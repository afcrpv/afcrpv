#encoding: utf-8
class Dossier < ActiveRecord::Base
  attr_accessible :code_bnpv, :date_recueil, :doublon, :j_evenement, :m_evenement, :a_evenement, :comm_evenement, :gravite, :evolution, :commentaire, :concomitants, :obesite, :tabac, :tabac_pa, :hta, :autoimmune, :autoimmune_quoi, :cancer, :cancer_quoi, :post_partum, :diabete, :hyperglycemie
  attr_accessible :patient_attributes, :traitements_attributes
  attr_accessible :enquete_id, :evenement_id, :refinery_crpv_id
  %w(age ant apres quoi).each do |suffix|
    attr_accessible :"contraception_#{suffix}"
  end
  (1..3).each do |i|
    %w(contraception concomitant).each do |name|
      attr_accessible :"name_#{i}", :"name_#{i}_du", :"name_#{i}_au"
    end
  end
  %w(thrombose cv).each do |prefix|
    %w(perso fam).each do |suffix|
      attr_accessible :"#{prefix}_#{suffix}", :"#{prefix}_#{suffix}_quoi"
    end
  end
  %w(perso fam).each do |suffix|
    attr_accessible :"hhc_#{suffix}"
  end
  %w(chirurgie immobilisation voyage autre autre_quoi).each do |suffix|
    attr_accessible :"circonstance_#{suffix}"
  end
  %w(perso fam).each do |prefix|
    %w(bilan anomalie anomalie_quoi).each do |suffix|
      attr_accessible :"anomalie_hemostase_#{prefix}_#{suffix}"
    end
    attr_accessible :"migraine_#{prefix}"
  end
  %w(dyslipidemie illicites autres_cv).each do |prefix|
    attr_accessible :"#{prefix}", :"#{prefix}_quoi"
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
