class CreateDepartementsCrpvsJoinTable < ActiveRecord::Migration
  def change
    create_table :crpvs_departements, id: false do |t|
      t.references :crpv, null: false
      t.references :departement, null: false
    end

    add_index :crpvs_departements, [:crpv_id, :departement_id], unique: true
  end
end
