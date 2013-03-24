class AddFdRtoDossier < ActiveRecord::Migration
  def change
    add_column :dossiers, :obesite, :string
    add_column :dossiers, :tabac, :string
    add_column :dossiers, :tabac_pa, :string
    %w(thrombose cv).each do |prefix|
      %w(perso fam).each do |suffix|
        add_column :dossiers, :"#{prefix}_#{suffix}", :string
        add_column :dossiers, :"#{prefix}_#{suffix}_quoi", :string
      end
    end
    add_column :dossiers, :hta, :string
    add_column :dossiers, :autoimmune, :string
    add_column :dossiers, :autoimmune_quoi, :string
    add_column :dossiers, :cancer, :string
    add_column :dossiers, :cancer_quoi, :string
    %w(perso fam).each do |suffix|
      add_column :dossiers, :"hhc_#{suffix}", :string
    end
    %w(chirurgie immobilisation voyage autre).each do |suffix|
      add_column :dossiers, :"circonstance_#{suffix}", :boolean
    end
    add_column :dossiers, :circonstance_autre_quoi, :string
    add_column :dossiers, :post_partum, :string
    %w(perso fam).each do |prefix|
      %w(bilan anomalie anomalie_quoi).each do |suffix|
        add_column :dossiers, :"anomalie_hemostase_#{prefix}_#{suffix}", :string
      end
      add_column :dossiers, :"migraine_#{prefix}", :string
    end
    add_column :dossiers, :diabete, :string
    add_column :dossiers, :hyperglycemie, :string
    %w(dyslipidemie illicites autres_cv).each do |prefix|
      add_column :dossiers, :"#{prefix}", :string
      add_column :dossiers, :"#{prefix}_quoi", :string
    end
  end
end
