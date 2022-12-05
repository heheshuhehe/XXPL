<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>账套对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' ,
		 height : document.documentElement.clientHeight-10
	});
	 //初始化table
	
	 $("#wbdg").datagrid({
	 	 width : '95%' ,
	 		 height : document.documentElement.clientHeight-200
	 });
});

function createwbdata(){
	
	var gztype=$("#gztype").combobox("getValue");
	var wbdate=$("#wbdate").combobox("getValue");
	
	var mailid= $("#mailid").combobox("getValue");
	var mailfrom=$("#mailfrom").textbox("getValue");
	var content=$("#content").textbox("getValue");
	var subject=$("#subject").textbox("getValue");
	var attach=$("#attach").textbox("getValue");
	
	
	var param="mailid="+mailid+"&mailfrom="+mailfrom +"&content="+content +"&subject="+subject +"&attach="+attach+"&wbdate="+wbdate+"&gztype="+gztype;
 	
	$('#wbdg').datagrid({method:'get',url:"<%=cp%>/guzhidz/getmailinfo?"+param}); 
}

function p_closeDialog(){
	$('#p_dlg_add').dialog('close');
}

function viewdata(){
	var row =$("#wbdg").datagrid('getSelected');
	if(row){

				 
				var id=row.id;
				
				var op='view';
				$.ajax({
					url:'<%=cp%>/guzhidz/getmailinfodetail',
					type:'post',
					data:{op:op,id:id},
					dataType: "json",
					success: function(data){
						
						if(data.length==1){
							var row=data[0];
							 $('#mailfrom_1').textbox('setValue',row.mail_from);
							 $('#mailto_1').textbox('setValue',row.mail_to);
							 $('#subject_1').textbox('setValue',row.mail_subject);
							 $('#content_1').html(row.mail_content);
							 $('#ach_1').html(row.mail_attachment);
							
							  $('#p_dlg_add').dialog('open');
						}else{
							alert("查询失败！");
						}
					}
				}); 

				
	
	}
} 
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#tgdate").datebox("setValue", myformatter(curr_time));
			$("#wbdate").datebox("setValue", myformatter(curr_time));
			
			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '99%',
		     	 height : document.documentElement.clientHeight-110
			 });
	});
</script>

