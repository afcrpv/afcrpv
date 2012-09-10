module Refinery
  module Categories
    class Category < Refinery::Core::BaseModel
      self.table_name = 'refinery_categories'

      attr_accessible :title, :position

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true

      has_many :events,
        foreign_key: :category_id,
        class_name: '::Refinery::Events::Event',
        order: "start_date DESC",
        inverse_of: :category
    end
  end
end
