$ ->
  return unless $("body").hasClass("blocklies") && $("body").hasClass("index")


  openSideNav = ->
    $("#navbarSide").addClass("reveal")
    $("#overlay").show()


  closeSideNav = ->
    $("#navbarSide").removeClass("reveal")
    $("#overlay").hide()


  openDashboard = ->
    $("#dashboard-wrap #overlay").show()
    $("#dashboard-wrap #dashboard").addClass("open")


  closeDashboad = ->
    $("#dashboard-wrap #overlay").hide()
    $("#dashboard-wrap #dashboard").removeClass("open")


  isOpenedDashboad = ->
    $("#dashboard-wrap #overlay").is(':visible')


  fitWorkspaces = ->
    $("#workspaces").css(
      height: $("#dashboard").height() - $("#workspaceForm").height()
    )


  fitDashboard = ->
    $("#dashboard-wrap #dashboard").css(
      height: $(window).height() \
                - $("#header").height() \
                - $("#workspace-header").height()
    )

    fitWorkspaces()


  $("#navbarSideButton").on "click", ->
    openSideNav()


  $("#overlay").on "click", ->
    closeSideNav()


  $(window).on "load resize", ->
    fitDashboard()


  $("#dashboard-wrap #overlay").on "click", ->
    closeDashboad()


  $("#dashboard-wrap #index").on "click", ->
    if isOpenedDashboad()
      closeDashboad()
    else
      openDashboard()
