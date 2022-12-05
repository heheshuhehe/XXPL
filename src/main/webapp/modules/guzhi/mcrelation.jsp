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
//初始化母帐套名次下拉框	 	 
$("#account_names").combobox({
		valueField: 'value',
 		textField: 'text',
 		mode:'local',
 		url:'<%=cp%>/guzhibank/InitMAccountBox',
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

  /********************母子对应关系***********************/

//查询母基金和子基金科目余额
 function searchdata(){
	 	var d_ywrq=$("#d_ywrq").combobox('getValue');
	/* 	var wb_zth=$("#wb_zth").combobox('getValue'); */
		if(d_ywrq==""){
			alert("请选择日期");
			return false;
		}
		else{
			var params="d_ywrq="+d_ywrq;
			if($("#isbd").prop("checked")){
	        	params +="&isbd=1";
	        } 
			if($("#wb_zth").combobox('getValue')!=""){
	        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
	        }
			$('#dg').datagrid({method:'get',
	               url:"<%=cp%>/zmjijin/mujijingetInfo?"+params,
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
/*   		var params="wb_zth="+wb_zth+"&d_ywrq="+d_ywrq;
 */         <%-- $('#dg').datagrid({method:'get',
         					url:"<%=cp%>/zmjijin/mujijingetInfo?"+params
         					}).datagrid('clientPaging');   --%>
       
		}
  }
 

 
 
 
 //查询母子基金对应关系
 function pz_searchdata(){
  		 var params="account_names="+$("#account_names").combobox('getValue');
  		 $('#bankpzdg').datagrid({url:"<%=cp%>/guzhibank/selectaccadbankMz?"+params}).datagrid('clientPaging'); 
 }
 
 //母子对应关系配置  初始化添加子账套 下拉框
 function pz_adddata(){
    	
    		 $("#account_namesadd").combobox({
				 valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:'<%=cp%>/guzhibank/InitMAccountBoxadd',
			     method:'post',
				  multiple:false,
				  width:300,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							console.log(opts);
							return row[opts.textField].indexOf(q) >-1;
						},
						onSelect:function(val){
						    
							 $("#zaccount_idadd").combobox({ 
									  valueField: 'value',
									  textField: 'text',
									  
									  mode:'local',
									  url:'<%=cp%>/guzhibank/InitZAccountBoxadd?zaccount_id='+val.value,
						              method:'get',
									   multiple:true,
    					 			 	multiline:true,
    					  				width:300,
    					  				height:80,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
								      onLoadSuccess: function(){
								    	  
									  }		
						    });
						},
						  onLoadSuccess: function(){
									 $('#account_namesadd').next('.combo').find('input').focus(function (){
								            $('#account_namesadd').combobox('clear');
								            $("#zaccount_idadd").combobox('clear');
								     });
									 
							     }
						
			 }); 	  
 	  $('#hdpz').dialog('open');
 	  
 
 }
 //保存新增母子对应关系
 function pz_ensure(){
  var  maccount_id=$("#account_namesadd").combobox('getValue');
  var maccount_name = $("#account_namesadd").combobox('getText');
  var  zaccount_id=$("#zaccount_idadd").combobox('getValues');
  var zaccount_name = $("#zaccount_idadd").combobox('getText');
  if(maccount_id==""){
		alert("请选择母基金账套号 ");
		return false;
	}
  if(zaccount_id==""){
		alert("请选择子基金账套号 ");
		return false;
	}
  else{
	$.ajax({
		url:'<%=cp%>/guzhita/addTACheckMZ',
		type:'post',
		data:{maccount_id:maccount_id,maccount_name:maccount_name,zaccount_id:zaccount_id,zaccount_name:zaccount_name},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("保存成功");
				closeDialog();
				pz_searchdata();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}
 }
 
 //删除母子对应关系配置
 function pz_removedata(){
 	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
	var id = $("input[name='ck']:checked").val();
	$.ajax({
			url:'<%=cp%>/guzhibank/deleteaccountbankmz',
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
 //修改母子对应配置
 function pz_editdata(){
	 if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
		var id = $("input[name='ck']:checked").val();
		$.ajax({
				url:'<%=cp%>/guzhibank/selectById',
				type:'post',
				data:{id:id},
				dataType: "json",
				success: function(data){
					if(data.msg="success"){
						
						 var json =data.data;
						 if(json.length>0){
						 var maccount_name=json[0].maccount_name;
						 var maccount_id=json[0].maccount_id;
						 $("#account_namesedit").combobox('setValue',maccount_id);
						 $("#account_namesedit").combobox('setText',maccount_name);
						 $("#account_namesedit").combobox('disable');
						 var zaccount_id=json[0].zaccount_id;
						 $("#account_fundnameedit").combobox({
						       valueField: 'value',
							   textField: 'text',
							   mode:'local',
						       url:'<%=cp%>/guzhibank/InitZAccountBoxadd?zaccount_idzz='+zaccount_id,
						       method:'post',
						       multiple:false,
						       width:250,
						       filter: function(q, row){
									var opts = $(this).combobox('options');
									return row[opts.textField].indexOf(q) >-1;
								},
						       onLoadSuccess: function(){
							   $('#account_fundnameedit').next('.combo').find('input').focus(function (){
						       });
						     }
						});
						 
						  $("#account_fundnameedit").combobox('setValue',zaccount_id); 
						  var zaccount_name=json[0].zaccount_name;
						 $("#account_fundnameedit").combobox('setText',zaccount_id+"_"+zaccount_name);
						 
						 var mzid=json[0].id;
						 $("#mzid").textbox('setValue',mzid);
					 	
						}
					}
				}
			});
		
			 //$(".textbox").css("display","none");
			$('#yhdzhds').dialog('open');


	 }
	 }

 


 
 
 
//保存修改母子账套配置信息
 function pz_ensures(){
	 var id=$("#mzid").textbox('getValue');
		 var  maccount_id=$("#account_namesedit").combobox('getValue');
		 var  maccount_name=$("#account_namesedit").combobox('getText');
		 var  zaccount_id=$("#account_fundnameedit").combobox('getValue');
		 var  zaccount_name=$("#account_fundnameedit").combobox('getText');
if (maccount_id=="") {
	alert('母基金账套号不能为空');
	return false;
}else {
	$.ajax({
		url:'<%=cp%>/guzhibank/updatemz',
		type:'post',
		data:{maccount_id:maccount_id,maccount_name:maccount_name,zaccount_id:zaccount_id,zaccount_name:zaccount_name,id:id},
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
	$('#account_newnames').combobox('clear');
	$('#gsyh_zhs').textbox('clear');
	$('#jsyh_zhs').textbox('clear');
	$('#msyh_zhs').textbox('clear');
	$('#zaccount_idadd').combobox('clear');
	$('#biaoshi').textbox('clear');
	$('#t1').combobox('clear');
	$('#wb_zth').combobox('clear');
	$('#account_names').combobox('clear');
	
}
 
 
//母子对应关系
 function querymzjijinInfo(zaccount_id,rq,kmdm){
 	$("#tabsidk").tabs('select', "子基金");
 	
  	var params="zaccount_id="+zaccount_id+"&rq="+rq+"&kmdm="+kmdm;
         $('#filepzdg').datagrid({method:'get',
         					url:"<%=cp%>/zmjijin/zijijingetInfo?"+params
         					}).datagrid('clientPaging'); 
 }
 
 function myCellStyler11(value,row,index){
		if (!isNaN(value)){
			return 'color:bleak;';
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
 
</script>
<body>
<div id="tabsidk" >
	<div title="母基金" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>母基金账套号:</span> <input class="easyui-combobox" name="wb_zth"
				id="wb_zth"
				data-options="
				                      	valueField: 'value',
								 		textField: 'text',
								 		mode:'local',
								 		url:'<%=cp%>/guzhibank/InitMAccountBox',
								  		method:'post',
										multiple:false,
										width:200,
										filter: function(q, row){
										var opts = $(this).combobox('options');
										console.log(opts);
										return row[opts.textField].indexOf(q) >-1;
										},
										onLoadSuccess: function(){
									 	$('#wb_zth').next('.combo').find('input').focus(function (){
								         	 $('#wb_zth').combobox('clear');
								    			});
								   		 }
									 ">
		   	 <span style="margin-left: 15px;">日期</span>  	
		     <span><input id="d_ywrq" name="d_ywrq" class="easyui-datebox" style="width: 150px"></input></span>
		     <span style="color: red;">*</span>
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
			 <input type="checkbox" name="isbd" id="isbd" value="1"/>
		  	<span style="font-size:8px;">只显示有差额的产品</span>
	   	  	 <div style="margin-bottom: 10px;float: right" id="sumnoteql"></div>  
			 <br/>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="dg"  style="width: 770px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
						               ">
				<thead>
					<tr>

					    <th field="" width="150" data-options="hidden:true"></th>
					    <th field="maccount_name" width="150">基金名称</th>
					    <th field="c_subj_code" width="150">科目代码</th>
					    <th field="c_subj_name" width="150">科目名称</th>
						<th field="mjjkmye" width="150" data-options="align:'right',formatter:myformatter,styler:myCellStyler11" >母基金科目余额</th>
					    <th field="zjjkmye" width="150" data-options="align:'right',formatter:myformatter,styler:myCellStyler11" >子基金科目余额合计</th>
						<th field="mzce" width="150"data-options="align:'right',formatter:myformatter,styler:myCellStyler">差额</th>
						<th field="myquery" width="70">查看</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="母子账套对应关系配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  <span>母基金账套名称:</span> 
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
								<th field="maccount_id" width="100" >母基金账套号</th>
								<th field="maccount_name" width="250" >母基金账套名称</th>
								<th field="zaccount_id" width="250" >子基金账套号</th>
								<th field="zaccount_name" width="250" >子基金账套名称</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>
		<div title="子基金" style="padding: 5px">
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
												<th field="zaccount_id" width="85" >子基金账套号</th>
						<th field="zaccount_name" width="260" >子基金名称</th>
						<th field="kmdm" width="200" >科目号</th>
						<th field="kmmc" width="150" >科目名称</th>
						<th field="zjjkmye" width="70" data-options="align:'right',formatter:myformatter,styler:myCellStyler11">科目余额</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
</div>
<!-- 新增弹框 -->
<div id="hdpz" class="easyui-dialog" closed="true" title="添加对应关系"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>母基金账套号:</span> <input class="easyui-combobox" name="account_namesadd"
				id="account_namesadd"
				>
			 <br></br>	
			 <span>子基金账套号:</span> 
			<span> 
				<input  style ="width:300px" class="easyui-combobox" id="zaccount_idadd" name="zaccount_idadd" data-options="editable:true">
			</span> 
			</span>
			<!-- <span style="color: red;">*</span> -->
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
	<div id="yhdzhds" class="easyui-dialog" closed="true" title="修改对应关系"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>母基金账套号:</span> <input  style="width: 250px"class="easyui-combobox" name="account_namesedit"
				id="account_namesedit"
				<%-- data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhibank/InitMAccountBox',
			                          method:'post',
									  multiple:false,
									  width:250,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('##account_namesedit').next('.combo').find('input').focus(function (){
									            $('#account_namesedit').combobox('clear');
									     });
								     }
									 " --%>>
			 <br></br>
			 <span id="renyuan" style="display:none;"> 
			 <input  type="text"   class="easyui-textbox" name="mzid" id="mzid" /> 
			 
			 </span>
			 <span>子基金账套号:</span> <input style="width: 250px"class="easyui-combobox" name="account_fundnameedit"
				id="account_fundnameedit"
			 >
			<!-- <span style="color: red;">*</span> -->
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensures()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

</body>



