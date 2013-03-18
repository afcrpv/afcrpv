#encoding: utf-8
module Refinery
  module Enquetes
    class EnquetesController < ::ApplicationController

      before_filter :find_all_enquetes, only: [:index]
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @enquete in the line below:
        present(@page)
      end

      def show
        @enquete = Enquete.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @enquete in the line below:
        present(@page)
      end

      def new
        @enquete = Enquete.new
        @enquete.build_patient
      end

      def edit
        @enquete = Enquete.find(params[:id])
      end

      def create
        @enquete = Enquete.new(params[:enquete])
        if @enquete.save
          redirect_to refinery.enquetes_enquetes_path, succes: "L'enquête a été créée avec succès."
        else
          render :new
        end
      end

    protected

      def find_all_enquetes
        @enquetes = Enquete.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/enquetes").first
      end

    end
  end
end
