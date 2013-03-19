class AddDescriptionToHydraSets < ActiveRecord::Migration
  def change
    add_column :hydra_sets, :description, :text
  end
end
