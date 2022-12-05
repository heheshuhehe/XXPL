//ListGrid对应的是数据表格。
function ListGrid(arrs) {
	this.type = 'ListGrid';
	this.getType = function(){
		return this.type;
	};
	//根据第一个参数有没有getType方法进行判断。ListGridField有该方法，数组没有。
	//如果有：参数形式是--> ListGridField1,ListGridField2...ListGridFieldN。
	//如果没有：参数-->ListGridField[]
	var args = 'getType' in arrs ? arguments : arrs;
	this.getListGridFields = function(){
		return args;
	};
}