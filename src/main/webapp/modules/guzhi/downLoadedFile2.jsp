<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="resoures.jsp"%>
<base href="<%=basePath%>" />
<script>document.documentElement.focus();</script>

<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>估值人员账套对应关系配置</title>
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	     //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-80
		 });
		
       <%--  $("#userInfo").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
              method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
					},
			 onLoadSuccess: function(){
			   
		     }
	  });
      $("#zth").combobox({
                      valueField: 'value',
        		 	  textField: 'text',
        			  groupField:'zt_group',
        			  mode:'local',
        			  url:'guzhidz/querySelectValue?selectType=queryAllZTH',
                      method:'post',
        			  multiple:false,
        			  width:250,
        			  filter: function(q, row){
        						var opts = $(this).combobox('options');
        						return row[opts.textField].indexOf(q) == 0;
        					},
        		     groupFormatter:function(group){
        		    	        if(trim(group)!="外包账套名称"){
        		    	        	return '<span style="color:red">' + group + '</span>';
        		    	        }else{
        		    	        	return '<span style="color:blue">' + group + '</span>';
        		    	        }
        		     },
        		     onLoadSuccess: function(){
        				 
        		     }
        					
        	  }); --%>  
 /////////////////////////新增///////////////////      
      <%--  $("#zttype").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'1',text:'托管'},{value:'2',text:'外包'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
					},
		      onSelect:function(val){
						 $("#zth1").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectValue?selectType=zthselect&zttype='+val.value,
					              method:'get',
								  multiple:true,
								  multiline:true,
								  width:300,
								  height:80,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) == 0;
										},
							      onLoadSuccess: function(){
							    	  $(this).combobox('enable');
								  }		
					    }).combobox('clear');
						 
						$("#userInfo1").combobox({ 
							  valueField: 'value',
							  textField: 'text',
							  disabled:true,
							  mode:'local',
							  url:'<%=cp%>/guzhidz/querySelectValue?selectType=userselect&usertype='+val.value,
				              method:'get',
							  multiple:false,
							  width:150,
							  filter: function(q, row){
										var opts = $(this).combobox('options');
										return row[opts.textField].indexOf(q) == 0;
									},
							  onLoadSuccess: function(){
								   $(this).combobox('enable');
							  }					
				       }).combobox('clear');
			 }				
	  }); --%>
	  
	  $("#userInfo1").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'01',text:'邮箱'},{value:'02',text:'FTP'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
			}
		})
		
		$("#userInfo2").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'01',text:'是'},{value:'02',text:'否'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
			}
		})
		
		$("#zth").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'01',text:'邮箱'},{value:'02',text:'FTP'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
			}
		})
	  
	  searchdata();
	  
	  /* var conloum = $("#dg").datagrid("getSelected");
	  $("#zttype").textbox('setValue',conloum.filename); */
	  
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
</script>
<!-- 自定义js -->
<script type="text/javascript">
 function searchdata(){
     var params="filename="+$("#userInfo").textbox('getValue')+"&remark="+$("#zth").combobox('getValue');
      $('#dg').datagrid({method:'get',url:"guzhisas/queryYXZWJ?"+params}).datagrid('clientPaging');
 }
 
 //zttype   userInfo1 
 function adddata(){
	if($("#zttype").textbox('getValue')==""||$("#userInfo1").combobox('getValue')==""){
		alert("请选择文件名称和文件标识！");
		return false;
	}else{
		var fileName=$("#zttype").textbox('getValue');
		var remark = $("#userInfo1").combobox('getValue');
		var state = $("#userInfo2").combobox('getValue');
		
		$.ajax({ 
		        type: "POST", 
		        url: "guzhisas/insertGuZhiServiceSystemInfo", 
		        data: {fileName:fileName,remark:remark,state:state}, 
		        dataType: "json", 
		        success: function(data) {                
		           if(data.msg=="success"){
		        	   alert("操作成功");
		        	   closeDialog();
		        	   searchdata();
		           }else{ 
		        	   alert("操作失败");
		        	   closeDialog();
		           }
		        }, 
		        error: function() { 
		           alert("系统异常，操作失败");     
		        } 
		    });  
	}
 }

 /* function removedata(){
	 if($("#userInfo1").combobox('getValue')==""||$("#zth1").combobox('getValues')==""){
			alert("请选择基金名称和估值人员");
			return false;
		}else{
			var userInfo=$("#userInfo1").combobox('getValue');
			var zth =$("#zth1").combobox('getValues');
			var ztmc=$("#zth1").combobox('getText');
			
			$.ajax({ 
			        type: "POST", 
			        url: "guzhidz/saveUserConfigInfo", 
			        data: {USERINFO:userInfo,ZTH:zth,ZTMC:ztmc,TYPE:'remove',ZTTYPE:'1'}, 
			        dataType: "json", 
			        success: function(data) {                
			           if(data.msg=="success"){
			        	   alert("操作成功");
			        	   closeDialog();
			        	   searchdata();
			           }else{ 
			        	   alert("操作失败");
			        	   closeDialog();
			           }
			        }, 
			        error: function() { 
			           alert("系统异常，操作失败");     
			        } 
			    });  
		}
 } */
 
 function removedata(){
 	if($("input[name='ck']:checked").length!=1){
 		alert("请选择要删除的数据");
 		return false;
 	}else{
 		var id = $("input[name='ck']:checked").val();
 		if(id==-1){
 			alert("此条数据为自动匹配数据，不需删除");
 			return false;
 		}else{ 
 			$.ajax({ 
 		        type: "POST", 
 		        url: "guzhisas/deleteYXZWJ", 
 		        data: {ID:id}, 
 		        dataType: "json", 
 		        success: function(data) {                
 		           if(data.msg=="success"){
 		        	   alert("删除成功");
 		        	   searchdata();
 		           }else{ 
 		        	   alert("删除失败");
 		           }
 		        }, 
 		        error: function() { 
 		           alert("系统异常，删除失败");     
 		        } 
 		    });
 		}
 	}
 }
 
 
 function editdata(){
 	if($("input[name='ck']:checked").length!=1){
 		alert("请选择1条要修改的数据");
 		return false;
 	}else{
 		var filename = $("input[name='ck']:checked").closest("tr").find("td[field='filename']");
 		var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']");
 		var state = $("input[name='ck']:checked").closest("tr").find("td[field='state']");
 	    filename.find("div").html("<input type='text' value='"+filename.find("div").text()+"'></input>");
 		
 		//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
 		$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
 		$("input[name='ck']").prop("disabled",true);
 	}
 }
 
  function savedata(){
 	if($("input[name='ck']:checked").length==1){
 		
 		var id = $("input[name='ck']:checked").val();
 		
 		var filename = $("input[name='ck']:checked").closest("tr").find("td[field='filename']").find("input").val();
 		//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
 		var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']").text();
 		var state = $("input[name='ck']:checked").closest("tr").find("td[field='state']").text();
 		
 		if(filename=="" || remark==""){
 			alert("文件名称和文件来源标识不能为空！");
 			return false;
 		}else if(typeof(filename)=="undefined"){
 			alert("请点击修改按钮！");
 			return false;
 		}else{
 			$.ajax({ 
 		        type: "POST", 
 		        url: "guzhisas/updateYXZWJ", 
 		        data: {ID:id,filename:filename,remark:remark,state:state}, 
 		        dataType: "json", 
 		        success: function(data) {                
 		           if(data.msg=="success"){
 		        	   alert("修改成功");
 		        	   searchdata();
 		           }else{ 
 		        	   alert("修改失败");
 		           }
 		        }, 
 		        error: function() { 
 		           alert("系统异常，修改失败");     
 		        } 
 		    });
 		}
 	} 
 }
 
 
 function closeDialog(){
	 $('#zth1').combobox('clear');
	 $('#userInfo1').combobox('clear');
	 $('#dlg').dialog('close');
 }
 
  
