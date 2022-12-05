<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>账套对应关系配置</title>
    <script>document.documentElement.focus();</script>
    
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 --> 
<script type="text/javascript">
 $(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
	 	 height : document.documentElement.clientHeight-20
	 });
	//初始化table
	 $("#dg").datagrid({
	 	 width : '100%',
   	     height :document.documentElement.clientHeight-160
	 });	
	 $("#dgpz").datagrid({
 	 	 width : '100%',
      	 height : document.documentElement.clientHeight-93
 	 });
	 $("#dgsta").datagrid({
 	 	 width : '100%',
      	 height : document.documentElement.clientHeight-93
 	 });
	 $("#guzhi_group").datagrid({
 	 	 width : '100%',
      	 height : document.documentElement.clientHeight-93
 	 });
	 
	 
 	 
 $('#tabsidk').tabs({
    border:false,
    onSelect:function(title,index){
        searchdata();
        typsearchdata();
        stasearchdata();
    }
});
	 
 $("#zth").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
     method:'post',
	  multiple:false,
	  width:180,
	  filter: function(q, row){
				var opts = $(this).combobox('options');
				console.log(opts);
				return row[opts.textField].indexOf(q) >-1;
			},
	  onLoadSuccess: function(){
				 $('#zth').next('.combo').find('input').focus(function (){
			            $('#zth').combobox('clear');
			            
			     });
				 
		     }
 });
 $("#typ").combobox({
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
	  onLoadSuccess: function(){
				 $('#typ').next('.combo').find('input').focus(function (){
			            $('#typ').combobox('clear');
			            
			     });
				 
		     }
 });
 $("#guzhiname").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
     method:'post',
	  multiple:false,
	  width:140,
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
    
		 $("#fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:120,
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
								  width:120,
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
 });


	
</script>
<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
    var params="zth="+$("#zth").combobox('getValue')+"&guzhiname="+$("#guzhiname").combobox('getValue')+
                    "&fristtype="+$("#fristtype").combobox('getValue')+"&secondtype="+$("#secondtype").combobox('getValue')+
                    "&is_o32="+$("#s_is_o32").combobox('getValue')+"&type="+$("#s_type").combobox('getValue')+
                    "&management="+$("#s_management").combobox('getValue')+"&liq_mode="+$("#s_liq_mode").combobox('getValue')+
                    "&frequency="+$("#s_frequency").combobox('getValue')+"&status="+$("#s_statues").combobox('getValue');
    $('#dg').datagrid({method:'get',url:"ziguan/queryZT?"+params}).datagrid('clientPaging'); 
}

