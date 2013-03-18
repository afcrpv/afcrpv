class AddEvenementToEnquete < ActiveRecord::Migration
  def change
    add_column :refinery_enquetes, :evenement_id, :integer
  end
end
