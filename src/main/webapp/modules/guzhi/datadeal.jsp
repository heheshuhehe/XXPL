<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="resoures.jsp"%>
<base href="<%=basePath%>" />
<script>document.documentElement.focus();</script>

<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>估值人员账套对应关系配置</title>
</head>
<!-- 初始化操作 -->



<script type="text/javascript">
	//得到当前日期
	formatterDate = function(date) {
		var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
		var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
				+ (date.getMonth() + 1);
		return date.getFullYear() + '-' + month + '-' + day;
	};

	$(function() {
		var curr_time = new Date();
		var strDate = curr_time.getFullYear() + "-";
		strDate += curr_time.getMonth() + 1 + "-";
		strDate += curr_time.getDate() + "-";
		strDate += curr_time.getHours() + ":";
		strDate += curr_time.getMinutes() + ":";

		var strDate1 = curr_time.getFullYear() + "-";
		strDate1 += curr_time.getMonth() + 1 + "-";
		strDate1 += curr_time.getDate() - 1 + "-";
		strDate1 += curr_time.getHours() + ":";
		strDate1 += curr_time.getMinutes() + ":";

		$("#mailsdate").datetimebox({
			value : strDate1 + " 12:00",
			required : true,
			showSeconds : false
		});

		$("#mailedate").datetimebox({
			value : strDate + " 12:00",
			required : true,
			showSeconds : false
		});

	});

	window.onload = function() {
		$('#newdate1').datebox('setValue', formatterDate(new Date()));
		$('#newdate').datebox('setValue', formatterDate(new Date()));
	}
</script>

