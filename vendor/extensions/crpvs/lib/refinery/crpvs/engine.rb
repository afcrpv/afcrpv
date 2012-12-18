module Refinery
  module Crpvs
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Crpvs

      engine_name :refinery_crpvs

      initializer "register refinerycms_crpvs plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "crpvs"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.crpvs_admin_crpvs_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/crpvs/crpv',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Crpvs)
      end
    end
  end
end
