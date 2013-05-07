#encoding: utf-8
class EnquetePdf < Prawn::Document
  def initialize enquete, view, dossiers
    super(top_margin: 20)
    @enquete = enquete
    @view = view
    @dossiers = dossiers
    header
    move_down 10
    dossiers_table
  end

  def header
    text "#{@enquete.description}"
  end

  def dossiers_table
    data = []
    data << ["N° BNPV", "Evènement", "Médicament(s)", "Date recueil"]
    @dossiers.each do |dossier|
      data << [dossier.code_bnpv, dossier.evenement.name, dossier.medicaments_list, I18n.l(dossier.date_recueil)]
    end

    font_size 10 do
      table data, header: true, width: 580, position: :center, column_widths: {0 => 70, 1 => 240, 3 => 70} do
        cells.style do |cell|
          cell.border_width = 0
          cell.valign = :center
        end
        row(0).borders = [:bottom]
        row(0).border_width = 2
        row(0).font_style = :bold
      end
    end
  end
end
