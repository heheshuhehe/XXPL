<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <%@include file="/modules/guzhi/resoures.jsp"%>	
 <base href="<%=basePath%>" /> 
 <script>document.documentElement.focus();</script>
 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>备付金与柜台核对</title>
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
	     	 height : document.documentElement.clientHeight-140
		 });
		 $("#dg_sz").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-140
		 });
		
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


</script>
<!-- 配置js -->
<script type="text/javascript">
function searchPeizhi(){
     	var params ="pz_zth="+$("#pz_zth").combobox('getValue');
     	 $('#pz_dg').datagrid({method:'get',
             url:"ZGBFJ/getJingZhiInfoPeizhi?"+params,
             onLoadSuccess:function(data){
	            	     if(data.rows.length>0){
		            	     if(typeof(data.rows[0].sumnoteql)!="undefined"){
		            	        $("#sumnoteql").html("<span style='color:red;'>"+data.rows[0].sumnoteql+"</span>个产品代码单位净值和累计单位净值不一致!"+
		            	        		"<span style='color:red;'>"+data.rows[0].sumbd+"</span>个产品净值波动超过10%!");
		            	        
		            	       
		            	     }
	            	     }
	           }}).datagrid('clientPaging'); 
}
function deletePeizhi(){
	if($("input[name='ck']:checked").length==0){
		alert("请选择要删除的数据");
	    return false;
	}else{
		var ids ="";
		$.each($("input[name='ck']:checked"),function(){
			ids +=$(this).val()+",";
		});
	    if(ids!=""){
		    ids = ids.substring(0,ids.length-1);
			$.ajax({
				url:'<%=cp%>/guzhidz/deleteJingZhiInfoPeizhi',
				type : 'post',
				data : {IDS : ids},
				dataType : "json",
				success : function(data) {
						alert("删除成功！");
						searchPeizhi();
				}
			});
	    }
	}
	
}
function adddata(){
	if($("#pz_zth_add").combobox('getValue')!=""){
		 var code = $("#pz_zth_add").combobox('getValue');
		 var name=  $("#pz_zth_add").combobox('getText');
		 $.ajax({
				url:'<%=cp%>/guzhidz/addJingZhiInfoPeizhi',
				type : 'post',
				data : {code : code,
					    name : name
					    },
				dataType : "json",
				success : function(data) {
					    alert("添加成功！");
					    closeDialog();
						searchPeizhi();
				}
			});
		 
	}else{
		alert("请选择账套名称");
		return false;
	}
}
function closeDialog(){
	$('#pz_zth_add').combobox('clear');
	$('#dlg').dialog('close');
}

</script>
 <!-- 自定义js -->
 <script type="text/javascript">

function filecloseDialog(){
	$('#files').textbox('clear');
	$('#filevalue').combobox('clear');
	$('#wbdates').datebox('clear');
	$('#wbdatee').datebox('clear');
	$('#filedlg').dialog('close');
}

 
 
 function searchdata(){
	  var str =$("#wbdate").combobox('getValue');
	  var strs =$("#wbdatee").combobox('getValue');
	  strs=strs.replace(/-/g,'');
	  if(str=="" || strs==""){
		  alert("请选择开始日期和结束日期");
		  return false;
	  }else{
			
        var params="wbdate="+str.replace(/-/g,'') + "&wbdatee=" + strs;
        if($("#wb_zth").combobox('getValue')!=""){
        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
        }
        $('#dg').datagrid({method:'get',
        	               url:"ZGBFJ/getjiJingInfo?"+params,
				           }).datagrid('clientPaging'); 
	  }
      
 }
  
 function queryZTKMInfo(rq,zth,gth,km_name){
	/* var gth=$("input[name='ck']:checked").closest("tr").find("td[field='zc_code']").text();
	var rq=$("input[name='ck']:checked").closest("tr").find("td[field='rq']").text();
	var zt_code=$("input[name='ck']:checked").closest("tr").find("td[field='zt_code']").text(); */
	//alert("帐套号："+zth+"柜台号："+gth+"日期："+rq+"类别："+km_name);
	if(gth==""){
		alert("请选择一条要查看的数据");
		return false;
	}else{
	$("#tabsidk").tabs('select', "检查产品持有证券份额及市值");
	 	var params="gth="+gth+"&rq="+rq+"&zth="+zth+"&km_name="+km_name;
	}
	$('#dg_sz').datagrid({method:'get',
        	               url:"ZGBFJ/getshizhiInfo?"+params,
				           }).datagrid('clientPaging'); 
				           
				           
				           
				           
	 /* var datebatch = $("#wbdatebatch").datebox('getValue');//日期
	// var wbzthbatch = $("#wbzthbatch").combobox('getValue')//基金号
 
	 $("#wbdate").datebox('setValue',datebatch);
	 $("#wbzth").combobox('setValue',id);
	 $("#level").combobox('setValue',5);
	 
	 searchdata();//根据查询条件查询数据 */
	 
 }
 function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:bleak;';
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
 			    var re =/(-?\d+)(\d{3})/;
 			    while(re.test(intPart)){
 			     intPart =intPart.replace(re,"$1,$2");
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
 			    var re =/(-?\d+)(\d{3})/;
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
			    var re =/(-?\d+)(\d{3})/;
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2");
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/;
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
	 var re =/(\d{4})(\d{2})(\d{2})/;
	 while(re.test(value)){
		 value =value.replace(re,"$1-$2-$3");
	 }
	 return value;
}

