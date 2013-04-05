class RemoveJmaEvenementFromDossiers < ActiveRecord::Migration
  def up
    remove_column :dossiers, :j_evenement
    remove_column :dossiers, :m_evenement
    remove_column :dossiers, :a_evenement
  end

  def down
    add_column :dossiers, :j_evenement, :integer
    add_column :dossiers, :m_evenement, :integer
    add_column :dossiers, :a_evenement, :integer
  end
end
