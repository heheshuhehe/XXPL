<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>场外投资标的净值查询</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});

	 $("#wbdg").datagrid({
	 	 width : '97%' 
	 });
	 $("#dg2").datagrid({
	 	 width : '97%' 
	 });
	 $("#userInfo").combobox({
         valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
         method:'post',
         multiple:false,
		  multiline:true,
		  width:200,
		  onChange:function() {  
	            var valueField = $(this).combobox("options").valueField;  
	            var val = $(this).combobox("getValue");  //当前combobox的值  
	            var allData = $(this).combobox("getData");   //获取combobox所有数据  
	            var result = true;      //为true说明输入的值在下拉框数据中不存在  
	            for (var i = 0; i < allData.length; i++) {  
	                if (val == allData[i][valueField]) {  
	                    result = false;  
	                    break;  
	                }  
	            }  
	            if (result) {  
	                $(this).combobox("clear");  
	            }  
	      
	        },
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#userInfo').next('.combo').find('input').focus(function (){
		            $('#userInfo').combobox('clear');
		     });
	     }
  });
	 
});


function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+$("#wbzth").combobox('getValue')+"&userInfo="+$("#userInfo").combobox('getValues');
	$('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/wb4otcmanage?'+params}).datagrid('clientPaging');
} 
function queryMXInfo(){
	var rows = $('#wbdg').datagrid('getSelections');
	if(rows.length==0){
		$.messager.alert('提示','没有选择任何数据!');
		return;
	}
	var ssinfo="";
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		ssinfo=ssinfo+"'"+row.c_key_code+"',";
	
	}
	$("#tabsidk").tabs('select', "需更新估值产品");
	var params="wbdate="+$("#wbdate").combobox('getValue')+"&ssinfo="+ssinfo+"&userInfo="+$("#userInfo").combobox('getValues');
	$('#dg2').datagrid({method:'get',url:'<%=cp%>/guzhidz/wb4otcmanagebydown?'+params}).datagrid('clientPaging');
}
function mailgo(){
	var rows = $('#wbdg').datagrid('getSelections');
	if(rows.length==0){
		$.messager.alert('提示','没有选择任何数据!');
		return;
	}
	var ssinfo="";
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		ssinfo=ssinfo+row.c_port_code+","+row.c_port_name+","+row.c_key_code+","+row.c_subj_name+","+row.gzlxr+"###";
		
	
	}
	var params={wbdate:$("#wbdate").combobox('getValue'),
			ssinfo:ssinfo,
			userInfo:$("#userInfo").combobox('getValue')};
	$.ajax({
		url:'<%=cp%>/guzhidz/wb4otcmanagemail',
		type:'post',
		data:params,
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("发送完成");
				
				
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
			 //初始化table
			 $("#dg2").datagrid({
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
	<div title="场外投资标的净值" style="padding: 10px">
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
					   </td><td> <span>估值人员:</span>
			 <input class="easyui-combobox" name="userInfo" id="userInfo"></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="queryMXInfo()">反查产品</a>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-note_go'" onclick="mailgo()">发送提醒邮件</a>
					
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
					  <th data-options="field:'ck',checkbox:true"></th>
						<th field="company_name" hidden="true" >管理人</th>
						<th field="c_port_code" >账套号</th>
						<th field="c_port_name" >账套名称</th>
						<th field="kflx" >开放类型</th>
						<th field="fwfw" >服务范围</th>			
						<th field="c_key_code" >标的代码</th>
						<th field="c_subj_name" >标的名称</th>
						<th field="newdate"  >最新净值日期</th>
						<th field="n_price_close"  >最新净值</th>
						<th field="xmjlinfo" >项目经理</th>
						<th field="gzlxr" width="120">估值核算联系人</th>
						<th field="xmjlyx"  hidden="true">项目经理</th>
						<th field="mailzt" >邮件状态</th>
						
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
	<div title="需更新估值产品" style="padding: 10px">
	
	 <div style="margin-top: 10px;">
			<table id="dg2"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						
						<th field="c_port_code" >账套号</th>
						<th field="c_port_name" >账套名称</th>												
						<th field="c_subj_code" >标的代码</th>
						<th field="c_subj_name" >标的名称</th>			
						<th field="username" >估值人员</th>						
	
					</tr>
				</thead>
			</table>
	 </div>
	</div>	

 
</div>

</body>







