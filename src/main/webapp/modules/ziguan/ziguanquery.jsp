<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>账套对应关系配置</title>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 --> 
<script type="text/javascript">
 $(function (){
	//初始化table
	$("#tabsidk").tabs({
			width : '100%',
			height : document.documentElement.clientHeight-20
	});
	
	$("#dgpz").datagrid({
	 	 width : '100%',
     	 height : document.documentElement.clientHeight-140
	 });
	
	 $("#dg").datagrid({
	 	 width : '100%',
   	     height :document.documentElement.clientHeight-135
	 });		
	 
	 
		 $("#fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:false,
			  width:80,
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
								  width:80,
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
		 
		 $("#bank").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getBankSelect',
		     method:'post',
			  multiple:false,
			  width:100,
			  filter: function(q, row){
					var opts = $(this).combobox('options');
					console.log(opts);
					return row[opts.textField].indexOf(q) >-1;
				}
		 })
 });


	
</script>
<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
	var  wbdate=$("#wbdate").datebox('getValue');
	var startdate = $("#startdate").datebox('getValue');
	var enddate = $("#enddate").datebox('getValue');
	var fristtype=fristtype=$("#fristtype").combobox('getValue');
	var secondtype=$("#secondtype").combobox('getValue');
	var state = $("#state").combobox('getValue');
	var bank = $("#bank").combobox('getValue');
	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');
	if($("#wbdate").datebox("getValue")==""){
		alert("请选择截止时间");
 		return false;
	}else if($("#fristtype").combobox('getValue')==""){
 	 		alert("请选择一级类别");
 	 		return false;
	}else{
		if(wbdate!=null&&fristtype!=null&&secondtype!=null){
			 var params="wbdate="+$("#wbdate").datebox('getValue')+"&startdate="+$("#startdate").datebox('getValue')+"&enddate="+$("#enddate").datebox('getValue')+
             "&fristtype="+$("#fristtype").combobox('getValue')+"&secondtype="+$("#secondtype").combobox('getValue')+"&state=+"+state+"&bank="+bank+"&chanzt="+chanzt;
		}else if(secondtype==""){
			var params="wbdate="+$("#wbdate").datebox('getValue')+"&state=+"+state+"&bank="+bank+
            "&fristtype="+$("#fristtype").combobox('getValue')+"&chanzt="+chanzt;
		}
    	
    $('#dg').datagrid({method:'get',url:"ziguan/getJJKMInfo?"+params}).datagrid('clientPaging'); 
	}
}
function ExporterExcel() {//导出Excel文件
	var  wbdate=$("#wbdate").datebox('getValue');
	var startdate = $("#startdate").datebox('getValue');
	var enddate = $("#enddate").datebox('getValue');
	var fristtype=$("#fristtype").combobox('getValue');
	var secondtype=$("#secondtype").combobox('getValue');
	var frist=$("#fristtype").combobox('getText');
	var second=$("#secondtype").combobox('getText');
	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');
	if(wbdate==""){
	alert("请选择日期");
	return false;
	} 
	if(fristtype==""){
		alert("请选择一级分类");
	    return false;
	}else{
			var params="wbdate="+wbdate+"&fristtype="+fristtype+"&startdate="+startdate+"&enddate="+enddate+
	   		"&secondtype="+secondtype+"&frist="+frist+
	   		"&second="+second+"&chanzt="+chanzt;
		window.location.href="<%=cp%>/ziguan/getDownJJKMInfo?"+params;
		}
}

//存储过程的计算
function compute(){
	var wbdate=$("#wbdate").datebox('getValue');
	if (wbdate=="") {
		alert("请选择计算数据的时间！");
		return false;
	}else{
	$.ajax({
		url:'<%=cp%>/ziguan/Compute',
		type:'post',
		data:{wbdate:wbdate},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("数据正确计算");
			}else{
				alert("数据计算出错！！！");
			}
			
		}
	});
	}
	
}

function p_searchdata(){

 	 var params="p_type="+$("#p_type").combobox('getValue');
	 $('#dgpz').datagrid({url:"<%=cp%>/ziguan/getTJConfig?"+params}).datagrid('clientPaging'); 
}

function p_editdata(type){
		var rows = $("#dgpz").datagrid("getSelections");
		var id = "";
		for(var i=0;i<rows.length;i++){
			id += rows[i].id;
			if(i<rows.length-1){
				id +=","
			}else{
				break;
			}
		}
		$.ajax({
			url:'<%=cp%>/ziguan/updateTJConfig',
			type:'post',
			data:{id:id,type:type},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("保存成功");
					p_searchdata();
					
				}else{
					alert("保存失败");
				}
				
			}
		});
}

