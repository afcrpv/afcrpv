class AddDescriptionToCategories < ActiveRecord::Migration
  def up
    klass = ::Refinery::Categories::Category
    unless klass.column_names.map(&:to_sym).include?(:description)
      add_column klass.table_name, :description, :string
    end
  end

  def down
    klass = ::Refinery::Categories::Category
    if klass.column_names.map(&:to_sym).include?(:description)
      remove_column klass.table_name, :description
    end
  end
end
