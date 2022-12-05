<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>账套对应关系配置</title>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>
$(function (){
	    //初始化table
	 	 $("#dg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-80
	 	 });
	
	 	$("#wbzth").next().hide();
		$("#tgzth").next().hide();
	 	
	 	$("#tggz").combobox({
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
	 						 $('#tggz').next('.combo').find('input').focus(function (){
	 					       //     $('#tggz').combobox('clear');
	 					            
	 					     });
	 						 
	 				     }
	 	});
	 	$("#wbgz").combobox({
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
	 						 $('#wbgz').next('.combo').find('input').focus(function (){
	 					       //     $('#wbgz').combobox('clear');
	 					            
	 					     });
	 						 
	 				     }
	 	});    
});
</script>

<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
  	 var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&stus="+$("#ztstus").combobox('getValue')+"&op=s";
	 $('#dg').datagrid({url:"<%=cp%>/guzhidz/getAccountMappingbaseInfo?"+params}).datagrid('clientPaging'); 
}



function updateInfo() {
	var row = $('#dg').datagrid('getSelected');
	if (row){
		
		
		 $("#tggz").combobox('setValue',row.tgusercode);
		 $("#wbgz").combobox('setValue',row.wbusercode);
		 $("#dzfre").combobox('setValue',row.dzfre);
		 
		 $("#ztmc").textbox('setValue',row.fund_name);
		 $("#wbmail").textbox('setValue',row.wbmail);
		 
		 
		 $("#wbzth").textbox('setValue',row.wb_zth);
		 $("#tgzth").textbox('setValue',row.tg_zth);
		
		 $('#yhdzhds').dialog('open');
	}
	else{
		$.messager.alert('提示','请先选中一行！');

	}
}

