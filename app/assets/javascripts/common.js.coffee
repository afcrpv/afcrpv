$ = jQuery

$ ->
  $("#documents").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#documents').data('source')
    fnServerParams: (aoData) ->
      path_array = window.location.pathname.toString().substr(1).split("/")
      if path_array.length > 1
        mot_cle = path_array.pop()
        aoData.push
          name: "mot_cle"
          value: mot_cle
    oLanguage:
      "sProcessing":     "Traitement en cours..."
      "sSearch":         "Rechercher dans le titre&nbsp;:"
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

  $('[data-toggle="tooltip"]').tooltip()
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
