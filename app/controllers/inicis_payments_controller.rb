class InicisPaymentsController < ApplicationController
  before_action :set_inicis_payment, only: [:show, :edit, :update, :destroy]

  # GET /inicis_payments
  # GET /inicis_payments.json
  def index
    @inicis_payments = InicisPayment.all
  end

  # GET /inicis_payments/1
  # GET /inicis_payments/1.json
  def show
  end

    def new
        @inicis_payment = InicisPayment.new
        
        @timestamp = DateTime.now.strftime('%Q')
        @order_number = Rails.application.config.inicis[:mid] + "_" + @timestamp  # 가맹점 주문번호(가맹점에서 직접 설정)        
        @price = "1000"        # 상품가격(특수기호 제외, 가맹점에서 직접 설정)
        @card_no_interest_quota = ''  # 카드 무이자 여부 설정(가맹점에서 직접 설정) - 카드사코드-할부개월:할부개월 ex) 11-2:3:,34-5:12,14-6:12:24,12-12:36,06-9:12,01-3:4
        @card_quota_base = '2:3:4:5:6:11:12:24:36'  # 가맹점에서 사용할 할부 개월수 설정
        
        ###################################
        # 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
        # ###################################
        @m_key = InicisPayment.make_hash(Rails.application.config.inicis[:sign_key])
        
        @params = {
            oid: @order_number,
            price: @price,
            timestamp: @timestamp
        }

        @sign = InicisPayment.make_hash(@params.to_query)
        
        # /* 기타 */
        @site_domain = "#{root_url}inicis_payments"; # 가맹점 도메인 입력
        # 페이지 URL에서 고정된 부분을 적는다. 
        # Ex) returnURL이 http://localhost:8082/demo/INIpayStdSample/INIStdPayReturn.jsp 라면
        #                 http://localhost:8082/demo/INIpayStdSample 까지만 기입한다.
        
        
    end

  # GET /inicis_payments/1/edit
  def edit
  end

  # POST /inicis_payments
  # POST /inicis_payments.json
  def create
    @inicis_payment = InicisPayment.new(inicis_payment_params)

    respond_to do |format|
      if @inicis_payment.save
        format.html { redirect_to @inicis_payment, notice: 'Inicis payment was successfully created.' }
        format.json { render :show, status: :created, location: @inicis_payment }
      else
        format.html { render :new }
        format.json { render json: @inicis_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inicis_payments/1
  # PATCH/PUT /inicis_payments/1.json
  def update
    respond_to do |format|
      if @inicis_payment.update(inicis_payment_params)
        format.html { redirect_to @inicis_payment, notice: 'Inicis payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @inicis_payment }
      else
        format.html { render :edit }
        format.json { render json: @inicis_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inicis_payments/1
  # DELETE /inicis_payments/1.json
  def destroy
    @inicis_payment.destroy
    respond_to do |format|
      format.html { redirect_to inicis_payments_url, notice: 'Inicis payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inicis_payment
      @inicis_payment = InicisPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inicis_payment_params
      params.require(:inicis_payment).permit(:version, :mid, :oid, :good_name, :price, :tax, :tax_free, :currency, :buyer_name, :buyer_tel, :buyer_email, :parent_email, :timestamp, :signature, :return_url, :m_key, :go_pay_method, :offer_period)
    end
end
