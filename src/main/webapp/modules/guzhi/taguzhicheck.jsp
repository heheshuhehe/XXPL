<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>昨日单位净值对照</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	     //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
	  var str =$("#wbdate").combobox('getValue');
	  if(str==""){
		  alert("请选择日期");
		  return false;
	  }else{
		 
        var params="wbdate="+str.replace(/-/g,'')+"&type=old";
        
        if($("#iseql").prop("checked")){
        	params +="&iseql=1";
        }
        if($("#isbd").prop("checked")){
        	params +="&isbd=1";
        }
        if($("#wb_zth").combobox('getValue')!=""){
        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
        }
        $('#dg').datagrid({method:'get',
        	               url:"guzhitacheck/getJingZhiInfo?"+params,
        	               onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
					            	     if(typeof(data.rows[0].sumnoteql)!="undefined"){
		 			            	        $("#sumnoteql").html("<span style='color:red;'>"+data.rows[0].sumnoteql+"</span>个产品代码单位净值和累计单位净值不一致!"+
		 			            	        		"<span style='color:red;'>"+data.rows[0].sumbd+"</span>个产品净值波动超过10%!");
		 			            	        
		 			            	       
					            	     }
				            	     }
				           }}).datagrid('clientPaging'); 
	  }
      
 }
 
 function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:red;';
		}
 }
 function myCellStyler1(value,row,index){
	var oDate = new Date();
	var year = oDate.getFullYear();   //获取系统的年；
	var mon =  oDate.getMonth()+1;   //获取系统月份，由于月份是从0开始计算，所以要加1
	var day = oDate.getDate(); // 获取系统日
	var str = year+""+mon+""+day;
	if(value<str){
		return 'color:#BFBCBC;';
	}
	
	
	
 }
function myformatter1(value,row,index){
 	 if(typeof(value)!='undefined'){ 
        if(!isNaN(value)){ //如果是数字 
 		 if(((value+"").indexOf("%")==-1)){//不带%号
 			  var  num = value+"";
 			  if(/^.*\..*$/.test(num)){
 			   var pointIndex =num.lastIndexOf(".");
 			   var intPart = num.substring(0,pointIndex);
 			   var pointPart =num.substring(pointIndex+1,pointIndex+5);
 			   intPart = intPart +"";
 			    var re =/(-?\d+)(\d{3})/
 			    while(re.test(intPart)){
 			     intPart =intPart.replace(re,"$1,$2")
 			    }
 			   if(pointPart.length==1){
 				   pointPart = pointPart+"000";
 			   }else if(pointPart.length==2){
 				  pointPart = pointPart+"00";
 			   }else if(pointPart.length==3){
 				  pointPart = pointPart+"0";
 			   }
 			    num = intPart+"."+pointPart;
 			  }else{
 			    var re =/(-?\d+)(\d{3})/
 			    while(re.test(num)){
 			     num =num.replace(re,"$1,$2");
 			    }
 			    num +=".0000";
 			 
 			    if(num==".0000"){
 			    	num="";
 			    }
 			    
 			  }
 			 
 			  return  "<span style='font-family:SimSun'>"+num+"</span>";
 		 }else{
 			 return "<span style='font-family:SimSun'>"+value+"</span>";
 	 	 }
 	   }else{//如果不是数字
 	      return "<span style='font-family:SimSun'>"+value+"</span>";  
 	   }
 	 }else{
 		 return "";
 	 }
 }
function myformatter2(value,row,index){
	 if(typeof(value)!='undefined'){ 
      if(!isNaN(value)){ //如果是数字 
		 if(((value+"").indexOf("%")==-1)){//不带%号
			  var  num = value+"";
			  if(/^.*\..*$/.test(num)){
			   var pointIndex =num.lastIndexOf(".");
			   var intPart = num.substring(0,pointIndex);
			   var pointPart =num.substring(pointIndex+1,pointIndex+3);
			   intPart = intPart +"";
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2")
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(num)){
			     num =num.replace(re,"$1,$2");
			    }
			    num +=".00";
			 
			    if(num==".00"){
			    	num="";
			    }
			  }
			  return  "<span style='font-family:SimSun'>"+num+"%"+"</span>";
		 }else{
			 return "<span style='font-family:SimSun'>"+value+"</span>";
	 	 }
	   }else{//如果不是数字
	       return "<span style='font-family:SimSun'>"+value+"</span>";
	   }
	 }else{
		 return "";
	 }
}
function myformatter3(value,row,index){
	 var re =/(\d{4})(\d{2})(\d{2})/
	 while(re.test(value)){
		 value =value.replace(re,"$1-$2-$3");
	 }
	 return value;
}


