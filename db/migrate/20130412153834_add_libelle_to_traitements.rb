class AddLibelleToTraitements < ActiveRecord::Migration
  def change
    add_column :traitements, :libelle, :string
  end
end
