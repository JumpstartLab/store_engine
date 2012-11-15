class CreateShoppers < ActiveRecord::Migration
  def change
    create_table :shoppers do |t|
      
      t.timestamps
    end
  end
end
