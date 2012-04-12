class AddTagToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :tag, :string, :default => "address"
  end
end
