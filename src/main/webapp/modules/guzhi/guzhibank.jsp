<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
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
	     //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-120
		 });
		 $("#bankpzdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-100
	 	 });
	 	 $("#filepzdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });	 	 
//初始化账套信息下拉框	 	 
$("#account_names").combobox({
		valueField: 'value',
 		textField: 'text',
 		mode:'local',
 		url:'<%=cp%>/guzhibank/InitAccountBox',
  		method:'post',
		multiple:false,
		width:200,
		filter: function(q, row){
		var opts = $(this).combobox('options');
		console.log(opts);
		return row[opts.textField].indexOf(q) >-1;
		},
		onLoadSuccess: function(){
	 	$('#account_names').next('.combo').find('input').focus(function (){
         	 $('#account_names').combobox('clear');
    			});
   		 }
 }); 
 
$("#userInfo").combobox({
    valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
    method:'post',
	  multiple:false,
	  width:150,
	  filter: function(q, row){
				var opts = $(this).combobox('options');
				return row[opts.textField].indexOf(q) >-1;
			},
	 onLoadSuccess: function(){
		 $('#userInfo').next('.combo').find('input').focus(function (){
	            $('#userInfo').combobox('clear');
	     });
   }
});

//初始化基金名称下拉框	 
$("#jj_mc").combobox({
    valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01&type=nopeizhi',
   method:'post',
	  multiple:false,
	  width:250,
	  filter: function(q, row){
				var opts = $(this).combobox('options');
				return row[opts.textField].indexOf(q)>-1;
			},
	 onLoadSuccess: function(){
		 $('#wbzth').next('.combo').find('input').focus(function (){
	            $('#wbzth').combobox('clear');
	     });
   }
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
function searchdata(){
 	
	  var str =$("#wbdates").combobox('getValue');
	  var userInfo = $("#userInfo").combobox('getValue')
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 
        var params="wbdate="+str.replace(/-/g,'');
        
        /* if($("#iseql").prop("checked")){
        	params +="&iseql=1";
        }*/
        if($("#isbd").prop("checked")){
        	params +="&isbd=1";
        } 
        if($("#t3").combobox('getValue')!=""){
        	params +="&tday="+$("#t3").combobox('getValue');
        } 
        if($("#datasrc").combobox('getValue')!=""){
        	params +="&datasrc="+$("#datasrc").combobox('getValue');
        } 
        if($("#wb_zth").combobox('getValue')!=""){
        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
        }
        if(userInfo != ""){
        	params += "&userInfo="+userInfo;
        }
        $('#dg').datagrid({method:'get',
        	               url:"guzhibank/selectyhdzhd?"+params,
        	               onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
				            	    // alert(data.rows.length);
					            	     if(typeof(data.rows[0].sumbd)!="undefined"){
		 			            	        $("#sumnoteql").html("<span style='color:red;font-size:8px;'>"+data.rows[0].sumbd+"</span><span style='font-size:8px;'>个产品有差额!</span>");
					            	     }
				            	     } else {
				            	     		$("#sumnoteql").html("");
				            	     }
				           }}).datagrid('clientPaging'); 
	  }
      
 }
 
 function show_confirm(){  
    var result = confirm('是否继续！');  
    if(result){  
        alert('删除成功！');  
    }else{  
        alert('不删除！');  
    }  
}  
 /********************银行对账核对操作***********************/
 
 
 
 //银行对账核对匹配数据查询
 function pz_searchdata(){
  		 var params="account_names="+$("#account_names").combobox('getValue');
  		 $('#bankpzdg').datagrid({url:"<%=cp%>/guzhibank/selectaccadbank?"+params}).datagrid('clientPaging'); 
 }
 //银行对账核对匹配添加配置
 function pz_adddata(){
 
 
 $("#zt").combobox({
		valueField: 'value',
 		textField: 'text',
 		mode:'local',
 		url:'<%=cp%>/guzhibank/InitStatusBox',
  		method:'post',
		multiple:false,
		width:180,
		filter: function(q, row){
		var opts = $(this).combobox('options');
		console.log(opts);
		return row[opts.textField].indexOf(q) >-1;
		},
		onLoadSuccess: function(){
	 	$('#zt').next('.combo').find('input').focus(function (){
         	 $('#zt').combobox('clear');
    			});
   		 }
 }); 
 
//初始化新增配置账套信息下拉框	 
$("#account_newname").combobox({
		valueField: 'value',
 		textField: 'text',
 		mode:'local',
 		url:'<%=cp%>/guzhibank/InitNewAccountBox',
  		method:'post',
		multiple:false,
		width:180,
		filter: function(q, row){
		var opts = $(this).combobox('options');
		console.log(opts);
		return row[opts.textField].indexOf(q) >-1;
		},
		onLoadSuccess: function(){
	 	$('#account_newname').next('.combo').find('input').focus(function (){
         	 $('#account_newname').combobox('clear');
    			});
   		 }
 }); 
  
 	  $('#hdpz').dialog('open');
 
 }
 
 //保存银行对账核对修改数据
 function pz_ensures(){
  var  account_id=$("#account_newnames").combobox('getValue');
  var  zt=$("#zts").combobox('getValue');
  var  jiexi=$("#t2").combobox('getValue');
  var  biaoshi=$("#biaoshis").textbox('getValue');
  var  account_newname=$("#account_newnames").combobox('getText');
  var msyh_zh = $("#msyh_zhs").textbox('getValue');
  	  msyh_zh=trim(msyh_zh);
  	 
  var jsyh_zh = $("#jsyh_zhs").textbox('getValue').trim();
  	  jsyh_zh=trim(jsyh_zh);
  var gsyh_zh = $("#gsyh_zhs").textbox('getValue').trim();
  	  gsyh_zh=trim(gsyh_zh);
  	 var jtyh_zh = $("#jtyh_zhs").textbox('getValue').trim();
  	jtyh_zh=trim(jtyh_zh);
 if (account_id=="") {
	alert('账套名称不能为空');
	return false;
}else if(gsyh_zh==""&&msyh_zh==""&&jsyh_zh==""&&jtyh_zh==""){ 
	alert('银行账号至少有一个不为空!');
	return false;
}else {
	$.ajax({
		url:'<%=cp%>/guzhibank/updateaccountbank',
		type:'post',
		data:{account_newname:account_newname,gsyh_zh:gsyh_zh,msyh_zh:msyh_zh,jsyh_zh:jsyh_zh,account_id:account_id,zt:zt,jiexi:jiexi,biaoshi:biaoshi,jtyh_zh:jtyh_zh},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("保存成功");
				
				pz_searchdata();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}

 }
 //保存银行对账核对匹配数据
 function pz_ensure(){
  var  account_id=$("#account_newname").combobox('getValue');
  account_id=trim(account_id);
  var  account_newname=$("#account_newname").combobox('getText');
  var  zt=$("#zt").combobox('getValue');
  var  jiexi=$("#t1").combobox('getValue');
  var  biaoshi=$("#biaoshi").textbox('getValue');
  
  var msyh_zh = $("#msyh_zh").textbox('getValue');
  msyh_zh=trim(msyh_zh);
  var jsyh_zh = $("#jsyh_zh").textbox('getValue');
  jsyh_zh=trim(jsyh_zh);
  var gsyh_zh = $("#gsyh_zh").textbox('getValue');
  gsyh_zh=trim(gsyh_zh);
  
  var jtyh_zh = $("#jtyh_zh").textbox('getValue');
  jtyh_zh=trim(jtyh_zh);
 if (account_id=="") {
	alert('账套名称不能为空');
	return false;
}else if(gsyh_zh==""&&msyh_zh==""&&jsyh_zh==""&&jtyh_zh==""){
	alert('银行账号至少有一个不为空');
	return false;
}else {
	$.ajax({
		url:'<%=cp%>/guzhibank/saveaccountbank',
		type:'post',
		data:{account_newname:account_newname,gsyh_zh:gsyh_zh,msyh_zh:msyh_zh,jsyh_zh:jsyh_zh,account_id:account_id,zt:zt,jiexi:jiexi,biaoshi:biaoshi,jtyh_zh:jtyh_zh},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("保存成功");
				
				pz_searchdata();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}

 }

 //删除银行对账核对匹配数据
 function pz_removedata(){
 	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
	var id = $("input[name='ck']:checked").val();
	$.ajax({
			url:'<%=cp%>/guzhibank/deleteaccountbank',
			type:'post',
			data:{id:id},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
				alert("删除成功！");
				pz_searchdata();
				}else if(data.msg="error"){
				alert("删除失败！");
				}
			}
		});
	
	}
 }
 
 function pz_editdata(){
 if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
	var id = $("input[name='ck']:checked").val();
	$.ajax({
			url:'<%=cp%>/guzhibank/selectAccbankById',
			type:'post',
			data:{id:id},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					 var json =data.data;
					 if(json.length>0){
					 var account_name=json[0].account_name;
					 $("#account_newnames").combobox('setValue',account_name);
					 $("#account_newnames").combobox('disable');
					 
					  var gsyh_id=json[0].gsyh_id;
					 $("#gsyh_zhs").textbox('setValue',gsyh_id);
					 
					  var jsyh_id=json[0].jsyh_id;
					  
					 $("#jsyh_zhs").textbox('setValue',jsyh_id);
					 
					 var jtyh_id=json[0].jtyh_id;
					  
					 $("#jtyh_zhs").textbox('setValue',jtyh_id);
					 
					  var msyh_id=json[0].msyh_id;
					 $("#msyh_zhs").textbox('setValue',msyh_id);
					   var zt=json[0].status;
					 $("#zts").combobox('setValue',zt); 
					  var tday=json[0].tday;
					 $("#t2").combobox('setValue',tday);
					  var bs=json[0].bs;
					 $("#biaoshis").textbox('setValue',bs);
					}
				}
			}
		});
		$("#zts").combobox({
		valueField: 'value',
 		textField: 'text',
 		mode:'local',
 		url:'<%=cp%>/guzhibank/InitStatusBox',
  		method:'post',
		multiple:false,
		width:180,
		filter: function(q, row){
		var opts = $(this).combobox('options');
		console.log(opts);
		return row[opts.textField].indexOf(q) >-1;
		},
		onLoadSuccess: function(){
	 	$('#zts').next('.combo').find('input').focus(function (){
         	 $('#zts').combobox('clear');
    			});
   		 }
 }); 
		$('#yhdzhds').dialog('open');
 }
 }
