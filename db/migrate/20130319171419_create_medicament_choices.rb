class CreateMedicamentChoices < ActiveRecord::Migration
  def change
    create_table :medicament_choices do |t|
      t.belongs_to :medicament
      t.belongs_to :enquete

      t.timestamps
    end
    add_index :medicament_choices, :medicament_id
    add_index :medicament_choices, :enquete_id
  end
end
