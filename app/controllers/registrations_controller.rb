class RegistrationsController < Devise::RegistrationsController
  def new
    @page_name = 'Sign Up'
    
    super
  end

  def create
    super
  end

  def update
    super
  end
end 