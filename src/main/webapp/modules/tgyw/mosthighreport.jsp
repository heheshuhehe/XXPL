<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>最高额度申报</title>
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
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fdtype="+$("#fdtype").combobox('getValue');
	 $('#wbdg').datagrid({method:'get',url:'<%=cp%>/tgyw/searchmosthigh?'+params}).datagrid('clientPaging');
	
} 

function createwbdata2(type){
	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fdtype="+$("#fdtype").combobox('getValue')+"&type="+type;
	
	
	var url="<%=cp%>/tgyw/searchmosthighdown?"+params; 
	window.location.href=url;
   
	
} 
function closeDialog(){
	$("#jgmc_to").textbox('clear');
 	$("#lastdate_to").datebox('clear');
   $('#yhdzhds').dialog('close');
 
}
function createwbdata3(){
	var rows = $('#wbdg').datagrid('getSelections');
	if(rows.length==0){
		$.messager.alert('提示','没有选择任何数据!');
		return;
	}
	$("#jgmc_to").textbox('setValue',rows[0].shjgmc);
 	$("#lastdate_to").datebox('setValue',rows[0].lastdate);
	 $('#yhdzhds').dialog('open');
}
function saveInfonew(){
	var rows = $('#wbdg').datagrid('getSelections');
	if(rows.length==0){
		$.messager.alert('提示','没有选择任何数据!');
		return;
	}
	var  shid=rows[0].shjgdm;
	var  szid=rows[0].szjgdm;
	var lastdate=$("#lastdate_to").datebox('getValue');;
	$.ajax({
		url:'<%=cp%>/tgyw/searchmosthighedit',
		type:'post',
		data:{shid:shid,szid:szid,lastdate:lastdate},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				closeDialog();
				createwbdata();
			}else{
				alert("发送失败");
			}
			
		}
	});

}

</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#wbdate").datebox("setValue", myformatter(curr_time));

			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
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
	<div title="最高额度申报" style="padding: 10px">
		<table>
				<tr>
				<td><span>估值表日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>
					<td> <select id="fdtype" class="easyui-combobox" name="fdtype" style="width: 80px;">
					<option value="1">全部</option>
					<option value="2">幅度>10%</option>

					
				</select>
		               <span style="color: red;">*</span>
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata3()">上次估值表日期</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2('sh')">导出-上海</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2('sz')">导出-深圳</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2('dg')">导出底稿</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="shjgdm" >上海机构代码</th>
						<th field="shjgmc" >上海机构名称</th>
						<th field="shkzlb" >上海控制类别</th>
						<th field="szjgdm" >深圳机构代码</th>
						<th field="szjgmc" >深圳机构名称</th>
						<th field="szkzlb" >深圳控制类别</th>
						<th field="lastdate" >上次估值表日期</th>
						<th field="zrzcze" data-options="align:'right',formatter:myformatter">上次资产总额（百万）</th>
						<th field="zcze" data-options="align:'right',formatter:myformatter">资产总额（百万）</th>
						<th field="fudu" data-options="align:'right',formatter:myformatter">变动幅度</th>

					</tr>
				</thead>
			</table>
	 </div>
    </div>
		
    
 
</div>
  <div id="yhdzhds" class="easyui-dialog" closed="true" title="维护上次估值表日期"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons',
						modal:true
					">
				<span style="margin-left: 0px">机构名称:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="jgmc_to" name="jgmc_to" readonly="readonly">
			</span>
			
				<span style="margin-left: 0px">上次估值表日期:</span>
			<span> 
			 	<input id="lastdate_to" name="lastdate_to"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
			</span>
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
</body>







