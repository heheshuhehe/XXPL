<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>科目对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
var mydate_server = '${mydate}' ;
var wbzth_server='${wbzth}';
$(function (){
		//初始化tab页
		$("#tabsidk").tabs({
			width : '100%',
			height : document.documentElement.clientHeight-20
		});
		 
		 $("#dg").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-140
		 });
		 $("#w_dg").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-140
		 });
		 $("#g_dg").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-140
		 });
		 $("#dg1").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-160)
		 });
		 $("#dg2").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-160)
		 });
       $("#userInfo").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
             method:'post',
             multiple:true,
			  multiline:true,
			  width:200,
			  onChange:function() {  
		            var valueField = $(this).combobox("options").valueField;  
		            var val = $(this).combobox("getValue");  //当前combobox的值  
		            var allData = $(this).combobox("getData");   //获取combobox所有数据  
		            var result = true;      //为true说明输入的值在下拉框数据中不存在  
		            for (var i = 0; i < allData.length; i++) {  
		                if (val == allData[i][valueField]) {  
		                    result = false;  
		                    break;  
		                }  
		            }  
		            if (result) {  
		                $(this).combobox("clear");  
		            }  
		      
		        },
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
       
       $("#w_userInfo").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
           method:'post',
           multiple:true,
			  multiline:true,
			  width:200,
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
       
       if(mydate_server!=""&&wbzth_server!=""){
    	   $("#wb_zth").combobox('setValue',wbzth_server);
    	   $("#d_ywrq").datebox('setValue',mydate_server);
    	   searchdata();
      }
       
       $("#g_userInfo").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
           method:'post',
           multiple:true,
			  multiline:true,
			  width:200,
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
       
});
  
function ExporterExcel() {//导出Excel文件
	if($("#d_ywrq").datebox("getValue")==""){
		alert("请选择日期！");
		return false;
	}else{
   		var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&wb_ztmc="+$("#wb_zth").combobox('getText')+
   		"&d_ywrq="+$("#d_ywrq").datebox('getValue')+"&userInfo="+$("#userInfo").combobox('getValue')+"&tgiseql="+$("#tgiseql").combobox('getValue')+
   		"&wbiseql="+$("#wbiseql").combobox('getValue')+"&d_ywrq_end="+$("#d_ywrq_end").datebox('getValue');
   		 window.location.href="<%=cp%>/guzhidz/getShiZhiInfoDown?"+params;
	}
}

</script>
 
<!-- 自定义js -->
<script type="text/javascript">
var params_1="";
function searchdata(){
	if($("#d_ywrq").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
		var chanzt = $("input[name='chanzt']:checked").map(function () {
	        return $(this).val();
	    }).get().join('#'); 
   		var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&wb_ztmc="+$("#wb_zth").combobox('getText')+
   		"&d_ywrq="+$("#d_ywrq").datebox('getValue')+"&userInfo="+$("#userInfo").combobox('getValues')+"&tgiseql="+$("#tgiseql").combobox('getValue')+
   		"&wbiseql="+$("#wbiseql").combobox('getValue')+"&d_ywrq_end="+$("#d_ywrq_end").datebox('getValue')+"&chanzt="+chanzt;
		$('#dg').datagrid({method:'get',
			               url:"<%=cp%>/guzhidz/getShiZhiInfo?"+params,
			               onLoadSuccess:function(data){
			            	     if(data.rows.length>0){
				            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
	 			            	        $("#noteqlNum").html("不一致总数:<span style='color:red;'>"+data.rows[0].noteqlnum+"</span>");
				            	     }
			            	     }else{
			            	    	 $("#noteqlNum").html("");
			            	     }
			            		
			               }
			              }).datagrid('clientPaging'); 
		
	
	}
	
}

