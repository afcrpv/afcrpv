class CreateAgencesAgences < ActiveRecord::Migration

  def up
    create_table :refinery_agences do |t|
      t.string :name
      t.string :description
      t.string :feed_url
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-agences"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/agences/agences"})
    end

    drop_table :refinery_agences

  end

end
