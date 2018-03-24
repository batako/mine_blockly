Blockly.Blocks["minetest_mage_summons_drop"] =
  init: ->
    @appendValueInput("item")
      .setCheck("String")
      .appendField("drop")
    @setInputsInline(true)
    @setPreviousStatement(true, "null")
    @setNextStatement(true, "null")
    @setColour(185)


getCode = (language, item) ->
  switch language
    when "JavaScript"
      "drop(#{item});\n"
    when "Ruby"
      "drop(#{item})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_drop"] = (block) ->
    item = Blockly[language].valueToCode(
      block, "item", Blockly[language].ORDER_ATOMIC).slice(1,-1) \
        || "default:torch"

    getCode(language, item)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
