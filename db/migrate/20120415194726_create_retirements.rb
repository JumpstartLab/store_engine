class CreateRetirements < ActiveRecord::Migration
  def change
    create_table :retirements do |t|
      t.integer :product_id
      t.timestamps
    end
  end
end
