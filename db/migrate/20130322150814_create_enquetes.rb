class CreateEnquetes < ActiveRecord::Migration
  def change
    create_table :enquetes do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
