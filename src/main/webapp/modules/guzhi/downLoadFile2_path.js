$(function() {
	// 初始化table
	$("#pathdgs").datagrid({
		width : '100%',
		height : 390
	});
	pathsearchdata();

});

function trim(str) { // 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function pathsearchdata() {

	var params = "remark2=PATH";

	$('#pathdgs').datagrid({
		method : 'get',
		url : "guzhisas/queryConfigInfolist?" + params
	}).datagrid('clientPaging');
}

function patheditdata() {

	var obj = $("div[class='tabs-panels']").find("div[class='panel']").eq(3)
			.find("input[name='ck']:checked");

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(3).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	} else {
		var pathname = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(3).find("input[name='ck']:checked").closest("tr").find(
						"td[field='remark']");

		var pathpwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(3).find("input[name='ck']:checked").closest("tr").find(
						"td[field='value']");

		pathpwd.find("div").html(
				"<input type='text' value='" + pathpwd.find("div").text()
						+ "'></input>");

		$("div[class='tabs-panels']").find("div[class='panel']").eq(3).find(
				"table[class='datagrid-htable']").find("td[field='ck']").find(
				"input").prop("disabled", true);

		$("div[class='tabs-panels']").find("div[class='panel']").eq(3).find(
				"input[name='ck']").prop("disabled", true);
	}
}

function pathsavedata() {
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(3).find(
			"input[name='ck']:checked").length == 1) {

		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(3)
				.find("input[name='ck']:checked").val();

		var pathpwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(3).find("input[name='ck']:checked").closest("tr").find(
						"td[field='value']").find("input").val();

		if (pathpwd == "") {
			alert("路径不能为空！");
			return false;
		} else if (typeof (pathpwd) == "undefined") {
			alert("请点击修改按钮！");
			return false;
		} else {
			$.ajax({
				type : "POST",
				url : "guzhisas/updatepathconfiglist",
				data : {
					ID : id,
					value : pathpwd
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("修改成功");
						pathsearchdata();
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

function pathcloseDialog() {
	$('#paths').textbox('clear');
	$('#pathvalue').textbox('clear');
	// $('#otherlogo').textbox('clear');
	$('#pathdlg').dialog('close');
}
