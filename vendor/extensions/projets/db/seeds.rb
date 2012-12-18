::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinery_projets').blank?
    user.plugins.create(:name => "refinery_projets")
  end
end if defined?(::Refinery::User)

if defined?(::Refinery::Page)
  unless Refinery::Page.where(:link_url => '/projets/soumettre').any?
    contact_us_page = ::Refinery::Page.create({
      :title => "Soumettre un projet",
      :link_url => "/projets/soumettre",
      :menu_match => "^/projets.*$",
      :deletable => false
    })
    contact_us_page.parts.create({
      :title => "Body",
      :body => "<p>Get in touch with us. Just use the form below and we'll get back to you as soon as we can.</p>",
      :position => 0
    })
    contact_us_page.parts.create({
      :title => "Side Body",
      :body => "",
      :position => 1
    })
  end

  unless Refinery::Page.where(:link_url => '/projets/merci').any?
    thank_you_page = contact_us_page.children.create({
      :title => "Thank You",
      :link_url => "/projets/merci",
      :menu_match => "^/projets/merci",
      :show_in_menu => false,
      :deletable => false
    })
    thank_you_page.parts.create({
      :title => "Body",
      :body => "<p>We've received your projet and will get back to you with a response shortly.</p><p><a href='/'>Return to the home page</a></p>",
      :position => 0
    })
  end

end
