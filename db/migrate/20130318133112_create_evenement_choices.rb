class CreateEvenementChoices < ActiveRecord::Migration
  def change
    create_table :evenement_choices do |t|
      t.belongs_to :type_enquete
      t.belongs_to :evenement

      t.timestamps
    end
    add_index :evenement_choices, :type_enquete_id
    add_index :evenement_choices, :evenement_id
  end
end
