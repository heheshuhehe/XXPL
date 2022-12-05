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
$(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
	 	 height : document.documentElement.clientHeight-20
	 });
	 $("#dg").datagrid({
	 	 width : '100%',
	 	 height : document.documentElement.clientHeight-120
	 });
	 $("#wbzth").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01&type=nopeizhi',
             method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q)>-1;
					},
			 onLoadSuccess: function(){
				 $('#wbzth').next('.combo').find('input').focus(function (){
			            $('#wbzth').combobox('clear');
			     });
		     }
	  });
      $("#wbzth1").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01&type=nopeizhi',
              method:'post',
			  multiple:false,
			  width:300,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			   onSelect:function(val){
				    
					 $("#dlgwbkmh").combobox({ 
							  valueField: 'value',
							  textField: 'text',
							  disabled:true,
							  mode:'local',
							  url:'<%=cp%>/guzhidz/querySelectValue?selectType=wbkmhselect&wbzth='+val.value,
				              method:'get',
							  multiple:false,
							  width:300,
							  filter: function(q, row){
										var opts = $(this).combobox('options');
										return row[opts.textField].indexOf(q) >-1;
									},
						      onLoadSuccess: function(){
						    	  $(this).combobox('enable');
							  }		
				    }).combobox('clear');
					 
					$("#dlgtgkmh").combobox({ 
						  valueField: 'value',
						  textField: 'text',
						  disabled:true,
						  mode:'local',
						  url:'<%=cp%>/guzhidz/querySelectValue?selectType=tgkmhselect&wbzth='+val.value,
			              method:'get',
						  multiple:false,
						  width:300,
						  filter: function(q, row){
									var opts = $(this).combobox('options');
									return row[opts.textField].indexOf(q) >-1;
								},
						  onLoadSuccess: function(){
							   $(this).combobox('enable');
						  }					
			       }).combobox('clear');
		 }		
			  		
	  });  
      
      
      $("#wbzthCopy").combobox({ 
    	  valueField: 'value',
    	  textField: 'text',
    	  disabled:true,
    	  mode:'local',
    	  url:'<%=cp%>/guzhidz/querySelectValue?selectType=kemuCopy&type=01',
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
     $("#wbzthCopy1").combobox({ 
    	  valueField: 'value',
    	  textField: 'text',
    	  disabled:true,
    	  mode:'local',
    	  url:'<%=cp%>/guzhidz/querySelectValue?selectType=kemuCopy&type=02',
          method:'get',
    	  multiple:true,
    	  multiline:true,
    	  width:300,
		  height:80,
    	  filter: function(q, row){
    				var opts = $(this).combobox('options');
    				return row[opts.textField].indexOf(q) >-1;
    			},
         onLoadSuccess: function(){
       	  $(this).combobox('enable');
    	  },
    	  selectOnNavigation:$(this).is(':checked')
    });	
      
});

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
 	if($("#wbzth").combobox('getValue')==""){
 		alert("请选择基金名称");
 		return false;
 	}else if($("#wbdate").datebox("getValue")==""){
 		alert("请选择日期");
 		return false;
 	}else{
      $('#dg').datagrid({method:'post',
    	                 url:"guzhidz/getKMDZInfo",
    	                 queryParams:{wbzth:$("#wbzth").combobox('getValue'),
		    	                    	  wbztmc:$("#wbzth").combobox('getText'),
		    	                    	  wbdate:$("#wbdate").datebox('getValue'),
		    	                    	  level:$("#level").combobox('getValue')},
		    	         rowStyler:function(index,row){
		    	                  			if (row.ck==-1){
		    	                  				return 'background-color:pink';
		    	                  			}
		    	                  		}
                        }).datagrid('clientPaging'); 
      
 	}
 }
 function editdata(){
 	if($("input[name='ck']:checked").length!=1){
 		alert("请选择1条要修改的数据");
 		return false;
 	}else{
 		var tgTd = $("input[name='ck']:checked").closest("tr").find("td[field='tgkmh']");
 		var wbTd = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']");
 	    tgTd.find("div").html("<input type='text' value='"+tgTd.find("div").text()+"'></input>");
 		
 		$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
 		$("input[name='ck']").prop("disabled",true);
 	}
 }

 function savedata(){
 	if($("input[name='ck']:checked").length==1){
 		
 		var id = $("input[name='ck']:checked").val();
 		
 		var tgVal = $("input[name='ck']:checked").closest("tr").find("td[field='tgkmh']").find("input").val();
 		var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").text();
 		
 		var accountmappingid = $("input[name='ck']:checked").closest("tr").find("td[field='accountmappingid']").text();
 		if(tgVal=="" || wbVal==""){
 			alert("外包科目号或托管科目号不能为空！");
 			return false;
 		}else if(typeof(tgVal)=="undefined"){
 			alert("请点击修改按钮！");
 			return false;
 		}else{
 			$.ajax({ 
 		        type: "POST", 
 		        url: "guzhidz/saveKMConfig", 
 		        data: {ID:id,TGKMH:tgVal,WBKMH:wbVal,ACCOUNTMAPPINGID:accountmappingid}, 
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

 function saveAllData(){
	 
		var cks ;
		if($("input[name='ck'][value='-1']:checked").length>0){
		   if(confirm("您确定保存当前页所选对应关系？")){
			  cks =  $("input[name='ck'][value='-1']:checked");
		    }
		}else{
			 if(confirm("您确定保存当前页所有对应关系？")){
			   cks =  $("input[name='ck'][value='-1']");
			}
		}
		
		var accountmappingid;
		var requestStr="";
		for (var i = 0; i < cks.length; i++) {
			if(i==0){
				accountmappingid = cks.eq(i).closest("tr").find("td[field='accountmappingid']").text();
			}
			var tgkmh = cks.eq(i).closest("tr").find("td[field='tgkmh']").text();
	 		var wbkmh = cks.eq(i).closest("tr").find("td[field='wbkmh']").text();
	 		requestStr +=accountmappingid+","+tgkmh+","+wbkmh+"@@";
		}
		
		if(requestStr!=""){
			requestStr=requestStr.substring(0,requestStr.length-2);
			 $.ajax({ 
			        type: "POST", 
			        url: "guzhidz/saveKMConfig", 
			        data: {IDS:requestStr,type:'02'}, 
			        dataType: "json", 
			        success: function(data) {                
			           if(data.msg=="success"){
			        	   alert("操作成功");
			        	   searchdata();
			           }else{ 
			        	   alert("操作失败");
			           }
			        }, 
			        error: function() { 
			           alert("系统异常，操作失败");     
			        } 
			    });
		 }else{
			 alert("操作成功"); 
		 }
 } 
 
 
 
 
 function removedata(){
 	if($("input[name='ck']:checked").length==0){
 		alert("请选择要删除的数据");
 		return false;
 	}else{
 		    var ids="";
 		    $("input[name='ck']:checked").each(function(i){
 			   if($(this).val()!=-1){
 				  ids +=$(this).val()+",";
 			   }
 			});
 		    if(ids!=""){
 		    	ids =ids.substring(0,ids.length-1);
 		    }
 		    
 		    
 		    
 			$.ajax({ 
 		        type: "POST", 
 		        url: "guzhidz/deleteKMConfig", 
 		        data: {IDS:ids}, 
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

 function adddata(){
	 var wbzth = $("#wbzth1").combobox('getValue');
	 var wbkmh = $("#dlgwbkmh").combobox('getValue');
	 var tgkmh = $("#dlgtgkmh").combobox('getValue');
	 if(wbzth==""){
		 alert("请选择基金名称");
		 return false;
	 }
	 if(wbkmh==""){
		 alert("请选择外包科目号");
		 return false;
	 }
	 if(tgkmh==""){
		 alert("请选择托管科目号");
		 return false;
	 }
	 
	 
	 
	 $.ajax({ 
	        type: "POST", 
	        url: "guzhidz/addKMConfig", 
	        data: {WBZTH:wbzth,WBKMH:wbkmh,TGKMH:tgkmh}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("操作成功");
	        	   closeDialog();
	           }else{ 
	        	   alert("操作失败");
	        	   closeDialog();
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，操作失败");   
	           closeDialog();
	        } 
	    });
 }
 
 
 
 
 
 function closeDialog(){
	  $("#wbzth1").combobox('setValue',"");
	  $("#dlgwbkmh").textbox('setValue',"");
	  $("#dlgtgkmh").textbox('setValue',"");
	  
	 $('#dlg').dialog('close');
	 
 }
 </script>
 <!-- 科目复制页面js -->
<script type="text/javascript">
 function copydata(){
	var wbzthCopy =  $("#wbzthCopy").combobox('getValue');
	var wbzthCopy1 =  $("#wbzthCopy1").combobox('getValues');
     //var ytype =  $("#yuanType").combobox('getValue');
	//var mtype =  $("#mbType").combobox('getValue');
	
	
	if(wbzthCopy=="" || wbzthCopy1==""){
		alert("源基金名称和目标基金名称不能为空");
		return false;
	}
	if(confirm("您确定要复制?")){
		$.ajax({ 
		        type: "POST", 
		        url: "guzhidz/copyKMConfig", 
		        data: {WBZTHCOPY:wbzthCopy,WBZTHCOPY1:wbzthCopy1}, 
		        dataType: "json", 
		        success: function(data) {                
		           if(data.msg=="success"){
		        	   alert("修改成功");
		        	   $("#wbzthCopy").combobox('reload');
		        	   $("#wbzthCopy1").combobox('reload').combobox('clear');
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

 function removecopydata(){
		var wbzthCopy =  $("#wbzthCopy").combobox('getValue');
		if(wbzthCopy==""){
			alert("源基金名称不能为空");
			return false;
		}
		if(confirm("您确定要删除源基金的科目对照关系?")){
			$.ajax({ 
			        type: "POST", 
			        url: "guzhidz/deleteCopyKMConfig", 
			        data: {WBZTHCOPY:wbzthCopy}, 
			        dataType: "json", 
			        success: function(data) {                
			           if(data.msg=="success"){
			        	   alert("修改成功");
			        	   $("#wbzthCopy").combobox('reload').combobox('clear');
			        	   $("#wbzthCopy1").combobox('reload');
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
 
 

</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="科目对应关系配置" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> 
			<input class="easyui-combobox"
						name="wbzth" id="wbzth"
		    >
		   <span style="color: red;">*</span>
		   <span style="margin-left: 15px;">日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 100px"></input></span>
		   <span style="color: red;">*</span>
		   <span style="margin-left: 20px;">层级</span>
		   <select id="level" name="level" class="easyui-combobox" 
		                               style="width: 100px;"  editable="false">
		                    <option value="5">--请选择--</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
		   </select> 		
		   
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savedata()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open')">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removedata()">删除</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'"   style="display: none" onclick="saveAllData()">批量保存</a>
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
                        <th field="accountmappingid" data-options="hidden:true"></th>
                        <th field="wbztmc" width="150px">外包基金名称</th>
						<th field="wbkmh" width="150px">外包科目号</th>
                        <th field="wbkmmc" width="150px">外包科目名称</th>
						<th field="tgztmc" width="150px" data-options="hidden:true">托管基金名称</th>
						<th field="tgkmh" width="150px">托管科目号</th>
						<th field="tgkmmc" width="150px">托管科目名称</th>
						<th field="wbcb" width="100px" data-options="align:'right',formatter:myformatter">外包成本</th>
						<th field="tgcb" width="100px" data-options="align:'right',formatter:myformatter">托管成本</th>
						<th field="iscbeql" width="100px" data-options="align:'right',formatter:myformatter">差值</th>
						<th field="wbsz" width="100px" data-options="align:'right',formatter:myformatter">外包市值</th>
						<th field="tgsz" width="100px" data-options="align:'right',formatter:myformatter">托管市值</th>
						<th field="iseql" width="100px" data-options="align:'right',formatter:myformatter">差值</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>


   	<div title="科目对应关系复制" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span style="margin-left: 20px;">源基金名称:</span> 
			<input class="easyui-combobox"
						name="wbzthCopy" id="wbzthCopy"
		    >
		   <span style="color: red;">*</span>
		    <br/><br/> 
		    <span style="margin-left: 11px;">目标基金名称:</span> 
			<input class="easyui-combobox"
						name="wbzthCopy1" id="wbzthCopy1"
		    >
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="copydata()">复制</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removecopydata()">删除</a>
	 </div>
	</div>
  </div>
</div>
</body>







<div id="dlg" class="easyui-dialog" closed="true" title="添加科目对照信息"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
	<span style="margin-left:40px;">基金名称:</span> 
	<span> 
		<input class="easyui-combobox" name="wbzth1" id="wbzth1">
	</span> 
	<br/><br/>
	<span style="margin-left:20px;">外包科目名称:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="dlgwbkmh" name="dlgwbkmh" style="width: 300px;"/>
	</span>
	<br/><br/>
	<span style="margin-left:20px;">托管科目名称:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="dlgtgkmh" name="dlgtgkmh"  style="width: 300px;">
	</span>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton"
		onclick="adddata()">保存</a> <a href="javascript:void(0)"
		class="easyui-linkbutton"
		onclick="closeDialog()">取消</a>
</div>





