Blockly.Blocks['minetest_mage_summons_wait'] =
  init: ->
    @appendDummyInput()
      .appendField("wait")
    @appendValueInput("seconds")
      .setCheck("Number")
    @appendDummyInput()
      .appendField("seconds")
    @setInputsInline(true)
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(185)


getCode = (language, seconds) ->
  switch language
    when "JavaScript"
      "wait({seconds: #{seconds}});\n"
    when "Ruby"
      "wait({seconds: #{seconds}})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_wait"] = (block) ->
    seconds = Blockly.JavaScript.valueToCode(
      block, "seconds", Blockly.JavaScript.ORDER_ATOMIC) || 0

    getCode(language, seconds)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
