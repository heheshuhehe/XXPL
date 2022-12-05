<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>清算数据准备</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});

	 $("#wbdg").datagrid({
	 	 width : '98%' 
	 });
	 $("#wbdg2").datagrid({
	 	 width : '98%' 
	 });
	 $("#wbdg3").datagrid({
	 	 width : '98%' 
	 });
	 $("#wbdg4").datagrid({
	 	 width : '98%' 
	 });
	 $("#wbdg5").datagrid({
	 	 width : '98%' 
	 });
});


function createwbdata(){
	
	var oper="s1";
	if($("#ismx")[0].checked){
		oper="s2";
	}
	var p_zt =$("#p_zt").combobox('getValue');
	
	
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+$("#wbzth").combobox('getValue')+
 	"&systype="+$("#systype").combobox('getValue')+"&oper="+oper+"&p_zt="+p_zt;
	 $('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/querybaseiniprocess?'+params}).datagrid('clientPaging');

} 


function createwbdata4(){
 	var params="ini_group4="+$("#ini_group4").combobox('getValue');
	 $('#wbdg4').datagrid({method:'get',url:'<%=cp%>/guzhidz/querybaseini?'+params}).datagrid('clientPaging');
	
} 
function createwbdata5(){
 	var params="filetype5="+$("#filetype5").combobox('getValue');
	 $('#wbdg5').datagrid({method:'get',url:'<%=cp%>/guzhidz/querybasefile?'+params}).datagrid('clientPaging');
	
} 


function adddata2(oper){
 	
	 $('#oper2').val(oper);
	 if(oper=='s'){
		 var params="wbzth="+$("#wbzth2").combobox('getValue')+"&filetype="+$("#filetype2").combobox('getValue');
		 $('#wbdg2').datagrid({method:'get',url:'<%=cp%>/guzhidz/queryqsdataconfig?systype=2&oper=s&'+params}).datagrid('clientPaging');
	 }
	 
	if(oper=='a'){

		 $('#dialog2').dialog('open');
	}
	
	if(oper=='u'){
		var rows = $('#wbdg2').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}

		
		$("#ider2_dia2").val(rows.ider);
		$("#filetype2_dia2").combobox('select',rows.filetype) ;
		$("#jyjg2_dia2").combobox('select', rows.jyjg) ;
		$("#tzqd").textbox('setValue', rows.tzqd) ;
		
		
	 	$("#wbzth2_dia2").textbox('setValue', rows.c_port_code) ;
	 	$("#datasrc2_dia2").combobox('select',rows.datasrc) ;
	 	if(rows.c_port_code==''){
	 		$("#wbzth2_dia2").combobox('disable') ;
	 	}
		if(rows.jyjg==''){
			$("#jyjg2_dia2").combobox('disable') ;
		}
	 	$("#sender").textbox('setValue', rows.sender) ;
	 	$("#subjecter").textbox('setValue', rows.subjecter) ;
	 	$("#contenter").textbox('setValue', rows.contenter) ;
	 	$("#attacher").textbox('setValue', rows.attacher) ;
	 	
	 	$("#filepath").textbox('setValue', rows.filepath) ;
	 	$("#datefloat").combobox('select', rows.datefloat) ;
	 	$("#datefloattype").combobox('select', rows.datefloattype) ;
	 	
	 	 $('#dialog2').dialog('open');
	}
	
	if(oper=='d'){
		var rows = $('#wbdg2').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}
	var ider=rows.ider;
	
	$.messager.confirm('提示', '确认要删除吗?', function(r){
		if (r){

			$.ajax({
				url:'<%=cp%>/guzhidz/queryqsdataconfig',
				type:'post',
				data:{ider:ider,oper:oper},
				dataType: "json",
				success: function(data){
					if(data[0].msg=="success"){  
						alert("保存成功");
						closeDialog();
					}else{
						alert("发送失败");
					}
					
				}
			});
		}
	});
	
	}
	
}


