Blockly.Blocks["minetest_mage_basic_teleport"] =
  init: ->
    @appendDummyInput()
      .appendField("teleport")
    @appendValueInput("name")
      .setCheck("String")
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


getCode = (language, name, x, y, z) ->
  switch language
    when "JavaScript"
      "teleport(#{name}, #{x}, #{y}, #{z});\n"
    when "Ruby"
      "teleport(#{name}, #{x}, #{y}, #{z})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_basic_teleport"] = (block) ->
    name = Blockly[language].valueToCode(
      block, "name")
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0

    getCode(language, name, x, y, z)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
