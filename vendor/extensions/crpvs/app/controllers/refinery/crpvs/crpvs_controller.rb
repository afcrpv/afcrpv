#encoding: utf-8
module Refinery
  module Crpvs
    class CrpvsController < ::ApplicationController

      before_filter :find_all_crpvs, only: [:index]
      before_filter :find_page

      def paris
        @paris_crpvs = [
          ["ps", "Pitié-Salpétrière"],
          ["gp", "Georges Pompidou"],
          ["sa", "Saint-Antoine"],
          ["csvp", "Cochin St Vincent de Paul"],
          ["fw", "Fernand Widal"]
        ]
      end

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @crpv in the line below:
        present(@page)
      end

      def search
        if params[:dep]
          @crpv = Crpv.joins(:departements).where(departements: {cp: params[:dep]}).first
          if @crpv
            respond_to do |format|
              format.js
            end
          end
        end
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
