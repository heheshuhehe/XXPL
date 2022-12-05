<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="../guzhi/resoures.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script>document.documentElement.focus();</script>
<script type="text/javascript" src="<%=basePath%>myjs/report.js"></script>


</head>
<!-- 初始化操作 -->
<script type="text/javascript">
var heduiTable="#managerTable";
var mingxiTable="#mingXiTable";
var dateNO = "#smoNO";
var dateNOMingXi ="#smoMonthNOMingXi";
var reportType = "SMO";
var info = "smoinfo";
var mingxi = 'smoMingXi';
	$(function (){
		 //初始化核对table
		 $("#managerTable").datagrid({
			 striped: 'true',
		 	 width 	: '100%',
	    	 height : document.documentElement.clientHeight-80
		 });
		 //初始化明细table
		 $("#mingXiTable").datagrid({
			 striped: 'true',
		 	 width 	: '100%',
	    	 height : document.documentElement.clientHeight-80
		 }).datagrid('enableCellEditing').datagrid('gotoCell', {
				striped: 'true',
				index: 0,
				field: 'disc_type_code'
		});
	});
</script>

<!-- 自定义js -->
<script type="text/javascript">
function search1FundDataChkRslt(dateNOString,fundCode,managerName){
	$("#tabsidk").tabs('select', "明细");
	var params="reportType=SMO&dateNO="+dateNOString+"&fundCode="+fundCode+"&heDuiYiZhi=0";
	$(mingXiTable).datagrid({method:'post',url:"<%=cp%>/xinxipilu/search1FundDataChkRslt?"+params}).datagrid('clientPaging'); 
	$(dateNOMingXi).combobox('setValue',dateNOString);
 	$('#managerNameMingXi').combobox('setValue',managerName);
}
function searchQuantData(reportType){
 	if ($(dateNO).combobox('getText')==''  ){
		alert ('请选择月份');
		$(dateNO).focus();
	}else if ($(dateNO).combobox('getText').length!=6){
		alert ('请输入合法月份, 如 '+'202012');
	}else {	//合法月份
			   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
	   	params = "quantMonthNO="+$(dateNO).combobox('getText')+"&managerName="+$("#managerName").combobox('getText') + "&reportType="+reportType
			+"&isPrinted="+$("#isPrinted").combobox('getValue')
   			;
	   	$(heduiTable).datagrid({method:'post',url:"<%=cp%>/xinxipiluQuant/searchQuantYueBao?"+params}).datagrid('clientPaging');
	}	
		

}

/**
 * 导出3份文件
 */
function exportFiles(){
	var rows = $(heduiTable).datagrid('getChecked');//.datagrid('getSelected');row
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}else{
		$.post(
		       	"<%=cp%>/xinxipiluQuant/generateQuantExcel?reportType=month",
		        {"data":JSON.stringify(rows)},　　　　　　　　　　　//提交的数据是把上面的hero转化为json格式
		        function(data) { 
		        	if(data) {
		        		//console.log("data is "+data);
		        		if (data.indexOf("success")>=0) {
		        			alert("提交成功，请稍后在共享盘中查看文件");
		        		} else{
		        			alert(data.replace('fail=',''));
		        			return;
		        		}
		        	} else {
		        		alert("未能成功提交导出请求，请联系系统人员");
		        	}
		}); 
		$(heduiTable).datagrid('reload'); 
	}
}

/**
 * 重新采集数据，导入外包和tu信息
 */
function recollection(){
	var rows = $(heduiTable).datagrid('getChecked');//.datagrid('getSelected');row
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}else{
		$.post(
		       	"<%=cp%>/xinxipilu/generate3Files?reportType=month",
		        {"data":JSON.stringify(rows)},　　　　　　　　　　　//提交的数据是把上面的hero转化为json格式
		        function(data) { 
		        	if(data) {
		        		//console.log("data is "+data);
		        		if (data.indexOf("success")>=0) {
		        			alert("提交成功，请稍后在共享盘中查看文件");
		        		} else{
		        			alert(data.replace('fail=',''));
		        			return;
		        		}
		        	} else {
		        		alert("未能成功提交导出请求，请联系系统人员");
		        	}
		}); 
		$(heduiTable).datagrid('reload'); 
	}
}


/**
 * 动态地将字体变红
 */
