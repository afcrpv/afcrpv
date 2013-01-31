class Arrondissement < ActiveRecord::Base
  attr_accessible :name, :number, :refinery_crpv_id
  belongs_to :crpv, class_name: "Refinery::Crpvs::Crpv", foreign_key: "refinery_crpv_id"

  def nom_ordinal
    return case number
    when 1 ; then "1er"
    else
      number.to_s + "e"
    end
  end
end