function searchdata_wb(){
	if($("#w_d_ywrq").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
   		var params="w_wb_zth="+$("#w_wb_zth").combobox('getValue')+"&w_wb_ztmc="+$("#w_wb_zth").combobox('getText')+
   		"&w_d_ywrq="+$("#w_d_ywrq").datebox('getValue')+"&w_userInfo="+$("#w_userInfo").combobox('getValues')+
   		"&w_wbiseql="+$("#w_wbiseql").combobox('getValue')+"&w_d_ywrq_end="+$("#w_d_ywrq_end").datebox('getValue');
		$('#w_dg').datagrid({method:'get',
			               url:"<%=cp%>/guzhidz/getShiZhiInfoWB?"+params,
			               onLoadSuccess:function(data){
			            	     if(data.rows.length>0){
				            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
	 			            	        $("#w_noteqlNum").html("不一致总数:<span style='color:red;'>"+data.rows[0].noteqlnum+"</span>");
				            	     }
			            	     }else{
			            	    	 $("#w_noteqlNum").html("");
			            	     }
			            		
			               }
			              }).datagrid('clientPaging'); 
		
	
	}
	
}

function searchdata_gq(){
	if($("#g_d_ywrq").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
   		var params="wb_zth="+$("#g_wb_zth").combobox('getValue')+"&wb_ztmc="+$("#g_wb_zth").combobox('getText')+
   		"&g_d_ywrq="+$("#g_d_ywrq").datebox('getValue')+"&g_userInfo="+$("#g_userInfo").combobox('getValues')+
   		"&wbiseql="+$("#g_wbiseql").combobox('getValue')+"&g_ywrq_end="+$("#g_d_ywrq_end").datebox('getValue');
		$('#g_dg').datagrid({method:'get',
			               url:"<%=cp%>/guzhidz/getShiZhiInfoGQ?"+params,
			               onLoadSuccess:function(data){
			            	     if(data.rows.length>0){
				            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
	 			            	        $("#noteqlNum").html("不一致总数:<span style='color:red;'>"+data.rows[0].noteqlnum+"</span>");
				            	     }
			            	     }else{
			            	    	 $("#noteqlNum").html("");
			            	     }
			            		
			               }
			              }).datagrid('clientPaging'); 
		
	
	}
	
}

function queryGTInfo(gth,gth_rzrq,mydate){
	$("#tabsidk").tabs('select', "证券/资金明细");
	 //var params="gth="+gth+"&biz_dt="+$("#d_ywrq").datebox('getValue');
	 params_1="gth="+gth+"&biz_dt="+mydate+"&gth_rzrq="+gth_rzrq;
	$('#dg1').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryZQMX?"+params_1}).datagrid('clientPaging'); 
	$('#dg2').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryZJMX?"+params_1}).datagrid('clientPaging'); 
}

