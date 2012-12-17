module Refinery
  module Crpvs
    module Admin
      class CrpvsController < ::Refinery::AdminController

        crudify :'refinery/crpvs/crpv',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
