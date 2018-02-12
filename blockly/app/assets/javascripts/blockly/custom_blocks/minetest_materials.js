Blockly.Blocks['minetest_materials'] = {
  init: function() {
    this.setHelpUrl('http://www.example.com/');
    this.setColour(45);
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([
          ["Air", "air"],
          ["Bookshelf", "bookshelf"],
          ["Brick", "brick"],
          ["Dirt", "dirt"],
          ["Glass", "glass"],
          ["Stone", "stone"],
          ["Wood", "wood"],
          ["Gold", "default:goldblock"],
          ["Diamond", "default:diamondblock"],
        ]), "MATERIAL");
    this.setOutput(true, "String");
    this.setTooltip('List of materials for Minetest blocks');
  }
};

// JavaScript

Blockly.JavaScript['minetest_materials'] = function(block) {
  code = block.getFieldValue('MATERIAL');
  return [code, Blockly.JavaScript.ORDER_NONE];
};

// Python

Blockly.Python['minetest_materials'] = function(block) {
  code = block.getFieldValue('MATERIAL');
  return [code, Blockly.Python.ORDER_NONE];
};

// PHP

Blockly.PHP['minetest_materials'] = function(block) {
  code = block.getFieldValue('MATERIAL');
  return [code, Blockly.PHP.ORDER_NONE];
};

// Lua

Blockly.Lua['minetest_materials'] = function(block) {
  code = block.getFieldValue('MATERIAL');
  return [code, Blockly.Lua.ORDER_NONE];
};

// Dart

Blockly.Dart['minetest_materials'] = function(block) {
  code = block.getFieldValue('MATERIAL');
  return [code, Blockly.Dart.ORDER_NONE];
};
