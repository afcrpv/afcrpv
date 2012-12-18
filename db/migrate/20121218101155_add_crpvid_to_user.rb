class AddCrpvidToUser < ActiveRecord::Migration
  def change
    add_column Refinery::User.table_name, :refinery_crpv_id, :integer
  end
end
