class RenameEnquetesTable < ActiveRecord::Migration
  def change
    rename_table :refinery_enquetes, :dossiers
  end
end
