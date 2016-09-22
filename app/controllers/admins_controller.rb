class AdminsController < ApplicationController

    before_action :authenticate_admin_user!, only: [:index, :show, :edit, :update, :destroy, :main]
    before_action :set_admin, only: [:show, :edit, :update, :destroy]

    layout '/layouts/admin_main'

    # GET /admins
    # GET /admins.json
    def users
        @admins = Admin.all
    end
    
    def index
        redirect_to '/admins/main'
    end
    
    def login
        render :layout => false
    end
    
    def logout
        session[:admin] = nil
        redirect_to '/admins/login'
    end
    
    def sign_in
        
        email = params[:admin][:email] unless params[:admin][:email].blank?
        password = Digest::SHA1.hexdigest(params[:admin][:password]) unless params[:admin][:password].blank?
        error = false
                
        if email.nil? || password.nil?
            error = true
        else
            @admin = Admin.where('email = ? and password = ?',email, password)
            if @admin.empty?
                logger.error "----------" + @admin.inspect
                error = true
            else
                session[:admin] = @admin.first
                logger.debug "--------" + session[:admin].inspect
            end
        end    
        
        respond_to do |format|
            if error
                format.html { redirect_to '/admins/login', notice: 'Email or password is wrong.' }
            else
                format.html { redirect_to '/admins/main' }
            end    
        end              
        
    end    
    
    def main
        @payments = Payment.select('coalesce(sum(amount),0) as amount').where("payment_status = 'paid' and DATE(created_at) = DATE(now())").first
        @questions = Question.where("date(updated_at) = date(now())")
        @visit_users = User.where("date(current_sign_in_at) = date(now())")
        @new_users = User.where("date(created_at) = date(now())")
    end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

    # GET /admins/new
    def new
        @admin = Admin.new
        unless params[:school_id].blank?
            @school = School.find(params[:school_id])
            if @school.is_school == '1' 
                params[:admin_type] = 'school manager'
            else
                params[:admin_type] = 'institute manager'
            end
        end
    end

    # GET /admins/1/edit
    def edit
        unless @admin.school_id.nil?
            @school = @admin.school
        end    
    end

    # POST /admins
    # POST /admins.json
    def create
        
        @admin = Admin.new
        @admin.name = params[:admin][:name]
        @admin.email = params[:admin][:email]
        @admin.password = Digest::SHA1.hexdigest('eurekamath')
        @admin.admin_type = params[:admin][:admin_type]
        @admin.org_name = params[:admin][:org_name]
        @admin.school_id = params[:admin][:school_id]

        respond_to do |format|
            
            if @admin.save
                format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
                format.json { render :show, status: :created, location: @admin }
            else
                format.html { render :new }
                format.json { render json: @admin.errors, status: :unprocessable_entity }
            end
        end
        
    end


  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
    # POST /admins/change_password  
    def change_password
      
        admin = Admin.find(params[:admin_id])
        admin.password = Digest::SHA1.hexdigest(params[:password])
        admin.init_password_changed = 'Y'
        admin.save
        
        session[:admin] = admin
        
        ret = {}
        ret["msg"] = "ok"
        
        respond_to do |format|
            format.json { render :json => ret }
        end        
      
    end      

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :password, :admin_type, :org_name)
    end
end