</script>
<body>
	<div id="tabsidk" class="easyui-tabs" style="">
		<div title="估值人员配置" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<span>文件名称:</span> <input class="easyui-textbox" name="userInfo"
					id="userInfo"> <span style="margin-left: 15px;">文件来源标识:</span>
					<input class="easyui-combobox" name="zth" id="zth"> <a
						href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
						<!-- <a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-edit'" onclick="editdata()">修改</a> <a
						href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" onclick="savedata()">保存</a> <a
						href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-add'"
						onclick="$('#dlg').dialog('open')">新增</a> <a
						href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove'" onclick="removedata()">删除</a> -->
						<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg').dialog('open')">新增/删除 </a>
 -->
			</div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							<th data-options="field:'ck',checkbox:true"></th>
							<!-- <th field="accountmappingid" data-options="hidden:true"></th> -->
							<th field="filename" width="150px">文件名称</th>
							<th field="remark" width="200px">文件来源标识</th>
							<th field="state" width="150px">文件状态</th>
							<th field="currenttime" width="200px">日期</th>
							<!-- <th field="updatetime" width="200px">更新时间</th> -->
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="dlg" class="easyui-dialog" closed="true" title="添加需要下载的文件"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
		<span style="margin-left:20px;">文件名称:</span> <span> <input
			type="text" class="easyui-textbox" id="zttype" name="zttype" /> </span> <br />
		<br /> <span style="margin-left:20px;">文件标识:</span> <span> <input
			type="text" class="easyui-combobox" id="userInfo1" name="userInfo1" />
		</span> <br /> <br /> <span style="margin-left:20px;">文件状态(是否下载):</span> <span>
			<input type="text" class="easyui-combobox" id="userInfo2"
			name="userInfo2" /> </span>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="adddata()">保存</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>

</body>