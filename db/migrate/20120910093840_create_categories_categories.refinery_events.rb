# This migration comes from refinery_events (originally 2)
class CreateCategoriesCategories < ActiveRecord::Migration

  def up
    create_table :refinery_categories do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-categories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/categories/categories"})
    end

    drop_table :refinery_categories

  end

end
