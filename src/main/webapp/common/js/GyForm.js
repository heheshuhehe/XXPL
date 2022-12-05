//ListGrid对应的是数据表格。
function GyForm() {
	this.type = 'GyForm';
	this.getType = function(){
		return this.type;
	};
	
	var args = arguments;
	this.getFormItems = function(){
		return args;
	};
}