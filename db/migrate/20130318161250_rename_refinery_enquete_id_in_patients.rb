class RenameRefineryEnqueteIdInPatients < ActiveRecord::Migration
  def change
    rename_column :patients, :refinery_enquete_id, :dossier_id
  end
end
