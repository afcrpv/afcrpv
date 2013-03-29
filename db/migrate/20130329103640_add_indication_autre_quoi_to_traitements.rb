class AddIndicationAutreQuoiToTraitements < ActiveRecord::Migration
  def change
    add_column :traitements, :indication_autre_quoi, :string
  end
end
