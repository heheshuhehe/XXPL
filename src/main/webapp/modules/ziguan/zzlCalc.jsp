<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>账套对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 --> 
<script type="text/javascript">
 $(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
	 	 height : document.documentElement.clientHeight-20
	 });
	//初始化table
	 $("#dg").datagrid({
	 	 width : '100%',
   	     height :document.documentElement.clientHeight-130
	 });	
	
	 
	 
 	 
 $('#tabsidk').tabs({
    border:false,
    onSelect:function(title,index){
        searchdata();
        typsearchdata();
        stasearchdata();
    }
});
	 
 $("#zth").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
     method:'post',
	  multiple:false,
	  width:180,
	  filter: function(q, row){
				var opts = $(this).combobox('options');
				console.log(opts);
				return row[opts.textField].indexOf(q) >-1;
			},
	  onLoadSuccess: function(){
				 $('#zth').next('.combo').find('input').focus(function (){
			            $('#zth').combobox('clear');
			            
			     });
				 
		     }
 });

 $("#guzhiname").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
     method:'post',
	  multiple:false,
	  width:140,
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
 });
    
		 $("#fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:120,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onSelect:function(val){
					    
						 $("#secondtype").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
					              method:'get',
								  multiple:false,
								  width:120,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
							      onLoadSuccess: function(){
							    	  $(this).combobox('enable');
								  }		
					    });
					},
					  onLoadSuccess: function(){
								 $('#fristtype').next('.combo').find('input').focus(function (){
							            $('#fristtype').combobox('clear');
							            $('#secondtype').combobox('clear');
							     });
								 
						     }
					
		 }); 
 });


	
</script>
<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
    var params="zth="+$("#zth").combobox('getValue')+"&guzhiname="+$("#guzhiname").combobox('getValue')+
                    "&fristtype="+$("#fristtype").combobox('getValue')+"&secondtype="+$("#secondtype").combobox('getValue')+
                    "&report_year="+$("#report_year").combobox('getValue')+"&report_quar="+$("#report_quar").combobox('getValue');
                    
    $('#dg').datagrid({method:'get',url:"ziguan/queryzzlCalc?"+params}).datagrid('clientPaging'); 
}





</script>
<body>
	<div id="tabsidk"  class="easyui-tabs" style="">
	 <div title="账套信息" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<div>
				    <span style="margin-left: 15px;">账套名称:</span>
						<input class="easyui-combobox" name="zt_logo" id="zth"
						>
						<span id="report_name0"> 年度  </span>  <select id="report_year" class="easyui-combobox" name="report_year" style="width: 80px;">
					<option value="2021">2021</option>
					<option value="2020">2020</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
					<option value="2016">2016</option>
					
				</select>  <span id="report_name1"> 季度  </span> 
				  <select id="report_quar" class="easyui-combobox" name="report_quar" style="width: 80px;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">年度</option>
					
				</select>
					<span style="margin-left: 15px;">估值人员:</span> 
						<input class="easyui-combobox" name="guzhi_name"
						id="guzhiname"> 
					
			
				</div>
					
				<div style="margin-top:10px; margin-left: 15px; ">
				<span style="margin-left: 0px;">一级分类:</span>
						<input class="easyui-combobox" name="ziguan_logo" id="fristtype">
					<span style="margin-left: 15px;">二级分类:</span>
						<input class="easyui-combobox" name="ziguan_logo" id="secondtype" style="width:120px">
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		      </div>
			</div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							 <th field="c_port_code" >账套号</th>
							<th field="c_port_name" >账套名称</th>
							<th field="d_establish" >成立日期</th>
							<th field="zjzzl" >增值增长率</th>
							<th field="zjzzl_gs" >增值增长率计算过程</th>
							<th field="ljzjzzl" >累计增值增长率</th>
							<th field="ljzjzzl_gs" >累计增值增长率计算过程</th>
													
						</tr>
					</thead>
				</table>
			</div>
		</div>
	
	



</body>



