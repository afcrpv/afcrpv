class AddTypeToTraitements < ActiveRecord::Migration
  def change
    add_column :traitements, :type, :string
  end
end
