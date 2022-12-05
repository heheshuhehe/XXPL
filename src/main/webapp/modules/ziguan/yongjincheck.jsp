<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>佣金</title>
    <script>document.documentElement.focus();</script>
    
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>
$(function (){
		 $("#tabsidk").tabs({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-20
		 });
	 	 $("#dg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-150
	 	 });
	 	 $("#dg1").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-150
	 	 });
	 	 $("#dg2").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-150
	 	 });
	 	$('#dlgReleaseTime').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                span.trigger('click'); //触发click事件弹出月份层
                if (!tds)
                    setTimeout(function () { //延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                        tds = p.find('div.calendar-menu-month-inner td');
                        tds.click(function (e) {
                            e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                            var year = /\d{4}/.exec(span.html())[0] //得到年份
                                ,
                                month = parseInt($(this).attr('abbr'), 10); //月份
                            $('#dlgReleaseTime').datebox('hidePanel') //隐藏日期对象
                                .datebox('setValue', year + '-' + month); //设置日期的值
                        });
                    }, 0);
            },
            parser: function (s) {//配置parser，返回选择的日期
                if (!s) return new Date();
                var arr = s.split('-');
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
            },
            formatter: function (d) { return d.getFullYear() + '-' + (d.getMonth() + 1); }//配置formatter，只返回年月
        });
        var p = $('#dlgReleaseTime').datebox('panel'), //日期选择对象
            tds = false, //日期选择对象中月份
            span = p.find('span.calendar-text'); //显示月份层的触发控件
        var curr_time = new Date();
      //  $("#dlgReleaseTime").datebox("setValue", myformatter(curr_time));
      
      $("#tjlx").combobox({
    	 width:150,
   		 onSelect:function(val){
   			 if(val.value==1){
   				 $("#leixing").show();
   			     $('#firsttype').combobox('clear');
   			     $('#secondtype').combobox('clear');
   				 $("#renyuan").hide();
   			 }else if(val.value==2){
   				 $("#leixing").hide();
   			     $('#userInfo').combobox('clear');
   				 $("#renyuan").show();
   				 
   			 }
          }		
       });
     
       
       //估值人员
      $("#userInfo").combobox({
            valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/yongjin/getUserSelectVal?selectType=queryUserInfo&usertype=2',
              method:'post',
			  multiple:false,
			  width:200,
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
      
    //初始化分类
      $("#firsttype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/yongjin/getUserSelectVal?selectType=03',
		      method:'post',
			  multiple:true,
			/*   multiline:true, */
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onChange:function(val){
					    $('#secondtype').combobox('clear');
					    var rec=$("#firsttype").combobox('getValues');
					    if(rec.toString().indexOf(",")>-1){
							$("#secondtype").combobox('disable');
					    
					    }else{
					     $("#secondtype").combobox('enable');
						 $("#secondtype").combobox({ 
								  valueField: 'value',
								  textField: 'text',
								  disabled:true,
								  mode:'local',
								  url:'<%=cp%>/yongjin/getUserSelectVal?selectType=04&firsttype='+rec,
					              method:'get',
								  multiple:false,
								  width:80,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
							      onLoadSuccess: function(){
							    	  $(this).combobox('enable');
								  }		
					    });
					    }
					},
					  onLoadSuccess: function(){
								 $('#firsttype').next('.combo').find('input').focus(function (){
							            $('#firsttype').combobox('clear');
							            $('#secondtype').combobox('clear');
							     });
								 
						     }
					
		 }); 

///////////////////////////////////请求配置项/////////////////////////////////////////
 
        $("#p_type_dialog").combobox({
     	     width:150,
    		 onSelect:function(val){
    			 if(val.value==4){
    				 $("#div_zth").hide();
    				 $("#div_dkmh").show();
    				 $("#div_rank").show();
    				 $("#p_zth_dialog").combobox('clear');
    			 }else {
    				 
    				 $("#p_zth_dialog").combobox({
    					  valueField: 'value',
    					  textField: 'text',
    					  mode:'local',
    					 
    					  url:'<%=cp%>/ziguan/addZiguanConfig?type='+val.value,
    			           method:'post',
    					  multiple:true,
    					  multiline:true,
    					  width:300,
    					  height:80,
    					  filter: function(q, row){
    								var opts = $(this).combobox('options');
    								return row[opts.textField].indexOf(q) >-1;
    					  },
    					 
    			  });
    		      
    				 $("#div_dkmh").hide();
    				 $("#div_zth").show();
    				 $("#p_dkmh_dialog").val("");
    				 $("#p_dkmh_rank").val("");
    			 }
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
///////////////////////////////Ajax请求///////////////////////////////////////////////////
  
function p_searchdata(){
  	 var params="p_type="+$("#p_type").combobox('getValue');
	 $('#dgpz').datagrid({url:"<%=cp%>/ziguan/getYJConfig?"+params}).datagrid('clientPaging'); 
}
function p_adddata(){
	  $('#p_dlg_add').dialog('open');
}
function p_closeDialog(){
	 $("#p_type_dialog").combobox('clear');
	 $("#p_zth_dialog").combobox('clear');
	 $("#p_dkmh_dialog").val("");
	 $('#p_dlg_add').dialog('close');
	 $("#p_dkmh_dialogs").val("");
	 $("#p_dkmh_ranks").val("");
	  $("#p_dkmh_rank").val("");
	 $('#p_dlg_edit').dialog('close');
}
//删除数据
function p_removedata(){
	if($("input[name='ck']:checked").length==0){
		alert("请选择要删除的记录！");
		return false;
	}else{
		if(confirm("确定要删除吗？")){
			var ids="";
			$.each($("input[name='ck']:checked"), function(i, n){
				ids +=$(this).val()+",";
			});  
			if(ids!=""){
				ids = ids.substring(0,ids.length-1);
				$.ajax({
					url:'<%=cp%>/ziguan/deleteZiguanConfig',
					type : 'post',
					data : {ids : ids},
					dataType : "json",
					success : function(data) {
							alert("删除成功！");
							p_searchdata();
							Yjinitialize();
					}
				});
			}
		}
	}
}
//保存数据
function p_saveData(){
	var type = $("#p_type_dialog").combobox("getValue");
	var zth = $("#p_zth_dialog").combobox("getValues");
	var ztmc = $("#p_zth_dialog").combobox("getText");
	var dkmh = $("#p_dkmh_dialog").val();
	var rank = $("#p_dkmh_rank").val();
	if(type=="" ||type=="0"){
		alert("请填写完整");
		return false;
	}else{
		if(zth=="" && dkmh==""){
			alert("请填写完整");
			return false;
		}else{
			$.ajax({
				url:'<%=cp%>/ziguan/saveZiguanConfig',
				type:'post',
				data:{type:type,zth:zth,dkmh:dkmh,ztmc:ztmc,rank:rank},
				dataType: "json",
				success: function(data){
					if(data.msg="success"){
						alert("保存成功！");
						p_closeDialog();
						p_searchdata();
						Yjinitialize();
					}else{
						alert("保存失败！");
					}
				}
			});
	   }
	}
}
function p_editdata(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var id = $("input[name='ck']:checked").val();
		$.ajax({
			url:'<%=cp%>/ziguan/getYjPzById',
			type:'post',
			data:{id:id},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					 $('#p_dlg_edit').dialog('open');
					 var json =data.data;
					 if(json.length>0){
					 var  code_1 = json[0].code;
					 $("#p_dkmh_dialogs").textbox('setValue',code_1);
					 	 $("#p_dkmh_dialogs").textbox('disable');
					  var rankid=json[0].rankid;
					 $("#p_dkmh_ranks").textbox('setValue',rankid);
					 }
	
				}
			}
		});
	}
}
function updateAcountMapping(){
	var  type =$("input[name='type']:checked").val(); 
	var rankid = $("#p_dkmh_ranks").textbox('getValue');
	var dkmh =$("#p_dkmh_dialogs").textbox('getValue');
	var id = $("input[name='ck']:checked").val();
	$.ajax({
		url:'<%=cp%>/ziguan/updateYjPzMapping',
		type:'post',
		data:{id:id,rankid:rankid,dkmh:dkmh},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("保存成功");
				p_closeDialog();
				 Yjinitialize();
				p_searchdata();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
	
}
function ExporterExcel() {//导出Excel文件
	 	var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
		var firsttype = $("#firsttype").combobox('getValues').toString();
		var secondtype= $("#secondtype").combobox('getValue');
		var userInfo = $("#userInfo").combobox('getValue');
		var first = $("#firsttype").combobox('getText');
		var second= $("#secondtype").combobox('getText');
		var user = $("#userInfo").combobox('getText');
		var chanzt = $("input[name='chanzt']:checked").map(function () {
	        return $(this).val();
	    }).get().join('#');
	if(dlgReleaseTime==""){
		alert("请选择日期");
		return false;
	} 
	
	var t = $("#tjlx").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		}else{if(secondtype==""){
			var params="dlgReleaseTime="+dlgReleaseTime+"&firsttype="+firsttype+
	   		"&first="+first+"&second="+second+"&chanzt="+chanzt;
		}else {
			var params="dlgReleaseTime="+dlgReleaseTime+"&firsttype="+firsttype+
	   		"&secondtype="+secondtype+"&first="+first+"&second="+second+"&chanzt="+chanzt;
		}
		}
		window.location.href='<%=cp%>/yongjin/getYongJinInfoDowns?'+params;
		}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
			var params="dlgReleaseTime="+dlgReleaseTime+"&user_id="+userInfo+"&user="+user;
		}
		window.location.href='<%=cp%>/ziguan/getYongJinInfoDown?'+params;
		}
		
	}
