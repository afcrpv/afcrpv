Refinery::Role.create(:id => 3, :title => 'Member')

members_page = ::Refinery::Page.find_or_create_by_link_url("/members",
  :title => "Members",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members.*$")
members_page.parts.find_or_create_by_title("Body",
  :body => "",
  :position => 0
)
members_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 1
)


login_page = members_page.children.find_or_create_by_link_url("/members/login",
  :title => "Login",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/login$")
login_page.parts.find_or_create_by_title("Body above",
  :body => "",
  :position => 0
)
login_page.parts.find_or_create_by_title("Body below",
  :body => "",
  :position => 1
)
login_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 2
)


new_member_page = members_page.children.find_or_create_by_link_url("/members/new",
  :title => "New Member",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/(new|create|).*$")
new_member_page.parts.find_or_create_by_title("Body above",
  :body => "",
  :position => 0
)
new_member_page.parts.find_or_create_by_title("Body below",
  :body => "",
  :position => 1
)
new_member_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 2
)

welcome_page = new_member_page.children.find_or_create_by_link_url("/members/welcome",
  :title => "Welcome",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/welcome$")
welcome_page.parts.find_or_create_by_title("Body",
  :body => "",
  :position => 0
)
welcome_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 1
)

lost_password_page = members_page.children.find_or_create_by_link_url("/members/new_password",
  :title => "New password",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/new_password$")
lost_password_page.parts.find_or_create_by_title("Body above",
  :body => "",
  :position => 0
)
lost_password_page.parts.find_or_create_by_title("Body below",
  :body => "",
  :position => 1
)
lost_password_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 2
)


new_password_page = lost_password_page.children.find_or_create_by_link_url("/members/new_password/created",
  :title => "New password created",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/new_password/created$")
new_password_page.parts.find_or_create_by_title("Body",
  :body => "",
  :position => 0
)
new_password_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 1
)

edit_members_page= members_page.children.find_or_create_by_link_url("/members/edit",
  :title => "Edit profile",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/edit$")
edit_members_page.parts.find_or_create_by_title("Body above",
  :body => "",
  :position => 0
)
edit_members_page.parts.find_or_create_by_title("Body below",
  :body => "",
  :position => 1
)
edit_members_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 2
)

profile_members_page = members_page.children.find_or_create_by_link_url("/members/profile",
  :title => "Profile",
  :deletable => false,
  :show_in_menu => false,
  :menu_match => "^/members/profile$")
profile_members_page.parts.find_or_create_by_title("Body above",
  :body => "",
  :position => 0
)
profile_members_page.parts.find_or_create_by_title("Body below",
  :body => "",
  :position => 1
)
profile_members_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 2
)

activate_members_page = members_page.children.create({:title => "Activate",
  :deletable => false,
  :link_url => "/members/activate",
  :show_in_menu => false,
  :menu_match => "^/members/activate\/[a-zA-Z0-9]+$"})
activate_members_page.parts.find_or_create_by_title("Body",
  :body => "",
  :position => 0
)
activate_members_page.parts.find_or_create_by_title("Side Body",
  :body => "",
  :position => 1
)
