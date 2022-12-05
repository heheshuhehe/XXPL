<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="../guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>银行对账核对</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
		 $("#tabsidk").tabs({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-20
		 });
	
	 	 $("#filepzdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });	 	 
	 	 $("#contractdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });	
	 	 $("#contype").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getcontype',
             method:'post',
             multiple:true,
			  width:180,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	 	 $("#contype2").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getcontype',
             method:'post',
             multiple:true,
			  width:180,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	 	 $("#fundstatus").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getComboBoxSource?tbname= fund_zt@db49&code=id&name=zt_name&option=order by id ',
             method:'post',
             multiple:true,
			  width:180,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	 	 $("#fundstatus2").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getComboBoxSource?tbname= fund_zt@db49&code=id&name=zt_name&option=order by id ',
             method:'post',
             multiple:true,
			  width:180,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	 	  $("#teleSrc").combobox({
			  
			  onChange:changedisplay
		  });

/* //选择文件框	 
$('#fb').filebox({    
	buttonText: '选择文件', 
    buttonAlign: 'left' 
}); */

		 
		 var curr_time = new Date();
		var strDate = curr_time.getFullYear() + "-";
		strDate += curr_time.getMonth() + 1 + "-";
		strDate += curr_time.getDate() + "-";
		strDate += curr_time.getHours() + ":";
		strDate += curr_time.getMinutes() + ":";

		var strDate1 = curr_time.getFullYear() + "-";
		strDate1 += curr_time.getMonth() + 1 + "-";
		strDate1 += curr_time.getDate() - 1 + "-";
		strDate1 += curr_time.getHours() + ":";
		strDate1 += curr_time.getMinutes() + ":";
 		$("#wbdate").datebox('setValue',strDate);
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 Array.prototype.unique = function(){
	 var res = [];
	 var json = {};
	 for(var i = 0; i < this.length; i++){
	  if(!json[this[i]]){
	   res.push(this[i]);
	   json[this[i]] = 1;
	  }
	 }
	 return res;
	}
  function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:red;';
		}
 } 
  function myCellStyler4(value,row,index){
		if (!isNaN(value)){
			return 'color:red;background-color:#F6BCBC;';
		}
 }
 function myCellStyler1(value,row,index){
	var oDate = new Date();
	var year = oDate.getFullYear();   //获取系统的年；
	var mon =  oDate.getMonth()+1;   //获取系统月份，由于月份是从0开始计算，所以要加1
	var day = oDate.getDate(); // 获取系统日
	var str = year+""+mon+""+day;
	if(value<str){
		return 'color:#BFBCBC;';
	}
	
	
	
 }
function myformatter1(value,row,index){
 	 if(typeof(value)!='undefined'){ 
        if(!isNaN(value)){ //如果是数字 
 		 if(((value+"").indexOf("%")==-1)){//不带%号
 			  var  num = value+"";
 			  if(/^.*\..*$/.test(num)){
 			   var pointIndex =num.lastIndexOf(".");
 			   var intPart = num.substring(0,pointIndex);
 			   var pointPart =num.substring(pointIndex+1,pointIndex+5);
 			   intPart = intPart +"";
 			    var re =/(-?\d+)(\d{3})/;
 			    while(re.test(intPart)){
 			     intPart =intPart.replace(re,"$1,$2");
 			    }
 			   if(pointPart.length==1){
 				   pointPart = pointPart+"000";
 			   }else if(pointPart.length==2){
 				  pointPart = pointPart+"00";
 			   }else if(pointPart.length==3){
 				  pointPart = pointPart+"0";
 			   }
 			    num = intPart+"."+pointPart;
 			  }else{
 			    var re =/(-?\d+)(\d{3})/;
 			    while(re.test(num)){
 			     num =num.replace(re,"$1,$2");
 			    }
 			    num +=".0000";
 			 
 			    if(num==".0000"){
 			    	num="";
 			    }
 			    
 			  }
 			 
 			  return  "<span style='font-family:SimSun'>"+num+"</span>";
 		 }else{
 			 return "<span style='font-family:SimSun'>"+value+"</span>";
 	 	 }
 	   }else{//如果不是数字
 	      return "<span style='font-family:SimSun'>"+value+"</span>";  
 	   }
 	 }else{
 		 return "";
 	 }
 }
