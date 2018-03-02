Blockly.Blocks["minetest_entity_sheep"] =
  init: ->
    @appendDummyInput()
      .appendField(
        new Blockly.FieldImage(
          window.image_path("blockly/entities/sheep.png")
          50
          50
          "*"
        )
      )
      .appendField("SHEEP")
    @setInputsInline(true)
    @setOutput(true, "String")
    @setColour(230)


for language in [
  "JavaScript"
  "Python"
  "PHP"
  "Lua"
  "Dart"
]
  Blockly[language]["minetest_entity_sheep"] = (block) ->
    [
      "blockly:mob_sheep"
      Blockly[language].ORDER_NONE
    ]
