<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/modules/guzhi/resoures.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>数据结息查询</title>
<script>document.documentElement.focus();</script>

<script type="text/javascript">
	
	var editIndex = undefined;
	
	function remove(){
		if (editIndex == undefined){return}
		$('#dg').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	
	function getSelections(){
		var ss = [];
		var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ss.push('<span>'+row.itemid+":"+row.productid+":"+row.attr1+'</span>');
		}
		$.messager.alert('Info', ss.join('<br/>'));
	}
	
	function closeDialog(){
		$('#fre_type').combobox('clear');
		$('#guzhi_type').textbox('clear');
		$('#filesname').val('');
		$('#dlg_add').dialog('close');
	}

	function searchdata_tg(){
		var fre_type_dz = $('#fre_type_dz').combobox('getValue');
		var files=  document.getElementById("tgfiles").files
		 var formData = new FormData($("#tgwb_hedui" )[0]); 
		if(files.length==0){
			$.messager.alert('提示','没有选择文件');
			return;
		}
		if(fre_type_dz == null || fre_type_dz == ''){
			$.messager.alert('提示','请选择报表类型');
			return;
		}
	var filesstring="";
		
	for(var i=0;i<files.length;i++){
		filesstring+=files[i]+";";
	}
		$.ajax({
			url:'<%=cp%>/tgyw/uploadtgfiles',
			type:'post',
			data:formData,
			 async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false, 
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("上传成功！");
					$('#tgfiles').val('');
				
					
					
				}else{
					alert("上传失败！");
				}
			}
		}); 
	
	 }
	
	function searchdata_wb(){
		$('#content1').html('');
		var fre_type_dz = $('#fre_type_dz').combobox('getValue');
		var tgmuban = $('#tgmuban').combobox('getValue');
		var wbmuban = $('#wbmuban').combobox('getValue');
		var files=  document.getElementById("wbfiles").files
		 var formData = new FormData($("#tgwb_hedui" )[0]); 
		if(files.length==0){
			$.messager.alert('提示','没有选择文件');
			return;
		}
		if(fre_type_dz == null || fre_type_dz == ''){
			$.messager.alert('提示','请选择报表类型');
			return;
		}
		if(tgmuban == null || tgmuban == ''){
			$.messager.alert('提示','请选择托管模板');
			return;
		}
		if(fre_type_dz == null || fre_type_dz == ''){
			$.messager.alert('提示','请选择外包模板');
			return;
		}
		
	var filesstring="";
		
	for(var i=0;i<files.length;i++){
		filesstring+=files[i]+";";
	}
		$.ajax({
			url:'<%=cp%>/tgyw/uploadwbfiles',
			type:'post',
			data:formData,
			 async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false, 
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("核对成功！");
					$('#wbfiles').val('');
					$('#content1').html(data.res);
				
				}else{
					alert("上传失败！");
				}
			}
		}); 
	
	 }

	
	  //数据结息查询
	 function searchFrequency(){
		  var type= $('#fre_type_s').combobox('getValue');
		  var guzhi= $('#guzhitype_s').combobox('getValue');
	      	$('#dg3').datagrid({method:'post',url:"<%=cp%>/tgyw/searchfrequency?mubantype="+type+'&guzhitype='+guzhi}); 
	 }

			 
