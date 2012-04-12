class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|

      t.timestamps
    end
  end
end
