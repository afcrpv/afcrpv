$ = jQuery

$ ->
  # calc imc
  $("#dossier_patient_attributes_#{field}").calculateBMI("#dossier_patient_attributes_imc") for field in ["taille", "poids"]

  # coherence obesite/imc
  $obesite_hint = $(".dossier_obesite p")
  $obesite_field = $("#dossier_obesite")
  imc = $("#dossier_patient_attributes_imc").val()
  condition_obesite = ($obesite_field.val() is "Oui" and imc < 30) or ($obesite_field.val() is "Non" and imc > 29)
  showNextif condition_obesite, $obesite_field, $obesite_hint

  $("#dossier_patient_attributes_imc").on "change", ->
    $obesite_hint = $(".dossier_obesite p")
    obesite = $("#dossier_obesite").val()
    imc = $("#dossier_patient_attributes_imc").val()
    condition_obesite = (obesite is "Oui" and imc < 30) or (obesite is "Non" and imc > 29)
    showNextif condition_obesite, $(@), $obesite_hint

  $obesite_field.on "change", ->
    $obesite_hint = $(".dossier_obesite p")
    imc = $("#dossier_patient_attributes_imc").val()
    condition_obesite = ($(@).val() is "Oui" and imc < 30) or ($(@).val() is "Non" and imc > 29)
    showNextif condition_obesite, $(@), $obesite_hint

  $contraception_field = $("#dossier_contraception_ant")
  showNextif $contraception_field.val() is "Oui", $contraception_field, $(".contraception-field")
  $contraception_field.on "change", -> 
    showNextif $(@).val() is "Oui", $(@), $(".contraception-field")

  $concomitants_field = $("#dossier_concomitants_pres")
  showNextif $concomitants_field.val() is "Oui", $concomitants_field, $(".concomitant-field")
  $concomitants_field.on "change", -> 
    showNextif $(@).val() is "Oui", $(@), $(".concomitant-field")

  showNextif $("#dossier_contraception_apres").val() is "Oui", $("#dossier_contraception_apres"), $(".contraception-quoi")
  $("#dossier_contraception_apres").on "change", -> 
    showNextif $(@).val() is "Oui", $(@), $(".contraception-quoi")

  $tabac = $("#dossier_tabac")
  showNextif $tabac.val() in ["oui", "sevré"], $tabac, $tabac.parents(".control-group").next()
  $tabac.on "change", ->
    showNextif $(@).val() in ["oui", "sevré"], $(@), $(@).parents(".control-group").next()

  for name in ["thrombose_perso", "thrombose_fam", "cv_perso", "cv_fam", "autoimmune", "cancer","dyslipidemie", "illicites", "autres_cv"]
    $field = $("#dossier_#{name}")
    showNextif $field.val() is "Oui", $field, $field.parents(".control-group").next()
    $field.on "change", ->
      showNextif $(@).val() is "Oui", $(@), $(@).parents(".control-group").next()

  for prefix in ["perso", "fam"]
    $bilan_field = $("#dossier_anomalie_hemostase_#{prefix}_bilan")
    $bilan_field.check_show_anomalie_hemostase("bilan")
    $anomalie_field = $("#dossier_anomalie_hemostase_#{prefix}_anomalie")
    $anomalie_field.check_show_anomalie_hemostase("anomalie")

  $("[id$=duree_comp]").check_show_duree_traitement()

  $("[id$=medicament_id]").check_show_indication()
  $(".indication").check_show_indication_autre()

  $(".traitements").bind 'cocoon:after-insert', ->
    $("[id$=duree_comp]").check_show_duree_traitement()
    $("[id$=medicament_id]").check_show_indication()
    $(".indication").check_show_indication_autre()

$.fn.check_show_duree_traitement = ->
  @each ->
    $select = $(this)
    condition = $select.val() isnt "NSP"
    $next = $select.nextAll(".duree-traitement")
    showNextif condition, $select, $next

    $select.on "change", ->
      $this = $(@)
      condition = $this.val() isnt "NSP"
      $next = $this.nextAll(".duree-traitement")
      showNextif condition, $this, $next

$.fn.check_show_anomalie_hemostase = (field) ->
  $select = $(this)
  $next = $($select.parents(".control-group").next())
  if field is "bilan"
    condition = $select.val() in ["avant", "après"]
    unless condition
      $select.parents(".control-group").next().find("select").val("")
      $select.parents(".control-group").next().find("select").trigger("change")
      $select.parents(".control-group").nextAll(".anomalie-hemostase-fields").find("select,input").each ->
        $(@).val("")
  else
    condition = $select.val() is "Oui"

  showNextif condition, $select, $next

  $select.on "change", ->
    $select = $(@)
    $next = $($select.parents(".control-group").next())
    if field is "bilan"
      condition = $select.val() in ["avant", "après"]
      unless condition
        $select.parents(".control-group").next().find("select").val("")
        $select.parents(".control-group").next().find("select").trigger("change")
        $select.parents(".control-group").nextAll(".anomalie-hemostase-fields").find("select,input").each ->
          $(@).val("")
    else
      condition = $select.val() is "Oui"

    showNextif condition, $select, $next

$.fn.check_show_indication = ->
  @each ->
    $select = $(this)
    $next = $($select.next(".indication"))
    condition = /cyprotérone|diane|androcur/.test($select.find("option:selected").text())
    showNextif condition, $select, $next

    $select.on "change", ->
      condition = /cyprotérone|diane|androcur/.test($(@).find("option:selected").text())
      $next = $(@).next(".indication")
      showNextif condition, $(@), $next

$.fn.check_show_indication_autre = ->
  @each ->
    $select = $(this)
    $next = $($select.next(".indication-quoi"))
    condition = $select.find("option:selected").text() is "autre"
    showNextif condition, $select, $next

    $select.on "change", ->
      condition = $(@).find("option:selected").text() is "autre"
      $next = $(@).next(".indication-quoi")
      showNextif condition, $(@), $next

showNextif = (condition, element, next) ->
  if condition
    $(next).show()
    $(next).css("visibility", "visible")
  else
    $(next).hide()
    $(next).css("visibility", "hidden")
