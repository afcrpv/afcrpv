class CreateEnquetes < ActiveRecord::Migration
  def change
    create_table :enquetes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
