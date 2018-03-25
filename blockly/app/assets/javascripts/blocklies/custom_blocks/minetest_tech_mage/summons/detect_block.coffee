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
        ["right", "right"]
        # ["right top", "right_top"]
        # ["right bottom", "right_bottom"]
        # ["front right", "front_right"]
        # ["front top_right", "front_top_right"]
        # ["front bottom_right", "front_bottom_right"]
        ["front", "front"]
        # ["front top", "front_top"]
        ["front bottom", "front_bottom"]
        # ["front left", "front_left"]
        # ["front top_left", "front_top_left"]
        # ["front bottom_left", "front_bottom_left"]
        ["left", "left"]
        # ["left top", "left_top"]
        # ["left bottom", "left_bottom"]
        # ["back left", "back_top_left"]
        # ["back bottom_left", "back_bottom_left"]
        ["back", "back"]
        # ["back top", "back_top"]
        # ["back bottom", "back_bottom"]
        # ["back right", "back_right"]
        # ["back top_right", "back_top_right"]
        # ["back bottom_right", "back_bottom_right"]
        ["top", "top"]
        ["bottom", "bottom"]
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
      "detectBlock('#{operator}', #{material}, '#{direction}', " \
        + "function() {\n#{actions}});\n"
    when "Ruby"
      "detect_block('#{operator}', #{material}, '#{direction}', " \
        + "->{\n#{actions}})\n"


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
