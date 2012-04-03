class CreateProducts < ActiveRecord::Migration
  def change
    create_table    :products do |t|
      t.string      :title
      t.text        :description
      t.boolean     :activity, :default => true
      t.integer     :price
      t.string      :image_link
      t.timestamps
    end
  end
end
