<%@page language="java" contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>银行对账核对</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
var id = "";
$(function (){
		 $("#tabsidk").tabs({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-20
		 });
	     //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-120
		 });
		 $("#pzdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-100
	 	 });
	 	 $("#filepzdg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });	 	 	 	 
	 	 $("#filepzdg_1").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 }); 
 
$("#year").combobox({
	valueField: 'value',
		textField: 'text',
		mode:'local',
		url:'<%=cp%>/ziguan/yeardata',
		method:'post',
		multiple:false,
		width:200,
		filter: function(q, row){
			var opts = $(this).combobox('options');
			console.log(opts);
			return row[opts.textField].indexOf(q) >-1;
	},
	onLoadSuccess: function(){
	 	$('#year').next('.combo').find('input').focus(function (){
	     	 $('#year').combobox('clear');
				});
	}
}); 

$("#guzhiname_zg").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=07',
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

$("#guzhiname_zg_1").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=07',
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

$("#guzhiname_zg_2").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=07',
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

	//file_search();
	//pz_searchdata();
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 
  function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:red;';
		}
 } 
  function myCellStyler4(value,row,index){
		if (!isNaN(value)){
			return 'color:red;background-color:#F6BCBC;';
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
/**************************查询*************************************/
 
 function show_confirm(){  
    var result = confirm('是否继续！');  
    if(result){  
        alert('删除成功！');  
    }else{  
        alert('不删除！');  
    }  
}

 function searchdata_fundtradeorder_set(){
	    var params="guzhiname="+$("#guzhiname_zg").combobox('getValue')+"&keyword="+$("#keyword").textbox('getValue');
	    //alert(params);
	    $('#pzdg').datagrid({method:'get',url:"ziguan/getFundtradeorderSet?"+params}).datagrid('clientPaging'); 
	}
 
 function searchdata_fundtradeorder_list(){
	 	var year = $("#paymentdate").combobox('getValue');
	 	if(year==""){
			alert("请选择日期！");
			return false;
		}
	    var params="guzhiname="+$("#guzhiname_zg_1").combobox('getValue')+"&paymentdate="+$("#paymentdate").combobox('getValue');
	    //alert(params);
	    $('#filepzdg').datagrid({method:'get',url:"ziguan/getFundtradeorderList?"+params}).datagrid('clientPaging'); 
	}
 function searchdata_fundtradeorder_files(){
	 	var year = $("#paymentdate_1").combobox('getValue');
	 	if(year==""){
			alert("请选择日期！");
			return false;
		}
	    var params="guzhiname="+$("#guzhiname_zg_2").combobox('getValue')+"&paymentdate="+$("#paymentdate_1").combobox('getValue');
	    //alert(params);
	    $('#filepzdg_1').datagrid({method:'post',url:"ziguan/getFundtradeorderFiles?"+params}).datagrid('clientPaging'); 
	}
 function get_fundtradeorderlist_fso(){
	 	var year = $("#paymentdate_1").combobox('getValue');
	 	if(year==""){
			alert("请选择日期！");
			return false;
		}
	 	//alert("+"+$("#guzhiname_zg_2").combobox('getValue')+"+");
	 	//return false;
	    var params="guzhiname="+$("#guzhiname_zg_2").combobox('getValue')+"&paymentdate="+$("#paymentdate_1").combobox('getValue');
        if($("#iscopy").prop("checked")){
        	params +="&iscopy=1";
        	if ($("#guzhiname_zg_2").combobox('getValue')==""||$("#guzhiname_zg_2").combobox('getValue')=="0")
       		{
        		alert("拷贝前请选择具体的估值人员！");
        		return false;
       		}
        }
        else
		{
        	params +="&iscopy=0";
		}
	    //alert(params);
	    //return false;
	    $('#filepzdg_1').datagrid({method:'post',url:"ziguan/getfundtradeorderlistFso?"+params}).datagrid('clientPaging'); 
	}
 /********************银行对账核对操作***********************/

 //删除银行对账核对匹配数据
 function pz_removedata(){
		var ids = [];
		var checkItems = $('#pzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
		});
 	if(ids.length<1){
		alert("请选择一条记录！");
		return false;
	}else{
	$.ajax({
			url:'<%=cp%>/ziguan/updatePZInfo',
			type:'post',
			data:{id:ids.toString(),type:'delete'},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("删除成功！");
					pz_searchdata();
				}else if(data.msg="error"){
					alert("删除失败！");
				}
			}
		});
	}
 }
 
 //删除资金系统和估值系统的配置关系
 function dr_removedata(){
		var ids = [];
		var checkItems = $('#pzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
			
		});
 	if(ids.length<1){
		alert("请选择一条记录！");
		return false;
	}else{
	$.ajax({
			url:'<%=cp%>/ziguan/updatedirectiveInfo',
			type:'post',
			data:{id:ids.toString(),type:'delete'},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("删除成功！");
					//pz_searchdata();
				}else if(data.msg="error"){
					alert("删除失败！");
				}
			}
		});
	
	}
 }
 
 //标注为已经制作
 function dr_signdata(){
		var ids = [];
		var checkItems = $('#filepzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.sno);
			
		});
 	if(ids.length<1){
		alert("请选择一条记录！");
		return false;
	}else{
	$.ajax({
			url:'<%=cp%>/ziguan/signdirectiveInfo',
			type:'post',
			data:{id:ids.toString(),type:'sign'},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("标注成功！");
					//pz_searchdata();
				}else if(data.msg="error"){
					alert("标注失败！");
				}
			}
		});
	
	}
 }
 
 function pz_editdata(){
 	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var row = $("#pzdg").datagrid('getSelected');
		$("#zg_fundcode").combobox('setValue',row.c_port_code);
		//$("#zg_fundcode").textbox('setValue',row.c_port_code);
		$("#jzzx_fundcode").combobox('setValue',row.fundcode);
		//$("#jzzx_fundcode").textbox('setValue',row.fundcode);
		//$("#value1").textbox('setValue',row.value1);
		//$("#value2").textbox('setValue',row.value2);
		$("#opid").textbox('setValue',row.id);
		id = row.id;
		$('#hdpz').dialog('open');
 	}
 }
 function pz_setdata(){
	 	if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var row = $("#filepzdg_1").datagrid('getSelected');
			//$("#zg_fundcode").combobox('setValue',row.c_port_code);
			//$("#zg_fundcode").textbox('setValue',row.c_port_code);
			$("#jzzx_fundcode").combobox('setValue',row.fundcode);
			$("#opid").textbox('setValue',row.id);
			id = row.id;
			$('#hdpz').dialog('open');
	 	}
	 }
 
 function pz_setdata_other(){
	 	if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var row = $("#filepzdg").datagrid('getSelected');
			//$("#zg_fundcode").combobox('setValue',row.c_port_code);
			//$("#zg_fundcode").textbox('setValue',row.c_port_code);
			$("#jzzx_fundcode").combobox('setValue',row.fundcode);
			$("#opid").textbox('setValue',row.id);
			id = row.id;
			$('#hdpz').dialog('open');
	 	}
	 } 
