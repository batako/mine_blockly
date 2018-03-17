regist_mob = (name) ->
  Blockly.Blocks["minetest_#{name}_entity"] =
    init: ->
      @appendDummyInput()
        .appendField(
          new Blockly.FieldImage(
            window.image_path("blocklies/entities/#{name}.png")
            50
            50
            "*"
          )
        )
        .appendField(name.toUpperCase())
      @setInputsInline(true)
      @setOutput(true, "String")
      @setColour(230)

  for language in [
    "JavaScript"
    "Ruby"
  ]
    Blockly[language]["minetest_#{name}_entity"] = (block) ->
      [
        "'blockly:mob_#{name}'"
        Blockly[language].ORDER_NONE
      ]

for name in [
  "sheep"
  "chicken"
]
  regist_mob(name)
