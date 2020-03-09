Blockly.Blocks["minetest_tech_mage_add_node_on_player"] =
  init: ->
    @appendValueInput("material")
      .setCheck("String")
      .appendField("place")
    @appendValueInput("x")
      .setCheck("Number")
      .appendField("your: ~X")
    @appendValueInput("y")
      .setCheck("Number")
      .appendField("~Y")
    @appendValueInput("z")
      .setCheck("Number")
      .appendField("~Z")
    @appendDummyInput()
      .appendField('move player')
      .appendField(new Blockly.FieldCheckbox('FALSE'), 'TELEPORT');
    @setInputsInline(true)
    @setPreviousStatement(true, "null")
    @setNextStatement(true, "null")
    @setColour(60)
    @setTooltip("Create a block of a given material, at coordinates x, y, z")


getCode = (language, material, x, y, z, teleport) ->
  switch language
    when "JavaScript"
      "createblockOnPlayer(#{material}, #{x}, #{y}, #{z}, #{teleport});\n"
    when "Ruby"
      "createblock_on_player(#{material}, #{x}, #{y}, #{z}, #{teleport})\n"


apply = (language) ->
  Blockly[language]["minetest_tech_mage_add_node_on_player"] = (block) ->
    material = Blockly[language].valueToCode(
      block, "material", Blockly[language].ORDER_ATOMIC).slice(1,-1) || "air"
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0
    teleport = block.getFieldValue('TELEPORT') == 'TRUE'

    getCode(language, material, x, y, z, teleport)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
