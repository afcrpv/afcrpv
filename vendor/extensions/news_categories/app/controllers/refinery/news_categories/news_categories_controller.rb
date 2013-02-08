module Refinery
  module NewsCategories
    class NewsCategoriesController < ::ApplicationController

      before_filter :find_all_news_categories
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @news_category in the line below:
        present(@page)
      end

      def show
        @news_category = NewsCategory.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @news_category in the line below:
        present(@page)
      end

    protected

      def find_all_news_categories
        @news_categories = NewsCategory.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/news_categories").first
      end

    end
  end
end
