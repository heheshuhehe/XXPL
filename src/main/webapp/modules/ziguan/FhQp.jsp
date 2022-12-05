<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>分红清算</title>
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
	      	 height : document.documentElement.clientHeight-150
	 	 });
	 	 	$("#wb_zth").combobox({
				  valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:'<%=cp%>/dividend/getproductcode',
			      method:'post',
			      multiple:false,
				  width:150,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							console.log(opts);
							return row[opts.textField].indexOf(q) >-1;
						},
						onSelect:function(val){
						     var zth=$("#wb_zth").combobox('getValue');
							
							 $("#zth").combobox({ 
									  valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/dividend/getzdmcode?zth='+zth,
						              method:'get',
						              multiple:false,
    					  			  width:150,
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
									 $('#wb_zth').next('.combo').find('input').focus(function (){
								            $('#wb_zth').combobox('clear');
								            $("#zth").combobox('clear');
								     });
									 
							     }
						
			 }); 	

});
</script>

<script type="text/javascript">
function searchdata(){
	  var str =$("#wbdate").combobox('getValue');
	  var strs =$("#wbdatee").combobox('getValue');
	  strs=strs.replace(/-/g,'');
	  str=str.replace(/-/g,'');
	  var se=$("#syl").textbox('getValue');
	  if(se == ""){
	    alert("请输入收益率");
		  return false;
	  }else{
	  
		  if(str=="" || strs==""){
			  alert("请选择开始日期和结束日期");
			  return false;
		  }else{
					 
			if(str>strs){
	  		 alert("请正确选择日期区间！");
		 	 return false;
	  	    }else{	 
						 
		        var params="wbdate="+str + "&wbdatee=" + strs;
		         if($("#wb_zth").combobox('getValue') == ""){
		        	alert("请选择产品代码！");
		 	 		return false;
		        }else{ 
		        
				        params +="&wb_zth="+$("#wb_zth").combobox('getValue');
				        
				        if($("#zth").combobox('getValue')!=""){
				        	params +="&zth="+$("#zth").combobox('getValue');
				        }
				        var syl=$("#syl").textbox('getValue');
				        if(syl != ""){
				        	params +="&syl="+syl;
				        }else{
				       		 params +="&syl="+1;
				        }
				    /*     var sy = $('#wrap input[name="sy"]:checked ').val();
				        var yw = $('#wrap2 input[name="yw"]:checked ').val();
				        var fhjs = $('#wrap3 input[name="fhjs"]:checked ').val();
				        var rqts = $('#wrap4 input[name="rqts"]:checked ').val(); */
				        var sy = $("#sy").combobox('getValue');
				        var yw = $("#yw").combobox('getValue');
				        var fhjs = $("#fhjs").combobox('getValue');
				        var rqts = $("#rqts").combobox('getValue'); 
				        var jsfs = $("#jsfs").combobox('getValue'); 
				        if(sy==1){
				        	params +="&sy=1";
				        }else if(sy==2){
				            params +="&sy=2";
				        
				        }
				        if(jsfs==1){
				        	params +="&jsfs=1";
				        }else if(jsfs==2){
				            params +="&jsfs=2";
				        
				        }
				        
				        if(yw==1){
				        	params +="&yw=1";
				        }else if(yw==2){
				            params +="&yw=2";
				        
				        }
				        if(fhjs==1){
				        	params +="&fhjs=1";
				        }else if(fhjs==2){
				            params +="&fhjs=2";
				        
				        }
				        if(rqts==1){
				        	params +="&rqts=360";
				        }
				        if(rqts==2){
				        	params +="&rqts=365";
				        }
				        if(rqts==3){
				        	params +="&rqts=366";
				        }
				        
				       	$('#dg').datagrid({method:'get',
							                        url:"<%=cp%>/dividend/getSettlement?"+params,
							              }).datagrid('clientPaging'); 
				  
					 }
		        
		         } 
		  }
	  }


   } 
  function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:bleak;';
		}
 }
 
 function experot(){
 	 var str =$("#wbdate").combobox('getValue');
	  var strs =$("#wbdatee").combobox('getValue');
	  strs=strs.replace(/-/g,'');
	  str=str.replace(/-/g,'');
	  var se=$("#syl").textbox('getValue');
	  if(se == ""){
	    alert("请输入收益率");
		  return false;
	  }else{
	  
		  if(str=="" || strs==""){
			  alert("请选择开始日期和结束日期");
			  return false;
		  }else{
					 
			if(str>strs){
	  		 alert("请正确选择日期区间！");
		 	 return false;
	  	    }else{	 
						 
		        var params="wbdate="+str + "&wbdatee=" + strs;
		         if($("#wb_zth").combobox('getValue') == ""){
		        	alert("请选择产品代码！");
		 	 		return false;
		        }else{ 
		        
				        params +="&wb_zth="+$("#wb_zth").combobox('getValue');
				        
				        if($("#zth").combobox('getValue')!=""){
				        	params +="&zth="+$("#zth").combobox('getValue');
				        }
				        var syl=$("#syl").textbox('getValue');
				        if(syl != ""){
				        	params +="&syl="+syl;
				        }else{
				       		 params +="&syl="+1;
				        }
				    /*     var sy = $('#wrap input[name="sy"]:checked ').val();
				        var yw = $('#wrap2 input[name="yw"]:checked ').val();
				        var fhjs = $('#wrap3 input[name="fhjs"]:checked ').val();
				        var rqts = $('#wrap4 input[name="rqts"]:checked ').val(); */
				        var sy = $("#sy").combobox('getValue');
				        var yw = $("#yw").combobox('getValue');
				        var fhjs = $("#fhjs").combobox('getValue');
				        var rqts = $("#rqts").combobox('getValue'); 
				        var jsfs = $("#jsfs").combobox('getValue'); 
				        if(sy==1){
				        	params +="&sy=1";
				        }else if(sy==2){
				            params +="&sy=2";
				        
				        }
				        if(jsfs==1){
				        	params +="&jsfs=1";
				        }else if(jsfs==2){
				            params +="&jsfs=2";
				        
				        }
				        
				        if(yw==1){
				        	params +="&yw=1";
				        }else if(yw==2){
				            params +="&yw=2";
				        
				        }
				        if(fhjs==1){
				        	params +="&fhjs=1";
				        }else if(fhjs==2){
				            params +="&fhjs=2";
				        
				        }
				        if(rqts==1){
				        	params +="&rqts=360";
				        }
				        if(rqts==2){
				        	params +="&rqts=365";
				        }
				        if(rqts==3){
				        	params +="&rqts=366";
				        }
				        
				       	//window.location.href="<%=cp%>/dividend/downLoadement?"+params; 
				  		window.location.href='<%=cp%>/dividend/downLoadement?'+params
					 }
		        
		         } 
		  }
	  }

 	
 
 }
