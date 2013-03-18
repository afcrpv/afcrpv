$ = jQuery

$ ->
  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} charactères"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."

  projetsoTable = $("#projets").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    aaSorting: [[3, "desc"]]
    aoColumns: [
      {sWidth: "40%"}
      {bSortable: false}
      {bSortable: false}
      {sWidth: "10%"}
    ]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#projets').data('source')
    fnServerParams: (aoData) ->
      state_param = GetURLParam('state')
      if state_param
        aoData.push
          name: "state"
          value: state_param
    oLanguage:
      "sProcessing":     "Traitement en cours..."
      "sSearch":         "Rechercher&nbsp;:"
      "sLengthMenu":     "Afficher _MENU_ &eacute;l&eacute;ments"
      "sInfo":           "Affichage du projet _START_ &agrave; _END_ sur _TOTAL_ projets"
      "sInfoEmpty":      "Affichage du projet 0 &agrave; 0 sur 0 projets"
      "sInfoFiltered":   "(filtr&eacute; de _MAX_ projets au total)"
      "sInfoPostFix":    ""
      "sLoadingRecords": "Chargement en cours..."
      "sZeroRecords":    "Aucun projet &agrave; afficher"
      "sEmptyTable":     "Aucune donnée disponible dans le tableau"
      "oPaginate":
        "sFirst":      "Premier"
        "sPrevious":   "Pr&eacute;c&eacute;dent"
        "sNext":       "Suivant"
        "sLast":       "Dernier"
      "oAria":
        "sSortAscending":  ": activer pour trier la colonne par ordre croissant"
        "sSortDescending": ": activer pour trier la colonne par ordre décroissant"

  documentsoTable = $("#documents").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    aaSorting: [[3, "desc"]]
    aoColumns: [
      {sWidth: "35%"}
      null
      {bSortable: false}
      {sWidth: "10%"}
      {bSortable: false}
      {bSortable: false}
    ]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#documents').data('source')
    fnServerParams: (aoData) ->
      path_array = window.location.pathname.toString().substr(1).split("/")
      tags_condition = $("#search_tag_condition").val()
      if tags_condition
        aoData.push
          name: "tags_condition"
          value: tags_condition
      if path_array.length > 1
        mot_cle = path_array.pop()
        aoData.push
          name: "mot_cle"
          value: mot_cle
    oLanguage:
      "sProcessing":     "Traitement en cours..."
      "sSearch":         "Rechercher&nbsp;:"
      "sLengthMenu":     "Afficher _MENU_ &eacute;l&eacute;ments"
      "sInfo":           "Affichage du document _START_ &agrave; _END_ sur _TOTAL_ documents"
      "sInfoEmpty":      "Affichage du document 0 &agrave; 0 sur 0 documents"
      "sInfoFiltered":   "(filtr&eacute; de _MAX_ documents au total)"
      "sInfoPostFix":    ""
      "sLoadingRecords": "Chargement en cours..."
      "sZeroRecords":    "Aucun document &agrave; afficher"
      "sEmptyTable":     "Aucune donnée disponible dans le tableau"
      "oPaginate":
        "sFirst":      "Premier"
        "sPrevious":   "Pr&eacute;c&eacute;dent"
        "sNext":       "Suivant"
        "sLast":       "Dernier"
      "oAria":
        "sSortAscending":  ": activer pour trier la colonne par ordre croissant"
        "sSortDescending": ": activer pour trier la colonne par ordre décroissant"

  $("#search_document_category_name").select2
    minimumInputLength: 2
    ajax:
      url: "/documents/categories.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        page_limit: 10
      results: (data, page) ->
        return {results: data}
  $("#search_document_category_name").on "change", (e) ->
    documentsoTable.fnFilter($(@).val(), 1)

  $("#search_tag").select2
    minimumInputLength: 2
    multiple: true
    ajax:
      url: "/tags.json"
      dataType: "json"
      data: (term, page) ->
        q: term
        context: "mots_cles"
        page_limit: 10
      results: (data, page) ->
        return {results: data}

  $("#type_enquete_evenement_list").select2
    multiple: true
    ajax:
      url: "/evenements.json"
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

  for field in ["#search_tag", "#search_tag_condition"]
    $(field).on "change", (e) ->
      documentsoTable.fnFilter($("#search_tag").val(), 2)

  $("tfoot input").keyup ->
    documentsoTable.fnFilter(@value, $("tfoot input").index(@))

  $("#documents").on 'hover', ->
    $("[data-toggle='tooltip']").tooltip()
  $("a[href='#top']").click (e) ->
    e.preventDefault()
    $("html, body").animate
      scrollTop: 0
      , "fast"

  $(".navbar-search").on "mouseenter", ->
    $(this).find(".btn").animate
      borderTopLeftRadius: 0
      borderTopRightRadius: 14
      borderBottomLeftRadius: 0
      borderBottomRightRadius: 14
      , 400
    $(this).find(".search-query").animate
      padding: '4px 14px'
      width: '210px'
      opacity: "1"
      , 200

  $(".navbar-search").on "mouseleave", ->
    $(this).find(".btn").animate
      borderTopLeftRadius: 14
      borderTopRightRadius: 14
      borderBottomLeftRadius: 14
      borderBottomRightRadius: 14
      , 400
    $(this).find(".search-query").animate
      padding: '4px 0'
      width: '0'
      opacity: "0"
      , 400

GetURLParam = (sParam) ->
  sPageUrl = window.location.search.substring(1)
  if sPageUrl
    console.log sPageUrl
    sURLVars = sPageUrl.split('&')
    for i in [0..sURLVars.length]
      sParamName = sURLVars[i].split('=')
      return sParamName[1] if sParamName[0] is sParam
