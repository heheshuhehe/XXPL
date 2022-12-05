<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
	$(function (){
		 //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	    	 height : document.documentElement.clientHeight-80
		 });
	});
</script>

<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
   	var params="systype=2&zth="+$("#wb_zth").combobox('getValue');
	$('#dg').datagrid({method:'get',url:"<%=cp%>/guzhidz/getzjzhConfig?"+params}).datagrid('clientPaging'); 
	
}


function addGuzhiUserInfo(){
	
	 var cz=  $("#cz").val();
	var zth=$("#wbzth").combobox('getValue');
	var jyjg=$("#jyjg").combobox('getValue');

	var ptzjzh=$("#ptzjzh").textbox('getValue');
	var ptsubj=$("#ptsubj").textbox('getValue');
	var xyzjzh=$("#xyzjzh").textbox('getValue');
	var xysubj=$("#xysubj").textbox('getValue');
	var ggzjzh=$("#ggzjzh").textbox('getValue');
	var ggbfjsubj=$("#ggbfjsubj").textbox('getValue');
	var ggbzjsubj=$("#ggbzjsubj").textbox('getValue');
	
	 var ider=$("#ider").val();
	var systype=2;

	
	if( zth==""){
		alert("请选择账套");
		return false;
	}else if(jyjg==""){
		alert("请选择交易机构");
		return false;
	}
		$.ajax({
			url:'<%=cp%>/guzhidz/addzjzh',
			type:'post',
			data:{zth:zth,jyjg:jyjg,ptzjzh:ptzjzh,ptsubj:ptsubj,xyzjzh:xyzjzh,xysubj:xysubj,ggzjzh:ggzjzh,ggbfjsubj:ggbfjsubj,ggbzjsubj:ggbzjsubj,systype:systype,cz:cz,ider:ider},
			dataType: "text",
			success: function(data){
				if(data=="2"){

					alert("保存成功");
					$('#dlg').dialog('close');
					searchdata();
					closeDialog();
				}else{
					alert("保存失败");
				}
			}
		});
	
}


function closeDialog(){
	$('#wbzth').combobox('clear');
	$('#jyjg').combobox('clear');
	$("#ptzjzh").textbox('clear');
	$("#ptsubj").textbox('clear');
	$("#xyzjzh").textbox('clear');
	$("#xysubj").textbox('clear');
	$("#ggzjzh").textbox('clear');
	$("#ggbfjsubj").textbox('clear');
	$("#ggbzjsubj").textbox('clear');
	$('#dlg').dialog('close');
}

function addinfo(){
	$("#wbzth").combobox('enable');
	 $("#cz").val('add');
	$('#dlg').dialog('open')
}
function updateInfo(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		
		$("#wbzth").combobox('disable',true);
		 $("#ider").val(row.ider);
		 $("#wbzth").combobox('setValue',row.zth);
		 $("#jyjg").combobox('setValue',row.jgcode);
		 	$("#ptzjzh").textbox('setValue',row.ptzjzh);
			$("#ptsubj").textbox('setValue',row.ptsubj);
			$("#xyzjzh").textbox('setValue',row.xyzjzh);
			$("#xysubj").textbox('setValue',row.xysubj);
			$("#ggzjzh").textbox('setValue',row.ggzjzh);
			$("#ggbfjsubj").textbox('setValue',row.ggbfjsubj);
			$("#ggbzjsubj").textbox('setValue',row.ggbzjsubj);
		 
		 
		 $("#cz").val('update');
		 $('#dlg').dialog('open');
	}
	else{
		$.messager.alert('提示','请先选中一行！');

	}

}


function deleteInfo(){var row = $('#dg').datagrid('getSelected');
if (row){
	
	$.messager.confirm('删除', '确定要删除这条数据吗？', function(r){
		if (r){
			var zth=row.zth;
			var zjzh=row.acct_no;
			var ider=row.ider;
			var cz='delete';
			var systype=2;
			$.ajax({
				url:'<%=cp%>/guzhidz/addzjzh',
				type:'post',
				data:{zth:zth,systype:systype,cz:cz,zjzh:zjzh,ider:ider},
				dataType: "text",
				success: function(data){
					if(data=="2"){

						alert("保存成功");
						$('#dlg').dialog('close');
						searchdata();
						closeDialog();
					}else{
						alert("保存失败");
					}
				}
			});
			
		}
		
	});
}
else{
	$.messager.alert('提示','请先选中一行！');

}

}


</script>
<body>
<div id="tabsidk">
	<div title="资金账号配置" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>账套名称</span> 
			 <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
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
		  
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addinfo()">添加</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="updateInfo()">修改</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="deleteInfo()">删除</a> 
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" 
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="ider" width="80" hidden="true">id</th>		
						<th field="zth" >账套号</th>						
						<th field="ztmc" >账套名称</th>
						<th field="jyjg" >交易机构</th>
						<th field="jgcode" width="100" hidden="true">交易</th>
						<th field="ptzjzh" >普通资金账号</th>			
						<th field="ptsubj" >普通账号估值科目</th>	
						<th field="xyzjzh" >信用资金账号</th>			
						<th field="xysubj" >信用账号估值科目</th>		
						<th field="ggzjzh" >个股期权资金账号</th>			
						<th field="ggbfjsubj" >个股期权<br>备付金估值科目</th>
						<th field="ggbzjsubj" >个股期权<br>保证金估值科目</th>							
						
						

					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" closed="true" title="添加估值人员信息"
	style="width: 650px; height: 300px; padding: 10px;"
	data-options="
				iconCls: 'icon-save',
				buttons: '#dlg-buttons',
				closable: false
			">
	<span style="margin-left: 20px">账套名称</span> 
	<span> 
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
	</span> 
	<span style="margin-left: 20px">交易机构</span> 
	<span> 
		<input class="easyui-combobox" name="jyjg" id="jyjg"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option=where ini_group=\'2\'  order by datacode desc',
		                          method:'post',
								  multiple:false,
								  width:120,
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
	</span>
	<br/><br/>

	<span style="margin-left: 20px">普通资金账号:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ptzjzh" name="ptzjzh">
	</span>
	<span style="margin-left: 18px"> 普通账号估值科目</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ptsubj" name="ptsubj" />
	</span> 
	<br/><br/>

	<span style="margin-left: 20px"> 信用资金账号:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="xyzjzh" name="xyzjzh">
	</span>
	<span style="margin-left: 18px"> 信用账号估值科目</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="xysubj" name="xysubj" />
	</span> 
	<br/><br/>
	
	<span style="margin-left: 20px"> 个股期权资金账号:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ggzjzh" name="ggzjzh">
	</span>
	<span style="margin-left: 18px"> 个股期权备付金估值科目</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ggbfjsubj" name="ggbfjsubj" />
		
	</span> 
	<br/><br/>
		<span style="margin-left: 18px"> 个股期权保证金金估值科目</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ggbzjsubj" name="ggbzjsubj" />
		
	</span> 
	<br/><br/>
  <input type="text"  style="display: none;" id="cz" name="cz" />
  <input type="text"  style="display: none;" id="ider" name="ider" />
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" 
		onclick="addGuzhiUserInfo()">保存</a> <a href="javascript:void(0)"
		class="easyui-linkbutton"
		onclick="closeDialog()">取消</a>
</div>

</body>




