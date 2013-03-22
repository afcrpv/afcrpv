class RenameMetaTypeIdInDossier < ActiveRecord::Migration
  def change
    rename_column :dossiers, :meta_type_id, :enquete_id
  end
end
