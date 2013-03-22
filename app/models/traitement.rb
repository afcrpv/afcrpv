class Traitement < ActiveRecord::Base
  attr_accessible :a_debut, :a_fin, :j_debut, :j_fin, :m_debut, :m_fin, :medicament_id
  belongs_to :dossier
  belongs_to :medicament
end
