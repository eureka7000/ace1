class SessionsController < Devise::SessionsController

  def new
      session[:previous_url] = URI(request.referer).path
      super
  end

  def create
      super
  end

end