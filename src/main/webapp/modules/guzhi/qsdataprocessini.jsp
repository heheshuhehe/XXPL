<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>清算数据准备</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});

	
	 $("#wbdg4").datagrid({
	 	 width : '98%' 
	 });
	 $("#wbdg5").datagrid({
	 	 width : '98%' 
	 });
});




function createwbdata4(){
 	var params="ini_group4="+$("#ini_group4").combobox('getValue');
	 $('#wbdg4').datagrid({method:'get',url:'<%=cp%>/guzhidz/querybaseini?'+params}).datagrid('clientPaging');
	
} 
function createwbdata5(){
 	var params="filetype5="+$("#filetype5").combobox('getValue');
	 $('#wbdg5').datagrid({method:'get',url:'<%=cp%>/guzhidz/querybasefile?'+params}).datagrid('clientPaging');
	
} 





function adddata4(oper){
 	
	 $('#oper4').val(oper);
	if(oper=='a'){
		
		 $('#dialog4').dialog('open');
	}
	
	if(oper=='u'){
		var rows = $('#wbdg4').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}
		if(rows.ini_code=='1'|| rows.ini_code=='3'){
			$.messager.alert('提示','文件种类和数据来源不可编辑!');
			return;
		}
		if(rows.datacode=='21'|| rows.datacode=='22'){
			$.messager.alert('提示','系统的默认初始化数据，不可编辑!');
			return;
		}
		
		$("#ini_group4_dia4").combobox('readonly',true) ;
		$("#ini_group4_dia4").combobox('select',rows.ini_code) ;
		$("#code4_dia4").textbox('setValue', rows.datacode) ;
	 	$("#name4_dia4").textbox('setValue', rows.dataname) ;
	 	
	 	 $('#dialog4').dialog('open');
	}
	

	if(oper=='d'){
		var rows = $('#wbdg4').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}
		if(rows.ini_code=='1'|| rows.ini_code=='3'){
			$.messager.alert('提示','文件种类和数据来源不可编辑!');
			return;
		}
		if(rows.datacode=='21'|| rows.datacode=='22'){
			$.messager.alert('提示','系统的默认初始化数据，不可编辑!');
			return;
		}
		
		var datacode=rows.datacode;
		$.messager.confirm('提示', '确认要删除吗?', function(r){
			if (r){

				$.ajax({
					url:'<%=cp%>/guzhidz/querybaseiniedit',
					type:'post',
					data:{datacode:datacode,oper:oper},
					dataType: "json",
					success: function(data){
						if(data[0].msg=="success"){  
							alert("保存成功");
							closeDialog();
						}else{
							alert("发送失败");
						}
						
					}
				});
			}
		});
	}
	
} 
function adddata5(oper){
 	
	 $('#oper5').val(oper);
	if(oper=='a'){
		
		 $('#dialog5').dialog('open');
	}
	
	if(oper=='u'){
		var rows = $('#wbdg5').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}

		
		$("#filetype5_dia5").combobox('readonly',true) ;
		$("#filetype5_dia5").combobox('select',rows.datacode) ;
		$("#filename5_dia5").textbox('setValue', rows.filename) ;
		$("#filename5_dia5_old").val(rows.filename);

	 	
	 	 $('#dialog5').dialog('open');
	}
	if(oper=='d'){
		var rows = $('#wbdg5').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}
		
		var ider=rows.ider;
		$.messager.confirm('提示', '确认要删除吗?', function(r){
			if (r){

				$.ajax({
					url:'<%=cp%>/guzhidz/querybasefilemx',
					type:'post',
					data:{ider:ider,oper:oper},
					dataType: "json",
					success: function(data){
						if(data[0].msg=="success"){  
							alert("保存成功");
							closeDialog();
						}else{
							alert("发送失败");
						}
						
					}
				});
			}
		});

	}
} 


