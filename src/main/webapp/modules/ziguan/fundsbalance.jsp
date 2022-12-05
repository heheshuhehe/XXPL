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
	 $("#dg").datagrid({
	 	 width : '100%',
   	     height :document.documentElement.clientHeight-135
	 });	
	
	
	 $("#stype").combobox({
		 onSelect:function (){
			 var stype= $("#stype").combobox('getValue');
				if(stype==1){
					$("#itemcodeid")[0].style.display="none";
					$("#cjspan")[0].style.display="";
				}
				else if(stype==2){
					$("#itemcodeid")[0].style.display="";
				$("#cjspan")[0].style.display="none";}
			}
	 });
	var stype= $("#stype").combobox('getValue');

	if(stype==1){
		$("#itemcodeid")[0].style.display="none";
		$("#cjspan")[0].style.display="";
	}
	else if(stype==2){
		$("#itemcodeid")[0].style.display="";
	$("#cjspan")[0].style.display="none";
	}
	 
		 $("#fristtype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		     method:'post',
			  multiple:true,
			  width:80,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					  onLoadSuccess: function(){
								 $('#fristtype').next('.combo').find('input').focus(function (){
							            $('#fristtype').combobox('clear');
							     });
								 
						     },
					onChange:function(){
						 $("#itemcode").combobox({
							 valueField: 'value',
							  textField: 'text',
							  mode:'local',
							  url:'<%=cp%>/ziguan/getsubjectinfo?fristtype='+$("#fristtype").combobox('getValue'),
						     method:'post',
							  multiple:false,
							  width:150,
							  filter: function(q, row){
										var opts = $(this).combobox('options');
										console.log(opts);
										return row[opts.textField].indexOf(q) >-1;
									},
									  onLoadSuccess: function(){
												 $('#itemcode').next('.combo').find('input').focus(function (){
											            $('#itemcode').combobox('clear');
											     });
												 
										     }
									
						 }); 
					}
					
		 }); 
		 
		 $("#itemcode").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getsubjectinfo?fristtype='+$("#fristtype").combobox('getValue'),
		     method:'post',
			  multiple:false,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					  onLoadSuccess: function(){
								 $('#itemcode').next('.combo').find('input').focus(function (){
							            $('#itemcode').combobox('clear');
							     });
								 
						     }
					
		 }); 
 });


	
</script>
<!-- 自定义js -->
<script type="text/javascript">

