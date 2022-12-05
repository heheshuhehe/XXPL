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
	var name = $("#name").val();
	$('#dxpz').datagrid({url:"<%=cp%>/ziguan/getDXList?name="+name}).datagrid('clientPaging'); 
}
function p_adddata(){
	 id="";
	 $("#servicetype").combobox('clear');
	 $("#userinfo").combobox('clear');
	 $("#productname").textbox('setValue',"");
	 $('#vote').textbox('setValue',"");
	 $("#rq").datebox('setValue',"");
	 $("#viewinfo").textbox('setValue',"");
	  $("#remark").textbox('setValue',"");
	  $('#p_dlg_add').dialog('open');
}
function p_closeDialog(){
	 $("#servicetype").combobox('clear');
	 $("#userinfo").combobox('clear');
	 $("#productname").textbox('setValue',"");
	 $('#vote').textbox('setValue',"");
	 $("#rq").datebox('setValue',"");
	 $("#viewinfo").textbox('setValue',"");
	  $("#remark").textbox('setValue',"");
	  $('#p_dlg_add').dialog('close');
	  id="";
}
//删除数据
function p_removedata(){
	if($("input[name='ck']:checked").length==0){
		alert("请选择要删除的记录！");
		return false;
	}else{
		if(confirm("确定要删除吗？")){
			var ids = [];
			var checkItems = $('#dxpz').datagrid('getChecked');
			$.each(checkItems,function(index,item){
				ids.push(item.id);
			});
			if(ids!=""){
				$.ajax({
					url:'<%=cp%>/ziguan/deleteDXInfo',
					type : 'post',
					data : {ids : ids.toString()},
					dataType : "json",
					success : function(data) {
							alert("删除成功！");
							p_searchdata();
					}
				});
			}
		}
	}
}
//保存数据
function p_saveData(type){
	var servicetype = $("#servicetype").combobox("getValue");
	var userinfo = $("#userinfo").combobox("getValue");
	var productname = $("#productname").textbox('getValue');
	var vote = $("#vote").textbox('getValue');
	var rq = $("#rq").datebox('getValue');
	var viewinfo = $("#viewinfo").textbox('getValue');
	var remark = $("#remark").textbox('getValue');
	if(productname=="" ||productname==null){
		alert("请填写产品信息");
		return false;
	}else{
			$.ajax({
				url:'<%=cp%>/ziguan/saveDXInfo',
				type:'post',
				data:{id:id,servicetype:servicetype,userinfo:userinfo,productname:productname,vote:vote,rq:rq,viewinfo:viewinfo,remark:remark,type:type},
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
}
function p_editdata(){
 	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var row = $("#dxpz").datagrid('getSelected');
		$("#productname").textbox('setValue',row.productname);
		$("#rq").datebox('setValue',row.rq);
		$("#servicetype").combobox('setValue',row.servicetype);
		$("#vote").textbox('setValue',row.vote);
		$("#viewinfo").textbox('setValue',row.viewinfo);
		$("#remark").textbox('setValue',row.remark);
		$("#userinfo").combobox('setValue',row.userinfo);
		id = row.id;
		$('#p_dlg_add').dialog('open');
 	}
 }

</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
		 <div title="代销产品" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			    <span>名称: 
			    </span>
			    <input id="name" class="easyui-textbox"  style="line-height:26px;border:1px solid #ccc"/>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="p_searchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="p_adddata('insert')">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_removedata()">删除</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="p_editdata('modify')">修改</a> 
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="dxpz"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
						               ">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="id"  data-options="hidden:true"></th>
								<th field="productname" width="150" >产品名称</th>
								<th field="rq" width="100" >上会日期</th>
								<th field="vote" width="100" >表决票数</th>
								<th field="servicetype" width="50" >服务类型</th>
								<th field="userinfo" width="50" >参会人员</th>
								<th field="viewinfo" width="200" >意见</th>
								<th field="remark" width="150" >备注</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>

		</div>
		
         <!-- dialog弹出框 -->
         <div id="p_dlg_add" class="easyui-dialog" closed="true" title="添加"
			style="width: 370px; height: 450px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<div style="margin-bottom: 10px;">
				<span style="margin-left: 5px">产品名称:</span> 
				<span>
					<input class="easyui-textbox" name="name" id="productname" style="width: 200px;"></input>
				</span>
				<span style="color: red;">*</span><br/><br/>
				<span style="margin-left: 20px">时&nbsp&nbsp间:</span>
				<span>
					<input id="rq" name="rq" class="easyui-datebox" style="width: 150px"></input>
				</span><br/><br/>
				<span style="margin-left: 5px">表决票数:</span> 
				<span>
					<input class="easyui-textbox" name="vote" id="vote" style="width: 200px;"></input>
				</span><br/><br/>
				<span style="margin-left: 5px">服务类型:</span>
					  <select class="easyui-combobox" name="type" id="servicetype" >
					    	<option value="外包服务">外包服务</option>
					    	<option value="综合服务">综合服务</option>
					    	<option value="托管+外包">托管+外包</option>
					    	<option value="纯托管">纯托管</option>
					    	<option value="其它">其它</option>
					  </select> 
					  <br/><br/>
				<span style="margin-left: 5px">参会人员:</span>
					  <select class="easyui-combobox" name="user" id="userinfo" >
					    	<option value="刘加加">刘加加</option>
					    	<option value="方觉">方觉</option>
					    	<option value="李小璐">李小璐</option>
					    	<option value="祁宇科">祁宇科</option>
					    	<option value="杨菲">杨菲</option>
					    	<option value="杨帆">杨帆</option>
					    	<option value="温雯">温雯</option>
					  </select> 
					  <br/><br/>
				<span style="margin-left: 20px">意&nbsp&nbsp见:</span> 
				<span>
					<input class="easyui-textbox" name="view" id="viewinfo"  data-options="multiline:true" style="width: 250px;height:50px;"></input>
				</span>
				<br/><br/>
				<span style="margin-left: 20px">备&nbsp&nbsp注:</span> 
				<span>
					<input class="easyui-textbox name="remark" id="remark"  data-options="multiline:true" style="width: 250px;height:50px;"></input>
				</span>
			</div>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="p_saveData()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div>
 </body>
</html>





