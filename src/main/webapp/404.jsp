<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()
			+":"+request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="404 Error Page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <body>
		<div class="navbar navbar-inverse">
		</div><!--/.navbar-->
		<div class="container-fluid" id="main-container">
			<div id="main-content" class="clearfix">
					<div id="page-content" class="clearfix">
						<div class="row-fluid">
<!-- PAGE CONTENT BEGINS HERE -->
<div class="error-container">
<div class="well">
	<h1 class="grey lighter smaller">
		<span class="blue bigger-125"><i class="icon-sitemap"></i> 404</span> 没有找到此页面
	</h1>
	<hr />
	<h3 class="lighter smaller">We looked everywhere but we couldn't find it!</h3>
	
	<div>
		
		<div class="space"></div>
		
		<h4 class="smaller">Try one of the following:</h4>
		<ul class="unstyled spaced inline bigger-110">
			<li><i class="icon-hand-right blue"></i> 检查路径是不是有误</li>
			<li><i class="icon-hand-right blue"></i> 检查代码是不是有误</li>
			<li><i class="icon-hand-right blue"></i> 检查环境配置是不是有误</li>
		</ul>
	</div>
	
	<hr />
	<div class="space"></div>
	
	<div class="row-fluid">
		<div id="zhongxin">
		</div>
	</div>
</div>
</div>
<!-- PAGE CONTENT ENDS HERE -->
						 </div><!--/row-->
	
					</div><!--/#page-content-->
					  
			</div><!-- #main-content -->
		</div><!--/.fluid-container#main-container-->
	</body>
</html>