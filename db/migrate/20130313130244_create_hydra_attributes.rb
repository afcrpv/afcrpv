class CreateHydraAttributes < ActiveRecord::Migration
  def up
    migrate_to_hydra_entity :refinery_enquetes
  end

  def down
    rollback_from_hydra_entity :refinery_enquetes
  end
end
