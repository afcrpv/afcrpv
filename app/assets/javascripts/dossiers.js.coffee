$ = jQuery

$ ->
  # calc imc
  $("#dossier_patient_attributes_#{field}").calculateBMI("#dossier_patient_attributes_imc") for field in ["taille", "poids"]


  showNextif $("#dossier_contraception_ant").val() is "Oui", $("#dossier_contraception_ant"), $(".contraception-field")
  $("#dossier_contraception_ant").on "change", -> 
    console.log @
    showNextif $(@).val() is "Oui", $(@), $(".contraception-field")

showNextif = (condition, element, next) ->
  if condition then $(next).show() else $(next).hide()
