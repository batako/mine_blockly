Blockly.Blocks["minetest_mage_summons_detect_block"] =
  init: ->
    @appendValueInput("material")
      .setCheck("String")
      .appendField("detect")
      .appendField(new Blockly.FieldDropdown([
        ["equal", "equal"]
        ["not", "not"]
      ]), "operator")
    @appendDummyInput()
      .appendField(new Blockly.FieldDropdown([
        ["ahead", "ahead"]
      ]), "direction")
    @appendStatementInput("actions")
      .setCheck(null)
      .appendField("do")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(207)


getCode = (language, operator, material, direction, actions) ->
  switch language
    when "JavaScript"
      "detectBlock('#{operator}', #{material}, '#{direction}', function() {\n#{actions}});\n"
    when "Ruby"
      "detect_block('#{operator}', #{material}, '#{direction}', ->{\n#{actions}})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_detect_block"] = (block) ->
    operator = block.getFieldValue("operator")
    material = Blockly[language].valueToCode(block, "material")
    actions = Blockly[language].statementToCode(block, "actions")
    direction = block.getFieldValue("direction")

    getCode(language, operator, material, direction, actions)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
