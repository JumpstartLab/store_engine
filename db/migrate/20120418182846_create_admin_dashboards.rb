class CreateAdminDashboards < ActiveRecord::Migration
  def change
    create_table :admin_dashboards do |t|

      t.timestamps
    end
  end
end
