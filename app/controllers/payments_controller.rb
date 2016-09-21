class PaymentsController < ApplicationController
    
    before_action :set_payment, only: [:show]
    before_filter :authenticate_user!, only: [:create, :close]
    before_action :authenticate_admin_user!, only: [:index, :show]
    skip_before_filter :verify_authenticity_token, :only => :payment_return    
    
    def close
    end
    
    def paypal_confirm
        
        @payment = Payment.where('paypal_token = ?', params[:paypal_token]).first
        
        unless @payment.nil?
            
            express_purchase_options = {
                :ip => request.remote_ip,
                :token => params[:paypal_token],
                :payer_id => @payment.paypal_payer_id
            }
            
            @response = EXPRESS_GATEWAY.purchase(
                @payment.amount * 100, express_purchase_options
            )
            
            logger.debug "@message" + @response.message
            
            payment_log = PaymentLog.new
            payment_log.user_id = current_user.id
            payment_log.pg = 'paypal'
            payment_log.result_message = @response.message
            payment_log.result_detail = @response.inspect
            payment_log.save
            
            if @response.success?
            
                @payment.payment_status = 'paid'
                @payment.save                    
            
                @user = User.find(current_user.id)
                @user.expire_date = @user.get_expire_date(@payment.service_name[0].to_i)
                @user.save
                
            end    
            
        end
        
    end

    
    def paypal
        
        response = EXPRESS_GATEWAY.setup_purchase(
            params[:price].to_i/10,
            ip: request.remote_ip,
            return_url: "#{root_url}/payments/paypal_payment_return",
            cancel_return_url: "#{root_url}/mypages/payment",
            currency: 'USD',
            allow_guest_checkout: true,
            items: [{name: "#{params[:goodname]} #{'Month'.pluralize(params[:goodname].to_i)} License", description: "You can use all of EurekaMath contents during #{params[:goodname]} #{'Month'.pluralize(params[:goodname].to_i)}", quantity: "1", amount: params[:price].to_i/10}]
        )
        
        @payment = Payment.new()
        @payment.user_id = current_user.id
        @payment.amount = params[:price].to_i/1000
        @payment.service_name = params[:goodname] + 'Month'.pluralize(params[:goodname].to_i)
        @payment.payment_status = 'processing'
        @payment.pay_gateway = 'paypal'
        @payment.currency = 'USD'
        @payment.paypal_token = response.token
        @payment.save
        
        redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
        
    end 

    
    def paypal_payment_return
        @payment = Payment.where('paypal_token = ?',params[:token]).first
        unless @payment.nil?
            @payment.paypal_payer_id = params[:PayerID]
            @payment.save
        end
    end
    
    def payment_return
        
        ActiveRecord::Base.transaction do        

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
                res = HTTParty.post(@auth_url, :body => @auth_map)
            
                #############################################################
                #5.API 통신결과 처리(***가맹점 개발수정***)
                #############################################################
                @payment_result = res.parsed_response
                result_detail = make_string_for_db(@payment_result)
            
                #############################################################
                # 6. DB에 저장
                #############################################################            
                payment_log = PaymentLog.new
                payment_log.user_id = current_user.id
                payment_log.pg = 'inicis'
                payment_log.result_code = @payment_result['resultCode']
                payment_log.result_message = @payment_result['resultMsg']
                payment_log.result_detail = result_detail
                payment_log.moid = @payment_result['MOID']
                payment_log.save
            
                if @payment_result['resultCode'] == '0000'
                    payment = Payment.find_by_oid(@payment_result['MOID'])
                    payment.payment_status = 'paid'
                    payment.save                    
                    
                    user = User.find(current_user.id)
                    user.expire_date = user.get_expire_date(@payment_result['goodName'].to_i)
                    user.save
                end    
                
            end
            
        end
        
    end    

    def index
        page = params[:page].blank? ? 1 : params[:page]
        @active = 'payments'
        @payments = Payment.all.paginate( :page => page, :per_page => 30 ).order(id: :desc)
        render :layout => 'layouts/admin_main'
    end

    def show
        @payment_logs = PaymentLog.where('moid = ?', @payment.oid)
        render :layout => 'layouts/admin_main'
    end

    def create

        @payment = Payment.new()
        @payment.user_id = current_user.id
        @payment.amount = params[:payment][:amount]
        @payment.service_name = params[:payment][:service_name] + 'Month'.pluralize(params[:payment][:service_name].to_i)
        @payment.oid = params[:payment][:oid]
        @payment.payment_status = 'processing'
        @payment.pay_method = params[:payment][:pay_method]
        @payment.pay_gateway = 'inicis'
        @payment.currency = 'KRW'
      
        if @payment.save
            tmp = {
                oid: params[:payment][:oid],
                price: params[:price],
                timestamp: params[:timestamp]
            }
      
            signature = InicisPayment.make_hash(tmp.to_query)
      
            @ret = {
                signature: signature
            }
        end
      
        render json: @ret

    end

    private
        
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
        @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
        params.require(:payment).permit(:name, :amount, :user_id, :expire_date, :service_name, payment_status)
    end
    
    def make_string_for_db(details)
        
        ret = ""
    
        details.each_pair do |key, value|
           ret += key + ":" + value + ","
        end
        
        ret
        
    end        
    
end
