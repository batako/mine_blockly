Blockly.Blocks['minetest_mage_summons_play_sound'] =
  init: ->
    @appendDummyInput()
      .appendField("play sound")
      .appendField(new Blockly.FieldDropdown([
        ["chicken cluck", "mob_chicken"]
        ["sheep baa", "mob_sheep"]
      ]), "SOUND")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(185)
  onchange: (ev) ->
    return unless sound = ev.newValue
    audio = new Audio(
      window.audio_path("blocklies/#{sound}.ogg")
    )
    audio.play()


getCode = (language, block) ->
  switch language
    when "JavaScript"
      "playSound('#{block.getFieldValue('SOUND')}');\n"
    when "Ruby"
      "playSound('#{block.getFieldValue('SOUND')}')\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_play_sound"] = (block) ->
    getCode(language, block)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