</script>
<body>
	<div id="tabsidk" class="easyui-tabs" style="">
		<div title="账套查询信息" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			    <div style="margin-bottom: 5px;">
			    <span style="margin-left: 15px;">说明: 科目代码:fkmbm;科目名称:fkmmc;成本:fzqcb;市值:fzqsz</span></br>
				<span style="margin-left: 15px;">推荐值:1,实收资本金额;2,实收资本</span> </br>
				<span style="margin-left: 15px;">多科目号(例如:1002+1021) 601实收资本,fzqsl,fzqcb,fzqsz</span>
				</div>
				<span style="margin-left: 15px">成立日期</span>
		   		<span><input id="startdate" name="startdate" class="easyui-datebox" style="width: 100px"></input></span>
				<span style="margin-left: 5px">至</span>
		   		<span><input id="enddate" name="enddate" class="easyui-datebox" style="width: 100px"></input></span>
				<span style="margin-left: 15px">估值表日期</span>
		   		<span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 100px"></input><span style="color: red;">*</span> </span>
				<span style="margin-left: 15px;">一级分类:</span>
					<input class="easyui-combobox" name="ziguan_logo" id="fristtype">
					<span style="color: red;">*</span>
				<span style="margin-left: 15px;">二级分类:</span>
					<input class="easyui-combobox" name="ziguan_logo" id="secondtype"></input>
					<input type="checkbox" name="chanzt" value="1"  id="chanzt" />是否显示无数据账套信息
						<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
						 <a href="javascript:void(0);" class="easyui-linkbutton" 
						 data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
					<br>
					<span style="margin-left: 15px;">状态:</span>
					<select class="easyui-combobox" name="state" style="width:100px;" id ="state"  >
						<option value="">请选择</option>
						<option value="PS1">计划期</option>
						<option value="PS2">发行期</option>
						<option value="PS3">募集期</option>
						<option value="PS4">存续期</option>
						<option value="PS5">已到期</option>
						<option value="PS6">已清算</option>
					</select>
					<span style="margin-left: 15px;">银行:</span>
					<input class="easyui-combobox" name="bank" id="bank">
			 </div>
			<div style="margin-top: 10px;">
				<table id="dg" 
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							 <th field="top_classify" data-options="hidden:true"></th>
							 <th field="sub_classify" data-options="hidden:true"></th>
							 <th field="type"data-options="hidden:true">type</th>
							<th field="zth" width="100px">账套号</th>
						     <th field="fsetname" width="225px">基金名称</th>
							<th field="fzqsz" width="150px" data-options="align:'right',formatter:myformatter">基金市值</th>
							<th field="fzqcb" width="150px" data-options="align:'right',formatter:myformatter">基金成本</th>
							<th field="fzqsl" width="150px" data-options="align:'right',formatter:myformatter">基金数量</th>
							<th field="createdate"  width="150px" >成立日期</th>
							<th field="state" width="100px">状态</th>
							<th field="bank" width="150px">银行</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
			<div title="配置" style="padding: 5px">
				  <div style="margin-bottom: 10px;">
				    <span>类型: 
	                 <select class="easyui-combobox" name="p_type" id="p_type">
	                      <option value="0">--请选择--</option>
			              <option value="1">参加统计</option>
					      <option value="2">不参加统计</option>
				      </select>
				    </span>
				     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="p_searchdata()">查询</a> 
				     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="p_editdata('1')">统计</a> 
				     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="p_editdata('2')">不统计</a> 
				  </div>
				  <div style="margin-top: 10px;">
						<table  id="dgpz"  
							data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
							              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500
							               "  >
							<thead>
								<tr>
									<th data-options="field:'ck',checkbox:true"></th>
									<th field="id"  data-options="hidden:true"></th>
									<th field="account_id" width="150px">账套号</th>
						     		<th field="name" width="225px">基金名称</th>
									<th field="isconfig" data-options="hidden:true" ></th>
									<th field="type" width="150px" >类型</th>
								</tr>
							</thead>
						</table>
					</div>
		 </div>
	</div>
<!-- 	         <div id="p_dlg_edit" class="easyui-dialog" closed="true" title="修改配置项"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
			 <span style="margin-left:20px;">类&nbsp;&nbsp;型:</span> <span> <input
			type="text" class="easyui-textbox" id="p_dkmh_dialogs" name="p_dkmh_dialogs" />
		</span><span style="color: red;">*(220601,fstartbal,本期借方)</span> <br /> <br />
		<span style="margin-left:20px;">排序号&nbsp;:</span> <span> <input
			type="text" class="easyui-textbox" id="p_dkmh_ranks" name="p_dkmh_ranks" />
		</span> <span style="color: red;">*(排序号为数字，可重复)</span> <br /> <br />
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="updateAcountMapping()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="p_closeDialog()">取消</a>
		</div> -->
</body>



