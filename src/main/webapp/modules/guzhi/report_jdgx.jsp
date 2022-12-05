<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>账套对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});
	 //初始化table
	 $("#dg").datagrid({
	 	 width : '98%' 
	 	 
	 });
	 $("#wbdg").datagrid({
	 	 width : $("#tabsidk").width-10 
	 });
});

  
function create_jdgx(){
	


	var wbzth="";
	 var rows = $('#wbdg').datagrid('getSelections');
	  
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			wbzth=wbzth+row.c_port_code+",";
		}
	
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+wbzth+"&wbcj="+$("#wbcj").combobox('getValue')
 	+"&a_year="+$("#a_year").combobox('getValue')+"&a_quwer="+$("#a_quwer").combobox('getValue');
	
	
	$.ajax({
		url:'<%=cp%>/guzhidz/jdgx',
		type:'post',
		data:params,
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("发送完成！");
			}else{
				alert("发送失败！！！");
			}
			
		}
	});
	
} 

function createwbdata(){
 	
	$('#wbdg').datagrid({method:'get',url:"<%=cp%>/guzhidz/allaccount?wbzth=" +$('#wbzth').combobox('getValue') }); 
} 
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#tgdate").datebox("setValue", myformatter(curr_time));
			$("#wbdate").datebox("setValue", myformatter(curr_time));
			 //初始化table
			 $("#dg").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
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
	var editIndex = undefined;
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#wbdg').datagrid('validateRow', editIndex)){
			alert(editIndex);
			$('#wbdg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}

	function onClickRow(index){
		if (editIndex != index){
			if (endEditing()){
				$('#wbdg').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				$('#wbdg').datagrid('selectRow', editIndex);
			}
		}
	}
	
	function getSelections(){
		var ss = [];
		var rows = $('#wbdg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ss.push('<span>'+row.itemid+":"+row.productid+":"+row.attr1+'</span>');
		}
		$.messager.alert('Info', ss.join('<br/>'));
	}
	 
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="季度更新" style="padding: 10px">
		<table>
				<tr>
				<td>年份:<select id="a_year"
						class="easyui-combobox" name="a_year" style="width: 100px;">
						    <option value="2021">2021</option>
						    <option value="2020">2020</option>
					    	<option value="2019">2019</option>
							<option value="2018">2018</option>
							<option value="2017">2017</option>
							<option value="2016">2016</option>
							
							</select>
							季度:<select id="a_quwer"
						class="easyui-combobox" name="a_quwer" style="width: 100px;">	
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							</select><td>  <span style="display: none"> 指定日期
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>  </span>
			     </td>
					<td>帐套名称：
					  <input class="easyui-combobox"
						name="wbzth" id="wbzth"
						 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
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
		               >
		               <span style="color: red;">*</span>
					   </td><td><span style="display: none;"> 层级：<select id="wbcj"
						class="easyui-combobox" name="wbcj" style="width: 100px;">
					    	<option value="5">--请选择--</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							</select> </span> </td> 
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="create_jdgx()">生成</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table    id="wbdg" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th> 
						<th field="c_port_code" >账套号</th>
						<th field="c_port_name" >账套名称</th>
											
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		
 
</div>
</body>
</div>






