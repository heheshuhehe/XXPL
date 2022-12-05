<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	 //初始化table
	 $("#dg").datagrid({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-80
	 });
});
</script>

<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
   		var params="dataType="+$("#dataType").combobox('getText');
		$('#dg').datagrid({url:"<%=cp%>/guzhidz/getCodeManage?"+params}).datagrid('clientPaging'); 
	
}


function addCodeManage(){
	var data_type=$("#data_type").textbox('getValue');
	var data_value=$("#data_value").textbox('getValue');
	var data_code=$("#data_code").textbox('getValue');
	if(data_type==""){
		alert("请添加数据类型");
		return false;
	}else if(data_value==""){
		alert("请添加数据名称");
		return false;
	}else if(data_code==""){
		alert("请添加数据编号");
		return false;
	}
	else{
			$.ajax({
				url:'<%=cp%>/guzhidz/addCodeManage',
				type:'post',
				data:{data_type:data_type,data_value:data_value,data_code:data_code},
				dataType: "json",
				success: function(data){
						alert("保存成功！");
						$('#dlg').dialog('close');
						searchdata();
						closeDialog();
				}
			});
	}
}


function closeDialog(){
	$('#data_type').textbox('clear');
	$('#data_value').textbox('clear');
	$('#data_code').textbox('clear');
	$('#dlg').dialog('close');
}

function updateInfo(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var datacode = $("input[name='ck']:checked").closest("tr").find("td[field='datacode']");
		var datavalue = $("input[name='ck']:checked").closest("tr").find("td[field='datavalue']");
		datacode.find("div").html("<input type='text' value='"+datacode.find("div").text()+"'></input>");
		datavalue.find("div").html("<input type='text' value='"+datavalue.find("div").text()+"'></input>");
		$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
		$("input[name='ck']").prop("disabled",true);
	}
}


function saveInfo(){
	var id = $("input[name='ck']:checked").closest("tr").find("td[field='id']").text();
	var datacode = $("input[name='ck']:checked").closest("tr").find("td[field='datacode']").find("input").val();
	var datavalue = $("input[name='ck']:checked").closest("tr").find("td[field='datavalue']").find("input").val();
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条要修改的记录！");
		return false;
	}else if(typeof(datacode)=="undefined"||typeof(datavalue)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}
	else{
		$.ajax({
			url:'<%=cp%>/guzhidz/updateCodeManage',
			type:'post',
			data:{id:id,datacode:datacode,datavalue:datavalue},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("操作成功");
				 	$('#dg').datagrid('reload');
				}else{
					alert("操作失败");
				}
			}
		});
	}
}

function delInfo(){
	var id = $("input[name='ck']:checked").closest("tr").find("td[field='id']").text();
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		if(confirm("确定要删除吗？")){
			$.ajax({
				url:'<%=cp%>/guzhidz/deleteCodeManage',
				type : 'post',
				data : {id:id},
				dataType : "json",
				success : function(data) {
						alert("删除成功！");
						//$('#dg').datagrid('reload');
						searchdata();
				}
			});
		}
	}

}
</script>
<body>
<div id="tabsidk">
	<div title="字典维护" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>数据类型:</span> <input class="easyui-combobox" name="dataType"
				id="dataType"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/getDataType',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) == 0;
											}
									 ">
			
			&nbsp;
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">添加</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="updateInfo()">修改</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveInfo()">保存</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="delInfo()">删除</a>
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="100" data-options="hidden:true">ID</th>
						<th field="datatype" width="150">数据类型</th>
						<th field="datacode" width="150">数据编号</th>
						<th field="datavalue" width="250">数据名称</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" closed="true" title="添加账套对应关系"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="
				iconCls: 'icon-save',
				buttons: '#dlg-buttons'
			">
	<span style="margin-left: 20px">数据类型:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="data_type" name="data_type" />
	</span> 
	<span style="margin-left: 20px">数据名称:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="data_value" name="data_value" />
	</span> 
	<br/>
	<br/>
	<span style="margin-left: 20px">数据编号:</span>
	<span> 
	 	<input type="text" class="easyui-textbox" id="data_code" name="data_code">
	</span>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton"
		onclick="addCodeManage()">保存</a> <a href="javascript:void(0)"
		class="easyui-linkbutton"
		onclick="closeDialog()">取消</a>
</div>
</body>




