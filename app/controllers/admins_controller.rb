class AdminsController < ApplicationController

    before_action :authenticate_admin_user!, only: [:index, :show, :edit, :update, :destroy]
    before_action :set_admin, only: [:show, :edit, :update, :destroy]

    # GET /admins
    # GET /admins.json
    def index
        @admins = Admin.all
    end
    
    def login
        render :layout => false
    end
    
    def sign_in
        
        email = params[:admin][:email] unless params[:admin][:email].blank?
        password = params[:admin][:password] unless params[:admin][:password].blank?
        error = false
        
        if email.nil? || password.nil?
            error = true
        else
            logger.debug "********* email : " + email.inspect
            logger.debug "********* password : " + password.inspect
        
            @admin = Admin.where('email = ? and password = ?',email, password)
        end    
        
        respond_to do |format|
            if error
                format.html { redirect_to '/admins/login', notice: 'Email or password is empty.' }
            else
                
            end    
        end              
        
   
        
    end    

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :password, :salt)
    end
end
