//ListGrid对应的是数据表格。
function GyWindow() {
	this.type = 'GyWindow';
	this.getType = function(){
		return this.type;
	};
	
	var args = arguments;
	this.getForms = function(){
		return args;
	};
}