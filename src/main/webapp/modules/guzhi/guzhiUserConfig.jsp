<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <%
    String cp = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp+"/";
    %>
    <link href="<%=basePath%>common/easyui/themes/icon.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>common/bootstrap/bootstrap-3.3.2.min.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>common/bootstrap/bootstrap-multiselect.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>common/easyui/themes/default/easyui.css">
	<!-- <script type="text/javascript" src="<%=basePath%>common/jquery/jquery.min.js"></script>- -->
	<script type="text/javascript" src="<%=basePath%>common/bootstrap/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/bootstrap/bootstrap-3.3.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/bootstrap/bootstrap-multiselect.js"></script>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>估值人员账套对应关系配置</title>
</head>


<script  type="text/javascript">
function getSelected(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		$.messager.alert('Info',"["+ row.ck+"]"+row.id+":"+row.username+":"+row.status);
	}
	var checkedItems = $('#dg').datagrid('getChecked'); 
	var names = [];  
	$.each(checkedItems, function(index, item){    
		names.push(item.productname); 
		});                 
}
function getSelections(){
	var ss = [];
	var rows = $('#dg').datagrid('getSelections');
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		ss.push('<span>['+row.ck+"]"+row.itemid+":"+row.productid+":"+row.attr1+'</span>');
	}
	$.messager.alert('Info', ss.join('<br/>'));
}

(function($){
	function pagerFilter(data){
		if ($.isArray(data)){	// is array
			data = {
				total: data.length,
				rows: data
			}
		}
		var dg = $(this);
		var state = dg.data('datagrid');
		var opts = dg.datagrid('options');
		if (!state.allRows){
			state.allRows = (data.rows);
		}
		var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
		var end = start + parseInt(opts.pageSize);
		data.rows = $.extend(true,[],state.allRows.slice(start, end));
		return data;
	}

	var loadDataMethod = $.fn.datagrid.methods.loadData;
	$.extend($.fn.datagrid.methods, {
		clientPaging: function(jq){
			return jq.each(function(){
				var dg = $(this);
                var state = dg.data('datagrid');
                var opts = state.options;
                opts.loadFilter = pagerFilter;
                var onBeforeLoad = opts.onBeforeLoad;
                opts.onBeforeLoad = function(param){
                    state.allRows = null;
                    return onBeforeLoad.call(this, param);
                }
				dg.datagrid('getPager').pagination({
					onSelectPage:function(pageNum, pageSize){
						opts.pageNumber = pageNum;
						opts.pageSize = pageSize;
						$(this).pagination('refresh',{
							pageNumber:pageNum,
							pageSize:pageSize
						});
						dg.datagrid('loadData',state.allRows);
					}
				});
                $(this).datagrid('loadData', state.data);
                if (opts.url){
                	$(this).datagrid('reload');
                }
			});
		},
        loadData: function(jq, data){
            jq.each(function(){
                $(this).data('datagrid').allRows = null;
            });
            return loadDataMethod.call($.fn.datagrid.methods, jq, data);
        },
        getAllRows: function(jq){
        	return jq.data('datagrid').allRows;
        }
	})
})(jQuery);

function myformatter(value,row,index){
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
			 
			  return  "<span style='font-family:SimSun'>"+num+"</span>";
		 }else{
			 return "<span style='font-family:SimSun'>"+value+"</span>";
	 	 }
	   }else{//如果不是数字
		   if(value.indexOf("jrdwjz")==-1){
			   return "<span style='font-family:SimSun'>"+value+"</span>";
		   }else{
			   return "<span style='font-family:SimSun'>"+value.split("jrdwjz")[0]+"</span>";
		   }
	   }
	 }else{
		 return "";
	 }
}

</script>


