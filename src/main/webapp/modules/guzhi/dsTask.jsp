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
		 height : document.documentElement.clientHeight-10
	});
	 //初始化table
	
	 $("#wbdg").datagrid({
	 	 width : '95%' ,
	 		 height : document.documentElement.clientHeight-200
	 });
});

function createwbdata(){
 	
	$('#wbdg').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryDsTask"}); 
} 
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#tgdate").datebox("setValue", myformatter(curr_time));
			$("#wbdate").datebox("setValue", myformatter(curr_time));
			
			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '99%',
		     	 height : document.documentElement.clientHeight-110
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
	<div title="定时任务查询" style="padding: 10px">
		<table>
				<tr>
				
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a></td>	
								
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">修改</a></td>	
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  class="easyui-datagrid" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="taskname"  >任务名称</th>
						<th field="taskurl"  >任务地址</th>
						<th field="isdownfile"  >是否下载文件</th>
						<th field="tasktime"    >每日几点运行</th>
						<th field="downpath"   >文件下载路径</th>
						<th field="isused" >是否启用</th>
					
						
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		

 
</div>
</body>
</div>