function opendialog(){
	$("#zths").combobox({
		 valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=add',
	     method:'post',
		  multiple:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					console.log(opts);
					return row[opts.textField].indexOf(q) >-1;
				},
		  onLoadSuccess: function(){
					 $('#zths').next('.combo').find('input').focus(function (){
				            $('#zths').combobox('clear');
				            
				     });
					 
			     }
	 });
	 $("#guzhinames").combobox({
		 valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
	     method:'post',
		  multiple:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					console.log(opts);
					return row[opts.textField].indexOf(q) >-1;
				},
				  onLoadSuccess: function(){
						 $('#guzhinames').next('.combo').find('input').focus(function (){
					            $('#guzhinames').combobox('clear');
					            
					     });
						 
				     }
	 });
	 $("#zgstatus").combobox({
		 valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=05',
	     method:'post',
		  multiple:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					console.log(opts);
					return row[opts.textField].indexOf(q) >-1;
				},
		  onLoadSuccess: function(){
					 $('#zgstatus').next('.combo').find('input').focus(function (){
				            $('#zgstatus').combobox('clear');
				            
				     });
					 
			     }
	 });
	 $("#zgbank").combobox({
		 valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/ziguan/getUserSelect?selectType=06',
	     method:'post',
		  multiple:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					console.log(opts);
					return row[opts.textField].indexOf(q) >-1;
				},
		  onLoadSuccess: function(){
					 $('#zgbank').next('.combo').find('input').focus(function (){
				            $('#zgbank').combobox('clear');
				            
				     });
					 
			     }
	 });
	    
			 $("#zttypevalue").combobox({
				 valueField: 'value',
				  textField: 'text',
				  mode:'local',
				  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
			     method:'post',
				  multiple:false,
				  width:250,
				  filter: function(q, row){
							var opts = $(this).combobox('options');
							console.log(opts);
							return row[opts.textField].indexOf(q) >-1;
						},
						onSelect:function(val){
						    
							 $("#zttypevalue2").combobox({ 
									  valueField: 'value',
									  textField: 'text',
									  disabled:true,
									  mode:'local',
									  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
						              method:'get',
									  multiple:false,
									  width:250,
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
									 $('#zttypevalue').next('.combo').find('input').focus(function (){
								            $('#zttypevalue').combobox('clear');
								            $('#zttypevalue2').combobox('clear');
								     });
									 
							     }
						
			 }); 
	
	
	$('#dlg').dialog('open');
}
function addAcountMapping(){
	var zths=$("#zths").combobox('getValue');
	var guzhinames=$("#guzhinames").combobox('getValue');
	var zgstatus=$("#zgstatus").combobox('getValue');
	var zgbank=$("#zgbank").combobox('getValue');
	var zttypevalue=$("#zttypevalue").combobox('getValue');
	var zttypevalue2=$("#zttypevalue2").combobox('getValue');
	var zgtype = $("#a_type").combobox('getValue');
	var zgfrequency =$("#a_frequency").combobox('getValue');
	var zgmanagement =$("#a_management").combobox('getValue');
	var zgliq_mode =$("#a_liq_mode").combobox('getValue');
	var zgis_o32 =$("#a_is_o32").combobox('getValue');
	var zgpro_cal =$("#a_pro_cal").combobox('getValue');
	if(zths==""){
		alert("请选择账套名称");
		return false;
	}else if(guzhinames==""){
		alert("请选择估值人员信息");
		return false;
	}else if(zttypevalue==""  ){
		alert("请选择一级分类");
		return false;
	}else{
				$.ajax({
					url:'<%=cp%>/ziguan/addAccountMapping',
					type:'post',
					data:{zths:zths,guzhinames:guzhinames,zgstatus:zgstatus,zgbank:zgbank,
						zttypevalue:zttypevalue,zttypevalue2:zttypevalue2,zgtype:zgtype,zgfrequency:zgfrequency,
						zgmanagement:zgmanagement,zgliq_mode:zgliq_mode,zgis_o32:zgis_o32,zgpro_cal:zgpro_cal
					},
					dataType: "json",
					success: function(data){
					if(data.msg="success"){
						alert("保存成功！");
						$('#dlg').dialog('close');
						closeDialog();
						searchdata();
					}else{
						alert("保存失败！");
					}
				}
			});
	
	}
}
function staaddAcount(){
	var sta =$("#sta").textbox('getValue');
	if(sta==""){
		alert("请输入状态");
		return false
	 }
	else{
		$.ajax({
			url:'<%=cp%>/ziguan/addAccount',
			type:'post',
			data:{sta:sta
			},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					$('#stadlg').dialog('close');
					closeDialog();
					stasearchdata();
				}else{
					alert("保存失败！");
				}
			}
		});
	}
}

function groupaddAcount(){
	var area =$("#area").combobox('getValue');
	var group_code =$("#group_code").textbox('getValue');
	if(group_code==""){
		alert("请输入组代码");
		return false
	 }
	else{
		$.ajax({
			url:'<%=cp%>/ziguan/addGroup',
			type:'post',
			data:{area:area,group_code:group_code
			},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					$('#grouplg').dialog('close');
					closeDialog();
					groupsearchdata();
				}else{
					alert("保存失败！");
				}
			}
		});
	}
}


function addAcountOnt(){
	var ont =$("#ont").textbox('getValue');
	if(ont==""){
		alert("请输入一级分类");
		return false
	 }
	else{
		$.ajax({
			url:'<%=cp%>/ziguan/addAccountOnt',
			type:'post',
			data:{ont:ont
			},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					$('#stadlg').dialog('close');
					closeDialog();
					typsearchdata();
					 $("#typ").combobox({
						 valueField: 'value',
						  textField: 'text',
						  mode:'local',
						  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
					     method:'post',
						  multiple:false,
						  width:250,
						  filter: function(q, row){
									var opts = $(this).combobox('options');
									console.log(opts);
									return row[opts.textField].indexOf(q) >-1;
								},
								  onLoadSuccess: function(){
										 $('#typ').next('.combo').find('input').focus(function (){
									            $('#typ').combobox('clear');
									            
									     });
										 
								     }
					 });
				}else{
					alert("保存失败！");
				}
			}
		});
	}
}

