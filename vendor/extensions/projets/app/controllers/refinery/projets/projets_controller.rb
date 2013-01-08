module Refinery
  module Projets
    class ProjetsController < ::ApplicationController
      before_filter :find_page, only: [:show, :index]

      def index
        @projets = Projet.order('created_at')
        present(@page)
      end

      def show
        @projet = Projet.find(params[:id])

        present(@page)
      end

      def merci
        @page = ::Refinery::Page.find_by_link_url("/projets/merci")
      end

      def new
        @projet = ::Refinery::Projets::Projet.new(refinery_crpv_id: current_refinery_user.refinery_crpv_id)
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

      protected

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/projets").first
      end
    end
  end
end
