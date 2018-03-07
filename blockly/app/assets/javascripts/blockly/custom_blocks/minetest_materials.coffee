Blockly.Blocks['minetest_materials'] = init: ->
  @setHelpUrl 'http://www.example.com/'
  @setColour 45
  @appendDummyInput().appendField new (Blockly.FieldDropdown)([
    ['White Wool', 'wool:white']
    ['Blue Wool', 'wool:blue']
    ['Green Wool', 'wool:green']
    ['Dark Green Wool', 'wool:dark_green']
    ['Yellow Wool', 'wool:yellow']
    ['Orange Wool', 'wool:orange']
    ['Red Wool', 'wool:red']
    ['Pink Wool', 'wool:pink']
    ['Violet Wool', 'wool:violet']
    ['Random Wool', 'wool:random']
    ['Air', 'air']
    ['Brick', 'brick']
    ['Stone', 'stone']
    ['Wood', 'wood']
    ['Wooden Ladder', 'default:ladder_wood']
    ['Gold', 'default:goldblock']
    ['Diamond', 'default:diamondblock']
  ]), 'MATERIAL'
  @setOutput true
  @setTooltip 'List of materials for Minetest blocks'
  return



Blockly.JavaScript["minetest_materials"] = (block) ->
  code = block.getFieldValue('MATERIAL')
  return [code, Blockly.JavaScript.ORDER_NONE]
