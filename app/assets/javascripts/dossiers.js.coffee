$ = jQuery

$ ->
  # calc imc
  $("#dossier_patient_attributes_#{field}").calculateBMI("#dossier_patient_attributes_imc") for field in ["taille", "poids"]

  for field in ["contraception_ant", "concomitants"]
    showNextif $("#dossier_#{field}").val() is "Oui", $("#dossier_#{field}"), $(".contraception-field")
    $("#dossier_#{field}").on "change", -> 
      showNextif $(@).val() is "Oui", $(@), $(".contraception-field")

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

  $event_field = $("#dossier_evenement_id")
  $event_condition_veineux = $event_field.val() in ["1", "2", "5"]
  $event_condition_arterieux = $event_field.val() in ["3", "4"]

  #showNextif $event_condition_veineux, $event_field, $(".fdr-veineux")
  #$event_field.on "change", ->
    #showNextif $(@).val() in ["1", "2", "5"], $(@), $(".fdr-veineux")

  #showNextif $event_condition_arterieux, $event_field, $(".fdr-arterieux")
  #$event_field.on "change", ->
    #showNextif $(@).val() in ["3", "4"], $(@), $(".fdr-arterieux")

showNextif = (condition, element, next) ->
  if condition
    $(next).show()
  else
    $(next).hide()
