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
    @appendStatementInput("spawn_actions")
      .setCheck(null)
      .appendField("when spawned")
    @appendStatementInput("punch_actions")
      .setCheck(null)
      .appendField("when touched")
    @setInputsInline(true)
    @setColour(120)


getCode = (language, x, y, z, entity, spawn_actions, punch_actions) ->
  switch language
    when "JavaScript"
      "spawnEntity(#{x}, #{y}, #{z}, #{entity}," \
        + " {\nwhen_spawned: function() {\n#{spawn_actions}},\n" \
        + "when_punched: function() {\n#{punch_actions}}\n});\n"
    when "Ruby"
      "spawnEntity(#{x}, #{y}, #{z}, #{entity}," \
        + " {\nwhen_spawned: ->{\n#{spawn_actions}},\w" \
        + "when_punched: ->{\n#{punch_actions}}\n})\n"


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
    spawn_actions = Blockly[language].statementToCode(block, "spawn_actions")
    punch_actions = Blockly[language].statementToCode(block, "punch_actions")

    getCode(language, x, y, z, entity, spawn_actions, punch_actions)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
