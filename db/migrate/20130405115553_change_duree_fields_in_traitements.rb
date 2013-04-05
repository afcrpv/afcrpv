class ChangeDureeFieldsInTraitements < ActiveRecord::Migration
  def up
    %w(debut fin).each do |suffix|
      remove_column :traitements, :"j_#{suffix}"
      remove_column :traitements, :"m_#{suffix}"
      remove_column :traitements, :"a_#{suffix}"
    end
    add_column :traitements, :duree_comp, :string
  end

  def down
    %w(debut fin).each do |suffix|
      add_column :traitements, :"j_#{suffix}", :integer
      add_column :traitements, :"m_#{suffix}", :integer
      add_column :traitements, :"a_#{suffix}", :integer
    end
    remove_column :traitements, :duree_comp
  end
end
