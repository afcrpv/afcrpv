require 'friendly_id'
require 'i18n'
module Refinery
  module Projets
    class Projet < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :titre, use: [:slugged]
      validates :titre, :presence => true
      validates :responsable, :presence => true
      validates :refinery_crpv_id, :presence => true
      validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

      acts_as_indexed :fields => [:titre, :but, :effet, :medicament, :contexte, :objectif, :objectif_sec, :retombees]

      default_scope :order => 'created_at DESC'

      alias_attribute :name, :titre

      attr_accessible :email, :titre, :refinery_crpv_id, :but, :responsable, :exploitant, :date_requete, :effet, :medicament, :contexte, :design, :objectif, :objectif_sec, :champs, :debut_inclusion, :fin_inclusion, :type_inclusion, :criteres_inclusion, :criteres_non_inclusion, :retombees, :slug

      belongs_to :refinery_crpv, class_name: "::Refinery::Crpvs::Crpv"

      TYPE_INCLUSION = ["date de notification", "date de survenue"]

      def self.latest(number = 7)
        limit(number)
      end

      def date
        updated_at ? updated_at.to_date : created_at.to_date
      end
    end
  end
end
