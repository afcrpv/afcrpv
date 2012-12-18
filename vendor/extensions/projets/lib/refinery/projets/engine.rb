module Refinery
  module Projets
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Projets

      engine_name :refinery_projets

      initializer "register refinerycms_projets plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "projets"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.projets_admin_projets_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/projets/projet',
            :title => 'name',
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Projets)
      end
    end
  end
end
