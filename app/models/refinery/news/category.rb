module Refinery
  module News
    class Category < Refinery::Core::BaseModel
      self.table_name = "news_categories"
      attr_accessible :title

      validates :title, :presence => true, :uniqueness => true

      def capitalized_title
        title.upcase
      end
    end
  end
end
