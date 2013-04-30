#encoding: utf-8
class Dossier < ActiveRecord::Base
  columns_for_xlsx = [:code_bnpv, :date_recueil, :doublon, :age, :poids, :taille, :imc, :date_evenement, :evenement, :comm_evenement, :gravite, :evolution]

  (1..3).each do |i|
    columns_for_xlsx << [:"medicament_#{i}", :"medicament_#{i}_indication", :"medicament_#{i}_duree_ttt"]
  end
  columns_for_xlsx << [:contraception_ant, :contraception_age]
  (1..3).each do |i|
    columns_for_xlsx << [:"contraception_#{i}", :"contraception_#{i}_duree_ttt"]
  end
  columns_for_xlsx << :concomitants_pres
  (1..3).each do |i|
    columns_for_xlsx << [:"concomitant_#{i}", :"concomitant_#{i}_duree_ttt"]
  end
  columns_for_xlsx << [:contraception_ci, :contraception_apres, :contraception_quoi, :obesite, :tabac, :tabac_pa]
  %w(thrombose cv).each do |prefix|
    %w(perso fam).each do |suffix|
      columns_for_xlsx << [:"#{prefix}_#{suffix}", :"#{prefix}_#{suffix}_quoi"]
    end
  end
  columns_for_xlsx << :hta
  %w(autoimmune cancer).each do |name|
    columns_for_xlsx << [:"#{name}", :"#{name}_quoi"]
  end
  columns_for_xlsx << [:hhc_perso, :hhc_fam]
  %w(chirurgie immobilisation voyage autre_quoi).each do |name|
    columns_for_xlsx << :"circonstance_#{name}"
  end
  columns_for_xlsx << :post_partum
  %w(perso fam).each do |prefix|
    %w(bilan anomalie anomalie_nombre anomalie_quoi).each do |suffix|
      columns_for_xlsx << :"anomalie_hemostase_#{prefix}_#{suffix}"
    end
  end
  columns_for_xlsx << [:migraine_perso, :migraine_fam, :diabete, :hyperglycemie]
  %w(dyslipidemie illicites autres_cv).each do |prefix|
    columns_for_xlsx << [:"#{prefix}", :"#{prefix}_quoi"]
  end
  columns_for_xlsx << :commentaire

  acts_as_xlsx columns: columns_for_xlsx.flatten, i18n: 'activerecord.attributes'

  attr_accessible :code_bnpv, :date_recueil, :doublon, :date_evenement, :comm_evenement, :gravite, :evolution, :commentaire, :concomitants_pres, :obesite, :tabac, :tabac_pa, :hta, :autoimmune, :autoimmune_quoi, :cancer, :cancer_quoi, :post_partum, :diabete, :hyperglycemie
  attr_accessible :patient_attributes, :incrimines_attributes, :contraceptions_attributes, :concomitants_attributes
  attr_accessible :enquete_id, :evenement_id, :refinery_crpv_id
  %w(age ant ci apres quoi).each do |suffix|
    attr_accessible :"contraception_#{suffix}"
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
    %w(bilan anomalie anomalie_quoi anomalie_nombre).each do |suffix|
      attr_accessible :"anomalie_hemostase_#{prefix}_#{suffix}"
    end
    attr_accessible :"migraine_#{prefix}"
  end
  %w(dyslipidemie illicites autres_cv).each do |prefix|
    attr_accessible :"#{prefix}", :"#{prefix}_quoi"
  end

  validates :code_bnpv, presence: true, uniqueness: true
  validates :evenement_id, presence: true
  validates :date_recueil, presence: true

  validate :must_have_traitements

  has_one :patient
  delegate :age, :poids, :taille, :imc, to: :patient

  belongs_to :evenement
  belongs_to :enquete
  belongs_to :crpv, class_name: "::Refinery::Crpvs::Crpv", foreign_key: :refinery_crpv_id

  has_many :incrimines, dependent: :destroy
  has_many :medicaments, through: :incrimines

  has_many :contraceptions, dependent: :destroy
  has_many :concomitants, dependent: :destroy

  accepts_nested_attributes_for :patient, reject_if: :all_blank
  accepts_nested_attributes_for :incrimines, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contraceptions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :concomitants, reject_if: :all_blank, allow_destroy: true

  TABAC = [
    ["oui", 0],
    ["sevré", 1],
    ["non", 2],
    ["NSP", 3]
  ]

  ONI = [
    "Oui",
    "Non",
    "NSP"
  ]

  HEMOSTASE = [
    ["bilan avant évènement", "avant"],
    ["bilan après évènement", "après"],
    ["bilan non fait", "non"],
    ["bilan prévu à distance", "distance"],
    ["NSP", "nsp"]
  ]

  GRAVITE = [
    "décès",
    "mise en jeu du pronostic vital",
    "hospitalisation"
  ]

  EVOLUTION = [
    "guérison sans séquelle",
    "guérison en cours",
    "guérison avec séquelles",
    "décès du à l'effet",
    "NSP"
  ]

  DUREE_COMP = [
    "< à",
    "> à",
    "=",
    "NSP"
  ]

  def self.code_bnpv_or_evenement_or_medicament_contains(string)
    joins{[evenement, traitements.medicament]}.
      where{
        (code_bnpv.like "%#{string}%") |
        (evenement.name.like "%#{string}%") |
        (traitements.medicament.name.like "%#{string}%")
    }
  end

  (1..3).each do |i|
    define_method :"medicament_#{i}" do
      incrimines[i-1].medicament rescue nil
    end
    define_method :"medicament_#{i}_duree_ttt" do
      incrimines[i-1].duree_ttt rescue nil
    end
    define_method :"medicament_#{i}_indication" do
      incrimines[i-1].full_indication rescue nil
    end
    define_method :"contraception_#{i}" do
      contraceptions[i-1].medicament rescue nil
    end
    define_method :"contraception_#{i}_duree_ttt" do
      contraceptions[i-1].duree_ttt rescue nil
    end
    define_method :"concomitant_#{i}" do
      concomitants[i-1].libelle rescue nil
    end
    define_method :"concomitant_#{i}_duree_ttt" do
      concomitants[i-1].duree_ttt rescue nil
    end
  end

  def medicaments_list
    if medicaments.any?
      medicaments.map(&:name).join(", ")
    end
  end

  def must_have_traitements
    if incrimines.empty? or incrimines.all? {|traitement| traitement.marked_for_destruction? }
      errors.add(:traitements, "Vous devez saisir au moins 1 médicament")
    end
  end
end
