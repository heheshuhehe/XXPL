<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>佣金</title>
    <script>document.documentElement.focus();</script>
    
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>
var id="";
$(function (){
		 $("#tabsidk").tabs({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-20
		 });
	 	 $("#dxpz").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-140
	 	 });

///////////////////////////////////请求配置项/////////////////////////////////////////
        p_searchdata();
      
      
});
</script>

<!-- 自定义js -->
<script type="text/javascript">
///////////////////////////////Ajax请求///////////////////////////////////////////////////
function p_searchdata(){
	var prodesc = $("#name").val();
	var protype = $("#protype").combobox('getValue');
	$('#dxpz').datagrid({url:'<%=cp%>/ziguan/getProtype?op=s&prodesc='+prodesc+'&protype='+protype}).datagrid('clientPaging'); 
}
function p_adddata(){
	 $("#op").val('add');
	 $("#s_protype").combobox('clear');
	 $("#userinfo").combobox('clear');
	 
	 $('#desc').textbox('setValue',"");
	 $("#solve").textbox('setValue',"");
	  $("#filesname").val('');
	  $('#p_dlg_add').dialog('open');

}
function p_closeDialog(){

	  $('#p_dlg_add').dialog('close');
	  id="";
}
//删除数据
function p_removedata(){
	var row =$("#dxpz").datagrid('getSelected');
	if(row){
		$.messager.confirm('删除', '确定要删除这条数据吗？', function(r){
			if (r){
				 
				var id=row.id;
				$("#id").val(row.id);
				$("#op").val('del');
				var formData = new FormData($("#uploadfile" )[0]); 
				$.ajax({
					url:'<%=cp%>/ziguan/getProtypeCZ?op=del',
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
							p_closeDialog();
							p_searchdata();
						}else{
							alert("保存失败！");
						}
					}
				}); 

				
				
			}
		});
	}else{
		
	}
}
//保存数据
function p_saveData(type){
	
	var op=$("#op").val();
	var s_protype = $("#s_protype").combobox('getValue');
	var userinfo =$("#userinfo").combobox('getValue'); 
	var desc = $("#desc").textbox('getValue');
	var solve = $("#solve").textbox('getValue');
	
	var files=  document.getElementById("filesname").files
	 var formData = new FormData($("#uploadfile" )[0]); 
	if(files.length==0){
		/* $.messager.alert('提示','没有选择文件');
		return; */
	}

var filesstring="";
	
for(var i=0;i<files.length;i++){
	filesstring+=files[i].name+";";
}
	$.ajax({
		url:'<%=cp%>/ziguan/getProtypeCZ?op='+op,
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
				p_closeDialog();
				p_searchdata();
			}else{
				alert("保存失败！");
			}
		}
	}); 

}

function p_editdata(){
	var row =$("#dxpz").datagrid('getSelected');
 	if(row ){
 		  $("#op").val('modify');
 		 $("#id").val(row.id);
 		 
 		 $("#s_protype").combobox('setValue',row.protype);
 		 $("#userinfo").combobox('select',row.userinfo);
 		 
 		 $('#desc').textbox('setValue',row.prodesc);
 		 $("#solve").textbox('setValue',row.solve);
 		  $("#filesname").val('');
 		  $('#p_dlg_add').dialog('open');
	}else{
		alert("请选择一条记录！");
		return false;
	}
 }
function p_export(){


	var url="<%=cp%>/ziguan/getProtype_ex?op=s"; 
	window.location.href=url;
 }
 
 
 

</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
		 <div title="知识库" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			   <span>问题类型: 
			    </span>
			    <input class="easyui-combobox" name="protype" id="protype"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option=where datatype=\'protype\' order by datacode desc',
		                          method:'post',
								  multiple:false,
								  width:100,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('protype').next('.combo').find('input').focus(function (){
									            $('protype').combobox('clear');
									 });
							     }
					  ">
			    <span>问题描述: 
			    </span>
			    <input id="name" class="easyui-textbox"  style="line-height:26px;border:1px solid #ccc"/>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="p_searchdata()">查询</a> 
			       
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="p_adddata('add')">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_removedata()">作废</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_editdata('modify')">查看/修改</a> 
			      <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_export('modify')">导出</a> 
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="dxpz"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
						               ">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="id"  data-options="hidden:true"></th>
								<th field="protype" width="80"  data-options="hidden:true">问题类型</th>
								<th field="protypename" width="80"  >问题类型</th>
								<th field="prodesc" width="300" >问题描述</th>
								<th field="solve" width="300" >解决方法</th>
								<th field="fname" width="200" data-options="hidden:true"  >附件</th>
									<th field="attach" width="200" >附件</th>
								<th field="userinfo" width="50" data-options="hidden:true">录入人</th>
								<th field="userinfoname" width="50"  >录入人</th>
								 
							</tr>
						</thead>
					</table>
				</div>
		 </div>

		</div>
		
         <!-- dialog弹出框 -->
         <div id="p_dlg_add" class="easyui-dialog" closed="true" title="添加"
			style="width: 530px; height: 650px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
					<form id="uploadfile" style="float: left"		enctype="multipart/form-data">
			<div style="margin-bottom: 10px;">
			<input   id="op"  name="op" type="text"  style="display: none" />
			<input   id="id"  name="id" type="text"  style="display: none" />
				<span style="margin-left: 5px">问题类型:</span> 
				<span>
					<input class="easyui-combobox" name="s_protype" id="s_protype"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option=where datatype=\'protype\' order by datacode desc',
		                          method:'post',
								  multiple:false,
								  width:100,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('s_protype').next('.combo').find('input').focus(function (){
									            $('s_protype').combobox('clear');
									 });
							     }
					  ">
				</span>
				<span style="color: red;">*</span>
				<span style="margin-left: 5px">录入人:</span>
					 <input class="easyui-combobox" name="userinfo" id="userinfo"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=guzhiuserinfo&code=id&name=username&option=where grouptype=1 order by id asc',
		                          method:'post',
								  multiple:false,
								  width:100,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('userinfo').next('.combo').find('input').focus(function (){
									            $('userinfo').combobox('clear');
									 });
							     }
					  ">
				
				<br/><br/>
				<span style="margin-left: 0px">问题描述:</span>
				<span>
					<input name="desc" id="desc" class="easyui-textbox" data-options="multiline:true"  style="width:400px;height:80px">
				</span><br/><br/>
				<span style="margin-left: 0px">解决方法:</span> 
				<span>
					<input name="solve" id="solve" class="easyui-textbox" data-options="multiline:true"  style="width:400px;height:350px">
			
					  <br/><br/>
				<span style="margin-left: 5px">附件:</span>
					  <input type="file" id="filesname"		name="filesname"    />
					  <br/><br/>
				
			</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="p_saveData()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div>
 </body>
</html>





