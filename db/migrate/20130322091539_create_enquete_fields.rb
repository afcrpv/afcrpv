class CreateEnqueteFields < ActiveRecord::Migration
  def change
    create_table :enquete_fields do |t|
      t.string :name
      t.string :libelle
      t.string :field_type
      t.boolean :required
      t.belongs_to :enquete
      t.integer :position

      t.timestamps
    end
    add_index :enquete_fields, :enquete_id
  end
end
