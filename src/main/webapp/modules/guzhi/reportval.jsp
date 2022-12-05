<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>数据结息查询</title>
    <script>document.documentElement.focus();</script>
    	<style scoped="scoped">
	        .md{
	            height:16px;
	            line-height:16px;
	            background-position:2px center;
	            text-align:right;
	            font-weight:bold;
	            padding:0 2px;
	            color:red;
	        }
    </style>
    <style>
    body { font-size: 62.5%; }
    label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
  </style>
    
    
</head>
<script type="text/javascript">



function showdiag() {
	
	$('#dialog-form').dialog('open')
    
}




		function myformatter(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
		}
		function myparser(s){
			if (!s) return new Date();
			var ss = s.split('-');
			var y = parseInt(ss[0],10);
			var m = parseInt(ss[1],10);
			var d = parseInt(ss[2],10);
			if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
				return new Date(y,m-1,d);
			} else {
				return new Date();
			}
		}
	


	</script>
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#dg').datagrid('validateRow', editIndex)){
				var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'date258'});
				//var productname = $(ed.target).combobox('getText');
				//$(ed.target).val();
				var productname = ''
				
				$('#dg').datagrid('getRows')[editIndex]['date258'] = productname;
				
				
				 productname =$('#dg').datagrid('getRows')[editIndex]['date2589']
				 if(productname==undefined)
					 productname='';
				// var tvalue=	$(ed.target).combobox('getText'); $(ed.target).val();
				 var tvalue=	'';
					if(productname.indexOf(tvalue)>-1)
						productname=productname.replace(tvalue+'#','')
						else if(tvalue.length==10)
							productname=productname+tvalue+'#';
						
					$('#dg').datagrid('getRows')[editIndex]['date2589'] = productname;
				 
				$('#dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function myselect(s){
			endEditing()
		}
		

		
		
		function onClickRow(index){
			if (editIndex != index){
				/*  if (endEditing()){
					$('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
					editIndex = index;
				}  
				else {
					
				} 
				$('#dg').datagrid('selectRow', editIndex); */ 
			}
			$('#indexq').val(index);
			
			 var row=$('#dg').datagrid('getRows')[$('#indexq').val()];
	
			   $('#selecttxt').val(row.date2589);
			$('#dg').datagrid('selectRow', editIndex);
		}
		function append(){
			if (endEditing()){
				$('#dg').datagrid('appendRow',{status:'P'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function remove(){
			if (editIndex == undefined){return}
			$('#dg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function accept(){
			if (endEditing()){
				$('#dg').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
		function getChanges(){
			var rows = $('#dg').datagrid('getChanges');
			alert(rows.length+' rows are changed!');
		}
		function getSelections(){
			var ss = [];
			var rows = $('#dg').datagrid('getSelections');
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				ss.push('<span>'+row.itemid+":"+row.productid+":"+row.attr1+'</span>');
			}
			$.messager.alert('Info', ss.join('<br/>'));
		}
	</script>
<!-- 初始化操作 ,一般来讲初始化操作都是用来初始化表和用来绑定下拉列表框的-->
<script type="text/javascript">
$(function (){
	

	 $("#zmm").hide();
	
	 $("#tabsidk").tabs({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-20
	 });
	 $("#dg").datagrid({
	 	 width : '100%',
	     height : document.documentElement.clientHeight-120
	 });
	  $("#dg2").datagrid({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-120
	 });
	 //此段代码是绑定产品名称的下拉列表框
	 $("#c_port_name").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getDataName',
              method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	  $("#guzhiname").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/guzhidz/getUserinfoname',
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
 });

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
 function searchdata(){

   $('#dg').datagrid({method:'post',url:"<%=cp%>/guzhidz/getGroupName"}).datagrid('clientPaging'); 
}
 function senddata_dz(){

	 if (endEditing()){
			$('#dg').datagrid('acceptChanges');
		}
	 var ssinfo ="";
	 if($("#pdf_b")[0].checked)
		 report_b="pdf";
	 else
		 report_b="excel";
	 var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ssinfo=ssinfo+row.datacode+","+row.date2589+",";
		}
		$.messager.alert('info', '请耐心等待发送结果，');
	 
		$.ajax({
			url:'<%=cp%>/guzhidz/sendmail',
			type:'post',
			data:{ssinfo:ssinfo,type:'dz',report_b:report_b},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("发送完成！");
				}else{
					alert("发送失败！！！");
				}
				
			}
		});
	  
	}
 
 function senddata_ma(){

	 if (endEditing()){
			$('#dg').datagrid('acceptChanges');
		}
	 var report_b="";
	 if($("#pdf_b")[0].checked)
		 report_b="pdf";
	 else
		 report_b="excel";
	 var ssinfo ="";
	 var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ssinfo=ssinfo+row.datacode+"#"+row.date2589+"#";
		
		}
		$.messager.alert('info', '请耐心等待发送结果，');
	 
		$.ajax({
			url:'<%=cp%>/guzhidz/sendmail',
			type:'post',
			data:{ssinfo:ssinfo,type:'ma',report_b:report_b},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("发送完成");
				}else{
					alert("发送失败！！！");
				}
				
			}
		});
	  
	}
  //数据结息查询
 function searchdata2(){
 		var wbdate = $("#wbdate").datebox('getValue');
/* 
		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		} */
		
 //var params="c_occur_date="+$("#c_occur_date").datebox('getValue')
 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		var edate = $("#wbdate2").datebox('getValue');
 		
 	/* 	if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		 */
 		var r_flag = $("#r_flag").combobox('getValue');
 		var params = {c_cp_name:$("#c_port_name").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue'),username:$("#guzhiname").datebox('getValue'),r_flag:r_flag};
 		
 		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 
      
      $('#dg2').datagrid({method:'post',url:"<%=cp%>/guzhidz/searchdata",queryParams:params}).datagrid('clientPaging'); 
 }

 


 
 </script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
   	<div title="估值表发送" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
	  <input  id="indexq" type="text"  style="display: none" />
		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		<span style="display: none">  <input type="checkbox"   id="pdf_b" name="p df_b"> PDF盖章版</span> 
		<span style="display: none">  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="senddata_dz()">对账邮箱 发送</a></span> 
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="senddata_ma()">管理人邮箱发送</a>
</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="rownumbers:true,  autoRowHeight:false,pagination:true,pageSize:500,
				singleSelect: false,
				selectOnCheck:true,
				checkOnSelect:true,
				onClickRow: onClickRow
				
				
			">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
					     <th field="datacode" hidden=true >代码</th>
                        <th field="datavalue"  width="120"  >分组名称</th>
					    <th field="date2589"  width="540" >已选日期</th>
						<!--  <th field="date258" data-options="width:120,align:'center',editor:{type:'datebox',options:{formatter:myformatter,parser:myparser,onSelect:myselect}}">估值表日期</th> -->
					 <th field="date258"  ">选择</th>
					
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	

	
	
	<div title="发送记录查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<input class="easyui-combobox"
						name="c_port_name" id="c_port_name"
		    >
		   <span style="margin-left: 15px;">发送日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px"  data-options=""></input></span>
		   <span style="color: red;"> </span>
		   <span>状态:</span>
			<span>
				<select id="r_flag" class="easyui-combobox" name="r_flag" style="width: 175px;">
					<option value="0">全部</option>
					<option value="1">成功</option>
					<option value="2">失败</option>
					
				</select>
			</span>
		   <span style="display: none">
		    <span style="margin-left: 15px;">估值表日期</span>  	
		   <span><input id="wbdate2" name="wbdate2" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;"> </span>
		   <span style="margin-left: 15px;">估值人员:</span> 
					<input class="easyui-combobox" name="guzhi_name"
					id="guzhiname"> 
					<span>&nbsp&nbsp&nbsp</span> </span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  <br />	
	</div>
		<div style="margin-top: 10px;">
			<table id="dg2" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                    <th field="id" width="80px">序号</th> -->
                       
						<th field="wb_zth" >外包账套号</th>
						<th field="ztmc" >账套名称</th>
						<th field="reportdate"  hidden=true >估值表日期</th>
						<th field="senddate">发送日期</th>
						<th field="tomail" >接收人</th>
						<th field="flag" >发送结果</th>
						<th field="reporttype" >类型</th>
						<th field="fujian" >附件</th>
						
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
  </div>
</div>



<div id="dialog-form" class="easyui-dialog"  title="日期选择"   style="width:500px;height:200px;padding:10px" 
			data-options="
				closed:true,
				modal:true,
			onOpen:function(){
			
			    
			}

			,
			
				buttons: [{
					text:'Ok',
					iconCls:'icon-ok',
					handler:function(){
					
					
				  var row=$('#dg').datagrid('getRows')[$('#indexq').val()];
				   row.date2589=$('#selecttxt').val();
					
					var  indexq=$('#indexq').val();

				  $('#dg').datagrid('endEdit',indexq ).datagrid('refreshRow',indexq );
				
						$('#selecttxt').val('');
						$('#dialog-form').dialog('close');
						}
					
				},{
					text:'Cancel',
					handler:function(){
						$('#selecttxt').val('');
						$('#dialog-form').dialog('close');
					}
				}]
			">
		
        <input   id="selecttxt"  type="text" name="name" id="name" class=" auto-kal "   class=""  data-kal="mode:'multiple'" style="width:450px"  >

	</div>


</body>













