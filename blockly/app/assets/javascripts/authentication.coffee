$ ->
  return unless $('body').hasClass('authentication')

  if $('body').hasClass('index')
    localStorage.clear()

    $('#name').on 'input', (e) ->
      str = $(e.target).val()

      while str.match(/[^A-Z^a-z\d\-]/)
        str = str.replace(/[^A-Z^a-z\d\-]/,"")

      $(e.target).val(str)
