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
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+$("#wbzth").combobox('getValue');
	 $('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/querygtbalance?'+params}).datagrid('clientPaging');
	
	$('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/querygtbalance?'+params});
} 

function createwbdata2(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth=0";
	
	
	$('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/querygtbalance?'+params});
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
	<div title="柜台余额查询" style="padding: 10px">
		<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
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
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2()">虚拟估值表</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="wb_zth" >账套号</th>
						<th field="c_port_name" >账套名称</th>
						<th field="gth" >普通柜台号</th>
						<th field="xhye" data-options="align:'right',formatter:myformatter">柜台余额</th>
						<th field="rzrq_gth" >双融柜台号</th>
						<th field="srye" data-options="align:'right',formatter:myformatter">双融余额</th>
						<th field="stock_option" >个股期权号</th>
						<th field="ggye" data-options="align:'right',formatter:myformatter">个股期权余额</th>
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		
    
 
</div>
</body>
</div>