function addAcountSent(){
	var fir=$("#typs").combobox("getValue");
	var sent =$("#sent").textbox('getValue');
	if (fir=="") {
		alert("请输入一级分类");
		return false
	}else if(sent==""){
		alert("请输入二级分类");
		return false
	 }
	else{
		$.ajax({
			url:'<%=cp%>/ziguan/addAccountSent',
			type:'post',
			data:{fir :fir,sent : sent
			},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("保存成功！");
					$('#stadlg').dialog('close');
					closeDialog();
					typsearchdata();
				}else{
					alert("保存失败！");
				}
			}
		});
	}
}
function removedata(){
	if($("input[name='ck']:checked").length==0){
		alert("请选择一条记录！");
		return false;
	}else{
		if(confirm("确定要删除吗？")){
			var ids ="";
			$.each($("input[name='ck']:checked"),function(){
				ids +=$(this).val()+",";
			});
		    if(ids!=""){
			    ids = ids.substring(0,ids.length-1);
				$.ajax({
					url:'<%=cp%>/ziguan/deleteAccountMapping',
					type : 'post',
					data : {ck : ids},
					dataType : "json",
					success : function(data) {
							alert("删除成功！");
							searchdata();
					}
				});
		    }
		}
	}

}
function editdata(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		$("#zths_u").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=01',
		     method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
			  onLoadSuccess: function(){
						 $('#zths_u').next('.combo').find('input').focus(function (){
					         //   $('#zths_u').combobox('clear');
					            
					     });
						 
				     }
		 });
		 $("#guzhinames_u").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
		     method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					  onLoadSuccess: function(){
							 $('#guzhinames_u').next('.combo').find('input').focus(function (){
						        //    $('#guzhinames_u').combobox('clear');
						            
						     });
							 
					     }
		 });
		 $("#zgstatus_u").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=05',
		     method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
			  onLoadSuccess: function(){
						 $('#zgstatus_u').next('.combo').find('input').focus(function (){
					          //  $('#zgstatus_u').combobox('clear');
					            
					     });
						 
				     }
		 });
		 $("#zgbank_u").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=06',
		     method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
			  onLoadSuccess: function(){
						 $('#zgbank_u').next('.combo').find('input').focus(function (){
					           // $('#zgbank_u').combobox('clear');
					            
					     });
						 
				     }
		 });
		    
		 $("#zttypevalue_u").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
			  onSelect:function(val){
						 $("#zttypevalue2_u").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+val.value,
					              method:'get',
								  multiple:false,
								  width:250,
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
								 $('#zttypevalue_u').next('.combo').find('input').focus(function (){
							          //  $('#zttypevalue_u').combobox('clear');
							          //  $('#zttypevalue2_u').combobox('clear');
							     });
								 
						     }
					
		 }); 

				 
		var id = $("input[name='ck']:checked").val();
		$.ajax({
			url:'<%=cp%>/ziguan/getListById',
			type:'post',
			
			data:{ck:id},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					 var json =data.data;
					 if(json.length>0){
						 var  account_id = json[0].account_id;
						 $("#zths_u").combobox('setValue',account_id);
						 $("#zths_u").combobox('disable');
						 var  top_classify = json[0].top_classify;
						 //$("#zttypevalue_u").combobox('setValue',top_classify);
						 $("#zttypevalue_u").combobox('select',top_classify);
						 
						 var  status = json[0].status;
						 $("#zgstatus_u").combobox('setValue',status);
						 var  bank = json[0].bank;
						 $("#zgbank_u").combobox('setValue',bank);
						 var  user_id = json[0].user_id;
						 $("#guzhinames_u").combobox('setValue',user_id);
						 var  sub_classify = json[0].sub_classify;
						 $("#zttypevalue2_u").combobox('setValue',sub_classify);
						 var is_o32 = json[0].is_o32;
						 $("#m_is_o32").combobox('select',is_o32);
						 var type = json[0].type;
						 $("#m_type").combobox('select',type);
						 var management = json[0].management;
						 $("#m_management").combobox('select',management);
						 var frequency = json[0].frequency;
						 $("#m_frequency").combobox('select',frequency);
						 var liq_mode = json[0].liq_mode;
						 $("#m_liq_mode").combobox('select',liq_mode);
						 
						 var pro_cal = json[0].pro_cal;
						 $("#m_pro_cal").combobox('select',pro_cal);
					}
				}
			}
		});
		$('#cdlg').dialog('open');
	}
}
function typeditdata(){
	if($("input[name='kk']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var id = $("input[name='ck']:checked").val();
		var kk = $("input[name='kk']:checked").val();
		$.ajax({
			url:'<%=cp%>/ziguan/gettypById',
			type:'post',
			
			data:{ck:id,kk:kk},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					 var json =data.data;
					 if(json.length>1){
					 var  datavalue = json[1].datavalue;
					 $("#typup").textbox('setValue',datavalue);
					 var  datavalue = json[0].datavalue;
					 $("#typupone").textbox('setValue',datavalue);
					 }
					 if(json.length==1){
						 var  datavalue = json[0].datavalue;
						 $("#typupone").textbox('setValue',datavalue);
						 
					 }
				}
			}
		});
		if (id=='0') {
	      $("#zjflspan1").hide();		
	      $("#zjflspan2").hide();		
		}else{
			 $("#zjflspan1").show();		
		      $("#zjflspan2").show();
		}
	 $('#typupda').dialog('open');
	}
}
function updatetypAcount(){
		var id = $("input[name='ck']:checked").val();
		var kk = $("input[name='kk']:checked").val();
		
		var typup =$("#typup").textbox('getValue');
		var typupone =$("#typupone").textbox('getValue');
		$.ajax({
			url:'<%=cp%>/ziguan/updateTypMapping',
			type:'post',
			data:{id:id,kk:kk,typup:typup,typupone:typupone},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("保存成功");
					closeDialog();
					typsearchdata();
				}else{
					alert("保存失败");
				}
				
			}
		});
}
function staeditdata(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var id = $("input[name='ck']:checked").val();
		$.ajax({
			url:'<%=cp%>/ziguan/getstaById',
			type:'post',
			
			data:{ck:id},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					 var json =data.data;
					 if(json.length>0){
					 var  datavalue = json[0].datavalue;
					 $("#stads").textbox('setValue',datavalue);
					 
					 }
				}
			}
		});
	 $('#stad').dialog('open');
	}
}

