// Do not edit this file; automatically generated by build.py.
'use strict';

Blockly.Ruby=new Blockly.Generator("Ruby");Blockly.Ruby.addReservedWords("Class,Object,BEGIN,END,__ENCODING__,__END__,__FILE__,__LINE__alias,and,begin,break,case,class,def,defined?,do,else,elsif,end,ensure,false,for,if,in,module,nextnil,not,or,redo,rescue,retry,return,self,super,then,true,undef,unless,until,when,while,yield");Blockly.Ruby.ORDER_ATOMIC=0;Blockly.Ruby.ORDER_MEMBER=2;Blockly.Ruby.ORDER_FUNCTION_CALL=2;Blockly.Ruby.ORDER_EXPONENTIATION=3;Blockly.Ruby.ORDER_LOGICAL_NOT=4;
Blockly.Ruby.ORDER_UNARY_SIGN=4;Blockly.Ruby.ORDER_BITWISE_NOT=4;Blockly.Ruby.ORDER_MULTIPLICATIVE=5;Blockly.Ruby.ORDER_ADDITIVE=6;Blockly.Ruby.ORDER_BITWISE_SHIFT=7;Blockly.Ruby.ORDER_BITWISE_AND=8;Blockly.Ruby.ORDER_BITWISE_XOR=9;Blockly.Ruby.ORDER_BITWISE_OR=9;Blockly.Ruby.ORDER_RELATIONAL=11;Blockly.Ruby.ORDER_LOGICAL_AND=13;Blockly.Ruby.ORDER_LOGICAL_OR=14;Blockly.Ruby.ORDER_CONDITIONAL=15;Blockly.Ruby.ORDER_NONE=99;Blockly.Ruby.INFINITE_LOOP_TRAP=null;
Blockly.Ruby.init=function(){Blockly.Ruby.definitions_=Object.create(null);Blockly.Ruby.functionNames_=Object.create(null);if(Blockly.Variables){Blockly.Ruby.variableDB_?Blockly.Ruby.variableDB_.reset():(Blockly.Ruby.variableDB_=new Blockly.Names(Blockly.Ruby.RESERVED_WORDS_),Blockly.Ruby.variableDB_.localVars=null,Blockly.Ruby.variableDB_.localVarsDB=null,Blockly.Ruby.variableDB_.getRubyName=function(a,b){if(b==Blockly.Variables.NAME_TYPE){for(var c=this.localVars;null!=c;){if(a in c)return c[a];
c=c.chain}return"$"+this.getName(a,b)}return this.getName(a,b)},Blockly.Ruby.variableDB_.pushScope=function(){var a=this.localVars,b=this.localVarsDB;this.localVars=Object.create(null);this.localVarsDB=new Blockly.Names(Blockly.Ruby.RESERVED_WORDS_);this.localVars.chain=a;this.localVarsDB.chain=b},Blockly.Ruby.variableDB_.addLocalVariable=function(a){this.localVars[a]=this.localVarsDB.getName(a,Blockly.Variables.NAME_TYPE);return this.localVars[a]},Blockly.Ruby.variableDB_.popScope=function(){this.localVars=
this.localVars.chain;this.localVarsDB=this.localVarsDB.chain});for(var a=[],b=Blockly.Variables.allVariables(Code.workspace).map(function(a){return a.name}),c=0;c<b.length;c++)a[c]="$"+Blockly.Ruby.variableDB_.getName(b[c],Blockly.Variables.NAME_TYPE)+" = nil";a=a.join("\n");Blockly.Ruby.definitions_.variables=a}};Blockly.Ruby.validName=function(a){return this.variableDB_.safeName_(a)};
Blockly.Ruby.generateDefinitions=function(){var a=[],b;for(b in Blockly.Ruby.definitions_)a.push(Blockly.Ruby.definitions_[b]);return a};Blockly.Ruby.finish=function(a){return Blockly.Ruby.generateDefinitions().join("\n\n").replace(/\n\n+/g,"\n\n").replace(/\n*$/,"\n\n\n")+a};Blockly.Ruby.scrubNakedValue=function(a){return a+"\n"};Blockly.Ruby.quote_=function(a){a=a.replace(/\\/g,"\\\\").replace(/\n/g,"\\\n").replace(/%/g,"\\%").replace(/'/g,"\\'");return"'"+a+"'"};
Blockly.Ruby.scrub_=function(a,b){if(null===b)return"";var c="";if(!a.outputConnection||!a.outputConnection.targetConnection){var d=a.getCommentText();d&&(c+=this.prefixLines(d,"# ")+"\n");for(var e=0;e<a.inputList.length;e++)a.inputList[e].type==Blockly.INPUT_VALUE&&(d=a.inputList[e].connection.targetBlock())&&(d=this.allNestedComments(d))&&(c+=this.prefixLines(d,"# "))}e=a.nextConnection&&a.nextConnection.targetBlock();e=this.blockToCode(e);return c+b+e};Blockly.Ruby.colour={};Blockly.Ruby.colour_picker=function(a){return["'"+a.getFieldValue("COLOUR")+"'",Blockly.Ruby.ORDER_ATOMIC]};Blockly.Ruby.colour_random=function(a){return["'#%06x' % rand(2**24 - 1)",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.colour_rgb=function(a){var b=Blockly.Ruby.provideFunction_("colour_rgb",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(r, g, b)","  r = (2.55 * [100, [0, r].max].min).round","  g = (2.55 * [100, [0, g].max].min).round","  b = (2.55 * [100, [0, b].max].min).round","  '#%02x%02x%02x' % [r, g, b]","end"]),c=Blockly.Ruby.valueToCode(a,"RED",Blockly.Ruby.ORDER_NONE)||0,d=Blockly.Ruby.valueToCode(a,"GREEN",Blockly.Ruby.ORDER_NONE)||0;a=Blockly.Ruby.valueToCode(a,"BLUE",Blockly.Ruby.ORDER_NONE)||
0;return[b+"("+c+", "+d+", "+a+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.colour_blend=function(a){var b=Blockly.Ruby.provideFunction_("colour_blend",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(colour1, colour2, ratio) ",'  _, r1, g1, b1 = colour1.unpack("A1A2A2A2").map {|x| x.to_i(16)}','  _, r2, g2, b2 = colour2.unpack("A1A2A2A2").map {|x| x.to_i(16)}',"  ratio = [1, [0, ratio].max].min","  r = (r1 * (1 - ratio) + r2 * ratio).round","  g = (g1 * (1 - ratio) + g2 * ratio).round","  b = (b1 * (1 - ratio) + b2 * ratio).round","  '#%02x%02x%02x' % [r, g, b]",
"end"]),c=Blockly.Ruby.valueToCode(a,"COLOUR1",Blockly.Ruby.ORDER_NONE)||"'#000000'",d=Blockly.Ruby.valueToCode(a,"COLOUR2",Blockly.Ruby.ORDER_NONE)||"'#000000'";a=Blockly.Ruby.valueToCode(a,"RATIO",Blockly.Ruby.ORDER_NONE)||0;return[b+"("+c+", "+d+", "+a+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.lists={};Blockly.Ruby.lists_create_empty=function(a){return["[]",Blockly.Ruby.ORDER_ATOMIC]};Blockly.Ruby.lists_create_with=function(a){for(var b=Array(a.itemCount_),c=0;c<a.itemCount_;c++)b[c]=Blockly.Ruby.valueToCode(a,"ADD"+c,Blockly.Ruby.ORDER_NONE)||"None";b="["+b.join(", ")+"]";return[b,Blockly.Ruby.ORDER_ATOMIC]};
Blockly.Ruby.lists_repeat=function(a){var b=Blockly.Ruby.valueToCode(a,"ITEM",Blockly.Ruby.ORDER_NONE)||"None";a=Blockly.Ruby.valueToCode(a,"NUM",Blockly.Ruby.ORDER_MULTIPLICATIVE)||"0";return["["+b+"] * "+a,Blockly.Ruby.ORDER_MULTIPLICATIVE]};Blockly.Ruby.lists_length=function(a){return[(Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"[]")+".length",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.lists_isEmpty=function(a){return[(Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"[]")+".empty?",Blockly.Ruby.ORDER_LOGICAL_NOT]};Blockly.Ruby.lists_indexOf=function(a){var b=Blockly.Ruby.valueToCode(a,"FIND",Blockly.Ruby.ORDER_NONE)||"[]",c=Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_MEMBER)||"''";a="FIRST"==a.getFieldValue("END")?".find_first":".find_last";return[c+a+"("+b+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.lists_getIndex=function(a){var b=a.getFieldValue("MODE")||"GET",c=a.getFieldValue("WHERE")||"FROM_START",d=Blockly.Ruby.valueToCode(a,"AT",Blockly.Ruby.ORDER_UNARY_SIGN)||"1";a=Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_MEMBER)||"[]";if("FIRST"==c){if("GET"==b)return[a+".first",Blockly.Ruby.ORDER_FUNCTION_CALL];c=a+".shift";if("GET_REMOVE"==b)return[c,Blockly.Ruby.ORDER_FUNCTION_CALL];if("REMOVE"==b)return c+"\n"}else if("LAST"==c){if("GET"==b)return[a+".last",Blockly.Ruby.ORDER_MEMBER];
c=a+".pop";if("GET_REMOVE"==b)return[c,Blockly.Ruby.ORDER_FUNCTION_CALL];if("REMOVE"==b)return c+"\n"}else if("FROM_START"==c){d=Blockly.isNumber(d)?parseInt(d,10)-1:"("+d+" - 1).to_i";if("GET"==b)return[a+"["+d+"]",Blockly.Ruby.ORDER_MEMBER];c=a+".delete_at("+d+")";if("GET_REMOVE"==b)return[c,Blockly.Ruby.ORDER_FUNCTION_CALL];if("REMOVE"==b)return c+"\n"}else if("FROM_END"==c){if("GET"==b)return[a+"[-"+d+"]",Blockly.Ruby.ORDER_MEMBER];c=a+".delete_at(-"+d+")";if("GET_REMOVE"==b)return[c,Blockly.Ruby.ORDER_FUNCTION_CALL];
if("REMOVE"==b)return c+"\n"}else if("RANDOM"==c){if("GET"==b)return c=Blockly.Ruby.provideFunction_("lists_random_item",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(myList)","  myList[rand(myList.size)]","end"]),[c+"("+a+")",Blockly.Ruby.ORDER_FUNCTION_CALL];c=Blockly.Ruby.provideFunction_("lists_remove_random_item",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(myList)","  myList.delete_at(rand(myList.size))","end"]);c=c+"("+a+")";if("GET_REMOVE"==b)return[c,Blockly.Ruby.ORDER_FUNCTION_CALL];
if("REMOVE"==b)return c+"\n"}throw"Unhandled combination (lists_getIndex).";};
Blockly.Ruby.lists_setIndex=function(a){var b=Blockly.Ruby.valueToCode(a,"LIST",Blockly.Ruby.ORDER_MEMBER)||"[]",c=a.getFieldValue("MODE")||"GET",d=a.getFieldValue("WHERE")||"FROM_START",e=Blockly.Ruby.valueToCode(a,"AT",Blockly.Ruby.ORDER_NONE)||"1";a=Blockly.Ruby.valueToCode(a,"TO",Blockly.Ruby.ORDER_NONE)||"None";if("FIRST"==d){if("SET"==c)return b+"[0] = "+a+"\n";if("INSERT"==c)return b+".unshift("+a+")\n"}else if("LAST"==d){if("SET"==c)return b+"[-1] = "+a+"\n";if("INSERT"==c)return b+".push("+
a+")\n"}else if("FROM_START"==d){e=Blockly.isNumber(e)?parseInt(e,10)-1:"("+e+" - 1).to_i";if("SET"==c)return b+"["+e+"] = "+a+"\n";if("INSERT"==c)return b+".insert("+e+", "+a+")\n"}else if("FROM_END"==d){if("SET"==c)return e=Blockly.isNumber(e)?parseInt(e,10):"("+e+").to_i",b+"[-"+e+"] = "+a+"\n";if("INSERT"==c)return e=Blockly.isNumber(e)?parseInt(e,10)+1:"("+e+" + 1).to_i",b+".insert(-"+e+", "+a+")\n"}else if("RANDOM"==d){if("SET"==c)return c=Blockly.Ruby.provideFunction_("lists_set_random_item",
["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(myList, value)","  myList[rand(myList.size)] = "+a,"end"]),c+"("+b+", "+a+")\n";if("INSERT"==c)return c=Blockly.Ruby.provideFunction_("lists_insert_random_item",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(myList, value)","  myList.insert(rand(myList.size), "+a+")","end"]),c+"("+b+", "+a+")\n"}throw"Unhandled combination (lists_setIndex).";};
Blockly.Ruby.lists_getSublist=function(a){var b=Blockly.Ruby.provideFunction_("lists_sublist",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(myList, range)","  myList[range] || []","end"]),c=Blockly.Ruby.valueToCode(a,"LIST",Blockly.Ruby.ORDER_MEMBER)||"[]",d=a.getFieldValue("WHERE1"),e=a.getFieldValue("WHERE2"),f=Blockly.Ruby.valueToCode(a,"AT1",Blockly.Ruby.ORDER_ADDITIVE)||"1";a=Blockly.Ruby.valueToCode(a,"AT2",Blockly.Ruby.ORDER_ADDITIVE)||"1";"FIRST"==d||"FROM_START"==d&&"1"==f?f="0":"FROM_START"==
d?f=Blockly.isNumber(f)?parseInt(f,10)-1:f+".to_i - 1)":"FROM_END"==d&&(f=Blockly.isNumber(f)?-parseInt(f,10):"-"+f+".to_i");"LAST"==e||"FROM_END"==e&&"1"==a?a="-1":"FROM_START"==e?a=Blockly.isNumber(a)?parseInt(a,10)-1:a+".to_i - 1":"FROM_END"==e&&(a=Blockly.isNumber(a)?-parseInt(a,10):"-"+a+".to_i");return[b+"("+c+", "+f+".."+a+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.logic={};Blockly.Ruby.controls_if=function(a){var b=0,c=Blockly.Ruby.valueToCode(a,"IF"+b,Blockly.Ruby.ORDER_NONE)||"false",d=Blockly.Ruby.statementToCode(a,"DO"+b)||"\n",e="if "+c+"\n"+d;for(b=1;b<=a.elseifCount_;b++)c=Blockly.Ruby.valueToCode(a,"IF"+b,Blockly.Ruby.ORDER_NONE)||"false",d=Blockly.Ruby.statementToCode(a,"DO"+b)||"\n",e+="elsif "+c+"\n"+d;a.elseCount_&&(d=Blockly.Ruby.statementToCode(a,"ELSE")||"\n",e+="else\n"+d);return e+"end\n"};
Blockly.Ruby.logic_compare=function(a){var b={EQ:"==",NEQ:"!=",LT:"<",LTE:"<=",GT:">",GTE:">="}[a.getFieldValue("OP")],c=Blockly.Ruby.ORDER_RELATIONAL,d=Blockly.Ruby.valueToCode(a,"A",c)||"0";a=Blockly.Ruby.valueToCode(a,"B",c)||"0";return[d+" "+b+" "+a,c]};
Blockly.Ruby.logic_operation=function(a){var b="AND"==a.getFieldValue("OP")?"&&":"||",c="&&"==b?Blockly.Ruby.ORDER_LOGICAL_AND:Blockly.Ruby.ORDER_LOGICAL_OR,d=Blockly.Ruby.valueToCode(a,"A",c);a=Blockly.Ruby.valueToCode(a,"B",c);if(d||a){var e="&&"==b?"true":"False";d||(d=e);a||(a=e)}else a=d="false";return[d+" "+b+" "+a,c]};Blockly.Ruby.logic_negate=function(a){return["! "+(Blockly.Ruby.valueToCode(a,"BOOL",Blockly.Ruby.ORDER_LOGICAL_NOT)||"true"),Blockly.Ruby.ORDER_LOGICAL_NOT]};
Blockly.Ruby.logic_boolean=function(a){return["TRUE"==a.getFieldValue("BOOL")?"true":"false",Blockly.Ruby.ORDER_ATOMIC]};Blockly.Ruby.logic_null=function(a){return["nil",Blockly.Ruby.ORDER_ATOMIC]};Blockly.Ruby.logic_ternary=function(a){var b=Blockly.Ruby.valueToCode(a,"IF",Blockly.Ruby.ORDER_CONDITIONAL)||"false",c=Blockly.Ruby.valueToCode(a,"THEN",Blockly.Ruby.ORDER_CONDITIONAL)||"nil";a=Blockly.Ruby.valueToCode(a,"ELSE",Blockly.Ruby.ORDER_CONDITIONAL)||"nil";return[b+" ? "+c+" : "+a,Blockly.Ruby.ORDER_CONDITIONAL]};Blockly.Ruby.loops={};Blockly.Ruby.controls_repeat=function(a){var b=parseInt(a.getFieldValue("TIMES"),10),c=Blockly.Ruby.statementToCode(a,"DO")||"end\n";Blockly.Ruby.INFINITE_LOOP_TRAP&&(c=Blockly.Ruby.INFINITE_LOOP_TRAP.replace(/%1/g,"'"+a.id+"'")+c);return b+".times do\n"+c+"end\n"};
Blockly.Ruby.controls_repeat_ext=function(a){var b=Blockly.Ruby.valueToCode(a,"TIMES",Blockly.Ruby.ORDER_NONE)||"0";b=Blockly.isNumber(b)?parseInt(b,10):b+".to_i";var c=Blockly.Ruby.statementToCode(a,"DO")||"end\n";Blockly.Ruby.INFINITE_LOOP_TRAP&&(c=Blockly.Ruby.INFINITE_LOOP_TRAP.replace(/%1/g,"'"+a.id+"'")+c);return b+".times do\n"+c+"end\n"};
Blockly.Ruby.controls_whileUntil=function(a){var b="UNTIL"==a.getFieldValue("MODE"),c=Blockly.Ruby.valueToCode(a,"BOOL",b?Blockly.Ruby.ORDER_LOGICAL_NOT:Blockly.Ruby.ORDER_NONE)||"false",d=Blockly.Ruby.statementToCode(a,"DO")||"end\n";Blockly.Ruby.INFINITE_LOOP_TRAP&&(d=Blockly.Ruby.INFINITE_LOOP_TRAP.replace(/%1/g,'"'+a.id+'"')+d);return(b?"until ":"while ")+c+" do\n"+d+"end\n"};
Blockly.Ruby.controls_for=function(a){Blockly.Ruby.variableDB_.pushScope();var b=Blockly.Ruby.variableDB_.addLocalVariable(a.getFieldValue("VAR"),Blockly.Variables.NAME_TYPE),c=Blockly.Ruby.valueToCode(a,"FROM",Blockly.Ruby.ORDER_NONE)||"0",d=Blockly.Ruby.valueToCode(a,"TO",Blockly.Ruby.ORDER_NONE)||"0",e=Blockly.Ruby.valueToCode(a,"BY",Blockly.Ruby.ORDER_NONE)||null,f=Blockly.Ruby.statementToCode(a,"DO")||"";Blockly.Ruby.INFINITE_LOOP_TRAP&&(f=Blockly.Ruby.INFINITE_LOOP_TRAP.replace(/%1/g,'"'+a.id+
'"')+f);var g=function(){return Blockly.Ruby.provideFunction_("for_loop",["# loops though all numbers from +params[:from]+ to +params[:to]+ by the step","# value +params[:by]+ and calls the given block passing the numbers","def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+" params","","  from = params[:from] #.to_f","  to = params[:to] #.to_f","  by = params[:by].abs #.to_f","","  from.step(to, (from > to) ? -1 * by : by) do |value|","    yield value","  end","","end"])};a=function(a,b,c){return g()+
" from: ("+a+"), to: ("+b+"), by: ("+c+")"};Blockly.isNumber(c)&&Blockly.isNumber(d)&&(null==e||Blockly.isNumber(e))?(null==e&&(e="1"),c=parseFloat(c),d=parseFloat(d),e=parseFloat(e),g=a(c,d,e)):g=a(c+".to_f",d+".to_f",null==e?"1":"("+e+").to_f");Blockly.Ruby.variableDB_.popScope();return g+" do |"+b+"|\n"+f+"end\n"};
Blockly.Ruby.controls_forEach=function(a){Blockly.Ruby.variableDB_.pushScope();var b=Blockly.Ruby.variableDB_.addLocalVariable(a.getFieldValue("VAR"),Blockly.Variables.NAME_TYPE),c=Blockly.Ruby.valueToCode(a,"LIST",Blockly.Ruby.ORDER_RELATIONAL)||"[]",d=Blockly.Ruby.statementToCode(a,"DO")||"end\n";Blockly.Ruby.INFINITE_LOOP_TRAP&&(d=Blockly.Ruby.INFINITE_LOOP_TRAP.replace(/%1/g,'"'+a.id+'"')+d);Blockly.Ruby.variableDB_.popScope();return c+".each do |"+b+"|\n"+d+"end\n"};
Blockly.Ruby.controls_flow_statements=function(a){switch(a.getFieldValue("FLOW")){case "BREAK":return"break\n";case "CONTINUE":return"next\n"}throw"Unknown flow statement.";};Blockly.Ruby.math={};Blockly.Ruby.math_number=function(a){a=parseFloat(a.getFieldValue("NUM"));return[a,0>a?Blockly.Ruby.ORDER_UNARY_SIGN:Blockly.Ruby.ORDER_ATOMIC]};
Blockly.Ruby.math_arithmetic=function(a){var b={ADD:[" + ",Blockly.Ruby.ORDER_ADDITIVE],MINUS:[" - ",Blockly.Ruby.ORDER_ADDITIVE],MULTIPLY:[" * ",Blockly.Ruby.ORDER_MULTIPLICATIVE],DIVIDE:[" / ",Blockly.Ruby.ORDER_MULTIPLICATIVE],POWER:[" ** ",Blockly.Ruby.ORDER_EXPONENTIATION]}[a.getFieldValue("OP")],c=b[0];b=b[1];var d=Blockly.Ruby.valueToCode(a,"A",b)||"0";a=Blockly.Ruby.valueToCode(a,"B",b)||"0";return[d+c+a,b]};
Blockly.Ruby.math_single=function(a){var b=a.getFieldValue("OP");if("NEG"==b){var c=Blockly.Ruby.valueToCode(a,"NUM",Blockly.Ruby.ORDER_UNARY_SIGN)||"0";return["-"+c,Blockly.Ruby.ORDER_UNARY_SIGN]}a="SIN"==b||"COS"==b||"TAN"==b?"("+Blockly.Ruby.valueToCode(a,"NUM",Blockly.Ruby.ORDER_MULTIPLICATIVE)+")"||"0":"("+Blockly.Ruby.valueToCode(a,"NUM",Blockly.Ruby.ORDER_NONE)+")"||"0";switch(b){case "ABS":c=a+".abs";break;case "ROOT":c="Math.sqrt("+a+")";break;case "LN":c="Math.log("+a+")";break;case "LOG10":c=
"Math.log10("+a+")";break;case "EXP":c="Math.exp("+a+")";break;case "POW10":c="(10 ** "+a+")";break;case "ROUND":c=a+".round";break;case "ROUNDUP":c=a+".ceil";break;case "ROUNDDOWN":c=a+".floor";break;case "SIN":c="Math.sin("+a+" / 180.0 * Math::PI)";break;case "COS":c="Math.cos("+a+" / 180.0 * Math::PI)";break;case "TAN":c="Math.tan("+a+" / 180.0 * Math::PI)"}if(c)return[c,Blockly.Ruby.ORDER_FUNCTION_CALL];switch(b){case "ASIN":c="Math.asin("+a+") / Math::PI * 180";break;case "ACOS":c="Math.acos("+
a+") / Math::PI * 180";break;case "ATAN":c="Math.atan("+a+") / Math::PI * 180";break;default:throw"Unknown math operator: "+b;}return[c,Blockly.Ruby.ORDER_MULTIPLICATIVE]};
Blockly.Ruby.math_constant=function(a){var b={PI:["Math::PI",Blockly.Ruby.ORDER_MEMBER],E:["Math::E",Blockly.Ruby.ORDER_MEMBER],GOLDEN_RATIO:["(1 + Math.sqrt(5)) / 2",Blockly.Ruby.ORDER_MULTIPLICATIVE],SQRT2:["Math.sqrt(2)",Blockly.Ruby.ORDER_MEMBER],SQRT1_2:["Math.sqrt(1.0 / 2)",Blockly.Ruby.ORDER_MEMBER],INFINITY:["1/0.0",Blockly.Ruby.ORDER_ATOMIC]};a=a.getFieldValue("CONSTANT");return b[a]};
Blockly.Ruby.math_number_property=function(a){var b=Blockly.Ruby.valueToCode(a,"NUMBER_TO_CHECK",Blockly.Ruby.ORDER_MULTIPLICATIVE)||"0",c=a.getFieldValue("PROPERTY");if("PRIME"==c)return[Blockly.Ruby.provideFunction_("is_prime",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+" n","  return false if n < 0","  (2..Math.sqrt(n)).each { |i| return false if n % i == 0}","  true","end"])+"("+b+")",Blockly.Ruby.ORDER_FUNCTION_CALL];switch(c){case "EVEN":var d=b+".even?";break;case "ODD":d=b+".odd?";break;
case "WHOLE":d=b+" % 1 == 0";break;case "POSITIVE":d=b+" > 0";break;case "NEGATIVE":d=b+" < 0";break;case "DIVISIBLE_BY":a=Blockly.Ruby.valueToCode(a,"DIVISOR",Blockly.Ruby.ORDER_MULTIPLICATIVE);if(!a||"0"==a)return["false",Blockly.Ruby.ORDER_ATOMIC];d=b+" % "+a+" == 0"}return[d,Blockly.Ruby.ORDER_RELATIONAL]};
Blockly.Ruby.math_change=function(a){var b=Blockly.Ruby.valueToCode(a,"DELTA",Blockly.Ruby.ORDER_ADDITIVE)||"0";return Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("VAR"),Blockly.Variables.NAME_TYPE)+" += "+b+"\n"};Blockly.Ruby.math_round=Blockly.Ruby.math_single;Blockly.Ruby.math_trig=Blockly.Ruby.math_single;
Blockly.Ruby.math_on_list=function(a){var b=a.getFieldValue("OP");a=Blockly.Ruby.valueToCode(a,"LIST",Blockly.Ruby.ORDER_NONE)||"[]";switch(b){case "SUM":b=a+".sum";break;case "MIN":b=a+".numbers.min";break;case "MAX":b=a+".numbers.max";break;case "AVERAGE":b=a+".average";break;case "MEDIAN":b=a+".median";break;case "MODE":b=Blockly.Ruby.provideFunction_("math_modes",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(some_list)","  groups = some_list.group_by{|v| v}","  ","  groups = groups.sort {|a,b| b[1].size <=> a[1].size}",
"  ","  max_size = groups[0][1].size","  ","  modes = []","  ","  groups.each do |group|","    ","    break if group[1].size != max_size","    ","    modes << group[0]","    ","  end","  ","  modes","","end"])+"("+a+")";break;case "STD_DEV":b=a+".standard_deviation";break;case "RANDOM":b=a+"[rand("+a+".size)]";break;default:throw"Unknown operator: "+b;}return[b,Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.math_modulo=function(a){var b=Blockly.Ruby.valueToCode(a,"DIVIDEND",Blockly.Ruby.ORDER_MULTIPLICATIVE)||"0";a=Blockly.Ruby.valueToCode(a,"DIVISOR",Blockly.Ruby.ORDER_MULTIPLICATIVE)||"0";return[b+" % "+a,Blockly.Ruby.ORDER_MULTIPLICATIVE]};
Blockly.Ruby.math_constrain=function(a){var b=Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"0",c=Blockly.Ruby.valueToCode(a,"LOW",Blockly.Ruby.ORDER_NONE)||"0";a=Blockly.Ruby.valueToCode(a,"HIGH",Blockly.Ruby.ORDER_NONE)||"float('inf')";return["[["+b+", "+c+"].max, "+a+"].min",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.math_random_int=function(a){var b=Blockly.Ruby.valueToCode(a,"FROM",Blockly.Ruby.ORDER_NONE)||"0";a=Blockly.Ruby.valueToCode(a,"TO",Blockly.Ruby.ORDER_NONE)||"0";return["rand("+b+".."+a+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.math_random_float=function(a){return["rand",Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.procedures={};
Blockly.Ruby.procedures_defreturn=function(a){Blockly.Ruby.variableDB_.pushScope();for(var b=Blockly.Variables.allVariables(a),c=b.length-1;0<=c;c--){var d=b[c];-1==a.arguments_.indexOf(d)?b[c]=Blockly.Ruby.variableDB_.getRubyName(d,Blockly.Variables.NAME_TYPE):b.splice(c,1)}b=[];for(c=0;c<a.arguments_.length;c++)b[c]=Blockly.Ruby.variableDB_.addLocalVariable(a.arguments_[c],Blockly.Variables.NAME_TYPE);c=Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("NAME"),Blockly.Procedures.NAME_TYPE);d=
Blockly.Ruby.statementToCode(a,"STACK");Blockly.Ruby.INFINITE_LOOP_TRAP&&(d=Blockly.Ruby.INFINITE_LOOP_TRAP.replace(/%1/g,'"'+a.id+'"')+d);var e=Blockly.Ruby.valueToCode(a,"RETURN",Blockly.Ruby.ORDER_NONE)||"";e&&(e="\n  return "+e+"\n");b="def "+c+"("+b.join(", ")+")\n"+d+e+"end";b=Blockly.Ruby.scrub_(a,b);Blockly.Ruby.definitions_[c]=b;Blockly.Ruby.variableDB_.popScope();return null};Blockly.Ruby.procedures_defnoreturn=Blockly.Ruby.procedures_defreturn;
Blockly.Ruby.procedures_callreturn=function(a){for(var b=Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("NAME"),Blockly.Procedures.NAME_TYPE),c=[],d=0;d<a.arguments_.length;d++)c[d]=Blockly.Ruby.valueToCode(a,"ARG"+d,Blockly.Ruby.ORDER_NONE)||"None";return[b+"("+c.join(", ")+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.procedures_callnoreturn=function(a){for(var b=Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("NAME"),Blockly.Procedures.NAME_TYPE),c=[],d=0;d<a.arguments_.length;d++)c[d]=Blockly.Ruby.valueToCode(a,"ARG"+d,Blockly.Ruby.ORDER_NONE)||"None";return b+"("+c.join(", ")+")\n"};
Blockly.Ruby.procedures_ifreturn=function(a){var b="if "+(Blockly.Ruby.valueToCode(a,"CONDITION",Blockly.Ruby.ORDER_NONE)||"False")+"\n";a.hasReturnValue_?(a=Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"None",b+="\n  return "+a+"\n"):b+="\n  return\n";return b+"end\n"};Blockly.Ruby.text={};Blockly.Ruby.text=function(a){return[Blockly.Ruby.quote_(a.getFieldValue("TEXT")),Blockly.Ruby.ORDER_ATOMIC]};
Blockly.Ruby.text_join=function(a){if(0==a.itemCount_)return["''",Blockly.Ruby.ORDER_ATOMIC];if(1==a.itemCount_){var b=Blockly.Ruby.valueToCode(a,"ADD0",Blockly.Ruby.ORDER_NONE)||"''";return[b+".to_s",Blockly.Ruby.ORDER_FUNCTION_CALL]}if(2==a.itemCount_)return b=Blockly.Ruby.valueToCode(a,"ADD0",Blockly.Ruby.ORDER_NONE)||"''",a=Blockly.Ruby.valueToCode(a,"ADD1",Blockly.Ruby.ORDER_NONE)||"''",[b+".to_s + "+a+".to_s",Blockly.Ruby.ORDER_UNARY_SIGN];b=[];for(var c=0;c<a.itemCount_;c++)b[c]=(Blockly.Ruby.valueToCode(a,
"ADD"+c,Blockly.Ruby.ORDER_NONE)||"''")+".to_s";b=b.join(" + ");return[b,Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.text_append=function(a){var b=Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("VAR"),Blockly.Variables.NAME_TYPE);a=Blockly.Ruby.valueToCode(a,"TEXT",Blockly.Ruby.ORDER_NONE)||"''";return b+" = "+b+".to_s + ("+a+").to_s\n"};Blockly.Ruby.text_length=function(a){return[(Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"''")+".size",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.text_isEmpty=function(a){return[(Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"''")+".empty?",Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.text_indexOf=function(a){var b="FIRST"==a.getFieldValue("END")?".find_first":".find_last",c=Blockly.Ruby.valueToCode(a,"FIND",Blockly.Ruby.ORDER_NONE)||"''";return[(Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_MEMBER)||"''")+b+"("+c+")",Blockly.Ruby.ORDER_FUNCTION_CALL]};
Blockly.Ruby.text_charAt=function(a){var b=a.getFieldValue("WHERE")||"FROM_START",c=Blockly.Ruby.valueToCode(a,"AT",Blockly.Ruby.ORDER_UNARY_SIGN)||"1";a=Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_MEMBER)||"''";c=Blockly.isNumber(c)?parseInt(c,10)-1:c+".to_i - 1";switch(b){case "FIRST":return[a+"[0]",Blockly.Ruby.ORDER_MEMBER];case "LAST":return[a+"[-1]",Blockly.Ruby.ORDER_MEMBER];case "FROM_START":return b=Blockly.Ruby.provideFunction_("text_get_from_start",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+
" (text, index)",'  return "" if index < 0','  text[index] || ""',"end"]),[b+"("+a+", "+c+")",Blockly.Ruby.ORDER_FUNCTION_CALL];case "FROM_END":return b=Blockly.Ruby.provideFunction_("text_get_from_end",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+" (text, index)",'  return "" if index < 0','  text[-index-1] || ""',"end"]),[b+"("+a+", "+c+")",Blockly.Ruby.ORDER_FUNCTION_CALL];case "RANDOM":return b=Blockly.Ruby.provideFunction_("text_random_letter",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+
" (text)","  text[rand(text.size)]","end"]),[b+"("+a+")",Blockly.Ruby.ORDER_FUNCTION_CALL]}throw"Unhandled option (text_charAt).";};
Blockly.Ruby.text_getSubstring=function(a){var b=Blockly.Ruby.valueToCode(a,"STRING",Blockly.Ruby.ORDER_MEMBER)||"''",c=a.getFieldValue("WHERE1"),d=a.getFieldValue("WHERE2"),e=Blockly.Ruby.valueToCode(a,"AT1",Blockly.Ruby.ORDER_NONE)||"1";a=Blockly.Ruby.valueToCode(a,"AT2",Blockly.Ruby.ORDER_NONE)||"1";"FIRST"==c||"FROM_START"==c&&"1"==e?e="0":"FROM_START"==c?e=Blockly.isNumber(e)?parseInt(e,10)-1:t1+".to_i - 1":"FROM_END"==c&&(e=Blockly.isNumber(e)?-parseInt(e,10):"-"+e+".to_i");"LAST"==d||"FROM_END"==
d&&"1"==a?a="-1":"FROM_START"==d?a=Blockly.isNumber(a)?parseInt(a,10)-1:a+".to_i - 1":"FROM_END"==d&&(a=Blockly.isNumber(a)?-parseInt(a,10):a+".to_i");return[b+"["+e+".."+a+"]",Blockly.Ruby.ORDER_MEMBER]};
Blockly.Ruby.text_changeCase=function(a){var b={UPPERCASE:".upcase",LOWERCASE:".downcase",TITLECASE:null},c=b[a.getFieldValue("CASE")];c?(c=b[a.getFieldValue("CASE")],a=Blockly.Ruby.valueToCode(a,"TEXT",Blockly.Ruby.ORDER_MEMBER)||"''",a+=c):(c=Blockly.Ruby.provideFunction_("text_to_title_case",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(str)","  str.gsub(/\\S+/) {|txt| txt.capitalize}","end"]),a=Blockly.Ruby.valueToCode(a,"TEXT",Blockly.Ruby.ORDER_NONE)||"''",a=c+"("+a+")");return[a,Blockly.Ruby.ORDER_MEMBER]};
Blockly.Ruby.text_trim=function(a){var b={LEFT:".lstrip",RIGHT:".rstrip",BOTH:".strip"}[a.getFieldValue("MODE")];return[(Blockly.Ruby.valueToCode(a,"TEXT",Blockly.Ruby.ORDER_MEMBER)||"''")+b,Blockly.Ruby.ORDER_MEMBER]};Blockly.Ruby.text_print=function(a){return"blockly_puts("+(Blockly.Ruby.valueToCode(a,"TEXT",Blockly.Ruby.ORDER_NONE)||"''")+")\n"};
Blockly.Ruby.text_prompt=function(a){var b=Blockly.Ruby.provideFunction_("text_prompt",["def "+Blockly.Ruby.FUNCTION_NAME_PLACEHOLDER_+"(msg):","    print (msg)","    $stdin.gets"]),c=Blockly.Ruby.quote_(a.getFieldValue("TEXT"));b=b+"("+c+")";"NUMBER"==a.getFieldValue("TYPE")&&(b+=".to_f");return[b,Blockly.Ruby.ORDER_FUNCTION_CALL]};Blockly.Ruby.variables={};Blockly.Ruby.variables_get=function(a){return[Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("VAR"),Blockly.Variables.NAME_TYPE),Blockly.Ruby.ORDER_ATOMIC]};Blockly.Ruby.variables_set=function(a){var b=Blockly.Ruby.valueToCode(a,"VALUE",Blockly.Ruby.ORDER_NONE)||"0";return Blockly.Ruby.variableDB_.getRubyName(a.getFieldValue("VAR"),Blockly.Variables.NAME_TYPE)+" = "+b+"\n"};