module Refinery
  module Agences
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Agences

      engine_name :refinery_agences

      initializer "register refinerycms_agences plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "agences"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.agences_admin_agences_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/agences/agence',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Agences)
      end
    end
  end
end