function adddata4(oper){
 	
	 $('#oper4').val(oper);
	if(oper=='a'){
		
		 $('#dialog4').dialog('open');
	}
	
	if(oper=='u'){
		var rows = $('#wbdg4').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}

		
		$("#ini_group4_dia4").combobox('readonly',true) ;
		$("#ini_group4_dia4").combobox('select',rows.ini_code) ;
		$("#code4_dia4").textbox('setValue', rows.datacode) ;
	 	$("#name4_dia4").textbox('setValue', rows.dataname) ;
	 	
	 	 $('#dialog4').dialog('open');
	}
	
} 
function adddata5(oper){
 	
	 $('#oper5').val(oper);
	if(oper=='a'){
		
		 $('#dialog5').dialog('open');
	}
	
	if(oper=='u'){
		var rows = $('#wbdg5').datagrid('getSelected');
		if(rows==null){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}

		
		$("#filetype5_dia5").combobox('readonly',true) ;
		$("#filetype5_dia5").combobox('select',rows.datacode) ;
		$("#filename5_dia5").textbox('setValue', rows.filename) ;
		$("#filename5_dia5_old").val(rows.filename);

	 	
	 	 $('#dialog5').dialog('open');
	}
	
} 

function saveInfonew2(){
	var  filetype=$("#filetype2_dia2").combobox('getValue') ;
	var  filetypename=$("#filetype2_dia2").combobox('getText') ;
	var  jyjg=$("#jyjg2_dia2").combobox('getValue') ;
	var  wbzth=$("#wbzth2_dia2").combobox('getValue') ;
	var  datasrc=$("#datasrc2_dia2").combobox('getValue') ;
	var  tzqd=$("#tzqd").textbox('getValue') ;
	var  sender=$("#sender").textbox('getValue') ;
	var  subjecter=$("#subjecter").textbox('getValue') ;
	var  contenter=$("#contenter").textbox('getValue') ;
	var  attacher=$("#attacher").textbox('getValue') ;
	var  filepath=$("#filepath").textbox('getValue') ;
	var  datefloat=$("#datefloat").combobox('getValue') ;
	
	var  datefloattype=$("#datefloattype").combobox('getValue') ;
	var oper=$("#oper2").val() ;
	var ider=$("#ider2_dia2").val() ;
	
	if(filetype==''||datasrc==''){
		$.messager.alert('提示','文件类型或者数据来源为空!');
		return;
	}
	
	if(filetypename=='交易所（公共）')
		wbzth='-999';
	$.ajax({
		url:'<%=cp%>/guzhidz/queryqsdataconfig',
		type:'post',
		data:{ider:ider,filetype:filetype,jyjg:jyjg,wbzth:wbzth,datasrc:datasrc,sender:sender,subjecter:subjecter,contenter:contenter,attacher:attacher,filepath:filepath,datefloat:datefloat,datefloattype:datefloattype,oper:oper,systype:2,tzqd:tzqd},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				closeDialog();
			}else{
				alert("发送失败");
			}
			
		}
	});
	
}

