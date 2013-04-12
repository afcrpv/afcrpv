class ChangeConcomitantsInDossiers < ActiveRecord::Migration
  def up
    rename_column :dossiers, :concomitants, :concomitants_pres
  end

  def down
    rename_column :dossiers, :concomitants_pres, :concomitants
  end
end
