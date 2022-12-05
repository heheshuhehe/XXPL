<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<%@include file="/common/corejscss.jsp"%>
	<base href="<%=basePath%>" /> 
    <title></title>
	<script type="text/javascript" src="myjs/login/listMenu.js"></script>
</head>
<body style="overflow:hidden;background:#eff6fe;">
	<div id="jzzq" style="margin-top: 2px;height:80px;width:100%;">
		<img src="images/11-21.png" alt="" style="width: 676px; height: 79px;" />
	</div>
	<div id="tc" style="position:fixed;top:20px;right:20px;"> 
		  <a href="logoExit.jsp" style="float: right;
		     text-decoration:none;
		     font-size:11px; font-weight:100;
             color:#fff;letter-spacing:1px
             background-color:#E7EAEB;
             font-family:'微软雅黑','黑体','宋体';
             text-align:center" 
             ><img src="<%=basePath%>images/logo/logout1.png"
             width="30" height="30"/>
             <p >退  出</p>
             </a> 
	</div>
	<div id="hello" style="height: 100%; width: 100%; margin-top: -4px;">
		<div class="divSmall" id="divleft" style="float: left; height: 80%; width: 18%;"></div>
		<div  class="content" style="float: left; height: 80%; width: 0.5%;position:relative;top:-9px; " onclick="switchSysBar()">
			<img id="fc" src="ext/resources/images/default/menu/fc.png"  alt="浮层" />
			<img id="zyss" src="ext/resources/images/default/layout/mini-left.gif"  alt="向左收缩" style="margin-top: 300px; padding-left:1px; "  />
			<img id="zyss_right" src="ext/resources/images/default/layout/mini-right.gif"  alt="向右收缩" style="display:none; margin-top: 300px; padding-left:1px; "  />
		</div>
		<div class="content" id="divright"  style="float: left; height: 80%; width: 81.5%;">
			
		</div>
	</div>
</body>
</html>
