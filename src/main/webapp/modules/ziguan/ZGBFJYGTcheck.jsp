<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>科目对应关系配置</title>
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
var mydate_server = '${mydate}' ;
var wbzth_server='${wbzth}';
$(function (){
		//初始化tab页
		$("#tabsidk").tabs({
			width : '100%',
			height : document.documentElement.clientHeight-20
		});
		 
		 $("#dgl").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-140
		 });
		 $("#dgl1").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-160)
		 });
		 $("#dgl2").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-160)
		 });
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
       
       if(mydate_server!=""&&wbzth_server!=""){
    	   $("#wb_zth").combobox('setValue',wbzth_server);
    	   $("#d_ywrq").datebox('setValue',mydate_server);
    	   searchdata();
      }
       
       
       
});
  
 
function ExporterExcel() {//导出Excel文件
	if($("#d_ywrq").datebox("getValue")==""){
		alert("请选择日期！");
		return false;
	}else{
   		var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&wb_ztmc="+$("#wb_zth").combobox('getText')+
   		"&d_ywrq="+$("#d_ywrq").datebox('getValue')+"&userInfo="+$("#userInfo").combobox('getValue')+"&tgiseql="+$("#tgiseql").combobox('getValue')+
   		"&wbiseql="+$("#wbiseql").combobox('getValue')+"&d_ywrq_end="+$("#d_ywrq_end").datebox('getValue');
   		 window.location.href="<%=cp%>/guzhidz/getShiZhiInfoDown?"+params;
	}
}
</script>
 
<!-- 自定义js -->
<script type="text/javascript">
function zgbfjsearchdata(){
	<%-- if($("#d_ywrq").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
   		var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&wb_ztmc="+$("#wb_zth").combobox('getText')+
   		"&d_ywrq="+$("#d_ywrq").datebox('getValue')+"&userInfo="+$("#userInfo").combobox('getValue')+"&tgiseql="+$("#tgiseql").combobox('getValue')+
   		"&wbiseql="+$("#wbiseql").combobox('getValue')+"&d_ywrq_end="+$("#d_ywrq_end").datebox('getValue');
		$('#dgl').datagrid({method:'get',
			               url:"<%=cp%>/zgbfj/getnewJingZhiInfo?"+params,
			               onLoadSuccess:function(data){
			            	     if(data.rows.length>0){
				            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
	 			            	        $("#noteqlNum").html("不一致总数:<span style='color:red;'>"+data.rows[0].noteqlnum+"</span>");
				            	     }
			            	     }else{
			            	    	 $("#noteqlNum").html("");
			            	     }
			            		
			               }
			              }).datagrid('clientPaging'); 
		
	
	} --%>
	  var str =$("#d_ywrq").combobox('getValue');
	  var strs =$("#d_ywrq_end").combobox('getValue');
	  strs=strs.replace(/-/g,'');
	  str=str.replace(/-/g,'');
	  if(str=="" ){
		  alert("请选择日期起！");
		  return false;
	  }else{
	  	if(strs==""){
	  	strs=str;
	  	}
	  	if(str>strs){
	  		alert("请正确选择日期区间！");
		 	return false;
	  	}else{
	  	
	        var params="d_ywrq="+str.replace(/-/g,'') + "&d_ywrq_end=" + strs+"&tgiseql="+$("#tgiseql").combobox('getValue')+"&wbiseql="+$("#wbiseql").combobox('getValue');
	        if($("#wb_zth").combobox('getValue')!=""){
	        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
	        }
	        $('#dgl').datagrid({method:'get',
	        	               url:"zgbfj/getbfjgtInfo?"+params,
	        	                onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
					            	      if(typeof(data.rows[0].noteqlnum)!="undefined"){
		 			            	        $("#noteqlNum").html("<span style='font-size:8px;'>融资融券不一致总数不一致总数:</span><span style='color:red;font-size:8px'>"+data.rows[0].noteqlnum+"</span>"+
		 			            	        "<span style='font-size:8px;'>普通柜台科目不一致总数</span><span style='color:red; font-size:8px;'>"+data.rows[0].sumbd+"</span>");
		 			            	        
					            	     }
					            	      
				            	     }else{
				            	    	 $("#noteqlNum").html("<span style='font-size:8px;'>融资融券不一致总数不一致总数:</span><span style='color:red;'>"+0+"</span>"+
				            	    	 "<span style='font-size:8px;'>普通柜台科目不一致总数:</span><span style='color:red; font-size:8px;'>"+0+"</span>");
				            	     }
				            	}	
					           }).datagrid('clientPaging'); 
		  	}
			
	  }
}

