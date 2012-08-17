module Refinery
  module NewsCategories
    module Admin
      class NewsCategoriesController < ::Refinery::AdminController

        crudify :'refinery/news_categories/news_category',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
