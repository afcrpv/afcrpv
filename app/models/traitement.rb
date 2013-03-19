class Traitement < ActiveRecord::Base
  belongs_to :dossier
  belongs_to :medicament
  attr_accessible :a_debut, :a_fin, :j_debut, :j_fin, :m_debut, :m_fin
end
