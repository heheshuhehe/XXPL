<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>柜台余额查询</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});

	 $("#wbdg").datagrid({
	 	 width : '98%' 
	 });
});


function createwbdata(){
	var ztmc=$("#wbzth").combobox('getText')
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&valdate="+$("#valdate").combobox('getValue')+"&ztmc="+ztmc+"&jzdate="+$("#jzdate").combobox('getValue')+"&status="+$("#status").combobox('getValue');
	 
	params=params+"&valdate2="+$("#valdate2").combobox('getValue');
	$('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/automailquerylog?'+params}).datagrid('clientPaging');
	
	
} 

function calculate(){
 	
	var date=$("#jzdate").combobox('getValue');
	
	$.ajax({
		url:'<%=cp%>/guzhidz/automailcalculate',
		type:'post',
		data:{date:date},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("计算完成");
				closeDialog();
			}else{
				alert("发送失败");
			}
			
		}
	});
} 
function sendmail(){

	var date=$("#wbdate").combobox('getValue');
	$.ajax({
		url:'<%=cp%>/guzhidz/automailsendmail',
		type:'post',
		data:{date:date},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("发送成功");
				closeDialog();
			}else{
				alert("发送失败");
			}
			
		}
	});
} 

function adddata(){
	var ssinfo="";

		var rows = $('#wbdg').datagrid('getSelections');
		if(rows.length==0){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}
		var ssinfo="";
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ssinfo=ssinfo+row.ider+',';
		}
		if(confirm("即将对选中数据对应的估值表进行重新发送，确认继续吗？")){
			$.ajax({
				url:'<%=cp%>/guzhidz/automailsendmailadd',
				type : 'post',
				data : {ssinfo : ssinfo},
				dataType : "json",
				success : function(data) {
					if(data[0].msg=="success"){  
						alert("重置成功");

					}else{
						alert("重置失败");
					}
				}
			});
		}
	
}
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#wbdate").datebox("setValue", myformatter(curr_time));

			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-120
			 });
	});
</script>

<script type="text/javascript">
	function myformatter1(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + '-' + (m < 10 ? ('0' + m) : m) + '-'
				+ (d < 10 ? ('0' + d) : d);
	}
	function myparser(s) {
		if (!s)
			return new Date();
		var ss = (s.split('-'));
		var y = parseInt(ss[0], 10);
		var m = parseInt(ss[1], 10);
		var d = parseInt(ss[2], 10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
			return new Date(y, m - 1, d);
		} else {
			return new Date();
		}
	}
	
	function format (number) {
		var num;
		try{
			num=Number(number);
			
		}
		catch (e) {
			return number;
		}
	if(isNaN(num))
		return num;
	    return (num.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'); 

	} 

	 
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="柜台余额查询" style="padding: 10px">
	<div id="p" class="easyui-panel" title="数据字典" style="width:95%;height:150px;padding:10px;"
				data-options="iconCls:'icon-search',collapsible:true,collapsed:true">
			
			【披露频率:01-每个交易日披露最新估值日;02-每周披露上周最后一交易日;03-每月初披露上月末最后一自然日;04-每月初披露上月末最后一交易日;05-每周一次性披露上周每个交易日】<br>
		【净值表要素:01-产品名称;02-净值日期;03-单位净值;04-累计单位净值;05-资产净值;06-资产份额;07-备案编码;08-资产总值;09-虚拟单位净值;10-虚拟累计单位净值】<br>
		【估值表要素:01-科目代码;02-科目名称;03-数量;04-单位成本;05-成本;06-成本占净值;07-市价;08-市值;09-市值占净值;10-估值增值;11-停牌信息;】<br>
		【数据格式:01-EXCEL;02-PDF加盖托管业务章;03-PDF加盖运营服务章;】<br>【估值表科目级别:01-一级;02-二级;03-三级;04-最末级】<br>
		【披露类型:01-净值;02-估值;03-虚拟净值表】<br>
		</div>
		<table>
				<tr>
				<td>
				
					<span>基准计算日期</span>
				     <input id="jzdate" name="jzdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input></td><td>
				
				
				<span>发送日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
						
					
						
					 <span style="color: red;">*</span>
					 </td><td>
					 <span>估值表日期(起)</span>
				     <input id="valdate" name="valdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td><td><span>估值表日期（止）</span>
				     <input id="valdate2" name="valdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span></td></tr><tr>
					<td>基金名称：
					  <input class="easyui-combobox"
						name="wbzth" id="wbzth"
						 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=t_fund_info@zhglpt&code=fund_code&name=fund_name&option= where fund_status=8 order by fund_code desc',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('#wbzth').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 "
		               ></td> <td>
		               <span style="color: red;">*</span>
		                 状态：<select class="easyui-combobox"	name="status" id="status" style="width: 120px;" > 
						<option value="">全部</option>
						<option value="01">已发送</option>
						<option value="00">未发送</option>
						<option value="02">发送失败</option>
						<option value="04">停止发送</option>
				
				</select>
					   </td> <td>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"  style="display: none;" data-options="iconCls:'icon-search'" onclick="calculate()">计算</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'"  style="display: none;" onclick="sendmail()">发送</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'"   onclick="adddata()">发送状态重置</a>
					</td><td></td>		
				</tr>
		</table>
		
	
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
					 <th data-options="field:'ck',checkbox:true"></th>
						<th field="fund_id" >基金编码</th>
						<th field="fund_name" width="120" >基金名称</th>
						<th field=val_date width="120">估值表日期</th>
						<th field="status" >发送状态</th>
						<th field="sendtime" >发送时间</th>
						<th field="mailto" width="120" >收件人</th>
						<th field=attachment width="120">附件名称</th>
						<th field="disclosure_type" >披露类型</th>
						<th field="disclosure_frequency" >披露频率</th>
						<th field="data_type" >数据格式</th>
						<th field="valuation_level" >估值表级别</th>
						<th field="net_worth_element" >要素</th>
						<th field="errorinfo" >备注信息</th>

						
						
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		
    
 
</div>
</body>
</div>