</script>
<!-- 初始化操作 ,一般来讲初始化操作都是用来初始化表和用来绑定下拉列表框的-->
<script type="text/javascript">
$(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-20
	 });


	  $("#dg3").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-120
		 });
	  
	  $("#content1").load({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-180
		 });
	  
	  
	  
	  $("#fre_type_dz").combobox({
		  onChange:function(newvalue,oldvalue){
			  $("#tgmuban").combobox({
				  valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:'<%=cp%>/tgyw/getMubanName?guzhitype=1&reporttype='+newvalue,
	              method:'post',
				  multiple:false,
				  width:150, filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
				 onLoadSuccess: function(){
			     }
				  
			  });
			  $("#wbmuban").combobox({
				  valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:'<%=cp%>/tgyw/getMubanName?guzhitype=2&reporttype='+newvalue,
	              method:'post',
				  multiple:false,
				  width:150, filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
				 onLoadSuccess: function(){
			     }
				  
			  });
		  }
	  });
});
	
     
	


	function addFrequency(){
		$('#dlg_add').dialog('open');
	}
	
	function addFrequencyInfo(){
		var frequency = $("#fre_type").combobox('getValue');
		var email =$("#guzhi_type").textbox('getValue'); 
		var files=  document.getElementById("filesname").files
		 var formData = new FormData($("#uploadfile" )[0]); 
		if(files.length==0){
			$.messager.alert('提示','没有选择文件');
			return;
		}
		if(frequency == null || frequency == ''){
			$.messager.alert('提示','请选择报表类型');
			return;
		}
		if(email == null || email == ''){
			$.messager.alert('提示','请选择报表种类');
			return;
		}
	var filesstring="";
		
	for(var i=0;i<files.length;i++){
		filesstring+=files[i]+";";
	}
		$.ajax({
			url:'<%=cp%>/tgyw/addFrequencyInfo',
			type:'post',
			data:formData,
			 async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false, 
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("上传成功！");
					closeDialog();
					searchFrequency();
				}else{
					alert("上传失败！");
				}
			}
		}); 
	}
	
	function modifyFreqency(){
		if($("input[name='fck']:checked").length!=1){
			$.messager.alert('提示','请选择一条记录');
			return false;
		}else{
			var row = $('#dg3').datagrid('getSelected');
			$('#muban_id').val(row.id);
			$("#fre_type_edit").combobox('setText',row.reporttypename);
			$("#fre_type_edit").combobox('setValue',row.reporttype);
			$("#fre_type_edit").combobox('readonly',true);
			$("#guzhi_type_edit").combobox('setText',row.guzhitypename);
			$("#guzhi_type_edit").combobox('setValue',row.guzhitype);
			$("#guzhi_type_edit").combobox('readonly',true);
			$('#dlg_edit').dialog('open');
		}
	}
	
	function saveFrequencyInfo(){
		var id = $("#muban_id").val();
		var files=  document.getElementById("filesname_edit").files
		
		if(files.length!=1){
			$.messager.alert('提示','只能选择一个文件');
			return;
		}
		 var formData = new FormData($("#uploadfile_edit" )[0]); 
		
		$.ajax({
			url:'<%=cp%>/tgyw/modifyFrequencyInfo',
			type:'post',
			data:formData,
			 async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false,  
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					closeEditDialog();
					searchFrequency();
				}else{
						alert("保存失败！");
				}
			}
		});
	}
	function closeEditDialog(){
		$('#dlg_edit').dialog('close');
		$("#fre_type_edit").combobox('clear');
		$("#guzhi_type_edit").textbox('clear');
		$("#filesname_edit").val('');
		
	}
	function removeFreqency(){
		if($("input[name='fck']:checked").length==0){
			$.messager.alert('提示','请选择要删除的信息');
			return false;
		}else{
			$.messager.confirm('Confirm','确认要删除勾选内容?',function(r){
				if(r){
					var ids ="";
					var checkItems = $('#dg3').datagrid('getChecked');
					$.each(checkItems,function(index,item){
						ids += item.id;
						if((checkItems.length-1) != index)
							ids += ",";
					});
					$.ajax({
						url:'<%=cp%>/tgyw/removeFrequencyInfo',
						type : 'post',
						data : {
							ids : ids
						},
						dataType : "json",
						success : function(data) {
							searchFrequency();
						}
					})
				} else {
					return;
				}
			});
		}
	}
</script>

