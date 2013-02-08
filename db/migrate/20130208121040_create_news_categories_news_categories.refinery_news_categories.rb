# This migration comes from refinery_news_categories (originally 1)
class CreateNewsCategoriesNewsCategories < ActiveRecord::Migration

  def up
    create_table :refinery_news_categories do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end

    names = %w(congres formation prix emploi)
    say_with_time "Creating #{names.to_sentence} categories" do
      names.each do |name|
        Refinery::NewsCategories::NewsCategory.create!(title: name)
      end
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
