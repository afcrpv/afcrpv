class CreateMedicaments < ActiveRecord::Migration
  def change
    create_table :medicaments do |t|
      t.string :name
      t.string :type
      t.string :classe
      t.string :forme

      t.timestamps
    end
  end
end
