#encoding: utf-8
class Dossier < ActiveRecord::Base
  include HydraAttribute::ActiveRecord

  attr_accessible :code_bnpv, :date_recueil, :doublon, :j_evenement, :m_evenement, :a_evenement, :comm_evenement, :gravite, :evolution, :commentaire, :position, :patient_attributes, :hydra_set_id, :evenement_id, :refinery_crpv_id

  validates :code_bnpv, presence: true, uniqueness: true

  has_one :patient
  belongs_to :evenement
  belongs_to :type_enquete
  belongs_to :crpv, class_name: "::Refinery::Crpvs::Crpv", foreign_key: :refinery_crpv_id

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
