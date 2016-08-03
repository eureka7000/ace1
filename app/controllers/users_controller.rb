class UsersController < ApplicationController
    
    before_action :authenticate_admin_user!, only: [:new, :edit, :index]
    
    layout '/layouts/admin_main'

    def welcome

        respond_to do |format|
            format.html
        end

    end
    
    def new
        @user = User.new
        @schools = School.all
        @admins = Admin.all
        @teachers = Teacher.select('users.id, users.user_name').joins(:user).where('teachers.school_id = ?', @user.school_id)
        @mentos = UserType.select('users.id, users.user_name').joins(:user).where('user_type = ?', 'mento')
        render :layout => 'layouts/admin_main'
    end
    
    def edit
        @user = User.find(params[:id])
        @schools = School.all
        @admins = Admin.all
        @teachers = Teacher.select('users.id, users.user_name').joins(:user).where('teachers.school_id = ?', @user.school_id)
        @mentos = UserType.select('users.id, users.user_name').joins(:user).where('user_type = ?', 'mento')
        render :layout => 'layouts/admin_main'
    end      
    
    def get_mento
        
        @teachers = Teacher.select('users.id, users.user_name').joins(:user).where('teachers.school_id = ?', params[:id])
        render json: @teachers
        
    end    
    
    def create
        
        password = "11111111"
        
        @user = User.new(:email => params[:user][:email], :password => password, :password_confirmation => password)
        @user.phone = params[:user][:phone]
        @user.user_name = params[:user][:user_name]
        @user.location = params[:user][:location]
        @user.grade =  params[:user][:grade]
        @user.school_id = params[:user][:school_id]
        @user.join_channel_sales_id = params[:user][:join_channel_sales_id]  
        @user.save
        
        user_type = UserType.new
        user_type.user_id = @user.id
        user_type.user_type = params[:user_type][:user_type]
        user_type.save
        
        user_relation = UserRelation.new
        user_relation.user_id = @user.id
        user_relation.related_user_id = params[:user_relations][:related_id]
        user_relation.relation_type = 'mento'
        user_relation.save
        
        @schools = School.all
        @admins = Admin.all
        @teachers = Teacher.select('users.id, users.user_name').joins(:user).where('teachers.school_id = ?', @user.school_id)
        
        respond_to do |format|
            format.html { redirect_to "/users" }
        end
        
    end    
    
    def update_admin
        
        ActiveRecord::Base.transaction do
       
            @user = User.find(params[:user_id])
            @user.email = params[:user][:email]
            @user.phone = params[:user][:phone]
            @user.user_name = params[:user][:user_name]
            @user.location = params[:user][:location]
            @user.grade =  params[:user][:grade]
            @user.school_id = params[:user][:school_id]
            @user.join_channel_sales_id = params[:user][:join_channel_sales_id]  
            @user.save 
        
            @user_type = nil
            if @user.user_types.empty?
                @user_type = UserType.new
            else
                @user_type = @user.user_types[0]    
            end    
            @user_type.user_id = @user.id
            @user_type.user_type = params[:user_type][:user_type]
            @user_type.save
            
            unless params[:user_relations].blank?
                
                if @user.user_relations.empty?
                    @user_relation = UserRelation.new
                else
                    @user_relation = @user.user_relations[0]
                end    
        
                @user_relation.user_id = @user.id
                @user_relation.related_user_id = params[:user_relations][:related_id]
                @user_relation.relation_type = 'mento'
                @user_relation.confirm_status = 'confirmed'        
                @user_relation.save
                
            end    
        
            @schools = School.all
            @admins = Admin.all
            @mentos = UserType.select('users.id, users.user_name').joins(:user).where('user_type = ?', 'mento')            
            
            unless @user.school_id.nil?
                @teachers = Teacher.select('users.id, users.user_name').joins(:user).where('teachers.school_id = ?', @user.school_id)
            end    
        
            respond_to do |format|
                format.html { render :new }
            end
            
        end            
        
    end    
    
    
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
        @user.grade = params[:user][:grade]

        respond_to do |format|
            if @user.save
                
                if params[:target_from] == "admin"
                    format.html { redirect_to '/users/#{@user.id}' }
                else
                    format.html { redirect_to '/mypages/user_info?active_tab=2' }
                end

                format.json { head :no_content }
            else
                format.html { redirect_to '/mypages/user_info?active_tab=2' }
                format.json { render json: @account_item.errors, status: :unprocessable_entity }
            end
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
        
        UserMailer.cert_teacher(manager.first, current_user).deliver
        
        respond_to do |format|
            format.json { render :json => ret }
        end           
        
    end    
    
    def index
        
        email = params[:email]
        user_type = params[:user_type]
        school = params[:school]
        page = params[:page].blank? ? 1 : params[:page]
        
        if email.nil? && user_type.nil? && school.nil?
            @users = User.all.paginate( :page => page, :per_page => 30 ).order(id: :desc)
        else
            
            str = "";
                        
            unless email.blank?
                str += " email like '#{email}%' "
            end
            
            unless user_type.blank?
                if str == ""
                    str += " user_types.user_type = '#{user_type}' "
                else
                    str += " and user_types.user_type = '#{user_type}' "
                end        
            end
            
            unless school.blank?
                if str == ""
                    str += " schools.name like '#{school}%' "
                else
                    str += " and schools.name like '#{school}%' "
                end        
            end    
                
            @users = User.select('users.id, users.email, users.user_name, schools.name as school_name, users.phone, user_types.user_type, users.sign_in_count, users.expire_date ')
                .joins("left outer join user_types on user_types.user_id = users.id")
                .joins("left join schools on schools.id = users.school_id").where(str).paginate( :page => params[:page], :per_page => 30 ).order(id: :desc)
                
            logger.debug @users.inspect
            
        end                
        
        render :layout => 'layouts/admin_main'
        
    end
    
    
    def show
        authenticate_admin_user!
        @user = User.find(params[:id])

        respond_to do |format|
            format.html 
        end
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