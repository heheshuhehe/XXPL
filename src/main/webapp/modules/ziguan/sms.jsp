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
	  }else if(filename!=".xls"){
		alert("请选择excel文件(仅支持excel2003版本)");
		return false;
	  }else if(content == ""){
			alert("请输入短信内容");
			return false;		
	  }else{
     	var formData = new FormData($( "#uploadfile" )[0]); 
	     $.ajax({   
	          url: '<%=cp%>/guzhibank/springUploadSMS',   
	          type: 'POST',   
	          data: formData,
	          async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false,   
	          dataType:"json",
	          success: function (data) { 
	          		if(data.msg="success"){
	            	 		file_down(fileName);
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
					/* reLoad(); */
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
 function file_searchs(rq){
 		
  $('#filepzdg').datagrid({url:"<%=cp%>/guzhibank/getFiledata?"+params}).datagrid('clientPaging'); 
 }
 //查询导入到数据库中
 function file_search(){
	 var rq = $('#rq').combobox('getValue')
	 var params="rq="+rq;
		var ids = [];
		var checkItems = $('#filepzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
		});
		ids = ids.unique();
		if(ids.length >1 ){
			params +="&ids="+ids;
		}

  	$('#filepzdg').datagrid({url:"<%=cp%>/guzhibank/getFiledataSMS?"+params}).datagrid('clientPaging'); 
 }
 
 function sms_test(){
	 var test_phone=$("#test_phone").val();
	 var content = $("#sms_content").val();
	 if(test_phone == "" || content == ""){
		 alert("请输入短信内容和测试电话！");
		 return;
	 }
	 $.ajax({
			url:'<%=cp%>/guzhibank/sendSMSTest',
			type:'post',
			data:{test_phone:test_phone,content:content},
			dataType: "json",
			success: function(data){
					alert(data.msg);
			}
		});
	 }
 
 function sms_go(){
		var ids = [];
		var checkItems = $('#filepzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
		});
		id = ids.unique();
		if(ids.length < 1){
			alert("请选择要发送的联系人!");
			return;
		}
	 $.ajax({
			url:'<%=cp%>/guzhibank/getFiledataSMSgo?ids='+id,
			type:'post',
			dataType: "json",
			success: function(data){
					alert(data.msg);
					file_search();
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
		 		短信内容：<input type="text" id="sms_content" name="sms_content"  style="width:300px"/>(短信中 #A列#将被替换成A列中的值，其他列同理 )<br />
		</div>
		<div style="float:left;margin-left: 30px;margin-top:4px;">
			<form id="uploadfile" style="float:left" enctype="multipart/form-data"> 
				<input type="file" name="file"id ="fi"> 
				<input type="button" value="导入文件"   onclick="upfile()"/> 
				</form>
		</div>
		<br/>
			<div style="float:left;margin-left: 15px;margin-top:4px;">
				测试电话：<input type="text" id="test_phone" name="test_phone"  style="width:300px"/> 	
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="sms_test()">测试</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'" onclick="sms_go()">发送</a>
			</div>
			<div style="float:left;margin-left: 15px;margin-top:4px;">
				<input id="rq" name="rq" class="easyui-datebox"  style="width: 120px"></input>
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="file_search()">查询</a> 
	  		</div>
<br /> <br /> 
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id"  data-options="hidden:true"></th>
						<th field="code" width="100">TA代码</th>
						<th field="name" width="150">产品名称</th>
						<th field="user_name" width="100">联系人</th>
						<th field="phone"  width="100">电话号码</th>
						<th field="content"  width="500">内容</th>
						<th field="dr" width="100">状态</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
	

	
	


</div>

	
	

</body>