function upfile() {   
	var myFile = document.getElementById("fi").value;
	var rqs =$("#wbdate").combobox('getValue');
	var length = myFile.length;
	var x = myFile.lastIndexOf("\\");
	x++; 
	var fileName = myFile.substring(x,length); 
	var filename=fileName.substring(fileName.lastIndexOf("."),fileName.length);
	 if(rqs==""){
		alert("请选择导入数据日期");
		  return false;
	  }else if (fileName=="") {
		alert("请选择要导入数据库的文件");
		return false;
	  }else if(filename!=".xls"&&filename!=".dlt"){
		alert("请选择xls或者dlt格式的文件！！！");
		return false;
	  }else{
	
     var formData = new FormData($( "#uploadfile" )[0]); 
    // alert (formData);  
     $.ajax({   
          url: '<%=cp%>/guzhibank/springUpload',   
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
	function disLoad() {
		$(".datagrid-mask").remove();
		$(".datagrid-mask-msg").remove();
	}
 function file_down(filename){
 var rqs =$("#wbdate").combobox('getValue');
	  if(rqs==""){
		alert("请选择导入数据日期");
		  return false;
	  }else{
	   rqs=rqs.replace(/-/g,'');
		$.ajax({
			url:'<%=cp%>/guzhibank/filedelup',
			type:'post',
			data:{filename:filename,rqs:rqs},
			dataType: "json",
			beforeSend : function() {
				load("正在导入数据库中，请稍后...");
			},
			success: function(obj){
				if(obj.msg=="success"){
					disLoad();
					alert("文件导入数据库成功"); 
					file_searchs(rqs);
				}else if(obj.msg="error"){
					disLoad();
					alert("文件导入数据库失败！");
				}
			}
			
		});
	}
 }
 //导入数据库的数据先删除后插入

 //数据库中删除后插入的查询
 function file_searchs(rq){
 		
      	 var params="rq="+rq;
		
  $('#filepzdg').datagrid({url:"<%=cp%>/guzhibank/getFiledata?"+params}).datagrid('clientPaging'); 
 }
 //查询导入到数据库中
 function file_search(){
 var str =$("#wbdate").combobox('getValue');
 var yh_zh =$("#yh_zh").textbox('getValue');
 var yh_khjg =$("#yh_khjg").combobox('getValue');
 var jj_mc =$("#jj_mc").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else {
		 
       var params="wbdate="+str.replace(/-/g,'');
        }
        if (yh_zh!="") {
			 params+="&zh="+yh_zh;
		}
		if (yh_khjg!="") {
			 params+="&khjg="+yh_khjg;
		}
		if (jj_mc!="") {
			 params+="&jjmc="+jj_mc;
		}
  $('#filepzdg').datagrid({url:"<%=cp%>/guzhibank/getFiledata?"+params}).datagrid('clientPaging'); 
	closeDialog();
 }
 
 function selectbankid(account_name,msyh_id,jsyh_id,gsyh_id){
 	if(msyh_id!=null){
 		var msyh=msyh_id.split(",");
 		for(var i = 0; i < msyh.length; i++ ){
 			 
 		}
 	}
 	
 }
 //取消
 function closeDialog(){
	$('#enddate').datebox('clear');
	$('#startdate').datebox('clear');
	$('#remark_s').textbox('clear');
	$('#upuser').textbox('clear');
	$('#dates').textbox('clear');
	$('#updates').textbox('clear');
	$('#remark_ss').textbox('clear');
	$('#dlg').dialog('close');
	$('#REMARK').dialog('close');
	$('#hdpz').dialog('close');
	$('#yhdzhds').dialog('close');
	$('#fb').filebox('clear');
	$('#account_newname').combobox('clear');
	//$('#yh_khjg').combobox('clear');
	$('#gsyh_zh').textbox('clear');
	$('#jsyh_zh').textbox('clear');
	$('#msyh_zh').textbox('clear');
	$('#jtyh_zh').textbox('clear');
	$('#account_newnames').combobox('clear');
	$('#gsyh_zhs').textbox('clear');
	$('#jsyh_zhs').textbox('clear');
	$('#msyh_zhs').textbox('clear');
	
	//$('#yh_zh').textbox('clear');
	$('#biaoshi').textbox('clear');
	$('#t1').combobox('clear');
	
}
</script>
<body>
<div id="tabsidk" >

	<div title="银行对账核对导入文件" style="padding: 5px">
	  <div style ="height:25px;">
	  <div style ="float:left">
	  	<span>日期</span>
	       <input id="wbdate" name="wbdate"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
		 <span style="color: red;">*</span>
		</div> 
		 <div style ="float:left;width:30px; height:5px" ></div>
 		   <form id="uploadfile" style="float:left" enctype="multipart/form-data"> 
			<input type="file" name="file"id ="fi"> 
			<input type="button" value="导入文件"   onclick="upfile()"/> 
			</form>
			<div style ="float:left;width:20px; height:5px" ></div>
			<div>
			<span >开户机构:</span> 
		  	<select class="easyui-combobox"  name="yh_khjg" id="yh_khjg" >
		  				<option value=" ">--请选择--</option>
					    <option value="1">工商银行</option>
					    <option value="3">建设银行</option>
					    <option value="2">民生银行</option>
					    <option value="4">交通银行</option>
					  </select>
			</div>
			<br />
			<div>
			<span>基金名称:</span> 
			<input class="easyui-combobox"	name="jj_mc" id="jj_mc">
			<span>&nbsp&nbsp&nbsp</span>
			<span >银行账号:</span>
			<span> 
				<input  style="width:200px;height:25px;" type="text" class="easyui-textbox"    name="yh_zh" id="yh_zh" />
			</span> 
			<span>&nbsp&nbsp&nbsp</span>
	  		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="file_search()">查询</a> 
	  		</div>
	  <br></br>
	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th field="rq" width="85" >日期</th>
						<th field="khjg" width="260" >开户机构</th>
						<th field="hm" width="200" >银行户名</th>
						<th field="zh" width="150" >银行账号</th>
						<th field="bz" width="70" >币种</th>
						<th field="zhye" width="120" data-options="align:'right',formatter:myformatter" >账户余额</th>
					<!-- 	<th field="kyye" width="85" data-options="align:'right',formatter:myformatter">可用余额</th> -->
						<th field="zt" width="85" >状态</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
	
	<div title="银行对账核对" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
	   <span>账套名称:</span>
	   <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhibank/InitAccountBox',
		                          method:'post',
								  multiple:false,
								  width:200,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									 });
		 }  ">
		 
		   <span style="margin-left: 15px;">核对类型</span>
		  	<select class="easyui-combobox" name="t3" id="t3" >
		  				<option value=" ">--请选择--</option>
					    <option value="1">T+1</option>
					    <option value="2">T+2</option>
			</select>
			 <span style="margin-left: 15px;">余额来源</span>
		  	<select class="easyui-combobox" name="datasrc" id="datasrc" >
					    <option value="1">系统余额表</option>
					    <option value="2">人工导入表</option>
			</select>
			<span style="margin-left: 15px;">估值人员:</span> 
			<input class="easyui-combobox"
						name="userInfo" id="userInfo"
		    >
		    <span style="margin-left: 15px;">日期</span>
	     	<input id="wbdates" name="wbdates"
			class="easyui-datebox"  style="width: 120px"></input>
		  <span style="color: red;">*</span>
		  	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
			<br> <input type="checkbox" name="isbd" id="isbd" value="1"/>
		  	<span style="font-size:8px;">只显示有差额的产品</span>
	   	  	 <div style="margin-bottom: 10px;float: right" id="sumnoteql"></div> 
		</div>
		
		
	   <div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="rownumbers:true,autoRowHeight:false,pagination:true,pageSize:500,singleSelect:true,
				             rowStyler: function(index,row){
				                      var str='';
									  if(index%2==0){
									    str='background-color:#D9EEEE;';
									  }
									  if(typeof(row.bdpd)!='undefined' && (row.bdpd+'').indexOf('span')==-1){
									     str='background-color:#EFF29A;';
									  }
									  if(!isNaN(row.zrjz_ce)){
									  str='background-color:#F6BCBC;';
									  };
								}">
				<thead>
					<tr>
                        <th field="account_id"    width="85px"     rowspan="2">账套号</th>
                        <th field="account_name"  width="250px"   rowspan="2">账套名称</th>
                         <th field="status"  width="85px"   rowspan="2">状态</th> 
                         <th style="WORD-WRAP: break-word" field="yhzh"  width="250px" height="35px"   rowspan="2" >银行账号</th> 
						<th   colspan="3">余额</th>
						<th field="tday"    width="85px"     rowspan="2">核对类型</th>
						<th field="user"    width="85px"     rowspan="2">估值人员</th>
					</tr>
					<tr>
					  <th field="kmye" width="120px"  data-options="align:'right',formatter:myformatter">科目余额</th>
					  <th field="zhye" width="120px" data-options="align:'right',formatter:myformatter" >银行账户余额</th>
					  <th field="yece" width="80px" data-options="align:'right',formatter:myformatter,styler:myCellStyler" >差额</th>
					  <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="银行对账核对配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  <span>账套名称:</span> 
			<span> 
				<input  class="easyui-combobox" id="account_names" name="account_names"  >
			</span>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddata()">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="pz_removedata()">删除</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_editdata()">修改</a> 
			     
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="bankpzdg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
						               ">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="account_id" width="100" >账套号</th>
								<th field="account_name" width="250" >账套名称</th>
								<th field="gsyh_id" width="250" >工商银行账号</th>
								<th field="msyh_id" width="250" >民生银行账号</th>
								<th field="jsyh_id" width="250" >建设银行账号</th>
								<th field="jtyh_id" width="250" >交通银行账号</th>
								<th field="status" width="60" >状态</th>
								<th field="tday" width="60" >核对类型</th>
								<th field="bs" width="45" >标识</th>
								
							</tr>
						</thead>
					</table>
				</div>
		 </div>


</div>
<div id="hdpz" class="easyui-dialog" closed="true" title="添加银行账号"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>账套名称:&nbsp;&nbsp;</span> 
			<span> 
				 <input class="easyui-combobox" name="account_newname" id="account_newname"/>
			</span> 
			<span style="color: red;">*</span>
			  <span>核对类型:</span>
		  	<select class="easyui-combobox" name="t1" id="t1" >
		  				<option value=" ">--请选择--</option>
					    <option value="T+1">T+1</option>
					    <option value="T+2">T+2</option>
					  </select>
			<br></br>	
			<span>状&nbsp;&nbsp;态:&nbsp;&nbsp;</span> 
			<span> 
				 <input class="easyui-combobox" name="zt" id="zt"/>
			</span> 
			 <span >&nbsp;&nbsp;标识:</span> 
			<span> 
				<input  style="width:100px;height:25px;" type="text" class="easyui-textbox"    name="biaoshi" id="biaoshi" />
			</span> 	  
			 <br></br>
			<span >工商银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="gsyh_zh" id="gsyh_zh" data-options="multiline:true"/>
			</span> 
		
			 <br></br>			
			
			<span >建设银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="jsyh_zh" id="jsyh_zh" data-options="multiline:true"/>
			</span> 
			 <br></br>	
			<span >民生银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="msyh_zh" id="msyh_zh" data-options="multiline:true"/>
			</span> 
			 <br></br>	
			 	<span >交通银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="jtyh_zh" id="jtyh_zh" data-options="multiline:true"/>
			</span> 
			 <br></br>	
			 
			
					  
			
			<!--  <span >标&nbsp;&nbsp;识:&nbsp;</span> 
			<span> 
				<input  style="width:100px;height:25px;" type="text" class="easyui-textbox"    name="biaoshi" id="biaoshi" />
			</span> 
			 <br></br>	 -->	
			<span style="color: red;">* 多个银行账号之间用,隔开</span>
			 
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
	<div id="yhdzhds" class="easyui-dialog" closed="true" title="修改银行账号"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>账套名称:&nbsp;&nbsp;</span> 
			<span> 
				 <input class="easyui-combobox" name="account_newnames" id="account_newnames" data-options=" width:180"/>
			</span> 
			<span style="color: red;">*</span>
			 <span>核对类型:</span>
		  	<select class="easyui-combobox" name="t2" id="t2" >
		  				<option value=" ">--请选择--</option>
					    <option value="T+1">T+1</option>
					    <option value="T+2">T+2</option>
					  </select>
					  
			 <br></br>	
			 <span>状&nbsp;&nbsp;态:&nbsp;&nbsp;</span> 
			<span> 
				 <input class="easyui-combobox" name="zts" id="zts"/>
			</span> 
			 <span >&nbsp;&nbsp;标识:</span> 
			<span> 
				<input  style="width:100px;height:25px;" type="text" class="easyui-textbox"    name="biaoshis" id="biaoshis" />
			</span> 
			 <br></br>
			<span >工商银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="gsyh_zhs" id="gsyh_zhs" data-options="multiline:true"/>
			</span> 
		
			 <br></br>			
			
			<span >建设银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="jsyh_zhs" id="jsyh_zhs" data-options="multiline:true"/>
			</span> 
			 <br></br>	
			<span >民生银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="msyh_zhs" id="msyh_zhs" data-options="multiline:true"/>
			</span> 
			<br></br>	
				<span >交通银行账号:</span> 
			<span> 
				<input  style="width:500px;height:35px;" type="text" class="easyui-textbox"    name="jtyh_zhs" id="jtyh_zhs" data-options="multiline:true"/>
			</span>
			 <!-- <br></br>	
			 	 <span>t1,t2</span>
		  	<select class="easyui-combobox" name="t2" id="t2" >
		  				<option value=" ">--请选择--</option>
					    <option value="T+1">T+1</option>
					    <option value="T+2">T+2</option>
					  </select> -->
					  <br></br>
					  
				
			  <!-- <span >标识:</span> 
			<span> 
				<input  style="width:100px;height:25px;" type="text" class="easyui-textbox"    name="biaoshis" id="biaoshis" />
			</span>  -->
			 <br></br>	
			<span style="color: red;">* 多个银行账号之间用,隔开</span>
			 
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensures()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

</body>



