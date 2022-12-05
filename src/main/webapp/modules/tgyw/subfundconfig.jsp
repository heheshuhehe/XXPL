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
	
	var tacode = $("#tacode").textbox('getValue');
	$('#dxpz').datagrid({url:'<%=cp%>/ziguan/subtacode?op=s&tacode='+tacode}).datagrid('clientPaging'); 
}
function p_adddata(){
	 $("#op").val('add');
	
	 
	 $('#tacode_p').textbox('setValue',"");
	 $("#tacode_s").textbox('setValue',"");
	 $("#tacode_accno").textbox('setValue',"");
	  $('#p_dlg_add').dialog('open');

}
function p_closeDialog(){

	  $('#p_dlg_add').dialog('close');

}
//删除数据
function p_removedata(){
	var row =$("#dxpz").datagrid('getSelected');
	if(row){
		$.messager.confirm('删除', '确定要删除这条数据吗？', function(r){
			if (r){
				 
				var id=row.ider;
				
				var op='del';
				$.ajax({
					url:'<%=cp%>/ziguan/subtacode',
					type:'post',
					data:{op:op,id:id},
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
	var id=$("#ider").val();
	var tacode_p = $("#tacode_p").textbox('getValue');
	var tacode_s =$("#tacode_s").textbox('getValue'); 
	var tacode_accno = $("#tacode_accno").textbox('getValue');

	$.ajax({
		url:'<%=cp%>/ziguan/subtacode',
		type:'post',
		data:{tacode_p:tacode_p,tacode_s:tacode_s,tacode_accno:tacode_accno,op:op,id:id},  

		dataType: "json",
		success: function(data){
			if(data[0].msg="success"){
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
 		 $("#ider").val(row.ider);

 		$('#tacode_p').textbox('setValue',row.tacode_p);
 		 $('#tacode_s').textbox('setValue',row.tacode_sub);
 		 $("#tacode_accno").textbox('setValue',row.tacode_sub_accno);

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
		 <div title="母子基金配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			   <span>母/子基金代码: 
			    </span>

			    <input id="tacode" name="tacode" class="easyui-textbox"  style="line-height:26px;border:1px solid #ccc"/>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="p_searchdata()">查询</a> 
			       
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="p_adddata('add')">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_removedata()">删除</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_editdata('modify')">查看/修改</a> 
			    </br> </br>
			    说明：1.母基金代码，投资标的在我司私募TA中的基金代码。2.子基金代码，投资者在估值系统中配置的资产代码。3.子基金基金账号，子基金在我司私募TA系统中开户的基金账号
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="dxpz"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
						               ">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="ider"  data-options="hidden:true"></th>
					
								<th field="tacode_p" width="100"  >母基金代码（被投资标的）</th>
								<th field="tacode_sub" width="100" >子基金代码（投资者）</th>
								<th field="tacode_sub_accno" width="150" >子基金（投资者）基金账号</th>
							 
								 
							</tr>
						</thead>
					</table>
				</div>
		 </div>

		</div>
		
         <!-- dialog弹出框 -->
         <div id="p_dlg_add" class="easyui-dialog" closed="true" title="添加"
			style="width: 430px; height: 350px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
					<form id="uploadfile" style="float: left"		enctype="multipart/form-data">
			<div style="margin-bottom: 10px;">
			<input   id="op"  name="op" type="text"  style="display: none" />
			<input   id="ider"  name="ider" type="text"  style="display: none" />
		
				<br/><br/>
				<span style="margin-left: 0px">母基金代码（被投资标的）:</span>
				<span>
					<input name="tacode_p" id="tacode_p" class="easyui-textbox" data-options=""  style="width:100px;">
				</span><br/><br/>
				<span style="margin-left: 0px">子基金代码（投资者）:</span> 
				<span>
					<input name="tacode_s" id="tacode_s" class="easyui-textbox" data-options=""  style="width:100px;">
			
					  <br/><br/>
				<span style="margin-left: 5px">子基金（投资者）基金账号</span>
						<input name="tacode_accno" id="tacode_accno" class="easyui-textbox" data-options=""  style="width:150;">
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





