Blockly.Blocks["minetest_mage_summons_place"] =
  init: ->
    @appendValueInput("material")
      .setCheck("String")
      .appendField("place")
    @setInputsInline(true)
    @setPreviousStatement(true, "null")
    @setNextStatement(true, "null")
    @setColour(185)


getCode = (language, material) ->
  switch language
    when "JavaScript"
      "place(#{material});\n"
    when "Ruby"
      "place(#{material})\n"


apply = (language) ->
  Blockly[language]["minetest_mage_summons_place"] = (block) ->
    material = Blockly[language].valueToCode(
      block, "material", Blockly[language].ORDER_ATOMIC).slice(1,-1) || "air"

    getCode(language, material)


for language in [
  "JavaScript"
  "Ruby"
]
  apply(language)
