require 'friendly_id'
require 'i18n'
module Refinery
  module Projets
    class Projet < Refinery::Core::BaseModel
      include Workflow
      extend FriendlyId
      friendly_id :titre, use: [:slugged]
      validates :titre, :presence => true
      validates :responsable, :presence => true
      validates :refinery_crpv_id, :presence => true
      validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

      acts_as_indexed :fields => [:titre, :but, :effet, :medicament, :contexte, :objectif, :objectif_sec, :retombees]

      default_scope :order => 'created_at DESC'

      alias_attribute :name, :titre

      attr_accessible :email, :titre, :refinery_crpv_id, :but, :responsable, :exploitant, :date_requete, :effet, :medicament, :contexte, :design, :objectif, :objectif_sec, :champs, :debut_inclusion, :fin_inclusion, :type_inclusion, :criteres_inclusion, :criteres_non_inclusion, :retombees, :slug, :workflow_state

      belongs_to :crpv, class_name: "::Refinery::Crpvs::Crpv", foreign_key: :refinery_crpv_id

      TYPE_INCLUSION = ["date de notification", "date de survenue"]

      def responsable_with_email
        [responsable, email].compact.join(" - ")
      end

      def date
        updated_at ? updated_at.to_date : created_at.to_date
      end

      def self.latest(number = 7)
        limit(number)
      end

      def self.titre_contains(string)
        where{
          titre.like "%#{string}%"
        }
      end

      def self.en_cours
        where(workflow_state: "en_cours")
      end

      def self.termines
        where(workflow_state: "termine")
      end

      workflow do
        state :en_cours do
          event :terminer, transition_to: :termine
          event :annuler, transition_to: :annule
        end
        state :termine
        state :annule
      end
    end
  end
end
