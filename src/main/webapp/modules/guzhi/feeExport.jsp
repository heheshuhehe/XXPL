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
    var curr_time = new Date();
	$("#wbdate").datebox("setValue", myformatter(curr_time));

	 //初始化table
	 $("#wbdg").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-80
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
});


function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fylx="+$("#fylx").combobox('getValue');
	$('#wbdg').datagrid({method:'get',url:"<%=cp%>/guzhidz/feeExport?"+params}).datagrid('clientPaging'); 
} 

function exportdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fylx="+$("#fylx").combobox('getValue')+"&down=1";
	var url="<%=cp%>/guzhidz/feeExportDown?"+params; 
	window.location.href=url;
	
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
</div>
</html>
