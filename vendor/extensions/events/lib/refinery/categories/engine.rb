module Refinery
  module Categories
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Categories

      engine_name :refinery_events

      initializer "register refinerycms_categories plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "categories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.categories_admin_categories_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/categories/category'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Categories)
      end
    end
  end
end