function queryZTKMInfo(gth,biz_dt,rzrq_gth){
	$("#tabsidk").tabs('select', "证券/资金明细");
	var params="gth="+gth+"&biz_dt="+biz_dt+"&rzrq_gth="+rzrq_gth;
	$('#dgl1').datagrid({method:'get',url:"<%=cp%>/zgbfj/queryZQMX?"+params}).datagrid('clientPaging'); 
	$('#dgl2').datagrid({method:'get',url:"<%=cp%>/zgbfj/queryZJMX?"+params}).datagrid('clientPaging'); 
}
    
</script>
<script type="text/javascript">
 function hideOrShow(type){
	 if(type==1){
		 $("#zjmx").toggle();
	 }else if(type==2){
		 $("#zqmc").toggle();
	 }
 }
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="备付金与柜台核对信息" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> <input class="easyui-combobox" name="wb_zth"
				id="wb_zth"
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
									 onLoadSuccess: function(){
										 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									     });
								     }
									 ">
		   	 <span style="margin-left: 16px;">日期起</span>  	
		     <span><input id="d_ywrq" name="d_ywrq" class="easyui-datebox" style="width: 150px"></input></span>
		     <span style="color: red;">*</span>
		     <span style="margin-left: 15px;">日期止</span>  	
		     <span><input id="d_ywrq_end" name="d_ywrq_end" class="easyui-datebox" style="width: 150px"></input></span>
		     <!-- <span style="color: red;">*</span> -->
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="zgbfjsearchdata()">查询</a> <br></br>
			<!-- <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
			 <br/>
			  <span>估值人员:</span>
			 <input class="easyui-combobox" name="userInfo" id="userInfo">-->
			 
			 <span>普通柜台科目余额一致:</span>
			 <span>
				<select id="tgiseql" class="easyui-combobox" name="tgiseql" style="width: 130px;">
					<option value="5">--请选择--</option>
					<option value="tg_eql">托管一致</option>
					<option value="tg_noteql">托管不一致</option>
				</select>
			 </span>
			 &nbsp;
			 <span>融资融券柜台科目余额一致:</span>
			 <span>
				<select id="wbiseql" class="easyui-combobox" name="wbiseql" style="width: 150px;">
					<option value="6">--请选择--</option>
					<option value="wb_eql">外包一致</option>
					<option value="wb_noteql">外包不一致</option>
				</select>
			 </span>
			  <span id='noteqlNum' style="font-size:20px;float: right;"></span>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="dgl" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<!-- <tr>
					    <th field="noteqlnum" width="150" data-options="hidden:true"></th>
					    <th field="rq" width="150">日期</th>
					    <th field="zt_code" width="150">帐套号</th>
						<th field="zt_name" width="150">帐套名称</th>
					    <th field="pt_gtname" width="70">普通柜台</th>
					    <th field="rzrj_gtname" width="70">融资融券柜台</th>
						<th field="zc_code" width="100">资产账号</th>
						<th field="gzye" width="100" >估值系统 科目余额</th>
						<th field="taye" width="100" >柜台系统科目余额</th>
						<th field="zthye" width="100">差额</th> 
						<th field="gw_xq" width="100" >详情</th>
					</tr> -->
					<tr>
						<!-- <th width="180px"     rowspan="2" data-options="field:'ck',checkbox:true"></th> -->
                        <th field="rq"    width="90px"     rowspan="2">日期</th>
                        <th field="zt_code"  width="80px"   rowspan="2">帐套号</th>
                        <th field="zt_name"  width="180px"   rowspan="2">帐套名称</th>
                        <th field="zc_code" width="100px" rowspan="2">普通柜台</th>
                        <th field="rzrq_gth" width="100px" rowspan="2">融资融券柜台</th>
						<th   colspan="3"  width="200px"  >普通柜台科目余额</th>
						<th   colspan="3"  width="200px"  >融资融券科目余额</th>
						<th field="gw_xq"    width="180px"     rowspan="2">详情</th>
					</tr>
					<tr>
					  <th field="gzye" width="60px" >估值系统</th>
					  <th field="taye" width="60px"  >柜台系统</th>
					  <th field="zthye" width="80px" >差额</th>
					  
					  <th field="gzyexy" width="60px" >估值系统</th>
					  <th field="tayexy" width="60px"  >柜台系统</th>
					  <th field="zthye1" width="80px">差额</th>

				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
					
				</thead>
			</table>
		</div>
	</div>
	
	<div title="证券/资金明细" style="padding: 5px;">
	
	 <div class="easyui-accordion" style="height:440px;">
	     <div title="资金明细信息" style="overflow:auto;">
					<table id="dgl1" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              pageList:[10,20,50,100]
						              ">
						<thead>
							<tr>
								<th field="dt" width="80">时间</th>
								<th field="cust_no" width="80">柜台资金号</th>
								<th field="cust_name" width="100">基金名称</th>
								<th field="sec_code" width="80">证券代码</th>
								<th field="sec_short_name" width="130">证券名称</th>
								<th field="business_name" width="130">交易行为</th>
								<th field="sec_chg" width="80">证券变动</th>
								<th field="sec_bal" width="80">证券余额</th>
								<th field="fund_chg" width="80">资金变动</th>
								<th field="fund_bal" width="80">资金余额</th>
								<th field="done_amt" width="80">资金发生额</th>
								<!--   
								<th field="currency_type" width="30">货币类型</th>
								<th field="sec_type" width="30">sec_type</th>
								<th field="business_code" width="50">业务编码</th>
								<th field="done_amt" width="50">done_amt</th>
								<th field="flag" width="50">flag</th>
								<th field="branch_name" width="50">交易机构</th>
								<th field="currency_name" width="50">货币名称</th>
								<th field="sec_typt_desc" width="50">sec_typt_desc</th>
								  <th field="occur_date" width="50">时间</th>
								<th field="occur_time" width="50">发生时间</th>
								<th field="serial_no" width="50">serial_no</th>
								<th field="branch_code_1" width="50">branch_code_1</th>
								<th field="holder_acc_no" width="50">holder_acc_no</th>
								-->
							</tr>
						</thead>
					</table>
	   </div>
	   <div title="证券明细信息" style="overflow:auto;">
			<table id="dgl2"  
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<tr>
						<th field="dt" width="80">时间</th>
						<th field="cust_no" width="80">柜台资金号</th>
						<th field="name" width="100">基金名称</th>
						<th field="market_name" width="100">市场</th>
						<th field="sec_code" width="100">证券代码</th>  
						<th field="sec_short_name" width="100">证券名称</th>
						<th field="pos_qutty" width="100">股份数</th>
						<th field="sec_price" width="100">股票价格</th>
						<th field="mkt_value" width="100">市值</th>
						<!--  <th field="flag" width="100">flag</th>
						<th field="market_code" width="100">市场</th>
						-->
					</tr>
				</thead>
			</table>
		</div>
	</div>
	</div>
</div>

</body>