<script type="text/javascript">
	function myformatter1(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + '-' + (m < 10 ? ('0' + m) : m) + '-'
				+ (d < 10 ? ('0' + d) : d);
	}
	function myparser(s) {
		if (!s)
			return new Date();
		var ss = (s.split('-'));
		var y = parseInt(ss[0], 10);
		var m = parseInt(ss[1], 10);
		var d = parseInt(ss[2], 10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
			return new Date(y, m - 1, d);
		} else {
			return new Date();
		}
	}
	
	function format (number) {
		var num;
		try{
			num=Number(number);
			
		}
		catch (e) {
			return number;
		}
	if(isNaN(num))
		return num;
	    return (num.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'); 

	} 
	function changetime() {
		//1.先获取 newdate 的日期
		var ndate = $("#wbdate").datebox("getValue");
		var a = new Date(ndate.replace(/\-/g, "\/"));
//得到第一个日期，它有onSelect属性，可以触发第二个日期
		var mailsdate = a.getFullYear() + "-";
		mailsdate += a.getMonth() + 1 + "-";
		mailsdate += a.getDate();

		$("#wbdate2").datebox({
		//给第二个日期设置值（将第一个日期放进去）
			value : mailsdate,
			required : true
		});

		
	}
	function formatEncodeHtml(value, row, index) {
	    return encodeHtml(value);
	}
	this.REGX_HTML_ENCODE = /"|&|'|<|>|[\x00-\x20]|[\x7F-\xFF]|[\u0100-\u2700]/g;
	function encodeHtml(s) {
	    return (typeof s != "string") ? s :
	            s.replace(this.REGX_HTML_ENCODE,
	                    function ($0) {
	                        var c = $0.charCodeAt(0), r = ["&#"];
	                        c = (c == 0x20) ? 0xA0 : c;
	                        r.push(c);
	                        r.push(";");
	                        return r.join("");
	                    });
	}

</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="邮件信息查询" style="padding: 10px">
		<table>
				<tr>
				<td>邮箱：<select id="mailid"
						class="easyui-combobox" name="mailid" style="width: 100px;">
					    	<option value="receice_mail_info">外包服务邮箱</option>
							<option value="receice_mail_info_tg">托管业务邮箱</option>
							<option value="receice_mail_info_ht">合同专用邮箱</option>
							<option value="2">qita</option>
							</select></td>  	
				<td><span>类型:</span> 		<select id="gztype"
						class="easyui-combobox" name="gztype" style="width: 60px;">
					    	<option value="T0">T+0</option>
							<option value="T1">T+1</option>				</select>	</td> 
				<td><span>估值日期:</span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 100px" editable="false" data-options="onSelect:changetime"></input> 			</td> 
				<td><span>发件人:</span> 			<input class="easyui-textbox"	name="mailfrom" id="mailfrom"></td> 
				<td><span>主题:</span> 			<input class="easyui-textbox"	name="subject" id="subject"></td> 
				<td><span>内容:</span> 			<input class="easyui-textbox"	name="content" id="content"></td> 
				<td><span>附件:</span> 			<input class="easyui-textbox"	name="attach" id="attach"></td> 
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a></td>	
								
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="viewdata()">修改</a></td>	
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  class="easyui-datagrid" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="id" data-options="hidden:true" >id</th>
						<th field="mail_from" width="150" data-options="formatter:formatEncodeHtml" >发件人</th>
						<th field="mail_to"  width="100" data-options="formatter:formatEncodeHtml" >收件人</th>
						<th field="mail_time"  >发送时间</th>
						<th field="mail_subject"  width="200" data-options="formatter:formatEncodeHtml"   >主题</th>
						<th field="mail_content"  width="100"data-options="formatter:formatEncodeHtml"  >内容</th>
						<th field="mail_isattach" >是否有附件(0无1有)</th>
						<th field="mail_attachment" width="200" >附件名称</th>
					
						
					</tr>
				</thead>
			</table>
	 </div>
    </div>
		

 
</div>
<!-- dialog弹出框 -->
         <div id="p_dlg_add" class="easyui-dialog" closed="true" title="查看"
			style="width: 800px; height: 600px; padding: 10px;"
			data-options="		iconCls: 'icon-save',		buttons: '#dlg-buttons'		,minimizable:true,maximizable:true			">

			<div style="margin-bottom: 10px;">
			<input   id="op"  name="op" type="text"  style="display: none" />
			<input   id="ider"  name="ider" type="text"  style="display: none" />
		
				<br/><br/>
				<span style="margin-left: 0px">发件人:</span>
				<span>
					<input name="mailfrom_1" id="mailfrom_1" class="easyui-textbox" data-options=""  style="width:700px ">
				</span><br/><br/>
				<span style="margin-left: 0px">收件人:</span> 
				<span>
					<input name="mailto_1" id="mailto_1" class="easyui-textbox" data-options=""  style="width:700px">
			
					  <br/><br/>
				<span style="margin-left: 0px">主题：</span>
						<input name="subject_1" id="subject_1" class="easyui-textbox" data-options=""  style="width:700px">
					  <br/><br/>

				<span style="margin-left: 0px">正文：</span>
					<div name="content_1" id="content_1"  style="width: 99%;min-height:100px ;border: 1px dashed ; overflow: auto "></div>
					  <br/><br/>
					  <span style="margin-left: 0px">附件：</span>
					<div name="ach_1" id="ach_1"  style="width: 99%;min-height:100px ; border: 1px dashed ; "></div>
					  <br/><br/>
					  
			</div>

		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="p_saveData()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div>
</body>
</div>







