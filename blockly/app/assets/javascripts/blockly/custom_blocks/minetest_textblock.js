Blockly.Blocks['minetest_textblock'] = {
  init: function() {
  this.setColour(45);
  this.appendDummyInput()
      .appendField("text to")
      .appendField(new Blockly.FieldDropdown([
        ["place", "createtextblock"],
        ["delete", "deletetextblock"],
      ]), "COMMAND")
      .appendField(new Blockly.FieldTextInput('text'), 'TEXT');
  this.appendValueInput("x")
      .setCheck("Number")
      .appendField("x");
  this.appendValueInput("y")
      .setCheck("Number")
      .appendField("y");
  this.appendValueInput("z")
      .setCheck("Number")
      .appendField("z");
  this.appendValueInput("dx")
      .setCheck("Number")
      .appendField("dx");
  this.appendValueInput("dy")
      .setCheck("Number")
      .appendField("dy");
  this.appendValueInput("dz")
      .setCheck("Number")
      .appendField("dz");
  this.setInputsInline(true);
  this.setPreviousStatement(true, "null");
  this.setNextStatement(true, "null");
  }
};

// JavaScript

Blockly.JavaScript['minetest_textblock'] = function(block) {
  var text = block.getFieldValue('TEXT');
  var command = block.getFieldValue('COMMAND');
  var value_x = Blockly.JavaScript.valueToCode(block, 'x', Blockly.JavaScript.ORDER_ATOMIC);
  var value_y = Blockly.JavaScript.valueToCode(block, 'y', Blockly.JavaScript.ORDER_ATOMIC);
  var value_z = Blockly.JavaScript.valueToCode(block, 'z', Blockly.JavaScript.ORDER_ATOMIC);
  var value_dx = Blockly.JavaScript.valueToCode(block, 'dx', Blockly.JavaScript.ORDER_ATOMIC);
  var value_dy = Blockly.JavaScript.valueToCode(block, 'dy', Blockly.JavaScript.ORDER_ATOMIC);
  var value_dz = Blockly.JavaScript.valueToCode(block, 'dz', Blockly.JavaScript.ORDER_ATOMIC);
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  if (value_dx == "") value_dx = 0;
  if (value_dy == "") value_dy = 0;
  if (value_dz == "") value_dz = 0;
  var code = command + '("' + text + '", ' + value_x + ', ' + value_y + ', ' + value_z + ', ' + value_dx + ', ' + value_dy + ', ' + value_dz + ')';
  return code;
};

// Python

Blockly.Python['minetest_textblock'] = function(block) {
  var text = block.getFieldValue('TEXT');
  var command = block.getFieldValue('COMMAND');
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var value_y = Blockly.Python.valueToCode(block, 'y', Blockly.Python.ORDER_ATOMIC);
  var value_z = Blockly.Python.valueToCode(block, 'z', Blockly.Python.ORDER_ATOMIC);
  var value_dx = Blockly.Python.valueToCode(block, 'dx', Blockly.Python.ORDER_ATOMIC);
  var value_dy = Blockly.Python.valueToCode(block, 'dy', Blockly.Python.ORDER_ATOMIC);
  var value_dz = Blockly.Python.valueToCode(block, 'dz', Blockly.Python.ORDER_ATOMIC);
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  if (value_dx == "") value_dx = 0;
  if (value_dy == "") value_dy = 0;
  if (value_dz == "") value_dz = 0;
  var code = command + '("' + text + '", ' + value_x + ', ' + value_y + ', ' + value_z + ', ' + value_dx + ', ' + value_dy + ', ' + value_dz + ')';
  return code;
};

// PHP

Blockly.PHP['minetest_textblock'] = function(block) {
  var text = block.getFieldValue('TEXT');
  var command = block.getFieldValue('COMMAND');
  var value_x = Blockly.PHP.valueToCode(block, 'x', Blockly.PHP.ORDER_ATOMIC);
  var value_y = Blockly.PHP.valueToCode(block, 'y', Blockly.PHP.ORDER_ATOMIC);
  var value_z = Blockly.PHP.valueToCode(block, 'z', Blockly.PHP.ORDER_ATOMIC);
  var value_dx = Blockly.PHP.valueToCode(block, 'dx', Blockly.PHP.ORDER_ATOMIC);
  var value_dy = Blockly.PHP.valueToCode(block, 'dy', Blockly.PHP.ORDER_ATOMIC);
  var value_dz = Blockly.PHP.valueToCode(block, 'dz', Blockly.PHP.ORDER_ATOMIC);
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  if (value_dx == "") value_dx = 0;
  if (value_dy == "") value_dy = 0;
  if (value_dz == "") value_dz = 0;
  var code = command + '("' + text + '", ' + value_x + ', ' + value_y + ', ' + value_z + ', ' + value_dx + ', ' + value_dy + ', ' + value_dz + ')';
  return code;
};

// Lua

Blockly.Lua['minetest_textblock'] = function(block) {
  var text = block.getFieldValue('TEXT');
  var command = block.getFieldValue('COMMAND');
  var value_x = Blockly.Lua.valueToCode(block, 'x', Blockly.Lua.ORDER_ATOMIC);
  var value_y = Blockly.Lua.valueToCode(block, 'y', Blockly.Lua.ORDER_ATOMIC);
  var value_z = Blockly.Lua.valueToCode(block, 'z', Blockly.Lua.ORDER_ATOMIC);
  var value_dx = Blockly.Lua.valueToCode(block, 'dx', Blockly.Lua.ORDER_ATOMIC);
  var value_dy = Blockly.Lua.valueToCode(block, 'dy', Blockly.Lua.ORDER_ATOMIC);
  var value_dz = Blockly.Lua.valueToCode(block, 'dz', Blockly.Lua.ORDER_ATOMIC);
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  if (value_dx == "") value_dx = 0;
  if (value_dy == "") value_dy = 0;
  if (value_dz == "") value_dz = 0;
  var code = command + '("' + text + '", ' + value_x + ', ' + value_y + ', ' + value_z + ', ' + value_dx + ', ' + value_dy + ', ' + value_dz + ')';
  return code;
};

// Dart

Blockly.Dart['minetest_textblock'] = function(block) {
  var text = block.getFieldValue('TEXT');
  var command = block.getFieldValue('COMMAND');
  var value_x = Blockly.Dart.valueToCode(block, 'x', Blockly.Dart.ORDER_ATOMIC);
  var value_y = Blockly.Dart.valueToCode(block, 'y', Blockly.Dart.ORDER_ATOMIC);
  var value_z = Blockly.Dart.valueToCode(block, 'z', Blockly.Dart.ORDER_ATOMIC);
  var value_dx = Blockly.Dart.valueToCode(block, 'dx', Blockly.Dart.ORDER_ATOMIC);
  var value_dy = Blockly.Dart.valueToCode(block, 'dy', Blockly.Dart.ORDER_ATOMIC);
  var value_dz = Blockly.Dart.valueToCode(block, 'dz', Blockly.Dart.ORDER_ATOMIC);
  if (value_x == "") value_x = 0;
  if (value_y == "") value_y = 0;
  if (value_z == "") value_z = 0;
  if (value_dx == "") value_dx = 0;
  if (value_dy == "") value_dy = 0;
  if (value_dz == "") value_dz = 0;
  var code = command + '("' + text + '", ' + value_x + ', ' + value_y + ', ' + value_z + ', ' + value_dx + ', ' + value_dy + ', ' + value_dz + ')';
  return code;
};