</script>

<script type="text/javascript">

function searchdata(){
	var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
	var firsttype = $("#firsttype").combobox('getValues').toString();
	var secondtype= $("#secondtype").combobox('getValue');
	var userInfo = $("#userInfo").combobox('getValue');
	var user = $("#userInfo").combobox('getText');
	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');
	if(dlgReleaseTime==""){
		alert("请选择时间");
		return false;
	} 
	
	var t = $("#tjlx").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		} else{
			
			if(secondtype==""){
				
				$('#dg').datagrid({method:'post',
	             	url:"<%=cp%>/yongjin/getYongJincheckInfo",
					queryParams:{dlgReleaseTime:dlgReleaseTime,
						         firsttype:firsttype,chanzt:chanzt
						        } 
	             	}).datagrid('clientPaging'); 
	             	 $('#secondtype').combobox('clear');
	             	  			}else{
		 		$('#dg').datagrid({method:'post',
             	url:"<%=cp%>/yongjin/getYongJincheckInfo",
				queryParams:{dlgReleaseTime:dlgReleaseTime,
					         firsttype:firsttype,
					         secondtype:secondtype,chanzt:chanzt} 
             	}).datagrid('clientPaging'); 
             	 $('#secondtype').combobox('clear');
		}
		}
	}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
		$('#dg').datagrid({method:'post',
            url:"<%=cp%>/ziguan/getYongJinInfo",
			queryParams:{dlgReleaseTime:dlgReleaseTime,
				         user_id:userInfo,chanzt:chanzt
				        } 
            }).datagrid('clientPaging'); 
		}
	}
	
	
} 
   function myCellStyler(value,row,index){
			if (!isNaN(value)){
				return 'color:bleak;';
			}
 		}
 
