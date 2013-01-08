# encoding: UTF-8

module ApplicationHelper
  def periode_inclusion(projet)
    "#{l projet.debut_inclusion} - #{l projet.fin_inclusion} (#{projet.type_inclusion})"
  end
  def def_item_for_object(object, field, content=nil)
    object_name = object.class.to_s.downcase.gsub('::', '/')
    content = general_def_content(object, field).html_safe unless content
    content_tag(:dt, I18n.t(field, scope: "activerecord.attributes.#{object_name}")) + content_tag(:dd, content) if object.send(field).present?
  end

  def website_def_content(object, website)
    if website
      link = website.gsub(/<\/?p>/, "")
      link_to link, target: "_blank" do
        content_tag(:i, nil, class: "icon-share") + link
      end
    end
  end

  def general_def_content(object, field)
    raw(object.send(field))
  end

  def email_def_content(object, email)
    email.gsub(/<\/?p>/, "").split("<br />").map {|item| mail_to(item)}.join("<br/>").html_safe
  end
  def news_line(news)
    klass_name = get_demodulized_class(news)
    content_tag :tr do
      [
        content_tag(:td, news_date(news)),
        content_tag(:td, category_label(news, klass_name)),
        content_tag(:td, link_to_news(news))
      ].join("\n").html_safe
    end
  end

  def get_demodulized_class(news)
    news.class.parent.name.downcase.demodulize
  end

  def link_to_news(news)
    klass_name = get_demodulized_class(news)
    title = news.send(:title)
    link_to(title, refinery.polymorphic_path([klass_name, news]))
  end

  def news_date(news)
    content_tag :span, I18n.l(news.created_at.to_date), class: "date"
  end

  def category_label(news, klass_name)
    text = news.respond_to?(:category) ? news.category.to_s.upcase : klass_name.singularize.upcase
    content_tag(:span, text, class: label_class(news, klass_name))
  end

  def link_to_toc_branch(branch, level)
    path = branch.respond_to?(:link_url) ? branch.link_url : branch.nested_path
    branch_title = level == 1 ? content_tag(:i, nil, class: "icon-chevron-left") : ""
    branch_title += branch.menu_title.blank? ? branch.title : branch.menu_title
    link_to branch_title.html_safe, path
  end

  def toc_branch_css(branch)
    css = []
    css << 'active' if is_selected?(branch)
    css
  end

  def is_selected?(page)
    path = request.path
    path = path.force_encoding('utf-8') if path.respond_to?(:force_encoding)

    # Ensure we match the path without the locale, if present.
    if ::Refinery.i18n_enabled? and path =~ %r{^/#{::I18n.locale}/}
      path = path.split(%r{^/#{::I18n.locale}}).last
      path = "/" if path.blank?
    end

    # First try to match against a "menu match" value, if available.
    return true if page.try(:menu_match).present? && path =~ Regexp.new(page.menu_match)

    # Find the first url that is a string.
    url = [page.url]
    url << ['', page.url[:path]].compact.flatten.join('/') if page.url.respond_to?(:keys)
    url = url.last.match(%r{^/#{::I18n.locale.to_s}(/.*)}) ? $1 : url.detect{|u| u.is_a?(String)}

    # Now use all possible vectors to try to find a valid match
    [path, URI.decode(path)].include?(url) || path == "/#{page.id}"
  end

  private

  def label_class(news, klass_name)
    category = news.respond_to?(:category) ? news.category.title : klass_name
    label_css = "label "
    label_css += case category
                when "congres", "formation", "prix" then "label-info"
                when "emplois" then "label-warning"
                else
                  ""
                end
  end
end
