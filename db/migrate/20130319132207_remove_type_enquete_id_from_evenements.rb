class RemoveTypeEnqueteIdFromEvenements < ActiveRecord::Migration
  def up
    remove_column :evenements, :type_enquete_id
  end

  def down
    add_column :evenements, :type_enquete_id, :integer
  end
end