function upfile() {   
	var files = document.getElementById("fi").files;
	var length = files.length;
	var formData = new FormData($( "#uploadfile" )[0]);
	if(length<=0){
		$.messager.alert('提示','请选择要导入的文件');
		return false;
	}
	for(var i =0;i<length;i++){
		var start = files[i].name.lastIndexOf(".");
		var end = files[i].name.length;
		var type = files[i].name.substring(start,end);
		if(type != '.xls' && type != '.xlsx'){
			$.messager.alert('提示','导入文件格式错误');
			return false;
		}
			
		formData.append('formData',files[i]);
	}
	var request = new XMLHttpRequest();
	request.onreadystatechange = function(){
		if(request.readyState == XMLHttpRequest.DONE){
			$.messager.alert('提示','上传成功!');
			file_search();
		}
	}
	request.open('POST','<%=cp%>/ziguan/springUpload');
	request.send(formData);
}  
 //查询导入到数据库中
 function file_search(){
	  $('#filepzdg').datagrid({url:"<%=cp%>/ziguan/getFileList"}).datagrid('clientPaging'); 
 }
 
 function compareData(){
	 	var year = $("#year").combobox('getValue');
		var start =$("#start").combobox('getValue'); 
		var end =$("#end").combobox('getValue'); 
		var checkItems = $('#filepzdg').datagrid('getChecked');
		if(year == "" && start == "" && end == ""){
			$.messager.alert("提示","年份和起始日期不能同时为空!");
			return;
		}else if(year !="" && start != "" || year != "" && end != ""){
			$.messager.alert("提示","不能同时选年份和起始日期!");
			return;
		}else if(year == "" && (start != "" || end != "") ){
			if(start == "" || end == "" ){
				$.messager.alert("提示","请选择起始日期!");
				return;
			}else{
				var beginDate = new Date(start.replace(/\-/g,"\/"));
				var endDate = new Date(end.replace(/\-/g,"\/"));
				if(beginDate >=endDate){
					$.messager.alert("提示","开始时间不能小于结束时间!");
					return;
				}
			}
		}
		var ids = [];
		$.each(checkItems,function(index,item){
			ids.push(item.id);
		});
		if(ids.length < 1){ 
			$.messager.alert("提示","请选择一个产品!");
			return;
		}
 		$.ajax({
			url:'<%=cp%>/ziguan/comparedata',
			type : 'post',
			data : {id : ids.toString(),year:year,start:start,end:end},
			dataType : "json",
			success : function(data) {
					$.messager.alert('提示',"操作完成！");
					file_search();
			}
		});
 }
 //取消
 function closeDialog(){
	 $('#hdpz').dialog('close');
	$('#value1').textbox('clear');
	$('#tablename').combobox('clear');
	$('#value2').textbox('clear');
	pz_searchdata();
}
 
 function pz_ensure(){
	  var  zg_fundcode_value=$("#zg_fundcode").combobox('getValue');
	  var  jzzx_fundcode_value=$("#jzzx_fundcode").textbox('getValue');
	  var  id=$("#opid").textbox('getValue');

	 if (zg_fundcode_value=="") {
		$.messager.alert('提示','资管估值系统产品信息不能为空');
		return false;
	}else if(jzzx_fundcode_value==""){
		$.messager.alert('提示','资金划付系统产品信息不能同时为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/saveFundtradeorderInfo',
			type:'post',
			data:{zg_fundcode_value:zg_fundcode_value,jzzx_fundcode_value:jzzx_fundcode_value,id:id},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					//pz_searchdata();
					closeDialog();
					
				}else{
					$.messager.alert("提示","保存失败");
					
				}
				id = "";
			}
		});
		}

	}
 
 function pz_searchdata(){
		 $('#pzdg').datagrid({url:"<%=cp%>/ziguan/queryFundtradeorderSetInfo"}); 
	}
 
 function pz_adddata(){
	 $('#hdpz').dialog('open');
 }
