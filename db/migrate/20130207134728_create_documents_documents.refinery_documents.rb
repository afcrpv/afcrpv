# This migration comes from refinery_documents (originally 1)
class CreateDocumentsDocuments < ActiveRecord::Migration

  def up
    create_table :refinery_documents do |t|
      t.string :titre
      t.date :publication
      t.integer :document_category_id
      t.integer :fichier_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-documents"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/documents/documents"})
    end

    drop_table :refinery_documents

  end

end
