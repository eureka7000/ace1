class SessionsController < Devise::SessionsController

  def new
      if request.referer.nil?
          session[:previous_url] = '/'
      else  
          session[:previous_url] = URI(request.referer).path 
      end      
      super
  end

  def create
      super
  end

end