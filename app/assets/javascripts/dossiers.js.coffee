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

  for name in ["thrombose_perso", "thrombose_fam", "cv_perso", "cv_fam", "autoimmune", "cancer", "anomalie_hemostase_perso_anomalie", "anomalie_hemostase_fam_anomalie", "dyslipidemie", "illicites", "autres_cv"]
    $field = $("#dossier_#{name}")
    showNextif $field.val() is "Oui", $field, $field.parents(".control-group").next()
    $field.on "change", ->
      showNextif $(@).val() is "Oui", $(@), $(@).parents(".control-group").next()

showNextif = (condition, element, next) ->
  if condition
    $(next).show()
  else
    $(next).hide()
