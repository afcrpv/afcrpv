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
      has_many :projets, class_name: "::Refinery::Projets::Projet", foreign_key: :refinery_crpv_id
      has_many :members, class_name: "::Refinery::Memberships::Member"
      has_many :departements, :order => :name, :foreign_key => "refinery_crpv_id"
      has_many :arrondissements, :foreign_key => "refinery_crpv_id"

      def self.with_name(string)
        where{name =~ my{"%#{string}%"}}
      end

      def name_and_id
        {id: id, text: name}
      end

      def to_s
        name
      end

      def full_adresse
        ((adresse || "") + "<br />" + (cp || "") + " - " + (city || "")).html_safe
      end
    end
  end
end
