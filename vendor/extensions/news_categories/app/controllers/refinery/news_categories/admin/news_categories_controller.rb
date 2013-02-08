module Refinery
  module NewsCategories
    module Admin
      class NewsCategoriesController < ::Refinery::AdminController

        crudify :'refinery/news_categories/news_category', :xhr_paging => true

      end
    end
  end
end
