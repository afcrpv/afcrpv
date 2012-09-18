class AddSlugToEmplois < ActiveRecord::Migration
  def up
    klass = ::Refinery::Emplois::Emploi
    unless klass.column_names.map(&:to_sym).include?(:slug)
      add_column klass.table_name, :slug, :string
    end
  end

  def down
    klass = ::Refinery::Emplois::Emploi
    if klass.column_names.map(&:to_sym).include?(:slug)
      remove_column klass.table_name, :slug
    end
  end
end
