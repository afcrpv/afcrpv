# encoding: UTF-8

(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:fr]).each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-emplois').blank?
        user.plugins.create(:name => 'refinerycms-emplois',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => "/emplois").empty?
    emplois_page = Refinery::Page.create(
      :title => 'Consulter les offres',
      :link_url => "/emplois",
      :deletable => false,
      :menu_match => "^/emplois.*$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      emplois_page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end

  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => "/emplois/deposer").empty?
    deposer_page = emplois_page.children.create(
      :title => "Deposer une offre d'emploi",
      :link_url => "/emplois/deposer",
      :deletable => false,
      :menu_match => "^/emplois/deposer$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      deposer_page.parts.create(:title => default_page_part, :body => "<p>Pour poster une nouvelle offre d'emploi, veuillez remplir les champs ci-dessous. Après envoi du formulaire, vous recevrez un e-mail de confirmation à l'adresse indiquée.</p>", :position => index)
    end
  end

  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => "/emplois/merci").empty?
    merci_page = emplois_page.children.create(
      :title => "Merci",
      :link_url => "/emplois/merci",
      :deletable => false,
      :menu_match => "^/emplois/merci$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      merci_page.parts.create(:title => default_page_part, :body => "<p>Votre offre d'emploi a bien été transmise au webmaster et sera publiée sur le site dès que possible.</p>\n<p>Pour toute question ou modification concernant cette offre, merci de <strong>contacter le webmaster</strong> à l'adresse suivante : <a href='mailto:webmaster.afcrpv@gmail.com'>webmaster.afcrpv@gmail.com</a></p>\n<p>Vous recevrez un e-mail de confirmation à l'adresse indiquée dans le formulaire.</p>\n<a class='btn btn-large btn-block btn-primary' href='/'>Retour à la page d'accueil.</a>", :position => index)
    end
  end
end
