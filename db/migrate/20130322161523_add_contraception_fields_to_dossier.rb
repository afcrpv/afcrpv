class AddContraceptionFieldsToDossier < ActiveRecord::Migration
  def change
    add_column :dossiers, :contraception_ant, :string
    add_column :dossiers, :contraception_age, :integer
    (1..3).each do |i|
      add_column :dossiers, :"contraception_#{i}", :string
      add_column :dossiers, :"contraception_#{i}_du", :date
      add_column :dossiers, :"contraception_#{i}_au", :date
    end
  end
end
