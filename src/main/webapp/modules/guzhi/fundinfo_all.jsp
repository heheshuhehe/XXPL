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
	  $("#guzhiname").next(".combo").hide();
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
 		var notdata="";
 		if($("#notdata")[0].checked){
 			notdata="1";
 		}
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		
 		var params = {operate:'search',c_cp_name:$("#c_port_name").textbox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue'),
 				
 		notdata:notdata
 		};
 		
 		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 
      
      $('#dg2').datagrid({method:'post',url:"guzhidz/getFundiInfoAll",queryParams:params}).datagrid('clientPaging'); 
 }
 function exportda(){
		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		

//获取开始日期
		var sdate = $("#wbdate").datebox('getValue');
		//获取结束日期
		var edate = $("#wbdate2").datebox('getValue');
		var notdata="";
		if($("#notdata")[0].checked){
			notdata="1";
		}
		
		if (edate < sdate){
		
			alert("结束日期不能小于开始日期");
			
			return;
		}
		
		var params = {operate:'search',c_cp_name:$("#c_port_name").textbox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue'),
				
		notdata:notdata
		};
		
		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 	var params="operate=search&wbdate="+wbdate+"&c_cp_name="+$("#c_port_name").textbox('getValue')+"&down=1";
	var url="<%=cp%>/guzhidz/getFundiInfoAll_ex?"+params; 
	window.location.href=url;
   

}

 
 </script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
   	<div title="数据查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<input class="easyui-textbox"	name="c_port_name" id="c_port_name">
		   <span style="margin-left: 15px;">估值表日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px" editable="false" data-options="onSelect:changetime"></input></span>
		   <span style="color: red;">*</span>
		   <span style="display: none">
		    <span style="margin-left: 15px;">结束日期</span>  	
		   <span><input id="wbdate2" name="wbdate" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		   </span>
					<input class="easyui-combobox" name="guzhi_name"	id="guzhiname" style="display: none"> 
					<input name="notdata" id="notdata" type="checkbox"   style="display: none" /> 
					<span>&nbsp&nbsp&nbsp</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="exportda()">导出</a>
		  <br />	
		 
		</div>
		<div style="margin-top: 10px;">
			<table id="dg2" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:20">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                    <th field="id" width="80px">序号</th> -->
						<th field="fund_code" width="">基金编码</th>
						<th field="fund_name" width="">基金名称</th>
						<th field="wb_zth" width="">外包账套号</th>
						<th field="tg_zth" width="">托管账套号</th>
						<th field="managername" width=""> 管理人</th>
						<th field="managerid" width=""> 管理人编码</th>
						<th field="services" width="">服务范围</th>
						<th field="isdx" width="">是否代销</th>
						<th field="fundstatus" width="">基金状态</th>
						<th field="fundtype" width="">基金类型</th>
						<th field="shenhe_user" width=""> 合同审核</th>
						<th field="add_date" width="">合同创建日期</th>
					
						<th field="xmjl" width="">项目经理</th>
						<th field="amac_code" width="">协会编码</th>
						<th field="xxpldata" width="" hidden="true" > 信披信息</th>
						<th field="set_date" width="">成立日期</th>
						<th field="end_date" width="">清盘日期</th>
						<th field="tg_jg" width="">托管机构</th>
						<th field="wb_jg" width="">外包机构</th>
						<th field="val_date" width=""> 数据日期</th>
						<th field="dwjz" width="">单位净值</th>
						<th field="ljjz" width="">累计单位净值</th>
						<th field="sszb" width="">实收资本</th>
						<th field="zcjz" width="">资产净值</th>

					</tr>
				</thead>
			</table>
		</div>
	</div>
  </div>
  
 
</body>













