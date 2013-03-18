class CreateEvenements < ActiveRecord::Migration
  def change
    create_table :evenements do |t|
      t.string :name

      t.timestamps
    end
    add_index :evenements, :name
  end
end
