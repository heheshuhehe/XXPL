<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>科目对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
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
		 
		 $("#dg").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-100
		 });
		
		 $("#dg1").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-100)
		 });
		 $("#dg2").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-100)
		 });
		 $("#dg3").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-100)
		 });
		 $("#dg4").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-100)
		 });
       $("#userInfo").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
             method:'post',
            // multiple:true,
			//  multiline:true,
			  width:200,
			  onChange:function() {  
		     /*        var valueField = $(this).combobox("options").valueField;  
		            var val = $(this).combobox("getValue");  //当前combobox的值  
		            var allData = $(this).combobox("getData");   //获取combobox所有数据  
		            var result = true;      //为true说明输入的值在下拉框数据中不存在  
		            for (var i = 0; i < allData.length; i++) {  
		                if (val == allData[i][valueField]) {  
		                    result = false;  
		                    break;  
		                }  
		            }  
		            if (result) {  
		                $(this).combobox("clear");  
		            }   */
		      
		        },
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				/*  $('#userInfo').next('.combo').find('input').focus(function (){
			            $('#userInfo').combobox('clear');
			     }); */
		     }
	  });
       $(document).bind('contextmenu',function(e){
			e.preventDefault();
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		});
       $("#w_userInfo").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
           method:'post',
           multiple:true,
			  multiline:true,
			  width:200,
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
    	   $("#tg_zth").combobox('setValue',wbzth_server);
    	   $("#d_ywrq").datebox('setValue',mydate_server);
    	   searchdata();
      }
       
       $("#tgzth").combobox({
    	   valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectVal?selectType=TGall',
           method:'post',
			  multiple:false,
			  width:200,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				
		     }
	  });
       
       
       $("#jyjg").combobox({
    	   valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:"<%=cp%>/guzhidz/getComboBoxSource?tbname=smgz_qsdata_baseini&code=datacode&name=dataname&option= where ini_group='2' ",
           method:'post',
			  multiple:false,
			  width:200,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				
		     }
	  });
       
       $("#g_userInfo").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
          	 method:'post',
           //		multiple:true,
			//  multiline:true,
			  width:200,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				/*  $('#userInfo').next('.combo').find('input').focus(function (){
			            $('#userInfo').combobox('clear');
			     }); */
		     }
	  });
       
});
  

</script>
 
<!-- 自定义js -->
<script type="text/javascript">

