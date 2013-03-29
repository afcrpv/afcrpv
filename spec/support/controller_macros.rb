module ControllerMacros
  def login_as_admin
    roles = []
    %w(Refinery Superuser).each do |title|
      roles << Refinery::Role.create(title: title)
    end
    user = Refinery::User.new username: "John Doe", email: "test@test.com"
    user.roles = roles

    sign_in user
  end
end
