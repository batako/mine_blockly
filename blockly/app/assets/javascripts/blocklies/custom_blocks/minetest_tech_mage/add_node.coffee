Blockly.Blocks["minetest_mage_basic_add_node"] =
  init: ->
    @appendValueInput("material")
      .setCheck("String")
      .appendField("place")
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
    @setTooltip("Create a minetest block of a given material, at coordinates x, y, z")


getCode = (language, material, x, y, z) ->
  switch language
    when "JavaScript"
      "createblock(#{material}, #{x}, #{y}, #{z});\n"
    when "Ruby"
      "createblock(#{material}, #{x}, #{y}, #{z})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_basic_add_node"] = (block) ->
    material = Blockly[language].valueToCode(
      block, "material", Blockly[language].ORDER_ATOMIC).slice(1,-1) || "air"
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0

    getCode(language, material, x, y, z)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
