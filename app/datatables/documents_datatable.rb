#encoding: utf-8
class DocumentsDatatable
  delegate :params, :l, :h, :link_to, :authorised_documents_user?, :refinery, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Refinery::Documents::Document.count,
      iTotalDisplayRecords: documents.total_entries,
      aaData: data
    }
  end

private

  def data
    documents.map do |document|
      [
        document.titre,
        h(document.document_category),
        document.mots_cle_list,
        l(document.publication),
        (link_to(document.fichier.file_name, document.fichier.url) rescue ""),
        (authorised_documents_user? ? link_to("<i class='icon-pencil'></i>".html_safe, refinery.edit_documents_document_path(document), class: "btn") : "")
      ]
    end
  end

  def documents
    @documents ||= fetch_documents
  end

  def fetch_documents
    documents = Refinery::Documents::Document.order("#{sort_column} #{sort_direction}")
    documents = documents.page(page).per_page(per_page)
    if params[:sSearch].present?
      documents = documents.includes(:document_category).where("titre like :search", search: "%#{params[:sSearch]}%")
    else
      documents = documents.recent
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
