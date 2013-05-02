#encoding: utf-8
class DossierPdf < Prawn::Document
  def initialize dossier, view
    super(top_margin: 30)
    @dossier = dossier
    @view = view
    header
    move_down 20
    data = []
    data += info_generales
    data += info_evenement
    font_size(9) do
      table data, position: :center, width: 560 do
        column(0).align = :right
        column(0).font_style = :bold
        column(4).align = :right
        column(4).font_style = :bold
        column(8).align = :right
        column(8).font_style = :bold
        cells.style do |cell|
          cell.borders = [:top, :bottom]
          cell.valign = :center
        end
      end
    end
  end

  def header
    text @dossier.enquete.to_s, size: 14, style: :bold
    move_down 20
    text "N° Dossier BNPV #{@dossier.code_bnpv}"
  end

  def info_generales
    [[{content: "Date recueil :", colspan: 2}, {content: @dossier.date_recueil, colspan: 2}, {content: "Doublon ?", colspan: 2}, {content: @dossier.doublon, colspan: 2}, {content: "Patient :", colspan: 2}, {content: @dossier.patient_data, colspan: 2}]]
  end

  def info_evenement
    [
      [{content: "Evènement :", colspan: 2}, {content: @dossier.evenement.to_s, colspan: 4}, {font_style: :normal, colspan: 6, content: "(#{@dossier.comm_evenement})"}],
      [{content: "Date évènement :", colspan: 2}, {content: @dossier.date_evenement, colspan: 2}, {content: "Gravité :", colspan: 2}, {content: @dossier.gravite, colspan: 2}, {content: "Evolution :", colspan: 2}, {content: @dossier.evolution, colspan: 2}]
    ]
  end

  def incrimines
  end
end
