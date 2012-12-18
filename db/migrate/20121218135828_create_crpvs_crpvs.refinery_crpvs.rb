# This migration comes from refinery_crpvs (originally 1)
class CreateCrpvsCrpvs < ActiveRecord::Migration

  def up
    create_table :refinery_crpvs do |t|
      t.string :name
      t.text :adresse
      t.string :city
      t.string :cp
      t.string :responsable
      t.string :tel
      t.string :fax
      t.string :email
      t.string :website
      t.string :bulletin
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-crpvs"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/crpvs/crpvs"})
    end

    drop_table :refinery_crpvs

  end

end
