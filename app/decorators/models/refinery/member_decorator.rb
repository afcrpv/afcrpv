Refinery::Memberships::Member.class_eval do
  attr_accessible :refinery_crpv_id

  belongs_to :refinery_crpv, class_name: "::Refinery::Crpvs::Crpv"

  def to_param
    id
  end

  def full_name
    "#{self.first_name} #{last_name}"
  end
end
