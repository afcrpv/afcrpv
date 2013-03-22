class CreateDossiers < ActiveRecord::Migration
  def change
    execute <<-SQL
      create table dossiers(
        id                    serial primary key,
        code_bnpv             character varying,
        date_recueil          date,
        doublon               character varying,
        j_evenement           integer,
        m_evenement           integer,
        a_evenement           integer,
        comm_evenement        text,
        gravite               character varying,
        evolution             character varying,
        commentaire           text,
        meta_type_id          integer references meta_types(id),
        evenement_id          integer references evenements(id),
        refinery_crpv_id      integer references refinery_crpvs(id),
        properties_hstore     hstore,
        created_at            timestamp without time zone,
        updated_at timestamp without time zone
      )
    SQL
  end
end
