class RemovePropertiesFromDossier < ActiveRecord::Migration
  def up
    remove_column :dossiers, :properties_hstore
  end

  def down
    add_column :dossiers, :properties_hstore, :string
  end
end
