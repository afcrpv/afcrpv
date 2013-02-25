module Refinery
  module Documents
    class Document < Refinery::Core::BaseModel
      self.table_name = 'refinery_documents'
      attr_accessible :titre, :publication, :document_category_id, :fichier, :fichier_id, :position, :mots_cle_list
      acts_as_ordered_taggable
      acts_as_ordered_taggable_on :mots_cles

      acts_as_indexed :fields => [:titre]

      validates :titre, :presence => true, :uniqueness => true

      belongs_to :fichier, :class_name => '::Refinery::Resource'
      belongs_to :document_category, :class_name => "::Refinery::Documents::Category"

      def self.recent
        order("publication DESC")
      end

      def self.titre_or_category_name_or_mot_cle_contains(string)
        joins{[document_category, taggings.tag]}.
          where{
            (titre.like "%#{string}%") |
            (document_category.name.like "%#{string}%") |
            (taggings.tag.name.like "%#{string}%")
          }
      end
    end
  end
end
