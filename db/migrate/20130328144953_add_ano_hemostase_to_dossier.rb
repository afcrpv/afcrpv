class AddAnoHemostaseToDossier < ActiveRecord::Migration
  def change
    %w(perso fam).each do |prefix|
      add_column :dossiers, :"anomalie_hemostase_#{prefix}_anomalie_nombre", :string
    end
  end
end