</script>
<body>
<div id="tabsidk" >

<div title="资金划拨系统交易单(文件)" style="padding: 5px">
	  <div style ="height:15px;">
	  <div style ="float:left">
	  	<span>交易日期</span>
	       <input id="paymentdate_1" name="paymentdate_1"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
	    <span>估值人员:</span> 
			<input class="easyui-combobox" name="guzhi_name_2" id="guzhiname_zg_2"> 
		</div>
		  <input type="checkbox" name="iscopy" id="iscopy" value="1"/>
		  <span style="font-size:10px;">拷贝文件至备份路径</span>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="get_fundtradeorderlist_fso()">查询</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_setdata()">匹配</a> 
 	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_1"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="sno" width="420"  sortable="true">交易文件名</th>
						<th field="fundcode" width="100" sortable="true">产品编码</th>
						<th field="paymentdate" width="80"  sortable="true">交收时间</th>
						<th field="payamount" width="120"  sortable="true">交收金额</th>
						<th field="fundname" width="300"  sortable="true">产品名称</th>
						<th field="username" width="120"  sortable="true">估值人员名称</th>
						<th field="updatetime" width="120"  sortable="true">完成时间</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
	<div title="资金划拨系统交易单" style="padding: 5px">
	  <div style ="height:15px;">
	  <div style ="float:left">
	  	<span>交易日期</span>
	       <input id="paymentdate" name="paymentdate"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
	    <span>估值人员:</span> 
			<input class="easyui-combobox" name="guzhi_name_1" id="guzhiname_zg_1"> 
		</div>
		 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_fundtradeorder_list()">查询</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_setdata_other()">匹配</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dr_signdata()">标注已做</a> 
 	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="fundcode" width="100"  sortable="true">产品编码</th>
						<th field="paymentdate" width="80"  sortable="true">交收时间</th>
						<th field="payamount" width="120"  sortable="true">交收金额</th>
						<th field="sno" width="220"  sortable="true">交收序列号</th>
						<th field="fundname" width="300"  sortable="true">产品名称</th>
						<th field="username" width="120"  sortable="true">估值人员名称</th>
						<th field="updatetime" width="120"  sortable="true">完成时间</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 
	
	<div title="配置对应关系" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  <span>估值人员:</span> 
					<input class="easyui-combobox" name="guzhi_name"
					id="guzhiname_zg">
					
				<span >产品关键字:</span>
				<span> 
					<input  style="width:150px;height:25px;" type="text" class="easyui-textbox"    name="keyword" id="keyword" />
				</span> 	 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_fundtradeorder_set()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddata()">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dr_removedata()">删除</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_editdata()">修改</a> 
			     
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="pzdg"  
						data-options="selectOnCheck:true,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
						               ">
						<thead>
							<tr>
						        <th data-options="field:'ck',checkbox:true"></th>
								<th field="id" width="80" >序号</th>
								<th field="fundcode" width="100" >划付产品代码</th>
								<th field="fundname" width="300" >划付系统产品名称</th>
								<th field="c_port_code" width="100" >资管系统产品名称</th>
								<th field="c_port_name" width="300" >资管系统产品名称</th>
								<th field="username" width="80" >估值人员</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>


