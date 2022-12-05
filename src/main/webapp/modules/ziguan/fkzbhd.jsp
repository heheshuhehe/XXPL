<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>账套对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 --> 
<script type="text/javascript">
 $(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
	 	 height : document.documentElement.clientHeight-20
	 });
	//初始化table
	 $("#dg").datagrid({
	 	 width : '100%',
   	     height :document.documentElement.clientHeight-130
	 });	
    
		 $("#fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:80,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onSelect:function(val){
					    
						 $("#secondtype").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
					              method:'get',
								  multiple:false,
								  width:200,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
							      onLoadSuccess: function(){
							    	  $(this).combobox('enable');
								  }		
					    });
					},
					  onLoadSuccess: function(){
								 $('#fristtype').next('.combo').find('input').focus(function (){
							            $('#fristtype').combobox('clear');
							            $('#secondtype').combobox('clear');
							     });
								 
						     }
					
		 }); 
 });


	
</script>
<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
	var date = $('#sdate').combobox('getValue');
	if(date==""){
		alert("请选择查询时间!");
		return;
	}
    $('#dg').datagrid({method:'get',url:"ziguan/fkzbquery?date="+date}).datagrid('clientPaging'); 
}
</script>
<body>
	<div id="tabsidk"  class="easyui-tabs" style="">
	 <div title="风控指标信息" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
					<div style="margin-top:10px; margin-left: 15px; ">
					 <span>日期</span>&nbsp;&nbsp;
				      <input id="sdate" name="sdate" class="easyui-datebox"  style="width: 120px"></input>
						<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>

			      </div>
			 </div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<th field="c_port_code" width="100px">账套号</th>
						   <th field="c_port_name" width="225px">账套名称</th>
							<th field="sz" width="100px">回购市值占比</th>
							<th field="pld" width="150px">偏离度</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

</body>



