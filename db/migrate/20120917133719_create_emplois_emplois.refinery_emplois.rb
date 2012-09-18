# This migration comes from refinery_emplois (originally 1)
class CreateEmploisEmplois < ActiveRecord::Migration

  def up
    create_table :refinery_emplois do |t|
      t.string :organisation
      t.string :name
      t.string :email
      t.string :telephone
      t.text :address
      t.string :title
      t.text :description
      t.date :expires_on
      t.integer :attachment_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-emplois"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/emplois/emplois"})
    end

    drop_table :refinery_emplois

  end

end