function turnRed(val,row){
 	if (val == '核对不一致'){
 		return '<span style="color:red;">'+val+'</span>';
 	} else {
		return val;
	} 
}
</script>
<body>
	<div id="tabsidk" class="easyui-tabs" >
		<div title="管理人" style="padding: 5px">
			<div title="量化基金管理人列表" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;">
					<span>月份:</span>  <input class="easyui-combobox" name="smoNO"
						id="smoNO"
						data-options="
				                      valueField: 'id',
									  textField: 'date_no',
									  mode:'local',
									  url:'<%=cp%>/xinxipiluQuant/getAllFundDate?date_Type='+reportType,  
			                          method:'get',
									  multiple:false,
									  width:150,
									  onLoadSuccess: function(data){
									  $('#quantMonthNO').combobox('setValue',data[0].value);
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 "> 
					<span>管理人名称:</span>  <input class="easyui-combobox" name="managerName"
						id="managerName"
						data-options="
				                      valueField: 'id',
									  textField: 'magr_name',
									  mode:'local',
									  url:'<%=cp%>/xinxipiluQuant/getAllQuantMangerOptions?date_Type=month',  
			                          method:'get',
									  multiple:false,
									  width:230,
									  onLoadSuccess: function(data){
									  $('#managerName').combobox('setValue',data[0].value); 
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 "> 
					<span>生成状态:</span>  <input class="easyui-combobox" style="width:230px;" name="isPrinted"
						id="isPrinted" value="" 
						data-options=  "valueField: 'label',
										textField: 'value',
										data: [{
											label: '0',
											value: '未生成报告'
										},{
											label: '1',
											value: '已生成'
										},{
											label: '2',
											value: '财务指标有错误'
										},{
											label: '3',
											value: '强制生成'
										},{
											label: '',
											value: '全选'
										}]" /> 											 
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchQuantData(reportType)">查询</a>
						<span>&nbsp&nbsp&nbsp&nbsp&nbsp</span> 								
<!-- 					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-redo'" onclick="recollection()">重新采集</a>		 -->	
									
<!-- 					<a href="javascript:void(0);" class="easyui-linkbutton" -->
<!-- 						data-options="iconCls:'icon-arrow_down'" onclick="exportFiles()">重新导出</a> -->
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-arrow_down'" onclick="generateAndPushToJBK(reportType,'0','<%=cp%>',heduiTable,dateNO)">生成报告</a><span>&nbsp&nbsp</span> 	
				</div>
				<div style="margin-top: 10px;">
					<table id="managerTable"
						data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<th data-options="field:'ck',	checkbox:true"></th>
 								<th field="magr_no" 			width="80" sortable="true" >	管理人编号</th>
								<th field="magr_stat" 			width="65" sortable="true" >	管理人状态</th>
								<th field="fake_magr_name" 			width="110" sortable="true" >	管理人名称</th>
								<th field="bill_flag" 			width="70" align="center">		清单标志</th>
 								<th field="date_no"	width="65" 	formatter = "turnRed" sortable="true" >日期编号</th>
<!-- 								<th field="print_stat" 			width="50" sortable="true">		打印状态</th>				 -->
 								<th field="data_chk_rslt_code"	width="65" formatter = "turnRed" sortable="true" align="center">核对结果</th>
								<th field="gbicc_chk_rslt_code" width="100" align="center">		报告状态</th>		
								<th field="wb_data_stat_code" 	width="80">						外包数据状态</th>
								<th field="memo" formatter = "addMessageBox"	width="500" sortable="true" align="center">	备注</th>
								<th field="magr_name" hidden="true" >magr_name</th>			
								<th field="fund_code" hidden="true" >fund_code</th>																		
							</tr>
						</thead>
					</table>
				</div>
			</div>
			</div>
		<div title="明细" style="padding: 5px">
			<div title="月报明细" style="padding: 5px">
				<span>月份:</span>  <input class="easyui-combobox" name="smoMonthNOMingXi"
							id="smoMonthNOMingXi"
							data-options="
					                      valueField: 'id',
										  textField: 'value',
										  mode:'local',
										  url:'<%=cp%>/xinxipilu/getDateOptions?date_Type=month',  
				                          method:'get',
										  multiple:false,
										  width:150,
										  onLoadSuccess: function(data){
										  $('smoMonthNOMingXi').combobox('setValue',data[0].value);
										  },
										  filter: function(q, row){
													var opts = $(this).combobox('options');
													return row[opts.textField].indexOf(q) >-1;
												}
									">
				<span>基金名称:</span>  <input class="easyui-combobox" name="fundNameMingxi"
						id="fundNameMingxi"
						data-options="
				                      valueField: 'id',
									  textField: 'value',
									  mode:'local',
									  url:'<%=cp%>/xinxipilu/getFundNameOptions?date_Type=month',  
			                          method:'get',
									  multiple:false,
									  width:230,
									  onLoadSuccess: function(data){
									   $('fundNameMingxi').combobox('setValue',data[0].value); 
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 "> 									
				<span>管理人名称:</span>  <input class="easyui-combobox" name="managerNameMingXi"
						id="managerNameMingXi"
						data-options="
				                      valueField: 'id',
									  textField: 'magr_name',
									  mode:'local',
									  url:'<%=cp%>/xinxipiluQuant/getAllQuantMangerOptions?date_Type=month',  
			                          method:'get',
									  multiple:false,
									  width:230,
									  onLoadSuccess: function(data){
									  $('#managerNameMingXi').combobox('setValue',data[0].value); 
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 "> 									
				<span>&nbsp</span>			
				<input name="heDuiYiZhi" id="heDuiYiZhi"  type="checkbox" /> 显示核对一致	
				<span>&nbsp&nbsp&nbsp</span>								
				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchManagerMingXi(reportType,'<%=cp%>', mingXiTable, dateNOMingXi)">查询</a> 
				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" onclick="modifyOrConfrim(reportType,'<%=cp%>','3',mingXiTable)">保存修改</a> 
				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" onclick="modifyOrConfrim(reportType,'<%=cp%>','4',mingXiTable)">指标确认</a> 	
				<div title="明细列表" style="margin-top: 10px;">
					<table id="mingXiTable"
						data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<!-- <th data-options="field:'ck',checkbox:true"></th> -->
								<th data-options="field:'ck',checkbox:true"></th>
<!-- 								<th field="disc_type_code" 	width="60">服务类型</th>
 -->								<th field="date_no" 		width="60">日期编号</th>
								<th field="fund_name" 		width="160" align="center">基金名称</th>
								<th field="rept_date" 		width="80">报告日期</th>
								<th field="indx_name" 		width="300" >指标名称</th>
								<th field="indx_dim" 		width="60">指标维度</th>
								<th field="wb_data" 		width="150">外包数据</th>
								<th field="tg_data" 		width="150">托管数据</th>
								<th field="chk_rslt_code" 	width="80" formatter = "turnRed">核对结果</th>
								<th field="upd_aft_data" 		width="150" editor="text">修改数据</th>
								<th field="upder_ip" 		width="60" " >修改人IP</th>
								<th field="magr_no" hidden="true" >magr_no</th>						
								
							</tr>
						</thead>
					</table>
				</div>			
			</div>
		</div>
	</div>


</body>