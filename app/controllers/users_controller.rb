class UsersController < ApplicationController

    def welcome

        respond_to do |format|
            format.html
        end

    end
    
    
    def cert_teacher
        
        ret = {}
        
        if params[:school_name].blank?
            ret = { :error => '학교명이 비어 있습니다.'}
        end
        
        if params[:manager_email].blank?
            ret = { :error => '관리자 전자우편이 비어있습니다.'}
        end    
        
        manager = Admin.where('org_name = ? and email = ?',params[:school_name], params[:manager_email])
        
        if manager.empty?
            ret = { :error => '해당 정보로 학교(학원)관리자를 찾을 수 없습니다.' }
        end    
        
        respond_to do |format|
            format.json { render :json => ret }
        end           
        
    end    
    
    # PUT /users/1
    # PUT /users/1.json
    def update
        
        unless params[:target_from] == "admin"
            authenticate_user!
        else
            authenticate_admin_user!
        end    
        
        @user = User.find(params[:id])
        @user.user_name = params[:user][:user_name]
        @user.location = params[:user][:location]
        @user.phone = params[:user][:phone]

        respond_to do |format|
            if @user.save
                
                if params[:target_from] == "admin"
                    format.html { redirect_to '/users/#{@user.id}' }
                else
                    format.html { redirect_to '/mypages/settings?active_tab=2' }                    
                end

                format.json { head :no_content }
            else
                format.html { redirect_to '/mypages/settings?active_tab=2' }
                format.json { render json: @account_item.errors, status: :unprocessable_entity }
            end
        end
        
    end
    
    def index
        authenticate_admin_user!
        @users = User.all
        render :layout => 'layouts/admin_main'
    end
    
    def show
        authenticate_admin_user!
        @user = User.find(params[:id])

        respond_to do |format|
            format.html 
        end
    end     
    
    def edit
        authenticate_admin_user!
        @user = User.find(params[:id])
        render :layout => 'layouts/admin_main'
    end    
    
    
    def destroy
        
        authenticate_admin_user!
        
        @user = User.find(params[:id])
        @user.destroy

        respond_to do |format|
            format.html { redirect_to users_url }
            format.json { head :no_content }
        end
        
    end       


end