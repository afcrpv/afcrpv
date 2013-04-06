Refinery::User.class_eval do
  def is_admin?
    has_role?("Superuser") || has_role?("Refinery")
  end

  belongs_to :refinery_crpv, class_name: "::Refinery::Crpvs::Crpv", foreign_key: :refinery_crpv_id
end
