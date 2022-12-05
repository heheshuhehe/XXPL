<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>数据结息查询</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 ,一般来讲初始化操作都是用来初始化表和用来绑定下拉列表框的-->
<script type="text/javascript">
$(function (){

	 $("#zmm").hide();
	
	 $("#tabsidk").tabs({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-20
     	 
	 });
	 $("#dg").datagrid({
	 	 width : '100%',
	     height : document.documentElement.clientHeight-120
	 });
	  $("#dg2").datagrid({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-120
	 });
	 //此段代码是绑定产品名称的下拉列表框
	 $("#c_port_name").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getDataName',
              method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	  $("#guzhiname").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/guzhidz/getUserinfoname',
     method:'post',
	  multiple:false,
	  width:150,
	  filter: function(q, row){
				var opts = $(this).combobox('options');
				console.log(opts);
				return row[opts.textField].indexOf(q) >-1;
			},
			  onLoadSuccess: function(){
					 $('#guzhiname').next('.combo').find('input').focus(function (){
				            $('#guzhiname').combobox('clear');
				            
				     });
					 
			     }
 });

});

//关于日期的二级联动
	function changetime() {
		//1.先获取 newdate 的日期
		var ndate = $("#wbdate").datebox("getValue");
		var a = new Date(ndate.replace(/\-/g, "\/"));
//得到第一个日期，它有onSelect属性，可以触发第二个日期
		var mailsdate = a.getFullYear() + "-";
		mailsdate += a.getMonth() + 1 + "-";
		mailsdate += a.getDate();

		$("#wbdate2").datebox({
		//给第二个日期设置值（将第一个日期放进去）
			value : mailsdate,
			required : true
		});

		
	}

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 
  //数据结息查询
 function searchdata2(){
 		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		
 //var params="c_occur_date="+$("#c_occur_date").datebox('getValue')
 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		var edate = $("#wbdate2").datebox('getValue');
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		
 		var params = {c_cp_name:$("#c_port_name").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue')};
 		
 		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 
      
      $('#dg2').datagrid({method:'post',url:"guzhidz/getGuzhiByCt",queryParams:params}).datagrid('clientPaging'); 
 }
 function closeDialog(){
	 $('#dlg').dialog('close');
	 
 }
 
 function exportDBF() {
	
	jQuery.download = function(url, data, method){
	    // 获得url和data
	    if( url && data ){ 
	        // data 是 string 或者 array/object
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 把参数组装成 form的 input
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request发送请求
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
	
		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		
		 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		var edate = $("#wbdate2").datebox('getValue');
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		
 		var params = {c_cp_name:$("#c_port_name").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue')};
 				
		$.download('guzhidz/downloadsjxxx2',params,'post');
		
};
 function exportDBFTG(type) {
	
	jQuery.download = function(url, data, method){
	    // 获得url和data
	    if( url && data ){ 
	        // data 是 string 或者 array/object
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 把参数组装成 form的 input
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request发送请求
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
	
		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		
		 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		var edate = $("#wbdate2").datebox('getValue');
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		
 		var params = {c_cp_name:$("#c_port_name").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue'),type:type};
 				
		$.download('guzhidz/downloadsjxxxtg',params,'post');
		
};
 
 
 </script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
   	<div title="数据结息查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<input class="easyui-combobox"
						name="c_port_name" id="c_port_name"
		    >
		   <span style="margin-left: 15px;">结息日期(外包组使用时，该日期必须与计息日期一致)</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px" editable="false" data-options="onSelect:changetime"></input></span>
		   <span style="color: red;">*</span>
		   <span style="display: none">
		    <span style="margin-left: 15px;">结束日期</span>  	
		   <span><input id="wbdate2" name="wbdate" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		   </span>
		   <span style="margin-left: 15px;">估值人员:</span> 
					<input class="easyui-combobox" name="guzhi_name"
					id="guzhiname"> 
					<span>&nbsp&nbsp&nbsp</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  <br />	
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportDBF()">外包导出</a>
<!-- 			  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportDBFTG('gth')">托管柜台导出</a>
			  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportDBFTG('rzrq_gth')">托管融资融券导出</a>	 
			  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportDBFTG('stock_option')">托管个股导出</a>	  -->	  
		</div>
		<div style="margin-top: 10px;">
			<table id="dg2" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                    <th field="id" width="80px">序号</th> -->
                        <th field="occur_dt" >结息日期</th>
						<th field="wb_zth" >账套号</th>
						<th field="tg_zth" width="150px" hidden="true" >托管账套号</th>
						<th field="c_port_name" width="150px">账套名称</th>
						<th field="trade_branch" >交易机构</th>
						<th field="gth" >柜台资金账号</th>
						<th field="occur_amt" width="150px">结息金额</th>
						<th field="typeinfo" width="150px">类型</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
  </div>
</div>
</body>













