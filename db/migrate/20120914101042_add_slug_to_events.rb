class AddSlugToEvents < ActiveRecord::Migration
  def up
    klass = ::Refinery::Events::Event
    unless klass.column_names.map(&:to_sym).include?(:slug)
      add_column klass.table_name, :slug, :string
    end
  end

  def down
    klass = ::Refinery::Events::Event
    if klass.column_names.map(&:to_sym).include?(:slug)
      remove_column klass.table_name, :slug
    end
  end
end
