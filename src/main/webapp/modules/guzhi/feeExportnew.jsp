<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>   
    <title>文件信息</title>
    <script>document.documentElement.focus();</script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href='<%=basePath%>calendar/fullcalendar.min.css' rel='stylesheet' />
    <link href='<%=basePath%>calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <script src='<%=basePath%>calendar/lib/moment.min.js'></script>
<%--     <script src='<%=basePath%>calendar/lib/jquery.min.js'></script> --%>
    <script src='<%=basePath%>calendar/fullcalendar.js'></script>
    
    <script src='<%=basePath%>calendar/locale-all.js'></script>
    
</head>
<script type="text/javascript">

function getyyyyMMdd(){
    var d = $('#calendar').fullCalendar('getDate');
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1; 
    var curr_year = d.getFullYear();
    String(curr_month).length < 2 ? (curr_month = "0" + curr_month): curr_month;
    String(curr_date).length < 2 ? (curr_date = "0" + curr_date): curr_date;
    var yyyyMMdd = curr_year + "" + curr_month ;
    return yyyyMMdd;
}    

$(document).ready(function() {

    $("#userInfo").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#userInfo').next('.combo').find('input').focus(function (){
		            $('#userInfo').combobox('clear');
		     });
	     }
});
    $("#banktype").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=EA_IPMP2.EPG_DICTIONARY@dbtyzf&code=dict_key&name=dict_value&option=where parent_code='0001' order by dict_key asc ",
        method:'post',
        multiple:false,
		  width:180,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) > -1;
				},
		 onLoadSuccess: function(){
	     }
 });
    $("#banktype_a").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=EA_IPMP2.EPG_DICTIONARY@dbtyzf&code=dict_key&name=dict_value&option=where parent_code='0001' order by dict_key asc ",
        method:'post',
        multiple:false,
		  width:180,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) > -1;
				},
		 onLoadSuccess: function(){
	     }
 	});
    var curr_time = new Date();
	$("#wbdate").datebox("setValue", myformatter(curr_time));

	 //初始化table
	 $("#wbdg").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-80
	 });
	 $("#yhflow").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-120
	 });
	 $("#feetypedg").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-120
	 });
	var initialLocaleCode = 'zh-cn';
  var date =new Date();
	$('#calendar').fullCalendar({
		height:530,
		defaultDate: date,
		editable: false,
		eventLimit: true, // allow "more" link when too many events
		locale: initialLocaleCode,
		weekends:false,
		eventBackgroundColor:'#e6e6fa',
		eventTextColor:'black',
		header: {
			left: 'prev,next ',
			center: 'title',
			right: ''
		},
		dayClick: function(date) {
			
		},

		events: {
			//url: '<%=basePath%>guzhidz/getfundOpeninfo?yyyymm=' +getyyyyMMdd() ,
					url: '<%=basePath%>guzhidz/getfundOpeninfo?yyyymm=2017' ,
			error: function() {
				$('#script-warning').show();
			}
	}
         
	});


	$('#calendar2').fullCalendar({
		height:530,
		defaultDate: date,
		editable: false,
		defaultView: 'listDay',

		eventLimit: true, // allow "more" link when too many events
		locale: initialLocaleCode,
		header: {
			left: 'prev,next ',
			center: 'title',
			right: ''
		},
		dayClick: function(date) {
			
		},
		events: {
			url: '<%=basePath%>guzhidz/getfundOpeninfodetail',
			error: function() {
				$('#script-warning').show();
			}
	},
	eventOrder:function(e1,e2){
		 var n1=parseInt( e1.id);
		 var n2=parseInt( e2.id);
		 if(n1>n2)
			 return 1;
			 else return -1;
	}
         
	});
	


});

		
							

function searchdata(){


    var str =$("#d_ywrq").combobox('getValue');
    str=str.replace(/-/g,'');
      if(str=="" ){
		  alert("请选择日期起！");
		  return false;
	  } 
      
    //var params="zth="+$("#zth").combobox('getValue');
    var params="zth="+$("#zth").combobox('getValue') + "&d_ywrq=" + str + "&ttlz="+$("#ttlz").combobox('getValue');
	 $('#dg').datagrid({method:'get',
	 url:"simu/getNameout?"+params
	 }).datagrid('clientPaging'); 
/* 	$('#zth').combobox('clear','zth');
 */	 
	  
}

