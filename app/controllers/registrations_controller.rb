class RegistrationsController < Devise::RegistrationsController
  def new
    @page_name = t(:sign_up)
    super
  end

  def create
    super

    user = User.find(current_user.id)
    user.user_auth = 'free'
    user.save
        
    user_type = UserType.new
    
    logger.debug user_type
    
    user_type.user_id = @user.id
    user_type.user_type = params[:user_type][:user_type]
    user_type.save

  end

  def update
    super
  end
  

  

  
  
end 