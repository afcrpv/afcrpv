class CreateNewsCategoriesNewsCategories < ActiveRecord::Migration

  def up
    create_table :refinery_news_categories do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-news_categories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/news_categories/news_categories"})
    end

    drop_table :refinery_news_categories

  end

end
