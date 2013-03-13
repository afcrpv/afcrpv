module Refinery
  module Enquetes
    module Admin
      class EnquetesController < ::Refinery::AdminController

        crudify :'refinery/enquetes/enquete',
                :title_attribute => 'code_bnpv', :xhr_paging => true

      end
    end
  end
end
