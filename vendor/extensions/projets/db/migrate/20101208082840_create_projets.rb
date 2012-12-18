class CreateProjets < ActiveRecord::Migration
  def up
    unless ::Refinery::Projets::Projet.table_exists?
      create_table :refinery_projets_projets, :force => true do |t|
        t.string   :name
        t.string   :email
        t.string   :phone
        t.text     :message
        t.boolean  :spam,     :default => false
        t.timestamps
      end

      add_index :refinery_projets_projets, :id
    end
  end

  def down
     drop_table ::Refinery::Projets::Projet.table_name

     ::Refinery::Page.delete_all({
       :link_url => ("/projets" || "/projets/merci")
     }) if defined?(::Refinery::Page)
  end
end
