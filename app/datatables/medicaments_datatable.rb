#encoding: utf-8
class MedicamentsDatatable
  delegate :logger, :params, :l, :h, :link_to, :edit_medicament_path, :check_box_tag, :content_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Medicament.count,
      iTotalDisplayRecords: medicaments.total_entries,
      aaData: data,
    }
  end

  private

  def data
    medicaments.map do |medicament|
      [
        medicament.id,
        content_tag(:td, check_box_tag("medicament_names[]", medicament.name)),
        medicament.name,
        medicament.classe,
        medicament.forme,
        link_to("<i class='icon-pencil'></i>".html_safe, edit_medicament_path(medicament), class: "btn btn-small") + link_to("<i class='icon-trash'></i>".html_safe, medicament, confirm: "Etes-vous sûr ?", method: :delete, class: "btn btn-small")
      ]
    end
  end

  def medicaments
    @medicaments ||= fetch_medicaments
  end

  def fetch_medicaments
    medicaments = Medicament.order("LOWER(#{sort_column}) #{sort_direction}")
    medicaments = medicaments.page(page).per_page(per_page)
    if params[:sSearch].present?
      medicaments = medicaments.name_contains params[:sSearch]
    end
    medicaments
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(name classe forme)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
