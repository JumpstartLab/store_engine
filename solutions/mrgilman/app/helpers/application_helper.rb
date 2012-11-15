module ApplicationHelper
  def categories
    @categories = Category.all
  end
end
