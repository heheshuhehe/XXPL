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
		width : '98%' ,
	    height : document.documentElement.clientHeight-20
	});
	
	 $("#wbdg").datagrid({
 	 	 width : '100%',
      	 height : document.documentElement.clientHeight-130
 	 });
});

 

function addfileInfo(){
	var files=  document.getElementById("filesnames").files
	 var formData = new FormData($("#uploadfile" )[0]); 
	if(files.length==0){
		$.messager.alert('提示','没有选择文件');
		return;
	}
	$.ajax({
		url:'<%=cp%>/guzhidz/addfileInfo',
		type:'post',
		data:formData,
		 async: false,   
          cache: false,   
          contentType: false,   
          processData: false, 
		dataType: "json",
		success: function(data){
			if(data.msg="success"){
				alert("上传成功！");
				$("#content1").html(data.res);
				$("#filesnames").val('');
			}else{
				alert("上传失败！");
			}
		}
	}); 
}

</script>
<script>
function createwbdata(){
	

	var zth =$("#wbzth").combobox('getValue');

	
 	var params="zth="+zth
 	+"&a_year="+$("#a_year").combobox('getValue')+"&a_quwer="+$("#a_quwer").combobox('getValue');
	
	
 	$('#wbdg').datagrid({url:"<%=cp%>/guzhidz/zzssearch?"+params}).datagrid('clientPaging'); 
 	
	
	
} 
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
	<div title="增值税核对" style="padding: 10px" >
	<form id="uploadfile" style=" "
			enctype="multipart/form-data">
		<table>
				<tr>
					<td><span>当日计税基准余额</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span></td>
				<td><span> 选择模板：<input type="file" id="filesnames" name="filesnames" multiple="multiple" />
				
					<a href="javascript:void(0)" class="easyui-linkbutton"	onclick="addfileInfo()">上传核对</a> </span>
				
			     </td>
				
					<td> </td> 
					<td></td>
					<td></td>		
				</tr>
		</table>
		</form>
		    <div id="content1"
					style="margin-left: 20px;margin-top:20px; overflow: auto; height: 500px"></div>
    </div>
	<div title="增值税核对记录查询" style="padding: 10px" >
	<table>
				<tr>
				<td>年份:<select id="a_year"
						class="easyui-combobox" name="a_year" style="width: 100px;">
							<option value="2021">2021</option>
							<option value="2020">2020</option>
					    	<option value="2019">2019</option>
							
							
							</select>
							月度(季度请选择对应的最末月):<select id="a_quwer"
						class="easyui-combobox" name="a_quwer" style="width: 100px;">	
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
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
					   </td><td> </td> 
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
								
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table    id="wbdg" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th> 
						<th field="wb_zth" >账套号</th>
						<th field="name" >账套名称</th>
						<th field="y_year" >年度</th>
						<th field="m_month" >月度</th>
						<th field="q_quar" >季度</th>
						<th field="t_type" >类型</th>
						<th field="m_moshi" >模式</th>
											
					</tr>
				</thead>
			</table>
	 </div>
	
	</div>
		
 
</div>
</body>
</div>






