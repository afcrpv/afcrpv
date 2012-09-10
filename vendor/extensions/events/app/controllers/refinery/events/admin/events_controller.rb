module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController

        crudify :'refinery/events/event', :xhr_paging => true

      end
    end
  end
end
