<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>员工绩效考核系统</title>

<link rel="stylesheet" type="text/css"
	href="../../ext/resources/css/ext-all-old.css" />
<link rel="stylesheet" href="../../css/common-logo.css" />
<link rel="stylesheet" href="../../css/result.css" />
<link rel="stylesheet" href="../../css/empty.css" />
<script type="text/javascript" src="../../ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../ext/ext-all.js"></script>
<script type="text/javascript"
	src="../../ext/build/locale/ext-lang-zh_CN.js"></script>
<link rel="stylesheet" href="../../css/Ext.ux.form.LovCombo.css" />
<link rel="stylesheet" href="../../css/lovcombo.css" />
<link rel="stylesheet" href="../../css/webpage.css" />
<link rel="stylesheet" href="../../css/pager.css" />
<script type="text/javascript" src="../../common/jquery/jquery-1.7.2.js"></script>

<script type="text/javascript" src="menugl.js"></script>
</head>
<body>
	<%
		String usercode = request.getParameter("usercode");
		System.out.println(usercode);
	%>
	<div id="hello" style="border: 0px solid #000; height: 100%;">
		<div class="divSmall" id="divleft" style="float: left; width: 20%;">

		</div>
		<div class="content " id="divright" style="width: 80%;">
			<div id="main" style="margin-left: 400px;">
				<table style="float:left;">
					<tr>
						<td>
							菜单编号：<input id="menucode" class="menu_edit" type = "text" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td> 菜单名称：<input id="menuname" class="menu_edit" type="text" />
						</td>
					</tr>
					<tr>
						<td>父菜单号：<input id="fmenucode" class="menu_edit" type="text" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td> 菜单链接：<input id="menuurl" class="menu_edit" type="text" />
						</td>
					</tr>
					<tr>

						<td>菜单图标：<input id="menuimg" class="menu_edit" type="text" />
						</td>
					</tr>

					<tr>
						<td><input value="修改" type="button" class="menu_edit"
							onclick="operName('update')" /></td>
						<td><input value="删除" type="button" class="menu_edit"
							onclick="operName('delete')" /></td>
						<td><input value="添加根节点" type="button" class="menu_edit" onclick="insertroot()" />
						</td>
						<td><input value="添加子节点" type="button" class="menu_edit" onclick="insertcode()" />
						</td>
					</tr>
				</table>
			</div>
			<div id="father" style="display: none; margin-left: 400px;">
				<table style="float:left;">
					<tr>
						<td>
							菜单编号：<input id="menucode1" class="menu_edit" type = "text" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td> 菜单名称：<input id="menuname1" class="menu_edit" 	type="text" />
						</td>
					</tr>
					<tr>

						<td>菜单图标：<input id="menuimg1" class="menu_edit"
							type="text" />
						</td>
					</tr>

					<tr>
						<td><input value="新增" type="button" class="menu_edit"
							onclick="operName('insertf')" /></td>
						<td><input value="返回" type="button" class="menu_edit" onclick="returnmain()" />
						</td>
					</tr>
				</table>
			</div>
			<div id="chliern" style="display: none; margin-left: 400px;">
				<table style="float:left;">
					<tr>
						<td>
							菜单编号：<input id="menucode2" class="menu_edit" type = "text" disabled="disabled" id="chliern_cdbh"/>
						</td>
					</tr>
					<tr>
						<td> 菜单名称：<input id="menuname2" class="menu_edit"	type="text" /> </td>
					</tr>
					<tr>
						<td>父菜单号：<input id="fmenucode2" class="menu_edit" type="text" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td>菜单链接：<input id="menuurl2" class="menu_edit"
							type="text" />
						</td>
					</tr>
					<tr>

						<td>菜单图标：<input id="menuimg2" class="menu_edit"
							type="text" />
						</td>
					</tr>
					<tr>
						<td><input value="新增" type="button" class="menu_edit"
							onclick="operName('insertc')" /></td>
						<td><input value="返回" type="button" class="menu_edit" onclick="returnmain()" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

</body>
</html>
