/*
 * id : 对应表单元素的编号
 * title : 表单元素名称
 * type : 类型：文本框【textfield】，多选下拉菜单【lovcombo】、时间控件【datefield】
 * dataSource : 对应数据来源. textField的时候对应默认值。lovcombo时对应Ext.data.SimpleStore形式存储的数据.
 * width : 宽度。
 * columnWidth : 在一行中对应的百分比。
 * clazz : 样式。
 * */
function FormItem(id, title, type, dataSource, width,columnWidth, clazz) {
	this.id = id;
	this.title = title;
	this.type = type;
	this.width = width;
	this.columnWidth = columnWidth;
	this.clazz = clazz;
	this.getId= function(){
		return this.Id;
	};
	this.getTitle = function(){
		return this.title;
	};
	this.getType = function(){
		return this.type;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getColumnWidth = function(){
		return this.columnWidth;
	};
	this.getClazz = function(){
		return this.clazz;
	};
}