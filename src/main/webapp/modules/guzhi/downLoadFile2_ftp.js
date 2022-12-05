$(function() {
	// 初始化table
	$("#ftpdgs").datagrid({
		width : '100%',
		height : 390
	});
	ftpsearchdata();

});

function trim(str) { // 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function ftpsearchdata() {
	var params = "value=" + $("#ftpname").textbox('getValue') + "&remark=ftp";
	;
	$('#ftpdgs').datagrid({
		method : 'get',
		url : "guzhisas/queryConfigInfolist?" + params
	}).datagrid('clientPaging');
}

// zttype userInfo1
function ftpadddata() {
	if ($("#ftps").textbox('getValue') == ""
			|| $("#ftpvalue").textbox('getValue') == "") {
		alert("请填写配置文件的名称和配置文件的值！");
		return false;
	} else {

		var username = $("#ftps").textbox('getValue');
		var ftppwd = $("#ftpvalue").textbox('getValue');
		var name = 'ftp';
		var value = $("#ftpaddr").textbox('getValue');
		var remark = 'FTP';

		$.ajax({
			type : "POST",
			url : "guzhisas/insertConfigInfoList",
			data : {
				username : username,
				password : ftppwd,
				name : name,
				value : value,
				remark : remark
			},
			dataType : "json",
			success : function(data) {
				if (data.msg == "success") {
					alert("操作成功");
					ftpcloseDialog();
					ftpsearchdata();
				} else {
					alert("操作失败");
					ftpcloseDialog();
				}
			},
			error : function() {
				alert("系统异常，操作失败");
			}
		});
	}
}

function ftpremovedata() {
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(2).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择要删除的数据");
		return false;
	} else {
		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(2)
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
						ftpsearchdata();
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

function ftpeditdata() {
	var obj = $("div[class='tabs-panels']").find("div[class='panel']").eq(2)
			.find("input[name='ck']:checked");

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(2).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	} else {
		var ftpip = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(2).find("input[name='ck']:checked").closest("tr").find(
						"td[field='value']");
		var ftpname = $("div[class='tabs-panels']").find("div[class='panel']")
		.eq(2).find("input[name='ck']:checked").closest("tr").find(
		"td[field='username']");
		var ftppwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(2).find("input[name='ck']:checked").closest("tr").find(
						"td[field='password']");
		
		ftpip.find("div").html(
				"<input type='text' value='" + ftpip.find("div").text()
						+ "'></input>");

		ftpname.find("div").html(
				"<input type='text' value='" + ftpname.find("div").text()
						+ "'></input>");
		ftppwd.find("div").html(
				"<input type='text' value='" + ftppwd.find("div").text()
						+ "'></input>");

		$("div[class='tabs-panels']").find("div[class='panel']").eq(2).find(
				"table[class='datagrid-htable']").find("td[field='ck']").find(
				"input").prop("disabled", true);

		$("div[class='tabs-panels']").find("div[class='panel']").eq(2).find(
				"input[name='ck']").prop("disabled", true);
	}
}

function ftpsavedata() {
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(2).find(
			"input[name='ck']:checked").length == 1) {

		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(2)
				.find("input[name='ck']:checked").val();

		var ftpip = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(2).find("input[name='ck']:checked").closest("tr").find(
						"td[field='value']").find("input").val();
		var ftpname = $("div[class='tabs-panels']").find("div[class='panel']")
		.eq(2).find("input[name='ck']:checked").closest("tr").find(
		"td[field='username']").find("input").val();

		var ftppwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(2).find("input[name='ck']:checked").closest("tr").find(
						"td[field='password']").find("input").val();

		if (ftpname == "" || ftpip == "") {
			alert("配置文件的值不能为空！");
			return false;
		} else if (typeof (ftppwd) == "undefined") {
			alert("请点击修改按钮！");
			return false;
		} else {
			$.ajax({
				type : "POST",
				url : "guzhisas/updateftpconfiglist",
				data : {
					ID : id,
					username : ftpname,
					password : ftppwd,
					ftpip : ftpip
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("修改成功");
						ftpsearchdata();
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

function ftpcloseDialog() {
	$('#ftps').textbox('clear');
	$('#ftpvalue').textbox('clear');
	// $('#otherlogo').textbox('clear');
	$('#ftpdlg').dialog('close');
}
