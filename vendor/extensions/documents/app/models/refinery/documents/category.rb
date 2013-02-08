module Refinery
  module Documents
    class Category < Refinery::Core::BaseModel
      include TheSortableTree::Scopes
      acts_as_nested_set
      attr_accessible :name, :parent_id, :position

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
