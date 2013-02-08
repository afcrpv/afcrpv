#encoding: utf-8
module Refinery
  module Documents
    class DocumentsController < ::ApplicationController

      before_filter :find_all_categories, only: [:new, :edit, :create, :update]
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @document in the line below:
        @documents = Refinery::Documents::Document.all
        present(@page)
      end

      def show
        @document = Document.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @document in the line below:
        present(@page)
      end

      def new
        if current_refinery_user.has_role?('documents') or current_refinery_user.is_admin?
          @document = ::Refinery::Documents::Document.new
        else
          redirect_to refinery.documents_documents_path, notice: "Vous n'êtes pas autorisé à voir cette page !"
        end
      end

      def create
        resource = Resource.create(file: params[:document][:fichier])
        @document = ::Refinery::Documents::Document.new(params[:document].merge({fichier: resource}))
        if @document.save
          redirect_to refinery.documents_documents_path
        else
          render :new
        end
      end

    protected

      def find_all_categories
        @categories = ::Refinery::Documents::Category.all
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/documents").first
      end

    end
  end
end
