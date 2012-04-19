class ChangePercentageToIntegerOnSales < ActiveRecord::Migration
  def change
    remove_column :sales, :percentage
    add_column    :sales, :percentage, :integer
  end
end
