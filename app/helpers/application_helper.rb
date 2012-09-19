# encoding: UTF-8

module ApplicationHelper
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
    content_tag :span, I18n.l(news.created_at.to_date, format: :perso), class: "date"
  end

  def category_label(news, klass_name)
    text = news.respond_to?(:category) ? news.category.to_s.upcase : klass_name.singularize.upcase
    content_tag(:span, text, class: label_class(news, klass_name))
  end

  def link_to_toc_branch(branch, level)
    branch_title = level == 1 ? content_tag(:i, nil, class: "icon-chevron-left") : ""
    branch_title += branch.menu_title.blank? ? branch.title : branch.menu_title
    link_to branch_title.html_safe, branch.nested_path
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

  def get_agence_feeds(agence, limit)
    feeds = agence.feeds
    return feed_error if feeds.nil?
    if feeds.any?
      feeds_list(agence.feeds(limit))
    else
      content_tag :p, "Aucune actualité"
    end
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

  def feed_error
    content_tag :div, class: "alert alert-error" do
      content_tag(:strong, "Attention !") + " Impossible de récupérer le flux d'actualité RSS."
    end
  end

  def feeds_list(feeds)
    feeds_items = []
    feeds.each do |feed|
      feeds_items << content_tag(:li, link_to(feed.title, feed.link, target: "_BLANK"))
    end
    content_tag :ul, feeds_items.join("\n").html_safe
  end
end
