class AdminsController < ApplicationController
  before_filter :ensure_admin

  def login
  end

  def dashboard
  end
end
