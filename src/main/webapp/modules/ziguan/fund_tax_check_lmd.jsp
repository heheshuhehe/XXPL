<%@page language="java" contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
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
	 	 $("#filepzdg_managername").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_value").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#table_check").datagrid({
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

$("#guzhiname_zg").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=07',
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

$("#guzhiname_zg_1").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=07',
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

$("#guzhiname_zg_2").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=07',
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

$("#group_code").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getTaxGroupSelect?selectType=01',
  method:'post',
	  multiple:false,
	  width:150,
	  filter: function(q, row){
				var opts = $(this).combobox('options');
				console.log(opts);
				return row[opts.textField].indexOf(q) >-1;
			},
			  onLoadSuccess: function(){
					 $('#group_code').next('.combo').find('input').focus(function (){
				            $('#group_code').combobox('clear');
				            
				     });
					 
			     }
});

	//file_search();
	//pz_searchdata();
     InitDateValue();
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

 function searchdata_fundtradeorder_set(){
	    var params="guzhiname="+$("#guzhiname_zg").combobox('getValue')+"&keyword="+$("#keyword").textbox('getValue');
	    //alert(params);
	    $('#pzdg').datagrid({method:'get',url:"ziguan/getFundtradeorderSet?"+params}).datagrid('clientPaging'); 
	}
 
 function searchdata_taxgroupid(){
	    var params="guzhiname="+$("#guzhiname_zg").combobox('getValue')+"&keyword="+$("#keyword").textbox('getValue');
	    //alert(params);
	    $('#pzdg').datagrid({method:'get',url:"ziguan/getFundtradeorderSet?"+params}).datagrid('clientPaging'); 
	}
 
 function searchTaxWrongList(){
	 	var date_start = $("#date_start").combobox('getValue');
	 	var date_end = $("#date_end").combobox('getValue');
	 	if(date_start==""||date_end==""){
			alert("请选择日期！");
			return false;
		}
	    var params="guzhiname="+$("#guzhiname_zg_1").combobox('getValue')+"&date_start="+$("#date_start").combobox('getValue')+"&date_end="+$("#date_end").combobox('getValue');
	    //alert(params);
	    $('#filepzdg').datagrid({method:'get',url:"ziguan/getTaxWrongList?"+params}).datagrid('clientPaging'); 
	}
 
 function OutputTaxWrongList(){
	 	var date_start = $("#date_start_1").combobox('getValue');
	 	var date_end = $("#date_end_1").combobox('getValue');
	 	if(date_start==""||date_end==""){
			alert("请选择日期！");
			return false;
		}
	    var params="area_lx="+$("#area_lx").combobox('getValue')+"&data_lx="+$("#data_lx").combobox('getValue')+"&tax_lx="+$("#tax_lx").combobox('getValue')+"&date_start="+$("#date_start_1").combobox('getValue')+"&date_end="+$("#date_end_1").combobox('getValue');
	    //alert(params);
	    //return false;
	    $('#filepzdg_value').datagrid({method:'get',url:"ziguan/OutputTaxWrongList?"+params}).datagrid('clientPaging'); 
	}
 
 function OutputTaxInterestList(){
	 	var date_start = $("#date_start_2").combobox('getValue');
	 	var date_end = $("#date_end_2").combobox('getValue');
	 	if(date_start==""||date_end==""){
			alert("请选择日期！");
			return false;
		}
	    var params="area_lx="+$("#area_lx_1").combobox('getValue')+"&date_start="+$("#date_start_2").combobox('getValue')+"&date_end="+$("#date_end_2").combobox('getValue');
	    //alert(params);
	    //return false;
	    $('#pzdg').datagrid({method:'get',url:"ziguan/OutputTaxInterestList?"+params}).datagrid('clientPaging'); 
	}
 
 function CheckTaxTableList(){
	 	var date_start = $("#date_start_3").combobox('getValue');
	 	var date_end = $("#date_end_3").combobox('getValue');
	 	if(date_start==""||date_end==""){
			alert("请选择日期！");
			return false;
		}
	 	var group_code=$("#group_code").combobox('getValue');
	 	var c_port_code=$("#c_port_code").textbox('getValue');
	 	if(group_code==""&&c_port_code==""){
			alert("请填入产品编码或者选择组别编码中至少一项！");
			return false;
		}
	 	var params="area_lx="+$("#area_lx_2").combobox('getValue')+"&date_start="+$("#date_start_3").combobox('getValue')+"&date_end="+$("#date_end_3").combobox('getValue')+"&c_port_code="+$("#c_port_code").textbox('getValue')+"&group_code="+$("#group_code").textbox('getValue');
	    //alert(params);
	    //return false;
	    $('#table_check').datagrid({method:'get',url:"ziguan/CheckTaxTableList?"+params}).datagrid('clientPaging'); 
	}
 
 function ExporterExcel() {//导出Excel文件
	 	var date_start = $("#date_start_1").combobox('getValue');
	 	var date_end = $("#date_end_1").combobox('getValue');
	 	if(date_start==""||date_end==""){
			alert("请选择日期！");
			return false;
		}
	    var params="area_lx="+$("#area_lx").combobox('getValue')+"&data_lx="+$("#data_lx").combobox('getValue')+"&tax_lx="+$("#tax_lx").combobox('getValue')+"&date_start="+$("#date_start_1").combobox('getValue')+"&date_end="+$("#date_end_1").combobox('getValue');
// 	    alert(params);
// 	    return false;
	
	 	window.location.href='<%=cp%>/ziguan/OutputTaxlistExcel?'+params;

		
	}
 
 function searchdata_fundtradeorder_files(){
	 	var year = $("#paymentdate_1").combobox('getValue');
	 	if(year==""){
			alert("请选择日期！");
			return false;
		}
	    var params="guzhiname="+$("#guzhiname_zg_2").combobox('getValue')+"&paymentdate="+$("#paymentdate_1").combobox('getValue');
	    //alert(params);
	    $('#filepzdg_1').datagrid({method:'post',url:"ziguan/getFundtradeorderFiles?"+params}).datagrid('clientPaging'); 
	}
 function get_fundtradeorderlist_fso(){
	 	var year = $("#paymentdate_1").combobox('getValue');
	 	if(year==""){
			alert("请选择日期！");
			return false;
		}
	 	//alert("+"+$("#guzhiname_zg_2").combobox('getValue')+"+");
	 	//return false;
	    var params="guzhiname="+$("#guzhiname_zg_2").combobox('getValue')+"&paymentdate="+$("#paymentdate_1").combobox('getValue');
        if($("#iscopy").prop("checked")){
        	params +="&iscopy=1";
        	if ($("#guzhiname_zg_2").combobox('getValue')==""||$("#guzhiname_zg_2").combobox('getValue')=="0")
       		{
        		alert("拷贝前请选择具体的估值人员！");
        		return false;
       		}
        }
        else
		{
        	params +="&iscopy=0";
		}
	    //alert(params);
	    //return false;
	    $('#filepzdg_1').datagrid({method:'post',url:"ziguan/getfundtradeorderlistFso?"+params}).datagrid('clientPaging'); 
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
 
 //删除资金系统和估值系统的配置关系
 function dr_removedata(){
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
			url:'<%=cp%>/ziguan/updatedirectiveInfo',
			type:'post',
			data:{id:ids.toString(),type:'delete'},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("删除成功！");
					//pz_searchdata();
				}else if(data.msg="error"){
					alert("删除失败！");
				}
			}
		});
	
	}
 }
 
 //标注为已经制作
 function dr_signdata(){
		var lxs = [];
		var c_port_codes = [];
		var d_book_dates = [];
		var c_sec_codes = [];
		var checkItems = $('#filepzdg').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			lxs.push(item.lx);
			c_port_codes.push(item.c_port_code);
			d_book_dates.push(item.d_book_date);
			c_sec_codes.push(item.c_sec_code);
		});
		//alert(c_port_codes);
		//return false;
		
 	if(lxs.length<1){
		alert("请选择一条记录！");
		return false;
	}else{
	$.ajax({
			url:'<%=cp%>/ziguan/signTaxWrongList',
			type:'post',
			data:{lx:lxs.toString(),c_port_code:c_port_codes.toString(),d_book_date:d_book_dates.toString(),c_sec_code:c_sec_codes.toString()},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("标注成功！");
					//pz_searchdata();
				}else if(data.msg="error"){
					alert("标注失败！");
				}
			}
		});
	
	}
 }
 
 function pz_editdata(){
 	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var row = $("#pzdg").datagrid('getSelected');
		$("#zg_fundcode").combobox('setValue',row.c_port_code);
		//$("#zg_fundcode").textbox('setValue',row.c_port_code);
		$("#jzzx_fundcode").combobox('setValue',row.fundcode);
		//$("#jzzx_fundcode").textbox('setValue',row.fundcode);
		//$("#value1").textbox('setValue',row.value1);
		//$("#value2").textbox('setValue',row.value2);
		$("#opid").textbox('setValue',row.id);
		id = row.id;
		$('#hdpz').dialog('open');
 	}
 }
 function pz_setdata(){
	 	if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var row = $("#filepzdg_1").datagrid('getSelected');
			//$("#zg_fundcode").combobox('setValue',row.c_port_code);
			//$("#zg_fundcode").textbox('setValue',row.c_port_code);
			$("#jzzx_fundcode").combobox('setValue',row.fundcode);
			$("#opid").textbox('setValue',row.id);
			id = row.id;
			$('#hdpz').dialog('open');
	 	}
	 }
 
 function pz_setdata_other(){
	 	if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var row = $("#filepzdg").datagrid('getSelected');
			//$("#zg_fundcode").combobox('setValue',row.c_port_code);
			//$("#zg_fundcode").textbox('setValue',row.c_port_code);
			$("#jzzx_fundcode").combobox('setValue',row.fundcode);
			$("#opid").textbox('setValue',row.id);
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
	  var  zg_fundcode_value=$("#zg_fundcode").combobox('getValue');
	  var  jzzx_fundcode_value=$("#jzzx_fundcode").textbox('getValue');
	  var  id=$("#opid").textbox('getValue');

	 if (zg_fundcode_value=="") {
		$.messager.alert('提示','资管估值系统产品信息不能为空');
		return false;
	}else if(jzzx_fundcode_value==""){
		$.messager.alert('提示','资金划付系统产品信息不能同时为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/saveFundtradeorderInfo',
			type:'post',
			data:{zg_fundcode_value:zg_fundcode_value,jzzx_fundcode_value:jzzx_fundcode_value,id:id},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					//pz_searchdata();
					closeDialog();
					
				}else{
					$.messager.alert("提示","保存失败");
					
				}
				id = "";
			}
		});
		}

	}
 
 function pz_checkmanagername(){
		 $('#filepzdg_managername').datagrid({url:"<%=cp%>/ziguan/queryFundcheckmanagername"}); 
	}
 
 function pz_adddata(){
	 $('#hdpz').dialog('open');
 }
 
 
 
 function InitDateValue(){
	    var date=new Date;
	    date=DateAdd("d",-3,date);
		var year = date.getFullYear();
		var month = date.getMonth();
		var new_year = year; //取当前的年份
		var new_month = month++;//取下一个月的第一天，方便计算（最后一天不固定）
		if(month>12){//如果当前大于12月，则年份转到下一年
		  new_month -=12; //月份减
		  new_year++; //年份增
		}
		
		var first_date = new Date(new_year,new_month,1); //取当年当月中的第一天
		var f_date = new Date(new_year,new_month,1); //取当年当月中的第一天
		var last_date = DateAdd("m",1,first_date); //取当年当月中的第一天
		last_date = DateAdd("d",-1,last_date);
	    $("#date_start").textbox('setValue',formatDate(f_date));
	    $("#date_end").textbox('setValue',formatDate(last_date));
	    $("#date_start_1").textbox('setValue',formatDate(f_date));
	    $("#date_end_1").textbox('setValue',formatDate(last_date));
	    $("#date_start_2").textbox('setValue',formatDate(f_date));
	    $("#date_end_2").textbox('setValue',formatDate(last_date));
	    $("#date_start_3").textbox('setValue',formatDate(f_date));
	    $("#date_end_3").textbox('setValue',formatDate(last_date)); }
 function formatDate(time){
	 var date = new Date(time);
	 var year = date.getFullYear(),
	         month = date.getMonth()+1,//月份是从0开始的
	 day = date.getDate(),
	 hour = date.getHours(),
	 //min = date.getMinutes(),
	 sec = date.getSeconds();
	 var newTime = year + '-' +
	                 (month< 10? '0' + month : month) + '-' +
	                 (day< 10? '0' + day : day) ;
	 return newTime;         
	 }
 function DateAdd (interval,number,date){
	//確保為date類型:
	date=convertToDate(date);
    switch(interval.toLowerCase()){
        case "y": return new Date(date.setFullYear(date.getFullYear()+number));
        case "m": return new Date(date.setMonth(date.getMonth()+number));
        case "d": return new Date(date.setDate(date.getDate()+number));
        case "w": return new Date(date.setDate(date.getDate()+7*number));
        case "h": return new Date(date.setHours(date.getHours()+number));
        case "n": return new Date(date.setMinutes(date.getMinutes()+number));
        case "s": return new Date(date.setSeconds(date.getSeconds()+number));
        case "l": return new Date(date.setMilliseconds(date.getMilliseconds()+number));
    }
};
	function dateFormat(date){
		//確保為date類型:
		date=convertToDate(date);
		vardefyear = parseInt(date.getFullYear());//當前年
	vardefmonth = parseInt(date.getMonth()+1,10); //當前月
	vardefday=date.getDate();//當前日
	var result="";
	    if(defmonth<10&&defday<10){
		    result=defyear+'-0'+defmonth+'-0'+defday;
	    }else if(defmonth<10){
	        result=defyear+'-0'+defmonth+'-'+defday;
	    }else if(defday<10){
	        result=defyear+'-'+defmonth+'-0'+defday;
	    }else{
			result=defyear+'-'+defmonth+'-'+defday;
	    }
	    return result;
	};
	//javascript中定義的replaceAll()
	String.prototype.replaceAll = function(s1,s2){
		return this.replace(new RegExp(s1,"gm"),s2);
	};
	//將日期類型格式的字符串轉化為日期類型:
	function convertToDate(expr){
		if(typeof expr=='string'){
			expr=expr.replaceAll('-','/');//將字符中的-替換為/,原因是IE或其它瀏覽器不支持-符號的Date.parse()
			return new Date(Date.parse(expr));
		}else{
			return expr;
		}
	};



 
