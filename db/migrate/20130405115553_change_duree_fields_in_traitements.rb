class ChangeDureeFieldsInTraitements < ActiveRecord::Migration
  def change
    %w(debut fin).each do |suffix|
      remove_column :traitements, :"j_#{suffix}"
      remove_column :traitements, :"m_#{suffix}"
      remove_column :traitements, :"a_#{suffix}"
    end
    add_column :traitements, :duree_comp, :string
  end
end
