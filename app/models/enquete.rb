#encoding: utf-8
class Enquete < ActiveRecord::Base
  self.table_name = 'refinery_enquetes'
  include HydraAttribute::ActiveRecord

  attr_accessible :code_bnpv, :date_recueil, :doublon, :j_evenement, :m_evenement, :a_evenement, :comm_evenement, :gravite, :evolution, :commentaire, :position, :patient_attributes, :hydra_set_id

  validates :code_bnpv, presence: true, uniqueness: true

  has_one :patient, foreign_key: :refinery_enquete_id
  belongs_to :evenement

  accepts_nested_attributes_for :patient, reject_if: :all_blank

  GRAVITE = [
    "décès",
    "mise en jeu du pronostic vital",
    "hospitalisation"
  ]

  EVOLUTION = [
    "guérison sans séquelle",
    "guérison avec séquelles",
    "décès du à l'effet",
    "NSP"
  ]
end
