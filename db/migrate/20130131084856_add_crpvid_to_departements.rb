class AddCrpvidToDepartements < ActiveRecord::Migration
  def change
    add_column :departements, :refinery_crpv_id, :integer
  end
end
