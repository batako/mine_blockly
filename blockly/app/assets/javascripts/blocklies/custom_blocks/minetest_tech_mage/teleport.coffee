Blockly.Blocks["minetest_tech_mage_teleport"] =
  init: ->
    @appendDummyInput()
      .appendField("teleport")
    @appendValueInput("x")
      .setCheck("Number")
      .appendField("x")
    @appendValueInput("y")
      .setCheck("Number")
      .appendField("y")
    @appendValueInput("z")
      .setCheck("Number")
      .appendField("z")
    @setInputsInline(true)
    @setPreviousStatement(true, "null")
    @setNextStatement(true, "null")
    @setColour(45)


getCode = (language, x, y, z) ->
  switch language
    when "JavaScript"
      "teleport('@LOGIN_ID', #{x}, #{y}, #{z});\n"
    when "Ruby"
      "teleport('@LOGIN_ID', #{x}, #{y}, #{z})\n"


apply = (language) ->
  Blockly[language]["minetest_tech_mage_teleport"] = (block) ->
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0

    getCode(language, x, y, z)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
