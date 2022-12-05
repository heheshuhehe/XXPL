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
    
</head>
<!-- 日期框 -->
<script type="text/javascript">  
$(function() { 
		
	    var ntime = new Date();
		var strDate = ntime.getFullYear();
		 
		//$('#cc').combobox('setValue', '2017');  
		
		//
		
		var thisMonth=new Date().getUTCMonth()+1;//本月
		
	/* 	第一季度  1月1日 - 3月31日
		第二季度  4月1日 - 6月30日 
		第三季度  7月1日 - 9月30日
		第四季度 10月1日 -12月31日 */
		if(thisMonth <= 3){
		  $("#cc").combobox('setValue',strDate-1); 
		  $('#ccc').combobox('setValue', '4');
		}else if(thisMonth <= 6 && thisMonth >3){
		   $("#cc").combobox('setValue',strDate);
		   $('#ccc').combobox('setValue', '1'); 
		}else if(thisMonth <= 9 && thisMonth >6){
		   $("#cc").combobox('setValue',strDate);
		   $('#ccc').combobox('setValue', '2'); 
		}else if(thisMonth <= 12 && thisMonth >9){
		   $("#cc").combobox('setValue',strDate);
		   $('#ccc').combobox('setValue', '3'); 
		   
		}
		       $('#datetime1').datebox({    
		              onShowPanel : function() {// 显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层    
		                  span.trigger('click'); // 触发click事件弹出月份层    
		                  if (!tds)    
		                      setTimeout(function() {// 延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔    
		                          tds = p.find('div.calendar-menu-month-inner td');    
		                          tds.click(function(e) {    
		                              e.stopPropagation(); // 禁止冒泡执行easyui给月份绑定的事件    
		                              var year = /\d{4}/.exec(span.html())[0]// 得到年份    
		                              , month = parseInt($(this).attr('abbr'), 10) + 1; // 月份    
		                              $('#datetime1').datebox('hidePanel')// 隐藏日期对象    
		                              .datebox('setValue', year + '-' + month); // 设置日期的值    
		                           });    
		                      }, 0);    
		               },    
		               parser : function(s) {// 配置parser，返回选择的日期    
		                  if (!s)    
		                      return new Date();    
		                  var arr = s.split('-');    
		                  return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);    
		               },    
		              formatter : function(d) {    
		                  var month = d.getMonth();  
		                  if(month<=10){  
		                      month = "0"+month;  
		                  }  
		                   if (d.getMonth() == 0) {    
		                      return d.getFullYear()-1 + '-' + 12;    
		                  } else {    
		                        return d.getFullYear() + '-' + month;    
		                    }    
		                }// 配置formatter，只返回年月    
		            });     
		            var p = $('#datetime1').datebox('panel'), // 日期选择对象    
		            tds = false, // 日期选择对象中月份    
		            span = p.find('span.calendar-text'); // 显示月份层的触发控件    
		            
		      });    
		      
</script>  
<script type="text/javascript">
/*=================导出  */
	/*导出excel 按钮*/ 
function outFile(){
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
	var selrow=$("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked");
	if (selrow.length == 0) {
		alert("请选择1条要导出的数据");
		return false;
		
	} else {
		var nf = $("#cc").combobox("getValue");
		
		var jd = $("#ccc").combobox("getValue");
		
		var jdStartdate = getjdfirstdate(jd);
		
		var jdLastdate = getjdlastdate(jd);
	
		var rows = $('#dg').datagrid('getSelected');
		
		var jjbh = rows.cac;
		
		var sjdm = getsjdm();
		
		
		var ids="";
		$.each(selrow,function(i ,n){
			ids += $(this).val()+",";
		});
		if(ids != ""){
		ids =ids.substring(0,ids.length-1);
		var time = new Date().getTime();
		var param = "jjbh="+jjbh +"&jdStartdate="+jdStartdate +"&jdLastdate="+jdLastdate+"&nf="+nf +"&sjdm="+sjdm +"&ids="+ids+"&time="+time;
		$.ajax({
			type : 'POST',
			url : 'guzhi/exportsmjb?'+param,
			dataType : 'json',
			beforeSend : function() {
				load("正在导出中，请稍后...");
			},
			complete : function() {
				disLoad();
			},
			success : function(data) {
				disLoad();
 				$.download('guzhi/downloadsmjb',param,'post');
				alert("下载完成！");
				searchdata();
			},error : function() {
				alert("系统异常！");
			}
		});
 		 
		}
		
	}

}
		
							
$(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
     	 height : 480
	 });
	 $("#dg").datagrid({
	 	 width : '100%',
     	 height : 390
	 });
	  
});

