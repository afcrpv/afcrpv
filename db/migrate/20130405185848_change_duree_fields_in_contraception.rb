class ChangeDureeFieldsInContraception < ActiveRecord::Migration
  def up
    (1..3).each do |i|
      remove_column :dossiers, :"contraception_#{i}_du"
      remove_column :dossiers, :"contraception_#{i}_au"
      add_column    :dossiers, :"contraception_#{i}_duree_comp",  :string
      add_column    :dossiers, :"contraception_#{i}_duree",       :integer
      add_column    :dossiers, :"contraception_#{i}_duree_unite", :string
    end
  end

  def down
    (1..3).each do |i|
      add_column       :dossiers, :"contraception_#{i}_du", :date
      add_column       :dossiers, :"contraception_#{i}_au", :date
      remove_column    :dossiers, :"contraception_#{i}_duree_comp"
      remove_column    :dossiers, :"contraception_#{i}_duree"
      remove_column    :dossiers, :"contraception_#{i}_duree_unite"
    end
  end
end
