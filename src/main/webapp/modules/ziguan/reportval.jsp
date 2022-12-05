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
<script type="text/javascript">
	
	var editIndex = undefined;
	
	function remove(){
		if (editIndex == undefined){return}
		$('#dg').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
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
	
	function closeDialog(){
		$('#fre_type').combobox('clear');
		$('#fre_email').textbox('clear');
		$('#dlg_add').dialog('close');
	}

	function searchdata(){
		var p_fristtype = $('#fristtype').combobox('getValue');
	 	var p_secondtype = $('#secondtype').combobox('getValue');
	 	var p_c_port_name = $('#userInfo').combobox('getValue');
	 	var p_batch = $('#r_batch').combobox('getValue');
	 	var p_frequencyinfo = $('#r_frequency').combobox('getValue');
	 	var senddate = $('#senddate').datebox('getValue');
	 	var params = "p_fristtype="+p_fristtype+"&p_secondtype="
	 	+p_secondtype+"&c_port_name="+p_c_port_name+"&p_frequencyinfo="
	 	+p_frequencyinfo+"&p_batch="+p_batch+"&date="+senddate;
	   $('#dg').datagrid({method:'post',url:"<%=cp%>/ziguan/searchEmailData?"+params}); 
	 }
	
	function searchdata2(){
		var s_fristtype = $('#s_fristtype').combobox('getValue');
	 	var s_secondtype = $('#s_secondtype').combobox('getValue');
	 	var s_userInfo = $('#s_userInfo').combobox('getValue');
	 	var s_c_port_name = $('#s_c_port_name').combobox('getValue');
	 	var s_flag = $('#s_flag').combobox('getValue');
	 	var senddate = $('#s_date').datebox('getValue');
	 	var params = "s_fristtype="+s_fristtype+"&s_secondtype="
	 	+s_secondtype+"&c_port_name="+s_c_port_name+"&s_flag="
	 	+s_flag+"&s_userInfo="+s_userInfo+"&date="+senddate;
	   $('#dg2').datagrid({method:'post',url:"<%=cp%>/ziguan/searchSendData?"+params}); 
	 }
	
	 function senddata(){
		 var ssinfo ="";
		 if($("#pdf_b")[0].checked)
			 report_b="pdf";
		 else
			 report_b="excel";
		var param ="";
		var charzt =document.getElementById("charzt").checked;
		var senddate = $('#senddate').datebox('getValue');
		var checkItems = $('#dg').datagrid('getChecked');
		if(checkItems.length<=0)
			return;
		$.each(checkItems,function(index,item){
			param += item.pk_batch+"#"+item.date;
				if((checkItems.length-1) != index)
					param += ",";
		});
		$.messager.alert('info', '请耐心等待发送结果，');
		 
		$.ajax({
				url:'<%=cp%>/ziguan/sendmail',
				type:'post',
				data:{param:param,report_b:report_b,charzt:charzt,senddate:senddate},
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
	  //数据结息查询
	 function searchFrequency(){
	      	$('#dg3').datagrid({method:'post',url:"<%=cp%>/ziguan/searchfrequency"}); 
	 }
	 function searchBatchInfo(){
		 	var p_fristtype = $('#p_fristtype').combobox('getValue');
		 	var p_secondtype = $('#p_secondtype').combobox('getValue');
		 	var p_c_port_name = $('#p_c_port_name').combobox('getValue');
		 	var p_frequencyinfo = $('#p_frequencyinfo').combobox('getValue');
		 	var params = "p_fristtype="+p_fristtype+"&p_secondtype="
		 	+p_secondtype+"&c_port_name="+p_c_port_name+"&p_frequencyinfo="+p_frequencyinfo;
	      	$('#dg4').datagrid({method:'post',url:"<%=cp%>/ziguan/queryBatchInfo?"+params}); 
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
	  $("#dg3").datagrid({
		 	 width : '100%',
	     	 height : document.documentElement.clientHeight-120
		 });
	  $("#dg4").datagrid({
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
	 $("#b_c_port_code").combobox({
         valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
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
	 $("#s_c_port_name").combobox({
         valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
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
	 $("#e_c_port_code").combobox({
         valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
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
     
	 $("#fristtype").combobox({
		 valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
	     method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					console.log(opts);
					return row[opts.textField].indexOf(q) >-1;
				},
				onSelect:function(val){
					 $("#secondtype").combobox({ 
							  valueField: 'value',
							  textField: 'text',
							  disabled:true,
							  mode:'local',
							  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
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
				},
				  onLoadSuccess: function(){
							 $('#fristtype').next('.combo').find('input').focus(function (){
						            $('#fristtype').combobox('clear');
						            $('#secondtype').combobox('clear');
						     });
					     }
		 }); 

		 $("#s_userInfo").combobox({
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
				 $('#s_userInfo').next('.combo').find('input').focus(function (){
			            $('#s_userInfo').combobox('clear');
			     });
		     }
	 	 });
		 
		 $("#s_fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onSelect:function(val){
						 $("#s_secondtype").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
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
					},
					  onLoadSuccess: function(){
								 $('#s_fristtype').next('.combo').find('input').focus(function (){
							            $('#s_fristtype').combobox('clear');
							            $('#s_secondtype').combobox('clear');
							     });
								 
						     }
					
		 }); 
		 $("#p_fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onSelect:function(val){
						 $("#p_secondtype").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
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
					},
					  onLoadSuccess: function(){
								 $('#p_fristtype').next('.combo').find('input').focus(function (){
							            $('#p_fristtype').combobox('clear');
							            $('#p_secondtype').combobox('clear');
							     });
								 
						     }
					
		 }); 
		 
		 $("#p_c_port_name").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
             method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					}
	 	 });
		 
		 $("#p_frequencyinfo").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/searchfrequency?type=combobox',
             method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					}
	 	  });

		 
/* 	   $(document).ready(function(){
		   $('#r_frequency').combobox({
				onChange:function(){
					var value = $('#r_frequency').combobox('getValue');
					if(value == 3)
						$('#senddate').datebox({disabled:false});
					else
						$('#senddate').datebox({disabled:true});
				}	   
		   });
	   });   */
});

	function addFrequency(){
		$('#dlg_add').dialog('open');
	}
	function addBatchInfo(){
		$('#dlg_batch').dialog('open');
		 $("#b_frequencyinfo").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/searchfrequency?type=combobox',
             method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					}
	 	  });
	}
	function addFrequencyInfo(){
		var frequency = $("#fre_type").combobox('getValue');
		var email = $("#fre_email").textbox('getValue');
		if(frequency == null || frequency == ''){
			$.messager.alert('提示','请选择发送频率');
			return;
		}
		$.ajax({
			url:'<%=cp%>/ziguan/addFrequencyInfo',
			type:'post',
			data:{frequency:frequency,email:email},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					closeDialog();
				}else{
						alert("保存失败！");
				}
			}
		});
	}
	
	function modifyFreqency(){
		if($("input[name='fck']:checked").length!=1){
			$.messager.alert('提示','请选择一条记录');
			return false;
		}else{
			var row = $('#dg3').datagrid('getSelected');
			$('#m_pk_frequency').val(row.pk_frequency);
			$("#m_frequency").combobox('setValue',row.frequency);
			$("#m_email").textbox('setValue',row.email_info);
			$('#dlg_edit').dialog('open');
		}
	}
	
	function saveFrequencyInfo(){
		var pk_frequency = $("#m_pk_frequency").val();
		var frequency = $("#m_frequency").combobox('getValue');
		var email = $("#m_email").textbox('getValue');
		if(frequency == null || frequency == ''){
			$.messager.alert('提示','请选择发送频率');
			return;
		}
		$.ajax({
			url:'<%=cp%>/ziguan/modifyFrequencyInfo',
			type:'post',
			data:{frequency:frequency,email:email,pk_frequency:pk_frequency},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					closeEditDialog();
					searchFrequency();
				}else{
						alert("保存失败！");
				}
			}
		});
	}
	function closeEditDialog(){
		$('#dlg_edit').dialog('close');
		$("#m_frequency").combobox('clear');
		$("#m_email").textbox('clear');
	}
	function removeFreqency(){
		if($("input[name='fck']:checked").length==0){
			$.messager.alert('提示','请选择要删除的信息');
			return false;
		}else{
			$.messager.confirm('Confirm','删除频率信息会删除对应的邮箱信息配置，确认要删除勾选内容?',function(r){
				if(r){
					var ids ="";
					var checkItems = $('#dg3').datagrid('getChecked');
					$.each(checkItems,function(index,item){
						ids += item.pk_frequency;
						if((checkItems.length-1) != index)
							ids += ",";
					});
					$.ajax({
						url:'<%=cp%>/ziguan/removeFrequencyInfo',
						type:'post',
						data:{ids:ids},
						dataType: "json",
						success: function(data){
							searchFrequency();
						}
					})
				}else{
					return;
				}
			});
		}
	}
	function modifyBatchInfo(){
		 $("#e_frequencyinfo").combobox({
             valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/searchfrequency?type=combobox',
             method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					}
	 	  });
		if($("input[name='bck']:checked").length!=1){
			$.messager.alert('提示','请选择一条记录');
			return false;
		}else{
			var row = $('#dg4').datagrid('getSelected');
			$('#m_pk_batch').val(row.pk_batch);
			$("#e_c_port_code").combobox('setValue',row.zth);
			if(row.frequency !=null && "" != row.frequency ){
				$("#e_frequencyinfo").combobox('setValue',row.frequency_value);
			}
			$("#e_batch").combobox('setValue',row.batch_value);
			$("#e_email").textbox('setValue',row.email);
			$('#dlg_batch_edit').dialog('open');
		}
	}
	function removeBatchInfo(){
		if($("input[name='bck']:checked").length==0){
			$.messager.alert('提示','请选择要删除的信息');
			return false;
		}else{
			$.messager.confirm('Confirm','确认要删除勾选内容?',function(r){
				if(r){
					var ids ="";
					var checkItems = $('#dg4').datagrid('getChecked');
					$.each(checkItems,function(index,item){
						ids += item.pk_batch;
						if((checkItems.length-1) != index)
							ids += ",";
					});
					$.ajax({
						url:'<%=cp%>/ziguan/removeBatchInfo',
						type:'post',
						data:{ids:ids},
						dataType: "json",
						success: function(data){
							searchBatchInfo();
						}
					})
				}else{
					return;
				}
			});
		}
	}
	function saveBatchInfo(){
		var c_port_code = $("#b_c_port_code").combobox('getValue');
		var frequency = $("#b_frequencyinfo").combobox('getValue');
		var email = $("#b_email").textbox('getValue');
		var batch = $("#batch").combobox("getValue");
		if(frequency == null || frequency == ''){
			$.messager.alert('提示','请选择发送频率');
			return;
		}
		if(c_port_code == null || c_port_code == ''){
			$.messager.alert('提示','请选择产品');
			return;
		}
		if(batch == null || batch == ''){
			$.messager.alert('提示','请选择批次信息');
			return;
		}
		$.ajax({
			url:'<%=cp%>/ziguan/saveBatchInfo',
			type:'post',
			data:{frequency:frequency,email:email,c_port_code:c_port_code,batch:batch},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					closeBatchDialog();
					searchBatchInfo();
				}else{
					alert("保存失败！");
				}
			}
		});
	}
	function editBatchInfo(){
		var c_port_code = $("#e_c_port_code").combobox('getValue');
		var frequency = $("#e_frequencyinfo").combobox('getValue');
		var email = $("#e_email").textbox('getValue');
		var batch = $("#e_batch").combobox("getValue");
		var pk_batch = $("#m_pk_batch").val();
		if(frequency == null || frequency == ''){
			$.messager.alert('提示','请选择发送频率');
			return;
		}
		if(c_port_code == null || c_port_code == ''){
			$.messager.alert('提示','请选择产品');
			return;
		}
		if(batch == null || batch == ''){
			$.messager.alert('提示','请选择批次信息');
			return;
		}
		$.ajax({
			url:'<%=cp%>/ziguan/editBatchInfo',
			type:'post',
			data:{frequency:frequency,email:email,c_port_code:c_port_code,batch:batch,pk_batch:pk_batch},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					closeEditBatchDialog();
				}else{
					alert("保存失败！");
				}
			}
		});
	}
	function closeEditBatchDialog(){
		$('#dlg_batch_edit').dialog('close');
		$("#e_c_port_code").combobox('clear');
		$("#e_email").textbox('clear');
		$("#e_frequencyinfo").combobox('clear');
		$("#e_batch").combobox('e_batch');
		$("#m_pk_batch").textbox('clear');
	}
	function closeBatchDialog(){
		$('#dlg_batch').dialog('close');
		$("#b_frequencyinfo").combobox('clear');
		$("#b_email").textbox('clear');
		$("#b_c_port_name").combobox('clear');
	}
