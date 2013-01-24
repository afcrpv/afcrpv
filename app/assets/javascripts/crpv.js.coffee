jQuery = $

$ ->
  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} charactères"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."
  $("#dep").select2
    placeholder: "Choisir un département par son code ou son nom"
    minimumInputLength: 2
    ajax:
      url: "/departements.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      matcher: (term, text) ->
        text.toUpperCase().indexOf(term.toUpperCase()) >= 0
      results: (data, page) ->
        return {results: data}
  $("#dep").on "change", (e) ->
    $("#chosen_crpv_link").html("")
    $(@).parent().submit() if e.val
