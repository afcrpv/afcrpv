class AddDescriptionToCategories < ActiveRecord::Migration
  def up
    klass = ::Refinery::NewsCategories::NewsCategory
    unless klass.column_names.map(&:to_sym).include?(:description)
      add_column klass.table_name, :description, :string
    end
  end

  def down
    klass = ::Refinery::NewsCategories::NewsCategory
    if klass.column_names.map(&:to_sym).include?(:description)
      remove_column klass.table_name, :description
    end
  end
end
