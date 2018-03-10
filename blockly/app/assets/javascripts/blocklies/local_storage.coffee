$ ->
  return unless $("body").hasClass("blocklies") && $("body").hasClass("index")


  savedBlockPrefix = 'bky.prc.saved.'


  _listenEvent = (event) ->
    # Capture only the create and move events.
    if event.type != Blockly.Events.CREATE &&
       event.type != Blockly.Events.MOVE
      return

    block = Code.workspace.getBlockById(event.blockId)

    return if !block

    root = block.getRootBlock()

    disable = (
      root.type != 'basics_setup' &&
      root.type != 'basics_loop' &&
      root.type != 'basics_mouse_pressed' &&
      root.type != 'procedures_defnoreturn' &&
      root.type != 'procedures_defreturn'
    )

    desc = block.getDescendants()

    i = 0
    while i < desc.length
      desc[i].setDisabled disable
      i++
    return


  _restoreBlocksFrom = (name) ->
    $('#restoreModal').hide()

    return if !name

    # ignore if empty
    if window.localStorage[savedBlockPrefix + name]
      name = savedBlockPrefix + name
      xml = Blockly.Xml.textToDom(window.localStorage[name])
      Code.workspace.clear()
      Blockly.Xml.domToWorkspace xml, Code.workspace
    else
      alertify.alert 'Error: ' + name + ' is not found.'


  _saveBlocksToLocalStorage = (key) ->
    xml = Blockly.Xml.workspaceToDom(Code.workspace)
    window.localStorage.setItem(key, Blockly.Xml.domToText(xml))


  saveBlocks = ->
    if 'localStorage' of window
      alertify.prompt(
        'Please type the name of your program.'
        (name, ev) ->
          key = savedBlockPrefix + name
          if window.localStorage[key]
            alertify.confirm(
              name + ' is already exists. Overwrite the exisiting program?'
              ->
                _saveBlocksToLocalStorage(key)
              ->
                return
            )
          else
            _saveBlocksToLocalStorage(key)
      )


  restoreBlocks = ->
    if 'localStorage' of window
      listElement = $('#restoreList')
      names = []

      for key of window.localStorage
        if key.startsWith(savedBlockPrefix)
          keyBody = key.substr(savedBlockPrefix.length)
          names.push keyBody

      if names.length == 0
        alertify.alert 'No programs.'
        return

      names.sort()

      listElement.html('')

      for name in names
        $('<li>').append(
          $('<a>').text(name)
                  .data('name', name)
                  .on 'click', ->
                    _restoreBlocksFrom(
                      $(this).data('name')
                    )
        ).appendTo(listElement)

      $('#restoreModal').css('display', 'block')


  cancelRestoreBlocks = ->
    $('#restoreModal').hide()


  pressCancelRestoreBlocks = (event) ->
    modal = document.getElementById('restoreModal')
    if event.target == modal
      cancelRestoreBlocks()


  $('#saveButton').on 'click', saveBlocks
  $('#restoreButton').on 'click', restoreBlocks
  $('#closeModal').on 'click', cancelRestoreBlocks
  $('#restoreModal').on 'click', pressCancelRestoreBlocks
