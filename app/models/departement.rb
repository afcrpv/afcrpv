class Departement < ActiveRecord::Base
  attr_accessible :cp, :name
  has_and_belongs_to_many :crpvs,
    class_name: "Refinery::Crpvs::Crpv",
    join_table: "crpvs_departements",
    foreign_key: "departement_id",
    association_foreign_key: "crpv_id"
  def self.with_cp_or_name(query)
    where("LOWER(name) like ? OR cp like ?", "%#{query}%", "%#{query}%")
  end

  def cp_name_and_id
    {id: id, text: cp_name}
  end

  def cp_name
    [zeroed_cp, name].join(" - ")
  end

  def zeroed_cp
    cp.length > 1 ? cp : "0" + cp
  end
end
