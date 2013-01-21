jQuery = $

$ ->
  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} charactère"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."
  $("#dep").select2
    placeholder: "Choisir un département"
    minimumInputLength: 1
    ajax:
      url: "/departements.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}
