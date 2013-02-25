class AddStateToProjet < ActiveRecord::Migration
  def change
    add_column :refinery_projets_projets, :workflow_state, :string
    add_index :refinery_projets_projets, :workflow_state
  end
end
