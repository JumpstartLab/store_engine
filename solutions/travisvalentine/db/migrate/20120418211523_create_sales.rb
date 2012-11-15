class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.datetime  :endtime
      t.decimal   :percentage, :scale => 2
      t.timestamps
    end
  end
end
