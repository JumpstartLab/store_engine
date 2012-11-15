class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.string :photo
      t.integer :price_cents
      t.timestamps
    end
  end
end