</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
		    <div title="分红清算" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
				     <span>产品代码:</span>
				     <input class="easyui-combobox" name="wb_zth" id="wb_zth"
				       />
				     <span style="color: red;">*</span>	
				       
				     <span>子代码:</span>
				     <input class="easyui-combobox" name="zth" id="zth"
				       />
				     <span>收益率(%):</span>
				     <input class="easyui-textbox" name="syl" id="syl" style="width: 70px"/>
				     <span style="color: red;">*</span>	
				     
		             <span>开始日期</span>
				        <input id="wbdate" name="wbdate"
						       class="easyui-datebox"  style="width: 120px">
						</input>
					 <span style="color: red;">*</span>	
					 <span>结束日期</span>
				     <input id="wbdatee" name="wbdatee"
						    class="easyui-datebox"  style="width: 120px"></input>
					 <span style="color: red;">*</span>	
					   <br></br>
					 <!-- <div>
						   <div  id="wrap" style="width:400px; float :left">
						   	 <span>收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;益:</span>
							   		<input type="radio" name="sy" value="1"  id="sy" />算头不算尾&nbsp;&nbsp;
							   		<input type="radio" name="sy" value="2"  id="sy" />头尾都算 &nbsp;&nbsp;
							   
						   </div>
						   <div  id="wrap2" style="width:500px;float :left">
						  	 <span>业务:</span>
							   		<input type="radio" name="yw" value="1"  id="yw" />分红 &nbsp;&nbsp;
							   		<input type="radio" name="yw" value="2"  id="yw" />清盘&nbsp;
						   </div>
					  </div>
					   <br/>
					   <div>
						   <div  id="wrap3" style="width:400px;float :left">
						   	 <span>分红计算方式:</span>
							   		<input type="radio" name="fhjs" value="1"  id="fhjs" />单日保留两位小数 &nbsp;&nbsp;
							   		<input type="radio" name="fhjs" value="2"  id="fhjs" />总收益保留两位小数&nbsp;&nbsp;
						   </div>
						   <div  id="wrap4" style="width:500px;float :left">
							  <span>日期天数:</span>
							   		<input type="radio" name="rqts" value="1"  id="rqts" />360 &nbsp;&nbsp;
							   		<input type="radio" name="rqts" value="2"  id="rqts" />365&nbsp;&nbsp;
							   		<input type="radio" name="rqts" value="3"  id="rqts" />366&nbsp;&nbsp;
							</div>
						</div> -->
				  
				  
				  <span>分红计算方式</span>
				  <span>
				    <select class="easyui-combobox" name="fhjs" id="fhjs" style="width: 130px">
							    <option value="1">单日保留两位小数</option>
							    <option value="2">总收益保留两位小数</option>
					</select> 
				  </span>
				  <span>收&nbsp;&nbsp;益:</span>
				  <span>
				  	<select class="easyui-combobox" name="sy" id="sy" style="width: 150px">
							    <option value="2">头尾都算 </option>
							    <option value="1">算头不算尾</option>
					</select> 
				  </span>
				  <span>业 &nbsp;&nbsp;务:</span>
				  <span>
				    <select class="easyui-combobox" name="yw" id="yw" style="width: 70px">
							    <option value="1">分红</option>
							    <option value="2">清盘 </option>
					</select> 
				  </span>
				  <span>日期天数</span>
				  <span>
				    <select class="easyui-combobox" name="rqts" id="rqts" style="width: 70px">
							    <option value="2">365</option>
							    <option value="1">360</option>
							    <option value="3">366</option>
					</select> 
				  </span>
				  <span>计算方式</span>
				  <span>
				    <select class="easyui-combobox" name="jsfs" id="jsfs" style="width: 130px">
							    <option value="1">单个投资者</option>
							    <option value="2">总实收资本</option>
							   
					</select> 
				  </span>
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> &nbsp;&nbsp;
				  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="experot()">导出</a> &nbsp;&nbsp;
				  
				  <br></br>
				  </div>
				<div style="margin-top: 5px; ">
						<table id="dg" style="width: 777px; height: 480px"
							data-options="rownumbers:true,autoRowHeight:false,singleSelect:true,pagination:true,pageSize:500, pageList:[50,100,200,500]">
							<thead>
								<tr>
					              <th field="id" data-options="hidden:true"></th>
					              <th field="mjj_dm" width="100px">基金代码</th>
						          <th field="c_subfundcode" width="100px">子代码</th>
						          <th field="c_subfundname" width="100px">基金名称</th>
						          <th field="jyzh" width="100px">交易账号</th>
						          <th field="jjzh" width="100px">基金账号</th>
						          <th field="mc" width="100px">客户名称</th>
						          <th field="xl" width="100px">客户类型</th>
						          <th field="fe" width="100px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">份额</th>
						          <th field="yjfh" width="100px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">预计分红</th>
						          <th field="jsje" width="150px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">结算金额</th>				
					           </tr>		
							</thead>
					</table>
				</div>
			</div> 
 </body>
</html>





