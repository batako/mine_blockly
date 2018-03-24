Blockly.Blocks["minetest_mage_summons_if_not_ahead"] =
  init: ->
    @appendValueInput("material")
        .setCheck("String")
        .appendField("if not")
    @appendDummyInput()
        .appendField("ahead")
    @appendStatementInput("actions")
        .setCheck(null)
        .appendField("do")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(207)


getCode = (language, material, actions) ->
  switch language
    when "JavaScript"
      "if_not_ahead(#{material}, function() {\n#{actions}});\n"
    when "Ruby"
      "if_not_ahead(#{material}, ->{\n#{actions}})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_if_not_ahead"] = (block) ->
    material = Blockly[language].valueToCode(block, "material")
    actions = Blockly[language].statementToCode(block, "actions")

    getCode(language, material, actions)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
