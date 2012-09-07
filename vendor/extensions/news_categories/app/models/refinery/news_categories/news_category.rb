module Refinery
  module NewsCategories
    class NewsCategory < Refinery::Core::BaseModel
      self.table_name = 'refinery_news_categories'

      attr_accessible :name, :position, :description

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true

      has_many :news,
        foreign_key: :refinery_news_category_id,
        class_name: "::Refinery::News::Item"
    end
  end
end
