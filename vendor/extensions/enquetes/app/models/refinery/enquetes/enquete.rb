#encoding: utf-8
module Refinery
  module Enquetes
    class Enquete < Refinery::Core::BaseModel
      self.table_name = 'refinery_enquetes'
      include HydraAttribute::ActiveRecord

      attr_accessible :code_bnpv, :date_recueil, :doublon, :j_evenement, :m_evenement, :a_evenement, :comm_evenement, :gravite, :evolution, :commentaire, :position, :patient_attributes

      acts_as_indexed fields: [:code_bnpv, :comm_evenement, :gravite, :evolution, :commentaire]

      validates :code_bnpv, presence: true, uniqueness: true

      has_one :patient, foreign_key: :refinery_enquete_id

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

      accepts_nested_attributes_for :patient, reject_if: :all_blank
    end
  end
end
