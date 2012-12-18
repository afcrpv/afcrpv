Refinery::Memberships::MembershipEmail.find_or_create_by_title('member_created',
  :subject => 'Welcome',
  :body => '<p>Welcome email</p>'
)
Refinery::Memberships::MembershipEmail.find_or_create_by_title('member_accepted',
  :subject => 'Accepted',
  :body => '<p>Accepted email</p>'
)
Refinery::Memberships::MembershipEmail.find_or_create_by_title('member_deleted',
  :subject => 'Account deleted',
  :body => '<p>Account deleted email</p>'
)
Refinery::Memberships::MembershipEmail.find_or_create_by_title('member_rejected',
  :subject => 'Account rejected',
  :body => '<p>Account rejected email</p>'
)
Refinery::Memberships::MembershipEmail.find_or_create_by_title('membership_extended',
  :subject => 'Membership extended',
  :body => '<p>Membership extended email</p>'
)
Refinery::Memberships::MembershipEmail.find_or_create_by_title('member_activated',
  :subject => 'Account activated',
  :body => '<p>Account activated email</p>'
)
