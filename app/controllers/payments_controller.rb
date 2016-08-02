class PaymentsController < ApplicationController
    
    before_action :set_payment, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!, only: [:create, :close]
    before_action :authenticate_admin_user!, only: [:index]
    skip_before_filter :verify_authenticity_token, :only => :payment_return    
    
    def close
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
                payment_log.save
            
                if @payment_result['resultCode'] == '0000'
                    payment = Payment.find_by_oid(@payment_result['MOID'])
                    payment.payment_status = 'paid'
                    payment.save                    
                    
                    user = User.find(current_user.id)
                    @expire_date = Time.new
                
                    if user.expire_date.nil?
                        @expire_date = @expire_date + @payment_result['goodName'].to_i.months  
                    else
                        if user.expire_date < @expire_date
                            @expire_date = @expire_date + @payment_result['goodName'].to_i.months
                        else
                            @expire_date = user.expire_date + @payment_result['goodName'].to_i.months
                        end                    
                    end
                
                    user.expire_date = @expire_date
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

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

    def create

        @payment = Payment.new()
        @payment.user_id = current_user.id
        @payment.amount = params[:payment][:amount]
        @payment.service_name = params[:payment][:service_name] + " months "
        @payment.oid = params[:payment][:oid]
        @payment.payment_status = 'processing'
        @payment.pay_method = params[:payment][:pay_method]
      
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

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
