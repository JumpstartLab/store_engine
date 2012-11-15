class CreateProductRatings < ActiveRecord::Migration
  def change
    create_table :product_ratings do |t|
      t.string :name
      t.text :body
      t.integer :rating
      t.integer :user_id
      t.integer :product_id
      t.integer :active, :default => 1

      t.timestamps
    end
  end
end
