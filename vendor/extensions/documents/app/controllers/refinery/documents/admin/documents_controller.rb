module Refinery
  module Documents
    module Admin
      class DocumentsController < ::Refinery::AdminController

        crudify :'refinery/documents/document',
                :title_attribute => 'titre', :xhr_paging => true

      end
    end
  end
end
