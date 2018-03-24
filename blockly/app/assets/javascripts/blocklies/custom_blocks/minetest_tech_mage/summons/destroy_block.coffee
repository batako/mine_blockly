Blockly.Blocks["minetest_mage_summons_destroy_block"] =
  init: ->
    @appendDummyInput()
        .appendField("destroy block")
    @setPreviousStatement(true, null)
    @setNextStatement(true, null)
    @setColour(185)

getCode = (language) ->
  switch language
    when "JavaScript"
      "destroyBlock();\n"
    when "Ruby"
      "destroy_block()\n"

apply = (language) ->
  Blockly[language]["minetest_mage_summons_destroy_block"] = (block) ->
    getCode(language)

for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
