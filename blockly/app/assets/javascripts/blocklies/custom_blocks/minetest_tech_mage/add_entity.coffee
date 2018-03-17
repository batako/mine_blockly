Blockly.Blocks["minetest_add_entity"] =
  init: ->
    @appendDummyInput()
      .appendField("spawn")
    @appendValueInput("entity")
      .setCheck("String")
      .appendField("entity")
    @appendValueInput("x")
      .setCheck("Number")
      .appendField("x")
    @appendValueInput("y")
      .setCheck("Number")
      .appendField("y")
    @appendValueInput("z")
      .setCheck("Number")
      .appendField("z")
    @appendStatementInput("ACTIONS")
      .setCheck(null)
    @setInputsInline(true)
    @setColour(120)


getCode = (language, x, y, z, entity, actions) ->
  switch language
    when "JavaScript"
      code = "var actions = function() {\n#{actions}}\n"
      code += "spawnEntity(#{x}, #{y}, #{z}, #{entity}, actions);\n"
    when "Ruby"
      code = "actions = ->{\n#{actions}}\n"
      code += "spawnEntity(#{x}, #{y}, #{z}, #{entity}, actions)\n"


apply = (language) ->
  Blockly[language]["minetest_add_entity"] = (block) ->
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0
    entity = Blockly[language].valueToCode(
      block, "entity", Blockly[language].ORDER_ATOMIC).slice(1,-1)
    actions = Blockly[language].statementToCode(block, "ACTIONS")

    getCode(language, x, y, z, entity, actions)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
