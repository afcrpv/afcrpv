module Refinery
  module NewsCategories
    class NewsCategory < Refinery::Core::BaseModel
      self.table_name = 'refinery_news_categories'

      attr_accessible :title, :position

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true

      def capitalized_title
        title.upcase
      end
    end
  end
end
