module Refinery
  module Agences
    module Admin
      class AgencesController < ::Refinery::AdminController

        crudify :'refinery/agences/agence',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
