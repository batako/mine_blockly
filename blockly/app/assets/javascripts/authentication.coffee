$ ->
  return unless $('body').hasClass('authentication')

  if $('body').hasClass('index')
    localStorage.clear()

    $('#name').on 'input', (e) ->
      str = $(e.target).val().toLowerCase()

      while str.match(/[^a-z0-9]/)
        str = str.replace(/[^a-z0-9]/, '')

      $(e.target).val(str)
