<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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


	file_search();
	pz_searchdata();
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
 
 function pz_editdata(){
 	if($("input[name='pzck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var row = $("#pzdg").datagrid('getSelected');
		$("#tablename").combobox('setValue',row.tablevalue);
		$("#value1").textbox('setValue',row.value1);
		$("#value2").textbox('setValue',row.value2);
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
	  var  tablevalue=$("#tablename").combobox('getValue');
	  var  tablename=$("#tablename").combobox('getText');
	  var  value1=$("#value1").textbox('getValue');
	  var value2 = $("#value2").textbox('getValue');

	 if (tablename=="") {
		$.messager.alert('提示','表名不能为空');
		return false;
	}else if(value1==""&& value2==""){
		$.messager.alert('提示','科目不能同时为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/savePZInfo',
			type:'post',
			data:{tablename:tablename,tablevalue:tablevalue,value1:value1,value2:value2,id:id},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					pz_searchdata();
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
		 $('#pzdg').datagrid({url:"<%=cp%>/ziguan/queryPZInfo"}); 
	}
 
 function pz_adddata(){
	 $('#hdpz').dialog('open');
 }
</script>
<body>
<div id="tabsidk" >

	<div title="报表导入核对" style="padding: 5px">
	  <div style ="height:15px;">
	  <div style ="float:left">
	  	<span>年份:</span> 
			<span> 
				<input  class="easyui-combobox"  options="valueField:id,textField:text"id="year" name="year"  style="width: 50px" >
			</span>
	  	<span>开始日期</span>
	       <input id="start" name="start"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
			<span>结束日期</span>
	       <input id="end" name="end"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
		</div> 
		 <div style ="float:left;width:30px; height:5px" ></div>
 		   <form id="uploadfile" style="float:left" enctype="multipart/form-data"> 
			<input type="file" name="file"id ="fi"  multiple> 
			<input type="button" value="导入文件"   onclick="upfile()"/> 
			</form>
<!-- 			<span>&nbsp&nbsp&nbsp</span>
	  		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="file_search()">查询</a>  -->
	  		 <span>&nbsp</span>
	  		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="compareData()">核对</a> 
			<div style ="float:left;width:20px; height:5px" ></div>
			<div>

	  		</div>
	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id"  data-options="hidden:true"></th>
						<th field="code" width="100" >产品编码</th>
						<th field="name" width="200" >产品名称</th>
						<th field="rq" width="120" >上传日期</th>
						<th field="is_check" width="120" >是否已核对</th>
						<th field="fz_isequal" width="120" >负债表是否一致</th>
						<th field="lr_isequal" width="120" >利润表是否一致</th>
						<th field="jz_isequal" width="120" >净值变动表是否一致</th>
						<th field="cz" width="100">操作</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
	
	<div title="配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddata()">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="pz_removedata()">删除</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_editdata()">修改</a> 
			     
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="pzdg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
						               ">
						<thead>
							<tr>
								<th data-options="field:'pzck',checkbox:true"></th>
								<th field="id"  data-options="hidden:true"></th>
								<th field="tablename" width="100" >表名</th>
								<th field="value1" width="250" >估值字段</th>
								<th field="value2" width="250" >审计字段</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>


</div>
<div id="hdpz" class="easyui-dialog" closed="true" title="科目配置"
			style="width: 450px; height: 250px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			 <span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp表名:</span>
		  	<select class="easyui-combobox" name="tablename" id="tablename" >
		  				<option value="">--请选择--</option>
					    <option value="REP_CW_1ZCFZB">资产负债表</option>
					    <option value="REP_CW_2LRB1">利润表</option>
					    <option value="REP_CW_3SYZQY_XBRL01">净值变动表</option>
			 </select>
			 <span style="color: red;">*</span>
			<br></br>	
			
			<span >估值科目:</span> 
			<span> 
					<input  style="width:200px;height:25px;" type="text" class="easyui-textbox"    name="value1" id="value1" data-options="multiline:true"/>
			</span> 
			<span style="color: red;">*</span>
			<br></br>			
			
			<span >审计科目:</span> 
			<span> 
				<input  style="width:200px;height:25px;" type="text" class="easyui-textbox"    name="value2" id="value2" data-options="multiline:true"/>
			</span>
			<span style="color: red;">*</span> 
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

</body>



