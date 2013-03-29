class Traitement < ActiveRecord::Base
  attr_accessible :a_debut, :a_fin, :j_debut, :j_fin, :m_debut, :m_fin, :medicament_id, :indication_id, :indication_autre_quoi, :duree, :duree_unite
  belongs_to :dossier
  belongs_to :indication
  belongs_to :medicament

  %w(debut fin).each do |name|
    define_method :"#{name}" do
      date_concat = []
      %w(a m j).each do |date_item|
        date_concat << self.send(:"#{date_item}_#{name}")
      end
      Date.parse(date_concat.join("-")) rescue nil
    end
  end
end
