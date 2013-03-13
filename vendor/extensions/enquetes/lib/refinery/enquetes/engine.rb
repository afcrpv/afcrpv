module Refinery
  module Enquetes
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Enquetes

      engine_name :refinery_enquetes

      initializer "register refinerycms_enquetes plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "enquetes"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.enquetes_admin_enquetes_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/enquetes/enquete',
            :title => 'code_bnpv'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Enquetes)
      end
    end
  end
end
