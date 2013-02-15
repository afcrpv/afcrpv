jQuery = $

$ ->
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
