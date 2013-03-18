class RemoveEvolutionFromRefineryEnquetes < ActiveRecord::Migration
  def up
    remove_column :refinery_enquetes, :j_evolution
    remove_column :refinery_enquetes, :m_evolution
    remove_column :refinery_enquetes, :a_evolution
  end

  def down
    add_column :refinery_enquetes, :a_evolution, :integer
    add_column :refinery_enquetes, :m_evolution, :integer
    add_column :refinery_enquetes, :j_evolution, :integer
  end
end