function zjExporterExcel() {//导出Excel文件
	if(params_1==""){
		alert("请选择需要导出的数据！");
		return false;
	}else{
	
	   // alert("请选择核对资金明细！"+params_1);
	    window.location.href="<%=cp%>/zgbfj/getzjmxInfoDown?"+params_1;
	    
    }
  
}
function zqExporterExcel() {//导出Excel文件
	
	if(params_1==""){
		alert("请选择需要导出的数据！");
		return false;
	}else{
		//alert("请选择核对证券明细！"+params_1);
		window.location.href="<%=cp%>/zgbfj/getzqmxInfoDown?"+params_1;
	}

}
</script>
<script type="text/javascript">
 function hideOrShow(type){
	 if(type==1){
		 $("#zjmx").toggle();
	 }else if(type==2){
		 $("#zqmc").toggle();
	 }
 }
 
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="托管柜台号核对" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> <input class="easyui-combobox" name="wb_zth"
				id="wb_zth"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectVal?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:200,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									     });
								     }
									 ">
		   	 <span style="margin-left: 30px;">日期起</span>  	
		     <span><input id="d_ywrq" name="d_ywrq" class="easyui-datebox" style="width: 150px"></input></span>
		     <span style="color: red;">*</span>
		     <span style="margin-left: 15px;">日期止</span>  	
		     <span><input id="d_ywrq_end" name="d_ywrq_end" class="easyui-datebox" style="width: 150px"></input></span>
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> 
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
			 <br/>
			 <span>估值人员:</span>
			 <input class="easyui-combobox" name="userInfo" id="userInfo">
			 <span style="margin-left: 15px;">托管一致:</span>
			 <span>
				<select id="tgiseql" class="easyui-combobox" name="tgiseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="tg_eql">托管一致</option>
					<option value="tg_noteql">托管不一致</option>
				</select>
			 </span>
			 <span style="margin-left: 10px;">外包一致:</span>
			 <span>
				<select id="wbiseql" class="easyui-combobox" name="wbiseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="wb_eql">外包一致</option>
					<option value="wb_noteql">外包不一致</option>
				</select>
			 </span>
			 <input type="checkbox" name="chanzt" value="1"  id="chanzt" />天天利/天天增不为零  
			  <span id='noteqlNum' style="font-size:20px;float: right;"></span>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="dg" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<tr>
					    <th field="noteqlnum" width="150" data-options="hidden:true"></th>
					    <th field="datestr" width="150">日期</th>
					    <th field="wb_ztmc" width="150">外包账套名称</th>
						<th field="wbzth" width="70">外包账套号</th>
					    <th field="tg_zth" width="70">托管账套号</th>
						<th field="gth" width="100">柜台号</th>
						<th field="n_hldmkv_locl" width="100" data-options="align:'right',formatter:myformatter">外包估值</th>
						<th field="en_sz" width="100" data-options="align:'right',formatter:myformatter">托管估值</th>
						<th field="captl_bal" width="100" data-options="align:'right',formatter:myformatter">柜台估值</th>
						<th field="sumttl" width="100" data-options="hidden:true" data-options="align:'right',formatter:myformatter">柜台资金合计</th>
						<th field="ttl_code" width="100" data-options="align:'right'">天天利/天天增编码</th>
						<th field="ttl" width="100" data-options="align:'right',formatter:myformatter">天天利/天天增</th>
						<th field="tgiseql" width="90" data-options="align:'right',formatter:myformatter">托管是否一致</th>
						<th field="wbiseql" width="90" data-options="align:'right',formatter:myformatter">外包是否一致</th>
						<th field="gth_rzrq" width="100">柜台号(融)</th>
						<th field="n_hldmkv_locl_rzrq" width="100" data-options="align:'right',formatter:myformatter">外包估值(融)</th>
						<th field="en_sz_rzrq" width="100" data-options="align:'right',formatter:myformatter">托管估值(融)</th>
						<th field="captl_bal_rzrq" width="100" data-options="align:'right',formatter:myformatter">柜台估值(融)</th>
						<th field="tgiseql_rzrq" width="90" data-options="align:'right',formatter:myformatter">托管是否一致</th>
						<th field="wbiseql_rzrq" width="90" data-options="align:'right',formatter:myformatter">外包是否一致</th>
						<th field="myquery" width="40">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="证券/资金明细" style="padding: 5px;">
	
	<div  style="margin-top: 5px; margin-bottom: 5px;" >
		<span  id="" name="">
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="zjExporterExcel()">资金明细导出</a>
		</span>
		<span id="" name="">
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="zqExporterExcel()">证券明细导出</a>
		</span>
	</div>	
	<div class="easyui-accordion" style="height:440px;">
	     <div title="资金明细信息" style="overflow:auto;">
					<table id="dg1" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              ">
						<thead>
							<tr>
								<th field="dt" width="80">时间</th>
								<th field="cust_no" width="80">柜台资金号</th>
								<th field="cust_name" width="100">基金名称</th>
								<th field="sec_code" width="80">证券代码</th>
								<th field="sec_short_name" width="80">证券名称</th>
								<th field="business_name" width="80">交易行为</th>
								<th field="sec_chg" width="80">证券变动</th>
								<th field="sec_bal" width="80">证券余额</th>
								<th field="fund_chg" width="80">资金变动</th>
								<th field="fund_bal" width="80">资金余额</th>
								<th field="done_amt" width="80">资金发生额</th>
								<!--   
								<th field="currency_type" width="30">货币类型</th>
								<th field="sec_type" width="30">sec_type</th>
								<th field="business_code" width="50">业务编码</th>
								<th field="done_amt" width="50">done_amt</th>
								<th field="flag" width="50">flag</th>
								<th field="branch_name" width="50">交易机构</th>
								<th field="currency_name" width="50">货币名称</th>
								<th field="sec_typt_desc" width="50">sec_typt_desc</th>
								  <th field="occur_date" width="50">时间</th>
								<th field="occur_time" width="50">发生时间</th>
								<th field="serial_no" width="50">serial_no</th>
								<th field="branch_code_1" width="50">branch_code_1</th>
								<th field="holder_acc_no" width="50">holder_acc_no</th>
								-->
							</tr>
						</thead>
					</table>
	   </div>
	   <div title="证券明细信息" style="overflow:auto;">
			<table id="dg2"  
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<tr>
						<th field="dt" width="80">时间</th>
						<th field="cust_no" width="80">柜台资金号</th>
						<th field="name" width="100">基金名称</th>
						<th field="market_name" width="100">市场</th>
						<th field="sec_code" width="100">证券代码</th>  
						<th field="sec_short_name" width="100">证券名称</th>
						<th field="pos_qutty" width="100">股份数</th>
						<th field="sec_price" width="100">股票价格</th>
						<th field="mkt_value" width="100">市值</th>
						<!--  <th field="flag" width="100">flag</th>
						<th field="market_code" width="100">市场</th>
						-->
					</tr>
				</thead>
			</table>
		</div>
	</div>
	</div>
	
	
	<div title="外包核对" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> <input class="easyui-combobox" name="w_wb_zth"
				id="w_wb_zth"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectVal?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:200,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('#w_wb_zth').next('.combo').find('input').focus(function (){
									            $('#w_wb_zth').combobox('clear');
									     });
								     }
									 ">
		   	 <span style="margin-left: 25px;">日期起</span>  	
		     <span><input id="w_d_ywrq" name="w_d_ywrq" class="easyui-datebox" style="width: 150px"></input></span>
		     <span style="color: red;">*</span>
		     <span style="margin-left: 15px;">日期止</span>  	
		     <span><input id="w_d_ywrq_end" name="d_ywrq_end" class="easyui-datebox" style="width: 150px"></input></span>
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_wb()">查询</a> 
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel_wb()">导出</a> 
			 <br/>
			 <span>估值人员:</span>
			 <input class="easyui-combobox" name="w_userInfo" id="w_userInfo">
			 <span style="margin-left: 10px;">外包一致:</span>
			 <span>
				<select id="w_wbiseql" class="easyui-combobox" name="w_wbiseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="wb_eql">外包一致</option>
					<option value="wb_noteql">外包不一致</option>
				</select>
			 </span>
			  <span id='w_noteqlNum' style="font-size:20px;float: right;"></span>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="w_dg" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<tr>
					    <th field="noteqlnum" width="150" data-options="hidden:true"></th>
					    <th field="datestr" width="150">日期</th>
					    <th field="wb_ztmc" width="150">外包账套名称</th>
						<th field="wbzth" width="70">外包账套号</th>
					    <!-- <th field="tg_zth" width="70">托管账套号</th> -->
						<th field="gth" width="100">柜台号</th>
						<th field="n_hldmkv_locl" width="100" data-options="align:'right',formatter:myformatter">外包估值</th>
						<!-- <th field="en_sz" width="100" data-options="align:'right',formatter:myformatter">托管估值</th> -->
						<th field="captl_bal" width="100" data-options="align:'right',formatter:myformatter">柜台估值</th>
						<th field="sumttl" width="100" data-options="hidden:true" data-options="align:'right',formatter:myformatter">柜台资金合计</th>
						<th field="ttl" width="150" data-options="align:'right',formatter:myformatter">外包天天利/天天增</th>
						<th field="ttlttz" width="150" data-options="align:'right',formatter:myformatter">柜台天天利/天天增</th>
						<!-- <th field="tgiseql" width="90" data-options="align:'right',formatter:myformatter">托管是否一致</th> -->
						<th field="wbiseql" width="90" data-options="align:'right',formatter:myformatter">外包是否一致</th>
						<th field="gtiseql" width="90" data-options="align:'right',formatter:myformatter">天天利是否一致</th>
						<th field="myquery" width="40">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	
 <div title="个股期权" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> <input class="easyui-combobox" name="g_wb_zth"
				id="g_wb_zth"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectVal?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:200,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('#g_wb_zth').next('.combo').find('input').focus(function (){
									            $('#g_wb_zth').combobox('clear');
									     });
								     }
									 ">
		   	 <span style="margin-left: 25px;">日期起</span>  	
		     <span><input id="g_d_ywrq" name="g_d_ywrq" class="easyui-datebox" style="width: 150px"></input></span>
		     <span style="color: red;">*</span>
		     <span style="margin-left: 15px;">日期止</span>  	
		     <span><input id="g_d_ywrq_end" name="d_ywrq_end" class="easyui-datebox" style="width: 150px"></input></span>
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_gq()">查询</a> 
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel_gq()">导出</a> 
			 <br/>
			 <span>估值人员:</span>
			 <input class="easyui-combobox" name="g_userInfo" id="g_userInfo">
 			 <span style="margin-left: 15px;">托管一致:</span>
			 <span>
				<select id="g_tgiseql" class="easyui-combobox" name="g_tgiseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="tg_eql">托管一致</option>
					<option value="tg_noteql">托管不一致</option>
				</select>
			 </span> 
			 <span style="margin-left: 10px;">外包一致:</span>
			 <span>
				<select id="g_wbiseql" class="easyui-combobox" name="g_wbiseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="wb_eql">外包一致</option>
					<option value="wb_noteql">外包不一致</option>
				</select>
			 </span>
			  <span id='g_noteqlNum' style="font-size:20px;float: right;"></span>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="g_dg" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<tr>
					    <th field="noteqlnum" width="150" data-options="hidden:true"></th>
					    <th field="datestr" width="150">日期</th>
					    <th field="wb_ztmc" width="150">外包账套名称</th>
						<th field="wbzth" width="100">外包账套号</th>
						<th field="tg_zth" width="100">托管账套号</th>
						<th field="stock_option" width="100">个股期权柜台号</th>
						<th field="captl_bal" width="100" data-options="align:'right',formatter:myformatter">个股期权</th>
						<th field="wb_bzj" width="100" data-options="align:'right',formatter:myformatter">保证金(外包)</th>
						<th field="wb_bfj" width="100" data-options="align:'right',formatter:myformatter">备付金(外包)</th>
						<th field="tg_bzj" width="100" data-options="align:'right',formatter:myformatter">保证金(托管)</th>
						<th field="tg_bfj" width="100" data-options="align:'right',formatter:myformatter">备付金(托管)</th>
<!-- 						<th field="en_sz" width="100" data-options="align:'right',formatter:myformatter">保证金(个股)</th>
						<th field="captl_bal" width="100" data-options="align:'right',formatter:myformatter">备付金(个股)</th> -->
						<th field="wbiseql" width="90" data-options="align:'right',formatter:myformatter">外包是否一致</th>
						<th field="tgiseql" width="90" data-options="align:'right',formatter:myformatter">托管是否一致</th>
<!-- 						<th field="myquery" width="40">操作</th> -->
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	
</div>

</body>





