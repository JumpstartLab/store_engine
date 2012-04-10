class CreateProducts < ActiveRecord::Migration
  def change
    create_table    :products do |t|
      t.string      :title
      t.text        :description
      t.boolean     :activity, :default => true
      t.decimal     :price, :precision => 12, :scale => 2
      t.string      :image_link
      t.timestamps
    end
  end
end
