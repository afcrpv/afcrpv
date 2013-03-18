class AddCrpvIdToRefineryEnquetes < ActiveRecord::Migration
  def change
    add_column :refinery_enquetes, :refinery_crpv_id, :integer
    add_index :refinery_enquetes, :refinery_crpv_id
  end
end
