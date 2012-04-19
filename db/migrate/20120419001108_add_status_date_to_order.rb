class AddStatusDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status_date, :datetime
  end
end
