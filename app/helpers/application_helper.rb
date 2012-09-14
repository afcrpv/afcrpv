# encoding: UTF-8

module ApplicationHelper
  def custom_menu_branch_css(local_assigns)
    options = local_assigns.dup
    options.update(:sibling_count => options[:menu_branch].shown_siblings.length) unless options[:sibling_count]

    css = []
    css << 'active' if selected_page_or_descendant_page_selected?(local_assigns[:menu_branch])
    if (local_assigns[:menu_branch].children unless local_assigns[:hide_chilren]).any? and local_assigns[:menu_branch].ancestors.length < local_assigns[:menu_levels]
      css << 'dropdown'
    else
      css << 'nav-header' unless local_assigns[:menu_branch].ancestors.length == 0
    end
    css
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
      feeds_list(agence.feeds)
    else
      content_tag :p, "Aucune actualité"
    end
  end

  def link_to_event(event)
    content_tag :li, class: "event-item" do
      [
        event_date(event),
        category_label(event),
        link_to(event.title, refinery.events_event_path(event))
      ].join("").html_safe
    end
  end

  def event_date(event)
    content_tag :span, I18n.l(event.start_date.to_date, format: :perso), class: "event"
  end

  def category_label(event)
    content_tag(:span, event.category.to_s.upcase, class: label_class(event))
  end

  private

  def label_class(event)

    label_css = "label "
    label_css += case event.category.title
                when "congres" then ""
                when "formation" then "label-info"
                when "prix" then "label-success"
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
