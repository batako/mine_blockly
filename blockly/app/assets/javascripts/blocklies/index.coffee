$(window).on 'load', ->
  return unless $("body").hasClass("blocklies") && $("body").hasClass("index")

  init = ->
    fitDashboard()


  openSideNav = ->
    $("#navbar_side").addClass("reveal")
    $("#overlay").show()


  closeSideNav = ->
    $("#navbar_side").removeClass("reveal")
    $("#overlay").hide()


  openDashboard = ->
    $("#dashboard_wrap #overlay").show()
    $("#dashboard_wrap #dashboard").addClass("open")


  closeDashboad = ->
    $("#dashboard_wrap #overlay").hide()
    $("#dashboard_wrap #dashboard").removeClass("open")


  isOpenedDashboad = ->
    $("#dashboard_wrap #overlay").is(':visible')


  fitWorkspaces = ->
    $("#workspaces").css(
      height: parseInt($("#dashboard_wrap #dashboard").height()) \
                - parseInt($("#workspace_form").height())
    )


  fitDashboard = ->
    $("#dashboard_wrap #dashboard").css(
      height: $(window).height() \
                - $("#header").height() \
                - $("#workspace_header").height()
    )

    setTimeout ->
      fitWorkspaces()
    , 500


  removeIndexClassOfDashboard = ->
    $('#dashboard').removeClass('mine')
    $('#dashboard').removeClass('share')


  $("#navbar_sideButton").on "click", ->
    openSideNav()


  $("#overlay").on "click", ->
    closeSideNav()


  $(window).on "resize", ->
    fitDashboard()


  $("#dashboard_wrap #overlay").on "click", ->
    removeIndexClassOfDashboard()
    closeDashboad()


  $("#dashboard_wrap #indexMine, #dashboard_wrap #indexShare").on "click", ->
    removeIndexClassOfDashboard()

    if isOpenedDashboad() && $('#dashboard').data('index-type') == $(this).data('index-type')
      closeDashboad()
    else
      $('#dashboard').addClass(
        $(this).data('index-type')
      ).data('index-type', $(this).data('index-type'))
      openDashboard()


  init()
