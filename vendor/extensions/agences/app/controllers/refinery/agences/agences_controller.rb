module Refinery
  module Agences
    class AgencesController < ::ApplicationController

      before_filter :find_all_agences
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @agence in the line below:
        present(@page)
      end

      def show
        @agence = Agence.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @agence in the line below:
        present(@page)
      end

    protected

      def find_all_agences
        @agences = Agence.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/agences").first
      end

    end
  end
end
