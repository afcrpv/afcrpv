module Refinery
  module Documents
    class Category < Refinery::Core::BaseModel
      self.table_name = 'refinery_documents_categories'
      include TheSortableTree::Scopes
      acts_as_nested_set
      attr_accessible :name, :parent_id, :position

      validates :name, :presence => true, :uniqueness => true

      def to_s
        name
      end

      def name_and_id
        {id: id, text: name}
      end
    end
  end
end
