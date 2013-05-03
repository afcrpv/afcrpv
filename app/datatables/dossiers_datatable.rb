#encoding: utf-8
class DossiersDatatable
  delegate :logger, :params, :l, :h, :link_to, :dossier_path, :edit_dossier_path, :authorised_enquetes_user?, :current_refinery_user, :content_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_records(options={})
    dossiers
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Dossier.count,
      iTotalDisplayRecords: dossiers.count,
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
        link_to(content_tag(:i, nil, class: "icon-print"), dossier_path(dossier), data: {target: "#dossier_modal", toggle: "modal", dossier_code: dossier.code_bnpv, edit_url: edit_dossier_path(dossier), print_url: dossier_path(dossier, format: :pdf)}, class: "btn btn-small", title: "Imprimer le dossier") + link_to("<i class='icon-pencil'></i>".html_safe, edit_dossier_path(dossier), class: "btn btn-small") + (authorised_enquetes_user? ? link_to("<i class='icon-trash'></i>".html_safe, dossier, confirm: "Etes-vous sûr ?", method: :delete, class: "btn btn-small") : "")
      ]
    end
  end

  def dossiers
    @dossiers ||= fetch_dossiers
  end

  def fetch_dossiers
    dossiers = Dossier.order("#{sort_column} #{sort_direction}")
    dossiers = dossiers.includes(:patient, :evenement, :incrimines => :medicament)
    dossiers = dossiers.where{refinery_crpv_id == my{current_refinery_user.refinery_crpv_id}} unless authorised_enquetes_user?
    if params[:sSearch_1].present?#dossiers.evenement.name
      dossiers = dossiers.joins{evenement}.where{evenement.name =~ my{"%#{params[:sSearch_1]}%"}}
    elsif params[:sSearch_2].present?#dossiers.incrimines.medicament.name
      dossiers = dossiers.joins{incrimines.medicament}.where{incrimines.medicament.name == my{params[:sSearch_2]}}
    #elsif params[:date_recueil_au].present? && params[:date_recueil_du].present?#dossiers.date_recueil
      #dossiers = dossiers.where{(date_recueil <= my{params[:date_recueil_au]}) & (date_recueil >= my{params[:date_recueil_du]})}
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
