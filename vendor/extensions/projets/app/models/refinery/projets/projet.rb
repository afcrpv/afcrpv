module Refinery
  module Projets
    class Projet < Refinery::Core::BaseModel
      validates :titre, :presence => true
      validates :responsable, :presence => true
      validates :refinery_crpv_id, :presence => true
      validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

      acts_as_indexed :fields => [:titre, :but, :effet, :medicament, :contexte, :objectif, :objectif_sec, :retombees]

      default_scope :order => 'created_at DESC'

      alias_attribute :name, :titre

      attr_accessible :email, :titre, :refinery_crpv_id, :but, :responsable, :exploitant, :date_requete, :effet, :medicament, :contexte, :design, :objectif, :objectif_sec, :champs, :debut_inclusion, :fin_inclusion, :type_inclusion, :criteres_inclusion, :criteres_non_inclusion, :retombees

      belongs_to :refinery_crpv, class_name: "::Refinery::Crpvs::Crpv"

      def self.latest(number = 7)
        limit(number)
      end
    end
  end
end