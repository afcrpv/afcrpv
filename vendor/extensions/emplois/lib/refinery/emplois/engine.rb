module Refinery
  module Emplois
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Emplois

      engine_name :refinery_emplois

      initializer "register refinerycms_emplois plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "emplois"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.emplois_admin_emplois_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/emplois/emploi',
            :title => 'organisation'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Emplois)
      end
    end
  end
end