</script>
<body>
<div id="tabsidk"  class="easyui-tabs" style="width: 100%px">
<!-- 1 -->
	<div title="备付金与柜台核对信息" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
		 <span>基金账套号:</span>
		 <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/ZGBFJ/queryGWDSelectVal?selectType=02',
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
		  &nbsp;
		  <span>开始日期</span>
	      <input id="wbdate" name="wbdate"
			class="easyui-datebox"  style="width: 120px"></input>
			<span style="color: red;">*</span>	
		 <span>结束日期</span>
	      <input id="wbdatee" name="wbdatee"
			class="easyui-datebox"  style="width: 120px"></input>
		 <span style="color: red;">*</span>	
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		  <!-- <a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-add'"
						onclick="$('#filedlg').dialog('open')">新增</a>
          <br></br>
		  <input type="checkbox" name="iseql" id="iseql" value="1"/>
		  <span>只显示单位净值和累计单位净值不一致</span>
		  <input type="checkbox" name="isbd" id="isbd" value="1"/>
		  <span>只显示单位净值波动超过10%的产品</span>-->
		</div> 
		
	   <div style="margin-top: 5px; margin-bottom: 5px;float: right" id="sumnoteql"></div>
		
	   <div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="rownumbers:true,autoRowHeight:false,singleSelect:true,pagination:true,pageSize:500">
				<thead>
					<tr>
						<!-- <th width="180px"     rowspan="2" data-options="field:'ck',checkbox:true"></th> -->
                        <th field="rq"    width="180px"     rowspan="2">日期</th>
                        <th field="zt_code"  width="180px"   rowspan="2">帐套号</th>
                        <th field="zt_name"  width="180px"   rowspan="2">帐套名称</th>
                        <th field="km_name"  width="180px"   rowspan="2">科目名称</th>
                       <!--  <th field="gw_cust" width="180px" rowspan="2" data-options="styler:myCellStyler1,formatter:myformatter3">资产账号</th> -->
                        <th field="zc_code" width="180px" rowspan="2">资产账号</th>
						<th   colspan="3"  width="180px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">科目余额</th>
						<th field="gw_xq"    width="180px"     rowspan="2">详情</th>
					</tr>
					<tr>
					  <th field="gzye" width="60px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">估值系统</th>
					  <th field="taye" width="60px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">柜台系统</th>
					  <th field="zthye" width="60px" data-options="align:'right'">差额</th>

				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
		</div>
		
	
		<!-- 2   -->
	<div title="检查产品持有证券份额及市值" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;float: right" id="sumnoteql"></div>
		
	   <div style="margin-top: 10px;">
			<table id="dg_sz" style="width: 777px; height: 480px"
								data-options="rownumbers:true,autoRowHeight:false,pagination:true,pageSize:500">

				<thead>
					<tr>
						<!-- <th field="ztmc"    width="130px"     rowspan="2" data-options="field:'ck',checkbox:true">序号</th> -->
                        <th field="ztmc1"    width="130px"     rowspan="2">类别</th>
                        <th field="sc"  width="130px"   rowspan="2">市场</th>
                        <th field="cust_no"  width="150px"   rowspan="2">资产账号</th>
                        <th field="gpdm"  width="150px"   rowspan="2">股票代码</th>
                        <th field="gpmc" width="150px" rowspan="2">股票名称</th>
						<th   colspan="3"  width="270px">股份数量</th>
						<th   colspan="3"  width="270px">市值</th>
					</tr>
					<tr>
					  <th field="ccsl" width="90px" data-options="align:'right',formatter:myformatter,styler:myCellStyler">估值</th>
					  <th field="ggfsl" width="90px" data-options="align:'right',formatter:myformatter,styler:myCellStyler">柜台</th>
					  <th field="ce" width="90px"  data-options="align:'right'">差额</th>
					 
					  <th field="ccsz" width="90px" data-options="align:'right',formatter:myformatter,styler:myCellStyler">估值</th>
					  <th field="gsz" width="90px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">柜台</th>
					  <th field="chaer" width="90px" data-options="align:'right'">差额</th>

				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>
