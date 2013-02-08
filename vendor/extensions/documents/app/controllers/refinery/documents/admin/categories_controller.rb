module Refinery
  module Documents
    module Admin
      class CategoriesController < ::Refinery::AdminController

        before_filter :find_all_other_categories, only: [:new, :create, :edit, :update]

        crudify :'refinery/documents/category',
                :title_attribute => 'name', :xhr_paging => true

        private

        def find_all_other_categories
          @all_but_self_and_children ||= params[:id].present? ? Refinery::Documents::Category.all.reject {|c| c === @category || @category.descendants.include?(c)} : Refinery::Documents::Category.all
        end
      end
    end
  end
end
