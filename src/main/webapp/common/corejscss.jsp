<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<link rel="stylesheet" href="<%=basePath%>ext/resources/css/ext-all.css" />
	<link rel="stylesheet" href="<%=basePath%>css/common.css" />
	<link rel="stylesheet" href="<%=basePath%>css/result.css" />
	<link rel="stylesheet" href="<%=basePath%>css/empty.css" />
	<link rel="stylesheet" href="<%=basePath%>css/Ext.ux.form.LovCombo.css" />
	<link rel="stylesheet" href="<%=basePath%>css/lovcombo.css" />
	<link rel="stylesheet" href="<%=basePath%>css/webpage.css" />
	<link rel="stylesheet" href="<%=basePath%>css/pager.css" />
	<link rel="stylesheet" href="<%=basePath%>css/zis_js.css" />
	<link rel="stylesheet" href="<%=basePath%>css/button.css" />
	<link rel="stylesheet" href="<%=basePath%>/css/jquery.resizableColumns.css">
	<script type="text/javascript" src="<%=basePath%>common/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/jquery/jquery.form.js"></script>
	
	
	<script type="text/javascript" src="<%=basePath%>common/jquery/jquery.pager.js"></script>
	<script type="text/javascript" src="<%=basePath%>ext/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="<%=basePath%>ext/ext-all.js"></script>
	<script type="text/javascript" src="<%=basePath%>ext/build/locale/ext-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/Ext.ux.form.LovCombo.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/Ext.ux.ThemeCombo.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/WebPage.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/data/formData.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/common.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/ListGridField.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/OprListGridField.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/ListGrid.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/Panel.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/DataGetter.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/ListGridFieldSet.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/innerQuery.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/js/dbservice.js"></script>
	<script type="text/javascript" src="<%=basePath%>/common/Pinyin/PinyinFilter.js"></script>
	<script type="text/javascript" src="<%=basePath%>/common/js/store.js"></script>
	<script type="text/javascript" src="<%=basePath%>/common/js/jquery.resizableColumns.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/common/js/jquery.freezeheader.js"></script>