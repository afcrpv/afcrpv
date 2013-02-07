Refinery::User.class_eval do
  def is_admin?
    has_role?("Superuser") || has_role?("Refinery")
  end
end
