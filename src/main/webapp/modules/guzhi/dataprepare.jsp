<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>估值人员账套对应关系配置</title>
<script type="text/javascript" src="<%=basePath%>/modules/guzhi/dataprepare.js"></script>

</head>
		    <!-- 用到的js分别为downLoadFile2_ftp.js（ftp配置），downLoadFile2_path.js（路径配置），downLoadFile2_1.js（其他配置），downLoadFile2_2.js（文件的）
		    	，downLoadFile2_mail.js（邮箱配置） -->

<body>
<div id="tabsidk" class="easyui-tabs" style="">
<div title="文件列表" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>文件名称:</span> 
			<input class="easyui-textbox"
						name="file_name" id="filename"
		    >
		    <span style="margin-left: 15px;">文件来源标识:</span> 
			<input class="easyui-combobox"
						name="file_logo" id="filelogo"
		    >
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="filesearchdata()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="fileeditdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="filesavedata()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#filedlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="fileremovedata()">删除</a>
<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg').dialog('open')">新增/删除 </a>
 -->	</div>
	   <div style="margin-top: 10px;">
			<table id="filedgs" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <!-- <th data-options="field:'ck',checkbox:true"></th>  -->
					    <th data-options="field:'ck',checkbox:true"></th>
                        <!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
                        <th field="filename" width="250px">文件名称</th>
                        <th field="filepwd" width="200px">文件标识来源</th>
                        <th field="updatetime" width="200px">更新时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div title="邮箱配置" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>邮箱账号:</span> 
			<input class="easyui-textbox"
						name="mail_name" id="mailname"
		    >
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="mailsearchdata()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="maileditdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="mailsavedata()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#maildlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="mailremovedata()">删除</a>
<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg').dialog('open')">新增/删除 </a>
 -->	</div>
	   <div style="margin-top: 10px;">
			<table id="maildgs" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <!-- <th data-options="field:'ck',checkbox:true"></th>  -->
					    <th data-options="field:'ck',checkbox:true"></th>
                        <!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
                        <th field="mailname" width="200px">邮箱账号</th>
                        <th field="mailpwd" width="200px">邮箱密码</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div title="路径配置" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="patheditdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="pathsavedata()">保存</a>
	<!--  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pathsearchdata()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#pathdlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="pathremovedata()">删除</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg').dialog('open')">新增/删除 </a>
 -->	</div>
	   <div style="margin-top: 10px;">
			<table id="pathdgs" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <!-- <th data-options="field:'ck',checkbox:true"></th>  -->
					    <th data-options="field:'ck',checkbox:true"></th>
                        <!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
                        <th field="pathname" width="250px">下载路径</th>
                        <th field="pathpwd" width="200px">保存路径</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div title="ftp配置" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>FTP账号:</span> 
			<input class="easyui-textbox"
						name="ftp_name" id="ftpname"
		    >
		    
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="ftpsearchdata()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="ftpeditdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="ftpsavedata()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#ftpdlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="ftpremovedata()">删除</a>
<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg').dialog('open')">新增/删除 </a>
 -->	</div>
	   <div style="margin-top: 10px;">
			<table id="ftpdgs" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <!-- <th data-options="field:'ck',checkbox:true"></th>  -->
					    <th data-options="field:'ck',checkbox:true"></th>
                        <!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
                        <th field="ftpname" width="250px">FTP账号</th>
                        <th field="ftppwd" width="200px">FTP密码</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div title="其他配置" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>配置文件的名称:</span> 
			<input class="easyui-textbox"
						name="other_name" id="othername"
		    >
		    <span style="margin-left: 15px;">配置文件的值:</span> 
			<input class="easyui-textbox"
						name="other_value" id="othervalue"
		    >
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdatas()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editdatas()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savedatas()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#othersdlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removedatas()">删除</a>
<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg').dialog('open')">新增/删除 </a>
 -->	</div>
	   <div style="margin-top: 10px;">
			<table id="otherdgs" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <!-- <th data-options="field:'ck',checkbox:true"></th>  -->
					    <th data-options="field:'ck',checkbox:true"></th>
                        <!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
                        <th field="key" width="250px">配置文件的名称</th>
                        <th field="value" width="200px">配置文件的值</th>
                        <th field="remark" width="200px">配置文件的说明</th>
						<th field="updatetime" width="200px">更新时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
</div>
<div id="filedlg" class="easyui-dialog" closed="true" title="添加FTP"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#filedlg-buttonss'">
	<span style="margin-left:20px;">文件名称:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="files" name="files" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">文件标识:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="filevalue" name="filevalue" />
	</span>
	 <br/><br/>
	
</div>
<div id="filedlg-buttonss">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="fileadddata()">保存</a> 
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="filecloseDialog()">取消</a>
</div>
<div id="pathdlg" class="easyui-dialog" closed="true" title="添加FTP"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#pathdlg-buttonss'">
	<span style="margin-left:20px;">下载路径:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="paths" name="paths" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">保存路径:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="pathvalue" name="pathvalue" />
	</span>
	 <br/><br/>
	
</div>
<div id="pathdlg-buttonss">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="pathadddata()">保存</a> 
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="pathcloseDialog()">取消</a>
</div>
<div id="maildlg" class="easyui-dialog" closed="true" title="添加邮箱"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#maildlg-buttonss'">
	<span style="margin-left:20px;">邮箱账号:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="mails" name="mails" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">邮箱密码:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="mailvalue" name="mailvalue" />
	</span>
	 <br/><br/>
	
</div>
<div id="maildlg-buttonss">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="mailadddata()">保存</a> 
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="mailcloseDialog()">取消</a>
</div>
<div id="othersdlg" class="easyui-dialog" closed="true" title="添加其他配置"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#othersdlg-buttonss'">
	<span style="margin-left:20px;">配置文件的名称:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="others" name="others" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">配置文件的值:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="othvalue" name="othvalue" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">配置文件的说明:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="otherlogo" name="otherlogo" />
	</span>
</div>
<div id="othersdlg-buttonss">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="adddatas()">保存</a> 
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialogs()">取消</a>
</div>
<div id="ftpdlg" class="easyui-dialog" closed="true" title="添加FTP"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#ftpdlg-buttonss'">
	<span style="margin-left:20px;">FTP账号:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ftps" name="ftps" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">Ftp密码:</span> 
	<span> 
		<input type="text" class="easyui-textbox" id="ftpvalue" name="ftpvalue" />
	</span>
	 <br/><br/>
	
</div>
<div id="ftpdlg-buttonss">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="ftpadddata()">保存</a> 
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="ftpcloseDialog()">取消</a>
</div>

</body>