function saveInfo(){

	 var tggz=$("#tggz").combobox('getValue');
	 var wbgz=$("#wbgz").combobox('getValue');
	 var dzfre=$("#dzfre").combobox('getValue');
	 
	 
	 
	 
	 
	 var wbzth=$("#wbzth").textbox('getValue');
	 var tgzth=$("#tgzth").textbox('getValue');
	 var wbmail=$("#wbmail").textbox('getValue');
	 
	 var op='u';
	
	 
	 if(tggz!=''&&tgzth==''){
		 $.messager.alert('提示','请核对该产品是否有托管账套');
		 $('#tggz').combobox('clear');
		 return;
	 }
	 if(wbgz!=''&&wbzth==''){
		 $.messager.alert('提示','请核对该产品是否有外包账套');
		 $('#wbgz').combobox('clear');
		 return;
	 }
	 
	$.ajax({
		url:'<%=cp%>/guzhidz/getAccountMappingbaseInfo',
		type:'post',
		data:{
			dzfre:dzfre,wbmail:wbmail,tggz:tggz,wbgz:wbgz,wbzth:wbzth,tgzth:tgzth,op:op
		},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				
				searchdata();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}


function initdata(){
	var row = $('#dg').datagrid('getSelected');
	if(row.tg_zth==''||row.wb_zth==''){
		$.messager.alert('提示','非托管外包账套，请检查');
		return;
	}
	if (row){
		

		
		 $("#ztmc_ini").textbox('setValue',row.fund_name);
		 
		 $("#wb_ini").textbox('setValue',row.wb_zth);
		 $("#fund_ini").textbox('setValue',row.fund_code); 
		 
		
		 $('#inidata').dialog('open');
		 
		 
	}
	else{
		$.messager.alert('提示','请先选中一行！');

	}
}

function indata(){
	 
	 var op='ini';
	 var fj_ini=$("#fj_ini").combobox('getValue');
	 var wbzth= $("#wb_ini").textbox('getValue');
	 var fund_ini= $("#fund_ini").textbox('getValue');
	 
	 if(wbzth==''||tgzth==''){
			
			return;
		}
	 
	 if(fj_ini=='0'){
		 $.messager.alert('提示','请选择分级信息');
		 return;
	 }
	 
		$.messager.confirm('提示', '确认要初始化科目对应关系吗？该操作执行后将不可恢复', function(r){
			if (r){

				$.ajax({
					url:'<%=cp%>/guzhidz/getAccountMappingbaseInfo',
					type:'post',
					data:{wbzth:wbzth,fund_ini:fund_ini,fj_ini:fj_ini,op:op},
					dataType: "json",
					success: function(data){
						if(data[0].msg=="success"){  
							alert("保存成功");
							closeDialog();
						}else{
							alert("发送失败");
						}
						
					}
				});
			}
		});
	 
}
function closeDialog() {
	
	 $("#tggz").combobox('clear');
	 $("#wbgz").combobox('clear');	 
	 $("#ztmc").textbox('clear');
	 $("#wbzth").textbox('clear');
	 $("#tgzth").textbox('clear');
	 $("#dzfre").combobox('clear');
	 
	 
	 $("#ztmc_ini").textbox('clear');
	 $("#fund_ini").textbox('clear');
	 $("#wb_ini").textbox('clear');

	 
	 $('#yhdzhds').dialog('close');
	 $('#inidata').dialog('close');
	
}

</script>
 
 <body> 
	   <div id="tabsidk" >
			<div title="账套基本信息" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;">
					  <span>账套名称:</span>
					  <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=t_fund_info@zhglpt&code=fund_code&name=fund_name&option= where fund_status in(8,9) order by fund_code desc',
		                          method:'post',
								  multiple:false,
								  width:250,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									 });
							     }
					  ">
					 
					状态： <input class="easyui-combobox" name="ztstus"
						id="ztstus"
						data-options="        valueField: 'value',
 											 textField: 'text',
											  mode:'local',
											 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=st_code_value@zhglpt&code=valu&name=name&option= where grup =\'FUND_STATUS\' order by valu desc',
					                          method:'post',
											  multiple:false,
											  width:120,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}
			    ">
					 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="updateInfo()">修改估值人员</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="initdata()">初始化科目对应关系</a> 
				</div>
				<div style="margin-top: 10px;">
					<table  id="dg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="fund_code" >基金编码</th>
								<th field="fund_name" >基金名称</th>
								<th field="jjzt"  >基金状态</th>
								<th field="tg_zth"  >托管账套号</th>
								<th field="wb_zth"  >外包账套号</th>
								<th field="tgusercode" hidden="true"> tgid</th>
								<th field="tguser"> 托管估值</th>
								<th field="wbusercode" hidden="true"> wbid</th>
								<th field="wbuser"> 外包估值</th>
								<th field="wbmail"> 外包对账邮箱</th>
								<th field="dzfre"> 对账频率</th>
							
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		
   <div id="yhdzhds" class="easyui-dialog" closed="true" title="维护估值人员"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons',
						closable:false
					">
				<span style="margin-left: 0px">账套名称:</span>
			<span> 
			 <input	type="text" class="easyui-textbox"  name="ztmc"	 style="width: 200px" id="ztmc"  disabled="disabled"> 
			 <br></br>
			 <input type="text" class="easyui-textbox" id="wbzth" name="wbzth"   >
			  <input type="text" class="easyui-textbox" id="tgzth" name="tgzth"   >
			 
			</span>
			
				<span style="margin-left: 0px">托管估值人员	<input class="easyui-combobox" id="tggz" name="tggz"></span>
				 <br></br>
				<span style="margin-left: 0px">外包估值人员	<input  class="easyui-combobox" id="wbgz" name="wbgz"></span>
			<br></br>
			 单外包对账邮箱：<input type="text" class="easyui-textbox"   style="width:450px"  id="wbmail" name="wbmail"   >
			 <br></br>
			对账频率： <select id="dzfre" class="easyui-combobox" name="dzfreq_update" style="width: 80px;">
					<option value="0">--请选择--</option>
					<option value="T1">T1</option>
					<option value="T2">T2</option>
					<option value="TN">TN</option>
				</select>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfo()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>  
		
		 <div id="inidata" class="easyui-dialog" closed="true" title="初始化科目对应关系"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#inidatabuttons',
						closable:false
					">
				<span style="margin-left: 0px">账套名称:</span>
			<span> 
			 <input	type="text" class="easyui-textbox"  name="ztmc_ini"	 style="width: 200px" id="ztmc_ini"  disabled="disabled"> 
			  <input	type="text" class="easyui-textbox"  name="fund_ini"	 style="width: 200px" id="fund_ini"  disabled="disabled"> 
			  <input	type="text" class="easyui-textbox"  name="wb_ini"	 style="width: 200px" id="wb_ini"  disabled="disabled">
			 <br></br>
			
			 
			 
			</span>
			
				<select id="fj_ini" class="easyui-combobox" name="fj_ini" style="width: 175px;">
					<option value="0">--请选择--</option>
					<option value="2">无分级</option>
					<option value="1">有分级</option>
				</select>
			
			
		</div>
		<div id="inidatabuttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="indata()">初始化</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"	 onclick="closeDialog()">取消</a>
		</div>  
 </body>
</html>





