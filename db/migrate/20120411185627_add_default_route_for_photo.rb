class AddDefaultRouteForPhoto < ActiveRecord::Migration
  def change
    change_column_default :products, :photo, '/link_to_your_photo.gif'
  end
end
