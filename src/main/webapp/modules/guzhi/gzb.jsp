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
	 	 width : '98%' 
	 });
});

function createtgdata(){
 	var params="tgdate="+$("#tgdate").combobox('getValue')+"&tgzth="+$("#tgzth").combobox('getValue')+"&tgcj="+$("#tgcj").combobox('getValue');
	$('#dg').treegrid({method:'get',url:"<%=cp%>/guzhidz/queryTggzb?"+params}); 
}
function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+$("#wbzth").combobox('getValue')+"&wbcj="+$("#wbcj").combobox('getValue');
	$('#wbdg').treegrid({method:'get',url:"<%=cp%>/guzhidz/queryWbgzb?"+params}); 
	
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

	 
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="外包估值表" style="padding: 10px">
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
					   </td><td>层级：<select id="wbcj"
						class="easyui-combobox" name="wbcj" style="width: 100px;">
					    	<option value="5">--请选择--</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							</select></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  class="easyui-treegrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id',
				treeField: 'fkmbm', onLoadSuccess: function(node,data){
				$('#wbdg').treegrid('collapseAll');
				}">
				<thead>
					<tr>
						<th field="fkmbm" width="200">科目代码</th>
						<th field="fkmmc" width="200">科目名称</th>
						<th field="fzqsl" width="80">数量</th>
						<th field="fzqcb" width="120" data-options="align:'right',formatter:myformatter">成本</th>
						<th field="fzqsz" width="120" data-options="align:'right',formatter:myformatter">市值</th>
						<th field="en_gzzz" width="120" data-options="align:'right',formatter:myformatter">估值增值</th>
					
						
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		
    <div title="托管估值表" style="padding: 10px">
		 <table>
				<tr>
				<td>
				   <span>日期</span>
				   <input id="tgdate" name="tgdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
				   <span style="color: red;">*</span>
			    </td>
					<td>帐套名称：<input class="easyui-combobox" name="tgzth" id="tgzth"
						data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('#tgzth').next('.combo').find('input').focus(function (){
									            $('#tgzth').combobox('clear');
									     });
								     }
									 "></input>
							<span style="color: red;">*</span></td>
							<td>层级：
								 <select id="tgcj"
							           class="easyui-combobox" name="tgcj" style="width: 100px;">
									    <option value="5">--请选择--</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
								</select>
							</td>
							
					<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createtgdata()">查询</a>
					
					</td>		
				</tr>
		</table>
	    <div style="margin-top: 10px;">
			<table id="dg"  class="easyui-treegrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id',
				treeField: 'vc_kmdm'">
				<thead>
					<tr>
						<th field="vc_kmdm" width="200">科目代码</th>
						<th field="vc_kmmc" width="200">科目名称</th>
						<th field="l_sl" width="80">数量</th>
						<th field="en_cb" width="120" data-options="align:'right',formatter:myformatter">成本</th>
						<th field="en_sz" width="120" data-options="align:'right',formatter:myformatter">市值</th>
						<th field="en_gzzz" width="120" data-options="align:'right',formatter:myformatter">估值增值</th>
					</tr>
				</thead>
			</table>
	 </div>
		    
		
	</div>
 
</div>
</body>
</div>






