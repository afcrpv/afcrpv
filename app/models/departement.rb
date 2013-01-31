class Departement < ActiveRecord::Base
  attr_accessible :cp, :name
  has_and_belongs_to_many :crpvs,
    class_name: "Refinery::Crpvs::Crpv",
    join_table: "crpvs_departements",
    foreign_key: "departement_id",
    association_foreign_key: "crpv_id"

  default_scope order(:name)
  def self.with_cp_or_name(query)
    where("LOWER(name) like ? OR cp like ?", "%#{query}%", "%#{query}%")
  end

  def cp_name_and_cp
    {id: cp, text: cp_name}
  end

  def cp_name
    name + " (#{zeroed_cp})"
  end

  def zeroed_cp
    cp.length > 1 ? cp : "0" + cp
  end
end
