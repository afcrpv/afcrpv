::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinery_inquiries').blank?
    user.plugins.create(:name => "refinery_inquiries")
  end
end if defined?(::Refinery::User)

if defined?(::Refinery::Page)
  unless Refinery::Page.where(:link_url => '/projets/soumettre').any?
    new_project_page = ::Refinery::Page.create({
      :title => "Soumettre un projet",
      :link_url => "/projets/soumettre",
      :menu_match => "^/projets.*$",
      :deletable => false
    })
    new_project_page.parts.create({
      :title => "Body",
      :body => "<p>Get in touch with us. Just use the form below and we'll get back to you as soon as we can.</p>",
      :position => 0
    })
    new_project_page.parts.create({
      :title => "Side Body",
      :body => "",
      :position => 1
    })
  end

  unless Refinery::Page.where(:link_url => '/projets/merci').any?
    thank_you_page = new_project_page.children.create({
      :title => "Merci",
      :link_url => "/projets/merci",
      :menu_match => "^/projets/merci",
      :show_in_menu => false,
      :deletable => false
    })
    thank_you_page.parts.create({
      :title => "Body",
      :body => "<p>We've received your inquiry and will get back to you with a response shortly.</p><p><a href='/'>Return to the home page</a></p>",
      :position => 0
    })
  end
end

(Refinery::Inquiries::Setting.methods.sort - ActiveRecord::Base.methods).each do |setting|
  Refinery::Inquiries::Setting.send(setting) unless setting.to_s =~ /=$/
end
