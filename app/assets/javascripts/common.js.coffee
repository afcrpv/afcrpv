$ = jQuery

$.extend true, $.fn.dataTable.defaults, ->
  sDom: "<'row-fluid'<'span6'l><'span6'T>r>t<'row-fluid'<'span6'i><'span6'p>>",
  sPaginationType: "bootstrap",

$ ->
  $.fn.select2.defaults.allowClear = true
  $.fn.select2.defaults.formatNoMatches = -> "Aucun résultat"
  $.fn.select2.defaults.formatInputTooShort = (input, min) -> "Saisir au moins #{min - input.length} charactères"
  $.fn.select2.defaults.formatSearching = -> "Recherche en cours..."


  $("a[data-toggle='tooltip']").tooltip()

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

window.getURLParam = (sParam) ->
  sPageUrl = window.location.search.substring(1)
  if sPageUrl
    console.log sPageUrl
    sURLVars = sPageUrl.split('&')
    for i in [0..sURLVars.length]
      sParamName = sURLVars[i].split('=')
      return sParamName[1] if sParamName[0] is sParam
