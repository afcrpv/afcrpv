require 'friendly_id'
module Refinery
  module Crpvs
    class Crpv < Refinery::Core::BaseModel
      extend FriendlyId
      friendly_id :name, use: [:slugged]
      self.table_name = 'refinery_crpvs'

      attr_accessible :name, :adresse, :city, :cp, :responsable, :tel, :fax, :email, :website, :bulletin, :position, :slug

      acts_as_indexed :fields => [:name, :adresse, :city, :cp, :responsable, :tel, :fax, :email, :website, :bulletin]

      validates :name, :presence => true, :uniqueness => true
      has_many :projets, class_name: "::Refinery::Projets::Projet"
      has_many :members, class_name: "::Refinery::Memberships::Member"

      def to_s
        name
      end
    end
  end
end
