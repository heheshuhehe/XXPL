$(function() {
	// 初始化table
	$("#otherdgs").datagrid({
		width : '100%',
		height : 390
	});
	searchdatas();

});

function trim(str) { // 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function searchdatas() {
	var params="remark=other&remark2="+$("#othername").textbox('getValue')+"&value="+$("#othervalue").textbox('getValue');

	$('#otherdgs').datagrid({
		method : 'get',
		url : "guzhisas/queryConfigInfolist?" + params
	}).datagrid('clientPaging');
}

// zttype userInfo1
function adddatas() {
	debugger;
	if ($("#otherlogo").textbox('getValue') == ""
			|| $("#othvalue").textbox('getValue') == "") {
		alert("请填写配置文件说明和配置文件的值！");
		return false;
	} else {
		debugger;
		var username = '0';
		var password = '0';
		/*
		 * var key=$("#others").textbox('getValue');
		 */
		var name = 'other';

		var value = $("#othvalue").textbox('getValue');
		var remark = $("#otherlogo").textbox('getValue');

		$.ajax({
			type : "POST",
			url : "guzhisas/insertConfigInfoList",
			data : {
				username : username,
				password : password,
				name : name,
				value : value,
				remark : remark
			},
			dataType : "json",
			success : function(data) {
				if (data.msg == "success") {
					alert("操作成功");
					closeDialogs();
					searchdatas();
				} else {
					alert("操作失败");
					closeDialogs();
				}
			},
			error : function() {
				alert("系统异常，操作失败");
			}
		});
	}
}

function removedatas() {
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(4).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择要删除的数据");
		return false;
	} else {
		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(4)
				.find("input[name='ck']:checked").val();
		if (id == -1) {
			alert("此条数据为自动匹配数据，不需删除");
			return false;
		} else if (typeof (mailpwd) == "undefined") {
			alert("请点击修改按钮！");
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
						searchdatas();
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

function editdatas() {

	var obj = $("div[class='tabs-panels']").find("div[class='panel']").eq(4)
			.find("input[name='ck']:checked");

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(4).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	} else {

		var value = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(4).find("input[name='ck']:checked").closest("tr").find(
						"td[field='value']");


//		value.find("div").html(
//				"<input style='width: 980px; height: 140px;' type='text' value='" + value.find("div").text()
//						+ "'></input>");
		
		value.find("div").html(
				"<textarea id='area1' style='width: 810px; height: 150px;'>"+value.find("div").text()+"</textarea>");

		$("div[class='tabs-panels']").find("div[class='panel']").eq(3).find(
				"table[class='datagrid-htable']").find("td[field='ck']").find(
				"input").prop("disabled", true);

		$("div[class='tabs-panels']").find("div[class='panel']").eq(3).find(
				"input[name='ck']").prop("disabled", true);
	}
}

function savedatas() {
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(4).find(
			"input[name='ck']:checked").length == 1) {

		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(4)
				.find("input[name='ck']:checked").val();

//		var value = $("div[class='tabs-panels']").find("div[class='panel']")
//				.eq(4).find("input[name='ck']:checked").closest("tr").find(
//						"td[field='value']").find("input").val();
		var value = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(4).find("input[name='ck']:checked").closest("tr").find(
						"#area1").val();

		if (value == "") {
			alert("配置文件的值不能为空！");
			return false;
		}else if (typeof (value) == "undefined") {
			alert("请点击修改按钮！");
			return false;
		}   else {
			$.ajax({
				type : "POST",
				url : "guzhisas/updateotherconfiglist",
				data : {
					ID : id,
					value : value
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("修改成功");
						searchdatas();
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

function closeDialogs() {
	$('#others').textbox('clear');
	$('#othvalue').textbox('clear');
	$('#otherlogo').textbox('clear');
	$('#othersdlg').dialog('close');
}
