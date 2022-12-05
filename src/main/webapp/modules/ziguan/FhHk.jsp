<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>分红清算</title>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>
$(function (){
    //初始化table
    $("#fh").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-140
	 });
	 $("#sh").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-140
	 });
	 $("#sg").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-140
	 });
	 $("#th").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-140
	 });
	 $("#hk").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-140
	 });
});
</script>
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
function searchdata(type){
	var date;
	var funcode;
	var params;
	if(type == 'fh'){
		date = $('#fhdate').combobox('getValue');
		funcode = $('#fh_code').combobox('getValue');
	    params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择查询时间!");
			return;
		}
	    $('#fh').datagrid({method:'get', url:"<%=cp%>/fhhk/getsearchdata?"+params, }).datagrid('clientPaging'); 
	}else if(type == 'sh'){
		date = $('#shdate').combobox('getValue');
		funcode = $('#sh_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择查询时间!");
			return;
		}
		 $('#sh').datagrid({method:'get', url:"<%=cp%>/fhhk/getsearchdata?"+params, }).datagrid('clientPaging'); 
	}else if(type == 'sg'){
		date = $('#sgdate').combobox('getValue');
		funcode = $('#sg_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择查询时间!");
			return;
		}
		 $('#sg').datagrid({method:'get', url:"<%=cp%>/fhhk/getsearchdata?"+params, }).datagrid('clientPaging'); 
	}else if(type == 'th'){
		date = $('#thdate').combobox('getValue');
		funcode = $('#th_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择查询时间!");
			return;
		}
		 $('#th').datagrid({method:'get', url:"<%=cp%>/fhhk/getsearchdata?"+params, }).datagrid('clientPaging'); 
	}else if(type == 'hk'){
		date = $('#hkdate').combobox('getValue');
		funcode = $('#hk_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择查询时间!");
			return;
		}
		 $('#hk').datagrid({method:'get', url:"<%=cp%>/fhhk/getsearchdata?"+params, }).datagrid('clientPaging'); 
	}
	
}
function exportdata(type){
	var date;
	var funcode;
	var params;
	if(type == 'fh'){
		date = $('#fhdate').combobox('getValue');
		funcode = $('#fh_code').combobox('getValue');
	    params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#fh').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		codes = codes.unique();
		if(codes.length != 1){
			alert("请选择一个产品!");
			return;
		}
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
	    window.location.href='<%=cp%>/fhhk/exportdata?'+params
	}else if(type == 'sh'){
		date = $('#shdate').combobox('getValue');
		funcode = $('#sh_code').combobox('getValue');
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#sh').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		codes = codes.unique();
		if(codes.length != 1){
			alert("请选择一个产品!");
			return;
		}
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportdata?'+params
	}else if(type == 'sg'){
		date = $('#sgdate').combobox('getValue');
		funcode = $('#sg_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#sg').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		codes = codes.unique();
		if(codes.length != 1){
			alert("请选择一个产品!");
			return;
		}
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportdata?'+params
	}else if(type == 'th'){
		date = $('#thdate').combobox('getValue');
		funcode = $('#th_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#th').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportdata?'+params
	}else if(type == 'hk'){
		date = $('#hkdate').combobox('getValue');
		funcode = $('#hk_code').combobox('getValue');
		params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#hk').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		codes = codes.unique();
		if(codes.length != 1){
			alert("请选择一个产品!");
			return;
		}
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportdata?'+params
	}
}
function exportdata_input(type){
	var date;
	var funcode;
	var params;
	if(type == 'fh'){
		date = $('#fhdate').combobox('getValue');
		funcode = $('#fh_code').combobox('getValue');
	    params = "date="+date+"&type="+type+"&funcode="+funcode;
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#fh').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
	    window.location.href='<%=cp%>/fhhk/exportinputexcel?'+params
	}else if(type == 'sh'){
		date = $('#shdate').combobox('getValue');
		funcode = $('#sh_code').combobox('getValue');
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#sh').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportinputexcel?'+params
	}else if(type == 'sg'){
		date = $('#sgdate').combobox('getValue');
		funcode = $('#sg_code').combobox('getValue');
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#sg').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportinputexcel?'+params
	}else if(type == 'hk'){
		date = $('#hkdate').combobox('getValue');
		funcode = $('#hk_code').combobox('getValue');
		if(date==""){
			alert("请选择导出日期!");
			return;
		}
		var checkItems = $('#hk').datagrid('getChecked');
		var codes = [];
		$.each(checkItems,function(index,item){
			codes.push(item.c_fundcode);
		});
		params = "date="+date+"&type="+type+"&funcode="+funcode+"&code="+codes;
		window.location.href='<%=cp%>/fhhk/exportinputexcel?'+params
	}
}
</script>
<body> 
	<div id="tabsidk"  class="easyui-tabs">
		<div title="分红" style="padding: 5px">
				  <div style="margin-top: 5px; margin-bottom: 5px;">
						<span>选择产品:</span>
						 <input class="easyui-combobox" name="fh_code" id="fh_code"
								data-options="
					                      valueField: 'value',
										  textField: 'text',
										  mode:'local',
										  url:'<%=cp%>/fhhk/getproductcode',
				                          method:'post',
										  multiple:false,
										  width:250,
										  filter: function(q, row){
													var opts = $(this).combobox('options');
													return row[opts.textField].indexOf(q) >-1;
												},
								         onLoadSuccess:function(){
											 $('#fh_code').next('.combo').find('input').focus(function (){
											            $('#fh_code').combobox('clear');
											 });
					     }  "/>&nbsp;&nbsp;
					    <span>日期:</span>
					    <input id="fhdate" name="fhdate" class="easyui-datebox"  style="width: 120px"></input>&nbsp;&nbsp;
					    <span style="color: red;">*</span>	&nbsp;&nbsp;
					    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata('fh')">查询</a>&nbsp;&nbsp;
					    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata('fh')">导出</a> &nbsp;&nbsp;
					    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata_input('fh')">指令模板导出</a> &nbsp;&nbsp;
		          </div>
			      <div style="margin-top: 10px;">
			         <table  id="fh" 
								data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true"></th>
										<th field="c_fundcode" width="100" >产品编码</th>
										<th field="c_fundname" width="150">产品名称</th>
										<th field="c_agencyno" width="90" >交易渠道</th>
										<th field="d_date" width="100">分配日期</th>
										<th field="f_totalshare" width="100">分红基数份额</th>
										<th field="f_unitprofit" width="100">每单位分红</th>
										<!-- <th field="f_totalprofit" width="100">总分红金额</th> -->
										<th field="c_flag" width="100">分红类型</th>
										<th field="f_realbalance" width="100">实发现金红利</th>
										<th field="c_custname" width="150">客户名称</th>
										<th field="c_identityno" width="100">证件号码</th>
										<th field="c_nameinbank" width="150">账户名称</th>
										<th field="c_bankname" width="150">开户行</th>
										<th field="c_bankacco" width="150">银行卡号</th>
									</tr>
								</thead>
					 </table>
				 </div>
		</div>
		
		<div title="赎回" style="padding: 5px">
			   <div style="margin-top: 5px; margin-bottom: 5px;">
					 <span>选择产品:</span>
					 <input class="easyui-combobox" name="sh_code" id="sh_code"
									data-options="
						                      valueField: 'value',
											  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/fhhk/getproductcode',
					                          method:'post',
											  multiple:false,
											  width:250,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													},
									         onLoadSuccess:function(){
												 $('#sh_code').next('.combo').find('input').focus(function (){
												            $('#sh_code').combobox('clear');
												 });
										     }  "/>
					  <span>日期</span>&nbsp;&nbsp;
				      <input id="shdate" name="shdate" class="easyui-datebox"  style="width: 120px"></input>
					  <span style="color: red;">*</span>	&nbsp;&nbsp;
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata('sh')">查询</a>&nbsp;&nbsp;
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata('sh')">导出</a> &nbsp;&nbsp;
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata_input('sh')">指令模板导出</a> &nbsp;&nbsp;
				</div>
				
			   <div style="margin-top: 10px;">
			         <table  id="sh"  
								data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true"></th>
										<th field="c_fundcode" width="100" >产品编码</th>
										<th field="c_fundname" width="150" >产品名称</th>
										<th field="c_agencyno" width="90" >交易渠道</th>
										<th field="d_cdate" width="100" >赎回日期</th>
										<th field="f_netvalue" width="120" >赎回单位净值</th>
										<th field="f_confirmshares" width="120" >赎回确认份额</th>
										<th field="f_confirmbalance" width="120" >赎回确认金额</th>
									    <th field="f_tradefare" width="100" >赎回总费用</th>
									    <th field="c_custname" width="150" >客户名称</th>
									    <th field="c_identityno" width="150" >证件编号</th>
									    <th field="c_nameinbank" width="150" >账户名称</th>
									    <th field="c_bankname" width="150" >开户行</th>
									    <th field="c_bankacco" width="150" >银行卡号</th>
									</tr>
								</thead>
					 </table>
				</div>
					
		</div>
		
		<div title="申购" style="padding: 5px">
			
			  <div style="margin-top: 5px; margin-bottom: 5px;">
				 <span>选择产品:</span>
				 <input class="easyui-combobox" name="sg_code" id="sg_code"
								data-options="
					                      valueField: 'value',
										  textField: 'text',
										  mode:'local',
										  url:'<%=cp%>/fhhk/getproductcode',
				                          method:'post',
										  multiple:false,
										  width:250,
										  filter: function(q, row){
													var opts = $(this).combobox('options');
													return row[opts.textField].indexOf(q) >-1;
												},
								         onLoadSuccess:function(){
											 $('#sg_code').next('.combo').find('input').focus(function (){
											            $('#sg_code').combobox('clear');
											 });
									     }  " />&nbsp;&nbsp;
				  <span>日期</span>
			      <input id="sgdate" name="sgdate" class="easyui-datebox"  style="width: 120px"></input>
				  <span style="color: red;">*</span>	&nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata('sg')">查询</a>&nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata('sg')">导出</a> &nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata_input('sg')">指令模板导出</a> &nbsp;&nbsp;
				</div>
				
				<div style="margin-top: 10px;">
			         <table  id="sg"  
								data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true"></th>
										<th field="c_fundcode" width="100" >产品编码</th>
										<th field="c_fundname" width="150" >产品名称</th>
										<th field="c_agencyno" width="90" >交易渠道</th>
										<th field="d_cdate" width="100" >申购日期</th>
										<th field="f_netvalue" width="120" >申购单位净值</th>
										<th field="f_confirmshares" width="120" >申购确认份额</th>
										<th field="f_confirmbalance" width="120" >申购确认金额</th>
									    <th field="f_tradefare" width="100" >申购总费用</th>
									    <th field="c_custname" width="150" >客户名称</th>
									    <th field="c_identityno" width="150" >证件编号</th>
									    <th field="c_nameinbank" width="150" >账户名称</th>
									    <th field="c_bankname" width="150" >开户行</th>
									    <th field="c_bankacco" width="150" >银行卡号</th>
									</tr>
								</thead>
					 </table>
				</div>
		 </div>
		
		<div title="退回" style="padding: 5px">
			
			  <div style="margin-top: 5px; margin-bottom: 5px;">
				 <span>选择产品:</span>
				 <input class="easyui-combobox" name="th_code" id="th_code"
								data-options="
					                      valueField: 'value',
										  textField: 'text',
										  mode:'local',
										  url:'<%=cp%>/fhhk/getproductcode',
				                          method:'post',
										  multiple:false,
										  width:250,
										  filter: function(q, row){
													var opts = $(this).combobox('options');
													return row[opts.textField].indexOf(q) >-1;
												},
								         onLoadSuccess:function(){
											 $('#th_code').next('.combo').find('input').focus(function (){
											            $('#th_code').combobox('clear');
											 });
									     }  " />&nbsp;&nbsp;
				  <span>日期</span>
			      <input id="thdate" name="thdate" class="easyui-datebox"  style="width: 120px"></input>
				 <span style="color: red;">*</span>	&nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata('th')">查询</a>&nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata('th')">导出</a> &nbsp;&nbsp;
				</div>
				
			  <div style="margin-top: 10px;">
			         <table  id="th"  
								data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true"></th>
										<th field="c_fundcode" width="100" >产品编码</th>
										<th field="c_fundname" width="150" >产品名称</th>
										<th field="c_agencyno" width="90" >交易渠道</th>
										<th field="d_cdate" width="100" >退回日期</th>
										<th field="f_netvalue" width="120" >退回单位净值</th>
										<th field="f_confirmshares" width="120" >退回确认份额</th>
										<th field="f_confirmbalance" width="120" >退回确认金额</th>
									    <th field="f_totalfare" width="100" >退回总费用</th>
									    <th field="c_custname" width="150" >客户名称</th>
									    <th field="c_identityno" width="150" >证件编号</th>
									    <th field="c_nameinbank" width="150" >账户名称</th>
									    <th field="c_bankname" width="150" >开户行</th>
									    <th field="c_bankacco" width="150" >银行卡号</th>
									</tr>
								</thead>
					 </table>
				</div>
		 </div>
		 <div title="赎回分红" style="padding: 5px">
			
			  <div style="margin-top: 5px; margin-bottom: 5px;">
				 <span>选择产品:</span>
				 <input class="easyui-combobox" name="hk_code" id="hk_code"
								data-options="
					                      valueField: 'value',
										  textField: 'text',
										  mode:'local',
										  url:'<%=cp%>/fhhk/getproductcode',
				                          method:'post',
										  multiple:false,
										  width:250,
										  filter: function(q, row){
													var opts = $(this).combobox('options');
													return row[opts.textField].indexOf(q) >-1;
												},
								         onLoadSuccess:function(){
											 $('#hk_code').next('.combo').find('input').focus(function (){
											            $('#hk_code').combobox('clear');
											 });
									     }  " />&nbsp;&nbsp;
				  <span>日期</span>
			      <input id="hkdate" name="hkdate" class="easyui-datebox"  style="width: 120px"></input>
				 <span style="color: red;">*</span>	&nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata('hk')">查询</a>&nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata('hk')">导出</a> &nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="exportdata_input('hk')">指令模板导出</a> &nbsp;&nbsp; 
				</div>
				
			  <div style="margin-top: 10px;">
			         <table  id="hk"  
								data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true"></th>
										<th field="c_fundcode" width="80" >产品编码</th>
										<th field="c_fundname" width="150" >产品名称</th>
										<th field="c_agencyno" width="80" >交易渠道</th>
										<th field="date" width="80" >确认日期</th>
										<th field="f_confirmbalance" width="120" >赎回确认金额</th>
									    <th field="f_realbalance" width="100" >实发现金红利</th>
									    <th field="f_total" width="120" >赎回分红合计金额</th>
									    <th field="c_custname" width="150" >客户名称</th>
									   <!--  <th field="c_identityno" width="150" >证件编号</th> -->
									    <th field="c_nameinbank" width="150" >账户名称</th>
									    <th field="c_bankname" width="150" >开户行</th>
									    <th field="c_bankacco" width="150" >银行卡号</th>
									</tr>
								</thead>
					 </table>
				</div>
		 </div>

	</div>
 </body>
</html>





