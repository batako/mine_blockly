$ ->
  return unless $("body").hasClass("blocklies") && $("body").hasClass("index")


  openSideNav = ->
    $("#navbarSide").addClass("reveal")
    $("#overlay").show()


  closeSideNav = ->
    $('#navbarSide').removeClass("reveal")
    $("#overlay").hide()


  $("#navbarSideButton").on "click", ->
    openSideNav()


  $("#overlay").on "click", ->
    closeSideNav()
