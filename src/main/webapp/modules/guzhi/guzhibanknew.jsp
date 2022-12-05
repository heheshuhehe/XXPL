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
 
 tab_option=$('#tabsidk').tabs('getTab','银行对账核对导入文件').panel('options').tab;
 tab_option.hide();
 $('#tabsidk').tabs('select','银行对账核对');

 
$("#bankname").combobox({
	valueField: 'value',
		textField: 'text',
		mode:'local',
		url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option= where datatype  =\'tgbank\'  order by datacode desc',
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
//初始化新增配置账套信息下拉框	 
$("#account_newname").combobox({
		valueField: 'value',
 		textField: 'text',
 		mode:'local',
 		url:'<%=cp%>/guzhibank/InitAccountBox',
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
		 
        var params="wbdate="+str;
        
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
        	               url:"guzhibank/selectyhdzhdnew?"+params,
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
  		 $('#bankpzdg').datagrid({url:"<%=cp%>/guzhibank/selectaccadbanknew?"+params}).datagrid('clientPaging'); 
 }
 //银行对账核对匹配添加配置
 function pz_adddata(op){
 
	 $("#op").val(op);
	 
	 if('s'==op){
		 
	 }
	 if('a'==op){
		 $("#account_newname").combobox('enable');
		 
			//$("#bankname").combobox('enable');
		  $('#hdpz').dialog('open');
		 
		
	 }
	 if('u'==op){
		
		 var row = $('#bankpzdg').datagrid('getSelected');
		 if (row){
			 $("#account_newname").combobox('disable',true);
			 
			 
			 $("#ider").val(row.ider);
			 $("#account_newname").combobox('select',row.zth);
		
			 	$("#bankname").combobox('select',row.bankcode);
				$("#yhzh").textbox('setValue',row.yhzh);
				$("#yhsubj").textbox('setValue',row.yhsubj);
			
			
			  $('#hdpz').dialog('open');
			}
			else{
				$.messager.alert('提示','请先选中一行！');

			}
		 
	 }
	 if('d'==op){

		 var row = $('#bankpzdg').datagrid('getSelected');
		 if (row){
			 
			 
			 
				$.messager.confirm('删除', '确定要删除这条数据吗？', function(r){
					if (r){
						var ider = row.ider;
						 
						 $.ajax({
								url:'<%=cp%>/guzhibank/saveaccountbanknew',
								type:'post',
								data:{ider:ider,op:op},
								dataType: "json",
								success: function(data){
									if(data.msg=="success"){  
										alert("删除成功");
										
										pz_searchdata();
										closeDialog();
										
									}else{
										alert("删除失败");
									}
									
								}
							});
						
					}
					
				});
			}else{
				$.messager.alert('提示','请先选中一行！');

			}
		 
	 }
 

  
 	
 
 }
 

 
 //保存银行对账核对匹配数据
 function pz_ensure(){
  var  account_id=$("#account_newname").combobox('getValue');
  account_id=trim(account_id);
  var  account_newname=$("#account_newname").combobox('getText');
  var ider=$("#ider").val();
  
  var zth=account_id;
  var systype=$("#systype").val();
  var yhtype=$("#yhtype").val();
  var  bankcode=$("#bankname").combobox('getValue');
  
  
  var  yhzh=$("#yhzh").textbox('getValue');
  var  yhsubj=$("#yhsubj").textbox('getValue');
  var  op=$("#op").val();
 
 if (zth=="") {
	alert('账套名称不能为空');
	return false;
}
	$.ajax({
		url:'<%=cp%>/guzhibank/saveaccountbanknew',
		type:'post',
		data:{account_newname:account_newname,account_id:account_id,zth:zth,systype:systype,yhtype:yhtype,bankcode:bankcode,yhzh:yhzh,yhsubj:yhsubj,ider:ider,op:op},
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

	<div title="银行对账核对导入文件" style="padding: 5px;">
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
		 <span style="display: none">
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
			</span>
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
				data-options="rownumbers:true,autoRowHeight:false,pagination:true,pageSize:50,singleSelect:true,
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
                        <th field="wb_zth"   >账套号</th>
                        <th field="fund_name"    >账套名称</th>
                         
                         <th style="WORD-WRAP: break-word" field="yhzh"   height="35px"   >银行账号</th> 
						
						<th field="datacode"   hidden="true">银行编码</th>
						<th field="yhname"    >银行名称</th>
						<th field="yhsubj"    >估值系统科目</th>
				
					  <th field="n_hldmkv" width="120px"  data-options="align:'right',formatter:myformatter">估值系统余额</th>
					  <th field="zhye"  data-options="align:'right',formatter:myformatter" >银行账户余额</th>
					  <th field="chae"   data-options="align:'right',formatter:myformatter,styler:myCellStyler" >差额</th>
					  <th field="username"  >估值人员</th> 
					  <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="银行账号核对配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  <span>账套名称:</span> 
			<span> 
				<input  class="easyui-combobox" id="account_names" name="account_names"  >
			</span>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchdata('s')">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddata('a')">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="pz_adddata('d')">删除</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_adddata('u')">修改</a> 
			     
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="bankpzdg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
						               ">
						<thead>
							<tr>
								
								<th field="ider" width="250" hidden="true" >银行类型</th>
								<th field="zth"  >账套号</th>
								<th field="c_port_name" width="250" >账套名称</th>
								<th field="yhtype" width="250" hidden="true" >银行类型</th>
								<th field="bankncode" width="250"  hidden="true">银行代码</th>
								<th field="bankname" width="250" >银行名称</th>
								<th field="yhzh" width="250" >银行账号</th>
								<th field="yhsubj"   >估值系统科目</th>
								
								
							</tr>
						</thead>
					</table>
				</div>
		 </div>


</div>
<div id="hdpz" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>账套名称:&nbsp;&nbsp;</span> 
			<span> 
				<input    style="display: none;"  id="op"  name="op"   /> 
				<input    style="display: none;"  id="zth"  name="zth"   /> 
				<input    style="display: none;"  id="ider"  name="ider"   /> 
				 <input class="easyui-combobox" name="account_newname" id="account_newname"/>
				 
				<input    style="display: none;"  id="systype"  name="systype"  value='2' /> 
				<select   name="yhtype" id="yhtype"   style="display: none;" >
					    <option value="1" selected="selected" >托管行</option>
					    <option value="2">募集行</option>
					  </select>
				 
			</span> 
			<span style="color: red;">*</span>
			  <span>银行名称:</span>
		  	<select class="easyui-combobox" name="bankname" id="bankname" >
		  				
					  </select>
			<br></br>	
			
			 <span >银行账号:</span> 
			<span> 
				<input  style="width:250px;height:25px;" type="text" class="easyui-textbox"    name="yhzh" id="yhzh" />
			</span> 	  
			 <br></br>
			
			 <span >估值系统科目:</span> 
			<span> 
				<input  style="width:250px;height:25px;" type="text" class="easyui-textbox"    name="yhsubj" id="yhsubj" />
			</span> 	
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
	

</body>



