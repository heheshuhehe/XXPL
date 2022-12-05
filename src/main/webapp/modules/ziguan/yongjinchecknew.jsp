<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>佣金</title>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>

$(function (){
		 $("#tabsidk").tabs({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-20
		 });
	 	 $("#dg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-150
	 	 });
	 	 $("#cwdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-20
	 	 });
	 	 $("#cwdg").datagrid('enableFilter');
	 	$('#dlgReleaseTime').datebox({
	 	    editable:false, 
			showSeconds : false,
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                span.trigger('click'); //触发click事件弹出月份层
                if (!tds)
                    setTimeout(function () { //延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                        tds = p.find('div.calendar-menu-month-inner td');
                        tds.click(function (e) {
                            e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                             year = /\d{4}/.exec(span.html())[0] //得到年份
                                ,
                                month = parseInt($(this).attr('abbr'), 10); //月份
                            $('#dlgReleaseTime').datebox('hidePanel') //隐藏日期对象
                                .datebox('setValue', year + '-' + month); //设置日期的值
                        });
                    }, 0);
            },
            parser: function (s) {//配置parser，返回选择的日期
                if (!s) return new Date();
                var arr = s.split('-');
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
            },
           
            formatter: function (d) {
                 var zmonth='';
	             zmonth= d.getMonth()+1;
	             if(d.getMonth()<9){
	           		 zmonth='0'+zmonth;
	             }else{
	             	zmonth=zmonth;
	             }
            
             return d.getFullYear() + '-' + (zmonth)+ '-'+ '01'; }//配置formatter，只返回年月
        });
        var p = $('#dlgReleaseTime').datebox('panel'), //日期选择对象
            tds = false, //日期选择对象中月份
            span = p.find('span.calendar-text'); //显示月份层的触发控件
        var curr_time = new Date();
    
        	$('#dlgReleaseTimeend').datebox({
        	    editable:false,
				showSeconds : false,
			})
			
<%-- 			 $("#guzhiname").combobox({
				 valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
			     method:'post',
				  multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							console.log(opts);
							return row[opts.textField].indexOf(q) >-1;
						},
						  onLoadSuccess: function(){
								 $('#guzhiname').next('.combo').find('input').focus(function (){
							            $('#guzhiname').combobox('clear');
							     });
								 
						     }
			 }); --%>
			    
});
</script>

<script type="text/javascript">
function searchdata(){
	var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
	var dlgReleaseTimeend = $("#dlgReleaseTimeend").datebox('getValue');

	
	if(dlgReleaseTime=="" && dlgReleaseTimeend==""){
		alert("请选择开始时间和结束时间");
		return false;
	}else{
			if (dlgReleaseTimeend < dlgReleaseTime){
		 		//alert("dlgReleaseTimeend"+dlgReleaseTimeend+"dlgReleaseTime"+dlgReleaseTime);
		 			alert("结束日期不能小于开始日期");
		 			return;
		 	 }else{
		 	 	//获取开始时间年份
		 	 	dlgReleaseTime.substr(0, 4);
		 	 	dlgReleaseTimeend.substr(0, 4);
		 	 	if(dlgReleaseTime.substr(0, 4) == dlgReleaseTimeend.substr(0, 4)){
			 	 	//获取结束时间年份
			 	 	var params="dlgReleaseTime="+dlgReleaseTime+"&dlgReleaseTimeend="+dlgReleaseTimeend;
	   		
					$('#dg').datagrid({method:'post',
			            url:"<%=cp%>/yongjin/getYongJincheckInfo?"+params
			        }).datagrid('clientPaging'); 
		 	 	}else{
		 	 		alert("结束日期与开始日期的年份不一致！");
		 			return;
		 	 	
		 	 	}
		 	 	
		 	 }
	} 
	
} 

function CWMXInfo(ksrq,jsrq,code,classify){
	$("#tabsidk").tabs('select', "财务明细");
	var params="ksrq="+ksrq+"&jsrq="+jsrq+"&code="+code+"&classify="+classify;
	$('#cwdg').datagrid({method:'get',url:"<%=cp%>/yongjin/CWMXInfo?"+params
	}).datagrid('clientPaging'); 
	$("#cwdg").datagrid('enableFilter');
}
 
function CWMXInfoByUser(){
	var ksrq = $("#dlgReleaseTime").datebox('getValue');
	var jsrq = $("#dlgReleaseTimeend").datebox('getValue');
	var row = $('#dg').datagrid('getSelected');
	var code = row.code;
	var classify = row.classify;
	var name = $("#guzhiname").combobox('getValue');
	var params="ksrq="+ksrq+"&jsrq="+jsrq+"&code="+code+"&classify="+classify+"&user="+name;
	$('#cwdg').datagrid({method:'get',url:"<%=cp%>/yongjin/CWMXInfoByUser?"+params
	}).datagrid('clientPaging'); 
}

