<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="resoures.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>估值人员账套对应关系配置</title>
<script>document.documentElement.focus();</script>

</head>
<!-- 初始化操作 -->

<!-- 自定义js -->
<script type="text/javascript">
	function maildownload() {
		$.ajax({
			type : 'POST',
			url : 'guzhisas/maildownload',
			dataType : 'json',
			beforeSend : function() {
				load("邮件正在下载中");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				alert(data.msg);
				disLoad();
				if (data.msg == "success"){
					alert("邮箱下载成功");
				}else {
					alert(data.msg);
				}
			},
			error : function(data){
				alert(data.msg);
				disLoad();
				alert("邮箱下载失败");
			}
		});
	}
	function ftpdownload() {
		$.ajax({
			type : 'POST',
			url : 'guzhisas/ftpdownload',
			dataType : 'json',
			beforeSend : function() {
				load("FTP正在下载中");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				alert("FTP下载成功");
			}
		});

	}
	function unzip() {
		$.ajax({
			type : 'POST',
			url : 'guzhisas/fileUnzip',
			dataType : 'json',
			beforeSend : function() {
				load("正在解压缩文件");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				alert("文件解压缩成功");
			}
		});

	}
	function filemerge() {
		$.ajax({
			type : 'POST',
			url : 'guzhisas/filemerge',
			dataType : 'json',
			beforeSend : function() {
				load("正在清洗文件");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
				alert("文件清洗成功");
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
</script>
<body>
	<div id="tabsidk">
		<div title="估值人员配置" style="padding: 5px">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="maildownload()">邮箱下载</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="ftpdownload()">FTP下载</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit'" onclick="unzip()">解压缩</a> <a
				href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit'" onclick="filemerge()">文件清洗</a>
		</div>
	</div>
	</div>

</body>