class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :title
      t.text :description
      t.integer :price
      t.string :photo
      t.boolean :retired, default: false
      t.timestamps
    end
  end
end
