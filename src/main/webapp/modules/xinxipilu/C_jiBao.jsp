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
var heduiTable="#jibaoheduiTable";
var mingxiTable="#jibaomingXiTable";
var dateNO = "#quaterNO";
var reportType = "quater";
var info = 'qinfo';
var mingxi = 'qMingXi';
	$(function (){
		 //初始化核对table
		 $("#jibaoheduiTable").datagrid({
			 striped: 'true',
		 	 width 	: '100%',
	    	 height : document.documentElement.clientHeight-80
		 });
		 $('#jibaoheduiTable').datagrid('hideColumn','fund_code');
		 //初始化明细table
		 $("#jibaomingXiTable").datagrid({
			 striped: 'true', 
		 	 width 	: '100%',
	    	 height : document.documentElement.clientHeight-80
		 });
		$('#jibaomingXiTable').datagrid('enableCellEditing').datagrid('gotoCell', {
			index: 0,
			field: 'disc_type_code'
		});
	});
</script>

<!-- 自定义js -->
<script type="text/javascript">
function search1FundDataChkRslt(dateNO,fundCode,fundName){
	$("#tabsidk").tabs('select', "明细");
	var params="reportType=Q&dateNO="+dateNO+"&fundCode="+fundCode+"&heDuiYiZhi=0";;
	 $('#jibaomingXiTable').datagrid({method:'post',url:"<%=cp%>/xinxipilu/search1FundDataChkRslt?"+params}).datagrid('clientPaging'); 
	 $('#quaterNOMingXi').combobox('setValue',dateNO);
	 $('#fundNameMingxi').combobox('setValue',fundName);
	 //var params="gth="+gth+"&biz_dt="+$("#d_ywrq").datebox('getValue');

}


/**
 * 导出3份文件
 */
function exportFiles(){
	var rows = $('# ').datagrid('getChecked');//.datagrid('getSelected');row
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}else{
		$.post(
		       	"<%=cp%>/xinxipilu/generate3Files?reportType=quater&isRecollect=1",
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
		$('#jibaoheduiTable').datagrid('reload'); 
	}
}

<%-- 
/**
 * 重新采集数据，导入外包和tu信息
 */
function recollection(){
	var rows = $('#jibaoheduiTable').datagrid('getChecked');//.datagrid('getSelected');row
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}else{
		$.post(
		       	"<%=cp%>/xinxipilu/recollection?reportType=quater",
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
		$('#jibaoheduiTable').datagrid('reload'); 
	}
}

 --%>
//测试
function testFunction(hehe  ){
	console.log('hehe');
	$.post(
	       	"<%=cp%>/xinxipilu/test?reportType=quater",
	        //{"data":JSON.stringify(rows)},　　　　　　　　　　　//
	        function(data) { 
/* 	        	if(data) {
	        		//console.log("data is "+data);
	        		if (data.indexOf("success")>=0) {
	        			alert("提交成功，请稍后在共享盘中查看文件");
	        		} else{
	        			alert(data.replace('fail=',''));
	        			return;
	        		}
	        	} else {
	        		alert("未能成功提交导出请求，请联系系统人员");
	        	} */
	}); 
	//$('#jibaoheduiTable').datagrid('reload'); 
}

