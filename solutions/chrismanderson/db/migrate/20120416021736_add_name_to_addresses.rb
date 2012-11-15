class AddNameToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :name, :string
  end
end