</div>
<div id="hdpz" class="easyui-dialog" closed="true" title="资金划拨系统与估值系统匹配"
			style="width: 450px; height: 250px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
		  	<span>估值系统账套名称:</span>
					  <input class="easyui-combobox" name="zg_fundcode" id="zg_fundcode"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/ziguan/getdirectZgProduct',
		                          method:'post',
								  multiple:false,
								  width:250,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#zg_fundcode').next('.combo').find('input').focus(function (){
									            $('#zg_fundcode').combobox('clear');
									 });
							     }
					  ">
			 <span style="color: red;">*</span>
			<br></br>	
			
			<span >资金划付产品名称:</span> 
			<span> 
				<input class="easyui-combobox" name="jzzx_fundcode" id="jzzx_fundcode"
										data-options="
							                      valueField: 'value',
												  textField: 'text',
												  mode:'local',
												  url:'<%=cp%>/ziguan/getdirectJzzxProduct',
						                          method:'post',
												  multiple:false,
												  width:250,
												  filter: function(q, row){
															var opts = $(this).combobox('options');
															return row[opts.textField].indexOf(q) >-1;
														},
										         onLoadSuccess:function(){
													 $('#jzzx_fundcode').next('.combo').find('input').focus(function (){
													            $('#jzzx_fundcode').combobox('clear');
													 });
											     }
									  ">
					</span> 
			<span style="color: red;">*</span>
			<input type="hidden" class="easyui-numberbox" id="opid" name="opid">
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

</body>