</script>
<body>
	<div id="tabsidk" class="easyui-tabs" >
		<div title="核对" style="padding: 5px">
			<div title="季报核对主页" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;">
					<span>季度:</span>  <input class="easyui-combobox" name="quaterNO"
						id="quaterNO"
						data-options="
				                      valueField: 'id',
									  textField: 'value',
									  mode:'local',
									  url:'<%=cp%>/xinxipilujibao/getDateOptions?date_Type=quater',  
			                          method:'get',
									  multiple:false,
									  width:150,
									  onLoadSuccess: function(data){
									  $('#quaterNO').combobox('setValue',data[0].value);
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 "> <span>&nbsp&nbsp</span> 
						<span>估值人员:</span>  <input class="easyui-combobox" name="guzhirenyuan"
						id="guzhirenyuan"
 						data-options="
				                      valueField: 'id',
									  textField: 'value',
									  mode:'local',
									  url:'<%=cp%>/xinxipilu/getGuzhiRenYuanOptions?reportType=Q',  
			                          method:'get',
									  multiple:true,
									  width:150,
									  onLoadSuccess: function(data){
									  <!-- $('#guzhirenyuan').combobox('setValue',data[0].value); -->
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 ">  <span>&nbsp&nbsp</span> 				 
					<span>基金名称:</span>  <input class="easyui-combobox" name="fundName"
						id="fundName"
						data-options="
				                      valueField: 'id',
									  textField: 'value',
									  mode:'local',
									  url:'<%=cp%>/xinxipilu/getFundNameOptions?date_Type=quater',  
			                          method:'get',
									  multiple:false,
									  width:230,
									  onLoadSuccess: function(data){
									  <!-- $('#fundName').combobox('setValue',data[0].value); -->
									  },
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 "> <span>&nbsp&nbsp</span> 
<!-- 					<span  >清单:</span>  <input class="easyui-combobox" style="width:90px;" name="thelist"
						id="thelist" value="全选" 
						data-options=  "valueField: 'label',
										textField: 'value',
										data: [{
											label: '1',
											value: '清单内'
										},{
											label: '0',
											value: '清单外'
										},{
											label: '2',
											value: '人工新增'
										},{
											label: '',
											value: '全选'
										}]" /> <span>&nbsp&nbsp</span> 	 -->			
					<span  >服务范围:</span>  <input class="easyui-combobox" style="width:90px;" name="serv_scop"
						id="serv_scop" value="全选" 
						data-options=  "valueField: 'label',
										textField: 'value',
										data: [{
											label: '托管外包',
											value: '托管外包'
										},{
											label: '外包',
											value: '外包'
										},{
											label: '综合服务',
											value: '综合服务'
										},{
											label: '',
											value: '全选'
										}]" /> 	<span>&nbsp&nbsp&nbsp&nbsp&nbsp</span>										 
 				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-redo'" onclick="recollection(heduiTable,'<%=cp%>','Q',dateNO)">重新采集</a> 											 
						<!--进度条，写着玩的: <div id="p" class="easyui-progressbar" data-options="value:60" style="width:400px;"></div> -->
				</div>
				<div style="margin-top: 5px; margin-bottom: 5px;"> 	
				<span>投监核对:</span> <input class="easyui-combobox" style="width:125px;" name="ivsp_chk_rslt_code"
										id="ivsp_chk_rslt_code" value="" 
						data-options=  "
										 multiple:true,										
										valueField: 'label',
										textField: 'value',
										data: [{
											label: '0',
											value: '未核对'
										},{
											label: '1',
											value: '核对一致'
										},{
											label: '2',
											value: '核对不一致'
										},{
											label: '9',
											value: '不需要核对'
										}]" /> 			<span>&nbsp&nbsp</span>  
					<span>核对结果:</span>  <input class="easyui-combobox" style="width:150px;" name="data_chk_rslt_code"
						id="data_chk_rslt_code" value="" 
						data-options=  "
										 multiple:true,						
										valueField: 'label',
										textField: 'value',
										data: [{
											label: '0',
											value: '未核对'
										},{
											label: '1',
											value: '核对一致'
										},{
											label: '2',
											value: '核对不一致'
										},{
											label: '3',
											value: '有修改不一致'
										},{
											label: '4',
											value: '人工确认一致'
										},{
											label: '5',
											value: '人工确认不一致'
										},{
											label: '9',
											value: '不需要核对'
										},{
											label: 'A',
											value: '不需要核对有修改'
										}]" /> 			<span>&nbsp&nbsp</span> 
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
										}]" /> 		<span>&nbsp&nbsp&nbsp&nbsp&nbsp</span> 
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata(info,'<%=cp%>')">查询</a><span>&nbsp&nbsp&nbsp&nbsp</span> 
<!-- 					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-redo'" onclick="recollection()">重新采集</a>	 -->					
<!-- 					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-arrow_down'" onclick="exportFiles()">重新导出</a><span>&nbsp&nbsp</span> 	 -->
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-arrow_down'" onclick="generateAndPushToJBK('q','0','<%=cp%>','#jibaoheduiTable',dateNO)">生成报告</a><span>&nbsp&nbsp</span> 	
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-arrow_down'" onclick="generateAndPushToJBK('q','1','<%=cp%>','#jibaoheduiTable',dateNO)">强制生成</a><span>&nbsp&nbsp</span> 										
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-arrow_down'" onclick="exportDiscSitu('q','<%=cp%>',dateNO)">导出当前列表</a><span>&nbsp&nbsp</span> 										
	
				</div>
				<div style="margin-top: 10px;">
                    <table 	id="jibaoheduiTable"						
                    		data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<th data-options="field:'ck',	checkbox:true"></th>
<!-- 							<th field="date_no" 			width="80" sortable="true" >	日期编号</th>
 -->							
 								<th field="serv_scop" 			width="65" sortable="true" >	服务范围</th>
								<th field="fund_num" 			width="80" sortable="true"  editor="text">	基金协会编号</th>
 								<th field="fund_code" 			width="100">					基金编号（综合管理平台）</th><!-- hided -->
								<th field="fund_name" 			width="150" align="center">		基金名称</th>
								<th field="ivsp_chk_rslt_code"	width="65" sortable="true" align="center">投监核对</th>								
 								<th field="data_chk_rslt_code"	width="65" formatter = "turnRed" sortable="true" align="center">核对结果</th>
								<th field="gbicc_chk_rslt_code" width="100" align="center">		报告状态</th>
								<th field="rept_date" 			width="74" sortable = "true" >	报告日期</th>
								<th field="wb_c_pord_code" 		width="68" align="center">		外包账套号</th>
								<th field="tg_c_pord_code" 		width="68" align="center">		托管账套号</th>
<!-- 								<th field="bill_flag" 			width="45" sortable="true">		清单</th>
								<th field="wb_data_stat_code" 	width="80" align="center">		外包数据</th>
								<th field="tg_data_stat_code" 	width="80" align="center">		托管数据</th> -->
