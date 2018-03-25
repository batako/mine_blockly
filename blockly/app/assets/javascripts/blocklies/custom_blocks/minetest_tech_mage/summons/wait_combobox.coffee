Blockly.Blocks['minetest_mage_summons_wait_combobox'] =
  init: ->
    @appendDummyInput()
      .appendField("wait")
      .appendField(new Blockly.FieldDropdown([
        ["very short", "very_short"]
        ["short", "short"]
        ["medium", "medium"]
        ["long", "long"]
        ["very long", "very_long"]
        ["random", "random"]
      ]), "type")
    @setInputsInline(true)
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(185)


getCode = (language, block) ->
  switch language
    when "JavaScript"
      "wait({type: '#{block.getFieldValue('type')}'});\n"
    when "Ruby"
      "wait({type: '#{block.getFieldValue('type')}'})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_wait_combobox"] = (block) ->
    getCode(language, block)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