function myformatter2(value,row,index){
	 if(typeof(value)!='undefined'){ 
      if(!isNaN(value)){ //如果是数字 
		 if(((value+"").indexOf("%")==-1)){//不带%号
			  var  num = value+"";
			  if(/^.*\..*$/.test(num)){
			   var pointIndex =num.lastIndexOf(".");
			   var intPart = num.substring(0,pointIndex);
			   var pointPart =num.substring(pointIndex+1,pointIndex+3);
			   intPart = intPart +"";
			    var re =/(-?\d+)(\d{3})/;
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2");
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/;
			    while(re.test(num)){
			     num =num.replace(re,"$1,$2");
			    }
			    num +=".00";
			 
			    if(num==".00"){
			    	num="";
			    }
			  }
			  return  "<span style='font-family:SimSun'>"+num+"%"+"</span>";
		 }else{
			 return "<span style='font-family:SimSun'>"+value+"</span>";
	 	 }
	   }else{//如果不是数字
	       return "<span style='font-family:SimSun'>"+value+"</span>";
	   }
	 }else{
		 return "";
	 }
}
function myformatter3(value,row,index){
	 var re =/(\d{4})(\d{2})(\d{2})/;
	 while(re.test(value)){
		 value =value.replace(re,"$1-$2-$3");
	 }
	 return value;
}
/**************************查询*************************************/

 function changedisplay(n,o){
	if(n==1){
		  $("#conid").css('display','none');
		  $("#contype2").combobox('clear');
		  $("#fundstatus2").combobox('clear');

		  
	}
	if(n==2){
		  $("#conid").css('display','');
	}
	
}


 function checkValue_onHidePanel () {
     var _options = $(this).combobox('options');  
var _data = $(this).combobox('getData');
var _values = $(this).combobox('getValues');
     var values = [];
for (var i = 0; i < _data.length; i++) {  
     if(_values.indexOf(_data[i][_options.valueField]+"") != -1){
                     values.push(_data[i][_options.valueField]);
     }
     }
     $(this).combobox('setValues', values);  
}

 
 
function upfile() {   
	var content = document.getElementById("sms_content").value;
	var myFile = document.getElementById("fi").value;

	var length = myFile.length;
	var x = myFile.lastIndexOf("\\");
	x++; 
	var fileName = myFile.substring(x,length); 
	var filename=fileName.substring(fileName.lastIndexOf("."),fileName.length);
	 if (fileName=="") {
		alert("请选择要导入数据库的文件");
		return false;
	  }else{
     	var formData = new FormData($( "#uploadfile" )[0]); 
	     $.ajax({   
	          url: '<%=cp%>/guzhibank/springUploadexcel',   
	          type: 'POST',   
	          data: formData,
	          async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false,   
	          dataType:"json",
	          success: function (data) { 
	          		if(data.msg="success"){
	          			alert("导入成功！");
					}else if(data.msg="error"){
						alert("文件导入数据库失败！");
					} 
	          }
	     }); 
     }  
    
}  
 
/*  function show_confirm(){  
    var result = confirm('是否继续！');  
    if(result){  
        alert('删除成功！');  
    }else{  
        alert('不删除！');  
    }  
}  */ 
 /*********************银行对账核对导入文件********************************/
 //excel中的数据导入到数据库中
 
 function load(msg) {
		$("<div class=\"datagrid-mask\"></div>").css({
			display : "block",
			width : "100%",
			height : $(window).height()
		}).appendTo("body");
		$("<div class=\"datagrid-mask-msg\"></div>").html(msg)
				.appendTo("body").css({
					display : "block",
					left : ($(document.body).outerWidth(true) - 190) / 2,
					top : ($(window).height() - 45) / 2
				});
	}
