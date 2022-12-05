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
	     //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
		 $("#pz_dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
		 $("#filepzdg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
		 // add by lrx
		 $("#filepjjhd").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


</script>
<!-- 配置js -->
<script type="text/javascript">
Date.prototype.format = function(formatStr){   
    var str = formatStr;   
    var Week = ['日','一','二','三','四','五','六'];   
    str=str.replace(/yyyy|YYYY/,this.getFullYear());  
    str=str.replace(/MM/,(this.getMonth()+1)>9?(this.getMonth()+1).toString():'0' + (this.getMonth()+1));   
    str=str.replace(/dd|DD/,this.getDate()>9?this.getDate().toString():'0' + this.getDate());   
   return str;   
} 

function searchPeizhi(){
     	var params ="pz_zth="+$("#pz_zth").combobox('getValue');
     	 $('#pz_dg').datagrid({method:'get',
             url:"guzhidz/getJingZhiInfoPeizhi?"+params,
             onLoadSuccess:function(data){
	            	     if(data.rows.length>0){
		            	     if(typeof(data.rows[0].sumnoteql)!="undefined"){
		            	        $("#sumnoteql").html("<span style='color:red;'>"+data.rows[0].sumnoteql+"</span>个产品代码单位净值和累计单位净值不一致!"+
		            	        		"<span style='color:red;'>"+data.rows[0].sumbd+"</span>个产品净值波动超过10%!");
		            	        
		            	       
		            	     }
	            	     }
	           }}).datagrid('clientPaging'); 
}
function deletePeizhi(){
	if($("input[name='ck']:checked").length==0){
		alert("请选择要删除的数据");
	    return false;
	}else{
		var ids ="";
		$.each($("input[name='ck']:checked"),function(){
			ids +=$(this).val()+",";
		});
	    if(ids!=""){
		    ids = ids.substring(0,ids.length-1);
			$.ajax({
				url:'<%=cp%>/guzhidz/deleteJingZhiInfoPeizhi',
				type : 'post',
				data : {IDS : ids},
				dataType : "json",
				success : function(data) {
						alert("删除成功！");
						searchPeizhi();
				}
			});
	    }
	}
	
}
function adddata(){
	if($("#pz_zth_add").combobox('getValue')!=""){
		 var code = $("#pz_zth_add").combobox('getValue');
		 var name=  $("#pz_zth_add").combobox('getText');
		 $.ajax({
				url:'<%=cp%>/guzhidz/addJingZhiInfoPeizhi',
				type : 'post',
				data : {code : code,
					    name : name
					    },
				dataType : "json",
				success : function(data) {
					    alert("添加成功！");
					    closeDialog();
						searchPeizhi();
				}
			});
		 
	}else{
		alert("请选择账套名称");
		return false;
	}
}
function closeDialog(){
	$('#pz_zth_add').combobox('clear');
	$('#dlg').dialog('close');
	$('#enddate').datebox('clear');
	$('#startdate').datebox('clear');
	$('#remark_s').textbox('clear');
	$('#upuser').textbox('clear');
	$('#dates').textbox('clear');
	$('#updates').textbox('clear');
	$('#remark_ss').textbox('clear');
	$('#dlgs').dialog('close');
	$('#dlg').dialog('close');
	$('#REMARK').dialog('close');
}

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
	  var str =$("#wbdate_zt").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 
        var params="wbdate="+str.replace(/-/g,'');
        
        if($("#iseql").prop("checked")){
        	params +="&iseql=1";
        }
        if($("#isbd").prop("checked")){
        	params +="&isbd=1";
        }
        
        if($("#isnotpipei").prop("checked")){
        	params +="&isnotpipei=1";
        }
        //add by lrx
        if($("#iseqsetupdate").prop("checked")){
        	params +="&iseqsetupdate=1";
        }
        
        if($("#wb_zth").combobox('getValue')!=""){
        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
        }
        
        
        $('#dg').datagrid({method:'get',
        	               url:"guzhidz/getJingZhiInfo?"+params,
        	               onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
					            	     if(typeof(data.rows[0].sumnoteql)!="undefined"){
		 			            	        $("#sumnoteql").html("<span style='color:red;'>"+data.rows[0].sumnoteql+"</span>个产品代码单位净值和累计单位净值不一致!"+
		 			            	        		"<span style='color:red;'>"+data.rows[0].sumbd+"</span>个产品净值波动超过10%!");
		 			            	        
		 			            	       
					            	     }
				            	     }
				           }}).datagrid('clientPaging'); 
	  }
      
 }
 
 function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:red;';
		}
 }
 function myCellStyler1(value,row,index){
	var oDate = new Date();
	var year = oDate.getFullYear();   //获取系统的年；
	var mon =  oDate.getMonth()+1;   //获取系统月份，由于月份是从0开始计算，所以要加1
	var day = oDate.getDate(); // 获取系统日
	var str = year+""+mon+""+day;
	if(value<str){
		return 'color:#1E90FF;';
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
 			    var re =/(-?\d+)(\d{3})/
 			    while(re.test(intPart)){
 			     intPart =intPart.replace(re,"$1,$2")
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
 			    var re =/(-?\d+)(\d{3})/
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
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2")
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/
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
	 var re =/(\d{4})(\d{2})(\d{2})/
	 while(re.test(value)){
		 value =value.replace(re,"$1-$2-$3");
	 }
	 return value;
}

/************************添加备注：时间20161214*************************/
//新增
 function opendialog(){	
 var id = $("input[name='ck']:checked").closest("tr").find("td[field='ztmc']").text();
 if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		$("#account_name").textbox('setValue',id);
		$("#account_name").textbox('disable');
		//$("#starttime").datebox('setValue',strDate);
		
		
	
		
	    $('#dlgs').dialog('open');
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
 
 //保存
 function addAcountMapping(){
 	var curr_time = new Date();
		var strDate = curr_time.getFullYear() + "-";
		if(curr_time.getMonth()<10){
		strDate += "0"+(curr_time.getMonth() + 1) + "-";
		} else{
		strDate += curr_time.getMonth() + 1 + "-";
		}
		if(curr_time.getDate()<10){
		strDate += "0"+curr_time.getDate();
		}else{
		strDate += curr_time.getDate() ;
		}
		/* strDate += curr_time.getHours() + ":";
		strDate += curr_time.getMinutes() + ":"; */
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
			url:'<%=cp%>/guzhidz/queryBZ',
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
			url:'<%=cp%>/guzhidz/updateBZ',
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
 
 /*查看备注信息*/
 function GZsearchdata(account_id){
 //var account_id=$("input[name='ck']:checked").val();
 var wbdate=$("#wbdate").datebox('getValue');
/* if ($("input[name='ck']:checked").length!=1){
 		alert("请选择一条数据！");
 		return false;
 	} */
	if (wbdate=="") {
			alert("请选择查询时间！");
				return false;
	}else{
	$.ajax({
			url:'<%=cp%>/guzhidz/queryBZ',
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
 	var wbdate=$("#wbdate_zt").datebox('getValue');
  	if (wbdate=="") {
		alert("请选择查询时间！");
		return false;
	} else{
		var datestr=new Date().format("yyyy-MM-dd");
		if(datestr!=wbdate){
			alert("历史数据不允许再次保存，"); 
		}else{
			 backups(wbdate);
			    closeDialog();
		}
		<%-- $.ajax({
			url:'<%=cp%>/guzhidz/querySerachBF',
			type:'post',
			data:{wbdate:wbdate,account_id:account_id},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){
					 var json =data.data;
					 if(json.length>0){
					 var  enddate = json[0].bfrq;
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
		}); --%>
	}
 }
 //备份
 function backups(wbdate){
 
  var account_id=$("input[name='ck']:checked").val();
  
  var str =$("#wbdate_zt").combobox('getValue');
  
  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 
        var params="wbdate="+str.replace(/-/g,'')+"&type=old";
        
        if($("#iseql").prop("checked")){
        	params +="&iseql=1";
        }
        if($("#isbd").prop("checked")){
        	params +="&isbd=1";
        }
        if($("#wb_zth").combobox('getValue')!=""){
        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
        }
        
 
  	  var wbdate_1 =$("#wbdate_zt").combobox('getValue');
  	  
      params += "&account_id="+account_id+"&wbdate_1="+wbdate_1
  	  	
	  if(wbdate_1==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 $.ajax({
			url:'<%=cp%>/guzhidz/queryBF?'+params,
			type:'post',
			//data:{wbdate:wbdate,account_id:account_id},
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
 };
 
 function searchhedui(zaccount_id,rq,kmdm){
 	
  	 var str =$("#wbdate_new").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
        var params="wbdate_new="+str.replace(/-/g,'');
        
        if($("#iseql_new").prop("checked")){
        	params +="&iseql_new=1";
        }
        if($("#isbd_new").prop("checked")){
        	params +="&isbd_new=1";
        }
        
        if($("#isnotpipei").prop("checked")){
        	params +="&isnotpipei_new=1";
        }
        if($("#wb_zth_new").combobox('getValue')!=""){
        	params +="&wb_zth_new="+$("#wb_zth_new").combobox('getValue');
        }
       
        
        
        $('#filepzdg').datagrid({method:'get',
        	               url:"guzhidz/getSearchHeDui?"+params,
        	               onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
					            	     if(typeof(data.rows[0].sumnoteql)!="undefined"){
		 			            	        $("#sumnote").html("<span style='color:red;'>"+data.rows[0].sumnoteql+"</span>个产品代码单位净值和累计单位净值不一致!"+
		 			            	        		"<span style='color:red;'>"+data.rows[0].sumbd+"</span>个产品净值波动超过10%!");
		 			            	        
		 			            	       
					            	     }
				            	     }
				           }}).datagrid('clientPaging'); 
	  }
      
 } 
 // add by lrx
  function searchJJHedui(zaccount_id,rq,kmdm){
	  //alert("hellow");
	  var params="";
	  if($("#iseqestablish_date").prop('checked')){
      	params +="&iseqestablish_date=1";
	  }
	  
	//  if($("#isgznull_date").prop('checked')){
  	  //    	params +="&isgznull_date=1";
	  //}
      $('#filepjjhd').datagrid({method:'get',
          url:"guzhidz/searchJJHedui?"+params,
              onLoadSuccess:function(){
	           }}).datagrid('clientPaging'); 
	 
 }
 
</script>
<body>
<div id="tabsidk"  class="easyui-tabs">
<div title="配置" style="padding: 5px">
		  <div style="margin-top: 5px; margin-bottom: 5px;">
				<span>账套名称:</span>
				 <input class="easyui-combobox" name="pz_zth" id="pz_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectVal?selectType=03',
		                          method:'post',
								  multiple:false,
								  width:200,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#pz_zth').next('.combo').find('input').focus(function (){
									            $('#pz_zth').combobox('clear');
									 });
			     }  ">
	
	      		<p style="display: none;"> <input id="wbdate" name="wbdate" class="easyui-datebox"  style="width: 120px"></input> </p>
			    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchPeizhi()">查询</a>
                <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="$('#dlg').dialog('open')">新增</a>
			    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deletePeizhi()">删除 </a>
          </div>
	      <div style="margin-top: 10px;">
	         <table  id="pz_dg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="zth" width="70" >账套号</th>
								<th field="ztmc" width="250" >账套名称</th>
							</tr>
						</thead>
					</table>
		 </div>
    <div id="dlg" class="easyui-dialog" closed="true" title="添加不对照的账套"
			style="width: 550px; height: 300px; padding: 10px;"
			data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
			<span style="margin-left:20px;">账套名称:</span> 
			<span> 
			  <input class="easyui-combobox" name="pz_zth_add" id="pz_zth_add"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectVal?selectType=03',
		                          method:'post',
								  multiple:false,
								  width:200,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#pz_zth_add').next('.combo').find('input').focus(function (){
									            $('#pz_zth_add').combobox('clear');
									 });
			     }  ">
				 
			</span> 
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="adddata()">新增</a> 
		    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialog()">取消</a>
		</div>
		 
</div>

	<div title="净值对照" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
		 <span>账套名称:</span>
		 <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectVal?selectType=03',
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
		  <span>确认日期</span>
	      <input id="wbdate_zt" name="wbdate"
			class="easyui-datebox"  style="width: 120px"></input>
		 <span style="color: red;">*</span>	
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="opendialog()">新增备注</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="searchbackups()">存储核对信息</a>
<!--              <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="searchhedui()">查看核对信息</a> -->
          <br></br>
		  <input type="checkbox" name="iseql" id="iseql" value="1"/>
		  <span>只显示单位净值和累计单位净值不一致</span>
		  <input type="checkbox" name="isbd" id="isbd" value="1"/>
		  <span>只显示单位净值波动超过10%的产品</span>
		  <input type="checkbox" name="isnotpipei" id="isnotpipei" value="1" style="display: none;"/>
<!-- 		  <span>TA与外包没有匹配</span> -->
		  <input type="checkbox" name="iseqsetupdate" id="iseqsetupdate"  style="display: none;" value="1"/>
<!-- 		  <span>基金成立日期不一致</span> -->
		  		 
		</div>
		
	   <div style="margin-top: 5px; margin-bottom: 5px;float: right" id="sumnoteql"></div>
		
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
									  if(!isNaN(row.ch1)||!isNaN(row.ch2)||!isNaN(row.ch4)){
									  str='background-color:#F6BCBC;';
									  }
									  return  str;
								}">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true,"rowspan="2" ></th>
                        <th field="ztmc"    width="180px"     rowspan="2">基金名称</th>
                        <th field="status"  width="60px"   rowspan="2">状态</th>
                        <th field="enddate" width="70px" rowspan="2" data-options="styler:myCellStyler1,formatter:myformatter3">净值日期</th>
						<th   colspan="3">产品代码</th>
						<th   colspan="3">产品份额</th>
					    <th   colspan="3">昨日单位净值</th>
						<th   colspan="3">T-1日单位净值</th>
						<th   colspan="3">累计单位净值</th>

						<th field="remark" width="180px" rowspan="2">备注</th>
					</tr>
					<tr>
					  <th field="ta" width="44px" >自建TA</th>
					  <th field="gz" width="44px" >估值</th>
					  <th field="zth" width="42px" >账套号</th>
					  
					  <th field="ta1" width="90px"  data-options="align:'right',formatter:myformatter">自建TA</th>
					  <th field="gz1" width="90px"  data-options="align:'right',formatter:myformatter">估值</th>
					  <th field="ch1" width="90px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">差额</th>
					  
					  <th field="ta2" width="50px" data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="gz2" width="50px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ch2" width="50px"  data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
					  
					  <th field="ta3" width="50px"   data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="fudu" width="50px"  data-options="align:'right',formatter:myformatter2">幅度</th>
					  <th field="bdpd" width="50px"  data-options="align:'right',formatter:myformatter2">波动判断</th>
					  
					  <th field="ta4" width="50px" data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="gz4" width="50px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ch4" width="50px" data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
					  

					  
				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
		

		
		<div id="dlgs" class="easyui-dialog" closed="true" title="添加备注信息"
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
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> --> 
				<a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
</div>
	</div>

	<div title="核对信息" style="padding: 5px">
	
	  <div style="margin-top: 5px; margin-bottom: 5px;">
		 <span>账套名称:</span>
		 <input class="easyui-combobox" name="wb_zth_new" id="wb_zth_new"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectVal?selectType=03',
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
		  <span>日期</span>
	      <input id="wbdate_new" name="wbdate_new"
			class="easyui-datebox"  style="width: 120px"></input>
		 <span style="color: red;">*</span>	
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchhedui()">查询</a>
<!--              <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="searchhedui()">查看核对信息</a> -->
          <br></br>
          <p style="display: none"> 
		  <input type="checkbox" name="iseql_new" id="iseql_new" value="1"/>
		  <span>只显示单位净值和累计单位净值不一致</span>
		  <input type="checkbox" name="isbd_new" id="isbd_new" value="1"/>
		  <span>只显示单位净值波动超过10%的产品</span>
		  <input type="checkbox" name="isnotpipei_new" id="isnotpipei_new" value="1"/>
		  <span>TA与外包没有匹配</span>
		  </p>
		</div>
		 <div style="margin-top: 5px; margin-bottom: 5px;float: right" id="sumnote"></div>
		
	  <div style="margin-top: 10px;">
	  
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						 <th field="ztmc"    width="180px"     rowspan="2">基金名称</th>
                        <th field="status"  width="60px"   rowspan="2">状态</th>
                        <th field="enddate" width="70px" rowspan="2" data-options="styler:myCellStyler1,formatter:myformatter3">封闭结束日</th>
						<th   colspan="3">产品代码</th>
						<th   colspan="3">产品份额</th>
					    <th   colspan="3">昨日单位净值</th>
						<th   colspan="3">T-1日单位净值</th>
						<th   colspan="3">累计单位净值</th>
					
					</tr>
					<tr>
					  <th field="ta" width="44px" >自建TA</th>
					  <th field="gz" width="44px" >估值</th>
					  <th field="zth" width="42px" >账套号</th>
					  
					  <th field="ta1" width="90px"  data-options="align:'right',formatter:myformatter">自建TA</th>
					  <th field="gz1" width="90px"  data-options="align:'right',formatter:myformatter">估值</th>
					  <th field="ch1" width="90px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">差额</th>
					  
					  <th field="ta2" width="50px" data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="gz2" width="50px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ch2" width="50px"  data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
					  
					  <th field="ta3" width="50px"   data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="fudu" width="50px"  data-options="align:'right',formatter:myformatter2">幅度</th>
					  <th field="bdpd" width="50px"  data-options="align:'right',formatter:myformatter2">波动判断</th>
					  
					  <th field="ta4" width="50px" data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="gz4" width="50px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ch4" width="50px" data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
					  
					
					  
					  
					  
				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 <!--add by lrx  -->
<div title="基金成立日期" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
		 
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchJJHedui()">查询</a>
  
		  <input type="checkbox" name="iseqestablish_date" id="iseqestablish_date" value="1"/>
		  <span>基金成立日期不一致</span>
		  <!--  <input type="checkbox" name="isgznull_date" id="isgznull_date" value="1"/>
		  <span>估值系统日期为空值</span>
		  -->
		</div>
		 <div style="margin-top: 5px; margin-bottom: 5px;float: right" id="sumnote"></div>
		
	  <div style="margin-top: 10px;">
			<table  id="filepjjhd"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						  <th field="jjmc"    width="500px" rowspan="2">基金名称</th>
						  <th field="c_fundcode"    width="180px" rowspan="2">基金代码</th>
						  <th colspan="3">基金成立日期</th>
					</tr>
					<tr>
					     <th field="ta6" width="100px" data-options="formatter:myformatter3">自建TA</th>
					     <th field="gz6" width="100px" data-options="formatter:myformatter3">估值</th>
					     <th field="ch6" width="210px" >基金成立日期比对结果</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 </div>
</body>



