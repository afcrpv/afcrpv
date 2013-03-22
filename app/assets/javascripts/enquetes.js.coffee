$ = jQuery

$ ->
  $("#enquete-show-cas").on "click", ->
    id = $("#enquete_id").val()
    window.location = "/enquetes/#{id}"

  $("#enquete_medicament_list").select2
    multiple: true
    initSelection: (element, callback) ->
      data = []
      data.push({id: name, text: name}) for name in $(element).val().split(", ")
      callback(data)
    ajax:
      url: "/medicaments/liste.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}

  $("#enquete_evenement_list").select2
    multiple: true
    initSelection: (element, callback) ->
      data = []
      data.push({id: name, text: name}) for name in $(element).val().split(", ")
      callback(data)
    ajax:
      url: "/evenements/liste.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}

  $("#document_mots_cle_list").select2
    tags: true
    ajax:
      url: "/documents/tags.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        context: "mots_cles"
        page_limit: 10
      results: (data, page) ->
        return {results: data}
    tokenSeparators: [","]