function searchdata(){
	var  wbdate=$("#wbdate").datebox('getValue');
	var  wbdate1=$("#wbdate1").datebox('getValue');
	var fristtype=$("#fristtype").combobox('getValue');
	var stype=$("#stype").combobox('getValue');
	var itemcode=$("#itemcode").combobox('getValue');
	var cj=$("#cj").combobox('getValue');

	/* var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#'); */
	if($("#wbdate").datebox("getValue")==""){
		alert("请选择开始时间");
 		return false;
	}
	if($("#wbdate1").datebox("getValue")==""){
		alert("请选择结束时间");
 		return false;
	}
	if(stype==2&&(itemcode==""||itemcode==null)){
		alert("请选科目号");
 		return false;
	}
    if($("#fristtype").combobox('getValue')==""){
 	 		alert("请选择分类");
 	 		return false;
	}else{
		if(wbdate!=null&&fristtype!=null){
			var onlydata="1"; var nolj="1"; 
			if($("#onlydata")[0].checked){
				onlydata=2;
			}
			if($("#nolj")[0].checked){
				nolj=2;
			}
			 var params="wbdate="+$("#wbdate").datebox('getValue')+"&wbdate1="+$("#wbdate1").datebox('getValue')+
             "&fristtype="+$("#fristtype").combobox('getValues')+"&stype="+$("#stype").combobox('getValue')+"&itemcode="+$("#itemcode").combobox('getValue')+"&cj="+$("#cj").combobox('getValue')
             +'&text='+$("#itemcode").combobox('getText')+'&onlydata='+onlydata+'&nolj='+nolj;
		}
    	
    $('#dg').datagrid({method:'get',url:"ziguan/fundsbalance?"+params}).datagrid('clientPaging'); 
	}
}
function ExporterExcel() {

	var  wbdate=$("#wbdate").datebox('getValue');
	var  wbdate1=$("#wbdate1").datebox('getValue');
	var fristtype=$("#fristtype").combobox('getValue');
	var stype=$("#stype").combobox('getValue');
	var itemcode=$("#itemcode").combobox('getValue');
	var cj=$("#cj").combobox('getValue');

	/* var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#'); */
	if($("#wbdate").datebox("getValue")==""){
		alert("请选择开始时间");
 		return false;
	}
	if($("#wbdate1").datebox("getValue")==""){
		alert("请选择结束时间");
 		return false;
	}
	if(stype==2&&(itemcode==""||itemcode==null)){
		alert("请选科目号");
 		return false;
	}
    if($("#fristtype").combobox('getValue')==""){
 	 		alert("请选择分类");
 	 		return false;
	}else{
		if(wbdate!=null&&fristtype!=null){
			var onlydata="1"; var nolj="1"; 
			if($("#onlydata")[0].checked){
				onlydata=2;
			}
			if($("#nolj")[0].checked){
				nolj=2;
			}
			 var params="wbdate="+$("#wbdate").datebox('getValue')+"&wbdate1="+$("#wbdate1").datebox('getValue')+
             "&fristtype="+$("#fristtype").combobox('getValues')+"&stype="+$("#stype").combobox('getValue')+"&itemcode="+$("#itemcode").combobox('getValue')+"&cj="+$("#cj").combobox('getValue')
             +'&text='+$("#itemcode").combobox('getText')+'&onlydata='+onlydata+'&nolj='+nolj;
		}
    	
   
	}
	
    	
		window.open("<%=cp%>/modules/ziguan/fundbal.jsp?"+params);
		
		
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



</script>
<body>
	<div id="tabsidk" >
		<div title="多基金余额表" style="padding: 5px">
			<span style="margin-left: 15px">开始时间</span><span style="color: red;">*</span> 
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 100px"></input></span>
		   <span style="margin-left: 15px">结束时间</span><span style="color: red;">*</span> 
		   <span><input id="wbdate1" name="wbdate1" class="easyui-datebox" style="width: 100px"></input></span>
				<span style="margin-left: 15px;">分类:</span><span style="color: red;">*</span>
					<input class="easyui-combobox"  style="width:150px;" name="fristtype" id="fristtype" >
					<span style="margin-left: 15px;">查询类型:</span><span style="color: red;">*</span>
					<select class="easyui-combobox" name="stype" style="width:100px;" id ="stype" data-options="filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				}" >
						<option  selected=true value="1">账套汇总</option>
						<option value="2">单科目明细</option>
					</select>
				<span id="itemcodeid"> <span style="margin-left: 15px;">科目号:</span><span style="color: red;">*</span>
					<input class="easyui-combobox" name="itemcode" id="itemcode" style="width:200px;"> </span>  </span>
					<span   id ="cjspan" style="margin-left: 15px;" id="cjid">科目层级:<span style="color: red;">*</span>
					<select class="easyui-combobox" name="cj" style="width:100px;" id ="cj"  >
						<option  selected=true value="1">一级科目</option>
						<option value="2">二级科目</option>
						<option value="3">三级科目</option>
					</select> </span><input name="onlydata" id="onlydata" type="checkbox" /> 不显示0数据
					<input name="nolj" id="nolj" type="checkbox" /> 查询累计值
						<br><a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
						 <a href="javascript:void(0);" class="easyui-linkbutton" 
						 data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
			 </div>
			<div style="margin-top: 10px;">
				<table id="dg" 
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500, pageList:[100,200,500]">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							 <th field="c_port_code" data-options="hidden:false">账套号</th>
							 <th field="c_port_name" data-options="hidden:false">账套名称</th>
							 <th field="itemcode"data-options="hidden:false">科目代码</th>
							 <th field="itemname" data-options="hidden:false">科目名称</th>
							 <th field="balanceqc" data-options="hidden:false,align:'right',formatter:myformatter">期初余额</th>
							<th field="occurbqj"   data-options="align:'right',formatter:myformatter">本期借方</th>
						     <th field="occurbqd"   data-options="align:'right',formatter:myformatter">本期贷方</th>
							<th field="occurljj"  data-options="align:'right',formatter:myformatter">累计借方</th>
							<th field="occurljd"   data-options="align:'right',formatter:myformatter">累计贷方</th>
							<th field="balanceqm"   data-options="align:'right',formatter:myformatter">期末余额</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>



