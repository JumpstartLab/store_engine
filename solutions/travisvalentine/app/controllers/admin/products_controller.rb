class Admin::ProductsController < Admin::AdminController

  def index
    @active = Product.active
    @retired = Product.retired
  end

end