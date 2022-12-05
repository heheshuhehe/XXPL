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
   	var params="user_name="+$("#user_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
	$('#dg').datagrid({method:'get',url:"<%=cp%>/guzhidz/getGuzhiUserInfo?"+params}).datagrid('clientPaging'); 
	
}


function addGuzhiUserInfo(){
	//var str=/^[A-Za-z0-9]+$/;  //数字和字母
	var str=/^[\d|A-z|\u4E00-\u9FFF]+$/;   //数字，字母和中文
	var user_id=$("#user_id").textbox('getValue');
	var username=$("#username1").textbox('getValue');
	var IP=$("#IP").textbox('getValue');
	var phone=$("#phone").textbox('getValue');
	var email=$("#email").textbox('getValue');
	var grouptype=$("#groupType1").combobox('getValue');
	if(!str.test(user_id)||user_id==""){
		alert("请输入数字,字母或中文的用户ID");
		return false;
	}else if(username==""){
		alert("请输入用户名称");
		return false;
	}else if(IP==""){
		alert("请输入IP");
		return false;
	}else if(phone==""){
		alert("请输入手机号码");
		return false;
	}else if(email==""){
		alert("请输入邮箱");
		return false;
	}else if(grouptype=="0"){
		alert("请选择用户类型");
		return false;
	}else{
		$.ajax({
			url:'<%=cp%>/guzhidz/addGuzhiUserInfo',
			type:'post',
			data:{user_id:user_id,username:username,IP:IP,phone:phone,email:email,grouptype:grouptype},
			dataType: "text",
			success: function(data){
				if(data=="2"){
					alert("用户名已存在！");
					return false;
				}else if(data==3){
					alert("验证错误，出现异常！");
					return false;
				}
					alert("保存成功");
					$('#dlg').dialog('close');
					searchdata();
					closeDialog();
			}
		});
	}
}


function closeDialog(){
	$('#user_id').textbox('clear');
	$('#username1').textbox('clear');
	$('#IP').textbox('clear');
	$('#phone').textbox('clear');
	$('#email').textbox('clear');
	$('#dlg').dialog('close');
}

function updateInfo(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var username = $("input[name='ck']:checked").closest("tr").find("td[field='username']");
		var ip = $("input[name='ck']:checked").closest("tr").find("td[field='ip']");
		var phone = $("input[name='ck']:checked").closest("tr").find("td[field='phone']");
		var email = $("input[name='ck']:checked").closest("tr").find("td[field='email']");
		var grouptype = $("input[name='ck']:checked").closest("tr").find("td[field='grouptype']");
		username.find("div").html("<input type='text' value='"+username.find("div").text()+"'></input>");
		ip.find("div").html("<input type='text' value='"+ip.find("div").text()+"'></input>");
		phone.find("div").html("<input type='text' value='"+phone.find("div").text()+"'></input>");
		email.find("div").html("<input type='text' value='"+email.find("div").text()+"'></input>");
		var str = grouptype.find("div").text();
		grouptype.find("div").html("<select><option value='1'>托管</option><option value='2'>外包</option></select>");
		if(str=="托管"){
			grouptype.find("div").find("select").val("1");
		}else{
			grouptype.find("div").find("select").val("2");
		}
		
		
		$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
		$("input[name='ck']").prop("disabled",true);
	}
}


function saveInfo(){
	var userId = $("input[name='ck']:checked").closest("tr").find("td[field='userid']").text();
	var username = $("input[name='ck']:checked").closest("tr").find("td[field='username']").find("input").val();
	var ip = $("input[name='ck']:checked").closest("tr").find("td[field='ip']").find("input").val();
	var phone = $("input[name='ck']:checked").closest("tr").find("td[field='phone']").find("input").val();
	var email = $("input[name='ck']:checked").closest("tr").find("td[field='email']").find("input").val();
	var grouptype = $("input[name='ck']:checked").closest("tr").find("td[field='grouptype']").find("select").val();
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条要修改的记录！");
		return false;
	}else if(typeof(username)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}
	else{
		$.ajax({
			url:'<%=cp%>/guzhidz/updateGuzhiUserInfo',
			type:'post',
			data:{userId:userId,username:username,ip:ip,phone:phone,email:email,grouptype:grouptype},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功");
					searchdata();
				}else{
					alert("保存失败");
				}
			}
		});
	}
}


</script>
<body>
<div id="tabsidk">
	<div title="估值人员信息" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>用户名称:</span> 
			<input class="easyui-combobox" name="user_name" id="user_name"
				       data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectVal?selectType=queryUserInfo',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											}
									 ">
		   <span>用户类型:</span>
		   <select id="groupType" class="easyui-combobox" name="groupType" style="width:150px;">
					<option value="">--请选择--</option>
					<option value="1">托管</option>
					<option value="2">外包</option>
			</select>	
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">添加</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="updateInfo()">修改</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveInfo()">保存</a> 
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" 
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="userid" width="80">用户ID</th>
						<th field="username" width="80">用户名称</th>
						<th field="ip" width="120">IP</th>
						<th field="phone" width="100">手机号码</th>
						<th field="email" width="100">邮箱</th>
						<th field="grouptype" width="80">用户类型</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" closed="true" title="添加估值人员信息"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="
				iconCls: 'icon-save',
				buttons: '#dlg-buttons'
			">
	<span style="margin-left: 20px">用户ID:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="user_id" name="user_id" />
	</span> 
	<span style="margin-left: 20px">用户名称:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="username1" name="username1">
	</span>
	<br/><br/>
	<span style="margin-left: 22px">用户IP:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="IP" name="IP" />
	</span>
	<span style="margin-left: 20px">手机号码:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="phone" name="phone">
	</span>
	<br/><br/>
	<span style="margin-left: 18px">&nbsp;邮箱:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="email" name="email" />
	</span> 
	
	<span style="margin-left: 20px">用户类型:</span> 
	<span>
		<select id="groupType1" class="easyui-combobox" name="groupType1" style="width: 100px;">
			<option value="0">--请选择--</option>								
			<option value="1">托管</option>
			<option value="2">外包</option>
		</select>
	</span>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton"
		onclick="addGuzhiUserInfo()">保存</a> <a href="javascript:void(0)"
		class="easyui-linkbutton"
		onclick="closeDialog()">取消</a>
</div>

</body>




