class AddTypeToBillingMethod < ActiveRecord::Migration
  def change
    add_column :billing_methods, :type, :string
  end
end
