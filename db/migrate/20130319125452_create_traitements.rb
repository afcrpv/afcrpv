class CreateTraitements < ActiveRecord::Migration
  def change
    create_table :traitements do |t|
      t.belongs_to :dossier
      t.belongs_to :medicament
      t.integer :j_debut
      t.integer :m_debut
      t.integer :a_debut
      t.integer :j_fin
      t.integer :m_fin
      t.integer :a_fin

      t.timestamps
    end
    add_index :traitements, :dossier_id
    add_index :traitements, :medicament_id
  end
end
