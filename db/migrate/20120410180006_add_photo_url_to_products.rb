class AddPhotoUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :photo_url, :string
  end
end
