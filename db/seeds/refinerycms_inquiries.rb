#encoding: utf-8
::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinery_inquiries').blank?
    user.plugins.create(:name => "refinery_inquiries")
  end
end if defined?(::Refinery::User)

if defined?(::Refinery::Page)
  unless Refinery::Page.where(:link_url => '/contact').any?
    contact_us_page = ::Refinery::Page.create({
      :title => "Contact",
      :link_url => "/contact",
      :menu_match => "^/(inquiries|contact).*$",
      :deletable => false
    })
    contact_us_page.parts.create({
      :title => "Body",
      :body => "<p>Centre Régional de Pharmacovigilance<br />Batiment A - 162, Avenue Lacassagne - 69424 Lyon cedex 03</p>\n
<p>Tél : 04.72.11.69.97<br />Fax: 04.72.11.69.85<br />Mail: afcrpv@gmail.com</p>\n
<p>Ou remplir le formulaire suivant :</p>",
      :position => 0
    })
    contact_us_page.parts.create({
      :title => "Side Body",
      :body => "",
      :position => 1
    })
  end

  unless Refinery::Page.where(:link_url => '/contact/merci').any?
    thank_you_page = contact_us_page.children.create({
      :title => "Merci",
      :link_url => "/contact/merci",
      :menu_match => "^/(inquiries|contact)/merci$",
      :show_in_menu => false,
      :deletable => false
    })
    thank_you_page.parts.create({
      :title => "Body",
      :body => "<p>Nous avons bien reçu votre message et nous revenons vers vous très vite.</p><p><a href='/'>Retour à l'accueil.</a></p>",
      :position => 0
    })
  end

  unless Refinery::Page.by_title('Privacy Policy').any?
    privacy_policy_page = contact_us_page.children.create({
      :title => "Privacy Policy",
      :deletable => true,
      :show_in_menu => false
    })
    privacy_policy_page.parts.create({
      :title => "Body",
      :body => "<p>We respect your privacy. We do not market, rent or sell our email list to any outside parties.</p><p>We need your e-mail address so that we can ensure that the people using our forms are bona fide. It also allows us to send you e-mail newsletters and other communications, if you opt-in. Your postal address is required in order to send you information and pricing, if you request it.</p><p>Please call us at 123 456 7890 if you have any questions or concerns.</p>",
      :position => 0
    })
  end
end

(Refinery::Inquiries::Setting.methods.sort - ActiveRecord::Base.methods).each do |setting|
  Refinery::Inquiries::Setting.send(setting) unless setting.to_s =~ /=$/
end