function groupeditdata(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var id = $("input[name='ck']:checked").val();
		$.ajax({
			url:'<%=cp%>/ziguan/getGroupById',
			type:'post',
			
			data:{ck:id},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					 var json =data.data;
					 if(json.length>0){
					 var  datavalue = json[0].datavalue;
					 $("#stads").textbox('setValue',datavalue);
					 
					 }
				}
			}
		});
	 $('#group').dialog('open');
	}
}

function updatestaAcount(){

		var id = $("input[name='ck']:checked").val();
		var stad =$("#stads").textbox('getValue');
		$.ajax({
			url:'<%=cp%>/ziguan/updateStaMapping',
			type:'post',
			data:{id:id,stad:stad},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("保存成功");
					closeDialog();
					stasearchdata();
				}else{
					alert("保存失败");
				}
				
			}
		});
	}

function saveAcountMapping(){
	var id = $("input[name='ck']:checked").val();
	var zths_u=$("#zths_u").combobox('getValue');
	var guzhinames_u=$("#guzhinames_u").combobox('getValue');
	var zgstatus_u=$("#zgstatus_u").combobox('getValue');
	var zgbank_u=$("#zgbank_u").combobox('getValue');
	var zttypevalue_u=$("#zttypevalue_u").combobox('getValue');
	var zttypevalue2_u=$("#zttypevalue2_u").combobox('getValue');
	var is_o32 = $("#m_is_o32").combobox('getValue');
	var type = $("#m_type").combobox('getValue');
	var frequency = $("#m_frequency").combobox('getValue');
	var management = $("#m_management").combobox('getValue');
	var liq_mode = $("#m_liq_mode").combobox('getValue');
	var pro_cal = $("#m_pro_cal").combobox('getValue');
	
	if(zths==""||guzhinames==""){
		alert("请选择账套名称和估值人员信息");
		return false;
	}else if(zttypevalue=="" || zttypevalue==""){
		alert("请选择分类");
		return false;
	}else if(zgstatus==""||zgbank==""){
		alert("请选择托管行和状态");
		return false;
	}else{
		$.ajax({
			url:'<%=cp%>/ziguan/updateAccountMapping',
			type:'post',
			data:{id:id,zths_u:zths_u,guzhinames_u:guzhinames_u,zgstatus_u:zgstatus_u,zgbank_u:zgbank_u,
				zttypevalue_u:zttypevalue_u,zttypevalue2_u:zttypevalue2_u,is_o32:is_o32,type:type,frequency:frequency,
				management:management,liq_mode:liq_mode,pro_cal:pro_cal
			},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("修改成功！");
					$('#cdlg').dialog('close');
					closeDialog();
					searchdata();
				}else{
					alert("修改失败！");
				}
			}
		});
}
}
function typsearchdata(){
	var params="secondtyp="+$("#typ").combobox('getValue');
	$('#dgpz').datagrid({method:'get',url:"<%=cp%>/ziguan/getUserSelecttype?"+params}).datagrid('clientPaging'); 
	
}
function stasearchdata(){
	$('#dgsta').datagrid({method:'get',url:"<%=cp%>/ziguan/getUserSelect?selectType=05"}).datagrid('clientPaging'); 
}

