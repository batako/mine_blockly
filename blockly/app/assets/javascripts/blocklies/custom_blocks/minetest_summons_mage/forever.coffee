Blockly.Blocks["minetest_mage_summons_forever"] =
  init: ->
    @appendDummyInput()
        .appendField("forever")
    @appendStatementInput("ACTIONS")
        .setCheck(null)
        .appendField("do")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(300)


getCode = (language, actions) ->
  switch language
    when "JavaScript"
      "forever(function() {\n#{actions}});\n"
    when "Ruby"
      "forever(->{\n#{actions}})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_forever"] = (block) ->
    actions = Blockly[language].statementToCode(block, "ACTIONS")

    getCode(language, actions)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
