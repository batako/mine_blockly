Blockly.Blocks['minetest_createblock'] = {
  init: function() {
    this.setHelpUrl('http://www.example.com/');
    this.setColour(45);
    this.appendValueInput("material")
        .setCheck("String")
        .appendField("material");
    this.appendValueInput("x")
        .setCheck("Number")
        .appendField("x");
    this.appendValueInput("y")
        .setCheck("Number")
        .appendField("y");
    this.appendValueInput("z")
        .setCheck("Number")
        .appendField("z");
    this.setInputsInline(true);
    this.setPreviousStatement(true, "null");
    this.setNextStatement(true, "null");
    this.setTooltip('Create a minetest block of a given material, at coordinates x, y, z');
  }
};

// JavaScript

Blockly.JavaScript['minetest_createblock'] = function(block) {
  var value_material = Blockly.JavaScript.valueToCode(block, 'material', Blockly.JavaScript.ORDER_ATOMIC);
  var value_x = Blockly.JavaScript.valueToCode(block, 'x', Blockly.JavaScript.ORDER_ATOMIC);
  var value_y = Blockly.JavaScript.valueToCode(block, 'y', Blockly.JavaScript.ORDER_ATOMIC);
  var value_z = Blockly.JavaScript.valueToCode(block, 'z', Blockly.JavaScript.ORDER_ATOMIC);
  if (value_material == "") value_material = "air";
  value_material = value_material.replace(/[\(]/,'');
  value_material = value_material.replace(/[\)]/,'');
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  var code = 'createblock("'+value_material+'", '+ value_x +', '+ value_y + ', '+ value_z +')\n';
  return code;
};

// Python

Blockly.Python['minetest_createblock'] = function(block) {
  var value_material = Blockly.Python.valueToCode(block, 'material', Blockly.Python.ORDER_ATOMIC);
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var value_y = Blockly.Python.valueToCode(block, 'y', Blockly.Python.ORDER_ATOMIC);
  var value_z = Blockly.Python.valueToCode(block, 'z', Blockly.Python.ORDER_ATOMIC);
  if (value_material == "") value_material = "air";
  value_material = value_material.replace(/[\(]/,'');
  value_material = value_material.replace(/[\)]/,'');
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  var code = 'createblock("'+value_material+'", '+ value_x +', '+ value_y + ', '+ value_z +')\n';
  return code;
};

// PHP

Blockly.PHP['minetest_createblock'] = function(block) {
  var value_material = Blockly.PHP.valueToCode(block, 'material', Blockly.PHP.ORDER_ATOMIC);
  var value_x = Blockly.PHP.valueToCode(block, 'x', Blockly.PHP.ORDER_ATOMIC);
  var value_y = Blockly.PHP.valueToCode(block, 'y', Blockly.PHP.ORDER_ATOMIC);
  var value_z = Blockly.PHP.valueToCode(block, 'z', Blockly.PHP.ORDER_ATOMIC);
  if (value_material == "") value_material = "air";
  value_material = value_material.replace(/[\(]/,'');
  value_material = value_material.replace(/[\)]/,'');
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  var code = 'createblock("'+value_material+'", '+ value_x +', '+ value_y + ', '+ value_z +')\n';
  return code;
};

// Lua

Blockly.Lua['minetest_createblock'] = function(block) {
  var value_material = Blockly.Lua.valueToCode(block, 'material', Blockly.Lua.ORDER_ATOMIC);
  var value_x = Blockly.Lua.valueToCode(block, 'x', Blockly.Lua.ORDER_ATOMIC);
  var value_y = Blockly.Lua.valueToCode(block, 'y', Blockly.Lua.ORDER_ATOMIC);
  var value_z = Blockly.Lua.valueToCode(block, 'z', Blockly.Lua.ORDER_ATOMIC);
  if (value_material == "") value_material = "air";
  value_material = value_material.replace(/[\(]/,'');
  value_material = value_material.replace(/[\)]/,'');
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  var code = 'createblock("'+value_material+'", '+ value_x +', '+ value_y + ', '+ value_z +')\n';
  return code;
};

// Dart

Blockly.Dart['minetest_createblock'] = function(block) {
  var value_material = Blockly.Dart.valueToCode(block, 'material', Blockly.Dart.ORDER_ATOMIC);
  var value_x = Blockly.Dart.valueToCode(block, 'x', Blockly.Dart.ORDER_ATOMIC);
  var value_y = Blockly.Dart.valueToCode(block, 'y', Blockly.Dart.ORDER_ATOMIC);
  var value_z = Blockly.Dart.valueToCode(block, 'z', Blockly.Dart.ORDER_ATOMIC);
  if (value_material == "") value_material = "air";
  value_material = value_material.replace(/[\(]/,'');
  value_material = value_material.replace(/[\)]/,'');
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  var code = 'createblock("'+value_material+'", '+ value_x +', '+ value_y + ', '+ value_z +')\n';
  return code;
};