<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	     $('#zth1').multiselect({
		  enableFiltering: true,
		  nonSelectedText: '--请选择--',
		  buttonText:function(options, select) {
			  if(options.length>0){
			    return options.length+'个选项被选中';
			  }else{
				  return  '--请选择--';
			  }
		  }
         });
	     $('#zth1_e').multiselect({
			  enableFiltering: true,
			  nonSelectedText: '--请选择--',
			  buttonText:function(options, select) {
				  if(options.length>0){
				    return options.length+'个选项被选中';
				  }else{
					  return  '--请选择--';
				  }
			  }
	     });
	     
	     
	     
	     //初始化table
		 $("#dg").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-80
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
      $("#zth").combobox({
                      valueField: 'value',
        		 	  textField: 'text',
        			  groupField:'zt_group',
        			  mode:'local',
        			  url:'guzhidz/querySelectValue?selectType=queryAllZTH',
                      method:'post',
        			  multiple:false,
        			  width:180,
        			  filter: function(q, row){
        						var opts = $(this).combobox('options');
        						return row[opts.textField].indexOf(q) >-1;
        					},
        		     groupFormatter:function(group){
        		    	        if(trim(group)!="外包账套名称"){
        		    	        	return '<span style="color:red">' + group + '</span>';
        		    	        }else{
        		    	        	return '<span style="color:blue">' + group + '</span>';
        		    	        }
        		     },
        		     onLoadSuccess: function(){
        		    	 $('#zth').next('.combo').find('input').focus(function (){
     			            $('#zth').combobox('clear');
     			         });
        		     }
        					
        	  });  
 /////////////////////////新增///////////////////   
       $("#zttype").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'1',text:'托管'},{value:'2',text:'外包'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
		      onSelect:function(val){
		    	  
		    	  $.ajax({
		    		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=zthselect&type=nopeizhi&utype=nopeizhi&zttype='+val.value,
						type:'get',
						dataType: "json",
						success: function(data){
							if(data.msg="success"){
								var str="";
								$.each(data,function(i,val){
									str +="<option value='"+ val.value+"'>"+val.text+"</option>";
								});
								$('#zth1').multiselect('destroy');
								$('#zth1').find("option").remove();
								$("#zth1").append(str);
								$('#zth1').multiselect({
									 enableFiltering: true,
									 nonSelectedText: '--请选择--',
									 buttonText:function(options, select) {
										  if(options.length>0){
										    return options.length+'个选项被选中';
										  }else{
											  return  '--请选择--';
										  }
									  }
				                });
							}else{
								alert("保存失败！");
							}
						}
					});
		    	  
		    	  
		    	  
						// $("#zth1").combobox({ 
						//		  valueField: 'value',
						//		  textField: 'text',
						//		  disabled:true,
						//		  mode:'local',
					//			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=zthselect&type=nopeizhi&utype=nopeizhi&zttype='+val.value,
					   //           method:'get',
					  //            multiple:true,
						//		  multiline:true,
						//		  width:300,
						//		  height:80,
						////		  filter: function(q, row){
						//					var opts = $(this).combobox('options');
						//					return row[opts.textField].indexOf(q) >-1;
						//				},
						//	      onLoadSuccess: function(){
						//	    	  $(this).combobox('enable');
						//		  },
						//		  selectOnNavigation:$(this).is(':checked')
					    //}).combobox('clear');
						 
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
										return row[opts.textField].indexOf(q) >-1;
									},
							  onLoadSuccess: function(){
								   $(this).combobox('enable');
							  }					
				       }).combobox('clear');
			 }				
	  });
//////////删除//////////////////// 
 
       $("#zttype_r").combobox({
           valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'1',text:'托管'},{value:'2',text:'外包'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
		      onSelect:function(val){
						$("#userInfo1_r").combobox({ 
							  valueField: 'value',
							  textField: 'text',
							  disabled:true,
							  mode:'local',
							  url:'<%=cp%>/guzhidz/querySelectValue?selectType=userselect&utype=peizhi&usertype='+val.value,
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
				       }).combobox('clear');
			 }				
	  });
 
