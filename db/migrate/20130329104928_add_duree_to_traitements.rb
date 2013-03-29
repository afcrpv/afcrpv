class AddDureeToTraitements < ActiveRecord::Migration
  def change
    add_column :traitements, :duree, :integer
    add_column :traitements, :duree_unite, :string
  end
end
