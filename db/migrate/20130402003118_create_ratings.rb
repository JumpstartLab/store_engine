class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :product
      t.references :user
      t.string :title
      t.text :body
      t.integer :stars, default: 0

      t.timestamps
    end
  end
end
