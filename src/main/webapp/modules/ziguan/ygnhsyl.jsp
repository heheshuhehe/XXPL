<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>数据结息查询</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 ,一般来讲初始化操作都是用来初始化表和用来绑定下拉列表框的-->
<script type="text/javascript">
$(function (){

	 $("#zmm").hide();
	
	 $("#tabsidk").tabs({
	 	 width : '100%',
     	 height : '99%'
	 });
	
	  $("#content1").load({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-180
		 });
		 $("#dg").datagrid({
		 	 width : '98%',
	   	     height :document.documentElement.clientHeight-500
		 });	
		$("#wbdate").datebox('setValue',formatterDate(new Date()));

});

//关于日期的二级联动
	function changetime() {
		//1.先获取 newdate 的日期
		var ndate = $("#wbdate").datebox("getValue");
		var a = new Date(ndate.replace(/\-/g, "\/"));
//得到第一个日期，它有onSelect属性，可以触发第二个日期
		var mailsdate = a.getFullYear() + "-";
		mailsdate += a.getMonth() + 1 + "-";
		mailsdate += a.getDate();

		$("#wbdate2").datebox({
		//给第二个日期设置值（将第一个日期放进去）
			value : mailsdate,
			required : true
		});

		
	}

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 
  //数据结息查询
 function searchdata2(){
 		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		
 //var params="c_occur_date="+$("#c_occur_date").datebox('getValue')
 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		
 		var params = {operate:'search', wbdate:$("#wbdate").datebox('getValue')
 				
 		};
 		
 		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 
      
   //   $('#dg2').datagrid({method:'post',url:"guzhidz/queryYgsyl",queryParams:params}).datagrid('clientPaging'); 
      
      
      $.ajax({
			url:'<%=cp%>/guzhidz/queryYgsyl',
			type:'post',
			data:params,
			dataType: "json",
			success: function(data){
				if(data.length>0){
					$('#mycontent').html('');
					var newcontent="";
				var content="产品代码HHHHHH      A:基准日期设置---开始日期FFFFFF                 &nbsp; &nbsp; (&nbsp; &nbsp;AAAAAA / ( BBBBBB - CCCCCC )&nbsp; &nbsp; +&nbsp; &nbsp; DDDDDD / EEEEEE )* 365 = GGGGGG ";
				data.forEach(function(item){
					newcontent+=content.replace("AAAAAA",new Number(item.ckjsy)).replace("BBBBBB",new Number( item.sszb_hz)).replace("CCCCCC",new Number(item.jyfe)).replace("DDDDDD",new Number(item.fckjsy))
					.replace("EEEEEE",new Number(item.sszb)).replace("FFFFFF",item.startdate).replace("GGGGGG",item.ygsyl).replace("HHHHHH",item.tacode)+"</br>"+"</br>";
				});
				
				
				$('#mycontent').html(newcontent);
				
				}else{
					alert("查询失败！");
				}
			}
		}); 
      
      $('#dg').datagrid({method:'get',url:"guzhidz/queryYgsyl?wbdate="+$("#wbdate").datebox('getValue')}).datagrid('clientPaging'); 
 }
 function closeDialog(){
		$("#c_subj_code_u").textbox('clear');
	 	$("#amac_code_u").textbox('clear');
	   $('#yhdzhds').dialog('close');
	 
 }
 function updateInfonew(){
	 //获取选中行
			var row = $('#dg2').datagrid('getSelected');
			if (row){
				
				
				 $("#c_subj_code_u").textbox('setValue',row.c_subj_code);
				 $("#amac_code_u").textbox('setValue',row.amaccode);
				
				 $('#yhdzhds').dialog('open');
			}
			else{
				$.messager.alert('提示','请先选中一行！');

			}


	 }

 

function saveInfonew(){
	var subj=  $("#c_subj_code_u").textbox('getValue');
	var amac=  $("#amac_code_u").textbox('getValue');
	if(amac==''){
		$.messager.alert('提示','协会编码为空！');
		return ;
	}
	$.ajax({
		url:'<%=cp%>/guzhidz/getDataFormDB',
		type:'post',
		data:{
			subj:subj,amac:amac,operate:"update"
		},
		dataType: "json",
		success: function(data){
			if(data[1].msg=="success"){  
				alert("保存成功");
				
				searchdata2();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}
 
 </script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
   	<div title="数据查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<!-- <span>产品名称:</span> 
			<input class="easyui-combobox"
						name="c_port_name" id="c_port_name"
		    > -->
		   <span style="margin-left: 15px;">日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px" editable="false"  ></input></span>
		   <span style="color: red;">*</span>
		  
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  
		 <!--    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="updateInfonew()">修改</a> -->
		  <br />	
		 
		</div>
			<div id="content1"
					style="margin-left: 20px; overflow: auto; height: 400px">
					
					
					<p>
                公式：<u></u> 
</p>
<p>
                <u><img src="data:image/png;base64,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" alt="" /></u> 
</p>

<p id="mycontent" >

</p>
					
	<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
				<th field="tacode" >产品代码</th>
							<th field="fckjsy" data-options="align:'center',formatter:myformatterFlat">当日非存款净收益 </th>
							
							<th field="sszb" data-options="align:'center',formatter:myformatterFlat">当日份额 </th>
							<th field="ckjsy" data-options="align:'center',formatter:myformatterFlat">累计浮动收益</th>
							<th field="jyfe" data-options="align:'center',formatter:myformatterFlat" >前一日的解约份额总数 </th>
							<th field="sszb_hz" data-options="align:'center',formatter:myformatterFlat">份额累计积数 </th>
							<th field="ygsyl"  data-options="" >预估年化收益率</th>
						
							
						
						</tr>
					</thead>
				</table>				
					
					
					
					</div>

	</div>
  </div>
  
  <div id="yhdzhds" class="easyui-dialog" closed="true" title="修改协会编码"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
				<span style="margin-left: 0px">科目代码:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="c_subj_code_u" name="c_subj_code_u" readonly="readonly">
			</span>
			
				<span style="margin-left: 0px">协会编码:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="amac_code_u" name="amac_code_u">
			</span>
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
</body>













