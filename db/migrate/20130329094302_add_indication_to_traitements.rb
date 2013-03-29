class AddIndicationToTraitements < ActiveRecord::Migration
  def change
    add_column :traitements, :indication_id, :integer
    add_index :traitements, :indication_id
  end
end
