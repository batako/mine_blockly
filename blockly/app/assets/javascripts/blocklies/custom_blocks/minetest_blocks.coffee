appy = (label, name, value) ->
  Blockly.Blocks["minetest_#{name}_block"] =
    init: ->
      @appendDummyInput()
        .appendField(
          new Blockly.FieldImage(
            window.image_path("blocklies/blocks/#{name}.png")
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
    Blockly[language]["minetest_#{name}_block"] = (block) ->
      [
        "'#{value}'"
        Blockly[language].ORDER_NONE
      ]

for params in [
  {label: "AIR", value: "air", name: "air"}
  {label: "BOOKSHELF", value: "default:bookshelf", name: "bookshelf"}
  {label: "BRICK", value: "default:brick", name: "brick"}
  {label: "DIRT", value: "default:dirt", name: "dirt"}
  {label: "GLASS", value: "default:glass", name: "glass"}
  {label: "STONE", value: "default:stone", name: "stone"}
  {label: "WOOD", value: "default:wood", name: "wood"}
  {label: "GOLD", value: "default:goldblock", name: "gold"}
  {label: "DIAMOND", value: "default:diamondblock", name: "diamond"}
  {label: "WHITE WOOL", value: "wool:white", name: "wool_white"}
  {label: "GREY WOOL", value: "wool:grey", name: "wool_grey"}
  {label: "DARK GREY WOOL", value: "wool:dark_grey", name: "wool_dark_grey"}
  {label: "BLACK WOOL", value: "wool:black", name: "wool_black"}
  {label: "BLUE WOOL", value: "wool:blue", name: "wool_blue"}
  {label: "CYAN WOOL", value: "wool:cyan", name: "wool_cyan"}
  {label: "GREEN WOOL", value: "wool:green", name: "wool_green"}
  {label: "DARK GREEN WOOL", value: "wool:dark_green", name: "wool_dark_green"}
  {label: "YELLOW WOOL", value: "wool:yellow", name: "wool_yellow"}
  {label: "ORANGE WOOL", value: "wool:orange", name: "wool_orange"}
  {label: "BROWN WOOL", value: "wool:brown", name: "wool_brown"}
  {label: "RED WOOL", value: "wool:red", name: "wool_red"}
  {label: "PINK WOOL", value: "wool:pink", name: "wool_pink"}
  {label: "MAGENTA WOOL", value: "wool:magenta", name: "wool_magenta"}
  {label: "VIOLET WOOL", value: "wool:violet", name: "wool_violet"}
  {label: "RANDOM WOOL", value: "wool:random", name: "wool_random"}
]
  appy(params.label, params.name, params.value)
