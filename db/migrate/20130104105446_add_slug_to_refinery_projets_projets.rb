class AddSlugToRefineryProjetsProjets < ActiveRecord::Migration
  def change
    add_column :refinery_projets_projets, :slug, :string
    add_index :refinery_projets_projets, :slug
  end
end
