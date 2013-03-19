class RenameTypeEnqueteIdInEvenementChoices < ActiveRecord::Migration
  def change
    rename_column :evenement_choices, :type_enquete_id, :enquete_id
  end
end
