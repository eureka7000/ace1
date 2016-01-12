class SessionsController < Devise::SessionsController

  def new
      logger.debug "********** new "
      super
  end

  def create
      logger.debug "********** create "
      super
  end

end