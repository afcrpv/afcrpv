class AddContraceptionCiToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :contraception_ci, :string
  end
end
