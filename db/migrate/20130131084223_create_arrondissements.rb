class CreateArrondissements < ActiveRecord::Migration
  def change
    create_table :arrondissements do |t|
      t.string :name
      t.integer :number
      t.integer :refinery_crpv_id

      t.timestamps
    end
  end
end
