class AddFieldsToRefineryProjets < ActiveRecord::Migration
  def change
    add_column :refinery_projets_projets, :titre, :string
    add_index :refinery_projets_projets, :titre
    add_column :refinery_projets_projets, :refinery_crpv_id, :integer
    add_index :refinery_projets_projets, :refinery_crpv_id
    add_column :refinery_projets_projets, :but, :string
    add_column :refinery_projets_projets, :responsable, :string
    add_column :refinery_projets_projets, :exploitant, :string
    add_column :refinery_projets_projets, :date_requete, :date
    add_column :refinery_projets_projets, :effet, :text
    add_column :refinery_projets_projets, :medicament, :text
    add_column :refinery_projets_projets, :contexte, :text
    add_column :refinery_projets_projets, :design, :string
    add_column :refinery_projets_projets, :objectif, :text
    add_column :refinery_projets_projets, :objectif_sec, :text
    add_column :refinery_projets_projets, :champs, :text
    add_column :refinery_projets_projets, :debut_inclusion, :date
    add_column :refinery_projets_projets, :fin_inclusion, :date
    add_column :refinery_projets_projets, :type_inclusion, :string
    add_column :refinery_projets_projets, :criteres_inclusion, :text
    add_column :refinery_projets_projets, :criteres_non_inclusion, :text
    add_column :refinery_projets_projets, :retombees, :text
  end
end
