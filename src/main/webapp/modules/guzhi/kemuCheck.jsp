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

//新增tab页
function addNewtab(url,name){
	var new_panel=top.Ext.getCmp(name);
	var tabs = top.tabs;
	if(new_panel){
		tabs.remove(new_panel);
	}
	var t = tabs.getActiveTab();   
    if(t.closable){     
    	if('inittab'==t.id){
    		tabs.remove(t);//删除标签     
    	}
    }      
    var flag = true;
    for(var qp=0;qp<tabs.items.length;qp++){
        var code = tabs.items.get(qp).getItemId();
        if(name==code){
        	flag = false;
        }
    }
    if(flag){
    	tabs.add({     
	        id: name,     
	        title:name,   
	        frame:true, 
	        html:'<iframe id="iframe_'+name+'" src='+url+' frameborder="0" width="100%" scrolling="yes" height="100%"></iframe>' ,
	        closable: true
	    }) ;     
    }
    tabs.setActiveTab(name) ;//当id为"id"的Tab标签显示(变为活动标签)
    tabs.setHeight( $(top.window).height()-83);
    status=0;
    allwidth=switchSysBar();
    tabs.setWidth(allwidth);
    tabs.show();
}


function myformatter1002(value,row,index){
	 if(typeof(row.wbkmh)!='undefined'&&row.wbkmh=='1002'){
		 var mydate = $("#wbdate").datebox("getValue");
	     var wbzth= $("#wbzth").combobox("getValue");
		 
		 var str="<a href=\"javascript:addNewtab('/guzhidz/tgGthCheck?wbzth="+wbzth+"&mydate="+mydate+"','1.5 托管柜台核对')\">"+value+"</a>";
		 return str;
	 }else{
		return value;
	 } 
       
}

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
		 $("#dgbatch").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-160
		 });
		 $("#dghist").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-120
		 });
		 
		 $("#t_dgbatch").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-160
		 });
		 $("#dg_noconf").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-160
		 });
		
		$("#wbzthbatch1").combobox({
	          valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
	          method:'post',
			//  multiple:true,
			//  multiline:true,
			  width:400,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				 //$('#wbzthbatch1').next('.combo').find('input').focus(function (){
			     //       $('#wbzthbatch1').combobox('clear');
			     // });
		     },
		     selectOnNavigation:$(this).is(':checked')
	      });
		
		$("#level").next(".combo").hide();
		
		$("#t_wbzthbatch1").combobox({
	          valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
	          method:'post',
			 // multiple:true,
			 // multiline:true,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				 //$('#wbzthbatch1').next('.combo').find('input').focus(function (){
			     //       $('#wbzthbatch1').combobox('clear');
			     // });
		     },
		     selectOnNavigation:$(this).is(':checked')
	      });
		
        $("#wbzth").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
             method:'post',
			  multiple:false,
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				 $('#wbzth').next('.combo').find('input').focus(function (){
			            $('#wbzth').combobox('clear');
			     });
		     }
	  });
      $("#wbzthbatch").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
              method:'post',
              multiple:true,
			  multiline:true,
			  width:400,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				//		 $('#wbzthbatch').next('.combo').find('input').focus(function (){
				//	            $('#wbzthbatch').combobox('clear');
					  //   });
			 },
			 selectOnNavigation:$(this).is(':checked')
	  });  
      
      
      $("#t_wbzthbatch").combobox({
          valueField: 'value',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
          method:'post',
          multiple:true,
		  multiline:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			//		 $('#wbzthbatch').next('.combo').find('input').focus(function (){
			//	            $('#wbzthbatch').combobox('clear');
				  //   });
		 },
		 selectOnNavigation:$(this).is(':checked')
  });  
      
      $("#wbzthUserHist").combobox({
          valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
          method:'post',
		  multiple:true,
		  multiline:true,
		  width:350,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#wbzthUserHist').next('.combo').find('input').focus(function (){
		            $('#wbzthUserHist').combobox('clear');
		     });
	     }
      });
	
    $("#wbzthHist").combobox({
          valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
          method:'post',
		  multiple:true,
		  multiline:true,
		  width:350,
		  height:110,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#wbzthHist').next('.combo').find('input').focus(function (){
		            $('#wbzthHist').combobox('clear');
		     });
	     }
  });
      
    $("#chawbzthHist").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=01',
          method:'post',
		  multiple:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#chawbzthHist').next('.combo').find('input').focus(function (){
		            $('#chawbzthHist').combobox('clear');
		     });
	     }
    });
 
   $("#jjmc_no1").combobox({
	   valueField: 'value',
		  textField: 'text',
		  mode:'local',
		 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=t_fund_info@zhglpt&code=fund_code&name=fund_name&option= where fund_status in(8,9) order by fund_code desc',
	    method:'post',
		  multiple:false,
		  width:250,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
	   onLoadSuccess:function(){
			 $('#jjmc_no1').next('.combo').find('input').focus(function (){
			            $('jjmc_no1').combobox('clear');
			 });
			 
	   },
	   onChange:function(n,o){
	   // onHidePanel:function(){
	   $('#wbkmh_no1').combobox('reload',"<%=cp%>/guzhidz/getComboBoxSource?tbname=gzb_kmmapping&code=tg_kmh||'-'||id&name=wb_kmh&option= where accountmapping_id='"+n+"' order by wb_kmh  ");
	   }
	    
	
   });
    $("#wbkmh_no1").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		// url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=gzb_kmmapping&code=tg_kmh&name=wb_kmh&option= where accountmapping_id= 270 order by wb_kmh',
          method:'post',
		  multiple:false,
		  width:250,
		  onChange:function(n,o){
			   
			   $('#tgkmh_no1').textbox('setValue', n.split("-")[0]);
			   $('#ider').val( n.split("-")[1]);
			
			   }
	
    });
 

});

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 function searchdata(){
	 var isbd='';
	 var vales='';
 	if($("#wbzth").combobox('getValue')==""){
 		alert("请选择基金名称");
 		return false;
 	}else if($("#wbdate").datebox("getValue")==""){
 		alert("请选择日期");
 		return false;
 	}else{
 		
 		if($("#isbd").prop("checked")){
 			isbd ="&isbd=1";
 			vales=1;
        }else{
        	isbd="&isbd=0";
 			vales=0;
        }
        	
      var params="wbzth="+$("#wbzth").combobox('getValue')+"&wbztmc="+$("#wbzth").combobox('getText')+
                      "&wbdate="+$("#wbdate").datebox('getValue')+"&level="+$("#level").combobox('getValue')+"&type=check"+isbd;
      $('#dg').datagrid({method:'post',
			    	     url:"guzhidz/getKMDZInfoNew",
			    	     queryParams:{wbzth:$("#wbzth").combobox('getValue'),
					               	  wbztmc:$("#wbzth").combobox('getText'),
					               	  wbdate:$("#wbdate").datebox('getValue'),
					               	  level:$("#level").combobox('getValue'),type:'check',isbd:vales}
                        }).datagrid('clientPaging'); 
      
 	}
 }
 //批量
  function searchdatabatch(){
	 
	 
	 var guzhiday=$("#guzhiday").combobox('getValue');
	 var fundtus=$("#fundtus").combobox('getValue');
	 
	 
    if($("#wbdatebatch").datebox("getValue")==""){
 		alert("请选择日期");
 		return false;
 	}else{
      $('#dgbatch').datagrid({method:'post',
    	                      url:"guzhidz/getBatchCheckInfo", 
    	                      queryParams:{wbzth:$("#wbzthbatch").combobox('getValues'),
		    	                    	   wbdate:$("#wbdatebatch").datebox('getValue'),
		    	                    	   userinfo:$("#wbzthbatch1").combobox('getValue'),
		    	                    	   iseql:$("#iseql").combobox('getValue'),
		    	               				guzhiday:guzhiday    ,
		    	               				fundtus:fundtus
    	                      },
   	                    	   onLoadSuccess:function(data){
   				            	     if(data.rows.length>0){

   					            	     if(typeof(data.rows[0].fail)!="undefined"){
   		 			            	       // $("#t_notsumnum").html("不一致总数:<span style='color:red;'>"+data.rows[0].notsumnum+"</span>");
   		 			            	       
   		 			            	       var infos="";
   		 			            	       for(i=0;i<data.rows.length;i++){
   		 			            	    	infos=infos+  '【'+data.rows[i].fund_name+'】';
   		 			            	       }
   					            	    	 $.messager.alert('提示',infos+'没有进行科目对应关系初始化，请先在"1.1账套基本信息"进行初始化再查询核对');}
   					            	     
   				            	     }else{
   				            	    	 $("#notsumnum").html("");
   				            	     }
   				            		
   				               }}); 
      
 	}
 }
 
  function t_searchdatabatch(){
	    if($("#t_wbdatebatch").val()==""){
	 		alert("请选择日期");
	 		return false;
	 	}else{
	      $('#t_dgbatch').datagrid({method:'post',
	    	                      url:"guzhidz/getBatchCheckInfoBT", 
	    	                      queryParams:{wbzth:$("#wbzthbatch").combobox('getValues'),
			    	                    	   wbdate:$("#t_wbdatebatch").val(),
			    	                    	   userinfo:$("#t_wbzthbatch1").combobox('getValues'),
			    	                    	   iseql:$("#t_iseql").combobox('getValue')},
	   	                    	   onLoadSuccess:function(data){
	   				            	     if(data.rows.length>0){
	   					            	     if(typeof(data.rows[0].notsumnum)!="undefined"){
	   		 			            	        $("#t_notsumnum").html("不一致总数:<span style='color:red;'>"+data.rows[0].notsumnum+"</span>");
	   					            	     }
	   				            	     }else{
	   				            	    	 $("#t_notsumnum").html("");
	   				            	     }
	   				            		
	   				               }}).datagrid('clientPaging'); 
	      
	 	}
	 }
 
 function queryZTKMInfo(id){
	 $("#tabsidk").tabs('select', "账套科目核对");
	 var datebatch = $("#wbdatebatch").datebox('getValue');//日期
	// var wbzthbatch = $("#wbzthbatch").combobox('getValue')//基金号
 
	 $("#wbdate").datebox('setValue',datebatch);
	 $("#wbzth").combobox('setValue',id);
	 $("#level").combobox('setValue',5);
	 
	 searchdata();//根据查询条件查询数据
	 
 }
 
 ///保存
 
 function saveHist(){
	    if($("#wbdateHist").datebox("getValue")==""){
	 		alert("请选择日期");
	 		return false;
	 	}else{
	      $.ajax({ 
		        type: "POST", 
		        url: "guzhidz/saveCheckHist", 
		        data: {wbzth:$("#wbzthHist").combobox('getValues'),gzry:$("#wbzthUserHist").combobox('getValues'),wbdate:$("#wbdateHist").datebox('getValue'),
		        	   wbztmc:$("#wbzthHist").combobox('getText'),level:5,wbdate_end:$("#wbdateHist_end").datebox('getValue'),
		        	   type:'check'}, 
		        dataType: "json", 
		        success: function(data) {                
		           if(data.msg=="success"){
		        	   alert("操作成功");
		           }else{ 
		        	   alert("操作失败");
		           }
		        }, 
		        error: function() { 
		           alert("系统异常，操作失败");     
		        } 
		    });
	 	}
 }
 //查询历史记录
 function queryHist(){
	    if($("#chawbdateHist").datebox("getValue")=="" || $("#chawbzthHist").combobox("getValue")==""){
	 		alert("请选择日期和基金名称");
	 		return false;
	 	}else{
	 		  var params="wbzth="+$("#chawbzthHist").combobox('getValue')+
                        "&wbdate="+$("#chawbdateHist").datebox('getValue');
               $('#dghist').datagrid({method:'get',url:"guzhidz/queryCheckHist?"+params}).datagrid('clientPaging'); 
	 	}
 }
 
 //查询不核对配置
 function queryNoconf(){
	  $('wbkmh_no1').combobox('reload','<%=cp%>/guzhidz/getComboBoxSource?tbname=gzb_kmmapping&code=tg_kmh&name=wb_kmh&option= where accountmapping_id='+270+' order by wb_kmh  ');
	
	 		  var params="fundcode="+$("#jjmc_no").combobox('getValue');
                       
               $('#dg_noconf').datagrid({method:'get',url:"guzhidz/queryNoconf?op=s&"+params}).datagrid('clientPaging'); 

 }
 
 function formateyyy(value, row, index) {
     if (row != null) {
    	 if(isNumber(value)){
    		 if(row.wbkmh=='901'||row.wbkmh=='904'||row.wbkmh.indexOf('901_')!=-1||row.wbkmh.indexOf('904_')!=-1)
    		 	return (parseFloat(value).toFixed(4) + '');
    		 else
    			 return (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
    	 }
        
    	 else
    		 return value;
   }
   }

 function isNumber(val){

	    var regPos = /^\d+(\.\d+)?$/; //非负浮点数
	    var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
	    if(regPos.test(val) || regNeg.test(val)){
	        return true;
	    }else{
	        return false;
	    }

	}

 function moNoconf(op){
	
	// $("#tgkmh_no1").combobox('readonly','true');	
		
	 if("a"==op){
		 $("#wbkmh_no1").combobox('readonly',false);	
		 $("#jjmc_no1").combobox('readonly',false);
		
	 }
	 
		 
	 if("u"==op){
		var row = $('#dg_noconf').datagrid('getSelected');
		 if (row){
			 $("#jjmc_no1").combobox('readonly','true');	
			 $("#ider").val(row.ider);
			 $("#wbkmh_no1").textbox('setValue',row.wbkmh_no);
			 
			 $("#tgkmh_no1").textbox('setValue',row.tgkmh_no);
			 $("#cbhd_no1").combobox('select',row.cbhd);
			 $("#szhd_no1").combobox('select',row.szhd);			 
			 $("#jjmc_no1").combobox('select',row.fundcode);
				
		}
		else{
			$.messager.alert('提示','请先选中一行！');
			return ;

		}
		
	 }
	 $("#op").val(op);
	 $('#yhdzhds').dialog('open');

}
 function closeDialog(){
		$("#tgkmh_no1").textbox('clear');
	 	$("#wbkmh_no1").combobox('clear');
	 	$("#jjmc_no1").combobox('clear');
	 	$("#jjmc_no1").combobox('readonly',false);
	 	
	   $('#yhdzhds').dialog('close');
	 
}
 function saveInfonew(){
		var ider=  $("#ider").val();
		var op=$("#op").val();
		var wbkmh=$("#wbkmh_no1").combobox('getValue');
		var jjmc=$("#jjmc_no1").combobox('getValue');
		var cbhd=$("#cbhd_no1").combobox('getValue'); 
		var szhd=$("#szhd_no1").combobox('getValue'); 
		
		if(wbkmh==''||jjmc==''){
			$.messager.alert('提示','基金名称不能为空！科目号不能为空');
			return ;
		}
		$.ajax({
			url:'<%=cp%>/guzhidz/queryNoconf',
			type:'post',
			data:{
				op:op,ider:ider,cbhd:cbhd,szhd:szhd
			},
			dataType: "json",
			success: function(data){
				if(data[0].msg=="success"){  
					alert("保存成功");
					closeDialog();
					queryNoconf();
					
					
				}else{
					alert("保存失败");
				}
				
			}
		});
 }
 </script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="账套科目核对" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> 
			<input class="easyui-combobox"
						name="wbzth" id="wbzth"
		    >
		   <span style="color: red;">*</span>
		   <span style="margin-left: 15px;">日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		   <span style="margin-left: 20px; display: none;">层级</span>
		   		   <select id="level" name="level" class="easyui-combobox" 
		                               style="width: 150px;"  editable="false">
		                    <option value="5">--请选择--</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
		   </select> 			
		   <input type="checkbox" name="isbd" id="isbd" checked="checked"/>
		  	<span style="font-size:8px;">只显示差额项</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询/核对</a>
		</div>
		
		
		<div style="margin-top: 10px;">
			<table id="dg" 
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              rowStyler: function(index,row){
				      	                  var str='';
										  if(typeof(row.iscbeql)!='undefined' && (row.iscbeql+'').indexOf('span')==-1){
										     str='background-color:#F6BCBC;';
										  }
										  if(typeof(row.iseql)!='undefined' && (row.iseql+'').indexOf('span')==-1){
										     str='background-color:#F6BCBC;';
										  }
										 
										  if(typeof(row.wbkmh)!='undefined' && row.wbkmh=='831'){
										     str='';
										  }
										  if(typeof(row.wbkmh)!='undefined' && row.wbkmh=='832'){
										     str='';
										  }
										   if(typeof(row.wbkmh)!='undefined' && row.wbkmh=='841' 
										       && typeof(row.iseql)!='undefined' && (row.iseql+'').indexOf('span')!=-1){
										      str='';
										  }
										  return  str;
							 },
				            singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
                        <th field="accountmappingid" data-options="hidden:true"></th>
                        <th field="wbztmc" width="180px" 
                        data-options="formatter:myformatter1002">基金名称</th>
						<th field="wbkmh" width="80px">外包科目号</th>
                        <th field="wbkmmc" width="170px">外包科目名称</th>
						<th field="tgztmc" width="200px" data-options="hidden:true">托管基金名称</th>
						<th field="tgkmh" width="150px">托管科目号</th>
                        <th field="tgkmmc" width="150px">托管科目名称</th>
						<th field="wbcb" width="100px" data-options="align:'right',formatter:formateyyy">外包成本</th>
						<th field="tgcb" width="100px" data-options="align:'right',formatter:formateyyy">托管成本</th>
						<th field="iscbeql" width="100px" data-options="align:'center',formatter:formateyyy">差值</th>
						<th field="wbsz" width="100px" data-options="align:'right',formatter:formateyyy">外包市值</th>
						<th field="tgsz" width="100px" data-options="align:'right',formatter:formateyyy">托管市值</th>
						<th field="iseql" width="100px" data-options="align:'center',formatter:formateyyy">差值</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
 
	<div title="批量核对" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> 
			<input class="easyui-combobox" name="wbzthbatch" id="wbzthbatch" >
			<span>是否匹配:</span>
			<span>
				<select id="iseql" class="easyui-combobox" name="iseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="eql">完全匹配</option>
					<option value="noteql">不完全匹配</option>
				</select>
			 </span>  估值时效（平台维护）<select id="guzhiday" class="easyui-combobox" name="guzhiday" style="width: 80px;">
					<option value="9">全部</option>
					<option value="0">T+0</option>
					<option value="1">T+1</option>
					<option value="2">T+2</option>
				</select>
				</span>基金状态<select id="fundtus" class="easyui-combobox" name="fundtus" style="width: 120px;">
					<option value="0">全部</option>
					<option value="8">基金成立</option>
					<option value="9">基金清盘</option>

				</select>
			 <br />
		     <span style="">估值人员:</span> 
		     <input class="easyui-combobox" name="wbzthbatch1" id="wbzthbatch1" >
		    <span style="margin-left: 22px;">日期:</span>  
		   <span><input id="wbdatebatch" name="wbdatebatch" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdatabatch()">查询</a>
		    <span id="notsumnum" style="font-size:20px;float: right;"></span>
		     
		</div>
		<div style="margin-top: 10px;">
			<table id="dgbatch" 
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>       
					    <th field="notsumnum" width="150" data-options="hidden:true"></th>
                        <th field="wbzth" width="50px">外包账套号</th>
                        <th field="wbztmc" width="180px">外包账套名称</th>
                        <th field="wbuser" width="80px">外包估值人员</th>
						<th field="tgzth" width="80px">托管账套号</th>
                        <th field="tgztmc" width="180px">托管账套名称</th>
                        <th field="tguser" width="80px">托管估值人员</th>
						<th field="eqlnum" width="70px">科目匹配数</th>
						<th field="noteqlnum" width="80px">科目不匹配数</th>
						<th field="myquery" width="40px">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="保存核对记录" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> 
			<input class="easyui-combobox" name="wbzthHist" id="wbzthHist" >
<!-- 			<span style="color: red;">*</span>
 -->			<br></br>
		    <span>估值人员:</span> 
			   <input class="easyui-combobox" name="wbzthUserHist" id="wbzthUserHist" >
			<br></br>
		   <span>开始日期:</span>  	
		   <span><input id="wbdateHist" name="wbdateHist" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		    <span>结束日期:</span>  	
		   <span><input id="wbdateHist_end" name="wbdateHist_end" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveHist()">保存</a>
		</div>
	</div>
	
	<div title="查询核对记录" style="padding: 5px">
		 <div style="margin-top: 5px; margin-bottom: 5px;">
				<span>基金名称:</span> 
				<input class="easyui-combobox" name="chawbzthHist" id="chawbzthHist" >
				<span style="color: red;">*</span>
			    <span style="margin-left: 15px;">日期</span>  	
			    <span><input id="chawbdateHist" name="chawbdateHist" class="easyui-datebox" style="width: 150px"></input></span>
			    <span style="color: red;">*</span>
			    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="queryHist()">查询</a>
          </div>
	      <div style="margin-top: 10px;">
			<table id="dghist" 
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              rowStyler: function(index,row){
				      	                  var str='';
										  if(typeof(row.iscbeqlhist)!='undefined' && (row.iscbeqlhist+'').indexOf('span')==-1){
										     str='background-color:#F6BCBC;';
										  }
										  if(typeof(row.iseqlhist)!='undefined' && (row.iseqlhist+'').indexOf('span')==-1){
										     str='background-color:#F6BCBC;';
										  }
										  return  str;
							 },
				             singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>       
                        <th field="wbztmchist" width="180px">基金名称</th>
						<th field="wbkmhhist" width="80px">外包科目号</th>
                        <th field="wbkmmchist" width="170px">外包科目名称</th>
						<th field="tgkmhhist" width="150px">托管科目号</th>
						<th field="tgkmhhist" width="150px">托管科目名称</th>
						<th field="wbcbhist" width="100px" data-options="align:'right',formatter:myformatter">外包成本</th>
						<th field="tgcbhist" width="100px" data-options="align:'right',formatter:myformatter">托管成本</th>
						<th field="iscbeqlhist" width="100px" data-options="align:'center',formatter:myformatter">差值</th>
						<th field="wbszhist" width="100px" data-options="align:'right',formatter:myformatter">外包市值</th>
						<th field="tgszhist" width="100px" data-options="align:'right',formatter:myformatter">托管市值</th>
						<th field="iseqlhist" width="100px" data-options="align:'center',formatter:myformatter">差值</th>
					</tr>
				</thead>
			</table>
		 </div>	
	</div>
	
	
	<div title="批量核对(时间)" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> 
			<input class="easyui-combobox" name="t_wbzthbatch" id="t_wbzthbatch" >
			<span>是否匹配:</span>
			<span>
				<select id="t_iseql" class="easyui-combobox" name="t_iseql" style="width: 150px;">
					<option value="5">--请选择--</option>
					<option value="eql">完全匹配</option>
					<option value="noteql">不完全匹配</option>
				</select>
			 </span>
			 <br />
		     <span style="">估值人员:</span> 
		     <input class="easyui-combobox" name="t_wbzthbatch1" id="t_wbzthbatch1" >
		    <span style="margin-left: 22px;">日期:</span>  
		   <span><input id="t_wbdatebatch" name="t_wbdatebatch"  type="text" class="auto-kal"  data-kal="mode:'multiple'"  style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="t_searchdatabatch()">查询</a>
		    <span id="notsumnum" style="font-size:20px;float: right;"></span>
		     
		</div>
		<div style="margin-top: 10px;">
			<table id="t_dgbatch" 
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>       
					    <th field="notsumnum" width="150" data-options="hidden:true"></th>
                        <th field="wbzth" width="50px">外包账套号</th>
                        <th field="wbztmc" width="180px">外包账套名称</th>
                        <th field="wbuser" width="80px">外包估值人员</th>
						<th field="tgzth" width="80px">托管账套号</th>
                        <th field="tgztmc" width="180px">托管账套名称</th>
                        <th field="tguser" width="80px">托管估值人员</th>
						<th field="eqlnum" width="70px">科目匹配数</th>
						<th field="noteqlnum" width="80px">科目不匹配数</th>
						<th field="myquery" width="40px">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div title="配置不核对项" style="padding: 5px">
		 <div style="margin-top: 5px; margin-bottom: 5px;">
		 <span style="margin-left: 0px">不核对的项，在本系统中数值可能有误，准确数值请去对应的估值系统查询</span>
					<br><br>
				<span>基金名称:</span> 
				 <input class="easyui-combobox" name="jjmc_no" id="jjmc_no"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								 url:'<%=cp%>/guzhidz/getComboBoxSource?tbname=t_fund_info@zhglpt&code=fund_code&name=fund_name&option= where fund_status in(8,9) order by fund_code desc',
		                          method:'post',
								  multiple:false,
								  width:250,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('jjmc_no').combobox('clear');
									            
									            
									 });
							     }
					  ">
				<span style="color: red;">*</span>
			    
			<!--     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="queryHist()">查询</a> -->
			    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="queryNoconf()">查询</a>
			    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="moNoconf('a')">添加</a>
			    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="moNoconf('u')">修改</a>
          </div>
	      <div style="margin-top: 10px;">
			<table id="dg_noconf" 
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				          
				             singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>       
						<th field="fundcode" width="180px" data-options="hidden:true" >基金名称</th>
						<th field="ider" width="180px" data-options="hidden:true" >基金名称</th>
                        <th field="wbjjmc_no" width="180px">基金名称</th>
						<th field="wbkmh_no" width="80px">外包科目号</th>
                        <th field="wbkmmc_no" width="170px" data-options="hidden:true"  >外包科目名称</th>
						<th field="tgkmh_no" width="150px">托管科目号</th>
						<th field="tgkmmc_no" width="150px" data-options="hidden:true" >托管科目名称</th>
						<th field="cb_no" width="100px" data-options="align:'right',formatter:myformatter">成本</th>
						<th field="sz_no" width="100px" data-options="align:'right',formatter:myformatter">市值</th>
						 <th field="cbhd" width="170px" data-options="hidden:true"  >外包科目名称</th>
						  <th field="szhd" width="170px" data-options="hidden:true"  >外包科目名称</th>
						
					</tr>
				</thead>
			</table>
		 </div>	
	</div>
</div>


 <div id="yhdzhds" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 300px; padding: 10px;modal:true;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
						
				<span style="margin-left: 0px">基金名称:</span>
				
		<input type="text" id="ider" name="ider" style="display: none;">
		<input type="text" id="op" name="op" style="display: none;">
			 <input class="easyui-combobox" name="jjmc_no1" id="jjmc_no1"
						data-options="method:'get'"
			                      
					  ">
			<br></br>
				<span style="margin-left: 0px">外包科目号:</span>
			<span> 
			 	<input  class="easyui-combobox" id="wbkmh_no1" name="wbkmh_no1">
			</span>
			 	
			
				<span style="margin-left: 0px">托管科目号:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="tgkmh_no1" name="tgkmh_no1" readonly="readonly">
			</span>
			<br></br>
			成本：<select id="cbhd_no1" class="easyui-combobox" name="cbhd_no1" style="width: 120px;">
					<option value="0">核对</option>
					<option value="1">不核对</option>

				</select>
			市值：<select id="szhd_no1" class="easyui-combobox" name="szhd_no1" style="width: 120px;">
					<option value="0">核对</option>
					<option value="1">不核对</option>

				</select>
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>


 </body>