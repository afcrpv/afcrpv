class AddContraceptionApresToDossier < ActiveRecord::Migration
  def change
    add_column :dossiers, :contraception_apres, :string
    add_column :dossiers, :contraception_quoi, :string
  end
end
