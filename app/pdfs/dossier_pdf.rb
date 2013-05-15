#encoding: utf-8
class DossierPdf < Prawn::Document
  def initialize dossier, view
    super(top_margin: 30)
    @dossier = dossier
    @view = view
    header
    move_down 10
    font_size 10 do
      data = info_generales
      data += info_patient
      data += evenement
      table data, position: :center, width: 564, column_widths: {0 => 93, 1 => 68, 2 => 60, 4 => 62} do
        cells.style do |cell|
          cell.border_width = 0
          cell.valign = :center
          if cell.column.even?
            cell.align = :right
            cell.font_style = :bold
          end
        end
      end
    end
    incrimines
    contraceptions
    concomitants
    contraception_apres_evenement
    fdr
    commentaire
  end

  def header
    text @dossier.enquete.to_s, size: 14, style: :bold
    move_down 20
    text "N° Dossier BNPV #{@dossier.code_bnpv}"
  end

  def info_generales
    [["Date recueil :", @dossier.date_recueil, "", "", "Doublon ?", @dossier.doublon]]
  end

  def info_patient
    [["Patient :", {content: @dossier.patient_data, colspan: 5}]]
  end

  def evenement
    [
      ["Evènement :", {content: @dossier.evenement, colspan: 5}],
      ["Date évènement :", @dossier.date_evenement, "Gravité :", @dossier.gravite, "Evolution :", @dossier.evolution]
    ]
  end

  def incrimines
    data = []
    @dossier.incrimines.each do |inc|
      data << [{content: inc.medicament.to_s.titleize, colspan: 5}, {content: inc.full_indication, colspan: 4}, {content: inc.duree_ttt, colspan: 3}]
    end
    move_down 20
    text "Médicaments en cause", size: 10, style: :bold
    font_size(10) do
      table data, position: :center, width: 560 do
        cells.style do |cell|
          cell.borders = [:top, :bottom]
          cell.valign = :center
        end
      end
    end
  end

  def contraceptions
    if @dossier.contraception_ant == "Oui"
      data = []
      @dossier.contraceptions.each do |cont|
        data << [{content: cont.medicament.to_s.titleize, colspan: 5}, {content: "", colspan: 4}, {content: cont.duree_ttt, colspan: 3}]
      end
      move_down 20
      text "Contraception(s) antérieure(s) #{@dossier.age_1ere_contraception}", size: 10, style: :bold

      font_size(10) do
        table data, position: :center, width: 560 do
          cells.style do |cell|
            cell.borders = [:top, :bottom]
            cell.valign = :center
          end
        end
      end
    end
  end

  def concomitants
    if @dossier.concomitants_pres == "Oui"
      data = []
      @dossier.concomitants.each do |conc|
        data << [{content: conc.libelle.titleize, colspan: 5}, {content: "", colspan: 4}, {content: conc.duree_ttt, colspan: 3}]
      end
      move_down 20
      text "Autres médicaments en cours au moment de l'évènement", size: 10, style: :bold

      font_size(10) do
        table data, position: :center, width: 560 do
          cells.style do |cell|
            cell.borders = [:top, :bottom]
            cell.valign = :center
          end
        end
      end
    end
  end

  def contraception_apres_evenement
    move_down 20
    text "Contraception après l'évènement", size: 10, style: :bold
    data = [
      ["Contre-indication : ", @dossier.contraception_ci(false), "Reprise d'une contraception : ", @dossier.contraception_apres(false)]
    ]
    font_size(10) do
      table data, position: :center, width: 560 do
        cells.style do |cell|
          cell.borders = [:top, :bottom]
          cell.valign = :center
          if cell.column.even?
            cell.align = :right
            cell.font_style = :bold
          end
        end
      end
    end
  end

  def fdr
    move_down 20
    text "Facteurs de risque", size: 10, style: :bold
    liste_fdr = [
      {label: "Communs", value: @dossier.fdr_communs},
      {label: "Veineux", value: @dossier.fdr_veineux},
      {label: "Artériels", value: @dossier.fdr_arteriels},
    ]
    data = []
    liste_fdr.each do |item|
      data << [item[:label] + " :", {content: item[:value], colspan: 5}]
    end
    font_size(10) do
      table data, position: :center, width: 560 do
        cells.style do |cell|
          cell.borders = [:top, :bottom]
          cell.valign = :center
          if cell.column.even?
            cell.align = :right
            cell.font_style = :bold
          end
        end
      end
    end
  end

  def commentaire
    font_size 10 do
      move_down 20
      text "Commentaire", style: :bold
      move_down 10
      text @dossier.commentaire(false)
    end
  end
end