//取消加载层  
	function reLoad() {
		$(".datagrid-mask").remove();
		$(".datagrid-mask-msg").remove();
		 var params="dr=1";
	  	$('#filepzdg').datagrid({url:"<%=cp%>/guzhibank/getFiledataSMS?"+params}).datagrid('clientPaging'); 
	}
	
	function disLoad(){
		$(".datagrid-mask").remove();
		$(".datagrid-mask-msg").remove();
	}
 function file_down(filename){
	 var content = $("#sms_content").val();
		$.ajax({
			url:'<%=cp%>/guzhibank/filedelupSMS',
			type:'post',
			data:{filename:filename,content:content},
			dataType: "json",
			beforeSend : function() {
				load("正在导入数据库中，请稍后...");
			},
			success: function(obj){
				if(obj.msg=="success"){
					reLoad();
					alert("文件导入数据库成功"); 
					//file_searchs();
				}else if(obj.msg="error"){
					disLoad();
					alert("文件导入数据库失败！");
				}
			}
			
		});
	
 }
 //导入数据库的数据先删除后插入

 //数据库中删除后插入的查询

 //查询导入到数据库中
 function file_search(){
	var teleSrc =$("#teleSrc").combobox('getValue');
	var params='?teleSrc='+teleSrc;
	 var contypes = $('#contype2').combobox('getValues');
	 var fundstatuses = $('#fundstatus2').combobox('getValues');
	 var contype = '';
	 var fundstatus='';
	 var zth='';
	 if(teleSrc==2){
		 if(contypes.length==0){
			 alert('必须选择联系人类型');
			 return;
		 }
		 if(fundstatuses.length==0){
				alert('必须选择基金状态');
				 return;
		}
    }
	if(contypes.length>0){
		for(var i=0;i<contypes.length;i++)
			contype+=contypes[i]+","
	}	
	
	if(fundstatuses.length>0){
		for(var i=0;i<fundstatuses.length;i++)
			fundstatus+=fundstatuses[i]+","
	}	
	 
	  params+="&zth="+zth+"&contype="+contype+"&fundstatus="+fundstatus;
  	$('#filepzdg').datagrid({url:"<%=cp%>/guzhibank/getFiledataExcel"+params}).datagrid('clientPaging'); 
 }
 function con_search(){
	 var zth = $('#c_port_name').textbox('getValue');
	 var contypes = $('#contype').combobox('getValues');
	 var fundstatuses = $('#fundstatus').combobox('getValues');
	 var contype = '';
	 var fundstatus='';
	if(contypes.length>0){
		for(var i=0;i<contypes.length;i++)
			contype+=contypes[i]+","
	}	
	if(fundstatuses.length>0){
		for(var i=0;i<fundstatuses.length;i++)
			fundstatus+=fundstatuses[i]+","
	}	
	 
	 var params="zth="+zth+"&contype="+contype+"&fundstatus="+fundstatus

  	$('#contractdg').datagrid({url:"<%=cp%>/guzhibank/getconinfo?"+params}).datagrid('clientPaging'); 
 }
 
 function sms_test(){
	  var teleSrc ='1';
		var params='?teleSrc='+teleSrc;
		
	 var test_phone=$("#test_phone").val();
	 var content = $("#sms_content").val();
	 if(test_phone == ""){
		 alert("请输入测试电话！");
		 return;
	 }
	 $.ajax({
			url:'<%=cp%>/guzhibank/sendSMSTestnew',
			type:'post',
			data:{test_phone:test_phone,content:content,teleSrc:'1'},
			dataType: "json",
			success: function(data){
					alert(data.msg);
			}
		});
	 }
 function con_down(){
	 var zth = $('#c_port_name').textbox('getValue');
	 var contypes = $('#contype').combobox('getValues');
	 var fundstatuses = $('#fundstatus').combobox('getValues');
	 var contype = '';
	 var fundstatus='';
	if(contypes.length>0){
		for(var i=0;i<contypes.length;i++)
			contype+=contypes[i]+","
	}	
	if(fundstatuses.length>0){
		for(var i=0;i<fundstatuses.length;i++)
			fundstatus+=fundstatuses[i]+","
	}	
	 
	 var params="zth="+zth+"&contype="+contype+"&fundstatus="+fundstatus
	 	
		var url="<%=cp%>/guzhibank/getconinfodown?"+params; 
		window.location.href=url;

	 }
 function mubandown(){
	
		var url="<%=cp%>/guzhibank/getconinfodownmuban"; 
		window.location.href=url;

	 }
 
 function sms_go(){
	/* 	var ids = [];
		var checkItems = $('#filepzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
		});
		id = ids.unique();
		if(ids.length < 1){
			alert("请选择要发送的联系人!");
			return;
		} */
	 var teleSrc =$("#teleSrc").combobox('getValue');
		var params='?teleSrc='+teleSrc;
		 var contypes = $('#contype2').combobox('getValues');
		 var fundstatuses = $('#fundstatus2').combobox('getValues');
		 var contype = '';
		 var fundstatus='';
		 var zth='';
		 if(teleSrc==2){
			 if(contypes.length==0){
				 alert('必须选择联系人类型');
				 return;
			 }
			 if(fundstatuses.length==0){
					alert('必须选择基金状态');
					 return;
			}
	    }
		if(contypes.length>0){
			for(var i=0;i<contypes.length;i++)
				contype+=contypes[i]+","
		}	
		
		if(fundstatuses.length>0){
			for(var i=0;i<fundstatuses.length;i++)
				fundstatus+=fundstatuses[i]+","
		}	
		 
		  params+="&zth="+zth+"&contype="+contype+"&fundstatus="+fundstatus;
	 $.ajax({
			url:'<%=cp%>/guzhibank/getFiledataSMSgoNew'+params,
			type:'post',
			dataType: "json",
			success: function(data){
					alert(data.msg);
					
			}
		});
	 }
 function selectbankid(account_name,msyh_id,jsyh_id,gsyh_id){
 	if(msyh_id!=null){
 		var msyh=msyh_id.split(",");
 		for(var i = 0; i < msyh.length; i++ ){
 			 
 		}
 	}
 	
 }

