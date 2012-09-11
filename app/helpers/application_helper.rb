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
    content_tag :li do
      (event.start_date.strftime('%d/%m/%Y') + " " + content_tag(:span, event.category.to_s.upcase, class: label_class(event))).html_safe + " " +
      link_to(event.title, refinery.events_event_path(event))
    end
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
