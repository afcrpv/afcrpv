$ = jQuery

$ ->
  $("a[href='#top']").click ->
    $("html, body").animate
      scrollTop: 0
      , "slow"
  $(".navbar-search").on "mouseenter", ->
    $(this).find(".search-query").animate
      padding: '4px 14px'
      width: '210px'
      opacity: "1"
      , 200
  $(".navbar-search").on "mouseleave", ->
    $(this).find(".search-query").animate
      padding: '4px 0'
      width: '0'
      opacity: "0"
      , 400
