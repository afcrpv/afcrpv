#encoding: utf-8
class DossiersDatatable
  delegate :logger, :params, :l, :h, :link_to, :edit_dossier_path, :authorised_dossiers_user?, :content_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Dossier.count,
      iTotalDisplayRecords: dossiers.total_entries,
      aaData: data,
    }
  end

  private

  def data
    dossiers.map do |dossier|
      [
        dossier.code_bnpv,
        dossier.evenement.name,
        dossier.medicaments_list,
        l(dossier.date_recueil),
        link_to("<i class='icon-pencil'></i>".html_safe, edit_dossier_path(dossier), class: "btn btn-small") + (authorised_dossiers_user? ? link_to("<i class='icon-trash'></i>".html_safe, dossier, confirm: "Etes-vous sûr ?", method: :delete, class: "btn btn-small") : "")
      ]
    end
  end

  def dossiers
    @dossiers ||= fetch_dossiers
  end

  def fetch_dossiers
    dossiers = Dossier.order("#{sort_column} #{sort_direction}")
    dossiers = dossiers.includes(:patient, :evenement, :traitements => :medicament).page(page).per_page(per_page)
    if params[:sSearch].present?
      dossiers = dossiers.code_bnpv_or_evenement_or_medicament_contains params[:sSearch]
    end
    dossiers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(code_bnpv evenement_id medicaments_list date_recueil)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
