class AddShowonhomeToAgence < ActiveRecord::Migration
  def up
    klass = ::Refinery::Agences::Agence
    unless klass.column_names.map(&:to_sym).include?(:show_on_home)
      add_column klass.table_name, :show_on_home, :boolean
    end
  end

  def down
    klass = ::Refinery::Agences::Agence
    if klass.column_names.map(&:to_sym).include?(:show_on_home)
      remove_column klass.table_name, :show_on_home
    end
  end
end
