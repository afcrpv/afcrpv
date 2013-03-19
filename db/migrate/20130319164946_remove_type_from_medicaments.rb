class RemoveTypeFromMedicaments < ActiveRecord::Migration
  def up
    remove_column :medicaments, :type
  end

  def down
    add_column :medicaments, :type, :string
  end
end
