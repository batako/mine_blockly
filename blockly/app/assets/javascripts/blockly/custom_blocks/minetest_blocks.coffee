appy = (label, name, value) ->
  Blockly.Blocks["minetest_#{name}_block"] =
    init: ->
      @appendDummyInput()
        .appendField(
          new Blockly.FieldImage(
            window.image_path("blockly/blocks/#{name}.png")
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
    "Python"
    "PHP"
    "Lua"
    "Dart"
  ]
    Blockly[language]["minetest_#{name}_block"] = (block) ->
      [
        value
        Blockly[language].ORDER_NONE
      ]

for params in [
  {label: "AIR", value: "air", name: "air"}
  {label: "BOOKSHELF", value: "bookshelf", name: "bookshelf"}
  {label: "BRICK", value: "brick", name: "brick"}
  {label: "DIRT", value: "dirt", name: "dirt"}
  {label: "GLASS", value: "glass", name: "glass"}
  {label: "STONE", value: "stone", name: "stone"}
  {label: "WOOD", value: "wood", name: "wood"}
  {label: "GOLD", value: "default:goldblock", name: "gold"}
  {label: "DIAMOND", value: "default:diamondblock", name: "diamond"}
]
  appy(params.label, params.name, params.value)
