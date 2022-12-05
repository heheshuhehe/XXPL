/*
 * line
 * xtype 类型
 * id
 * name
 * fieldLabel
 * width
 * format
 * store
 
//初始化FieldSet
function ListFieldSet(line,xtype, id, name, fieldLabel,width,format,store) {
	this.line = line;
	this.xtype = xtype;
	this.id = id;
	this.name = name;
	this.fieldLabel = fieldLabel;
	this.width = width;
	this.format = format;
	this.store = store;
	this.getLine = function(){
		return this.line;
	};
	this.getXtype = function(){
		return this.xtype;
	};
	this.getId = function(){
		return this.id;
	};
	this.getName = function(){
		return this.name;
	};
	this.getFieldLabel = function(){
		return this.fieldLabel;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getFormat = function(){
		return this.format;
	};
	this.getStore = function(){
		return this.store;
	};
}

//
function ListWindow(F_title,id,W_title,width,y) {
	this.F_title = F_title;
	this.id = id;
	this.W_title = W_title;
	this.width = width;
	this.y = y;
	this.getF_title = function(){
		return this.F_title;
	};
	this.getId = function(){
		return this.id;
	};
	this.getW_title = function(){
		return this.W_title;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getY = function(){
		return this.y;
	};
}*/


//ListGrid对应的是数据表格。
function ListGridSet() {
	this.type = 'ListGridSet';
	this.getType = function(){
		return this.type;
	};
	
	var args = arguments;
	this.getListGridFields = function(){
		return args;
	};
}
/*
 * line  行号
 * xtype 类型
 * id  
 * fieldLabel  名称
 * width  宽度
 * format 
 * store 
 */
//初始化FieldSet  输入框
function ListFieldSetText(line, id, fieldLabel,width) {
	this.xtype = 'textfield';
	this.line = line;
	this.id = id;
	this.fieldLabel = fieldLabel;
	this.width = width;
	this.getLine = function(){
		return this.line;
	};
	this.getXtype = function(){
		return this.xtype;
	};
	this.getId = function(){
		return this.id;
	};
	this.getFieldLabel = function(){
		return this.fieldLabel;
	};
	this.getWidth = function(){
		return this.width;
	};
}

//初始化FieldSet  下拉框（单选）
function ListFieldSetCombo(line, id, fieldLabel,width,store) {
	this.xtype = 'combo';
	this.line = line;
	this.id = id;
	this.fieldLabel = fieldLabel;
	this.width = width;
	this.store = store;
	this.getLine = function(){
		return this.line;
	};
	this.getXtype = function(){
		return this.xtype;
	};
	this.getId = function(){
		return this.id;
	};
	this.getFieldLabel = function(){
		return this.fieldLabel;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getStore = function(){
		return this.store;
	};
}
//初始化FieldSet  下拉框（多选）
function ListFieldSetLovCombo(line, id, fieldLabel,width,store) {
	this.xtype = 'lovcombo';
	this.line = line;
	this.id = id;
	this.fieldLabel = fieldLabel;
	this.width = width;
	this.store = store;
	this.getLine = function(){
		return this.line;
	};
	this.getXtype = function(){
		return this.xtype;
	};
	this.getId = function(){
		return this.id;
	};
	this.getFieldLabel = function(){
		return this.fieldLabel;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getStore = function(){
		return this.store;
	};
}
//初始化FieldSet  日期
function ListFieldSetDate(line, id, fieldLabel,width,format) {
	this.xtype = 'datefield';
	this.line = line;
	this.id = id;
	this.fieldLabel = fieldLabel;
	this.width = width;
	this.format = format;
	this.getLine = function(){
		return this.line;
	};
	this.getXtype = function(){
		return this.xtype;
	};
	this.getId = function(){
		return this.id;
	};
	this.getFieldLabel = function(){
		return this.fieldLabel;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getFormat = function(){
		return this.format;
	};
}
//初始化FieldSet  按钮
function ListFieldSetButton(line, fieldLabel,fun) {
	this.xtype = 'button';
	this.line = line;
	this.fieldLabel = fieldLabel;
	this.fun = fun;
	this.getLine = function(){
		return this.line;
	};
	this.getXtype = function(){
		return this.xtype;
	};
	this.getFieldLabel = function(){
		return this.fieldLabel;
	};
	this.getFun = function(){
		return this.fun;
	};
}
//初始化Window  其他
function ListWindow(F_title,id,W_title,width,y) {
	this.xtype = 'ListWindow';
	this.F_title = F_title;
	this.id = id;
	this.W_title = W_title;
	this.width = width;
	this.y = y;
	this.getF_title = function(){
		return this.F_title;
	};
	this.getId = function(){
		return this.id;
	};
	this.getW_title = function(){
		return this.W_title;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getY = function(){
		return this.y;
	};
}