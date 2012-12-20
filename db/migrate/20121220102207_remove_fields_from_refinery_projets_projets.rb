class RemoveFieldsFromRefineryProjetsProjets < ActiveRecord::Migration
  def up
    remove_column :refinery_projets_projets, :name
    remove_column :refinery_projets_projets, :phone
    remove_column :refinery_projets_projets, :message
    remove_column :refinery_projets_projets, :spam
  end

  def down
    add_column :refinery_projets_projets, :spam, :boolean, {default: false}
    add_column :refinery_projets_projets, :message, :text
    add_column :refinery_projets_projets, :phone, :string
    add_column :refinery_projets_projets, :name, :string
  end
end
