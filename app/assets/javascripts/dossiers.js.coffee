$ = jQuery

$ ->
  # calc imc
  $("#dossier_patient_attributes_#{field}").calculateBMI("#dossier_patient_attributes_imc") for field in ["taille", "poids"]

  $contraception_field = $("#dossier_contraception_ant")
  showNextif $contraception_field.val() is "Oui", $contraception_field, $(".contraception-field")
  $contraception_field.on "change", -> 
    showNextif $(@).val() is "Oui", $(@), $(".contraception-field")

  $concomitants_field = $("#dossier_concomitants")
  showNextif $concomitants_field.val() is "Oui", $concomitants_field, $(".concomitant-field")
  $concomitants_field.on "change", -> 
    showNextif $(@).val() is "Oui", $(@), $(".concomitant-field")

  showNextif $("#dossier_contraception_apres").val() is "reprise", $("#dossier_contraception_apres"), $(".contraception-quoi")
  $("#dossier_contraception_apres").on "change", -> 
    showNextif $(@).val() is "reprise", $(@), $(".contraception-quoi")

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
    $field = $("#dossier_anomalie_hemostase_#{prefix}_anomalie")
    showNextif $field.val() is "Oui", $field, $(".anomalie-hemostase-fields")
    $field.on "change", ->
      showNextif $(@).val() is "Oui", $(@), $(".anomalie-hemostase-fields")

  $(".indication").check_show_indication_autre()
  $("[id$=medicament_id]").check_show_indication()

  $("#traitements").bind 'cocoon:after-insert', ->
    $("[id$=medicament_id]").check_show_indication()
    $(".indication").check_show_indication_autre()

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
