<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="resoures.jsp"%>
<base href="<%=basePath%>" />
<script>document.documentElement.focus();</script>

<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科目对应关系配置</title>
</head>
<script type="text/javascript">
	$(function() {
		$("#tabsidk").tabs({
			width : '100%',
			height : 480
		});
		$("#dg").datagrid({
			width : '100%',
			height : document.documentElement.clientHeight - 80
		});
	});
</script>

<!-- 自定义js -->
<script type="text/javascript"> 
var isselect = false;

function searchdata(){
	if($("#c_occur_date").datebox("getValue")==""){
		alert("请选择日期！");
		return false;
	}else{
		/* var params="businessname="+$("#businessname").combobox('getValue'); */
   		var params="c_occur_date="+$("#c_occur_date").datebox('getValue')+"&businessname="+$("#businessname").combobox('getValue');
   		
		$('#dg').datagrid({method:'get',url:"<%=cp%>/guzhisasb/getszjzyw?" + params}).datagrid('clientPaging');
		
	}
		isselect = true;

	};

	function exportDBF() {
	
	jQuery.download = function(url, data, method){
	    // 获得url和data
	    if( url && data ){ 
	        // data 是 string 或者 array/object
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 把参数组装成 form的 input
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request发送请求
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
	
		if (!isselect){
			alert("请先查询!");
			return false;
		}

		if ($("#c_occur_date").datebox("getValue") == "") {
			alert("请选择日期！");
			return false;
		}
		
		var params="c_occur_date="+$("#c_occur_date").datebox('getValue')+"&downloadName="+new Date().getTime()+"&businessname="+$("#businessname").combobox('getValue');
		
		$.download('guzhisasb/downloadszjzyw',params,'post');
		
	};
	
	//弹出加载层
	function load(msg) {
		$("<div class=\"datagrid-mask\"></div>").css({
			display : "block",
			width : "100%",
			height : $(window).height()
		}).appendTo("body");
		$("<div class=\"datagrid-mask-msg\"></div>").html(msg + "，请稍候。。。")
				.appendTo("body").css({
					display : "block",
					left : ($(document.body).outerWidth(true) - 190) / 2,
					top : ($(window).height() - 45) / 2
				});
	}
	//取消加载层  
	function disLoad() {
		$(".datagrid-mask").remove();
		$(".datagrid-mask-msg").remove();
	}
</script>

<body>
	<div style="margin-top: 5px; margin-bottom: 5px;">
	     <span>业务类型:</span> <input class="easyui-combobox" name="businessname"
				id="businessname"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhi/getUsername',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											}
									 ">
		 <span style="margin-left: 15px;">日期</span>
		 <span> 
		 <input
			id="c_occur_date" name="c_occur_date" class="easyui-datebox"
			style="width: 150px">
		</input> </span> 
		<span style="color: red;">*</span> <a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> </span> <a
			href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'" onclick="exportDBF()">导出DBF</a>
	</div>
	<div style="margin-top: 10px;">
		<table id="dg" style="width: 770px; height: 480px"
			data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
			<thead>
				<tr>
					<th field="wb_zth" width="100">帐套号</th>
					<th field="cust_name" width="100">柜台名称</th>
					<th field="cust_no" width="100">柜台号</th>
					<th field="bname" width="150">业务类型</th>
					<th field="fund_chg" width="150">发生额</th>
					<th field="fund_bal" width="150">余额</th>
					<th field="occur_date" width="80">日期</th>
				</tr>
			</thead>
		</table>
	</div>
</body>
</html>