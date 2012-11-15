class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :active, :default => 1
      t.integer :sale_id

      t.timestamps
    end
  end
end
