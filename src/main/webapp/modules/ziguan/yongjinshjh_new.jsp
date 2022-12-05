<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>佣金</title>
    <script>document.documentElement.focus();</script>
    
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
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
	      	 height : document.documentElement.clientHeight-140
	 	 });
	 	$('#dlgReleaseTime').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                span.trigger('click'); //触发click事件弹出月份层
                if (!tds)
                    setTimeout(function () { //延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                        tds = p.find('div.calendar-menu-month-inner td');
                        tds.click(function (e) {
                            e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                            var year = /\d{4}/.exec(span.html())[0] //得到年份
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
            	var p=(d.getMonth() + 1)<10?'0'+(d.getMonth() + 1):(d.getMonth() + 1); 
            	return d.getFullYear() + '-' + p}//配置formatter，只返回年月
            //   formatter: function (d) { return d.getFullYear() + '-' + d.getMonth() ; }//配置formatter，只返回年月
            
	 	});
        var p = $('#dlgReleaseTime').datebox('panel'), //日期选择对象
            tds = false, //日期选择对象中月份
            span = p.find('span.calendar-text'); //显示月份层的触发控件
        var curr_time = new Date();

		
     
 
      
        
      
      
      
});
</script>

<!-- 自定义js -->
<script type="text/javascript">
///////////////////////////////Ajax请求///////////////////////////////////////////////////


      
      
      

function ExporterExcel() {//导出Excel文件
var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
	
	if(dlgReleaseTime==""){
		alert("请选择时间");
		return false;
	} 

			
			//alert(params.c_cp_name +":hhh:" + params.wbdate);
	 	var params="yearmonth="+dlgReleaseTime;
		var url="<%=cp%>/ziguan/getYongJinInfoshjhnew_ex?"+params; 
		window.location.href=url;
	}
	

</script>

<script type="text/javascript">

function searchdata(){
	var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
	
	if(dlgReleaseTime==""){
		alert("请选择时间");
		return false;
	} 
	
	
				
				$('#dg').datagrid({method:'post',
	             	url:"<%=cp%>/ziguan/getYongJinInfoshjhnew",
					queryParams:{yearmonth:dlgReleaseTime}
	             	}).datagrid('clientPaging'); 

	


	
	
} 
 
</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
	   
	   		 <div title="佣金查询" style="padding: 5px">
	   		
				<div style="margin-top: 5px; margin-bottom: 5px;" >
				
					  <span>时间:</span>
					  <span><input id="dlgReleaseTime" name="dlgReleaseTime" class="easyui-datebox" style="width: 150px"></input></span>
					   <span style="color: red;">*</span>
					 
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> &nbsp;&nbsp;
					   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a>&nbsp;&nbsp;
					   <br>4.3 的配置项中  ， 仅【佣金不报】起作用
					 
				</div>
				<div style="margin-top: 10px;">
					<table  id="dg" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500, pageList:[50,100,200,500]
						               ">
						<thead>
							<tr>
						<th field="ider" >序号</th>
						<th field="code" >账套号</th>
						<th field="name" width="200">账套名称</th>
						<th field="qc2206" data-options="align:'right',halign:'center',formatter:myformatter">应付管理人报酬<br>期初余额</th>
						<th field="qqw" width="100" data-options="align:'right',halign:'center',formatter:myformatter" >管理人报酬<br>期初余额调整</th>
						<th field="j2206"  data-options="align:'right',halign:'center',formatter:myformatter">管理人报酬<br>（当月借方）</th>
						<th field="d2206"  data-options="align:'right',halign:'center',formatter:myformatter" >管理人报酬<br>（当月贷方）</th>
						<th field="qm2206"  data-options="align:'right',halign:'center',formatter:myformatter">应付管理人报酬<br>余额</th>
						<th field="qc220901"  data-options="align:'right',halign:'center',formatter:myformatter">应付管理人佣金<br>期初余额</th>
						<th field="qqq" width="100" data-options="align:'right',halign:'center',formatter:myformatter">应付管理人佣金<br>期初金额调整</th>
						<th field="j220901" data-options="align:'right',halign:'center',formatter:myformatter" >管理佣金<br>（当月借方）</th>
						<th field="d220901"  data-options="align:'right',halign:'center',formatter:myformatter">管理佣金<br>（当月贷方）</th>
						<th field="qm220901"data-options="align:'right',halign:'center',formatter:myformatter">应付管理人<br>佣金余额</th>
						<th field="j220602"  data-options="align:'right',halign:'center',formatter:myformatter">业绩报酬<br>（当月借方）（含赎回）</th>
						<th field="j220602_n"  data-options="align:'right',halign:'center',formatter:myformatter">业绩报酬<br>（当月贷方）（不含赎回）</th>
						<th field="j220601"data-options="align:'right',halign:'center',formatter:myformatter">应付管理费<br>（当月借方）</th>
						<th field="guzhiuser"  >估值人员</th>
						
					</tr>
						</thead>
					</table>
				</div>
			</div>
		 

		</div>
		

         
 </body>
</html>