//////////修改//////////////////// 
       $("#zttype_e").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'1',text:'托管'},{value:'2',text:'外包'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
		      onSelect:function(val){
						$("#userInfo1_e").combobox({ 
							  valueField: 'value',
							  textField: 'text',
							  disabled:true,
							  mode:'local',
							  url:'<%=cp%>/guzhidz/querySelectValue?selectType=userselect&utype=peizhi&usertype='+val.value,
				              method:'get',
							  multiple:false,
							  width:150,
							  filter: function(q, row){
										var opts = $(this).combobox('options');
										return row[opts.textField].indexOf(q) >-1;
									},
							  onLoadSuccess: function(){
								   $(this).combobox('enable');
							  },
							  onSelect:function(value){
								  //ajax请求数据 
								   $.ajax({
											type: "POST",
											url:'<%=cp%>/guzhidz/getUserKmInfo',
									    	data: {USERID:value.value},
											dataType:'json',
											cache: false,
											success: function(data){
												if(data!=null){
													var arr=[];
													$.each(data, function(index, n){
														arr.push(n.zth);
												    });
													//$('#zth1_e').combobox('setValues', arr);
													$('#zth1_e').multiselect('deselectAll', false);
												    $('#zth1_e').multiselect('select', arr);
												}
											} 
										});
							  }
							 	
				       }).combobox('clear');
						
					 $.ajax({
						        url:'<%=cp%>/guzhidz/querySelectValue?selectType=zthselect&utype=&type=nopeizhi&zttype='+val.value,
								type:'get',
								dataType: "json",
								success: function(data){
									if(data.msg="success"){
										var str="";
										$.each(data,function(i,val){
											str +="<option value='"+ val.value+"'>"+val.text+"</option>";
										});
										$('#zth1_e').multiselect('destroy');
										$('#zth1_e').find("option").remove();
										$("#zth1_e").append(str);
										$('#zth1_e').multiselect({
											 enableFiltering: true,
											 nonSelectedText: '--请选择--',
											 buttonText:function(options, select) {
												  if(options.length>0){
												    return options.length+'个选项被选中';
												  }else{
													  return  '--请选择--';
												  }
											  }
						                });
									}else{
										alert("保存失败！");
									}
								}
							});
						
				//	 $("#zth1_e").combobox({ 
				//			  valueField: 'value',
				//			  textField: 'text',
			//				  disabled:true,
				//			  mode:'local',
				//			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=zthselect&utype=&type=nopeizhi&zttype='+val.value,
				//              method:'get',
			//	              multiple:true,
			//				  multiline:true,
			//				  width:300,
			//				  height:80,
			//				  filter: function(q, row){
			//							var opts = $(this).combobox('options');
			//							return row[opts.textField].indexOf(q) >-1;
			//						},
			//			      onLoadSuccess: function(){
			//			    	  $(this).combobox('enable');
			//				  },
			//				  selectOnNavigation:$(this).is(':checked')
			//	      }).combobox('clear');
	         }				
	   });
 
 
     
 
 
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
      var params="USERINFO="+$("#userInfo").combobox('getValue')+"&ZTH="+$("#zth").combobox('getValue')+
                      "&ZTHMC="+$("#zth").datebox('getText');
      $('#dg').datagrid({method:'get',url:"guzhidz/getUserConfigInfo?"+params}).datagrid('clientPaging'); 
 }
 
 function adddata(){
	if($("#userInfo1").combobox('getValue')==""||$("#zth1 option:checked").length==0){
		alert("请选择基金名称和估值人员");
		return false;
	}else{
		var userInfo=$("#userInfo1").combobox('getValue');
		var zttype = $("#zttype").combobox('getValue');
		//var zth =$("#zth1").combobox('getValues');
			var zth="";
			$("#zth1 option:checked").each(function(){
				zth+=$(this).val()+",";
			});
			if(zth!=""){
				zth=zth.substring(0,zth.length-1);
			}
	
		
		$.ajax({ 
		        type: "POST", 
		        url: "guzhidz/saveUserConfigInfo", 
		        data: {USERINFO:userInfo,ZTH:zth,ZTTYPE:zttype}, 
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

 function editdata(){
	//	if($("#userInfo1_e").combobox('getValue')==""|$("#zth1_e option:checked").length==0){
	//		alert("请选择基金名称和估值人员");
	//		return false;
	//	}else{
			var userInfo=$("#userInfo1_e").combobox('getValue');
			var zttype = $("#zttype_e").combobox('getValue');
		//	var zth =$("#zth1_e").combobox('getValues');
			var zth="";
			$("#zth1_e option:checked").each(function(){
				zth+=$(this).val()+",";
			});
			if(zth!=""){
				zth=zth.substring(0,zth.length-1);
			}
		
			$.ajax({ 
			        type: "POST", 
			        url: "guzhidz/saveUserConfigInfo", 
			        data: {USERINFO:userInfo,ZTH:zth,ZTTYPE:zttype,CTYPE:'edit'}, 
			        dataType: "json", 
			        success: function(data) {                
			           if(data.msg=="success"){
			        	   alert("操作成功");
			        	   closeDialog2();
			        	   searchdata();
			           }else{ 
			        	   alert("操作失败");
			        	   closeDialog2();
			           }
			        }, 
			        error: function() { 
			           alert("系统异常，操作失败");     
			        } 
			    });  
		//}
	 }
 
 
 function removedata(){
	 if($("#userInfo1_r").combobox('getValue')==""){
			alert("请选择估值人员");
			return false;
		}else{
			var userInfo=$("#userInfo1_r").combobox('getValue');
			$.ajax({ 
			        type: "POST", 
			        url: "guzhidz/saveUserConfigInfo", 
			        data: {USERINFO:userInfo,TYPE:'remove'}, 
			        dataType: "json", 
			        success: function(data) {                
			           if(data.msg=="success"){
			        	   alert("操作成功");
			        	   closeDialog1();
			        	   searchdata();
			           }else{ 
			        	   alert("操作失败");
			        	   closeDialog1();
			           }
			        }, 
			        error: function() { 
			           alert("系统异常，操作失败");     
			        } 
			    });  
		}
 }
 
 
 function closeDialog(){
	 $('#zttype').combobox('clear');
	// $('#zth1').combobox('clear');
	  $('#zth1').multiselect('deselectAll', false); 
	  $('#zth1').multiselect('updateButtonText');
	 $('#userInfo1').combobox('clear');
	 $('#dlg').dialog('close');
 }
 function closeDialog1(){
	 $('#zttype_r').combobox('clear');
	 $('#userInfo1_r').combobox('clear');
	 $('#dlg_remove').dialog('close');
 }
 function closeDialog2(){
	 $('#zttype_e').combobox('clear');
	 // $('#zth1_e').combobox('clear');
	 $('#zth1_e').multiselect('deselectAll', false);
	 $('#zth1_e').multiselect('updateButtonText');
	 $('#userInfo1_e').combobox('clear');
	 $('#dlg_e').dialog('close');
 }
</script>

<script type="text/javascript">
	function chadata_add(){
		var str ="";
		$("#zth1 option:checked").each(function(){
			str+=$(this).text()+",";
		});
		alert(str);
	}
	function chadata_edit(){
		var str ="";
		$("#zth1_e option:checked").each(function(){
			str+=$(this).text()+",";
		});
		alert(str);
	}
	function exportda(){
		var ztgroup = $("#ztgroup").combobox('getValue');
		var user = $("#userInfo").combobox('getValue');

		if (ztgroup == null || ztgroup == "") {

			alert("必须选择账套组");

			return;
		}
		


		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 	var params="ztgroup="+ztgroup+"&user="+user;
	var url="<%=cp%>/guzhidz/userZtcon_ex?"+params; 
	window.location.href=url;
   

}
	function importdata(){
		//var fre_type_dz = $('#fre_type_dz').combobox('getValue');
		var files=  document.getElementById("tgfiles").files
		 var formData = new FormData($("#impdata" )[0]); 
		if(files.length==0){
			$.messager.alert('提示','没有选择文件');
			return;
		}
		
	var filesstring="";
		
	for(var i=0;i<files.length==0;i++){
		filesstring+=files[i]+";";
	}
		$.ajax({
			url:'<%=cp%>/guzhidz/uploadztuser',
			type:'post',
			data:formData,
			 async: false,   
	          cache: false,   
	          contentType: false,   
	          processData: false, 
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("上传成功！");
					$('#tgfiles').val('');
				
					
					
				}else{
					alert("上传失败！");
				}
			}
		}); 
	
	 }
	
</script>

<body>
<div id="tabsidk" >
	<div title="估值人员配置" style="padding: 5px">
	   <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>估值人员:</span> 
			<input class="easyui-combobox"
						name="userInfo" id="userInfo"
		    >
		    <span style="margin-left: 15px;">基金名称:</span> 
			<input class="easyui-combobox"
						name="zth" id="zth"
		    >
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		<!--   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="$('#dlg').dialog('open')">新增</a> -->
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="$('#dlg_e').dialog('open')">修改</a>
		  
		  <form id="impdata" style="" enctype="multipart/form-data">
					<span><input type="file" id="tgfiles" name="tgfiles" style="display: inline;"	/> 
					
				 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="importdata()">导入</a>
				 	  账套组：<select id="ztgroup"
						class="easyui-combobox" name="ztgroup" style="width: 100px;">					    
							<option value="2">外包</option>
							<option value="1">托管</option>
							</select>
		   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportda()">导出</a>
		   </span>
				</form>
		 
		 
		
	
		 <!--  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="$('#dlg_remove').dialog('open')">删除 </a>--> 
		
		</div>
	   <div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <!-- <th data-options="field:'ck',checkbox:true"></th>  -->
                        <th field="username" width="80px">员工姓名</th>
                        <th field="userid" width="80px">员工用户ID</th>
                        <th field="wbztmc" width="200px">外包账套名称</th>
						<th field="wbzth" width="80px">外包账套号</th>
						 <th field="tgztmc" width="200px">托管账套名称</th>
						<th field="tgzth" width="80px">托管账套号</th>
						<th field="username1" width="80px">员工姓名</th>
						<th field="userid1" width="80px">员工用户ID</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
 
<div id="dlg" class="easyui-dialog" closed="true" title="添加估值人员对照信息"
	style="width: 650px; height: 450px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
	<span style="margin-left:20px;">人员类型:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="zttype" name="zttype" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">人员名称:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="userInfo1" name="userInfo1" />
	</span>
	<br/><br/>
	<span style="margin-left:20px;">基金名称:</span> 
	<span> 
		<select name="zth1" id="zth1"  multiple="multiple"></select>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="chadata_add()">查看所选值</a>
	</span> 
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="adddata()">新增</a> 
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialog()">取消</a>
</div>
<!-- 删除 -->
<div id="dlg_remove" class="easyui-dialog" closed="true" title="删除估值人员对照信息"
	style="width: 550px; height: 300px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#dlg-r-buttons'">
	<span style="margin-left:20px;">人员类型:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="zttype_r" name="zttype_r" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">人员名称:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="userInfo1_r" name="userInfo1_r" />
	</span>
	<br/><br/>
	<!-- <span style="margin-left:20px;">基金名称:</span> 
	<span> 
		<input class="easyui-combobox" name="zth1_r" id="zth1_r">
	</span> 
	 -->
</div>
<div id="dlg-r-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a> 
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialog1()">取消</a>
</div>

<!-- 修改 -->
<div id="dlg_e" class="easyui-dialog" closed="true" title="修改估值人员对照信息"
	style="width: 550px; height: 450px; padding: 10px;"
	data-options="iconCls: 'icon-save',buttons: '#dlg-e-buttons'">
	<span style="margin-left:20px;">人员类型:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="zttype_e" name="zttype_e" />
	</span>
	 <br/><br/>
	<span style="margin-left:20px;">人员名称:</span> 
	<span> 
		<input type="text" class="easyui-combobox" id="userInfo1_e" name="userInfo1_e" />
	</span>
	<br/><br/>
     <span style="margin-left:20px;">基金名称:</span> 
	 <span> 
		<!--  <input class="easyui-combobox" name="zth1_e" id="zth1_e">-->
		<select name="zth1_e" id="zth1_e"  multiple="multiple"></select>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="chadata_edit()">查看所选值</a>
	</span> 
	 
</div>
<div id="dlg-e-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="editdata()">修改</a> 
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialog2()">取消</a>
</div>


</body>