function ExporterExcel(){
	var ksrq = $("#dlgReleaseTime").datebox('getValue');
	var jsrq = $("#dlgReleaseTimeend").datebox('getValue');
	var row = $('#dg').datagrid('getSelected');
	var code = row.code;
	var classify = row.classify;
	var name = $("#guzhiname").combobox('getValue');
	var params="ksrq="+ksrq+"&jsrq="+jsrq+"&code="+code+"&classify="+classify+"&user="+name;
	window.location.href='<%=cp%>/yongjin/exportexcel?'+params
}

   function myCellStyler(value,row,index){
			if (!isNaN(value)){
				return 'color:bleak;';
			}
 		}
 
</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
		    <div title="佣金核对" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
					  <span>开始时间:</span>
					  <span><input id="dlgReleaseTime" name="dlgReleaseTime" class="easyui-datebox" style="width: 150px"></input></span>
					   <span style="color: red;">*</span>
					  <span>结束时间:</span>
					  <span><input id="dlgReleaseTimeend" name="dlgReleaseTimeend" class="easyui-datebox" style="width: 150px"></input></span>
					   <span style="color: red;">*</span>
					  
					   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> &nbsp;&nbsp;
<!-- 					   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
 -->					   <br></br>
				</div>
				<div style="margin-top: 5px; ">
						<table id="dg" style="width: 777px; height: 480px"
							data-options="rownumbers:true,autoRowHeight:false,singleSelect:true,pagination:true,pageSize:500">
							
							
							<thead>
								<tr>
									<th width="180px"     rowspan="2" data-options="field:'ck',checkbox:true"></th>
			                        <th field="kmh"    width="100px"     rowspan="2">科目号</th>
			                        <th field="ztmc"  width="180px"   rowspan="2">科目名称</th>
									<th  colspan="3"  width="320px"  >期初</th>
									<th  colspan="3"  width="320px"  ><!-- 借方 --></th>
									<th  colspan="3"  width="320px"  ><!-- 贷方 --></th>
									<th  colspan="3"  width="320px"  >期末</th>
									<th field="queryinfo"  width="180px"   rowspan="2">详情</th>
								</tr>
								<tr>
								  <th field="qcgz" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统</th>
								  <th field="qcgt" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统</th>
								  <th field="qcce" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>

								  <th field="gzjf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统(借方)</th>
								  <th field="gtdf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(贷方)</th>
								  <!-- <th field="gtjf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(借方)</th> -->
								  <th field="cejf" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>
			
								  <th field="gzdf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统(贷方)</th>
								  <th field="gtjf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(借方)</th>
								  <!-- <th field="gtdf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(贷方)</th> -->
								  <th field="cedf" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>

							      
								  <th field="qmgz" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统</th>
								  <th field="qmgt" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统</th>
								  <th field="qmce" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>
							      
							      <th field = "code"  data-options="hidden:true"></th>
							      <td field = "classify"  data-options="hidden:true"></td>
							      <th field="sumnoteql" data-options="hidden:true"></th>
			                      <th field="sumbd" data-options="hidden:true"></th>
								</tr>
							</thead>
					</table>
				</div>
			</div> 
			<div title="财务明细" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
<!-- 					<span>估值人员:</span> 
						<input class="easyui-combobox" name="guzhi_name" id="guzhiname" />  -->
<!-- 						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CWMXInfoByUser()">过滤</a> --> 
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
				</div>
			<div style="margin-top: 10px;">
				<table  id="cwdg"  
				
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
					              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,gridautoScroll:true
					               ">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th> -->
							<!--<th field="kmh"    width="100px"     rowspan="2">科目号</th>
			                <th field="ztmc"  width="180px"   rowspan="2">科目名称</th> -->
							<!-- <th field="pzrq" rowspan="2" width="110" >凭证日期</th> -->
							<th field="name" width="180px" rowspan="2">名称</th>
							<th  colspan="3"  width="320px"  >期初</th>
							<th  colspan="3"  width="320px"  ><!-- 借方 --></th>
							<th  colspan="3"  width="320px"  ><!-- 贷方 --></th>
							<th  colspan="3"  width="320px"  >期末</th>
							<!-- <th field="jfye" rowspan="2" width="110" >借方余额</th>
							<th field="dfye" rowspan="2" width="110" >贷方余额</th>
							<th field="zy" rowspan="2" width="150" >摘要</th> -->
						</tr>
						<tr>
							<th field="qcgz" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统</th>
							<th field="qcgt" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统</th>
							<th field="qcce" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>

							<th field="gzjf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统(借方)</th>
							<th field="gtdf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(贷方)</th>
							<!-- <th field="gtjf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(借方)</th> -->
							<th field="cejf" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>

							<th field="gzdf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统(贷方)</th>			
							<th field="gtjf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(借方)</th>
							<!-- <th field="gtdf" width="100px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统(贷方)</th> -->
							<th field="cedf" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>

							      
							<th field="qmgz" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">估值系统</th>
							<th field="qmgt" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">财务系统</th>
							<th field="qmce" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">差额</th>
						</tr>
					</thead>
				</table>
		  </div>
		</div>
		

 </body> 
 
</html>





