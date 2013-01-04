module Refinery
  module Projets
    class ProjetsController < ::ApplicationController

      def index
        @projets = Projet.order('created_at')
        @page = ::Refinery::Page.where(:link_url => "/projets").first
        present(@page)
      end

      def merci
        @page = ::Refinery::Page.find_by_link_url("/projets/merci")
      end

      def new
        @projet = ::Refinery::Projets::Projet.new
        @page = ::Refinery::Page.find_by_link_url("/projets/soumettre")
      end

      def create
        @projet = ::Refinery::Projets::Projet.new(params[:projet])
        @page = ::Refinery::Page.find_by_link_url("/projets/soumettre")

        if @projet.save
          redirect_to refinery.merci_projets_projets_path
        else
          render :new
        end
      end
    end
  end
end
