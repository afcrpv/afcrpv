#encoding: utf-8
class ProjetsDatatable
  delegate :logger, :params, :l, :h, :link_to, :refinery, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Refinery::Projets::Projet.count,
      iTotalDisplayRecords: projets.total_entries,
      aaData: data,
    }
  end

private

  def data
    projets.map do |projet|
      [
        projet.titre,
        h(projet.crpv),
        projet.responsable_with_email,
        l(projet.created_at.to_date)
      ]
    end
  end

  def projets
    @projets ||= fetch_projets
  end

  def fetch_projets
    projets = Refinery::Projets::Projet.order("#{sort_column} #{sort_direction}")
    projets = projets.includes(:crpv).page(page).per_page(per_page)
    if params[:sSearch].present?
      projets = projets.titre_contains params[:sSearch]
    else
      projets = projets.latest
    end
    if params[:state].present?
      projets = projets.termines
    else
      projets = projets.en_cours
    end
    projets
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(titre crpv responsable created_at)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
