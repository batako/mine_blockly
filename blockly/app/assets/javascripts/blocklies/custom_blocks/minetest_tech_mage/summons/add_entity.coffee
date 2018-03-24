Blockly.Blocks["minetest_mage_summons_add_entity"] =
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
    @appendStatementInput("touched_actions")
      .setCheck(null)
      .appendField("when touched")
    @appendStatementInput("used_actions")
      .setCheck(null)
      .appendField("when used")
    @setInputsInline(true)
    @setColour(120)


getCode = (language, x, y, z, entity, spawn_actions, touched_actions, used_actions) ->
  switch language
    when "JavaScript"
      "spawnEntity(#{x}, #{y}, #{z}, #{entity}," \
        + " {\nwhen_spawned: function() {\n#{spawn_actions}},\n" \
        + "when_touched: function() {\n#{touched_actions}},\n" \
        + "when_used: function() {\n#{used_actions}}\n});\n"
    when "Ruby"
      "spawnEntity(#{x}, #{y}, #{z}, #{entity}," \
        + " {\nwhen_spawned: ->{\n#{spawn_actions}},\n" \
        + "when_touched: ->{\n#{touched_actions}},\n" \
        + "when_used: ->{\n#{used_actions}}\n})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_add_entity"] = (block) ->
    x = Blockly[language].valueToCode(
      block, "x", Blockly[language].ORDER_ATOMIC) || 0
    y = Blockly[language].valueToCode(
      block, "y", Blockly[language].ORDER_ATOMIC) || 0
    z = Blockly[language].valueToCode(
      block, "z", Blockly[language].ORDER_ATOMIC) || 0
    entity = Blockly[language].valueToCode(
      block, "entity", Blockly[language].ORDER_ATOMIC).slice(1,-1)
    spawn_actions = Blockly[language].statementToCode(block, "spawn_actions")
    touched_actions = Blockly[language].statementToCode(block, "touched_actions")
    used_actions = Blockly[language].statementToCode(block, "used_actions")

    getCode(language, x, y, z, entity, spawn_actions, touched_actions, used_actions)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
