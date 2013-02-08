module Refinery
  module Documents
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/documents/category',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
