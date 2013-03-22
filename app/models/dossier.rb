#encoding: utf-8
class Dossier < ActiveRecord::Base
  attr_accessible :code_bnpv, :date_recueil, :doublon, :j_evenement, :m_evenement, :a_evenement, :comm_evenement, :gravite, :evolution, :commentaire, :patient_attributes, :enquete_id, :evenement_id, :refinery_crpv_id, :traitements_attributes, :contraception_age, :contraception_ant, :concomitants, :contraception_apres, :contraception_quoi

  (1..3).each do |i|
    %w(contraception concomitant).each do |name|
      attr_accessible :"name_#{i}", :"name_#{i}_du", :"name_#{i}_au"
    end
  end

  validates :code_bnpv, presence: true, uniqueness: true

  has_one :patient
  belongs_to :evenement
  belongs_to :enquete
  belongs_to :crpv, class_name: "::Refinery::Crpvs::Crpv", foreign_key: :refinery_crpv_id
  has_many :traitements, dependent: :destroy
  has_many :medicaments, through: :traitements

  accepts_nested_attributes_for :patient, reject_if: :all_blank
  accepts_nested_attributes_for :traitements, reject_if: :all_blank, allow_destroy: true

  ONI = [
    "Oui",
    "Non",
    "NSP"
  ]

  CONTRACEPTION_APRES = [
    ["reprise d’une contraception", "reprise"],
    ["contre-indication d'une contraception", "ci"],
    ["NSP", "nsp"]
  ]

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
