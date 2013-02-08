#encoding: utf-8
module Refinery
  module Documents
    class CategoriesController < ::ApplicationController

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

      def rebuild
        id        = params[:id].to_i
        parent_id = params[:parent_id].to_i
        prev_id   = params[:prev_id].to_i
        next_id   = params[:next_id].to_i

        render :text => "Do nothing" and return if parent_id.zero? && prev_id.zero? && next_id.zero?

        klass    = Category
        category = klass.find(id)

        if prev_id.zero? && next_id.zero?
          category.move_to_child_of klass.find(parent_id)
        elsif !prev_id.zero?
          category.move_to_right_of klass.find(prev_id)
        elsif !next_id.zero?
          category.move_to_left_of klass.find(next_id)
        end

        render :nothing => true
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
