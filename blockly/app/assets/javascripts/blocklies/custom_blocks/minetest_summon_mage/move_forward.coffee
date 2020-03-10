Blockly.Blocks["minetest_summon_mage_move_forward"] =
  init: ->
    @appendDummyInput()
      .appendField("move forward")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(185)


getCode = (language) ->
  switch language
    when "JavaScript"
      "moveForward();\n"
    when "Ruby"
      "moveForward()\n"


apply = (language) ->
  Blockly[language]["minetest_summon_mage_move_forward"] = (block) ->
    getCode(language)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
