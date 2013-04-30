#encoding: utf-8
class DossierPdf < Prawn::Document
  def initialize dossier, view
    super(top_margin: 30)
    @dossier = dossier
    @view = view
    header
    move_down 20
    data_for_table = []
    data_for_table += info_generales
    data_for_table += info_patient
    table data_for_table, position: :center do
      cells.style do |cell|
        cell.font_style = :bold if cell.column.even?
      end
    end
  end

  def header
    text @dossier.enquete.to_s, size: 14, style: :bold
  end

  def info_generales
    [
      ["N° BNPV", @dossier.code_bnpv, "Date recueil", @dossier.date_recueil, "Doublon ?", @dossier.doublon, "", ""]
    ]
  end

  def info_patient
    [ [{content: "Patient", colspan: 8}],
      ["Age", @dossier.age, "Poids", @dossier.poids, "Taille", @dossier.taille, "IMC", @dossier.imc]
    ]
  end
end
