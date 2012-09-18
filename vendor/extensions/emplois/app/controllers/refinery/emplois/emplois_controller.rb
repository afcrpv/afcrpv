module Refinery
  module Emplois
    class EmploisController < ::ApplicationController

      before_filter :find_all_emplois, only: [:index]
      before_filter :find_page, only: [:index, :show]
      before_filter :find_submit_page, only: [:new, :create]

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @emploi in the line below:
        present(@page)
      end

      def merci
        @page = ::Refinery::Page.find_by_link_url("/emplois/merci")
      end

      def new
        @emploi = ::Refinery::Emplois::Emploi.new
      end

      def create
        resource = Resource.create(file: params[:emploi][:attachment])
        @emploi = ::Refinery::Emplois::Emploi.new(params[:emploi].merge({attachment: resource}))
        if @emploi.save
          # add mailer stuff here
          redirect_to refinery.merci_emplois_emplois_path
        else
          render :new
        end
      end

      def show
        @emploi = Emploi.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @emploi in the line below:
        present(@page)
      end

    protected

      def find_all_emplois
        @emplois = Emploi.order('created_at DESC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/emplois").first
      end

      def find_submit_page
        @page = ::Refinery::Page.where(:link_url => "/emplois/deposer").first
      end
    end
  end
end
