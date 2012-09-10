module Refinery
  module Events
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Events

      engine_name :refinery_events

      initializer "register refinerycms_events plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "events"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.events_admin_events_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/events/event'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Events)
      end
    end
  end
end
