class ApplicationController < ActionController::Base
  include UsersHelper
  include OrdersHelper
  include BillingMethodsHelper
  include ShippingAddressesHelper

  protected



end
