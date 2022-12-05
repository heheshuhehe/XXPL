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

function modifydata(){
	var row = $('#wbdg').datagrid('getSelected');
	if(row){
		var id = row.id;
		var jyqk = row.jyqk_value;
		$('#p_dlg_edit').dialog('open');
		$('#account_id').val(id);
		$('#jyqk').combobox('setValue',jyqk);
	}
}


</script>
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '100%' 
	});
	 //初始化tablee

	 $("#wbdg").datagrid({
	 	 width : '99%' 
	 });
});



function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&userid="+$("#userInfo").combobox('getValue')+"&cplx="+$("#cplx").combobox('getValue')+"&kflx="+$("#kflx").combobox('getValue');
	$('#wbdg').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryfundinfos?"+params,onLoadSuccess:function(){
		  $(this).datagrid('clearChecked');
		   $(this).datagrid('clearSelections')
	} 
}); 
	$('#wbdg').datagrid('clearSelections');
} 

function p_closeDialog(){
	 $("#jyqk").combobox('clear');
	  $("#id").val("");
	 $('#p_dlg_edit').dialog('close');
}

function updateJyqk(){
	var id =  $("#account_id").val();
	var type = $("#jyqk").combobox('getValue');
	var rq = $("#wbdate").combobox('getValue');
	//alert(rq);
	$.ajax({
		url:'<%=cp%>/guzhidz/modifyjyqk',
		type:'post',
		data:{id:id,type:type,rq:rq},
		dataType: "json",
		success: function(data){
			if(data.msg="success"){
				 $('#p_dlg_edit').dialog('close');
				 createwbdata();
			}else{
				alert("出错了!");
			}
		}
	});
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
<div title="基金开放期查询" style="padding: 5px">
			<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>
			     <td><span>估值人员:</span> 
			<input class="easyui-combobox"
						name="userInfo" id="userInfo"
		    ></td>
					<td>产品类型：<select id="cplx"
						class="easyui-combobox" name="cplx" style="width: 100px;">
					    	<option value="0">全部</option>
							<option value="1">综合服务</option>
							<option value="2">纯外包</option>
							</select></td>
							<td>开放类型：<select id="kflx"
						class="easyui-combobox" name="kflx" style="width: 100px;">
					    	<option value="0">全部</option>
							<option value="1">固定开放</option>
							<option value="2">临时开放</option>
							</select></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
								<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifydata()">修改</a> 
					
					</td>		
				</tr>
		</table>
		<div style="margin-top: 10px;">
			<table id="wbdg"  class="easyui-datagrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id', singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500
				 ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id"  data-options="hidden:true"></th>
						<th field="wbzth"  >外包账套号</th>
						<th field="tgzth"  >托管账套号</th>
						<th field="ztmc"  >账套名称</th>
						<th field="kfzt"  >开放状态</th>
						<th field="jyqk"  >交易情况</th>
						<th field="kflx"  >开放类型</th>
						<th field="jtfs"  >业绩报酬计提方式</th>
						<th field="jtfl"  >费率</th>
				
						<th field="jyqk_value"  data-options="hidden:true"></th>
						<th field="wbgz"  >外包估值</th>
						<th field="tggz" >托管估值</th>

						
					</tr>
				</thead>
			</table>
	 </div>
	 		<!-- dialog弹出框 -->
         <div id="p_dlg_edit" class="easyui-dialog" closed="true" title="修改交易情况"
			style="width: 450px; height: 200px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			 	<input type="hidden" id="account_id" name="account_id"  value="">
			 <span style="margin-left:50px;">类&nbsp;&nbsp;型:</span> 
			 <select id="jyqk"
						class="easyui-combobox" name="jyqk" style="width: 100px;">
					    	<option value="0">无交易</option>
							<option value="1">申购</option>
							<option value="2">赎回</option>
							<option value="3">申购、赎回</option>
			 </select>
			  <br /> <br />
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="updateJyqk()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div>
	</div>
	<div title="基金开放期（月）" style="padding: 5px">
			<div id='calendar'  style="" ></div>
	</div>
	<div title="基金开放期（日）" style="padding: 5px">
			<div id='calendar2'  style="" ></div>
	</div>
</div>
</html>
