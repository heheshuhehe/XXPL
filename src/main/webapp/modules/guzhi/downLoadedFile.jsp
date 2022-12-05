<%@page language="java" import="java.util.*" pageEncoding="utf-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
	String cdid = request.getParameter("cdid");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/corejscss.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>test1</title>
		<script>document.documentElement.focus();</script>
		
		<script type="text/javascript" src="<%=basePath%>/common/js/DateField.js"></script>
		<script type="text/javascript" src="<%=basePath%>/common/js/DatePicker.js"></script>
		<script type="text/javascript" src="<%=basePath%>/common/js/json2.js"></script>
		<script type="text/javascript" src="<%=basePath%>/modules/guzhi/downLoadedFile.js"></script>
		<style type="text/css">
		  innerTab.td {   font-size: 30pt;}
		  body{
				background:#eff6fe !important;
				}
		</style>
		<script  type="text/javascript">
         $(document).ready(function(){
              cdid = '<%=cdid%>';
          });
		</script>
	</head>
	<body>
		<!-- 顶级容器 -->
		<div id="panel"></div>
	</body>
</html>