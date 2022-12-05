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
 		var notdata="";
 		if($("#notdata")[0].checked){
 			notdata="1";
 		}
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		
 		var params = {operate:'search',c_cp_name:$("#c_port_name").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue'),
 				
 		notdata:notdata
 		};
 		
 		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 
      
      $('#dg2').datagrid({method:'post',url:"guzhidz/getDataFormDB",queryParams:params}).datagrid('clientPaging'); 
 }
 function closeDialog(){
		$("#c_subj_code_u").textbox('clear');
	 	$("#amac_code_u").textbox('clear');
	   $('#yhdzhds').dialog('close');
	 
 }
 function updateInfonew(){
	 //获取选中行
			var row = $('#dg2').datagrid('getSelected');
			if (row){
				
				
				 $("#c_subj_code_u").textbox('setValue',row.c_subj_code);
				 $("#amac_code_u").textbox('setValue',row.amaccode);
				
				 $('#yhdzhds').dialog('open');
			}
			else{
				$.messager.alert('提示','请先选中一行！');

			}


	 }

 

function saveInfonew(){
	var subj=  $("#c_subj_code_u").textbox('getValue');
	var amac=  $("#amac_code_u").textbox('getValue');
	if(amac==''){
		$.messager.alert('提示','协会编码为空！');
		return ;
	}
	$.ajax({
		url:'<%=cp%>/guzhidz/getDataFormDB',
		type:'post',
		data:{
			subj:subj,amac:amac,operate:"update"
		},
		dataType: "json",
		success: function(data){
			if(data[1].msg=="success"){  
				alert("保存成功");
				
				searchdata2();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}
 
 </script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
   	<div title="数据查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<input class="easyui-combobox"
						name="c_port_name" id="c_port_name"
		    >
		   <span style="margin-left: 15px;">估值表日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px" editable="false" data-options="onSelect:changetime"></input></span>
		   <span style="color: red;">*</span>
		   <span style="display: none">
		    <span style="margin-left: 15px;">结束日期</span>  	
		   <span><input id="wbdate2" name="wbdate" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		   </span>
		   <span style="margin-left: 15px;">估值人员:</span> 
					<input class="easyui-combobox" name="guzhi_name"	id="guzhiname"> 
					<input name="notdata" id="notdata" type="checkbox" /> 仅显示未维护数据
					<span>&nbsp&nbsp&nbsp</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="updateInfonew()">修改</a>
		  <br />	
		 
		</div>
		<div style="margin-top: 10px;">
			<table id="dg2" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                    <th field="id" width="80px">序号</th> -->
						<th field="c_port_code" width="">外包账套号</th>
						<th field="c_subj_code" width="">科目代码</th>
						<th field="c_subj_name" width="">科目名称</th>
						<th field="amaccode" width="">协会编码</th>
						<th field="username" width=""> 估值人员</th>

					</tr>
				</thead>
			</table>
		</div>
	</div>
  </div>
  
  <div id="yhdzhds" class="easyui-dialog" closed="true" title="修改协会编码"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
				<span style="margin-left: 0px">科目代码:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="c_subj_code_u" name="c_subj_code_u" readonly="readonly">
			</span>
			
				<span style="margin-left: 0px">协会编码:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="amac_code_u" name="amac_code_u">
			</span>
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
</body>













