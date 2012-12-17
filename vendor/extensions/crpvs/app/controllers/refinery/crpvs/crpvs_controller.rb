module Refinery
  module Crpvs
    class CrpvsController < ::ApplicationController

      before_filter :find_all_crpvs
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @crpv in the line below:
        present(@page)
      end

      def show
        @crpv = Crpv.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @crpv in the line below:
        present(@page)
      end

    protected

      def find_all_crpvs
        @crpvs = Crpv.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/crpvs").first
      end

    end
  end
end
