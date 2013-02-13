$ = jQuery

$ ->
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
