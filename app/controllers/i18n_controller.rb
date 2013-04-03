class I18nController < ApplicationController
  def update
    session[:i18n] = params[:locale]
    redirect_to(:back)
  end
end
