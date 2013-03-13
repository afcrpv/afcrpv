# This migration comes from refinery_enquetes (originally 1)
class CreateEnquetesEnquetes < ActiveRecord::Migration

  def up
    create_table :refinery_enquetes do |t|
      t.string :code_bnpv
      t.date :date_recueil
      t.boolean :doublon
      t.integer :j_evenement
      t.integer :m_evenement
      t.integer :a_evenement
      t.text :comm_evenement
      t.string :gravite
      t.string :evolution
      t.integer :j_evolution
      t.integer :m_evolution
      t.integer :a_evolution
      t.text :commentaire
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-enquetes"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/enquetes/enquetes"})
    end

    drop_table :refinery_enquetes

  end

end
