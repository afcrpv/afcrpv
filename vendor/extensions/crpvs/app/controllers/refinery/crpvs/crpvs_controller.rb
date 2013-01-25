#encoding: utf-8
module Refinery
  module Crpvs
    class CrpvsController < ::ApplicationController

      before_filter :find_all_crpvs, only: [:index]
      before_filter :find_page
      helper_method :paris_crpvs

      def paris
        @page = ::Refinery::Page.where(:link_url => "/crpvs/paris").first
      end

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @crpv in the line below:
        present(@page)
      end

      def search
        if params[:dep]
          @crpv = Crpv.joins(:departements).where(departements: {cp: params[:dep]}).first
          respond_to do |format|
            format.js
          end
        end
      end

      def show
        @page = ::Refinery::Page.where(:link_url => "/crpvs/fiche").first
        @crpv = Crpv.find(params[:id])
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @crpv in the line below:
        present(@page)
      end

    protected

      def paris_crpvs
        @paris_crpvs ||= [
          ["pitie-salpetriere", "Pitié-Salpétrière"],
          ["georges-pompidou", "Georges Pompidou"],
          ["saint-antoine", "Saint-Antoine"],
          ["cochin-st-vincent-de-paul", "Cochin St Vincent de Paul"],
          ["fernand-widal", "Fernand Widal"]
        ]
      end

      def find_all_crpvs
        @crpvs = Crpv.order('name ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/crpvs").first
      end

    end
  end
end
