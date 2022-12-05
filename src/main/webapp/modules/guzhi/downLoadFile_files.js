$(function() {
	$("#tabsidk").tabs({
	 	 width : '100%',
    	 height : 480
	 });
	// 初始化table
	$("#filedgs").datagrid({
		width : '100%',
		height : 390,
		remoteSort:false,
		multiSort:true,
		singleSelect:true,
		collapsible:true
	});
	$("#filelogo").combobox({
		valueField : 'value',
		textField : 'text',
		mode : 'local',
		multiple : false,
		width : 150,
		data : [ {
			value : '01',
			text : '邮箱'
		}, {
			value : '02',
			text : 'FTP'
		} ],
		filter : function(q, row) {
			var opts = $(this).combobox('options');
			return row[opts.textField].indexOf(q) == 0;
		}
	})

	$("#filevalue").combobox({
		valueField : 'value',
		textField : 'text',
		mode : 'local',
		multiple : false,
		width : 150,
		data : [ {
			value : '01',
			text : '邮箱'
		}, {
			value : '02',
			text : 'FTP'
		} ],
		filter : function(q, row) {
			var opts = $(this).combobox('options');
			return row[opts.textField].indexOf(q) == 0;
		}
	})

	filesearchdata();

});

function trim(str) { // 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function filesearchdata() {
	var params = "filename=" + $("#filename").textbox('getValue') + "&remark="
			+ $("#filelogo").combobox('getValue');
	$('#filedgs').datagrid({
		method : 'get',
		url : "guzhisas/queryXXZWJ?" + params
	}).datagrid('clientPaging');
}

function fileadddata() {
	if ($("#files").textbox('getValue') == ""
			|| $("#filevalue").combobox('getValue') == "") {
		alert("请填写文件名称和w文件标识！");
		return false;
	} else {
		var filename = $("#files").textbox('getValue');
		var filepwd = $("#filevalue").combobox('getValue');

		$.ajax({
			type : "POST",
			url : "guzhisas/andGuZhiServiceSystemInfo",
			data : {
				filename : filename,
				remark : filepwd
			},
			dataType : "json",
			success : function(data) {
				if (data.msg == "success") {
					alert("操作成功");
					filecloseDialog();
					filesearchdata();
				} else {
					alert("操作失败");
					filecloseDialog();
				}
			},
			error : function() {
				alert("系统异常，操作失败");
			}
		});
	}
}

function fileremovedata() {
	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择要删除的数据");
		return false;
	} else {
		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(0)
				.find("input[name='ck']:checked").val();
		if (id == -1) {
			alert("此条数据为自动匹配数据，不需删除");
			return false;
		} else {
			$.ajax({
				type : "POST",
				url : "guzhisas/deleteGuZhiServiceSystemInfo",
				data : {
					ID : id
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("删除成功");
						filesearchdata();
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

function fileeditdata() {

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	} else {

		var filename = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").find(
						"td[field='filename']");
		var filepwd = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").closest(
						"tr").find("td[field='remark']");
		
		var fileusing = $("div[class='tabs-panels']").find("div[class='panel']")
		.eq(0).find("input[name='ck']:checked").closest("tr").closest(
		"tr").find("td[field='isusing']");
		

		filename.find("div").html(
				"<input type='text' value='" + filename.find("div").text()
						+ "'></input>");
		
		var fileusing_1 = fileusing.find("div").text();
		
		if (fileusing_1 == "启用"){
			fileusing.find("div").html(
			"<select id='selector'><option value='01' selected>启用</option><option value='02'>未启用</option></select>");
		} else if (fileusing_1 == "未启用"){
			fileusing.find("div").html(
			"<select id='selector'><option value='01'>启用</option><option value='02' selected>未启用</option></select>");
		} else {
			fileusing.find("div").html(
			"<select id='selector'><option value='01'>启用</option><option value='02'>未启用</option></select>");
		}
		
		$("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
				"itable[class='datagrid-htable']").find("td[field='ck']").find(
				"input").prop("disabled", true);

		$("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
				"input[name='ck']").prop("disabled", true);

	}
}

function filesavedata() {

	/*if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
		"input[name='ck']:checked").length != 1) {
		alert("请选择要修改数据");
		return false;
	}*/
	var obj = $("div[class='tabs-panels']").find("div[class='panel']").eq(0)
			.find("input[name='ck']:checked");

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length == 1) {

		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(0)
				.find("input[name='ck']:checked").val();

		var filename = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").find(
						"td[field='filename']").find("input").val();
		
		var fileusing = $("#selector").val();
		
		if (typeof (filename) == "undefined"){
			alert("请点击修改按钮！");
			return false;
		}
		
		if (filename == "" ||  filename.trim() == "") {
			alert("文件名不能为空！");
			return false;
		} else {
			$.ajax({
				type : "POST",
				url : "guzhisas/updateGuZhiServiceSystemInfo",
				data : {
					ID : id,
					filename : filename,
					fileusing : fileusing
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("修改成功");
						filesearchdata();
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

function filecloseDialog() {
	$('#files').textbox('clear');
	$('#filevalue').combobox('clear');
	// $('#otherlogo').textbox('clear');
	$('#filedlg').dialog('close');
}
