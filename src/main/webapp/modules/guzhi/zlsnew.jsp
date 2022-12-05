<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>昨日单位净值对照</title>
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
	     	 height : document.documentElement.clientHeight-140
		 });
		 $("#pzdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-100
	 	 });
	 	 
 	 $("#account_names").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
     method:'post',
	  multiple:false,
	  width:250,
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
	/* 	alert(strDate);
		alert(strDate1);
		 */
 		$("#wbdate").datebox('setValue',strDate);
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

//初始化分TA与柜台核对类型
 $("#type").combobox({
       valueField: 'value',
	   textField: 'text',
	   mode:'local',
       url:'<%=cp%>/guzhita/InitType',
       method:'post',
       multiple:false,
       width:200,
       filter: function(q, row){
			var opts = $(this).combobox('options');
			return row[opts.textField].indexOf(q) >-1;
		},
       onLoadSuccess: function(){
	   $('#type').next('.combo').find('input').focus(function (){
            $('#type').combobox('clear');
       });
     }
});

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
 	
	  var str =$("#wbdate").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 
        var params="wbdate="+str;
        
        if($("#iseql").prop("checked")){
        	params +="&iseql=1";
        }
        
      
        
        if($("#isbd").prop("checked")){
        	params +="&isbd=1";
        }
        if($("#wb_zth").combobox('getValue')!=""){
        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
        }
       if($("#type").combobox('getValue')!=""){
        	params +="&type="+$("#type").combobox('getValue');
        }
        if($("#zt").combobox('getValues')!=""){
        	
        	params +="&zt="+$("#zt").combobox('getValues');
        }
        $('#dg').datagrid({method:'get',
        	               url:"guzhita/queryTAData?"+params,
        	               onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
				            	    // alert(data.rows.length);
					            	     if(typeof(data.rows[0].sumnoteql)!="undefined"){
		 			            	        $("#sumnoteql").html("<span style='color:red;font-size:8px;'>"+data.rows[0].sumnoteql+"</span><span style='font-size:8px;'>个产品代码单位净值和累计单位净值不一致!</span>"+
		 			            	        		"<span style='color:red; font-size:8px;'>"+data.rows[0].sumbd+"</span><span style='font-size:8px;'>个产品净值波动超过10%!</span>");
					            	     }
				            	     } else {
				            	     		$("#sumnoteql").html("");
				            	     }
				           }}).datagrid('clientPaging'); 
	  }
      
 }
 
 function myCellStyler(value,row,index){
	if(value=="-100%"){
		return 'color:red';
	}
	if(value!=undefined&&value.indexOf('%')>0){
		if(new Number(value.replace('%',''))>9.9||new Number(value.replace('%',''))<-9.9)
		return 'color:red';
		else return 'color:green;';
	}
		
			if(new Number(value)==0.0)
				return 'color:green';
			else{
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
			  return  "<span style='font-family:SimSun'>"+num+""+"</span>";
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


//新增
 function opendialog(){	
 var id = $("input[name='ck']:checked").closest("tr").find("td[field='fundname']").text();
 if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		$("#account_name").textbox('setValue',id);
		$("#account_name").textbox('disable');
		//$("#starttime").datebox('setValue',strDate);
		
		
	
		
	    $('#dlg').dialog('open');
	 	var curr_time = new Date();
		var strDate = curr_time.getFullYear() + "-";
		strDate += curr_time.getMonth() + 1 + "-";
		strDate += curr_time.getDate() + "-";
		strDate += curr_time.getHours() + ":";
		strDate += curr_time.getMinutes() + ":";
		
		$("#startdate").datebox('setValue',strDate);
		$("#enddate").datebox('setValue',strDate);
		/* $("#startdate").datetimebox({
			value : strDate + " 08:00",
			required : true,
			showSeconds : false
		});

		$("#enddate").datetimebox({
			value : strDate + " 12:00",
			required : true,
			showSeconds : false
		}); */
	} 
		/*  $('#dlg').dialog('open'); */
 }
 function show_confirm(){  
    var result = confirm('是否继续！');  
    if(result){  
        alert('删除成功！');  
    }else{  
        alert('不删除！');  
    }  
}  
 
//保存
 function addAcountMapping(){
 	var curr_time = new Date();
		var strDate = curr_time.getFullYear() + "-";
		strDate += curr_time.getMonth() + 1 + "-";
		strDate += curr_time.getDate() + "-";
		strDate += curr_time.getHours() + ":";
		strDate += curr_time.getMinutes() + ":";
 	 var account_id=$("input[name='ck']:checked").val();
 	var endtime=$("#enddate").datebox('getValue');
 	var starttime=$("#startdate").datebox('getValue'); 
 	var remark_s=$("#remark_s").val();
 	if ($("input[name='ck']:checked").length!=1){
 		alert("请选择一条数据！");
 		return false;
 	}
  	if (starttime==""&&endtime=="") {
		alert("请选择开始或者结束时间！");
		return false;
	}
	else if (starttime>endtime){
		alert("开始时间不能大于结束时间！");
		return false;
	}else if (endtime>strDate){
		alert("结束时间不能大于当前时间！");
		return false;
	}
	else if (remark_s=="") {
		alert("请添加备注信息！");
		return false;
	}else{
		$.ajax({
			url:'<%=cp%>/guzhita/queryBZ',
			type:'post',
			data:{account_id:account_id,endtime:endtime,starttime:starttime},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){
					 var json =data.data;
					 if(json.length>0)
					 var  bzrq = json[0].bzrq;
					 if(bzrq!=""){
					 var result = confirm(bzrq+'这些日期内有备注是否继续!'); 
					/*  alert(bzrq+"这些日期内有备注是否继续"); */
					if(result){  
						// 执行方法
        			   UpdateBzdata(account_id,endtime,starttime,remark_s);
    				}else{  
        				closeDialog();  
   					 }  
					 }else{
					    UpdateBzdata(account_id,endtime,starttime,remark_s);
					    closeDialog();
					 }
				}
			}
		});
	}
  	/* closeDialog(); */
 }
 
 function UpdateBzdata(account_id,endtime,starttime,remark_s){
 $.ajax({
			url:'<%=cp%>/guzhita/updateBZ',
			type:'post',
			data:{account_id:account_id,endtime:endtime,starttime:starttime,remark_s:remark_s},
			dataType: "json",
			success: function(data){
				//alert(data);
				if(data.msg=="success"){
					alert("添加成功！");
					closeDialog();
					 }
				}
		});
 }
 function GZsearchdata(){
 var account_id=$("input[name='ck']:checked").val();
 var wbdate=$("#wbdate").datebox('getValue');
if ($("input[name='ck']:checked").length!=1){
 		alert("请选择一条数据！");
 		return false;
 	}
	if (wbdate=="") {
			alert("请选择查询时间！");
				return false;
	}else{
	$.ajax({
			url:'<%=cp%>/guzhita/queryBZ',
			type:'post',
			data:{account_id:account_id,wbdate:wbdate},
			dataType: "json",
			success: function(data){
				//alert(data);
				if(data.msg=="success"){
					 var json =data.data;
					 if(json.length>0){
					 var  remark = json[0].remark;
					 $("#remark_ss").textbox('setValue',remark);
					 $("#remark_ss").textbox('disable');
					 var  updatetime = json[0].updatetime;
					 $("#updates").textbox('setValue',updatetime);
					 var  bzrq = json[0].bzrq;
					 $("#dates").textbox('setValue',bzrq);
					  var  upuser = json[0].updateby;
					/*  alert(upuser); */
					 $("#upuser").textbox('setValue',upuser);
					 $('#REMARK').dialog('open');
					 }
					 else{
					 alert("该日期下没有备注信息");
					 closeDialog();
					 return false;
					 }
				}
			}
		});
 }
 }
 //查询备份信息
 function searchbackups(){
 var account_id=$("input[name='ck']:checked").val();
 	var wbdate=$("#wbdate").datebox('getValue');
  	if (wbdate=="") {
		alert("请选择查询时间！");
		return false;
	} else{
		$.ajax({
			url:'<%=cp%>/guzhita/querySerachBF',
			type:'post',
			data:{wbdate:wbdate,account_id:account_id},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){
					 var json =data.data;
					 if(json.length>0){
					 var  enddate = json[0].enddate;
					 var result = confirm(enddate+'数据已经备份确定要覆盖吗!'); 
					/*  alert(bzrq+"这些日期内有备注是否继续"); */
					if(result){  
						// 执行方法
        			   backups(wbdate);
    				}else{  
        				closeDialog();  
   					 }  
					 }else{
					    backups(wbdate);
					    closeDialog();
					 }
				}
			}
		});
	}
 }
 //计算分TA与估值数据
 function compute(){
	var wbdate=$("#wbdate").datebox('getValue');
	if (wbdate=="") {
		alert("请选择计算数据的时间！");
		return false;
	}else{
	$.ajax({
		url:'<%=cp%>/guzhita/Compute',
		type:'post',
		data:{wbdate:wbdate},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("数据正确计算");
			}else{
				alert("数据计算出错！！！");
			}
			
		}
	});
	}
	
}
 //备份
 function backups(wbdate){
 
 var account_id=$("input[name='ck']:checked").val();
 
  var wbdate =$("#wbdate").combobox('getValue');
	  if(wbdate==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 $.ajax({
			url:'<%=cp%>/guzhita/queryBF',
			type:'post',
			data:{wbdate:wbdate,account_id:account_id},
			dataType: "json",
			success: function(data){
				//alert(data);
				if(data.msg=="success"){
					 alert("数据已经备份!");
					 
					 
					 
				}else if(data.msg=="error"){
					alert("数据备份异常");
				}else if(data.mag=="error"){
					alert("查询时间下没有数据无法备份");
				}
			}
			
		});
			
		 
        
 }
 }
 /********************分Ta与估值核对配置***********************/
 
 
 
 //分TA查询配置数据
 function pz_searchdata(){
 		<%--  var account_names = $("#account_names").combobox('getValue');
  		 if(account_names==""){
  		 $('#pzdg').datagrid({method:'post',
	             	url:"<%=cp%>/guzhita/getTACheck",
					 
	             	}).datagrid('clientPaging'); 
  		 }else{
  		 $('#pzdg').datagrid({method:'post',
	             	url:"<%=cp%>/guzhita/getTACheck",
					 queryParams:{account_names:account_names
						        } 
	             	}).datagrid('clientPaging'); 
  		 } --%>
  		 var params="account_names="+$("#account_names").combobox('getValue');
  		 $('#pzdg').datagrid({url:"<%=cp%>/guzhita/getTACheck?"+params}).datagrid('clientPaging'); 
 }
 //分TA 添加配置
 function pz_adddata(){
  $("#account_fundname").combobox({
    					  valueField: 'value',
    					  textField: 'text',
    					  mode:'local',
    					 
    					  url:'<%=cp%>/guzhita/getAccountTACheck',
    			           method:'post',
    					  multiple:true,
    					  multiline:true,
    					  width:300,
    					  height:80,
    					  filter: function(q, row){
    								var opts = $(this).combobox('options');
    								return row[opts.textField].indexOf(q) >-1;
    					  },
    					  onLoadSuccess: function(){
						 $('#account_fundname').next('.combo').find('input').focus(function (){
			            $('#account_fundname').combobox('clear');
			            
			     });
				 
		     }
    					 
    			  });
 	  $('#hdpz').dialog('open');
 
 }
 //保存TA配置信息
 function pz_ensure(){
  var  account_fundname=$("#account_fundname").combobox('getValues');
  var account_zth = $("#account_fundname").combobox('getText');
  if (account_fundname!=null&&account_zth!=null) {
	$.ajax({
		url:'<%=cp%>/guzhita/addTACheck',
		type:'post',
		data:{account_fundname:account_fundname,account_zth:account_zth},
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
 //分TA修改配置
 function pz_editdata(){
 }
 //分TA删除配置
 function pz_removedata(){
 	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
	var id = $("input[name='ck']:checked").val();
	$.ajax({
			url:'<%=cp%>/guzhita/deleteTACheck',
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
	
}
 function mysorter(a,b){
	   return (new Number(a) >new Number(b) ?1:-1)
	  }
</script>
<body>
<div id="tabsidk" >
	
	<div title="分TA和估值核对系统" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
	   <span>账套名称:</span>
	   <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhita/queryTASelectVal?selectType=03',
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
		 <span>确认日期(T日应选择T+1日期)</span>
	     <input id="wbdate" name="wbdate"
			class="easyui-datebox"  style="width: 120px"></input>
		  <span style="color: red;">*</span>
		  <span>类型</span>
		  <select class="easyui-combobox" name="type" id="type" >
		  				<option value="">--请选择--</option>
					    <option value="0">普通基金</option>
					    <option value="2">货币市场基金</option>
					    <option value="6">QDII基金</option>
					    <option value="A">小集合计划</option>
					   
					  </select>
		  <span>状态</span>
		  <select class="easyui-combobox"  multiple= "multiple" name="zt" id="zt" >
		  				<option value=" ">--请选择--</option>
					    <option value="认购期">认购期</option>
					    <option value="正常开放">正常开放</option>
					    <option value="暂停交易">暂停交易</option>
					    <option value="暂停赎回">暂停赎回</option>
					     <option value="暂停申购">暂停申购</option>
					    <option value="产品终止">产品终止</option>
					    <option value="发行失败">发行失败</option>
					  </select>
		  	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
	  		<!-- <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="compute()">计算</a> -->
	<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="searchbackups()">存储核对信息</a> -->
		  <br></br>
		  
		  <input type="checkbox" name="iseql" id="iseql" value="1" />
		  <span style="font-size:8px;">仅显示差值项</span>
		  <input type="checkbox" name="isbd" id="isbd" value="1" style="display: " />
		  <span style="font-size:8px;display: ">只显示单位净值波动超过2%的产品</span>

	   	  <div style="margin-bottom: 10px;float: right" id="sumnoteql"></div>
		</div>
		
		
	   <div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="remoteSort:false, rownumbers:true,autoRowHeight:false,pagination:true,pageSize:500,singleSelect:true,
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
				
				<thead data-options="frozen:true">
					<tr>
					 <th data-options="field:'taname',width:180">基金名称</th>
					 <th data-options="field:'d_date',width:70">净值日期</th>
					 
					 <th data-options="field:'tacode',width:60,sortable:true">资产代码</th>
			<!-- 		 <th data-options="field:'tatype',width:70">TA类型</th>
					 <th data-options="field:'jjtype',width:70">基金类型</th>
					 <th data-options="field:'c_caption',width:70">基金状态</th>
					 <th data-options="field:'d_date',width:90">净值日期</th> -->
					 
					<!-- <th field="tacode"  width="60px"   rowspan="2">资产代码</th>
					 <th field="fundname"    width="180px"     rowspan="2">基金名称</th>
 						<th field="tatype"  width="80px"   rowspan="2">TA类型</th>
                        <th field="jjtype"  width="80px"   rowspan="2">基金类型</th>
                        <th field="c_caption"  width="60px"   rowspan="2">基金状态</th>
                          <th field="d_date"  width="60px"   rowspan="2">净值日期</th>  -->
					</tr>
				</thead>
				<thead>
					<tr>
					  <th field="tatype"  width="70px"   rowspan="2">TA类型</th>
                        <th field="jjtype"  width="80px"   rowspan="2">基金类型</th>
                        <th field="c_caption"  width="60px"   rowspan="2">基金状态</th>
                       
                       <!--  <th field="enddate" width="70px" rowspan="2" data-options="styler:myCellStyler1,formatter:myformatter3">封闭结束日</th> -->
						<th   colspan="3">产品份额</th>
					    <th   colspan="3">今日单位净值</th>
						<th   colspan="3">昨日单位净值</th>
						<th   colspan="3">累计单位净值</th>
					<!-- 	<th field="remark"    width="180px"     rowspan="2">备注</th> -->
					</tr>
					<tr>

					  
					  <th field="f_lastshares" width="100px"  data-options="align:'right',formatter:myformatter">分TA</th>
					  <th field="guzhi_fe" width="100px"  data-options="align:'right',formatter:myformatter">估值</th>
					  <th field="fe_cha" width="100px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">差额</th>
					  
					  
					  <th field="f_netvalue" width="60px" data-options="align:'right',formatter:myformatter1">分TA</th>
					  <th field="guzhi_dwjz" width="60px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="dwjz_cha" width="60px"  data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
					 
					  <th field="guzhi_zrdwjz" width="60px"   data-options="align:'right',formatter:myformatter1">分TA</th>
					  <th field="zjzzl" width="60px"  data-options="align:'right',formatter:myformatter2,styler:myCellStyler,sorter:mysorter" sortable="true" 
					   >幅度（%）</th>
					  <th field="bdpd" width="40px"  data-options="align:'right',formatter:myformatter2,styler:myCellStyler">波动判断</th>
					 
					  <th field="f_totalnetvalue" width="60px" data-options="align:'right',formatter:myformatter1">分TA</th>
					  <th field="guzhi_ljdwjz" width="60px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ljdwjz_cha" width="60px" data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
				      
				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div title="配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  <span>账套名称:</span> 
			<span> 
				<input  class="easyui-combobox" id="account_names" name="account_names" 
			                      >
						 
			</span>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddata()">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="pz_removedata()">删除</a> 
			    <!--  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="pz_editdata()">修改</a>  -->
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="pzdg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
						               ">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="account_id" width="100" >账套号</th>
								<th field="account_name" width="250" >账套名称</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>

</div>
<div id="hdpz" class="easyui-dialog" closed="true" title="添加不核对账套"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>账套名称:</span> 
			<span> 
				<input  class="easyui-combobox" id="account_fundname" name="account_fundname" data-options="editable:true">
						 
			</span> 
			</span>
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>


<div id="dlg" class="easyui-dialog" closed="true" title="添加备注信息"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>账套名称:</span> 
			<span> 
				<input type="text" class="easyui-textbox" id="account_name" name="account_name">
						 
			</span>
			<br/><br/>
			<span >开始时间:</span>
			<input id="startdate" name="startdate"
			class="easyui-datebox"  style="width: 172px" editable="false"></input>
			<span>结束时间:</span>
			<input id="enddate" name="enddate"
			class="easyui-datebox"  style="width: 172px" editable="false"></input>
			<br/><br/>
			<span >备&nbsp;&nbsp;注:</span>
			<span> 
			 	<input  class="easyui-textbox" id="remark_s" name="remark_s"style="width: 408px; height:100px;" data-options="multiline:true">
			</span>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
		<div id="REMARK" class="easyui-dialog" closed="true" title="查看备注信息"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
			<span>日&nbsp;&nbsp;期:</span>
			<input id="dates" name="dates"
			class="easyui-textbox"  style="width: 172px"></input>
			<!--<span>更新时间:</span>
			<input id="updates" name="updates"
			class="easyui-textbox"  style="width: 172px"></input>
			 <span>操作者 :</span>
			<input id="upuser" name="upuser"
			class="easyui-textbox"  style="width: 172px"></input> -->
			<br/><br/>
			<span >备&nbsp;&nbsp;注:</span>
			<span> 
			 	<input type="text"  class="easyui-textbox" id="remark_ss" name="remark_ss"style="width: 408px; height:100px;" data-options="multiline:true">
			</span>
				<br/><br/>
			
			
		</div>
 		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> 
				<a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div> 
</body>