</script>


<body>
<div id="tabsidk" >

<div title="管理人信息检查" style="padding: 5px">
	  <div style ="height:15px;">
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_checkmanagername()">查询</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_managername"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="c_port_code" width="100" sortable="true">产品编码</th>
						<th field="c_port_name" width="300"  sortable="true">产品名称</th>
						<th field="username" width="300"  sortable="true">估值人员</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
	<div title="台账校验" style="padding: 5px">
	  <div style ="height:15px;">
	  <div style ="float:left">
	  	<span>交易日期</span>
	       <input id="date_start" name="date_start"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
	       <input id="date_end" name="date_end"
			class="easyui-datebox"  style="width: 120px" float="left" value=""> </input>
	    <span>估值人员:</span> 
			<input class="easyui-combobox" name="guzhi_name_1" id="guzhiname_zg_1"> 
		</div>
		 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchTaxWrongList()">查询</a> 

		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="dr_signdata()">标注已处理</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" id="J_export" onclick="exportCsv2()">导出</a>

 	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="lx" width="200"  sortable="true">差错类型</th>
						<th field="c_port_code" width="80"  sortable="true">产品代码</th>
						<th field="c_port_name" width="300"  sortable="true">产品名称</th>
						<th field="d_book_date" width="80"  sortable="true">发生日期</th>
						<th field="c_sec_code" width="100"  sortable="true">证券代码</th>
						<th field="username" width="120"  sortable="true">估值人员名称</th>
						<th field="add_date" width="200"  sortable="true">处理结果</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 	<div title="台账取值" style="padding: 5px">
	  <div style ="height:15px;">
	  <div style ="float:left">
	  	<span>交易日期</span>
	       <input id="date_start_1" name="date_start_1"
			class="easyui-datebox"  style="width: 120px" float="left"></input>
	       <input id="date_end_1" name="date_end_1"
			class="easyui-datebox"  style="width: 120px" float="left" value=""> </input>
	    <span>地区:</span> 
		 <select id="area_lx" class="easyui-combobox">
		   <option value="bj">北京</option>
		   <option value="sh">上海</option>
		 </select>
	    <span>纳税分类:</span> 
		 <select id="tax_lx" class="easyui-combobox">
		   <option value="Y_TAX">应税(Y_TAX)</option>
		   <option value="M_TAX">免税(M_TAX)</option>
		 </select>
	    <span>业务分类:</span> 
		 <select id="data_lx" class="easyui-combobox">
		   <option value="zr">转让</option>
		   <option value="lx">利息</option>
		 </select>
		</div>


		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="OutputTaxWrongList()">查询</a> 
   

 	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_value"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false
				               ">
				<thead>
					<tr>
						<th field="username" width="50"  sortable="true">估值人员</th>
						<th field="lx_name" width="50"  sortable="true">类型名称</th>
						<th field="c_port_code" width="80"  sortable="true">产品代码</th>
						<th field="c_port_name" width="300"  sortable="true">产品名称</th>
						<th field="d_book_date" width="80"  sortable="true">发生日期</th>
						<th field="c_sec_code" width="100"  sortable="true">证券代码</th>
						<th field="c_sec_name" width="200"  sortable="true">证券名称</th>
						<th field="c_sec_var_code" width="100"  sortable="true">证券品种</th>
						<th field="c_sec_var_name" width="150"  sortable="true">品种名称</th>
						<th field="n_port_price" width="120"  sortable="true">卖出金额</th>
						<th field="n_port_cost" width="120"  sortable="true">卖出成本</th>
						<th field="n_base" width="120"  sortable="true">计税基准</th>
						<th field="n_val" width="120"  sortable="true">差价收入</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 
	
	<div title="利息免税品种统计" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  	<span>交易日期</span>
			       <input id="date_start_2" name="date_start_2"
					class="easyui-datebox"  style="width: 120px" float="left"></input>
			       <input id="date_end_2" name="date_end_2"
					class="easyui-datebox"  style="width: 120px" float="left"> </input>
			    <span>地区:</span> 
				 <select id="area_lx_1" class="easyui-combobox">
				   <option value="bj">北京</option>
				   <option value="sh">上海</option>
				 </select>
			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="OutputTaxInterestList()">查询</a> 
			     
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="pzdg"  
						data-options="selectOnCheck:true,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true
						               ">
						<thead>
							<tr>
								<th field="tax_id" width="150"  sortable="true">免税代码</th>
								<th field="sec_var_code" width="100" >债券代码</th>
								<th field="sec_var_name" width="300" >债券名称</th>
								<th field="n_base" width="100" >利息合计</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>
		 
		 	<div title="增值税申报表核对" style="padding: 5px">
			  <div style="margin-bottom: 10px;">
			  	<span>交易日期</span>
			       <input id="date_start_3" name="date_start_3"
					class="easyui-datebox"  style="width: 120px" float="left"></input>
			       <input id="date_end_3" name="date_end_3"
					class="easyui-datebox"  style="width: 120px" float="left"> </input>
			    <span>地区:</span> 
				 <select id="area_lx_2" class="easyui-combobox">
				   <option value="bj">北京</option>
				   <option value="sh">上海</option>
				 </select>
				 产品编码(选填，多个可以用,分隔)：
					<span> 
					<input  style="width:150px;height:25px;" type="text" class="easyui-textbox"  name="c_port_code" id="c_port_code" />
				</span> 

				 <span> 组合编码(选填，多个可以用,分隔):</span> 
			         <input class="easyui-combobox" name="group_code" id="group_code"> 

			     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CheckTaxTableList()">查询</a> 
			     
			  </div>
			  <div style="margin-top: 10px;">
					<table  id="table_check"  
						data-options="selectOnCheck:true,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true">
						<thead>
							<tr>
								<th field="username" width="80"  sortable="true">估值人员</th>
								<th field="c_port_code" width="80"  sortable="true">产品代码</th>
								<th field="c_port_name" width="300"  sortable="true">产品名称</th>
								<th field="table_name" width="150"  sortable="true">表名</th>
								<th field="sort_name" width="150"  sortable="true">类别</th>
								<th field="xiangmu_name" width="150" >项目</th>
								<th field="value_sign" width="100" >标识</th>
								<th field="value_name" width="200" >公式</th>
								<th field="jine1" width="200" >自算金额</th>
								<th field="jine2" width="200" >估值系统金额</th>
								<th field="ischeck" width="100" >核对</th>
							</tr>
						</thead>
					</table>
				</div>
		 </div>


