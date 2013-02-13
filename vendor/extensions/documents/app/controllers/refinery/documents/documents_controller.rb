#encoding: utf-8
module Refinery
  module Documents
    class DocumentsController < ::ApplicationController

      before_filter :find_all_categories, only: [:new, :edit, :create, :update]
      before_filter :find_page
      before_filter :edit_document_or_redirect, only: [:new, :edit]
      helper_method :authorised_documents_user?

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
      end

      def edit
      end

      def create
        resource = Resource.create(file: params[:document][:fichier])
        @document = ::Refinery::Documents::Document.new(params[:document].merge({fichier: resource}))
        if @document.save
          redirect_to refinery.documents_documents_path, success: "Le document a été créé avec succès."
        else
          render :new
        end
      end

      def update
        @document = ::Refinery::Documents::Document.find(params[:id])

        if @document.update_attributes(params[:document])
          redirect_to refinery.documents_documents_path, success: "Le document a été modifié."
        else
          render :edit
        end
      end

    protected

      def find_all_categories
        @categories = ::Refinery::Documents::Category.all
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/documents").first
      end

      def authorised_documents_user?
        current_refinery_user && (current_refinery_user.has_role?('documents') or current_refinery_user.is_admin?)
      end

      def edit_document_or_redirect
        if authorised_documents_user?
          method = :new
          args = []
          if params[:id].present?
            method = :find
            args = params[:id]
          end
          @document = ::Refinery::Documents::Document.send(method, args)
        else
          redirect_to refinery.documents_documents_path, notice: "Vous n'êtes pas autorisé à voir cette page !"
        end
      end

    end
  end
end