function closeDialog(){
	$("#banktype_a").combobox('clear');
	$("#feetype_a").textbox('clear');
 	$("#bz1_a").textbox('clear');
   $('#bz2_a').textbox('clear');
   $('#yhdzhds').dialog('close');
 
}
function saveInfonew(op){
	 var bankcode= $("#banktype_a").combobox('getValue');
	 var bankname= $("#banktype_a").combobox('getText');
	 var feetype= $("#feetype_a").textbox('getValue');
	 var bz1= $("#bz1_a").textbox('getValue');
	 var bz2= $("#bz2_a").textbox('getValue');
	 
	 if(bankcode==''||feetype==''){
		 $.messager.alert('提示','银行和费用类型必须填写 ，不能为空!');
	 }
	 if(bz1==''&&bz2==''){
		 $.messager.alert('提示','备注1筛选和备注2筛选不可同时为空，!');
	 }

	$.ajax({
		url:"<%=cp%>/guzhidz/searchbankfeetype?op="+op,
		type:'post',
		data:{bankcode:bankcode,bankname:bankname,feetype:feetype,bz1:bz1,bz2:bz2},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				closeDialog();
				managedata('s');
			}else{
				alert("发送失败");
			}
			
		}
	});

}

</script>
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '100%' 
	});
	 //初始化table

	 $("#wbdg").datagrid({
	 	 width : '99%' 
	 });
	 $("#yhflow").datagrid({
	 	 width : '99%' 
	 });
		var curr_time = new Date();
		$("#wbdate_s").datebox("setValue", myformatter(curr_time));
		$("#wbdate_e").datebox("setValue", myformatter(curr_time));
});


function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fylx="+$("#fylx").combobox('getValue');
	$('#wbdg').datagrid({method:'get',url:"<%=cp%>/guzhidz/feeExport?"+params}); 
} 

function searchdata(){
 	var params="wbdate_s="+$("#wbdate_s").combobox('getValue')+"&wbdate_e="+$("#wbdate_e").combobox('getValue');
 	params+="&skzh="+$("#skzh").textbox('getValue')+"&skyhmc="+$("#skyhmc").textbox('getValue');
 	params+="&fkzh="+$("#fkzh").textbox('getValue')+"&fkyhmc="+$("#fkyhmc").textbox('getValue');
	$('#yhflow').datagrid({method:'get',url:"<%=cp%>/guzhidz/searchbankflow?"+params}).datagrid('clientPaging'); ; 
} 

function exportdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fylx="+$("#fylx").combobox('getValue')+"&down=1";
	var url="<%=cp%>/guzhidz/feeExportDown?"+params; 
	window.location.href=url;
	
} 

