class Departement < ActiveRecord::Base
  attr_accessible :cp, :name, :refinery_crpv_id
  belongs_to :crpv, class_name: "Refinery::Crpvs::Crpv", foreign_key: "refinery_crpv_id"

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
