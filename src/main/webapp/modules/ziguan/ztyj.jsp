<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="../guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>昨日单位净值对照</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	     //初始化table
		 
		// add by lrx 20190820
		  $("#fileztyj").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
		 // add by lrx 20190820
		 $("#guzhiname").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
		     method:'post',
			  multiple:false,
			  width:140,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					  onLoadSuccess: function(){
							 $('#guzhiname').next('.combo').find('input').focus(function (){
						            $('#guzhiname').combobox('clear');
						            
						     });
							 
					     }
		 });
    
		 $("#fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:120,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onSelect:function(val){
					    
						 $("#secondtype").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
					              method:'get',
								  multiple:false,
								  width:120,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
							      onLoadSuccess: function(){
							    	  $(this).combobox('enable');
								  }		
					    });
					},
					  onLoadSuccess: function(){
								 $('#fristtype').next('.combo').find('input').focus(function (){
							            $('#fristtype').combobox('clear');
							            $('#secondtype').combobox('clear');
							     });
								 
						     }
					
		 }); 
		 
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


</script>


 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
	  var str =$("#gzdate").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 alert(str);
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
		$.ajax({
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
		});
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
 
 //add by lrx 20190820
function searchZTYJ(zaccount_id,rq,kmdm){
 	
  	 var str =$("#gzdate").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		
			  
		  
		  
        var params="gzdate="+str.replace(/-/g,'');    
      	//alert(params);
        params +="&zth="+$("#zth").combobox('getValue')+"&guzhiname="+$("#guzhiname").combobox('getValue')+
                            "&fristtype="+$("#fristtype").combobox('getValue')+"&secondtype="+$("#secondtype").combobox('getValue')
                            +"&frequency="+$("#s_frequency").combobox('getValue')
                            //+"&ztyj="+$("#ztyj").combobox('getValue');
        if($("#ztyj_check").prop('checked')){
	      	params +="&ztyj_check=1";
		  }
           // alert(params);
            $('#fileztyj').datagrid({method:'get',url:"ziguan/queryZTYJ?"+params}).datagrid('clientPaging'); 
        
	  }
      
 } 


 
</script>
<body>
<div id="tabsidk"  class="easyui-tabs">
 <!--add by lrx 20190820 -->
	 <div title="估值查询新" style="padding: 10px">
	  
		 <div style="margin-top: 5px; margin-bottom: 5px;float: right"></div>
        <div>
        	<span>日期</span>
	       <input id="gzdate" name="gzdate"
			class="easyui-datebox"  style="width: 120px"></input>
		    <span style="margin-left: 15px;">账套名称:</span>
				<input class="easyui-combobox" name="zt_logo" id="zth">
			<span style="margin-left: 15px;">估值人员:</span> 
				<input class="easyui-combobox" name="guzhi_name"
				id="guzhiname"> 
			<span style="margin-left: 15px;">一级分类:</span>
				<input class="easyui-combobox" name="ziguan_logo" id="fristtype">
			<span style="margin-left: 15px;">二级分类:</span>
				<input class="easyui-combobox" name="ziguan_logo" id="secondtype" style="width:120px">
				<span style="margin-left: 15px;">估值频率:</span>
				<span> 
					<select id="s_frequency" class="easyui-combobox" name="type" style="width: 140px;">
						<option value="">请选择</option>
						<option value="0">T+0</option>
						<option value="1">T+1</option>
						<option value="w">周</option>
						<option value="m">月</option>
						<option value="n">不定期</option>
					</select>
				</span>
				<br></br>
				<!--<span style="margin-left: 24px;">账套预警:</span>			
				  <span> 
					<select id="ztyj" class="easyui-combobox" name="ztyj_update" style="width: 250px;">
						<option value="">请选择</option>
						<option value="0">0.03%</option>
						<option value="1">0.05%</option>
						<option value="2">1%</option>
						<option value="3">2%</option>
						<option value="4">3%</option>
					</select>
				</span>-->
				<input type="checkbox" name="ztyj_check" id="ztyj_check" value="1"/>
		 		 <span>筛选超过预警值账套</span>
				
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchZTYJ()">查询</a>
		</div>
		
	  <div style="margin-top: 10px;">
			<table  id="fileztyj"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				               ">
				<thead>
					<tr>
						  <th field="c_port_code_today"    width="60px" rowspan="2">账套号</th>
						   <th field="c_port_name_today"    width="200px" rowspan="2">账套名称</th> 
						    <th colspan="6">T日净值</th>
						  <th colspan="5">T-1日净值</th>
						  <th colspan="5">T-2日净值</th>
						
						
					</tr>
					<tr>
					     <th field="DWJZ_today" width="100px" data-options="formatter:myformatter3">单位净值</th>
					     <th field="LJDWJZ_today" width="100px" data-options="formatter:myformatter3">累计单位净值</th>
					     <th field="RJZZZL_today" width="100px" data-options="formatter:myformatter3">日净值增长率</th>
					     <th field="LJJZZZL_today" width="100px" data-options="formatter:myformatter3">累计净值增长率</th>
					     <th field="ztyj" width="100px" >账套预警设定</th>
					     <th field="ztyj_status" width="100px" >账套预警状态</th>
						
						 <th field="DWJZ_yes" width="100px" data-options="formatter:myformatter3">单位净值</th>
					     <th field="LJDWJZ_yes" width="100px" data-options="formatter:myformatter3">累计单位净值</th>
					     <th field="RJZZZL_yes" width="100px" data-options="formatter:myformatter3">日净值增长率</th>
					     
					     <th field="ztyj" width="100px" >账套预警设定</th>
					     <th field="ztyj_status" width="100px" >账套预警状态</th>
					    
					
					     <th field="DWJZ_before" width="100px" data-options="formatter:myformatter3">单位净值</th>
					     <th field="LJDWJZ_before" width="100px" data-options="formatter:myformatter3">累计单位净值</th>
					     <th field="RJZZZL_before" width="100px" data-options="formatter:myformatter3">日净值增长率</th>
					    
					     <th field="ztyj" width="100px" >账套预警设定</th>
					     <th field="ztyj_status" width="100px" >账套预警状态</th>
					    
					</tr>
					
				</thead>
			</table>
		</div>
		
	
 </div>
 

 
 </div>
</body>



