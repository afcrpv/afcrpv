module Refinery
  module Enquetes
    class EnquetesController < ::ApplicationController

      before_filter :find_all_enquetes
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
