class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|

      t.timestamps
    end
  end
end
