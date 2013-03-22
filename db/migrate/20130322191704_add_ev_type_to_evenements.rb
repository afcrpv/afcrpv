class AddEvTypeToEvenements < ActiveRecord::Migration
  def change
    add_column :evenements, :ev_type, :string
  end
end
