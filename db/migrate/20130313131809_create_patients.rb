class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :age
      t.integer :poids
      t.integer :taille
      t.integer :imc
      t.belongs_to :dossier

      t.timestamps
    end
    add_index :patients, :dossier_id
  end
end
