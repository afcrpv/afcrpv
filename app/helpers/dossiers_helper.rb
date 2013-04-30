module DossiersHelper
  def row_fdr_for(dossier, fields)
    if fields.to_ary.any? { |f| dossier.send(f) }
      content_tag :div, column_fdr_for(dossier, fields), class: "row"
    end
  end

  private

  def column_fdr_for(dossier, fields)
    count = fields.map {|f| dossier.send(f)}.compact.count
    css_class = "span#{12/count}"
    html = []
    fields.to_ary.each_with_index do |field, i|
      html << capture { column_fdr_for_single_field(dossier, field, css_class)} if dossier.send(field).present?
    end
    html.join("\n").html_safe
  end

  def column_fdr_for_single_field(dossier, field, css_class="span6")
    content_tag(:div, class: css_class) do
      content_tag(:span, Dossier.human_attribute_name(field), class: "libelle") + dossier.send(field)
    end
  end
end
