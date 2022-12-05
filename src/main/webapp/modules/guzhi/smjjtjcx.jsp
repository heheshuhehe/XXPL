<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>私募基金统计查询</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});

	 $("#wbdg").datagrid({
	 	 width : '100%' 
	 });
	 $("#wbdg0").datagrid({
	 	 width : '100%' 
	 });
	 $("#wbdg1").datagrid({
	 	 width : '100%' 
	 });
});


function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&zth="+$("#zth").combobox('getValue')+"&wbdate_end="+$("#wbdate_end").combobox('getValue');
	
 	params+="&report_type="+$("#report_type").combobox('getValue')+"&busi_type="+$("#busi_type").combobox('getValue');
 	$('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/smjjtjcx?'+params}).datagrid('clientPaging');
} 
function createwbdata0(){
 	var params="wbdate0="+$("#wbdate0").combobox('getValue')+"&wbdate_end0="+$("#wbdate_end0").combobox('getValue');
 	params+="&type0="+$("#type0").combobox('getValue');
 	$('#wbdg0').datagrid({method:'get',url:'<%=cp%>/guzhidz/smjjtjcx0?'+params}).datagrid('clientPaging');
} 
function createwbdata1(){
 	var params="wbdate1="+$("#wbdate1").combobox('getValue')+"&wbdate_end1="+$("#wbdate_end1").combobox('getValue')+"&tgjg1="+$("#tgjg1").textbox('getValue');

 	$('#wbdg1').datagrid({method:'get',url:'<%=cp%>/guzhidz/smjjtjcx1?'+params}).datagrid('clientPaging');
} 
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#wbdate").datebox("setValue", myformatter(curr_time));
			$("#wbdate_end").datebox("setValue", myformatter(curr_time));
			$("#wbdate0").datebox("setValue", myformatter(curr_time));
			$("#wbdate_end0").datebox("setValue", myformatter(curr_time));
			$("#wbdate1").datebox("setValue", myformatter(curr_time));
			$("#wbdate_end1").datebox("setValue", myformatter(curr_time));

			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '98%',
		     	 height : document.documentElement.clientHeight-120
			 });
			 $("#wbdg0").datagrid({
			 	 width : '98%',
		     	 height : document.documentElement.clientHeight-120
			 });
			 $("#wbdg1").datagrid({
			 	 width : '98%',
		     	 height : document.documentElement.clientHeight-120
			 });
			 $("#report_type").combobox({
				  
				 onChange:function(n,o){
					 if(n=='0'){
						 $("#needdo").css('display','none'); 
					 }
					if(n=='1'){
						 $("#needdo").css('display','');
					 }
					  
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
	<div title="私募基金统计查询" style="padding: 10px">
		<table>
				<tr>
				<td><span>查询类型:</span> 	<select id="report_type" class="easyui-combobox" name="report_type" style="width: 150px;" >
					<option value="1">新增产品期末数据</option>
					<option value="0">全部产品期末数据</option>
					
					
				</select></td>
				<td><span>业务类型:</span> 	<select id="busi_type" class="easyui-combobox" name="busi_type" style="width: 120px;" >
					<option value="1">外包服务</option>
					<option value="2">托管业务</option>
					<option value="3">托管业务(私募)</option>
					<option value="4">托管业务(公募)</option>
					
				</select></td>
				<td>  <span style="display: none;">产品名称: 	<input class="easyui-combobox"	name="zth" id="zth"   /> </span></td> 
				 
				 <td><span id="needdo">期初日期
				     <input id="wbdate" name="wbdate" 
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px;"></input>
					 <span style="color: red;">*</span>  </span>
			     </td>
			     
					<td><span>期末日期</span>
				     <input id="wbdate_end" name="wbdate_end"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="zth" >账套号</th>
						<th field="ztmc" >账套名称</th>
						<th field="clrq" width="100px">成立日期</th>
						<th field="sjdate" >数据日期</th>
						<th field="sszb" data-options="align:'right',formatter:myformatter">实收资本（份额）</th>
						<th field="zcjz" data-options="align:'right',formatter:myformatter">资产净值（元）</th>
	
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
	<div title="协会数据排名统计（数量）" style="padding: 10px">
		<table>
				<tr>
				<td></td>
				<td></td>
				<td><select id="type0" class="easyui-combobox" name="type0" style="width: 150px;" >
					<option value="0">全部</option>
					<option value="1">非银行机构</option>
					
					
				</select> </td> 
				 
				 <td>备案区间
				     <input id="wbdate0" name="wbdate0" 
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px;"></input>
					 <span style="color: red;">*</span> 
			     </td>
			     
					<td><span></span>
				     <input id="wbdate_end0" name="wbdate_end0"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;"></span>
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata0()">查询</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg0"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="rank" hidden="true" >排名</th>
						<th field="tgjg" >托管机构</th>
						<th field="num" width="100px">产品数量</th>

					</tr>
				</thead>
			</table>
	 </div>
    </div>	
    <div title="协会数据查询" style="padding: 10px">
		<table>
				<tr>
				<td>托管机构：<input class="easyui-textbox" style="width: 150px"  id="tgjg1" /> </td>
				<td></td>
				<td> </td> 
				 
				 <td>备案区间
				     <input id="wbdate1" name="wbdate1" 
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px;"></input>
					 <span style="color: red;">*</span>
			     </td>
			     
					<td><span></span>
				     <input id="wbdate_end1" name="wbdate_end1"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;"></span>
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata1()">查询</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg1"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="jjmc" >基金名称</th>
						<th field="xhbm" >协会编码</th>
						<th field="tgjg" >托管机构</th>
						<th field="glr" >管理人</th>
						<th field="barq" >备案日期</th>

					</tr>
				</thead>
			</table>
	 </div>
    </div>
    
 
</div>
</body>
</div>






