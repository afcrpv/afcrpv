class AddTypeEnqueteIdToEvenements < ActiveRecord::Migration
  def change
    add_column :evenements, :type_enquete_id, :integer
  end
end
