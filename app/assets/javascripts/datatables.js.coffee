$ = jQuery

$ ->
  gaiSelected = []

  dossiersoTable = $("#dossiers").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    aoColumns: [
      {sWidth: "10%"}
      {sWidth: "25%"}
      {sWidth: "25%", bSortable: false}
      {sWidth: "23%"}
      {sWidth: "10%", bSortable: false}
    ]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#dossiers').data('source')
    fnServerParams: (aoData) ->
      date_recueil_conditions = {}
      for suffix in ["du", "au"]
        date_recueil_conditions["date_recueil_#{suffix}"] = for date_item in ["year", "month", "day"]
          $("#date_recueil_#{suffix}_#{date_item}").val()

      for param, value of date_recueil_conditions
        aoData.push
          name: param
          value: value.join("-")
    oLanguage:
      "sProcessing":     "Traitement en cours..."
      "sSearch":         "Recherche&nbsp;:"
      "sLengthMenu":     "Afficher _MENU_ &eacute;l&eacute;ments"
      "sInfo":           "Affichage du dossier _START_ &agrave; _END_ sur _TOTAL_"
      "sInfoEmpty":      "Affichage du dossier 0 &agrave; 0 sur 0"
      "sInfoFiltered":   "(filtr&eacute; de _MAX_ dossiers au total)"
      "sInfoPostFix":    ""
      "sLoadingRecords": "Chargement en cours..."
      "sZeroRecords":    "Aucun dossier &agrave; afficher"
      "sEmptyTable":     "Aucune donnée disponible dans le tableau"
      "oPaginate":
        "sFirst":      "Premier"
        "sPrevious":   "Pr&eacute;c&eacute;dent"
        "sNext":       "Suivant"
        "sLast":       "Dernier"
      "oAria":
        "sSortAscending":  ": activer pour trier la colonne par ordre croissant"
        "sSortDescending": ": activer pour trier la colonne par ordre décroissant"

  for prefix in ["du", "au"]
    for date_item in ["day", "month", "year"]
      $("#date_recueil_#{prefix}_#{date_item}").on "change", (e) ->
        dossiersoTable.fnFilter($("#date_recueil_dummy").val(), 3)

  $("#dossiers tfoot input").keyup ->
    dossiersoTable.fnFilter(@value, $("tfoot input").index(@))

  evenementsoTable = $("#evenements").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    aoColumns: [
      {bVisible: false}
      {sWidth: "2%", bSortable: false}
      {sWidth: "40%"}
      {sWidth: "40%"}
      {bSortable: false, sWidth: "10%"}
    ]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#evenements').data('source')
    fnRowCallback: (nRow, aData, iDisplayIndex) ->
      checkbox_value = $(nRow).find("input").attr("value")
      condition = checkbox_value in $.map(gaiSelected, (val, i) -> $(val).val())
      $(nRow).addClass("success").find("input").attr("checked", true) if condition
      return nRow
    oLanguage:
      "sProcessing":     "Traitement en cours..."
      "sSearch":         "Rechercher&nbsp;:"
      "sLengthMenu":     "Afficher _MENU_ &eacute;l&eacute;ments"
      "sInfo":           "Affichage de l'évènement _START_ &agrave; _END_ sur _TOTAL_"
      "sInfoEmpty":      "Affichage de l'évènement 0 &agrave; 0 sur 0"
      "sInfoFiltered":   "(filtr&eacute; de _MAX_ évènements au total)"
      "sInfoPostFix":    ""
      "sLoadingRecords": "Chargement en cours..."
      "sZeroRecords":    "Aucun évènement &agrave; afficher"
      "sEmptyTable":     "Aucune donnée disponible dans le tableau"
      "oPaginate":
        "sFirst":      "Premier"
        "sPrevious":   "Pr&eacute;c&eacute;dent"
        "sNext":       "Suivant"
        "sLast":       "Dernier"
      "oAria":
        "sSortAscending":  ": activer pour trier la colonne par ordre croissant"
        "sSortDescending": ": activer pour trier la colonne par ordre décroissant"

  $("#evenements tbody").on "click", "tr", ->
    checkbox = $(@).find("input")[0]

    if checkbox not in gaiSelected
      checkbox = $(@).find("input").attr("checked", true)[0]
      gaiSelected.push checkbox
    else
      checkbox = $(@).find("input")[0]
      gaiSelected = $.grep gaiSelected, (value) -> value isnt checkbox
      $(@).find("input").attr("checked", false)

    $(@).toggleClass("success")
    console.log gaiSelected

  $("#evenements-form").on "submit", (e) ->
    if gaiSelected.length
      for item in gaiSelected
        $(item).appendTo($("#evenements-checkboxes"))
    else
      e.preventDefault()
      alert "Vous n'avez sélectionné aucun évènement !"
      return false

  medicamentsoTable = $("#medicaments").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    aoColumns: [
      {bVisible: false}
      {sWidth: "2%", bSortable: false}
      {sWidth: "40%"}
      null
      null
      {bSortable: false, sWidth: "10%"}
    ]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#medicaments').data('source')
    fnRowCallback: (nRow, aData, iDisplayIndex) ->
      checkbox_value = $(nRow).find("input").attr("value")
      condition = checkbox_value in $.map(gaiSelected, (val, i) -> $(val).val())
      $(nRow).addClass("success").find("input").attr("checked", true) if condition
      return nRow
    oLanguage:
      "sProcessing":     "Traitement en cours..."
      "sSearch":         "Rechercher&nbsp;:"
      "sLengthMenu":     "Afficher _MENU_ &eacute;l&eacute;ments"
      "sInfo":           "Affichage du médicament _START_ &agrave; _END_ sur _TOTAL_ médicaments"
      "sInfoEmpty":      "Affichage du médicament 0 &agrave; 0 sur 0 médicaments"
      "sInfoFiltered":   "(filtr&eacute; de _MAX_ médicaments au total)"
      "sInfoPostFix":    ""
      "sLoadingRecords": "Chargement en cours..."
      "sZeroRecords":    "Aucun médicament &agrave; afficher"
      "sEmptyTable":     "Aucune donnée disponible dans le tableau"
      "oPaginate":
        "sFirst":      "Premier"
        "sPrevious":   "Pr&eacute;c&eacute;dent"
        "sNext":       "Suivant"
        "sLast":       "Dernier"
      "oAria":
        "sSortAscending":  ": activer pour trier la colonne par ordre croissant"
        "sSortDescending": ": activer pour trier la colonne par ordre décroissant"

  $("#medicaments tbody").on "click", "tr", ->
    checkbox = $(@).find("input")[0]

    if checkbox not in gaiSelected
      checkbox = $(@).find("input").attr("checked", true)[0]
      gaiSelected.push checkbox
    else
      checkbox = $(@).find("input")[0]
      gaiSelected = $.grep gaiSelected, (value) -> value isnt checkbox
      $(@).find("input").attr("checked", false)

    $(@).toggleClass("success")
    console.log gaiSelected

  $("#medicaments-form").on "submit", (e) ->
    if gaiSelected.length
      for item in gaiSelected
        $(item).appendTo($("#medicaments-checkboxes"))
    else
      e.preventDefault()
      alert "Vous n'avez sélectionné aucun médicament !"
      return false

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
      state_param = getURLParam('state')
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

  for field in ["#search_tag", "#search_tag_condition"]
    $(field).on "change", (e) ->
      documentsoTable.fnFilter($("#search_tag").val(), 2)

  $("#documents tfoot input").keyup ->
    documentsoTable.fnFilter(@value, $("tfoot input").index(@))


  $("#documents").on 'hover', ->
    $("[data-toggle='tooltip']").tooltip()
