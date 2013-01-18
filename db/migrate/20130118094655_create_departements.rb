class CreateDepartements < ActiveRecord::Migration
  def change
    create_table :departements do |t|
      t.string :name
      t.string :cp

      t.timestamps
    end
    add_index :departements, :name
    add_index :departements, :cp
  end
end