function saveInfonew4(){

	var  ini_group=$("#ini_group4_dia4").combobox('getValue') ;
	var  datacode=$("#code4_dia4").textbox('getValue') ;
	var  dataname=$("#name4_dia4").textbox('getValue') ;
	var oper=$("#oper4").val() ;
	
	if(ini_group=='' || dataname==''){
		$.messager.alert('提示','配置类型或者数据名称为空');
		return;
	}
	$.ajax({
		url:'<%=cp%>/guzhidz/querybaseiniedit',
		type:'post',
		data:{ini_group:ini_group,datacode:datacode,dataname:dataname,oper:oper},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				closeDialog();
				createwbdata();
			}else{
				alert("发送失败");
			}
			
		}
	});

}
function saveInfonew5(){

	var  filetype=$("#filetype5_dia5").combobox('getValue') ;
	var  filename=$("#filename5_dia5").textbox('getValue') ;
	var  filename_old=$("#filename5_dia5_old").val();
	var oper=$("#oper5").val() ;
	
	if(filetype=='' || filename==''){
		$.messager.alert('提示','文件种类或者文件名称为空');
		return;
	}
	$.ajax({
		url:'<%=cp%>/guzhidz/querybasefilemx',
		type:'post',
		data:{filetype:filetype,filename:filename,filename_old:filename_old,oper:oper},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				closeDialog();

			}else{
				alert("发送失败");
			}
			
		}
	});

}
function closeDialog(){
	
	
	 $("#filetype2_dia2").combobox('clear') ;
	 $("#jyjg2_dia2").combobox('clear') ;
	 $("#wbzth2_dia2").combobox('clear') ;
	 $("#datasrc2_dia2").combobox('clear') ;
	 $("#tzqd").textbox('clear') ;
	 $("#jyjg2_dia2").combobox('enable') ;
	 $("#wbzth2_dia2").combobox('enable') ;
	 
	 $("#sender").textbox('clear') ;
	 $("#subjecter").textbox('clear') ;
	 $("#contenter").textbox('clear') ;
	 $("#attacher").textbox ('clear') ;
	 $('#filepath').textbox('clear');
	 $('#datefloat').combobox('clear');
	 $('#datefloattype').combobox('clear');
	 $('#dialog2').dialog('close');
	
	
	
	$("#ini_group4_dia4").combobox('clear') ;
	$("#ini_group4_dia4").combobox('readonly',false) ;
	$("#code4_dia4").textbox('clear') ;
 	$("#name4_dia4").textbox('clear') ;
 	 $('#dialog4').dialog('close');
 	 
 	$("#filetype5_dia5").combobox('readonly',false) ;
	$("#filetype5_dia5").combobox('clear') ;
	$("#filename5_dia5").textbox('clear') ;
	$("#filename5_dia5_old").val('') ;
	
	 $('#dialog5').dialog('close');
 	
}
function createwbdata2(systype,sign){
	var ssinfo="";
	if(sign=='redo'){
		
		var rows = $('#wbdg').datagrid('getSelections');
		if(rows.length==0){
			$.messager.alert('提示','没有选择任何数据!');
			return;
		}
		var ssinfo="";
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ssinfo=ssinfo+row.ider;
	}
	}

		var oper='c';
		var  wbdate=$("#wbdate").combobox('getValue') ;
	$.ajax({
		url:'<%=cp%>/guzhidz/querybaseiniprocess',
		type:'post',
		data:{wbdate:wbdate,systype:systype,oper:oper,sign:sign,ssinfo:ssinfo},
		dataType: "json",
		beforeSend : function() {
			load("正在处理数据。。。。");
		},
		complete : function() {
			disLoad();
		},
		success: function(data){
			disLoad();
			if(data[0].msg=="success"){  
				alert("处理完成");
			}else{
				alert("处理失败");
			}
			
		}
	});
} 
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#wbdate").datebox("setValue", myformatter(curr_time));

			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 //初始化table
			 $("#wbdg2").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 //初始化table
			 $("#wbdg3").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 //初始化table
			 $("#wbdg4").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 
			//初始化table
			 $("#wbdg5").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 
			 
			 
		 $.getJSON("<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='1' order by datacode asc",function(json){

			 $("#filetype2_dia2").combobox({ valueField: 'value',
				  textField: 'text',
					data:json,
				  method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     },
			     onChange:function(n,o){
			    	 if($("#filetype2_dia2").combobox('getText').indexOf('公共')>0){
			    		 $("#jyjg2_dia2").combobox('clear') ;
			    			$("#jyjg2_dia2").combobox('disable') ;
			    		 
			    			
			    		 	$("#wbzth2_dia2").combobox('clear') ;
			    			$("#wbzth2_dia2").combobox('disable') ;
			    	 }else{
			    			$("#jyjg2_dia2").combobox('enable') ;
			    	
			    			$("#wbzth2_dia2").combobox('enable') ;
			    	 }
			    }
		  	});
			 
			 $("#filetype2").combobox({ valueField: 'value',
				  textField: 'text',
					data:json,
				  method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     }
		  	});
			 
		 } ); 
			 
			 $("#jyjg2_dia2").combobox({
	              valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='2' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     }
		  });
			 
		/* 	 $("#filetype2_dia2").combobox({ valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='1' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     },onChange:function(n,o){
			    	 if(n.indexOf("公共")>0){
			    		 $("#jyjg2_dia2").combobox('clear') ;
			    			$("#jyjg2_dia2").combobox('disabled') ;
			    		 
			    		 	$("#wbzth2_dia2").combobox('clear') ;
			    			$("#wbzth2_dia2").combobox('readonly',true) ;
			    	 }
			     }
		  });
			  */
			 $("#datasrc2_dia2").combobox({ valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='3' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
						onChange:function(n,o){
							if(n==3){
								$('#mailpannel').panel('open');
								$('#diskpannel').panel('close');
								$('#datefloat').combobox('clear');
								$('#datefloattype').combobox('clear');
								$('#filepath').textbox('clear');
								
							}
							if(n==4){
								$('#mailpannel').panel('close');
								$('#diskpannel').panel('open');
								$('#sender').textbox('clear');
								$('#subjecter').textbox('clear');
								$('#contenter').textbox('clear');
								$('#attacher').textbox('clear');
								
							}
						},
				 onLoadSuccess: function(){
					   $('#datefloat').combobox('clear');
						$('#datefloattype').combobox('clear');
			     }
		  });
			 $("#filetype5").combobox({
	              valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='1' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     }
		  });
			 
			 $("#filetype5_dia5").combobox({
	              valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='1' order by datacode asc ",
	              method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							return row[opts.textField].indexOf(q) > -1;
						},
				 onLoadSuccess: function(){
			     }
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

	 
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="数据处理情况查询" style="padding: 10px">
		<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>
					<td>帐套名称：
					  <input class="easyui-combobox"
						name="wbzth" id="wbzth"
						 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('#wbzth').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 "
		               >
		               <span style="color: red;">*</span>
		               系统：<select class="easyui-combobox"	name="systype" id="systype" style="width: 70px;" > 
						<option value="1">托管</option>
						<option value="2">外包</option>

				
				</select>
				     状态：<select class="easyui-combobox"	name="p_zt" id="p_zt" style="width: 80px;" > 
						<option value="0">全部</option>
						<option value="1">未完成</option>
						<option value="2">已完成</option>

				</select>
				<input    type="checkbox" name="ismx" id="ismx" > 按账套 展示
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2('2','do')">外包数据处理</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2('2','redo')">数据重处理</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
					 <th data-options="field:'ck',checkbox:true"></th>
					 	<th field="ider" hidden="true">id</th>
						<th field="c_port_code" >账套号</th>
						<th field="c_port_name" >账套名称</th>
						<th field="gz_date" >数据日期</th>
						<th field="f_state" >数据状态</th>
						<th field="filetypename" >文件类型</th>

							<th field="jyjgname" >交易机构</th>
						<th field="datasrcname" >数据来源</th>
						
						<th field="sender" >发件人</th>
						<th field="subjecter" >主题</th>
						<th field="contenter" >正文内容</th>
						<th field="attacher" >附件</th>
						<th field="filepath" >文件路径</th>
						<th field="datefloat" >日期浮动</th>
						<th field="datefloattype" >浮动类型</th>

	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
	<div title="外包清算数据信息配置" style="padding: 10px">
		<table>
				<tr>
				<td>	<span style="margin-left: 0px">文件种类:</span>
			<span> 
			 	<input id="filetype2" name="filetype2"	class="easyui-combobox"		style="width: 120px"></input>
			</span>  </td>
					<td>帐套名称：
					  <input class="easyui-combobox"	name="wbzth2" id="wbzth2" 	 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('wbzth2').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 "
		               >
		               <span style="color: red;">*</span>
					   </td>
								<td>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata2('s')">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata2('a')">添加</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata2('u')">修改</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata2('d')">删除</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg2"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="ider"  hidden="true">账套号</th>
						<th field="c_port_code" >账套号</th>
						<th field="c_port_name" >账套名称</th>
						<th field="c_asset_code" >资产代码</th>
						
						<th field="filetypename" >文件类型</th>
						<th field="filetype"  hidden="true">文件类型</th>
						<th field="jyjg"  hidden="true">交易机构</th>
							<th field="jyjgname" >交易机构</th>
						<th field="datasrc" hidden="true" >数据来源</th>
						<th field="datasrcname" >数据来源</th>
						<th field="tzqd0" hidden="true">投资渠道</th>
						<th field="tzqd" >关键字</th>
						
						
						<th field="sender" >发件人</th>
						<th field="subjecter" >主题</th>
						<th field="contenter" >正文内容</th>
						<th field="attacher" >附件</th>
						<th field="filepath" >文件路径</th>
						<th field="datefloat" >日期浮动</th>
						<th field="datefloattype" >浮动类型</th>
						
						
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>	
    <div title="托管清算数据信息配置" style="padding: 10px">
		<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>
					<td>帐套名称：
					  <input class="easyui-combobox"
						name="wbzth" id="wbzth"
						 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('#wbzth').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 "
		               >
		               <span style="color: red;">*</span>
					   </td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata2()">虚拟估值表</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg3"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="wb_zth" >账套号</th>
						<th field="c_port_name" >账套名称</th>
						<th field="gth" >普通柜台号</th>
						<th field="xhye" data-options="align:'right',formatter:myformatter">柜台余额</th>
						<th field="rzrq_gth" >双融柜台号</th>
						<th field="srye" data-options="align:'right',formatter:myformatter">双融余额</th>
						<th field="stock_option" >个股期权号</th>
						<th field="ggye" data-options="align:'right',formatter:myformatter">个股期权余额</th>
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>	
    <div title="基础数据配置" style="padding: 10px">
		<table>
				<tr>
				<td><span>配置类型</span>
				<select class="easyui-combobox"	name="ini_group4" id="ini_group4"  > 
					 	<option value="0"selected="selected" >全部</option>
						<option value="1">文件种类</option>
						<option value="2">交易机构</option>
						<option value="3">文件来源</option>
				
				</select>
				    
			     </td>
					
					   </td>
						<td>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata4()">查询</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata4('a')">添加</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata4('u')">修改</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg4"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="ini_group" >配置类型</th>
						<th field="ini_code" hidden="true" >配置类型</th>
						<th field="datacode" >代码</th>
						<th field="dataname" >数据名称</th>

					</tr>
				</thead>
			</table>
	 </div>
    </div>	
 <div title="文件种类明细配置" style="padding: 10px">
		<table>
				<tr>
				<td><span>文件种类</span>
				<input class="easyui-combobox"	name="filetype5" id="filetype5"  > 
				

				    
			     </td>
					
					   </td>
						<td>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata5()">查询</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata5('a')">添加</a>
							<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="adddata5('u')">修改</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg5"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						<th field="dataname" >文件种类</th>
						<th field="datacode" hidden="true" >文件代码</th>
						<th field="filename" >文件名称</th>

						
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>	
    
</div>
</body>
<div id="dialog2" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 400px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons2',
						modal:true
					">
			
			<span style="margin-left: 0px">文件种类:</span>
			<span> 
			 	<input id="filetype2_dia2" name="filetype2_dia2"	class="easyui-combobox"		style="width: 120px"></input>
			</span>
				<span style="margin-left: 0px">交易机构:</span>
			<span> 
			 	<input id="jyjg2_dia2" name="jyjg2_dia2"	class="easyui-combobox"	style="width: 120px"></input>
			</span>
							<br /> <br />
			<span style="margin-left: 0px">账套名称:</span>
			<span> 
			<input class="easyui-combobox"	name="wbzth2_dia2" id="wbzth2_dia2" 	 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('wbzth2_dia2').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 "
		               >
			</span>
			<span style="margin-left: 0px">数据来源:</span>
			<span> 
			 	<input id="datasrc2_dia2" name="datasrc2_dia2"	class="easyui-combobox"		style="width: 120px"></input>
			</span>
			<br /> <br />
			</select>
					关键字：<input class="easyui-textbox"	name="tzqd" id="tzqd" style="width: 140px;" > 
						
				
						</input>
			<br /> <br />
			配置说明：1.每一项路径对应一套文件 2.共享盘的三个选项都要配置3.日期使用YYYYMMDD（大写）使用
			<br /> <br />
			<div id="mailpannel" class="easyui-panel" title="数据特征" style="width:660px;height:200px;padding:10px;" data-options="closed:true" >
					发件人： <input id="sender"class="easyui-textbox" name="sender" style="width: 300px;" />   <br>  <br>
					主题： <input id="subjecter"class="easyui-textbox" name="subjecter" style="width: 300px;" />   <br>  <br>
					内容： <input id="contenter"class="easyui-textbox" name="contenter" style="width: 300px;" />   <br>  <br>
					附件： <input id="attacher"class="easyui-textbox" name="attacher" style="width: 300px;" />   <br>  <br>
					    
				</div>
				<div id="diskpannel" class="easyui-panel" title="数据特征" style="width:660px;height:200px;padding:10px;" data-options="closed:true">
					文件路径： <input id="filepath"class="easyui-textbox" name="filepath" style="width: 400px;" />   <br>  <br>
					日期浮动：<select class="easyui-combobox"	name="datefloat" id="datefloat" style="width: 100px;" > 
						<option value="T-1">T-1</option>
						<option value="T+0">T+0</option>
						<option value="T+1">T+1</option>

				
				</select>
					  浮动类型：<select class="easyui-combobox"	name="datefloattype" id="datefloattype" style="width: 100px;" > 
						<option value="工作日">工作日</option>
						<option value="自然日">自然日</option>
				
				</select>
				</div>
			
			<input   id="oper2" name="oper2" style="display: none;" >
			<input   id="ider2_dia2" name="ider2_dia2" style="display: none;" >
			
		</div>
		<div id="dlg-buttons2">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew2()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

 <div id="dialog4" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons4',
						modal:true
					">
				<span style="margin-left: 0px">配置类型:</span>
			<span> 
			 <select class="easyui-combobox"	name="ini_group4_dia4" id="ini_group4_dia4"  > 
						<!-- <option value="1">文件种类</option> -->
						<option value="2">交易机构</option>
				
				</select>
			</span>
				<br /> <br />
				<span style="margin-left: 0px">代码(新增无需填写):</span>
			<span> 
			 	<input id="code4_dia4" name="code4_dia4"	class="easyui-textbox"	readonly="readonly"	style="width: 120px"></input>
			</span>
			<br /> <br />
			<span style="margin-left: 0px">名称:</span>
			<span> 
			 	<input id="name4_dia4" name="name4_dia4"	class="easyui-textbox"		style="width: 120px"></input>
			</span>
			<input   id="oper4" name="oper4" style="display: none;" >
			
		</div>
		<div id="dlg-buttons4">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew4()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
<div id="dialog5" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons5',
						modal:true
					">
				<span style="margin-left: 0px">文件种类:</span>
			<span> 
			 <input class="easyui-combobox"	name="filetype5_dia5" id="filetype5_dia5"  > 
			</span>
		
			<br /> <br />
			<span style="margin-left: 0px">文件名称:</span>
			<span> 
			 	<input id="filename5_dia5" name="filename5_dia5"	class="easyui-textbox"		style="width: 120px"></input>
			</span>
			<input   id="oper5" name="oper5" style="display: none;" >
			<input   id="filename5_dia5_old" name="filename5_dia5_old" style="display: none;" >
			
		</div>
		<div id="dlg-buttons5">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew5()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>




