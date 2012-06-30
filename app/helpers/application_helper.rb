module ApplicationHelper
  def custom_menu_branch_css(local_assigns)
    options = local_assigns.dup
    options.update(:sibling_count => options[:menu_branch].shown_siblings.length) unless options[:sibling_count]

    css = []
    css << 'active' if selected_page_or_descendant_page_selected?(local_assigns[:menu_branch])
    css << 'dropdown' if (local_assigns[:menu_branch].children unless local_assigns[:hide_chilren]).any?
    css
  end
end