</script>
<body>
<div id="tabsidk" >

	<div title="短信发送" style="padding: 5px">
	  <div style ="height:40px;">
		 <div style ="float:left;height:5px;margin-left: 15px;" >
		 		<input type="text" id="sms_content" name="sms_content"  style="width:300px;display: none;"/><br />
		</div>
		<div style="float:left;margin-left: 30px;margin-top:4px;">
			<form id="uploadfile" style="float:left" enctype="multipart/form-data"> 
				<input type="file" name="file"id ="fi"> 
				<input type="button" value="导入文件"   onclick="upfile()"/> 
				(短信内容中     <span style="color: red">  #A列#  </span>  将被替换成   <span style="color: red">  A列 </span>中的值，其他列同理 )
				</form>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="mubandown()">模板下载</a> 
		</div>
		<br/>
			<div style="float:left;margin-left: 15px;margin-top:4px;">
				测试电话：<input type="text" id="test_phone" name="test_phone"  style="width:120px"/> 	
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="sms_test()">测试</a>
					<input id="rq" name="rq"  style="width: 120px;display: none"></input>
					 电话来源:  <select class="easyui-combobox"	name="teleSrc" id="teleSrc"  > 
					 	<option value="1"selected="selected" >来自excel中的电话列</option>
						<option value="2">根据产品名称自动匹配</option>
				
					 	</select>
			<span id="conid" style="display: none;">	  联系人类型:  <input class="easyui-combobox"	name="contype2" id="contype2" data-options="onHidePanel:checkValue_onHidePanel"  > 
			基金状态:  <input class="easyui-combobox"	name="fundstatus2" id="fundstatus2" data-options="onHidePanel:checkValue_onHidePanel" > 		</span>
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="file_search()">查询</a> 
	  		
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'" onclick="sms_go()">发送</a>
			</div>
		
<br /> <br /> 
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true,hidden:true"></th>
						<th field="id"  data-options="hidden:true"></th>
						<th field="fundname" >产品名称</th>
						<th field="phone" >电话号码</th>
						<th field="content" width="100">短信内容</th>
						<th field="cola" >A列</th>
						<th field="colb" >B列</th>
						<th field="colc" >C列</th>
						<th field="cold" >D列</th>
						<th field="realnum" >实际发送号码</th>
						
					</tr>
				</thead>
			</table>
		</div>
 </div>
	

	
	


</div>
	<div title="系统默认联系人查询" style="padding: 5px">
	<span>产品名称:</span> 		<input class="easyui-textbox"		name="c_port_name" id="c_port_name"  >
		 联系人类型:  <input class="easyui-combobox"	name="contype" id="contype"  > 	
		基金状态:  <input class="easyui-combobox"	name="fundstatus" id="fundstatus"  > 	
		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="con_search()">查询</a>
		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="con_down()">导出</a></br></br>
	<table  id="contractdg"  style="margin-top: 20px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:50
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true,hidden:true"></th>
						<th field="id"  data-options="hidden:true"></th>
						<th field="fund_code"  >基金编码</th>
						<th field="fund_name"  >产品名称</th>
						<th field="jiaose_name"  >联系人类型</th>
						<th field="user_name" >联系人姓名</th>
						<th field="telephone"  >手机号码</th>
						<th field="zuoji"  >座机</th>
						<th field="email"  >邮箱</th>
					</tr>
				</thead>
			</table>
	</div>
	
	

</body>