</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
	   		<!--  <div title="佣金核对" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
					  <span>时间:</span>
					  <span><input id="dlgReleaseTime" name="dlgReleaseTime" class="easyui-datebox" style="width: 150px"></input></span>
					   <span style="color: red;">*</span>
					  <span>统计类型:</span>
					  <select class="easyui-combobox" name="tjlx" id="tjlx" >
					    <option value="1">按类型统计</option>
					    <option value="2">按人员统计</option>
					  </select> 
					   <span style="color: red;">*</span>
					  <span id="leixing"> 
					   <span>一级分类:</span>
					    <input class="easyui-combobox" name="firsttype" id="firsttype"> 
					      <span style="color: red;">*</span>
					   <span>二级分类:</span>
					   <input class="easyui-combobox" name="secondtype" id="secondtype">
					  </span>
					  <span id="renyuan" style="display:none;">  
					   <span>估值人员:</span>
					   <input class="easyui-combobox" name="userInfo" id="userInfo" />
					      <span style="color: red;">*</span>
					   </span>
					   <br></br>
					   		<input type="checkbox" name="chanzt" value="1"  id="chanzt" />是否显示无数据账套信息 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
					  		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> &nbsp;&nbsp;
					  		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
					   <br />
				</div>
				<div style="margin-top: 5px; ">
					<table  id="dg" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50, pageList:[50,100,200,500]
						               ">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="zth" width="100" >账套号</th>
								<th field="fsetname" width="200" >基金名称</th>
								<th field="220601fcredit_jf" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理人报酬（当月借方）</th>
								<th field="220601fcredit" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理人报酬（当月贷方）</th>
								<th field="220601fcredit_qc" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理人报酬（当月期初）</th>
								<th field="220601fcredit_qm" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理人报酬（当月期末）</th>
								<th field="22090101fcredit_jf" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理佣金（当月借方）</th>
								<th field="22090101fcredit" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理佣金（当月贷方）</th>
								<th field="22090101fcredit_qc" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理佣金（当月期初）</th>
								<th field="22090101fcredit_qm" width="150" data-options="align:'center',formatter:myformatter,styler:myCellStyler">管理佣金（当月期末）</th>
								
							</tr>
						</thead>
					</table>
				</div>
			</div>  -->
			
						<!-- 3 -->
		    <div title="佣金核对3" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
					  <span>时间:</span>
					  <span><input id="dlgReleaseTime" name="dlgReleaseTime" class="easyui-datebox" style="width: 150px"></input></span>
					   <span style="color: red;">*</span>
					  <span>统计类型:</span>
					  <select class="easyui-combobox" name="tjlx" id="tjlx" >
					    <option value="1">按类型统计</option>
					    <option value="2">按人员统计</option>
					  </select> 
					   <span style="color: red;">*</span>
					  <span id="leixing"> 
					   <span>一级分类:</span>
					    <input class="easyui-combobox" name="firsttype" id="firsttype"> 
					      <span style="color: red;">*</span>
					   <span>二级分类:</span>
					   <input class="easyui-combobox" name="secondtype" id="secondtype">
					  </span>
					  <span id="renyuan" style="display:none;">  
					   <span>估值人员:</span>
					   <input class="easyui-combobox" name="userInfo" id="userInfo" />
					      <span style="color: red;">*</span>
					   </span>
					   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> &nbsp;&nbsp;
					   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
					   <br></br>
					   		<input type="checkbox" name="chanzt" value="1"  id="chanzt" />是否显示无数据账套信息<br />
				</div>
				<div style="margin-top: 5px; ">
					<table id="dg" style="width: 777px; height: 480px"
				data-options="rownumbers:true,autoRowHeight:false,singleSelect:true,pagination:true,pageSize:500">
				<thead>
					<tr>
						<th width="180px"     rowspan="2" data-options="field:'ck',checkbox:true"></th>
                        <th field="zth"    width="100px"     rowspan="2">帐套号</th>
                        <th field="fsetname"  width="180px"   rowspan="2">帐套名称</th>
						<th  colspan="4"  width="320px"  >管理人报酬</th>
						<th  colspan="4"  width="320px"  >管理佣金</th>
					</tr>
					<tr>
					  <th field="220601fcredit" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月借方</th>
					  <th field="220601fcredit_jf" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月贷方</th>
					  <th field="220601fcredit_qc" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月期初</th>
					  <th field="220601fcredit_qm" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月期末</th>

					  <th field="22090101fcredit" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月借方</th>
					  <th field="22090101fcredit_jf" width="80px"  data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月贷方</th>
					  <th field="22090101fcredit_qc" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月期初</th>
					  <th field="22090101fcredit_qm" width="80px" data-options="align:'center',formatter:myformatter,styler:myCellStyler">当月期末</th>
					  
				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
				</thead>
			</table>
				</div>
			</div> 
								
			
			
			
		</div>
		
		
		
		
		
		
         <!-- dialog弹出框 -->
         <div id="p_dlg_add" class="easyui-dialog" closed="true" title="添加配置项"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<div style="margin-bottom: 10px;">
				<span style="margin-left: 20px">类型:</span> 
				<select class="easyui-combobox" name="p_type_dialog" id="p_type_dialog">
	                      <option value="0">--请选择--</option>
			              <option value="1">管理费不报</option>
					      <option value="2">需报业绩报酬</option>
			              <option value="3">佣金不报</option>
					      <option value="4">多科目号</option>
					      <option value="5">不参加报表统计</option>
				</select>
				<span style="color: red;">*</span>
			</div>
			 <div id="div_zth">
			  <span>账套名称:</span> 
			  <span><input class="easyui-combobox" name="p_zth_dialog" id="p_zth_dialog" data-options="editable:false"></input></span>
			  <span style="color: red;">*</span>
			 </div> 
			 <div id="div_dkmh" style="display: none;">
			      <span>多科目号:</span>
				  <span> <input class="text" name="p_dkmh_dialog" id="p_dkmh_dialog" style="width: 300px;"></input></span>
				  <span style="color: red;">*(220601,fstartbal,本期借方)</span>
			<div id="div_rank" style="display: none;"><br />
			      <span>排序号:&nbsp;</span>
				  <span> <input class="text" name="p_dkmh_rank" id="p_dkmh_rank" style="width: 100px;"></input></span>
				  <span style="color: red;">(排序号为数字)</span>
			 </div>
			 </div>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="p_saveData()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div>
         
         
         
         
		<div id="dlg" class="easyui-dialog" closed="true" title="添加账套对应关系"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>托管账套名称:</span> 
			<span> 
				<input class="easyui-combobox" name="tg_zth1"
						id="tg_zth1"
						data-options="
						                      valueField: 'value',
											  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/querySelectVal?selectType=queryTGZTH',
					                          method:'post',
											  multiple:false,
											  width:200,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}
			    ">
						 
			</span>
			<span style="margin-left: 25px">外包账套名称:</span>
			<span> 
			 	<input class="easyui-combobox" name="wb_zth1"
						id="wb_zth1"
						data-options="
						                      valueField: 'value',
											  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/querySelectVal?selectType=queryWBZTH',
					                          method:'post',
											  multiple:false,
											  width:200,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}
				">
			</span>
			<br/><br/>
			<span>交易机构:</span>
			<span style="margin-left: 23px;">
				<select id="trade_branch" class="easyui-combobox" name="trade_branch" style="width: 175px;">
					<option value="0">--请选择--</option>
					<option value="1">申万</option>
					<option value="2">宏源</option>
					<option value="3">其他</option>
				</select>
			</span>
			<span style="margin-left: 85px">柜台号:</span>
			<span> 
			 	<input type="text" class="easyui-numberbox" id="gth" name="gth">
			</span>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
		<!-- dialog弹出框 -->
         <div id="p_dlg_edit" class="easyui-dialog" closed="true" title="修改配置项"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
			 <span style="margin-left:20px;">类&nbsp;&nbsp;型:</span> <span> <input
			type="text" class="easyui-textbox" id="p_dkmh_dialogs" name="p_dkmh_dialogs" />
		</span><!-- <span style="color: red;">*(220601,fstartbal,本期借方)</span> --> <br /> <br />
		<span style="margin-left:20px;">排序号&nbsp;:</span> <span> <input
			type="text" class="easyui-textbox" id="p_dkmh_ranks" name="p_dkmh_ranks" />
		</span> <span style="color: red;">*(排序号为数字，可重复)</span> <br /> <br />
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="updateAcountMapping()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div>
 </body>
</html>





