appy = (label, name, value) ->
  Blockly.Blocks["minetest_#{name}_item"] =
    init: ->
      @appendDummyInput()
        .appendField(
          new Blockly.FieldImage(
            window.image_path("blocklies/items/#{name}.png")
            50
            50
            "*"
          )
        )
        .appendField(label)
      @setInputsInline(true)
      @setOutput(true, "String")
      @setColour(230)


  for language in [
    "JavaScript"
    "Ruby"
  ]
    Blockly[language]["minetest_#{name}_item"] = (block) ->
      [
        "'#{value}'"
        Blockly[language].ORDER_NONE
      ]

for params in [
  {label: "TORCH", value: "default:torch", name: "torch"}
]
  appy(params.label, params.name, params.value)
