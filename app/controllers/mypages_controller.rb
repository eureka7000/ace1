class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token, :only => :payment_return
    
    def close
    end
    
    def payment_return

        # 인증이 성공일 경우만
        if params[:resultCode] == '0000'
            
            @mid = params[:mid]
            @sign_key = Rails.application.config.inicis[:sign_key] 
            @timestamp = DateTime.now.strftime('%Q')
            @charset = "UTF-8"
            @format = "JSON"
            @auth_token = params[:authToken].gsub("\r\n","")
            
            @auth_url = params[:authUrl] # 승인요청 API url(수신 받은 값으로 설정, 임의 세팅 금지)
            @net_cancel = params[:netCancel] # 망취소 API url(수신 받은f값으로 설정, 임의 세팅 금지)

            @m_key = InicisPayment.make_hash(Rails.application.config.inicis[:sign_key])

            ######################
            # 2.signature 생성
            ######################
            # @sign_param = {
            #     authToken: @auth_token.force_encoding("UTF-8"),
            #     timestamp: @timestamp
            # }
            
            @sign_param = "authToken=" + @auth_token + "&timestamp=#{@timestamp}"
            @signature = InicisPayment.make_hash(@sign_param)

            ######################
            # 3.API 요청 전문 생성
            ######################
            @auth_map = {
                mid: @mid,      # 필수
                authToken: URI.encode(@auth_token),
                signature: @signature, 
                timestamp: @timestamp,
                charset: @charset,  
                format: @format
            }
            
            ######################
            # 4.API 통신 시작
            ######################
            # res = HTTParty.post(@auth_url, :body => @auth_map)
            
            #############################################################
            #5.API 통신결과 처리(***가맹점 개발수정***)
            #############################################################
            # @payment_result = res.parsed_response
            # for_test
            @payment_result = {
                "applTime"=>"171457", 
                "FlgNotiSendChk"=>"", 
                "applNum"=>"12103246", 
                "CARD_ClEvent"=>"", 
                "EventCode"=>"", 
                "currency"=>"WON", 
                "CARD_Quota"=>"00", 
                "CARD_GWCode"=>"7", 
                "resultMsg"=>"정상처리되었습니다.", 
                "authSignature"=>"393c362c135af34ef26ec351023f1403fb1d0582371c523bd0aa07ba95c7da3b", 
                "CARD_Point"=>"", 
                "CARD_Interest"=>"0", 
                "CARD_CheckFlag"=>"0", 
                "CARD_PurchaseCode"=>"", 
                "CARD_PurchaseName"=>"삼성카드", 
                "custEmail"=>"eureka7000@naver.com", 
                "resultCode"=>"0000", 
                "TotPrice"=>"1000", 
                "applPrice"=>"1000", 
                "tid"=>"StdpayCARDINIpayTest20160728171456752012", 
                "MOID"=>"INIpayTest_1469693651304", 
                "buyerTel"=>"010-456-7890", 
                "goodName"=>"유레카매스 수학", 
                "payMethod"=>"Card", 
                "payDevice"=>"PC", 
                "CARD_Code"=>"12", 
                "buyerEmail"=>"eureka7000@naver.com", 
                "CARD_PrtcCode"=>"1", 
                "CARD_MemberNum"=>"", 
                "buyerName"=>"김용록", 
                "CARD_Expire"=>"", 
                "applDate"=>"20160728", 
                "CARD_UsePoint"=>"000000000000", 
                "parentEmail"=>"", 
                "CARD_PRTC_CODE"=>"1", 
                "CARD_BankCode"=>"00", 
                "mid"=>"INIpayTest", 
                "CARD_TerminalNum"=>"019058I000", 
                "goodsName"=>"유레카매스 수학", 
                "CARD_Num"=>"426578*********9"
            }
            
            result_detail = make_string_for_db(@payment_result)
            
            logger.debug "encoding .. " + @payment_result['resultMsg'].encoding.inspect
            
            #############################################################
            # 6. DB에 저장
            #############################################################            
            payment_log = PaymentLog.new
            payment_log.user_id = current_user.id
            payment_log.pg = 'inicis'
            payment_log.result_code = @payment_result['resultCode']
            payment_log.result_message = '정상적으로 처리되었습니다.'
            payment_log.result_detail = result_detail
            payment_log.save
            

            
        end
        
    end    
    
    def payment
        
        @click = 'payment'
        @mid = Rails.application.config.inicis[:mid]
        # @order_number = current_user.id.to_s + "#" + Time.now().strftime('%Y%m%d%H%M%S')
        @price = 1000
        @timestamp = DateTime.now.strftime('%Q')
        @order_number = @mid + "_" + @timestamp        
        @params = {
            oid: @order_number,
            price: @price,
            timestamp: @timestamp
        }

        @sign = InicisPayment.make_hash(@params.to_query)  
        @m_key = InicisPayment.make_hash(Rails.application.config.inicis[:sign_key])
        
        # 결제이력
        @payment_logs = PaymentLog.where('user_id = ?', current_user.id).order('created_at desc')
        
    end    
    
    def overall

        @click = 'overall'
        @active = 'mypages'
       
        respond_to do |format|
            format.html
        end 
        
    end    

    def evaluation

        @click = 'evaluation'

        @unit_concept_exercise_histories = UnitConceptExerciseHistory.where(user_id: current_user.id).order(:unit_concept_desc_id).order(created_at: :desc)

        if current_user.user_types[0].user_type == 'school teacher' || 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
    end


    def question_list

        @click = 'question_list'
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)

        if current_user.user_types[0].user_type == 'student'
            @type = 'student';
        elsif current_user.user_types[0].user_type == 'school teacher'
            @type = 'school teacher'
        elsif current_user.user_types[0].user_type == 'mento'
            @type = 'mento'
        end

        unless params[:student].blank?
            @questions = @questions.where('user_id = ?', params[:student]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(:created_at)
        end

        unless params[:code].blank?
            @questions = @questions.where('unit_concept_id = ?', params[:code]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
        end

        @students = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).select(:user_id).distinct.order(:user_id)
        @codes = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).select(:unit_concept_id).distinct.order(:user_id)


        if current_user.user_types[0].user_type == 'school teacher' || 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
    end

    
    def user_info

        @click = 'user_info';
        @active_tab = params[:active_tab] || '2'
        
        @schools = School.where('is_school = ?', (current_user.user_types[0].user_type == 'school teacher' ? '1' : '0') )


        if current_user.user_types[0].user_type == 'school teacher' || 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end

        respond_to do |format|
            format.html
        end         
    end    
    
    private 
    
    def make_string_for_db(details)
        
        ret = ""
        
        details.each_pair do |key, value|
           ret += key + ":" + value + ","
        end
        
        ret
        
    end    
    
end