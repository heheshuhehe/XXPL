function ListGridField(name, title, width, clazz, oprs) {
	this.type = 'ListGridField';
	this.name = name;
	this.title = title;
	this.width = width;
	this.clazz = clazz;
	this.oprs = oprs;
	this.getType = function(){
		return this.type;
	};
	this.sayName = function() {
		alert(this.name);
	};
	this.getName = function(){
		return this.name;
	};
	this.getTitle = function(){
		return this.title;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getClazz = function(){
		return this.clazz;
	};
	this.getOprs = function(){
		return this.oprs;
	};
}
