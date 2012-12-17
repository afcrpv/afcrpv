module Refinery
  module Crpvs
    class Crpv < Refinery::Core::BaseModel
      self.table_name = 'refinery_crpvs'

      attr_accessible :name, :adresse, :city, :cp, :responsable, :tel, :fax, :email, :website, :bulletin, :position

      acts_as_indexed :fields => [:name, :adresse, :city, :cp, :responsable, :tel, :fax, :email, :website, :bulletin]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