function saveInfonew4(){

	var  ini_group=$("#ini_group4_dia4").combobox('getValue') ;
	var  datacode=$("#code4_dia4").textbox('getValue') ;
	var  dataname=$("#name4_dia4").textbox('getValue') ;
	var oper=$("#oper4").val() ;
	
	if(ini_group=='' || dataname==''){
		$.messager.alert('提示','配置类型或者数据名称为空');
		return;
	}
	$.ajax({
		url:'<%=cp%>/guzhidz/querybaseiniedit',
		type:'post',
		data:{ini_group:ini_group,datacode:datacode,dataname:dataname,oper:oper},
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
function saveInfonew5(){

	var  filetype=$("#filetype5_dia5").combobox('getValue') ;
	var  filename=$("#filename5_dia5").textbox('getValue') ;
	var  filename_old=$("#filename5_dia5_old").val();
	var oper=$("#oper5").val() ;
	
	if(filetype=='' || filename==''){
		$.messager.alert('提示','文件种类或者文件名称为空');
		return;
	}
	
	$.ajax({
		url:'<%=cp%>/guzhidz/querybasefilemx',
		type:'post',
		data:{filetype:filetype,filename:filename,filename_old:filename_old,oper:oper},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				closeDialog();

			}else{
				alert("发送失败");
			}
			
		}
	});

}
function closeDialog(){
	
	

	$("#ini_group4_dia4").combobox('clear') ;
	$("#ini_group4_dia4").combobox('readonly',false) ;
	$("#code4_dia4").textbox('clear') ;
 	$("#name4_dia4").textbox('clear') ;
 	 $('#dialog4').dialog('close');
 	 
 	$("#filetype5_dia5").combobox('readonly',false) ;
	$("#filetype5_dia5").combobox('clear') ;
	$("#filename5_dia5").textbox('clear') ;
	$("#filename5_dia5_old").val('') ;
	
	 $('#dialog5').dialog('close');
 	
}

</script>
<script>
 $(function (){
			var curr_time = new Date();
			

			 //初始化table
			 $("#wbdg4").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 
			//初始化table
			 $("#wbdg5").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 
			 
			 
		

			 

		
			 $("#filetype5").combobox({
	              valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='1' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     }
		  });
			 
			 $("#filetype5_dia5").combobox({
	              valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='1' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     }
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
	
	
    
    <div title="基础数据配置" style="padding: 10px">
		<table>
				<tr>
				<td><span>配置类型</span>
				<select class="easyui-combobox"	name="ini_group4" id="ini_group4"  > 
					 	<option value="0"selected="selected" >全部</option>
						<option value="1">文件种类</option>
						<option value="2">交易机构</option>
						<option value="3">文件来源</option>
				
				</select>
				    
			     </td>
					
					   </td>
						<td>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata4()">查询</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata4('a')">添加</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata4('u')">修改</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata4('d')">删除</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg4"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="ini_group" >配置类型</th>
						<th field="ini_code" hidden="true" >配置类型</th>
						<th field="datacode" >代码</th>
						<th field="dataname" >数据名称</th>

					</tr>
				</thead>
			</table>
	 </div>
    </div>	
 <div title="文件种类明细配置" style="padding: 10px">
		<table>
				<tr>
				<td><span>文件种类</span>
				<input class="easyui-combobox"	name="filetype5" id="filetype5"  > 
				

				    
			     </td>
					
					   </td>
						<td>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata5()">查询</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata5('a')">添加</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata5('u')">修改</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata5('d')">删除</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg5"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="dataname" >文件种类</th>
						<th field="datacode" hidden="true" >文件代码</th>
						<th field="filename" >文件名称</th>
						<th field="ider" hidden="true" >id</th>
						

						
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>	
    
</div>
</body>


 <div id="dialog4" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons4',
						modal:true
					">
				<span style="margin-left: 0px">配置类型:</span>
			<span> 
			 <select class="easyui-combobox"	name="ini_group4_dia4" id="ini_group4_dia4"  > 
						<!-- <option value="1">文件种类</option> -->
						<option value="2">交易机构</option>
				
				</select>
			</span>
				<br /> <br />
				<span style="margin-left: 0px">代码(新增无需填写):</span>
			<span> 
			 	<input id="code4_dia4" name="code4_dia4"	class="easyui-textbox"	readonly="readonly"	style="width: 120px"></input>
			</span>
			<br /> <br />
			<span style="margin-left: 0px">名称:</span>
			<span> 
			 	<input id="name4_dia4" name="name4_dia4"	class="easyui-textbox"		style="width: 300px"></input>
			</span>
			<input   id="oper4" name="oper4" style="display: none;" >
			
		</div>
		<div id="dlg-buttons4">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew4()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
<div id="dialog5" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons5',
						modal:true
					">
				<span style="margin-left: 0px">文件种类:</span>
			<span> 
			 <input class="easyui-combobox"	name="filetype5_dia5" id="filetype5_dia5"  > 
			</span>
		
			<br /> <br />
			<span style="margin-left: 0px">文件名称:</span>
			<span> 
			 	<input id="filename5_dia5" name="filename5_dia5"	class="easyui-textbox"		style="width: 120px"></input>
			</span>
			<input   id="oper5" name="oper5" style="display: none;" >
			<input   id="filename5_dia5_old" name="filename5_dia5_old" style="display: none;" >
			
		</div>
		<div id="dlg-buttons5">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew5()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>




