$ ->
  return unless $('body').hasClass('authentication')

  init = ->
    if $('body').hasClass('index')
      localStorage.clear()

    validation()


  bindEvent = ->
    $('#name').on 'input', (e) ->
      validation()


  validation = ->
    target = $('#name')
    str = target.val().toLowerCase()
    str = zenkaku2hankaku(str)
    str = str.replace(/[^a-z0-9]/, '') while str.match(/[^a-z0-9]/)
    target.val(str)


  zenkaku2hankaku = (str) ->
    str.replace /[Ａ-Ｚａ-ｚ０-９]/g, (s) ->
      String.fromCharCode(s.charCodeAt(0) - 0xFEE0)


  init()
