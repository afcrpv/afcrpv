module Refinery
  module Documents
    class Document < Refinery::Core::BaseModel
      self.table_name = 'refinery_documents'

      attr_accessible :titre, :publication, :document_category_id, :fichier, :fichier_id, :position

      acts_as_indexed :fields => [:titre]

      validates :titre, :presence => true, :uniqueness => true

      belongs_to :fichier, :class_name => '::Refinery::Resource'
    end
  end
end