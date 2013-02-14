#encoding: utf-8
class DocumentsDatatable
  delegate :logger, :params, :l, :h, :link_to, :authorised_documents_user?, :refinery, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Refinery::Documents::Document.count,
      iTotalDisplayRecords: documents.total_entries,
      aaData: data,
      bSortable_4: false,
      bSortable_5: false
    }
  end

private

  def data
    documents.map do |document|
      [
        document.titre,
        h(document.document_category),
        document.mots_cle_list.map {|m| link_to m, refinery.mot_cle_path(m), "data-toggle" => "tooltip", title: (title = "Clickez sur le mot clé pour filtrer par celui-ci")}.join(", "),
        l(document.publication),
        (link_to(document.fichier.file_name, document.fichier.url) rescue ""),
        (authorised_documents_user? ? link_to("<i class='icon-pencil'></i>".html_safe, refinery.edit_documents_document_path(document), class: "btn btn-small") : "")
      ]
    end
  end

  def documents
    @documents ||= fetch_documents
  end

  def fetch_documents
    documents = Refinery::Documents::Document.order("#{sort_column} #{sort_direction}")
    documents = documents.includes(:document_category).page(page).per_page(per_page)
    if params[:sSearch].present?
      documents = documents.where("titre like :search", search: "%#{params[:sSearch]}%")
    else
      documents = documents.recent
    end
    if params[:mot_cle].present?
      logger.debug "MOT CLE= #{params[:mot_cle]}"
      documents = documents.tagged_with(params[:mot_cle])
    end
    documents
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(titre publication)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
