<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>业务总结</title>
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
	var tdate=$("#wbdate").combobox('getValue');

	var wbdate2=$("#wbdate").combobox('getValue');
	var busi_type=$("#wbdate").combobox('getValue');
	var ye_type=$("#wbdate").combobox('getValue');
	
  $.ajax({
			url:'<%=cp%>/guzhidz/busiSum',
			type:'post',
		    data:{date:tdate},
			
			dataType: "json",
			success: function(data){
				if(data.length==1){
					$('#content1').html(data[0].res);
				}else{
					alert("查询失败！");
				}
			}
		}); 

} 


</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#wbdate").datebox("setValue", myformatter(curr_time));
			$("#wbdate2").datebox("setValue", myformatter(curr_time));
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
	<div title="业务总结" style="padding: 10px">
		<table>
				<tr>
				<td><span>截止日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
					 
					<div style="display: none;"> 
					 <span>结束日期</span>
				     <input id="wbdate2" name="wbdate2"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
					 <span>类型:</span> 	<select id="busi_type" class="easyui-combobox" name="busi_type" style="width: 100px;" >
					<option value="1">全部</option>
					<option value="2">我司提供服务</option>
					<option value="3">关联交易</option>
					</select>
					 <span> 余额方向:</span> 	<select id="ye_type" class="easyui-combobox" name="ye_type" style="width: 100px;" >
					<option value="1">借方（已付）</option>
					<option value="2">贷方（计提）</option>
					</select>
					</div>
			     </td>
					<td>
		               <span style="color: red;">*</span>
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
</td>		
				</tr>
		</table>
			<div id="content1"
					style="margin-left: 20px; overflow: auto; height: 400px"></div>
		
		 <div style="margin-top: 10px;display: none" >
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<!-- <th field="wb_zth" >账套号</th> -->
						<th field="comname" >管理人</th>
						<th field="ztmc" >账套名称</th>
						<th field="clrq" >成立日期</th>
						<th field="jsrq" >结束日期</th>
						<th field="tgf" data-options="align:'right',formatter:myformatter">托管费</th>
						<th field="wbf" data-options="align:'right',formatter:myformatter">外包费</th>
						<th field="tgwbf" >托管+外包</th>

	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		
    
 
</div>
</body>
</div>






