//var cz = new OprListGridField("cz","操作","调整",50,"billChange","class2");
function OprListGridField(name, title,trContent, width,clickName,clazz) {
	this.type = 'OprListGridField';
	this.name = name;
	this.title = title;
	this.trContent = trContent;
	this.width = width;
	this.clickName = clickName;
	this.clazz = clazz;
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
	this.getTrContent = function(){
		return this.trContent;
	};
	this.getWidth = function(){
		return this.width;
	};
	this.getClickName = function(){
		return this.clickName;
	};
	this.getClazz = function(){
		return this.clazz;
	};
}