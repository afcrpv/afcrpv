#encoding: utf-8
class EvenementsDatatable
  delegate :logger, :params, :l, :h, :link_to, :edit_evenement_path, :check_box_tag, :content_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Evenement.count,
      iTotalDisplayRecords: evenements.total_entries,
      aaData: data,
    }
  end

  private

  def data
    evenements.map do |evenement|
      [
        evenement.id,
        content_tag(:td, check_box_tag("evenement_names[]", evenement.name)),
        evenement.name,
        evenement.ev_type,
        link_to("<i class='icon-pencil'></i>".html_safe, edit_evenement_path(evenement), class: "btn btn-small") + link_to("<i class='icon-trash'></i>".html_safe, evenement, confirm: "Etes-vous sûr ?", method: :delete, class: "btn btn-small")
      ]
    end
  end

  def evenements
    @evenements ||= fetch_evenements
  end

  def fetch_evenements
    evenements = Evenement.order(:name)
    evenements = evenements.page(page).per_page(per_page)
    if params[:sSearch].present?
      evenements = evenements.name_contains params[:sSearch]
    end
    evenements
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(name ev_type)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
