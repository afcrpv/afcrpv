class AddDateEvenementToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :date_evenement, :date
  end
end