</div>
<div id="hdpz" class="easyui-dialog" closed="true" title="资金划拨系统与估值系统匹配"
			style="width: 450px; height: 250px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
		  	<span>估值系统账套名称:</span>
					  <input class="easyui-combobox" name="zg_fundcode" id="zg_fundcode"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/ziguan/getdirectZgProduct',
		                          method:'post',
								  multiple:false,
								  width:250,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#zg_fundcode').next('.combo').find('input').focus(function (){
									            $('#zg_fundcode').combobox('clear');
									 });
							     }
					  ">
			 <span style="color: red;">*</span>
			<br></br>	
			
			<span >资金划付产品名称:</span> 
			<span> 
				<input class="easyui-combobox" name="jzzx_fundcode" id="jzzx_fundcode"
										data-options="
							                      valueField: 'value',
												  textField: 'text',
												  mode:'local',
												  url:'<%=cp%>/ziguan/getdirectJzzxProduct',
						                          method:'post',
												  multiple:false,
												  width:250,
												  filter: function(q, row){
															var opts = $(this).combobox('options');
															return row[opts.textField].indexOf(q) >-1;
														},
										         onLoadSuccess:function(){
													 $('#jzzx_fundcode').next('.combo').find('input').focus(function (){
													            $('#jzzx_fundcode').combobox('clear');
													 });
											     }
									  ">
					</span> 
			<span style="color: red;">*</span>
			<input type="hidden" class="easyui-numberbox" id="opid" name="opid">
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensure()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

</body>



