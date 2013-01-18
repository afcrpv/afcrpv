class Departement < ActiveRecord::Base
  attr_accessible :cp, :name
  has_and_belongs_to_many :crpvs,
    class_name: "Refinery::Crpvs::Crpv",
    join_table: "crpvs_departements",
    foreign_key: "departement_id",
    association_foreign_key: "crpv_id"
end
