#encoding: utf-8
module Refinery
  module Documents
    class CategoriesController < ::ApplicationController
      include TheSortableTreeController::Rebuild

      before_filter :find_all_categories
      before_filter :find_page

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(params[:category])
        if @category.save
          redirect_to refinery.manage_documents_categories_path,
            notice: "Catégorie de document créée avec succès."
        else
          render :new
        end
      end

      def manage
      end

    protected

      def find_all_categories
        @categories = Category.nested_set.select('id, name, parent_id').all
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/documents/categories").first
      end

    end
  end
end
