class AddConcomitantsToDossier < ActiveRecord::Migration
  def change
    add_column :dossiers, :concomitants, :string
    (1..3).each do |i|
      add_column :dossiers, :"concomitant_#{i}", :string
      add_column :dossiers, :"concomitant_#{i}_du", :date
      add_column :dossiers, :"concomitant_#{i}_au", :date
    end
  end
end
