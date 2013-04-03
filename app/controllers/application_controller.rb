class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_cart, :get_flag
  before_filter :get_locale

  def require_admin
    if current_user == false
      not_authenticated
    elsif current_user.admin == true
      true
    else
      redirect_to login_path, :alert => "Only system administrators may access this page"
    end
  end

  def not_authenticated
    redirect_to login_path, :alert => "First login to access this page."
  end

  def find_or_create_cart
    session[:cart] ||= Hash.new(0)
  end

  def current_cart
    @cart ||= Cart.new(session[:cart])
  end

  private

  def get_locale
    I18n.locale = session[:i18n] || I18n.default_locale || :en
  end

  def get_flag
    case session[:i18n]
    when 'fr' then 'fr'
    when 'cs' then 'cs'
    else 'us'
    end
  end
end
