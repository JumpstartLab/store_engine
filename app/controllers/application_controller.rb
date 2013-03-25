class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  def ensure_admin
    # do something
  end

  def ensure_user
    #
  end
end
