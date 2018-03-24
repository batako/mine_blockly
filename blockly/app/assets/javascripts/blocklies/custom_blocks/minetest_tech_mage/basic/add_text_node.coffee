Blockly.Blocks["minetest_mage_basic_text_node"] =
  init: ->
    @appendDummyInput()
      .appendField("text to")
      .appendField(new Blockly.FieldDropdown([
        ["place", "createtextblock"],
        ["delete", "deletetextblock"],
      ]), "COMMAND")
      .appendField(new Blockly.FieldTextInput("text"), "TEXT")
    @appendValueInput("x")
      .setCheck("Number")
      .appendField("x")
    @appendValueInput("y")
      .setCheck("Number")
      .appendField("y")
    @appendValueInput("z")
      .setCheck("Number")
      .appendField("z")
    @appendValueInput("dx")
      .setCheck("Number")
      .appendField("dx")
    @appendValueInput("dy")
      .setCheck("Number")
      .appendField("dy")
    @appendValueInput("dz")
      .setCheck("Number")
      .appendField("dz")
    @setInputsInline(true)
    @setPreviousStatement(true, "null")
    @setNextStatement(true, "null")
    @setColour(45)


getCode = (language, command, text, x, y, z, dx, dy, dz) ->
  switch language
    when "JavaScript"
      "#{command}('#{text}', #{x}, #{y}, #{z}, #{dx}, #{dy}, #{dz});\n"
    when "Ruby"
      "#{command}('#{text}', #{x}, #{y}, #{z}, #{dx}, #{dy}, #{dz})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_basic_text_node"] = (block) ->
    text = block.getFieldValue("TEXT")
    command = block.getFieldValue("COMMAND")
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0
    dx = Blockly[language].valueToCode(
      block, "dx", Blockly[language].ORDER_ATOMIC) || 0
    dy = Blockly[language].valueToCode(
      block, "dy", Blockly[language].ORDER_ATOMIC) || 0
    dz = Blockly[language].valueToCode(
      block, "dz", Blockly[language].ORDER_ATOMIC) || 0

    getCode(language, command, text, x, y, z, dx, dy, dz)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
