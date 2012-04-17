class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price, scale: 2
      t.string :photo
      t.boolean :retired, default: false
      t.string :upc
      t.timestamps
    end
  end
end
