module Refinery
  module Projets
    class ProjetsController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def merci
        @page = ::Refinery::Page.find_by_link_url("/projets/merci")
      end

      def new
        @projet = ::Refinery::Projets::Projet.new
      end

      def create
        @projet = ::Refinery::Projets::Projet.new(params[:projet])

        if @projet.save
          redirect_to refinery.merci_projets_projets_path
        else
          render :new
        end
      end

      protected

      def find_page
        @page = ::Refinery::Page.find_by_link_url("/projets/soumettre")
      end

    end
  end
end