function groupsearchdata(){
	$('#guzhi_group').datagrid({method:'get',url:"<%=cp%>/ziguan/getUserSelect?selectType=08"}).datagrid('clientPaging'); 
}

function staremovedata(){

	var id = $("input[name='ck']:checked").val();
		if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			if(confirm("确定要删除吗？")){
				$.ajax({
					url:'<%=cp%>/ziguan/deletesta',
					type : 'post',
					data : {id : id},
					dataType : "json",
					success : function(data) {
							alert("删除成功！");
							stasearchdata();
					}
				});
			}
		}

	
}
function typremovedata(){
		if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var id = $("input[name='ck']:checked").val();
			if(confirm("确定要删除吗？")){
				$.ajax({
					url:'<%=cp%>/ziguan/deletetype',
					type : 'post',
					data : {id : id},
					dataType : "json",
					success : function(data) {
							alert("删除成功！");
							 $("#typ").combobox({
								 valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
							     method:'post',
								  multiple:false,
								  width:250,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											console.log(opts);
											return row[opts.textField].indexOf(q) >-1;
										},
										  onLoadSuccess: function(){
												 $('#typ').next('.combo').find('input').focus(function (){
											            $('#typ').combobox('clear');
											            
											     });
												 
										     }
							 });
							typsearchdata();
					}
				});
			}
		}

	
}
function typoneadddata(){
	  $('#typdlg').dialog('open');
}
function typtwoadddata(){
	$("#typs").combobox({
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
		  onLoadSuccess: function(){
					 $('#typs').next('.combo').find('input').focus(function (){
				            $('#typs').combobox('clear');
				            
				     });
					 
			     }
	 });
	  $('#typdlg2').dialog('open');
}
function staadddata(){
	  $('#stadlg').dialog('open');
}

function groupadddata(){
	  $('#grouplg').dialog('open');
}

function closeDialog(){
	$('#zths').combobox('clear');
	$('#guzhinames').combobox('clear');
	$('#zgstatus').combobox('clear');
	$('#zgbank').combobox('clear');
	$('#zttypevalue').combobox('clear');
	$('#zttypevalue2').combobox('clear');
	$('#zths_u').combobox('clear');
	$('#guzhinames_u').combobox('clear');
	$('#zgstatus_u').combobox('clear');
	$('#zgbank_u').combobox('clear');
	$('#m_pro_cal').combobox('clear');
	$('#zttypevalue_u').combobox('clear');
	$('#zttypevalue2_u').combobox('clear');
	$('#typ').combobox('clear');
	$("#sta").textbox('clear');
	$("#ont").textbox('clear');
	$("#sent").textbox('clear');
	$('#dlg').dialog('close');
	$('#cdlg').dialog('close');
	$('#stadlg').dialog('close');
	$('#grouplg').dialog('close');
	$('#typdlg').dialog('close');
	$('#typdlg2').dialog('close');
	$('#stad').dialog('close');
	$('#group').dialog('close');
	$('#typupda').dialog('close');
	$("#typup").textbox('clear');
	$("#typupone").textbox('clear');
}

