module Refinery
  module Emplois
    module Admin
      class EmploisController < ::Refinery::AdminController

        crudify :'refinery/emplois/emploi',
                :title_attribute => 'title', :xhr_paging => true, :sortable => false

      end
    end
  end
end
