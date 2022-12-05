$(function() {
	// 初始化table
	$("#maildgs").datagrid({
		width : '100%',
		height : 390
	});
	mailsearchdata();

});

function trim(str) { // 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function mailsearchdata() {
	var params = "filename=" + $("#mailname").textbox('getValue')
			+ "&remark=email";
	$('#maildgs').datagrid({
		method : 'get',
		url : "guzhisas/queryConfigInfolist?" + params
	}).datagrid('clientPaging');
}

// zttype userInfo1
function mailadddata() {
	if ($("#mails").textbox('getValue') == ""
			|| $("#mailvalue").textbox('getValue') == "") {
		alert("请填写配置文件的名称和配置文件的值！");
		return false;
	} else {
		var username = $("#mails").textbox('getValue');
		var mailpwd = $("#mailvalue").textbox('getValue');
		var name = 'email';
		var value = '0';
		var remark = '邮箱';

		$.ajax({
			type : "POST",
			url : "guzhisas/insertConfigInfoList",
			data : {
				username : username,
				password : mailpwd,
				name : name,
				value : value,
				remark : remark
			},
			dataType : "json",
			success : function(data) {
				if (data.msg == "success") {
					alert("操作成功");
					mailcloseDialog();
					mailsearchdata();
				} else {
					alert("操作失败");
					mailcloseDialog();
				}
			},
			error : function() {
				alert("系统异常，操作失败");
			}
		});
	}
}

function mailremovedata() {
	
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(1).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择要删除的数据");
		return false;
	} else {
		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(1)
				.find("input[name='ck']:checked").val();
		if (id == -1) {
			alert("此条数据为自动匹配数据，不需删除");
			return false;
		} else {
			$.ajax({
				type : "POST",
				url : "guzhisas/deleteconfiglist",
				data : {
					ID : id
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("删除成功");
						mailsearchdata();
					} else {
						alert("删除失败");
					}
				},
				error : function() {
					alert("系统异常，删除失败");
				}
			});
		}
	}
}

function maileditdata() {
	
	var obj = $("div[class='tabs-panels']").find("div[class='panel']").eq(1)
			.find("input[name='ck']:checked");

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(1).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	} else {
		var mailname = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(1).find("input[name='ck']:checked").closest("tr").find(
						"td[field='username']");
		var mailpwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(1).find("input[name='ck']:checked").closest("tr").find(
						"td[field='password']");

		mailname.find("div").html(
				"<input type='text' value='" + mailname.find("div").text()
						+ "'></input>");
		mailpwd.find("div").html(
				"<input type='text' value='" + mailpwd.find("div").text()
						+ "'></input>");

		$("div[class='tabs-panels']").find("div[class='panel']").eq(1).find(
				"table[class='datagrid-htable']").find("td[field='ck']").find(
				"input").prop("disabled", true);

		$("div[class='tabs-panels']").find("div[class='panel']").eq(1).find(
				"input[name='ck']").prop("disabled", true);

	}
}


function mailsavedata() {
	
/*	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
	"input[name='ck']:checked").length != 1) {
	alert("请选择要修改数据");
	return false;
	}*/
		
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(1).find(
			"input[name='ck']:checked").length == 1) {

		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(1)
				.find("input[name='ck']:checked").val();

		var mailname = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(1).find("input[name='ck']:checked").closest("tr").find(
						"td[field='username']").find("input").val();
		
		var mailpwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(1).find("input[name='ck']:checked").closest("tr").find(
						"td[field='password']").find("input").val();
		
		if (typeof (mailname) == "undefined"){
			alert("请点击修改按钮！");
			return false;
		}
		if (mailname == "" || mailname.trim() == "" || mailpwd == "" || mailpwd.trim() == "") {
			alert("账号密码不能为空！");
			return false;
		} else {
			$.ajax({
				type : "POST",
				url : "guzhisas/updatemailconfiglist",
				data : {
					ID : id,
					username : mailname,
					password : mailpwd
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("修改成功");
						mailsearchdata();
					} else {
						alert("修改失败");
					}
				},
				error : function() {
					alert("系统异常，修改失败");
				}
			});
		}
	}
}

function mailcloseDialog() {
	$('#mails').textbox('clear');
	$('#mailvalue').textbox('clear');
	// $('#otherlogo').textbox('clear');
	$('#maildlg').dialog('close');
}