</script>
<body>
	<div id="tabsidk"  class="easyui-tabs" style="">
	 <div title="账套信息" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<div>
				    <span style="margin-left: 15px;">账套名称:</span>
						<input class="easyui-combobox" name="zt_logo" id="zth"
						>
					<span style="margin-left: 15px;">估值人员:</span> 
						<input class="easyui-combobox" name="guzhi_name"
						id="guzhiname"> 
					<span style="margin-left: 15px;">一级分类:</span>
						<input class="easyui-combobox" name="ziguan_logo" id="fristtype">
					<span style="margin-left: 15px;">二级分类:</span>
						<input class="easyui-combobox" name="ziguan_logo" id="secondtype" style="width:120px">
						 	</div><div style="margin-top:10px;">
					<span style="margin-left: 15px;">是否O32:</span>
						
					<span> 
						<select id="s_is_o32" class="easyui-combobox" name="is_o32" style="width: 120px;">
							<option value="">请选择</option>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</span>
			
			
					<span style="margin-left: 15px;">投资类型:</span>
					<span> 
						<select id="s_type" class="easyui-combobox" name="type" style="width: 180px;">
							<option value="">请选择</option>
							<option value="1">证券类</option>
							<option value="0">非证券类</option>
						</select>
					</span>
					<span style="margin-left: 15px;">估值频率:</span>
					<span> 
						<select id="s_frequency" class="easyui-combobox" name="type" style="width: 140px;">
							<option value="">请选择</option>
							<option value="0">T+0</option>
							<option value="1">T+1</option>
							<option value="w">周</option>
							<option value="m">月</option>
							<option value="n">不定期</option>
						</select>
					</span>
					<span style="margin-left: 15px;">管理类型:</span>
					<span> 
						<select id="s_management" class="easyui-combobox" name="management" style="width: 120px;">
							<option value="">请选择</option>
							<option value="0">主动管理</option>
							<option value="1">被动管理</option>
						</select>
					</span>
					
					</div>
						<div style="margin-top:10px;">
					<span style="margin-left: 15px;">清算模式:</span>
					<span> 
						<select id="s_liq_mode" class="easyui-combobox" name="liq_mode" style="width: 120px;">
							<option value="">请选择</option>
							<option value="0">托管行清算</option>
							<option value="1">券商清算</option>
						</select>
					</span>
					<span style="margin-left: 37px;">状态:</span>
					<span> 
						<select id="s_statues" class="easyui-combobox" name="s_statues" style="width: 120px;">
							<option value="">请选择</option>
							<option value="1">运作中</option>
							<option value="138">待二次清盘</option>
							<option value="2">已清盘</option>
							<option value="3">已关闭</option>
							<option value="4">暂停中</option>
							<option value="5">未启用</option>
							<option value="6">测试账</option>
						</select>
					</span>
		<!-- 		</div>					<div style="margin-top:10px; margin-left: 15px; "> -->
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editdata()">修改</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="opendialog()">新增</a> 
		      </div>
			</div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							<th data-options="field:'ck',checkbox:true"></th>
							 <th field="top_classify" data-options="hidden:true"></th>
							 <th field="sub_classify" data-options="hidden:true"></th>
							 <th field="status" data-options="hidden:true"></th>
							 <th field="bank" data-options="hidden:true"></th>
							<th field="account_id" width="100px">账套号</th>
						   <th field="account_name" width="225px">账套名称</th>
							<th field="chn_top" width="100px">一级分类</th>
							<th field="chn_sub" width="150px">二级分类</th>
							<th field="chn_sta" width="100px">状态</th>
							<th field="is_o32" width="80px">是否O32</th>
							<th field="type" width="80px">投资类型</th>
							<th field="frequency" width="80px">估值频率</th>
							<th field="management" width="80px">管理类型</th>
							<th field="liq_mode" width="80px">清算模式</th>
							<th field="pro_cal" width="80px">业绩报酬</th>
							<th field="chn_bk" width="150px">托管行</th>
							<th field="username" width="150px">估值人员</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	 <div title="分类配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			    <span style="margin-left:20px;width: 250px ">分类:</span> <span> <input
				type="text" class="easyui-combobox" id="typ" name="typ" />
				</span>
				<span style="color: red;">*(一级分类必选)</span>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="typsearchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="typoneadddata()">新增一级分类</a> 
			      <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="typtwoadddata()">新增二级分类</a>
			      <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="typeditdata()">修改</a> 
			     <!--  <a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="typremovedata()">删除</a> -->
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="dgpz"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<th data-options="field:'kk',checkbox:true"></th>
								<th data-options="field:'ck',checkbox:true,hidden:true"></th>
								<th field="dc" width="100" >一级分类代码</th>
								<th field="fi" width="100" >一级分类</th>
								<th field="dd" width="100" >二级分类代码</th>
								<th field="ty" width="100" >二级分类</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>
		 <div title="状态配置" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="stasearchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="staadddata()">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="staeditdata()">修改</a>
			  <!--   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="staremovedata()">删除</a>  --> 
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="dgsta"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="value" width="100" >代码</th>
								<th field="text" width="100" >类型</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>
		
		 <div title="配置估值组" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="groupsearchdata()">查询</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="groupadddata()">新增</a> 
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="groupeditdata()">修改</a>
			  <!--   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="staremovedata()">删除</a>  --> 
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="guzhi_group"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="id" width="100" >序号</th>
								<th field="area" width="100" >地区</th>
								<th field="group_code" width="100" >组别代码</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>
		 
	</div>
	<div id="dlg" class="easyui-dialog" closed="true" title="添加账套配置" style="width: 400px; height: 500px; padding: 10px;"
				data-options="iconCls: 'icon-save',buttons: '#dlg-buttons'">
		<span style="margin-left: 20px;">帐套名称:</span> 
		<span> 
			<input style="width: 150px !important;" text" class="easyui-combobox" id="zths" name="zths" />
		</span> 
		<br /> <br /> 
		<span style="margin-left: 20px;">估值人员:</span> 
		<span>
			<input type="text" class="easyui-combobox" id="guzhinames" name="guzhinames" />
		</span> 
		<br /> <br /> 
		<span style="margin-left: 20px;">一级分类:</span> 
		<span>
			<input type="text" class="easyui-combobox" id="zttypevalue" name="zttypevalue" />
		</span> 
		<br /> <br /> 
		<span style="margin-left: 20px;">二级分类:</span> 
		<span>
			<input type="text" class="easyui-combobox" id="zttypevalue2" name="zttypevalue2" />
		</span> 
		<br /> <br /> 
		<span style="margin-left: 45px;">状态:</span> 
		<span>
			<input type="text" class="easyui-combobox" id="zgstatus" name="zgtatus" />
		</span> 
		<br /> <br /> 
		<span style="margin-left: 34px;">托管行:</span> 
		<span>
			<input type="text" class="easyui-combobox" id="zgbank" name="zgbank" />
		</span> 
		<br /> <br /> 
		<span style="margin-left: 22px;">是否O32:</span>
		<span> 
			<select id="a_is_o32" class="easyui-combobox" name="is_o32" style="width: 250px;">
				<option value="">请选择</option>
				<option value="1">是</option>
				<option value="0">否</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">投资类型:</span>
		<span> 
			<select id="a_type" class="easyui-combobox" name="type" style="width: 250px;">
				<option value="">请选择</option>
				<option value="1">证券类</option>
				<option value="0">非证券类</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">估值频率:</span>
		<span> 
			<select id="a_frequency" class="easyui-combobox" name="type" style="width: 250px;">
				<option value="">请选择</option>
				<option value="0">T+0</option>
				<option value="1">T+1</option>
				<option value="w">周</option>
				<option value="m">月</option>
				<option value="n">不定期</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">管理类型:</span>
		<span> 
			<select id="a_management" class="easyui-combobox" name="management" style="width: 250px;">
				<option value="">请选择</option>
				<option value="0">主动管理</option>
				<option value="1">被动管理</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">清算模式:</span>
		<span> 
			<select id="a_liq_mode" class="easyui-combobox" name="liq_mode" style="width: 250px;">
				<option value="">请选择</option>
				<option value="0">托管行清算</option>
				<option value="1">券商清算</option>
			</select>
		</span>
		
		<br /> <br /> 
		<span style="margin-left: 24px;">业绩报酬:</span>
		<span> 
			<select id="a_pro_cal" class="easyui-combobox" name="a_pro_cal" style="width: 250px;">
				<option value="0">0_TA计提</option>
				<option value="1">1_估值计提</option>
			</select>
		</span>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addAcountMapping()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeDialog()">取消</a>
	</div>
	<div id="typdlg" class="easyui-dialog" closed="true" title="添加一级分类配置"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#typdlg-buttons'">
		<span style="margin-left:20px;  margin-top:50px;">一级分类:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="ont" name="ont" /> </span> <br /> <br />
	</div>
	<div id="typdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="addAcountOnt()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>
	<div id="typdlg2" class="easyui-dialog" closed="true" title="添加二级分类配置"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#typdlg2-buttons'">
		<span style="margin-left:20px;width: 250px ">一级分类:</span> <span> <input
				type="text" class="easyui-combobox" id="typs" name="typs" />
				</span><br /> <br />
		<span style="margin-left:20px; ">二级分类:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="sent" name="sentt" /> </span> <br /> <br />
	</div>
	<div id="typdlg2-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="addAcountSent()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>
	<div id="stadlg" class="easyui-dialog" closed="true" title="添加状态配置"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#stadlg-buttons'">
		<span style="margin-left:20px; ">状态:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="sta" name="sta" /> </span> <br /> <br />
	</div>
	
	<div id="grouplg" class="easyui-dialog" closed="true" title="添加估值组"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#grouplg-buttons'">
		<span style="margin-left:20px; ">地区:</span> <span> 
		<select id="area" class="easyui-combobox">
				   <option value="bj">北京</option>
				   <option value="sh">上海</option>
				 </select><br /><br />
	   	<span style="margin-left:20px; ">代码:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="group_code" name="group_code" />
			 </span>  <br /> <br />
	</div>
	
	<div id="stadlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="staaddAcount()">保存</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>

	<div id="grouplg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="groupaddAcount()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>

	<div id="cdlg" class="easyui-dialog" closed="true" title="修改账套配置"
			style="width: 400px; height: 500px; padding: 10px;"
			data-options="iconCls: 'icon-save',buttons: '#cdlg-buttons'">
		<span style="margin-left:20px; ">帐套名称:</span> 
		<span> 
			<input style="width: 150px !important; type="text" class="easyui-combobox" id="zths_u" name="zths_u" /> 
		</span> 
		<br /> <br />
		<span style="margin-left:20px;">估值人员:</span> 
		<span> 
			<input type="text" class="easyui-combobox" id="guzhinames_u" name="guzhinames" />
		</span> 
		<br /> <br />	
		<span style="margin-left:20px;">一级分类:</span> 
		<span> 
			<input type="text" class="easyui-combobox" id="zttypevalue_u" name="zttypevalue" />
		</span> 
		<br /> <br />
		<span style="margin-left:20px;width: 250px ">二级分类:</span> 
		<span> 
			<input type="text" class="easyui-combobox" id="zttypevalue2_u" name="zttypevalue2" />
		</span> 
		<br /> <br />
		<span style="margin-left:45px;">状态:</span> 
		<span> 
			<input type="text" class="easyui-combobox" id="zgstatus_u" name="zgtatus" />
		</span> 
		<br /> <br />
		<span style="margin-left:34px;">托管行:</span> 
		<span> 
			<input type="text" class="easyui-combobox" id="zgbank_u" name="zgbank" />
		</span> 
		<br /> <br />
		<span style="margin-left: 22px;">是否O32:</span>
		<span> 
			<select id="m_is_o32" class="easyui-combobox" name="is_o32" style="width: 250px;">
				<option value="">请选择</option>
				<option value="1">是</option>
				<option value="0">否</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">投资类型:</span>
		<span> 
			<select id="m_type" class="easyui-combobox" name="type" style="width: 250px;">
				<option value="">请选择</option>
				<option value="1">证券类</option>
				<option value="0">非证券类</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">估值频率:</span>
		<span> 
			<select id="m_frequency" class="easyui-combobox" name="type" style="width: 250px;">
				<option value="">请选择</option>
				<option value="0">T+0</option>
				<option value="1">T+1</option>
				<option value="w">周</option>
				<option value="m">月</option>
				<option value="n">不定期</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">管理类型:</span>
		<span> 
			<select id="m_management" class="easyui-combobox" name="management" style="width: 250px;">
				<option value="">请选择</option>
				<option value="0">主动管理</option>
				<option value="1">被动管理</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">清算模式:</span>
		<span> 
			<select id="m_liq_mode" class="easyui-combobox" name="liq_mode" style="width: 250px;">
				<option value="">请选择</option>
				<option value="0">托管行清算</option>
				<option value="1">券商清算</option>
			</select>
		</span>
		<br /> <br /> 
		<span style="margin-left: 24px;">业绩报酬:</span>
		<span> 
			<select id="m_pro_cal" class="easyui-combobox" name="m_pro_cal" style="width: 250px;">
				<option value="0">TA计提</option>
				<option value="1">估值计提</option>
			</select>
		</span>
	</div>
	<div id="cdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveAcountMapping()">保存</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>
	<div id="stad" class="easyui-dialog" closed="true" title="修改状态配置"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#status-buttons'">
		<span style="margin-left:20px; ">状态:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="stads" name="stads" /> </span> <br /> <br />
	</div>
		<div id="status-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="updatestaAcount()">保存</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>

	
	<div id="group" class="easyui-dialog" closed="true" title="修改组别代码"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#stad-buttons'">
				<span style="margin-left:20px; ">地区:</span> <span> 
		<select id="area" class="easyui-combobox">
				   <option value="bj">北京</option>
				   <option value="sh">上海</option>
				 </select><br /><br />
	   	<span style="margin-left:20px; ">代码:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="group_code" name="group_code" />
			 </span>  <br /> <br />
	</div>
	<div id="stad-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="updatestaAcount()">保存1</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>
	
	<div id="typupda" class="easyui-dialog" closed="true" title="修改分类配置"
		style="width: 550px; height: 300px; padding: 10px;"
		data-options="iconCls: 'icon-save',buttons: '#typupda-buttons'">
		<span style="margin-left:20px; ">一级分类:</span> <span> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="typupone" name="typupone" /> </span> <br /> <br />
		<span style="margin-left:20px; " id='zjflspan1'>二级分类:</span>
		<span id='zjflspan2'> <input
			style="width: 150px !important;
			type="text" class="easyui-textbox" id="typup" name="typup" /> </span> <br /> <br />
	</div>
	<div id="typupda-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="updatetypAcount()">保存</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="removedata()">删除</a>  -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeDialog()">取消</a>
	</div>

</body>



