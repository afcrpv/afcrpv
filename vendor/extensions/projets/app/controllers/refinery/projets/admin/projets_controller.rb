module Refinery
  module Projets
    module Admin
      class ProjetsController < ::Refinery::AdminController

        crudify :'refinery/projets/projet',
                :title_attribute => "titre", :xhr_paging => true, :sortable => false,
                :order => "created_at DESC"
      end
    end
  end
end
