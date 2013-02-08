module Refinery
  module NewsCategories
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::NewsCategories

      engine_name :refinery_news_categories

      initializer "register refinerycms_news_categories plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "news_categories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.news_categories_admin_news_categories_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/news_categories/news_category'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::NewsCategories)
      end
    end
  end
end
