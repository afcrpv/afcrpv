(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:fr]).each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-documents').blank?
        user.plugins.create(:name => 'refinerycms-documents',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  if defined?(Refinery::Page)
    documents_url = "/documents"
    unless Refinery::Page.where(:link_url => documents_url).any?
      # documents#index action page
      documents_page = Refinery::Page.create(
        :title => 'Documents',
        :link_url => documents_url,
        :deletable => false,
        :menu_match => "^#{documents_url}(\/|\/.+?|)$"
      )
      Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
        documents_page.parts.create(:title => default_page_part, :body => nil, :position => index)
      end
    end
  end
end