</head>
<body>
	<div id="tabsidk" class="easyui-tabs" style="">
		<div title="报表核对" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<form id="tgwb_hedui" style="" enctype="multipart/form-data">
					<span>报表类型:</span>
					<span><input id="fre_type_dz" name="fre_type_dz"
						class="easyui-combobox"
						data-options="url:'guzhidz/getCodeManage?dataType=excelmuban',
					valueField:'datacode',	textField:'datavalue',	panelHeight:'auto'"></span>
					<span>托管模板:</span>
					<span><input class="easyui-combobox" name="tgmuban"
						id="tgmuban" /> </span>
					<span>外包模板:</span>
					<span><input class="easyui-combobox" name="wbmuban"
						id="wbmuban" /> </span>
					</br>
					</br>
					<span>托管文件(全量)：</span>
					<span><input type="file" id="tgfiles" name="tgfiles"
						multiple="multiple" /> <a href="javascript:void(0);"
						class="easyui-linkbutton" data-options="iconCls:'icon-search'"
						onclick="searchdata_tg()">上传托管文件</a> </span>
					</br>
					<span>外包文件：</span>
					<span><input type="file" id="wbfiles" name="wbfiles"
						multiple="multiple" /></span>
					<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata_wb()">上传外包文件并核对</a>
				</form>
				<div id="content1"
					style="margin-left: 20px; overflow: auto; height: 400px"></div>
			</div>





		</div>

		<div title="模板配置" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<span style="margin-left: 20px">报表类型:</span> <span> <input
					id="fre_type_s" name="fre_type_s" class="easyui-combobox"
					data-options="url:'guzhidz/getCodeManage?dataType=excelmuban',
					valueField:'datacode',
					textField:'datavalue',
					panelHeight:'auto'
			"></span>
				<span style="margin-left: 20px">报表组:</span> <span> <input
					id="guzhitype_s" name="guzhitype_s" class="easyui-combobox"
					style="width: 60px"
					data-options="url:'guzhidz/getCodeManage?dataType=grouptype',
					valueField:'datacode',
					textField:'datavalue',
					panelHeight:'auto'
			"></span>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-search'" onclick="searchFrequency()">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-add'" onclick="addFrequency()">新增</a> <a
					href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit'" onclick="modifyFreqency()">修改</a>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove'" onclick="removeFreqency()">删除</a>
				<br />
			</div>
			<div style="margin-top: 10px;">
				<table id="dg3" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<th data-options="field:'fck',checkbox:true"></th>
							<th field="id" hidden=true></th>
							<th field="mubanpath" hidden=true></th>
							<th field="guzhitype" hidden=true></th>
							<th field="reporttypename"">报表类型</th>
							<th field="guzhitypename">报表组</th>
							<th field="muban">模板名称</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>




	</div>
	<div id="dlg_add" class="easyui-dialog" closed="true" title="添加模板信息"
	
		style="width: 450px; height: 230px; padding: 10px;"
		data-options="
							iconCls: 'icon-save',
							buttons: '#dlg-buttons_add'
				">
		<form id="uploadfile" style="float: left"
			enctype="multipart/form-data">
			<span style="margin-left: 20px">报表类型:</span>
			<span> <input id="fre_type" style="width: 150px"
				name="fre_type" class="easyui-combobox"
				data-options="url:'guzhidz/getCodeManage?dataType=excelmuban',
						valueField:'datacode',
						textField:'datavalue',
						panelHeight:'auto'
				"></span>
			<span style="margin-left: 20px">报表组:</span>
			<span> <input id="guzhi_type" name="guzhi_type"	class="easyui-combobox" style="width: 60px"
				data-options="url:'guzhidz/getCodeManage?dataType=grouptype',
						valueField:'datacode',
						textField:'datavalue',
						panelHeight:'auto'
				"></span>
			<br />
			<br />
			<span> 选择模板：<input type="file" id="filesname"
				name="updateFiles" multiple="multiple" />

				<p></p>
		</form>
		</span>
	</div>
	<div id="dlg-buttons_add">
		<a href="javascript:void(0)" class="easyui-linkbutton"	onclick="addFrequencyInfo()">上传</a>
		 <a href="javascript:void(0)"class="easyui-linkbutton" onclick="closeDialog()">取消</a>
	</div>

	<div id="dlg_edit" class="easyui-dialog" closed="true" title="编辑模板信息"
		style="width: 450px; height: 230px; padding: 10px;"
		data-options="
							iconCls: 'icon-save',
							buttons: '#dlg-buttons_edit'
				">
		<form id="uploadfile_edit" style="float: left"
			enctype="multipart/form-data">
			<input type="hidden" id="muban_id" name="muban_id" value="" />
			<span style="margin-left: 20px">报表类型:</span>
			<span> <input id="fre_type_edit" style="width: 150px"
				name="fre_type_edit" class="easyui-combobox"
				data-options=" url:'guzhidz/getCodeManage?dataType=excelmuban',
						valueField:'datacode',
						textField:'datavalue',
						panelHeight:'auto'
				"></span>
			<span style="margin-left: 20px">报表组:</span>
			<span> <input id="guzhi_type_edit" name="guzhi_type_edit"
				class="easyui-combobox" style="width: 60px"
				data-options=" url:'guzhidz/getCodeManage?dataType=grouptype',
						valueField:'datacode',
						textField:'datavalue',
						panelHeight:'auto'
				"></span>
			<br />
			<br />
			<span> 选择模板：<input type="file" id="filesname_edit" name="updateFiles_edit" multiple="multiple" />

				<p></p>
		</form>

	</div>
	<div id="dlg-buttons_edit">
		<a href="javascript:void(0)" class="easyui-linkbutton"onclick="saveFrequencyInfo()">保存</a>
		 <a href="javascript:void(0)"class="easyui-linkbutton" onclick="closeEditDialog()">取消</a>
	</div>




</body>
</html>