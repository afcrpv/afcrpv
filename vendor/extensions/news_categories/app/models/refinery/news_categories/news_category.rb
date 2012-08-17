module Refinery
  module NewsCategories
    class NewsCategory < Refinery::Core::BaseModel
      self.table_name = 'refinery_news_categories'

      attr_accessible :name, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
