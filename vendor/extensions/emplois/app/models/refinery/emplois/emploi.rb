module Refinery
  module Emplois
    class Emploi < Refinery::Core::BaseModel
      self.table_name = 'refinery_emplois'

      attr_accessible :organisation, :name, :email, :telephone, :address, :title, :description, :expires_on, :attachment, :position

      acts_as_indexed :fields => [:organisation, :name, :email, :telephone, :address, :title, :description]

      [:organisation, :name, :email, :telephone, :address, :title, :description, :expires_on].each do |field|
        validates field, :presence => true
      end

      belongs_to :attachment, :class_name => '::Refinery::Resource'

    end
  end
end
