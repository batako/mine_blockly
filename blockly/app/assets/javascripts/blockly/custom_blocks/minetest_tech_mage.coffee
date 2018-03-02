Blockly.Blocks["minetest_add_entity"] =
  init: ->
    @appendDummyInput()
      .appendField("spawnentity")
    @appendValueInput("x")
      .setCheck("Number")
      .appendField("x")
    @appendValueInput("y")
      .setCheck("Number")
      .appendField("y")
    @appendValueInput("z")
      .setCheck("Number")
      .appendField("z")
    @appendValueInput("entity")
      .setCheck("String")
      .appendField("entity")
    @appendStatementInput("ACTIONS")
      .setCheck(null)
    @setInputsInline(true)
    @setColour(290)


Blockly.JavaScript["minetest_add_entity"] = (block) ->
  x = Blockly.JavaScript.valueToCode(
    block, "x", Blockly.JavaScript.ORDER_ATOMIC) || 0
  y = Blockly.JavaScript.valueToCode(
    block, "y", Blockly.JavaScript.ORDER_ATOMIC) || 0
  z = Blockly.JavaScript.valueToCode(
    block, "z", Blockly.JavaScript.ORDER_ATOMIC) || 0
  entity = Blockly.JavaScript.valueToCode(
    block, "entity", Blockly.JavaScript.ORDER_ATOMIC).slice(1,-1)
  actions = Blockly.JavaScript.statementToCode(block, "ACTIONS")
  code = "var actions = function() {\n#{actions}}\n"
  code += "spawnEntity(#{x}, #{y}, #{z}, '#{entity}', actions);\n"
  return code


Blockly.Blocks["minetest_move_forward"] =
  init: ->
    @appendDummyInput()
      .appendField("move forward")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(184)


Blockly.JavaScript["minetest_move_forward"] = (block) ->
  "moveForward();\n"


Blockly.Blocks['minetest_turn'] =
  init: ->
    @appendDummyInput()
      .appendField("turn")
      .appendField(new Blockly.FieldDropdown([
        ["left", "turnLeft();"]
        ["right", "turnRight();"]
      ]), "ACTION")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(184)


Blockly.JavaScript["minetest_turn"] = (block) ->
  "#{block.getFieldValue('ACTION')}\n"


Blockly.Blocks['minetest_wait'] =
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
    @setColour(184)


Blockly.JavaScript["minetest_wait"] = (block) ->
  seconds = Blockly.JavaScript.valueToCode(
    block, "seconds", Blockly.JavaScript.ORDER_ATOMIC) || 0
  "wait(#{seconds});\n"


Blockly.Blocks['minetest_play_sound'] =
  init: ->
    @appendDummyInput()
      .appendField("play sound")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(184)


Blockly.JavaScript["minetest_play_sound"] = (block) ->
  "playSound();\n"


# TODO
for language in [
  "Python"
  "PHP"
  "Lua"
  "Dart"
]
  Blockly[language]["minetest_add_entity"] = (block) ->
    ""

  Blockly[language]["minetest_move_forward"] = (block) ->
    ""

  Blockly[language]["minetest_turn"] = (block) ->
    ""

  Blockly[language]["minetest_wait"] = (block) ->
    ""

  Blockly[language]["minetest_play_sound"] = (block) ->
    ""