function closeDialog(){
	
	$('#tgzth').combobox('clear');
	$('#jyjg').combobox('clear');
	$('#pt_gth').val('');
	$('#sr_gth').val('');
	$('#gg_gth').val('');
	
	$('#gzxhye').textbox('clear');
	$('#gzsrye').textbox('clear');
	$('#gzbfjye').textbox('clear');
	$('#gzbzjye').textbox('clear');
	
	$('#mdate').textbox('clear');
	$('#gtxhye').textbox('clear');
	$('#gtsrye').textbox('clear');
	$('#gtbfjye').textbox('clear');
	$('#gtbzjye').textbox('clear');
   $('#yhdzhds').dialog('close');
 
}
function saveInfonew(){
	var tgzth=$('#tgzth').combobox('getValue');
	var jyjg=$('#jyjg').combobox('getValue');
	var pt_gth=	$('#pt_gth').val();
	var sr_gth=$('#sr_gth').val();
	var gg_gth=$('#gg_gth').val();
	
	var mdate=$('#mdate').textbox('getValue');
	
	var gtxhye=$('#gtxhye').textbox('getValue');
	var gtsrye=$('#gtsrye').textbox('getValue');
	var gtbfjye=$('#gtbfjye').textbox('getValue');
	var gtbzjye=$('#gtbzjye').textbox('getValue');
	
	$.ajax({
		url:'<%=cp%>/guzhidz/TGcheckBanlanceInput',
		type:'post',
		data:{
			tgzth:tgzth,jyjg:jyjg,pt_gth:pt_gth,sr_gth:sr_gth,gg_gth:gg_gth,mdate:mdate,gtxhye:gtxhye,gtsrye:gtsrye,gtbfjye:gtbfjye,gtbzjye:gtbzjye
		},
		dataType: "json",
		success: function(data){
			if(data[0].msg=="success"){  
				alert("保存成功");
				
				searchdata();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}
 


var params_1="";
function searchdata(){
	if($("#d_ywrq").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
		var chanzt = $("input[name='chanzt']:checked").map(function () {
	        return $(this).val();
	    }).get().join('#'); 
		
		
		var chanzt ="1";
			
			if($("#chanzt")[0].checked)
				chanzt="2";
   		var params="tg_zth="+$("#tg_zth").combobox('getValue')+"&tg_ztmc="+$("#tg_zth").combobox('getText')+
   		"&d_ywrq="+$("#d_ywrq").datebox('getValue')+"&userInfo="+$("#userInfo").combobox('getValues')+
   		"&d_ywrq_end="+$("#d_ywrq_end").datebox('getValue')+"&chanzt="+chanzt+"&guzhiday="+$("#guzhiday").combobox('getValue');
		$('#dg').datagrid({method:'get',
			               url:"<%=cp%>/guzhidz/TGcheckBanlance?"+params,
			               onLoadSuccess:function(data){
			            	     if(data.rows.length>0){
				            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
	 			            	        $("#noteqlNum").html("不一致总数:<span style='color:red;'>"+data.rows[0].noteqlnum+"</span>");
				            	     }
			            	     }else{
			            	    	 $("#noteqlNum").html("");
			            	     }
			            		
			               },
			               columnStyler:function(index,column){
			            	   return 'background-color:#666666';
			               }
			              }).datagrid('clientPaging'); 
		
	
	}
	
}

function handin(){
	
	var row = $('#dg').datagrid('getSelected');
	if (row){
		
		if(row.jyjgcode=='361'){
			$.messager.alert('提示','仅支持外部券商数据录入');
			return ;
		}
			
		
		$('#tgzth').combobox('select',row.zth);
		$('#jyjg').combobox('select',row.jyjgcode);
		$('#pt_gth').val(row.xh_gth);
		$('#sr_gth').val(row.sr_gth);
		$('#gg_gth').val(row.gg_gth);
		
		
		$('#mdate').textbox('setValue',$("#d_ywrq").datebox('getValue'));
		
		$('#gzxhye').textbox('setValue',row.xh_guzhi);
		$('#gzsrye').textbox('setValue',row.sr_guzhi);
		$('#gzbfjye').textbox('setValue',row.ggbfj_guzhi);
		$('#gzbzjye').textbox('setValue',row.ggbzj_guzhi);
		
		$('#gtxhye').textbox('setValue',row.xh_guzhi);
		$('#gtsrye').textbox('setValue',row.sr_guzhi);
		$('#gtbfjye').textbox('setValue',row.ggbfj_guzhi);
		$('#gtbzjye').textbox('setValue',row.ggbzj_guzhi);
		
		
	
		
		// $("#c_subj_code_u").textbox('setValue',row.c_subj_code);
		// $("#amac_code_u").textbox('setValue',row.amaccode);
		
		 $('#yhdzhds').dialog('open');
	}
	else{
		$.messager.alert('提示','请先选中一行！');

	}
	
}

function cell2Styler(value,row,index){
	return 'background-color:#E0EEEE';
}

function queryMXInfo(gth,gth_rzrq,gg_gth,mydate){
	$("#tabsidk").tabs('select', "证券/资金明细");
	 //var params="gth="+gth+"&biz_dt="+$("#d_ywrq").datebox('getValue');
	 params_1="gth="+gth+"&biz_dt="+mydate+"&gth_rzrq="+gth_rzrq+"&gg_gth="+gg_gth;
	$('#dg1').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryMX?"+params_1+"&type=1"}).datagrid('clientPaging'); 
	$('#dg2').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryMX?"+params_1+"&type=2"}).datagrid('clientPaging'); 
	$('#dg3').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryMX?"+params_1+"&type=3"}).datagrid('clientPaging'); 
	$('#dg4').datagrid({method:'get',url:"<%=cp%>/guzhidz/queryMX?"+params_1+"&type=4"}).datagrid('clientPaging'); 
}

function zjExporterExcel() {//导出Excel文件
	if(params_1==""){
		alert("请选择需要导出的数据！");
		return false;
	}else{
	
	   // alert("请选择核对资金明细！"+params_1);
	    window.location.href="<%=cp%>/zgbfj/getzjmxInfoDown?"+params_1;
	    
    }
  
}
function zqExporterExcel() {//导出Excel文件
	
	if(params_1==""){
		alert("请选择需要导出的数据！");
		return false;
	}else{
		//alert("请选择核对证券明细！"+params_1);
		window.location.href="<%=cp%>/zgbfj/getzqmxInfoDown?"+params_1;
	}

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
 function customCol(){
	 var xh= $("#xh_col")[0];
	 var sr= $("#sr_col")[0];
	 var ttl= $("#ttl_col")[0];
	 var gg= $("#gg_col")[0];
	 if(xh.checked){
		 $('#dg').datagrid('showColumn','xh');
		 $('#dg').datagrid('showColumn','xh_gth');
		 $('#dg').datagrid('showColumn','xh_guzhi');
		 $('#dg').datagrid('showColumn','xh_guitai');
		 $('#dg').datagrid('showColumn','xh_cha');
	 }else{
		 $('#dg').datagrid('hideColumn','xh');
		 $('#dg').datagrid('hideColumn','xh_gth');
		 $('#dg').datagrid('hideColumn','xh_guzhi');
		 $('#dg').datagrid('hideColumn','xh_guitai');
		 $('#dg').datagrid('hideColumn','xh_cha');
	 }
	 if(sr.checked){
		 $('#dg').datagrid('showColumn','sr');
		 $('#dg').datagrid('showColumn','sr_gth');
		 $('#dg').datagrid('showColumn','sr_guzhi');
		 $('#dg').datagrid('showColumn','sr_guitai');
		 $('#dg').datagrid('showColumn','sr_cha');
	 }else{
		 $('#dg').datagrid('hideColumn','sr');
		 $('#dg').datagrid('hideColumn','sr_gth');
		 $('#dg').datagrid('hideColumn','sr_guzhi');
		 $('#dg').datagrid('hideColumn','sr_guitai');
		 $('#dg').datagrid('hideColumn','sr_cha');
	 }
	 if(ttl.checked){
		 $('#dg').datagrid('showColumn','ttl');
		 $('#dg').datagrid('showColumn','hb_guzhi');
		 $('#dg').datagrid('showColumn','hb_guitai');
		 $('#dg').datagrid('showColumn','hb_cha');
	 }else{
		 $('#dg').datagrid('hideColumn','ttl');
		 $('#dg').datagrid('hideColumn','hb_guzhi');
		 $('#dg').datagrid('hideColumn','hb_guitai');
		 $('#dg').datagrid('hideColumn','hb_cha');
	 }
	 if(gg.checked){
		 $('#dg').datagrid('showColumn','gg');
		 $('#dg').datagrid('showColumn','gg_gth');
		 $('#dg').datagrid('showColumn','ggbfj_guzhi');
		 $('#dg').datagrid('showColumn','ggbfj_guitai');
		 $('#dg').datagrid('showColumn','ggbfj_cha');
		 $('#dg').datagrid('showColumn','ggbzj_guzhi');
		 $('#dg').datagrid('showColumn','ggbzj_guitai');
		 $('#dg').datagrid('showColumn','ggbzj_cha');
	 }else{
		 $('#dg').datagrid('hideColumn','gg');
		 $('#dg').datagrid('hideColumn','gg_gth');
		 $('#dg').datagrid('hideColumn','ggbfj_guzhi');
		 $('#dg').datagrid('hideColumn','ggbfj_guitai');
		 $('#dg').datagrid('hideColumn','ggbfj_cha');
		 $('#dg').datagrid('hideColumn','ggbzj_guzhi');
		 $('#dg').datagrid('hideColumn','ggbzj_guitai');
		 $('#dg').datagrid('hideColumn','ggbzj_cha');
	 }
	 
	 

 }
</script>
<body>
<div id="mm" class="easyui-menu" style="width:120px;">
	 
	<span    style="margin-left: 25px;font-size: 8px">  	<input type="checkbox"  value="xh" checked="checked"  id="xh_col">现货  </br>   </span>
	<span    style="margin-left: 25px;font-size: 8px">  	<input type="checkbox"  value="sr"  checked="checked"  id="sr_col">双融  </br>   </span>
	<span    style="margin-left: 25px;font-size: 8px">  	<input type="checkbox"  value="ttl" checked="checked"  id="ttl_col">天天利/增  </br>   </span>
	<span    style="margin-left: 25px;font-size: 8px">  	<input type="checkbox"  value="gg" checked="checked"  id="gg_col">个股期权  </br>   </span>
	
<div onclick="customCol()">OK</div>

</div>

<div id="tabsidk" class="easyui-tabs" style="">
	<div title="托管估值与柜台核对" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> <input class="easyui-combobox" name="tg_zth"
				id="tg_zth"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectVal?selectType=TGall',
			                          method:'post',
									  multiple:false,
									  width:200,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('#tg_zth').next('.combo').find('input').focus(function (){
									            $('#tg_zth').combobox('clear');
									     });
								     }
									 ">
		   	 <span style="margin-left: 30px;">日期起</span>  	
		     <span><input id="d_ywrq" name="d_ywrq" class="easyui-datebox" style="width: 150px"></input></span>
		     <span style="color: red;">*</span>
		     <span style="margin-left: 15px;display: none;">日期止
		     <input id="d_ywrq_end" name="d_ywrq_end" class="easyui-datebox" style="width: 150px"></input></span>
			 <span>估值人员:</span>
			 <input class="easyui-combobox" name="userInfo" id="userInfo">
			 估值时效（平台维护）<select id="guzhiday" class="easyui-combobox" name="guzhiday" style="width: 150px;">
					<option value="9">全部</option>
					<option value="0">T+0</option>
					<option value="1">T+1</option>
					<option value="2">T+2</option>
				</select>
			 <input type="checkbox" name="chanzt" value="1" checked="true" id="chanzt" />仅显示差值项
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> 
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="handin()">录入</a> 
			 <a style="display: none" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
			
			  <span id='noteqlNum' style="font-size:20px;float: right;"></span>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="dg" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					              
				    <thead data-options="frozen:true">
					<tr>
					<th  field="zth" >账套号</th>
					  <th  width="140" field="ztmc"   >账套名称</th>
							<th  field="jyjg"   >交易机构</th>
							<th  field="jyjgcode" hidden="true"  >交易机构</th>
					</tr>
				</thead>
				<thead>
					<tr>
			
						<th colspan="4"  field="xh" align="center" >现货</th>
						<th colspan="4"  field="sr" align="center">双融</th>
						<th colspan="3"  field="ttl" align="center" >天天利/增</th>
						<th colspan="7"  field="gg"  align="center" >个股期权</th>
						 
						
						<th rowspan="2" field="myquery" width="40">操作</th>
					</tr>
					<tr>
						<th field="xh_gth"  >柜台号</th>
					    <th field="xh_guzhi"  data-options="align:'right',formatter:myformatter">估值系统</th>
						<th field="xh_guitai"  data-options="align:'right',formatter:myformatter">柜台系统</th>
						<th field="xh_cha" data-options="align:'right',formatter:myformatter">差额</th>
						
						<th field="sr_gth"  data-options="align:'right',styler:cell2Styler">柜台号</th>
					    <th field="sr_guzhi"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">估值系统</th>
						<th field="sr_guitai"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">柜台系统</th>
						<th field="sr_cha" data-options="align:'right',formatter:myformatter,styler:cell2Styler">差额</th>
						

					    <th field="hb_guzhi"  data-options="align:'right',formatter:myformatter">估值系统</th>
						<th field="hb_guitai"  data-options="align:'right',formatter:myformatter">柜台系统</th>
						<th field="hb_cha" data-options="align:'right',formatter:myformatter">差额</th>
						
						<th field="gg_gth" data-options="align:'right',styler:cell2Styler">柜台号</th>
					    <th field="ggbfj_guzhi"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">估值备付金</th>
						<th field="ggbfj_guitai"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">柜台备付金</th>
						<th field="ggbfj_cha" data-options="align:'right',formatter:myformatter,styler:cell2Styler">差额</th>

					    <th field="ggbzj_guzhi"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">估值保证金</th>
						<th field="ggbzj_guitai"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">柜台保证金</th>
						<th field="ggbzj_cha" data-options="align:'right',formatter:myformatter,styler:cell2Styler">差额</th>
					
					
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="证券/资金明细" style="padding: 5px;">
	<div id="tabsidk" class="easyui-tabs" style="">

	     <div title="现货资金明细" style="overflow:auto;">
					<table id="dg1" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              ">
						<thead>
							<tr>
								<th field="biz_dt" >时间</th>
								<th field="cust_no" >柜台资金号</th>
								<th field="sec_code" >证券代码</th>
								<th field="sec_short_name" >证券名称</th>
								<th field="business_name" >交易行为</th>
								<th field="sec_chg" >证券变动</th>
								<th field="fund_chg" data-options="align:'right',formatter:myformatter">资金变动</th>								
							</tr>
						</thead>
					</table>
	
		</div>
		
		 <div title="双融资金明细" style="overflow:auto;">
					<table id="dg2" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              ">
						<thead>
							<tr>
								<th field="biz_dt" >时间</th>
								<th field="cust_no" >柜台资金号</th>
								<th field="sec_code" >证券代码</th>
								<th field="sec_short_name" >证券名称</th>
								<th field="business_name" >交易行为</th>
								<th field="sec_chg" >证券变动</th>
								<th field="fund_chg" data-options="align:'right',formatter:myformatter" >资金变动</th>			
								
							</tr>
						</thead>
					</table>
	
		</div>
		 <div title="天天利/增明细" style="overflow:auto;">
					<table id="dg3" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              ">
						<thead>
							<tr>
								<th field="biz_dt" >时间</th>
								<th field="cust_no" >柜台资金号</th>
								<th field="sec_code" >证券代码</th>
								<th field="sec_short_name" >证券名称</th>
								<th field="business_name" >交易行为</th>
								<th field="fund_chg" >证券变动</th>
								<th field="fund_chg" data-options="align:'right',formatter:myformatter" >资金变动</th>			
								
							</tr>
						</thead>
					</table>
	
		</div>
		 <div title="个股期权资金明细" style="overflow:auto;">
					<table id="dg4" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              ">
						<thead>
							<tr>
								<th field="biz_dt" >时间</th>
								<th field="cust_no" >柜台资金号</th>
								<th field="sec_code" >证券代码</th>
								<th field="sec_short_name" >证券名称</th>
								<th field="business_name" >交易行为</th>
								<th field="sec_chg" >证券变动</th>
								<th field="fund_chg" data-options="align:'right',formatter:myformatter" >资金变动</th>		
							</tr>
						</thead>
					</table>
	
		</div>
	</div>
	</div>
	
	
	
	
 
	
	
</div>




<div id="yhdzhds" class="easyui-dialog" closed="true" title="修改协会编码"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
						<span style="margin-left: 0px">日期:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="mdate" name="mdate"  readonly="readonly">	</span>
					<br /><br />
				<span style="margin-left: 0px">账套名称:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-combobox" id="tgzth" name="tgzth" readonly="readonly">	</span>
				<span style="margin-left: 55px">交易机构:</span>	<span> 		<input style="margin-left: 0px"type="text" class="easyui-combobox" id="jyjg" name="jyjg" readonly="readonly">	</span>
				<br /><br />
				<span style="margin-left: 0px">估值现货余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gzxhye" name="gzxhye" readonly="readonly">	</span>
				<span style="margin-left: 30px">柜台现货余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gtxhye" name="gtxhye" >	</span>
				<br /><br />
				<span style="margin-left: 0px">估值双融余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gzsrye" name="gzsrye" readonly="readonly">	</span>
				<span style="margin-left: 30px">柜台双融余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gtsrye" name="gtsrye" >	</span>
					<br /><br />
				<span style="margin-left: 0px">估值备付金余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gzbfjye" name="gzbfjye" readonly="readonly">	</span>
				<span style="margin-left: 20px">柜台备付金余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gtbfjye" name="gtbfjye" >	</span>
					<br /><br />
				<span style="margin-left: 0px">估值保证金余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gzbzjye" name="gzbzjye" readonly="readonly">	</span>
				<span style="margin-left: 20px">柜台保证金余额:</span>	<span> 		<input style="margin-left: 0px" type="text" class="easyui-textbox" id="gtbzjye" name="gtbzjye" >	</span>
			<input  id="pt_gth" name="pt_gth" style="display: none" >
			<input  id="sr_gth" name="sr_gth" style="display: none" >
			<input  id="gg_gth" name="gg_gth" style="display: none" >

			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>


</body>