function searchdata(){
    var params="zth="+$("#zth").combobox('getValue');
    
    
	 $('#dg').datagrid({method:'get',
	 url:"guzhi/getNameout?"+params
	 }).datagrid('clientPaging'); 
}



//弹出加载层
	function load(msg) {
		$("<div class=\"datagrid-mask\"></div>").css({
			display : "block",
			width : "100%",
			height : $(window).height()
		}).appendTo("body");
		$("<div class=\"datagrid-mask-msg\"></div>").html(msg)
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
	
	function getjdfirstdate(s){
		if (s == 1){
			return "0101";
		} else if (s == 2){
			return "0401";
		} else if (s == 3){
			return "0701";
		} else if (s == 4){
			return "1001";
		}
	}
	
	function getjdlastdate(s){
		if (s == 1){
			return "0331";
		} else if (s == 2){
			return "0630";
		} else if (s == 3){
			return "0930";
		} else if (s == 4){
			return "1231";
		}
	}
	
	/*获取上季度末*/
	function getsjdm(){
		var nf = $("#cc").combobox("getValue");
		var jd = $("#ccc").combobox("getValue");
		var yf = getjdlastdate(jd);
		if (yf == "1231"){
			return nf + "0930";
		} else if (yf == "0930"){
			return nf +"0630";
		} else if (yf == "0630"){
			return nf +"0331";
		} else if (yf == "0331"){
			return (nf -1) + "1231";
		}
	}

</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="基金报表" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称</span> 
			<input class="easyui-combobox" type="text"
						name="text" id="zth" 
						 data-options=		 "valueField: 'text',
	  										  textField: 'value',
											  mode:'local',
											  url:'<%=cp%>/guzhi/queryVBname?selectType=01',
					                          method:'post',
											  multiple:false,
											  width:150,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}" 	
		    >
<!-- 		    <label class="ui-label">年度</label>
		    <input class="easyui-combobox ui-text" id="yearChoose" style="width: 80px"> 
		    <label class="ui-label">月份</label>
		    <input class="easyui-combobox ui-text" id="monthChoose" style="width: 80px"> --> 
		  <!--   <select class="easyui-combobox" id="cbYearContrast" name="select" panelHeight="auto" style="width:80px; padding-top:5px; margin-top:10px;">
  			</select>  -->
		    
		    
		    <span style="margin-left: 15px;">年度 </span>  	
		    <select id="cc" class="easyui-combobox" value="2016" name="nf" style="width:80px;">  
			    <option value="2010">2010</option>   
			    <option value="2011">2011</option>   
			    <option value="2012">2012</option>   
			    <option value="2013">2013</option>   
			    <option value="2014">2014</option>
			    <option value="2015">2015</option>
			    <option value="2016">2016</option>   
			    <option value="2017">2017</option>   
			    <option value="2018">2018</option>   
			    <option value="2019">2019</option>
			    <option value="2020">2020</option>
			    <option value="2021">2021</option>   
			    <option value="2022">2022</option>   
			    <option value="2023">2023</option>   
			    <option value="2024">2024</option>
			    <option value="2025">2025</option>
			</select>
			<span style="margin-left: 15px;">季度 </span>  
			<select id="ccc" class="easyui-combobox" name="jd" style="width:80px;">   
			    <option  value="1">1季度</option>   
			    <option  value="2">2季度</option>   
			    <option  value="3">3季度</option>   
			    <option  value="4">4季度</option>     
			</select>  

		   <span style="margin-left: 15px;"></span>  	
		   <span hidden><input id="datetime1" name="datetime1" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;"></span>
		   <span style="color: red;"></span>		 			
		   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		   <a href="javascript:void(0)" class="easyui-linkbutton"
                data-options="iconCls:'icon-save'" onclick="outFile()">导出</a> 
			
<!--	  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savedata()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removedata()">删除</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveAllData()">批量保存</a>-->
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
                        <th field="accountmappingid" data-options="hidden:true"></th>
						<th field="cac" width="150px">基金编号</th>
						<th field="cpn" width="350px">基金名称</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
</html>