<script type="text/javascript">
	function clearA() {
		var newdate = $("#newdate").datebox('getValue');

		if (newdate == null || newdate == "") {

			alert("请选择处理日期！");

			return;
		}

		var params = "newdate=" + newdate;

		$.ajax({
			type : 'POST',
			url : 'guzhisas/clear?' + params,
			dataType : 'json',
			beforeSend : function() {
				load("初始化中");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				alert("初始化完成");
				searchdata();
			}
		});
	}
	function maildownload() {

		var sdate = $("#mailsdate").datebox("getValue");

		var edate = $("#mailedate").datebox("getValue");

		var newdate = $("#newdate").datebox('getValue');

		var a = new Date(sdate.replace(/\-/g, "\/"));
		var b = new Date(edate.replace(/\-/g, "\/"));

		if (sdate != "" && edate != "" && a >= b) {
			alert("开始时间不能大于结束时间！");
			return;
		}

		if (newdate == null || newdate == "") {

			alert("请选择处理日期！");

			return;
		}

		var params = "newdate=" + newdate + "&sdate=" + sdate + "&edate="
				+ edate;

		$.ajax({
			type : 'POST',
			url : 'guzhisas/maildownload?' + params,
			dataType : 'json',
			beforeSend : function() {
				load("邮件正在下载中");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				if (data.msg == "success") {
					alert("邮箱下载完成！");
				} else {
					alert(data.msg);
				}
				searchdata();
			},error : function() {
				alert("系统异常，请检查邮箱配置是否正确！");
			}

		});
	}

	function ftpdownload() {

		var newdate = $("#newdate").datebox('getValue');

		if (newdate == null || newdate == "") {

			alert("请选择处理日期！");

			return;
		}

		var params = "newdate=" + newdate;

		$.ajax({
			type : 'POST',
			url : 'guzhisas/ftpdownload?' + params,
			dataType : 'json',
			beforeSend : function() {
				load("FTP正在下载中");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				
				disLoad();
				if (data.msg == "success") {
					alert("FTP下载完成！");
				} else {
					alert(data.msg);
				}
				searchdata();
			},error : function() {
				alert("系统异常，请检查FTP配置是否正确！");
			}
		});

	}

	function unzip() {

		var newdate1 = $("#newdate1").datebox('getValue');

		if (newdate1 == null || newdate1 == "") {

			alert("请选择处理日期！");

			return;
		}

		var params = "newdate1=" + newdate1;

		$.ajax({
			type : 'POST',
			url : 'guzhisas/fileUnzip?' + params,
			dataType : 'json',
			beforeSend : function() {
				load("正在解压缩文件");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				if (data.msg == "success") {
					alert("文件解压缩完成");
				} else {
					alert(data.msg);
				}
			}
		});

	}
	function filemerge() {

		var newdate1 = $("#newdate1").datebox('getValue');

		if (newdate1 == null || newdate1 == "") {

			alert("请选择处理日期！");

			return;
		}

		var params = "newdate1=" + newdate1;
		$.ajax({
			type : 'POST',
			url : 'guzhisas/filemerge?' + params,
			dataType : 'json',
			beforeSend : function() {
				load("正在清洗文件");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				if (data.msg == "success") {
					alert("文件清洗完成");
				} else {
					alert(data.msg);
				}
			}
		});
	}
	//弹出加载层
	function load(msg) {
		$("<div class=\"datagrid-mask\"></div>").css({
			display : "block",
			width : "100%",
			height : $(window).height()
		}).appendTo("body");
		$("<div class=\"datagrid-mask-msg\"></div>").html(msg + "，请稍候。。。")
				.appendTo("body").css({
					display : "block",
					left : ($(document.body).outerWidth(true) - 190) / 2,
					top : ($(window).height() - 45) / 2
				});
	}
	//取消加载层  
	function disLoad() {
		$(".datagrid-mask").remove();
		$(".datagrid-mask-msg").remove();
	}

	$(function() {
		$("#tabsidk").tabs({
			width : '100%',
			height : 520
		});
		//初始化table
		$("#dg").datagrid({
			width : '100%',
			//height : document.documentElement.clientHeight - 80
			height : 390
		});
		$("#userInfo1").combobox({
			valueField : 'value',
			textField : 'text',
			mode : 'local',
			multiple : false,
			width : 150,
			data : [{
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

		$("#userInfo2").combobox({
			valueField : 'value',
			textField : 'text',
			mode : 'local',
			multiple : false,
			width : 150,
			data : [ {
				value : '01',
				text : '是'
			}, {
				value : '02',
				text : '否'
			} ],
			filter : function(q, row) {
				var opts = $(this).combobox('options');
				return row[opts.textField].indexOf(q) == 0;
			}
		})

		$("#zth").combobox({
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

		searchdata();

	});

	function trim(str) { //删除左右两端的空格
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}

	function searchdata() {
	
		var newdate = $("#newdate").datebox('getValue');

		if (newdate == null || newdate == "") {
		
			var curr_time = new Date();
			var strDate = curr_time.getFullYear() + "-";
			strDate += curr_time.getMonth() + 1 + "-";
			strDate += curr_time.getDate();
			
			newdate = strDate;
		}
	
		var params = "filename=" + $("#userInfo").textbox('getValue')
				+ "&remark=" + $("#zth").combobox('getValue') +"&newdate=" + newdate;
				
		$('#dg').datagrid({
			method : 'get',
			url : "guzhisas/queryYXZWJ?" + params
		}).datagrid('clientPaging');
	}

	//zttype   userInfo1 
	function adddata() {
		if ($("#zttype").textbox('getValue') == ""
				|| $("#userInfo1").combobox('getValue') == "") {
			alert("请选择文件名称和文件标识！");
			return false;
		} else {
			var fileName = $("#zttype").textbox('getValue');
			var remark = $("#userInfo1").combobox('getValue');
			var state = $("#userInfo2").combobox('getValue');

			$.ajax({
				type : "POST",
				url : "guzhisas/insertGuZhiServiceSystemInfo",
				data : {
					fileName : fileName,
					remark : remark,
					state : state
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("操作成功");
						closeDialog();
						searchdata();
					} else {
						alert("操作失败");
						closeDialog();
					}
				},
				error : function() {
					alert("系统异常，操作失败");
				}
			});
		}
	}
	function removedata() {
		if ($("input[name='ck']:checked").length != 1) {
			alert("请选择要删除的数据");
			return false;
		} else {
			var id = $("input[name='ck']:checked").val();
			if (id == -1) {
				alert("此条数据为自动匹配数据，不需删除");
				return false;
			} else {
				$.ajax({
					type : "POST",
					url : "guzhisas/deleteYXZWJ",
					data : {
						ID : id
					},
					dataType : "json",
					success : function(data) {
						if (data.msg == "success") {
							alert("删除成功");
							searchdata();
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

	function editdata() {
		if ($("input[name='ck']:checked").length != 1) {
			alert("请选择1条要修改的数据");
			return false;
		} else {
			var filename = $("input[name='ck']:checked").closest("tr").find(
					"td[field='filename']");
			var remark = $("input[name='ck']:checked").closest("tr").find(
					"td[field='remark']");
			var state = $("input[name='ck']:checked").closest("tr").find(
					"td[field='state']");
			filename.find("div").html(
					"<input type='text' value='" + filename.find("div").text()
							+ "'></input>");

			//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
			$("table[class='datagrid-htable']").find("td[field='ck']").find(
					"input").prop("disabled", true);
			$("input[name='ck']").prop("disabled", true);
		}
	}

	function savedata() {
		if ($("input[name='ck']:checked").length == 1) {

			var id = $("input[name='ck']:checked").val();

			var filename = $("input[name='ck']:checked").closest("tr").find(
					"td[field='filename']").find("input").val();
			//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
			var remark = $("input[name='ck']:checked").closest("tr").find(
					"td[field='remark']").text();
			var state = $("input[name='ck']:checked").closest("tr").find(
					"td[field='state']").text();

			if (filename == "" || remark == "") {
				alert("文件名称和文件来源标识不能为空！");
				return false;
			} else if (typeof (filename) == "undefined") {
				alert("请点击修改按钮！");
				return false;
			} else {
				$.ajax({
					type : "POST",
					url : "guzhisas/updateYXZWJ",
					data : {
						ID : id,
						filename : filename,
						remark : remark,
						state : state
					},
					dataType : "json",
					success : function(data) {
						if (data.msg == "success") {
							alert("修改成功");
							searchdata();
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

	function closeDialog() {
		$('#zth1').combobox('clear');
		$('#userInfo1').combobox('clear');
		$('#dlg').dialog('close');
	}

	function changetime(date) {
		//1.先获取 newdate 的日期
		var ndate = $("#newdate").datebox("getValue");
		var a = new Date(ndate.replace(/\-/g, "\/"));

		var mailsdate = a.getFullYear() + "-";
		mailsdate += a.getMonth() + 1 + "-";
		mailsdate += a.getDate() - 1;

		var mailedate = a.getFullYear() + "-";
		mailedate += a.getMonth() + 1 + "-";
		mailedate += a.getDate();

		$("#mailsdate").datetimebox({
			value : mailsdate + " 12:00",
			required : true,
			showSeconds : false
		});

		$("#mailedate").datetimebox({
			value : mailedate + " 12:00",
			required : true,
			showSeconds : false
		});
	}
	
	function filedownloadCheck() {
		var flag = 0;
		var newdate1 = $("#newdate1").datebox('getValue');
		newdate1=newdate1.replace(/\-/g, "\/");
		$.ajax({
				type : "POST",
				url : "sjzb/checkDownloadFile",
				data : {
					newdate : newdate1
				},
				dataType : "json",
				async: false,
				success : function(data) {
					if (data.msg == "success") {
						flag = 1;
					} else {
						flag = 0;
					}
				},
				error : function() {
					flag = 0;
				}
			});
			return flag;
	}
	
	function filedownload() {
		jQuery.download = function(url, data, method){
	    // 获得url和data
	    if( url && data ){ 
	        // data 是 string 或者 array/object
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 把参数组装成 form的 input
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request发送请求
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
		var newdate1 = $("#newdate1").datebox('getValue');
		newdate1=newdate1.replace(/\-/g, "\/");
		var params = "newdate=" + newdate1;
		if (filedownloadCheck()!=0){
		    $.download('sjzb/DownloadFile',params,'post');
		}else{
			alert("文件不存在！");
		}
	}
	
</script>
<body>
	<div id="tabsidk" class="easyui-tabs" style="">
		<div title="数据下载" style="padding: 5px">
			<div style="margin-top: 10px; margin-bottom: 5px;">
				<span style="margin-left: 15px;">处理日期</span>
				<span><input id="newdate" name="newdate"
					class="easyui-datebox" style="width: 130px" editable="false"
					data-options="onSelect:changetime"></input> </span> <span
					style="color: red;">*</span>
				<span style="margin-left: 15px;">邮箱下载时间从</span> <span><input
					id="mailsdate" name="mailsdate" class="easyui-datebox"
					style="width: 130px" editable="false"></input> </span> <span
					style="margin-left: 15px;">至</span> <span><input
					id="mailedate" name="mailedate" class="easyui-datebox"
					style="width: 130px" currentText editable="false"></input> </span><span
					style="color: red;">*</span> 
			</div>
			<div style="margin-top: 10px; margin-bottom: 5px; margin-left: 15px;">
				<span>文件名称:</span> <input class="easyui-textbox" name="userInfo"
					id="userInfo"> <span style="margin-left: 15px;">文件标识:</span>
					<input class="easyui-combobox" name="zth" id="zth"> 
						<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" onclick="clearA()">初始化</a> <a
						href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" onclick="maildownload()">邮箱下载</a>
				<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" onclick="ftpdownload()">FTP下载</a>
			</div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
					              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							<th data-options="field:'ck',checkbox:true"></th>
							<!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
							<th field="filename" width="500px">文件名称</th>
							<th field="remark" width="200px">文件标识</th>
							<!-- <th field="state" width="150px">文件状态</th> -->
							<th data-options="field:'state',width:80,align:'right',styler: function(value,row,index){
							if (value == '未下载'){
							    	return 'color:#ff0000;';
								}
							}">文件状态
							</th>
							<th field="currenttime" width="200px">日期</th>
							<!-- <th field="updatetime" width="200px">更新时间</th> -->
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div title="数据合并" style="padding: 5px">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit'" onclick="unzip()">解压缩</a>&nbsp; <a
				href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit'" onclick="filemerge()">文件清洗</a>
				&nbsp; <a
				href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-print'" onclick="filedownload()">文件下载</a>
				
				
				<span
				style="margin-left: 15px;">处理日期</span> <span><input
				id="newdate1" name="newdate1" class="easyui-datebox"
				style="width: 130px" editable="false"></input> </span>
		</div>

	</div>

	<div id="dlg" class="easyui-dialog" closed="true" title="添加需要下载的文件"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
		<span style="margin-left:20px;">文件名称:</span> <span> <input
			type="text" class="easyui-textbox" id="zttype" name="zttype" /> </span> <br />
		<br /> <span style="margin-left:20px;">文件标识:</span> <span> <input
			type="text" class="easyui-combobox" id="userInfo1" name="userInfo1" />
		</span> <br /> <br /> <span style="margin-left:20px;">文件状态(是否下载):</span> <span>
			<input type="text" class="easyui-combobox" id="userInfo2"
			name="userInfo2" /> </span>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="adddata()">保存</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="closeDialog()">取消</a>
	</div>

</body>