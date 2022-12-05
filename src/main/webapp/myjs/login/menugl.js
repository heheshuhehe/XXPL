var i = 4 ; 
var tabs;
	//操作
    var oper= "";
    //默认父节点id
    var parnode = "";
function addtab1(obj){
	returnmain();
	var arr = obj.split("@_@");
	for ( var i = 0; i < arr.length; i++) {
		if(arr[i]=="undefined"){
			arr[i] = "";
		}
	}
	//清空页面
	$("#menucode").val("");
	$("#menuname").val("");
	$("#fmenucode").val("");
	$("#menuurl").val("");
	$("#menuimg").val("");
	$("#menuorder").val("");
	//修改默认父节点
	parnode = arr[0];
	//赋值
	$("#menucode").val(arr[0]);
	$("#menuname").val(arr[1]);
	$("#fmenucode").val(arr[2]);
	$("#menuurl").val(arr[3]);
	$("#menuimg").val(arr[4]);
	$("#menuorder").val(arr[5]);
}



Ext.onReady(function(){
	var dataPara = {
			oper:"query"
	  };
	oper = "query";
	list(dataPara);
});

function initmethod(){
	var dataPara = {
			oper:"query"
	  };
	oper = "query";
	list(dataPara);
}
function list(data){
	$.ajax({
		url : '../../qMenu.asp?mathid='+Math.random(),
		data : data,
		type : 'post',
		dataType:'json',//接受数据格式 
		success : function(data) {
			if(oper == "query"){
				initMenu(data);
			}else{
				initmethod();
			}
		},
		failure : function(data) {
			alert('初始化菜单失败');
		}
	});
}

function initChildTree(data,parnode){
	var str = '';
	var ss = false;
	for (var j = 0; j <data.length ; j++) 
	{
		var json = data[j];
		if(json.fcdid==parnode){
			ss = true;
			var ob = json.cdid+"@_@"+json.cdname+"@_@"+json.fcdid+"@_@"+json.cdurl+"@_@"+json.imgpath+"@_@"+json.cdsx;
			var childs = 0;
			for(var k =0 ;k<data.length; k++){
				if(data[k].fcdid==json.cdid){
					childs++;
				}
			}
			if(childs>0){
				str =str+"{'text':'"+json.cdname+"','expanded':false,'listeners':{'click':function(){addtab1('"+ob+"');}},'children':[";
				str += initChildTree(data,json.cdid);
				str = str + "]";
			}else{
				str =str+"{'text':'"+json.cdname+"','leaf':true,'listeners':{'click':function(){addtab1('"+ob+"');}}";
			}
			str +="},";
		}
	}
	if(ss){
		str = str.substring(0,str.length-1);
	}else{
		str =str +"{}";
	}
	return str;
}

function initTreeMenu(data) {
	var str = "{'text':'菜单','expanded':true,'lines':false,'children':[";
	 for (var i = 0; i < data.length; i++) 
	 {
		 var json = data[i];
		if(json.fcdid=='0'){
			var ob = json.cdid+"@_@"+json.cdname+"@_@"+json.fcdid+"@_@"+json.cdurl+"@_@"+json.imgpath+"@_@"+json.cdsx;
			str =str+"{'text':'"+json.cdname+"','expanded':false,'listeners':{'click':function(){addtab1('"+ob+"');}},'children':[";
			str += initChildTree(data,json.cdid);
			str = str + "]},";
		}
	}
	 str = str.substring(0,str.length-1);
	 str = str + "]};";
	 return str;
}


function initMenu(data){
	var jsonData = initTreeMenu(data);
	var obj =  (new Function("return" + jsonData))(); 
	$("#divleft").html("");
	new Ext.tree.TreePanel({  
		renderTo:"divleft", 
		height : 900 ,
        loader: new Ext.tree.TreeLoader(),
        root: new Ext.tree.AsyncTreeNode(
        		obj
        		)
    }); 
	$('.x-tree-root-ct').parent().css({'height':'500px','overflow':'auto'});
}
//添加根节点
function insertroot(){
	main.style.display = "none";
	father.style.display = "";
	chliern.style.display = "none";
	$("#menucode1").val("");
	$("#menuname1").val("");
	$("#menuimg1").val("");
	$("#menuorder1").val("");
}
//添加子节点
function insertcode(){
	if(parnode==null||parnode==""){
		Ext.MessageBox.alert("警告","必须选中一个菜单",180);
		return;
	}
	main.style.display = "none";
	father.style.display = "none";
	chliern.style.display = "";
	//赋值
	$("#menucode2").val("");
	$("#menuname2").val("");
	$("#fmenucode2").val(parnode);
	$("#menuurl2").val("");
	$("#menuimg2").val("");
	$("#menuorder2").val("");
}
//返回主页面
function returnmain(){
	main.style.display = "";
	father.style.display = "none";
	chliern.style.display = "none";
	
}

function getMenuCode(menuName){
	var arrs = menuName.split(' ');
	if(arrs.length <= 1){
		alert('菜单名称，输入不合法！');
		return null;
	}
	var result = '';
	var cd_cjs = arrs[0].split('.');
	for(var i=0;i<cd_cjs.length;i++){
		cd_cj = cd_cjs[i];
		if(cd_cj.length==1){
			cd_cj ='0'+cd_cj;
		}
		result+=cd_cj;
	}
	return result;
}

function operName(opername){
	oper = opername;
	var flag = false;
	if(opername=='update'){
		var old_menuCode = $("#menucode").val();
		var menuname2 = $("#menuname").val();
		$("#menucode").val(getMenuCode(menuname2));
		flag = confirm("确认修改？");
		data = {
				cdid:$("#menucode").val(),
				fcdid:$("#fmenucode").val(),
				cdname:$("#menuname").val(),
				imgpath:$("#menuimg").val(),
				cdurl:$("#menuurl").val(),
				OLD_MENUCODE:old_menuCode,
				oper : opername
		  };
	}else if (opername=='insertf') {
		var menuname1 = $("#menuname1").val();
		$("#menucode1").val(getMenuCode(menuname1));
		flag = confirm("确认新增根节点？");
		data = {
				cdid:$("#menucode1").val(),
				cdname:$("#menuname1").val(),
				imgpath:$("#menuimg1").val(),
				fcdid:'0',
				cdurl:"",
				oper : 'insert'
		  };
		
	}else if (opername=='insertc') {
		var menuname2 = $("#menuname2").val();
		$("#menucode2").val(getMenuCode(menuname2));
		flag = confirm("确认新增子节点？");
		data = {
				cdid:$("#menucode2").val(),
				fcdid:$("#fmenucode2").val(),
				cdname:$("#menuname2").val(),
				imgpath:$("#menuimg2").val(),
				cdurl:$("#menuurl2").val(),
				oper : 'insert'
		  };
		
	}else if (opername=='delete') {
		flag = confirm("确认删除？");
		data = {
				cdid:$("#menucode").val(),
				oper : opername
		  };
		
	}
	if(flag){
		list(data);
	}
	returnmain();
}
