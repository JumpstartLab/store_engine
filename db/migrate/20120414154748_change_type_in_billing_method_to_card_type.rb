class ChangeTypeInBillingMethodToCardType < ActiveRecord::Migration
  def change
    rename_column :billing_methods, :type, :card_type
  end

end