</script>

<body>
	<div id="tabsidk" class="easyui-tabs" style="">
		<div title="估值表发送" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<span>估值人员:</span> 
					<input class="easyui-combobox" name="userInfo" id="userInfo"/> 
				<span style="margin-left: 15px;">一级分类:</span>
					<input class="easyui-combobox" name="ziguan_logo" id="fristtype"/>
				<span style="margin-left: 15px;">二级分类:</span>
					<input class="easyui-combobox"  style="width: 150px;"name="ziguan_logo" id="secondtype"/>
				<span style="display: none"> 
					<input type="checkbox" id="pdf_b" name="p df_b"/> PDF盖章版</span> 
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'" onclick="senddata()">发送</a><br/> 
				<span style="margin-left: 23px;">批次:</span> 
				<span> 
					<select id="r_batch" class="easyui-combobox" name="r_batch" style="width: 150px;">
					<option value="">--请选择--</option>								
					<option value="0">托管人</option>
					<option value="1">委托人</option>
					<option value="2">资管</option>
				</select>
				</span> 
				<span style="margin-left: 39px;">频率:</span> 
				<span> 
					<select id="r_frequency" class="easyui-combobox" name="r_frequency"  style="width: 150px;">
						<option value="">请选择</option>
						<option value="0">T+0</option>
						<option value="1">T+1</option>
						<option value="2">T+L</option>
						<option value="3">自定义</option>
					</select>
				</span> 
				<span style="margin-left: 39px;">日期:</span>
					<span>
						<input id="senddate" name="date" class="easyui-datebox" style="width: 150px" />
					</span>
				<input type="checkbox" name="charzt"   id="charzt" />指定日期<br />
			</div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="rownumbers:true,  autoRowHeight:false,pagination:true,pageSize:500,
							singleSelect: false,
							selectOnCheck:true,
							checkOnSelect:true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th field="pk_batch"  hidden=true></th>
							<th field="datacode" hidden=true>代码</th>
							<th field="zth" width="100px">账套号</th>
							<th field="c_port_name" width="200px">账套名称</th>
							<th field="batch" width="100px">批次</th>
							<th field="frequency" width="100px">频率</th>
							<th field="date" width="100px">估值日期</th>
							<th field="username" width="150px">估值人员</th>
							<th field="id"  hidden=true></th>
							<!-- <th field="status" width="100px">状态</th> -->
							<th field= "email" width="30%">收件人邮箱</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>

		<div title="频率模板配置" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchFrequency()">查询</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addFrequency()">新增</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifyFreqency()">修改</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeFreqency()">删除</a> 
					<br />
			</div>
			<div style="margin-top: 10px;">
				<table id="dg3" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<th data-options="field:'fck',checkbox:true"></th>
							<th field="pk_frequency" hidden=true></th>
							<th field="frequency" hidden=true></th>
							<th field="frequency_value"  style="width:150px;">频率</th>
							<th field="email_info"  style="width:50%;">邮件内容</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div title="批次邮箱配置" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<div>
					<span style="margin-left: 15px;">一级分类:</span>
						<input class="easyui-combobox" name="p_fristtype" id="p_fristtype" />
					<span style="margin-left: 15px;">二级分类:</span>
						<input class="easyui-combobox"  style="width: 150px;"name="p_secondtype" id="p_secondtype"/> 
					<span style="margin-left: 15px;">产品名称:</span> 
						<input class="easyui-combobox" name="p_c_port_name" id="p_c_port_name"/> 
					<span style="margin-left: 15px;">频率:</span> 
						<input class="easyui-combobox" name="p_frequency" id="p_frequencyinfo"/> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchBatchInfo()">查询</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addBatchInfo()">新增</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifyBatchInfo()">修改</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeBatchInfo()">删除</a> 
				</div>
			</div>
			<div style="margin-top: 10px;">
				<table id="dg4" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<th data-options="field:'bck',checkbox:true"></th>
							<th field="pk_batch" hidden=true></th>
							<th field="zth" width="80px">账套号</th>
							<th field="c_port_name" width="150px">账套名称</th>
							<th field="username" width="100px">估值人员</th>
							<th field="frequency" width="100px">频率</th>
							<th field="frequency_value" hidden=true></th>
							<th field="batch" width="100px">批次</th>
							<th field="batch_value" hidden=true></th>
							<th field="email" width="500px">收件人邮箱</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		
 		<div title="发送记录查询" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<span>估值人员:</span> 
					<input class="easyui-combobox" name="userInfo" id="s_userInfo"> 
				<span style="margin-left: 15px;">一级分类:</span>
					<input class="easyui-combobox" name="ziguan_logo" id="s_fristtype">
				<span style="margin-left: 15px;">二级分类:</span>
					<input class="easyui-combobox"  style="width: 150px;" name="ziguan_logo" id="s_secondtype">
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a> 
				<br/>
				<span>产品名称:</span> 
					<input class="easyui-combobox" name="c_port_name" id="s_c_port_name"> 
				<span style="margin-left: 15px;">发送日期:</span>
				<span>
					<input id="s_date" name="s_date" class="easyui-datebox" style="width: 150px" data-options=""></input>
				</span>
				<span style="margin-left: 39px;">状态:</span> 
				<span> 
					<select id="s_flag" class="easyui-combobox" name="s_flag" style="width: 150px;">
						<option value="0">全部</option>
						<option value="1">成功</option>
						<option value="2">失败</option>
					</select>
				</span> 
				<span style="display: none"> 
					<span style="margin-left: 15px;">估值表日期</span> 
					<span>
						<input id="wbdate2" name="wbdate2" class="easyui-datebox" style="width: 150px"></input>
					</span> 
					<span style="color: red;"> </span>
					<span style="margin-left: 15px;">估值人员:</span> 
						<input class="easyui-combobox" name="guzhi_name" id="guzhiname">
						<span>&nbsp&nbsp&nbsp</span>
				</span> 
				<br />
			</div>
			<div style="margin-top: 10px;">
				<table id="dg2" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<th field="zth"  width="5%">账套号</th>
							<th field="ztmc" width="10%">账套名称</th>
							<th field="reportdate" width="10%">估值表日期</th>
							<th field="senddate" width="10%">发送日期</th>
							<th field="tomail" width="10%">接收人</th>
							<th field="flag" width="10%">发送结果</th>
							<th field="reporttype" width="10%">类型</th>
							<th field="fujian" width="30%">附件</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		
	</div>
	<div id="dlg_add" class="easyui-dialog" closed="true" title="添加频率信息"
				style="width: 450px; height: 230px; padding: 10px;"
				data-options="
							iconCls: 'icon-save',
							buttons: '#dlg-buttons_add'
				">
		<span style="margin-left: 20px">发送频率:</span> 
		<span>
			<select id="fre_type" class="easyui-combobox" name="fre_type" style="width: 100px;">
				<option value="">--请选择--</option>								
				<option value="0">T+0</option>
				<option value="1">T+1</option>
				<option value="2">T+L</option>
				<option value="3">自定义</option>
			</select>
		</span>
		<br/><br/>
		<span style="margin-left: 18px">&nbsp;邮件内容:</span> 
		<span> 
			<input type="text" class="easyui-textbox" id="fre_email" name="email"  style="width:320px;height:80px;"/>
		</span> 
	</div>
	<div id="dlg-buttons_add">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addFrequencyInfo()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialog()">取消</a>
	</div>
	
	<div id="dlg_edit" class="easyui-dialog" closed="true" title="编辑频率信息"
				style="width: 450px; height: 230px; padding: 10px;"
				data-options="
							iconCls: 'icon-save',
							buttons: '#dlg-buttons_edit'
				">
		<span style="margin-left: 20px">发送频率:</span> 
		<input type="hidden"  id ="m_pk_frequency"  value = "" />
		<span>
			<select id="m_frequency" class="easyui-combobox" name="fre_type" style="width: 100px;">
				<option value="">--请选择--</option>								
				<option value="0">T+0</option>
				<option value="1">T+1</option>
				<option value="2">T+L</option>
				<option value="3">自定义</option>
			</select>
		</span>
		<br/><br/>
		<span style="margin-left: 18px">&nbsp;邮件内容:</span> 
		<span> 
			<input type="text" class="easyui-textbox" id="m_email" name="email"  style="width:320px;height:80px;"/>
		</span> 
	</div>
	<div id="dlg-buttons_edit">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveFrequencyInfo()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeEditDialog()">取消</a>
	</div>

	<div id="dlg_batch" class="easyui-dialog" closed="true" title="添加批次信息"
				style="width: 450px; height: 300px; padding: 10px;"
				data-options="
							iconCls: 'icon-save',
							buttons: '#dlg-buttons_batch'
				">
		<span style="margin-left: 20px">产品名称:</span> 
			<input class="easyui-combobox" name="c_port_name" id="b_c_port_code"> 
		<br/><br/>
		<span style="margin-left: 40px;">频率:</span> 
			<input class="easyui-combobox" name="b_frequency" id="b_frequencyinfo"/> 
		<br/><br/>
		<span style="margin-left: 40px">批次:</span> 
		<span>
			<select id="batch" class="easyui-combobox" name="batch" style="width: 100px;">
				<option value="">--请选择--</option>								
				<option value="0">托管人</option>
				<option value="1">委托人</option>
				<option value="2">资管</option>
			</select>
		</span>
		<br/><br/>
		<span style="margin-left: 40px">&nbsp;邮箱:</span> 
		<span> 
			<input type="text" class="easyui-textbox" id="b_email" name="email"  style="width:320px;height:80px;"/>
		</span> 
	</div>
	<div id="dlg-buttons_batch">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveBatchInfo()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeBatchDialog()">取消</a>
	</div>
	
	<div id="dlg_batch_edit" class="easyui-dialog" closed="true" title="修改批次信息"
				style="width: 450px; height: 300px; padding: 10px;"
				data-options="
							iconCls: 'icon-save',
							buttons: '#dlg-buttons_batch_edit'
				">
		<input type="hidden"  id ="m_pk_batch"  value = "" />
		<span style="margin-left: 20px">产品名称:</span> 
			<input class="easyui-combobox" name="c_port_name" id="e_c_port_code"> 
		<br/><br/>
		<span style="margin-left: 40px;">频率:</span> 
			<input class="easyui-combobox" name="b_frequency" id="e_frequencyinfo"/> 
		<br/><br/>
		<span style="margin-left: 40px">批次:</span> 
		<span>
			<select id="e_batch" class="easyui-combobox" name="batch" style="width: 100px;">
				<option value="">--请选择--</option>								
				<option value="0">托管人</option>
				<option value="1">委托人</option>
				<option value="2">资管</option>
			</select>
		</span>
		<br/><br/>
		<span style="margin-left: 40px">&nbsp;邮箱:</span> 
		<span> 
			<input type="text" class="easyui-textbox" id="e_email" name="email"  style="width:320px;height:80px;"/>
		</span> 
	</div>
	<div id="dlg-buttons_batch_edit">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editBatchInfo()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeEditBatchDialog()">取消</a>
	</div>

</body>