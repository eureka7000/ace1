class SessionsController < Devise::SessionsController

  def new
    @page_name = 'Login'
    super
  end

  def create
    super
  end

end