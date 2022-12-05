<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>科目对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
var mydate_server = '${mydate}' ;
var wbzth_server='${wbzth}';
$(function (){
		//初始化tab页
	
		 
		 $("#dg").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-100
		 });
});
  

</script>
 
<!-- 自定义js -->
<script type="text/javascript">


function Download() {//导出Excel文件
	if($("#trans_date").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
	
	   // alert("请选择核对资金明细！"+params_1);
	   var params="trans_date="+$("#trans_date").datebox('getValue');
	    window.location.href="<%=cp%>/zg/DownloadTransOrder?"+params;
	    
    }
  
}
</script>
<body>


<div id="tabsidk" class="easyui-tabs" style="">
	<div title="每日划款指令导出" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
		   	 <span style="margin-left: 30px;">查询日期</span>  	
		     <span><input id="trans_date" name="trans_date" class="easyui-datebox" style="width: 150px"></input></span>
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="Download()">导出</a> 
			  <span id='noteqlNum' style="font-size:20px;float: right;"></span>
			  <table  id="dg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				               ">
		</div>
	</div>
	</div>
</div>

</body>