</script>
<body>
<div id="tabsidk" >
	<div title="昨日单位净值对照" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
	   <span>账套名称:</span>
	   <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectVal?selectType=03',
		                          method:'post',
								  multiple:false,
								  width:200,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									 });
		 }  ">
		 <span>日期</span>
	     <input id="wbdate" name="wbdate"
			class="easyui-datebox"  style="width: 120px"></input>
		  <span style="color: red;">*</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		  <br></br>
		  <input type="checkbox" name="iseql" id="iseql" value="1"/>
		  <span>只显示单位净值和累计单位净值不一致</span>
		  <input type="checkbox" name="isbd" id="isbd" value="1"/>
		  <span>只显示单位净值波动超过10%的产品</span>
		</div>
		
	   <div style="margin-top: 5px; margin-bottom: 5px;float: right" id="sumnoteql"></div>
		
	   <div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="rownumbers:true,autoRowHeight:false,pagination:true,pageSize:500,
				             rowStyler: function(index,row){
				                      var str='';
									  if(index%2==0){
									    str='background-color:#D9EEEE;';
									  }
									  if(typeof(row.bdpd)!='undefined' && (row.bdpd+'').indexOf('span')==-1){
									     str='background-color:#EFF29A;';
									  }
									  if(!isNaN(row.ch1)||!isNaN(row.ch2)||!isNaN(row.ch4)){
									  str='background-color:#F6BCBC;';
									  }
									  return  str;
								}">
				<thead>
					<tr>
                        <th field="ztmc"    width="180px"     rowspan="2">基金名称</th>
                        <th field="status"  width="60px"   rowspan="2">状态</th>
                        <th field="endDate" width="70px" rowspan="2" data-options="styler:myCellStyler1,formatter:myformatter3">封闭结束日</th>
						<th   colspan="3">产品代码</th>
						<th   colspan="3">产品份额</th>
					    <th   colspan="3">昨日单位净值</th>
						<th   colspan="3">T-1日单位净值</th>
						<th   colspan="3">累计单位净值</th>
					</tr>
					<tr>
					  <th field="ta" width="44px" >自建TA</th>
					  <th field="gz" width="44px" >估值</th>
					  <th field="zth" width="42px" >账套号</th>
					  
					  <th field="ta1" width="90px"  data-options="align:'right',formatter:myformatter">自建TA</th>
					  <th field="gz1" width="90px"  data-options="align:'right',formatter:myformatter">估值</th>
					  <th field="ch1" width="90px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">差额</th>
					  
					  <th field="ta2" width="50px" data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="gz2" width="50px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ch2" width="50px"  data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
					  
					  <th field="ta3" width="50px"   data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="fudu" width="50px"  data-options="align:'right',formatter:myformatter2">幅度</th>
					  <th field="bdpd" width="50px"  data-options="align:'right',formatter:myformatter2">波动判断</th>
					  
					  <th field="ta4" width="50px" data-options="align:'right',formatter:myformatter1">自建TA</th>
					  <th field="gz4" width="50px" data-options="align:'right',formatter:myformatter1">估值</th>
					  <th field="ch4" width="50px" data-options="align:'right',formatter:myformatter1,styler:myCellStyler">差额</th>
				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<!-- 添加备注 -->
<div id="dlg" class="easyui-dialog" closed="true" title="添加备注信息"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>账套名称:</span> 
			<span> 
				<input type="text" class="easyui-textbox" id="account_name" name="account_name">
						 
			</span>
			<br/><br/>
			<span >开始时间:</span>
			<input id="startdate" name="startdate"
			class="easyui-datebox"  style="width: 172px" editable="false"></input>
			<span>结束时间:</span>
			<input id="enddate" name="enddate"
			class="easyui-datebox"  style="width: 172px" editable="false"></input>
			<br/><br/>
			<span >备&nbsp;&nbsp;注:</span>
			<span> 
			 	<input  class="easyui-textbox" id="remark_s" name="remark_s"style="width: 408px; height:100px;" data-options="multiline:true">
			</span>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
		<div id="REMARK" class="easyui-dialog" closed="true" title="查看备注信息"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
			<span>日&nbsp;&nbsp;期:</span>
			<input id="dates" name="dates"
			class="easyui-textbox"  style="width: 172px"></input>
			<!--<span>更新时间:</span>
			<input id="updates" name="updates"
			class="easyui-textbox"  style="width: 172px"></input>
			 <span>操作者 :</span>
			<input id="upuser" name="upuser"
			class="easyui-textbox"  style="width: 172px"></input> -->
			<br/><br/>
			<span >备&nbsp;&nbsp;注:</span>
			<span> 
			 	<input type="text"  class="easyui-textbox" id="remark_ss" name="remark_ss"style="width: 408px; height:100px;" data-options="multiline:true">
			</span>
				<br/><br/>
			
			
		</div>
		<div id="dlg-buttons">
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> --> 
				<a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
</div>
</body>



