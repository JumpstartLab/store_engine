class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title
      t.text    :description
      t.integer :price, :decimal, :scale => 2
      t.timestamps
    end
  end
end
