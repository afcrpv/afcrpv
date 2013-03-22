# This migration comes from meta_types (originally 20120507130303)
class MetaTypeMember < ActiveRecord::Migration
  def up
    execute <<-CREATE_SQL
      create table meta_type_members (
        id            serial PRIMARY KEY,
        meta_type_id  integer references meta_types(id),
        meta_type_property_id integer references meta_type_properties(id),
        position      integer,
        created_at    timestamp without time zone,
        updated_at    timestamp without time zone
      );
    CREATE_SQL
  end

  def down
    execute "drop table meta_type_members"
  end
end
