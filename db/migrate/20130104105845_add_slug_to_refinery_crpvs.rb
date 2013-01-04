class AddSlugToRefineryCrpvs < ActiveRecord::Migration
  def change
    add_column :refinery_crpvs, :slug, :string
    add_index :refinery_crpvs, :slug
  end
end