function managedata(op){
	if(op=='s'){
	 	var params="&banktype="+$("#banktype").combobox('getValue')+"&feetype="+$("#feetype").textbox('getValue');	 	
		$('#feetypedg').datagrid({method:'get',url:"<%=cp%>/guzhidz/searchbankfeetype?op="+op+params}).datagrid('clientPaging'); 
	}
	if(op=='a'){
		 $('#yhdzhds').dialog('open');
	}
	if(op=='d'){
		var row = $('#feetypedg').datagrid('getSelected');
		if (row){
			
			if(confirm("确定要删除吗？")){
			 var bankcode= row.bankcode;
			 var feetype= row.biztype;

				$.ajax({
					url:"<%=cp%>/guzhidz/searchbankfeetype?op="+op,
					type:'post',
					data:{bankcode:bankcode,feetype:feetype},
					dataType: "json",
					success: function(data){
						if(data[0].msg=="success"){  
							closeDialog();
							alert("保存成功");
						
							managedata('s');
							$('#feetypedg').datagrid('clearSelections')
						}else{
							alert("发送失败");
						}
						
					}
				});
			}
		}
		else{
			$.messager.alert('提示','请先选中一行！');

		}

	}
} 

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
<div title="费用查询" style="padding: 5px">
			<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>

					<td>费用类型：<select id="fylx"
						class="easyui-combobox" name="fylx" style="width: 100px;">
					    	<option value="0">两费及管理费</option>
							<option value="1">结息</option>
							<option value="2">汇划手续费</option>
							</select></td>
							   
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="exportdata()">导出</a>
					
					</td>		
				</tr>
		</table>
		<div style="margin-top: 10px;">
			<table id="wbdg"  class="easyui-datagrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id', singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				 ">
				<thead>
					<tr>
						<th field="wbzth"  >账套号</th>
						<th field="ztmc"  >账套名称</th>
						<th field="bfzh"  >本方账户</th>
						<th field="rq"  >日期</th>
						<th field="lb"  >类型</th>
						<th field="fsje"  >发生金额</th>

					</tr>
				</thead>
			</table>
	 </div>
	</div>
	<div title="托管户流水查询" style="padding: 5px">
			<table>
				<tr>
				<td><span>开始日期</span>
				     <input id="wbdate_s" name="wbdate_s"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
					 <span>结束日期</span>
				     <input id="wbdate_e" name="wbdate_d"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>

					<td>
					付款账号：<input class="easyui-textbox" name="fkzh"  id="fkzh"/ > 付款银行：<input class="easyui-textbox" name="fkyhmc"  id="fkyhmc"/ > </td></tr>
					 <tr><td>收款账号：<input class="easyui-textbox" name="skzh"  id="skzh"/ > 收款银行：<input class="easyui-textbox" name="skyhmc"  id="skyhmc"/ >
					<!-- 费用类型：<select id="fylx"
						class="easyui-combobox" name="fylx" style="width: 100px;">
					    	<option value="0">两费及管理费</option>
							<option value="1">结息</option>
							<option value="2">汇划手续费</option>
							</select> -->
					</td>
							   
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
								
					
					</td>		
				</tr>
		</table>
		<div style="margin-top: 10px;">
			<table id="yhflow"  class="easyui-datagrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id', singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50
				 ">
				<thead>
					<tr>
						<th field="fkzh"  >付款账号</th>
						<th field="fkyhmc"  >付款行</th>
						<th field="skzh"  >收款账号</th>
						<th field="skyhmc"  >收款行</th>
						<th field="trans_date"  >交易日期</th>
						<th field="amount"  >交易金额</th>
						<th field="bz1"  >备注1</th>
						<th field="bz2"  >备注2</th>
						

					</tr>
				</thead>
			</table>
	 </div>
	</div>
	<div title="费用类型管理" style="padding: 5px">
			<table>
				<tr>
				<td><span>银行类型</span>
				    <input id="banktype"
						class="easyui-combobox" name="banktype" style="width: 100px;">

							</> 
			     </td>

					<td>
					<span>费用类型</span>
				    <input id="feetype"
						class="easyui-textbox" name="feetype" style="width: 100px;">

							</> 
					</td>
							   
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('s')">查询</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('a')">添加</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('d')">删除</a>
					
					</td>		
				</tr>
		</table>
		<div style="margin-top: 10px;">
			<table id="feetypedg"  class="easyui-datagrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id', singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50
				 ">
				<thead>
					<tr>
						<th field="bankcode"  >银行代码(新意)</th>
						<th field="bankname"  >银行名称（新意）</th>
						<th field="biztype"  >业务类型</th>
						<th field="bz1term"  >备注1筛选条件</th>
						<th field="bz2term"  >备注2筛选条件</th>

					</tr>
				</thead>
			</table>
	 </div>
	</div>
</div>
</html>
<div id="yhdzhds" class="easyui-dialog" closed="true" title="费用类型配置"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons',
						modal:true
					">
				<span style="margin-left: 0px">银行类型:</span>
			 <input id="banktype_a"
						class="easyui-combobox" name="banktype_a" style="width: 100px;" />

						<span style="margin-left: 0px">费用类型:</span>
			 <input id="feetype_a"
						class="easyui-textbox" name="feetype_a" style="width: 100px;" />
			<br><br>
				<span style="margin-left: 0px">备注1筛选条件:</span>
				 <input id="bz1_a"
						class="easyui-textbox" name="bz1_a" style="width: 200px;" />
					<br><br>	
						<span style="margin-left: 0px">备注2筛选条件:</span>
				 <input id="bz2_a"
						class="easyui-textbox" name="bz2_a" style="width: 200px;" />
			
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew('a')">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