<!-- 								<th field="excel_rept_stat" 	width="70" align="center">		Excel报告</th>
								<th field="word_rept_stat" 		width="70" align="center">		Word报告</th>
								<th field="pdf_rept_stat" 		width="70" align="center">		PDF报告</th> -->
								<th field="wb_valu_prsn_name" 	width="80" align="center">		外包估值人员名称</th>
								<th field="tg_valu_prsn_name" 	width="80" align="center">		托管估值人员名称</th>								
								<th field="proj_mngr_name" 		width="80" align="center">		项目经理名称</th>
<!-- 								<th field="magr_ex_stat" 		width="80" align="center">		管理人异常状态</th>
								<th field="fund_setp_date" 		width="80" sortable="true">		基金成立日期</th>
								<th field="fund_matu_date" 		width="80" sortable="true">		基金到期日期</th> -->
<!-- 								<th field="fund_stat" 			width="55" sortable="true">		基金状态</th>
 -->								<!-- <th field="fund_type" 			width="80" sortable="true" align="center">基金类型</th> -->
								<th field="is_cifd" 			width="30" sortable="true">		分级</th>				
								<th field="memo" formatter = "addMessageBox"	width="500" sortable="true" align="center">	备注</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			</div>
		<div title="明细" style="padding: 5px">
			<div title="季报明细" style="padding: 5px">
				<span>季度:</span>  <input class="easyui-combobox" name="quaterNOMingXi"
							id="quaterNOMingXi"
							data-options="
					                      valueField: 'id',
										  textField: 'value',
										  mode:'local',
										  url:'<%=cp%>/xinxipilu/getDateOptions?date_Type=quater',  
				                          method:'get',
										  multiple:false,
										  width:150,
										  onLoadSuccess: function(data){
										  $('monthNOMingXi').combobox('setValue',data[0].value);
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
									  url:'<%=cp%>/xinxipilu/getFundNameOptions?date_Type=quater',  
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
				<span>&nbsp</span>					
				<input name="heDuiYiZhi" id="heDuiYiZhi"  type="checkbox" checked/> 显示核对一致	
				<span>&nbsp&nbsp&nbsp</span>								
				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata('qMingXi','<%=cp%>')">查询</a> 
				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" onclick="modifyOrConfrim('Q','<%=cp%>','3','#jibaomingXiTable')">保存修改</a> 
				<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" onclick="modifyOrConfrim('Q','<%=cp%>','4','#jibaomingXiTable')">指标确认</a> 		
				<div title="明细列表" style="margin-top: 10px;">
					<table id="jibaomingXiTable"
						data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<!-- <th data-options="field:'ck',checkbox:true"></th> -->
								<th data-options="field:'ck',checkbox:true"></th>
								<!-- <th field="disc_type_code" 	width="60">服务类型</th> -->
								<th field="date_no" 		width="60">日期编号</th>
								<th field="fund_name" 		width="160" align="center">基金名称</th>
								<th field="rept_date" 		width="80">报告日期</th>
								<th field="indx_name" 		width="300">指标名称</th>
								<th field="indx_dim" 		width="60">指标维度</th>
								<th field="wb_data" 		width="150">外包数据</th>
								<th field="tg_data" 		width="150">托管数据</th>
								<th field="chk_rslt_code" 	width="80" formatter = "turnRed">核对结果</th>
								<th field="upd_aft_data" 		width="150" editor="text">修改数据</th>
								<th field="upder_ip" 		width="60" >修改人IP</th>
								
								
							</tr>
						</thead>
					</table>
				</div>			
			</div>
		</div>
	</div>
		<div id="dlg" class="easyui-dialog" closed="true" title="添加估值人员信息"
			style="width: 550px; height: 300px; padding: 10px;"
			data-options="
				iconCls: 'icon-save',
				buttons: '#dlg-buttons'
			">
			<span style="margin-left: 20px">用户ID:</span> <span> <input
				type="text" class="easyui-textbox" id="user_id" name="user_id" />
			</span> <span style="margin-left: 20px">用户名称:</span> <span> <input
				type="text" class="easyui-textbox" id="username1" name="username1"></span>
			<br />
			<br /> <span style="margin-left: 22px">用户IP:</span> <span> <input
				type="text" class="easyui-textbox" id="IP" name="IP" />
			</span> <span style="margin-left: 20px">手机号码:</span> <span> <input
				type="text" class="easyui-textbox" id="phone" name="phone"></span>
			<br />
			<br /> <span style="margin-left: 18px">&nbsp;邮箱:</span> <span>
				<input type="text" class="easyui-textbox" id="email" name="email" />
			</span> <span style="margin-left: 20px">用户类型:</span> <span> <select
				id="groupType1" class="easyui-combobox" name="groupType1"
				style="width: 100px;">
					<option value="0">--请选择--</option>
					<option value="1">托管</option>
					<option value="2">外包</option>
			</select>
			</span>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addGuzhiUserInfo()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" onclick="closeDialog()">取消</a>
		</div>
</body>