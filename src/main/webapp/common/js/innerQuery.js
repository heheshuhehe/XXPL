var tt=new Object();
var hzs_innerQueryWin=new Object();
var peleid=new Object();//需要显示选中值的位置
var pformat=new Object();//显示数据的格式
var gridstr=new Object();
var pfunid=new Object();
var pwidth=new Object();
function  hzs_innerQuery(funid,queryWin,eleid,title,format,listgrid,width){
	queryWin.show();
	queryWin.hide();
	tt=title;
	peleid=eleid;
	pformat=format;
	gridstr=listgrid;
	gridstr=encodeURI(encodeURI(gridstr));
	pfunid=funid;
	pwidth=width;
	//console.log("111"+pwidth);
	if(''==pwidth||undefined==pwidth){
		pwidth=620;
	}
	//console.log("2222"+pwidth);
	 $("#"+eleid).after('<img class="x-form-trigger" onclick="hzs_getQueryWin()" src="../images/s.gif"/>');
}
function setData(allTrDataMap_Checked,allTrDataMap){
	 var formats=pformat.split("-");
	 var val="";
	 for(var i=0;i<formats.length;i++){
		 var f=formats[i];
		 for(var j=0;j<allTrDataMap_Checked['f_20123js'].length;j++){
			 //console.log(allTrDataMap_Checked[j]);
				 val+=allTrDataMap['f_20123js'][allTrDataMap_Checked['f_20123js'][j]][f];
		 }
		 if(i<formats.length-1){
			 val+="-";
		 }
	 }
	 $("#"+peleid).val(val);
	 hzs_innerQueryWin.destroy();
}
function hzs_getQueryWin(){
	//查询窗口公共定义
	hzs_innerQueryWin = new Ext.Window({ 
		id:'hzs_innerQueryWin',
		title:tt,
		closeable:true,
		draggable:true,
		shadow:false,
		width:pwidth,
		height:381,
		modal:true,     
        items: [{  title: '弹出的窗口', 
                            header:false, 
                            html : '<iframe style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; width:='+pwidth+'px; height: 350px; border-right-width: 0px" src=../jsp/innerQueryGrid.jsp?str='+gridstr+'&fun=\''+pfunid+'\'  frameborder="0" width="100%" scrolling="no" height="100%"></iframe>', 
                            border:false 
                        }] 
    }); 
	hzs_innerQueryWin.show();
}

function getStr(){
	
}