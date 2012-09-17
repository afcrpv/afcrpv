module Refinery
  module Emplois
    module Admin
      class EmploisController < ::Refinery::AdminController

        crudify :'refinery/emplois/emploi',
                :title_attribute => 'organisation', :xhr_paging => true

      end
    end
  end
end
