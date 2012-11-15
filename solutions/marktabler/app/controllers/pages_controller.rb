class PagesController < ApplicationController

  def home
  end

  def code
    redirect_to "http://github.com/marktabler/store_engine"
  end

end
