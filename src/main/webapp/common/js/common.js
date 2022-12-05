$(function(){
	/*奇偶行颜色控制。*/
	$(".hovertable tr:odd").addClass("odd-row");
	$(".hovertable tr:even").addClass("even-row");
	
	/*table 悬浮样式控制*/
	/*悬浮样式调整*/
	$(".hovertable tr").mouseover(function (){
		 $(this).addClass("over");
	});
	
	/*恢复原来的样式*/
	$(".hovertable tr").mouseout(function (){
		 $(this).removeClass("over");
	});
	
	/*导航条样式控制*/
	/*移入显示边框*/
	$(".tools_bar_imgs td img").mouseover(function (){
		 $(this).addClass("imgover");
	});
	
	/*移除恢复原状*/
	$(".tools_bar_imgs td img").mouseout(function (){
		 $(this).removeClass("imgover");
	});
	
});

/* 如果空值，赋""*/
function ifNull(exp){
	if(exp==null || typeof(exp)=="undefined"){
		return '';
	}
	return exp;
}
/* 判空*/
function isNull(exp){
	return exp==null || typeof(exp)=="undefined";
}
/* 判端字符串*/
function isNullString(exp){
	return exp==null || typeof(exp)=="undefined"||exp=="";
}
/* 数值型判断*/
function isNumber(val)
{
	 val = parseInt(val+'');
	 alert(typeof val);
     return typeof val == 'number' ;
}

/**
 * 移动选择的DIV
 * 
 * @return
 */
function Drag()
{
 // 初始化
 this.initialize.apply(this, arguments)
}
Drag.prototype = {
 // 初始化
 initialize : function (drag, options)
 {
  this.drag = this.$(drag);
  this._x = this._y = 0;
  this._moveDrag = this.bind(this, this.moveDrag);
  this._stopDrag = this.bind(this, this.stopDrag);
 
  this.setOptions(options);
 
  this.handle = this.$(this.options.handle);
  this.maxContainer = this.$(this.options.maxContainer);
 
  this.maxTop = Math.max(this.maxContainer.clientHeight, this.maxContainer.scrollHeight) - this.drag.offsetHeight;
  this.maxLeft = Math.max(this.maxContainer.clientWidth, this.maxContainer.scrollWidth) - this.drag.offsetWidth;
 
  this.limit = this.options.limit;
  this.lockX = this.options.lockX;
  this.lockY = this.options.lockY;
  this.lock = this.options.lock;
 
  this.onStart = this.options.onStart;
  this.onMove = this.options.onMove;
  this.onStop = this.options.onStop;
 
  this.handle.style.cursor = "move";
 
  this.changeLayout();
 
  this.addHandler(this.handle, "mousedown", this.bind(this, this.startDrag))
 },
 changeLayout : function ()
 {
  this.drag.style.top = this.drag.offsetTop + "px";
  this.drag.style.left = this.drag.offsetLeft + "px";
  this.drag.style.position = "absolute";
  this.drag.style.margin = "0"
 },
 startDrag : function (event)
 {  
  var event = event || window.event;
 
  this._x = event.clientX - this.drag.offsetLeft;
  this._y = event.clientY - this.drag.offsetTop;
 
  this.addHandler(document, "mousemove", this._moveDrag);
  this.addHandler(document, "mouseup", this._stopDrag);
 
  event.preventDefault && event.preventDefault();
  this.handle.setCapture && this.handle.setCapture();
 
  this.onStart()
 },
 moveDrag : function (event)
 {
  var event = event || window.event;
 
  var iTop = event.clientY - this._y;
  var iLeft = event.clientX - this._x;
 
  if (this.lock) return;
 
  this.limit && (iTop < 0 && (iTop = 0), iLeft < 0 && (iLeft = 0), iTop > this.maxTop && (iTop = this.maxTop), iLeft > this.maxLeft && (iLeft = this.maxLeft));
 
  this.lockY || (this.drag.style.top = iTop + "px");
  this.lockX || (this.drag.style.left = iLeft + "px");
 
  event.preventDefault && event.preventDefault();
 
  this.onMove()
 },
 stopDrag : function ()
 {
  this.removeHandler(document, "mousemove", this._moveDrag);
  this.removeHandler(document, "mouseup", this._stopDrag);
 
  this.handle.releaseCapture && this.handle.releaseCapture();
 
  this.onStop()
 },
 // 参数设置
 setOptions : function (options)
 {
  this.options =
  {
   handle:   this.drag, // 事件对象
   limit:   true, // 锁定范围
   lock:   false, // 锁定位置
   lockX:   false, // 锁定水平位置
   lockY:   false, // 锁定垂直位置
   maxContainer: document.documentElement || document.body, // 指定限制容器
   onStart:  function () {}, // 开始时回调函数
   onMove:   function () {}, // 拖拽时回调函数
   onStop:   function () {}  // 停止时回调函数
  };
  for (var p in options) this.options[p] = options[p]
 },
 // 获取id
 $ : function (id)
 {
  return typeof id === "string" ? document.getElementById(id) : id
 },
 // 添加绑定事件
 addHandler : function (oElement, sEventType, fnHandler)
 {
  return oElement.addEventListener ? oElement.addEventListener(sEventType, fnHandler, false) : oElement.attachEvent("on" + sEventType, fnHandler)
 },
 // 删除绑定事件
 removeHandler : function (oElement, sEventType, fnHandler)
 {
  return oElement.removeEventListener ? oElement.removeEventListener(sEventType, fnHandler, false) : oElement.detachEvent("on" + sEventType, fnHandler)
 },
 // 绑定事件到对象
 bind : function (object, fnHandler)
 {
  return function ()
  {
   return fnHandler.apply(object, arguments) 
  }
 }
};

function closeDiv(divID){	
document.getElementById(divID).style.display="none";
}

/**
*	弹出框
* @param dId  div的id
* @param tid    标题id
* @param tContent  标题
* @param dWidth   宽
* @param dHeight   高
* @param dTop   距离顶
* @param dLeft  距离左
* @param dZIndex    堆叠顺序
* @return
*/

function dragDiv(dId,tid,tContent,dWidth,dHeight,dTop,dLeft,dzIndex){
    
     var oBox = document.getElementById(dId);
     var id=oBox.getAttribute("id");
     var oTitle = document.getElementById(tid);
     var Top=dTop==""?"250":dTop;
     var Left=dLeft==""?"250":dLeft;
     oBox.style.cssText="width:"+dWidth+"px;height:"+dHeight+"px; position:absolute;top:"+Top+"px;left:"+Left+"px; z-index:"+dzIndex+";margin:0;padding:0; border:10px #E2ECF4 solid; background-color:#FFFFFF;";
     oTitle.style.cssText="height:25px;width:auto;background:#D9EBFC;font-size:16px;line-height:25px; font-weight: bolder;color:#D9EBFC";
    
     oTitle.innerHTML=("<div style='float:left;height:25px;color:#0E395A'>"+tContent+"</div> <img id='clse' onclick='closeDiv(\""+id+"\")' src='../clse.jpg' style='position:relative; height:20px; float:right; width:20px; cursor:pointer;margin-top:2px;'/>");    
     var oDrag = new Drag(oBox, {handle:oTitle, limit:false});
}