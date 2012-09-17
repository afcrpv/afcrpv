module Refinery
  module Emplois
    class EmploisController < ::ApplicationController

      before_filter :find_all_emplois
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @emploi in the line below:
        present(@page)
      end

      def show
        @emploi = Emploi.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @emploi in the line below:
        present(@page)
      end

    protected

      def find_all_emplois
        @emplois = Emploi.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/emplois").first
      end

    end
  end
end
