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
	 	 $("#filepzdg_worktimelist").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });	 	 	 	 
	 	 $("#filepzdg_sort").datagrid({
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
	 	 $("#filepzdg_worksort").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_workdetail").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_work_touzi").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_workdetaildefaultvalue").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });

	 	 $("#filepzdg_fundsort").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_fundvalue").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });	 	 
	 	 $("#filepzdg_fundtotalvalue").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_fund_undefined").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-130
	 	 });
	 	 $("#filepzdg_upload").datagrid({
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
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=09',
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
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=09',
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
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=09',
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
$("#guzhizt_sort").combobox({
	 valueField: 'value',
	  textField: 'text',
	  mode:'local',
	  url:'<%=cp%>/ziguan/getUserSelect?selectType=10',
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
	//pz_searchproductset();
    pz_searchdetailvalue();
    pz_searchtouzi();
    pz_searchdetail();
    pz_searchsort();
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
 
 //删除分类
 function dr_removesortdata(){
		var ids = [];
		var checkItems = $('#filepzdg_worksort').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
			
		});
 	if(ids.length<1){
		alert("请选择一条记录！");
		return false;
	}else{
	$.ajax({
			url:'<%=cp%>/ziguan/updateworksort',
			type:'post',
			data:{id:ids.toString(),type:'delete'},
			dataType: "json",
			success: function(data){
				if(data.msg="success"){
					alert("删除成功！");
					pz_searchsort();
				}else if(data.msg="error"){
					alert("删除失败！");
				}
			}
		});
	
	}
 }
 
 //删除分类指标
 function dr_removedetaildata(){
		var ids = [];
		var checkItems = $('#filepzdg_workdetail').datagrid('getChecked');
		$.each(checkItems,function(index,item){
			ids.push(item.id);
			
		});
 	if(ids.length<1){
		alert("请选择一条记录！");
		return false;
	}else{
	$.ajax({
			url:'<%=cp%>/ziguan/updateworkdetail',
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
	var myFile = document.getElementById("fi").value;
	var length = myFile.length;
	var x = myFile.lastIndexOf("\\");
	x++; 
	var fileName = myFile.substring(x,length); 
	var filename=fileName.substring(fileName.lastIndexOf("."),fileName.length);
	//var rqs =$("#paymentdate_cw_start").combobox('getValue');
	 if(fileName==""){
		alert("请选择要导入数据库的文件");
		  return false;
	  }else if(filename!=".xls"&&filename!=".dlt"){
		alert("请选择xls或者dlt格式的文件！！！");
		return false;
	  }else{
	
     var formData = new FormData($( "#uploadfile" )[0]); 
		//alert (fileName);
		//return false;
     
     
     $.ajax({   
          url: '<%=cp%>/guzhibank/springUpload',   
          type: 'POST',   
          data: formData,
          async: false,   
          cache: false,   
          contentType: false,   
          processData: false,   
          dataType:"json",
          success: function (data) { 
          		if(data.msg="success"){
            	 		file_down(fileName);
				}else if(data.msg="error"){
					alert("文件导入数据库失败！");
				} 
          }
     }); 
     }  
} 

function file_down(filename){
	 
		  
		  var rqs ="";
		  if(rqs==""){
			$.ajax({
				url:'<%=cp%>/guzhibank/worktimefundupload',
				type:'post',
				data:{filename:filename},
				dataType: "json",
				beforeSend : function() {
					load("正在导入数据库中，请稍后...");
				},
				success: function(obj){
					if(obj.msg=="success"){
						disLoad();
						//file_searchs(rqs);
						alert("文件导入数据库成功"); 
						//get_cw_fundtradeorderlist_check();
						
					}else if(obj.msg="error"){
						disLoad();
						alert("文件导入数据库失败！");
					}
				}
				
			});
		}	  
		  
	 }
//excel中的数据导入到数据库中

function load(msg) {
		$("<div class=\"datagrid-mask\"></div>").css({
			display : "block",
			width : "100%",
			height : $(window).height()
		}).appendTo("body");
		$("<div class=\"datagrid-mask-msg\"></div>").html(msg)
				.appendTo("body").css({
					display : "block",
					left : ($(document.body).outerWidth(true) - 190) / 2,
					top : ($(window).height() - 45) / 2
				});
	}

//取消加载层  
function disLoad() {
	$(".datagrid-mask").remove();
	$(".datagrid-mask-msg").remove();
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
	$('#hdpz_addsort').dialog('close');
	$('#xuhao').textbox('clear');
	$('#cname').combobox('clear');
	$('#qz').textbox('clear');
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

 function pz_ensuresort(){
	  var  xuhao_value=$("#xuhao").textbox('getValue');
	  var  cname_value=$("#cname").textbox('getValue');
	  var  qz_value=$("#quanzhong").textbox('getValue');
	  var  id=$("#opid").textbox('getValue');
	  
	 if (xuhao_value=="") {
		$.messager.alert('提示','序号编码不能为空');
		return false;
	}else if(cname_value==""){
		$.messager.alert('提示','类别名称不能同时为空');
		return false;
	}else if(qz_value==""){
		$.messager.alert('提示','权重值不能同时为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/saveWorkSort',
			type:'post',
			data:{xuhao_value:xuhao_value,cname_value:cname_value,qz_value:qz_value,id:id},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					pz_searchsort();
					closeDialog();
					
				}else{
					$.messager.alert("提示","保存失败");
					
				}
				//id = "";
			}
		});
		}

	}
 
 function pz_ensuredetailTarget(){
	  var  description_value=$("#description").textbox('getValue');
	  var  is_auto_value=$("#is_auto").combobox('getValue');
	  var  xuhao_value=$("#fund_sort_id").combobox('getValue');
	  var  level_id_value=$("#level_id").textbox('getValue');
	  var  zhi_value=$("#zhi").textbox('getValue');
	  var  id_value=$("#opid").textbox('getValue');
	 if (description_value=="") {
		$.messager.alert('提示','指标描述不能为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/saveWorkDetailTarget',
			type:'post',
			data:{description:description_value,is_auto:is_auto_value,xuhao:xuhao_value,level_id:level_id_value,zhi:zhi_value,id:id_value},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					pz_searchdetail();
					closeDialog();
					
				}else{
					$.messager.alert("提示","保存失败");
					
				}
				//id = "";
			}
		});
		}

	}
 
 function pz_ensuredetaildefaultvalue(){
	  var  fund_sort_value=$("#fund_sort").combobox('getValue');
	  var  fund_detail_value=$("#fund_detail").combobox('getValue');
	  var  fund_touzi=$("#fund_touzi").combobox('getValue');
	  var  zhi=$("#zhi").textbox('getValue');

	 if (fund_sort=="") {
		$.messager.alert('提示','产品类型不能为空');
		return false;
	}else if(fund_detail==""){
		$.messager.alert('提示','指标不能同时为空');
		return false;
	}else if(fund_touzi==""){
		$.messager.alert('提示','投资不能同时为空');
		return false;
	}else if(zhi==""){
		$.messager.alert('提示','默认值不能为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/saveWorkDetailDefaultValue',
			type:'post',
			data:{fund_sort_value:fund_sort_value,fund_detail_value:fund_detail_value,fund_touzi:fund_touzi,zhi:zhi},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					//pz_searchdata();
					closeDialog();
					
				}else{
					$.messager.alert("提示","保存失败");
					
				}
				//id = "";
			}
		});
		}

	}
 
 function pz_ensurefundsort(){
	  var  jzzx_fundcode_value=$("#jzzx_fundcode").combobox('getValue');
	  var  F1_value=$("#F1").combobox('getValue');
	  var  F2_value=$("#F2").combobox('getValue');
	  var  F3_value=$("#F3").combobox('getValue');
	  var  F4_value=$("#F4").combobox('getValue');
	  var  F5_value=$("#F5").combobox('getValue');
	  //var request = new XMLHttpRequest();
	  //var  ip_value=request.getRemoteAddr();

	 if (jzzx_fundcode_value=="") {
		$.messager.alert('提示','产品信息不能为空');
		return false;
	}else {
		$.ajax({
			url:'<%=cp%>/ziguan/saveWorkFundSort',
			type:'post',
			data:{F1:F1_value,F2:F2_value,F3:F3_value,F4:F4_value,F5:F5_value,jzzx_fundcode:jzzx_fundcode_value},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					$.messager.alert("提示","保存成功");
					//pz_searchdata();
					pz_searchproductset();
					closeDialog();
					
				}else{
					$.messager.alert("提示","保存失败");
					
				}
				//id = "";
			}
		});
		}

	}

 
 function pz_searchsort(){
		 $('#filepzdg_worksort').datagrid({url:"<%=cp%>/ziguan/queryFundSearchWorkSort"}); 
	}
 function pz_searchdetail(){
	 $('#filepzdg_workdetail').datagrid({url:"<%=cp%>/ziguan/queryFundSearchWorkDetail"}); 
}
 
 function pz_searchtouzi(){
	 $('#filepzdg_work_touzi').datagrid({url:"<%=cp%>/ziguan/queryFundSearchWorkTouzi"}); 
}
 
 function pz_searchworktimelist(){
	 	var date_start = $("#date_start").combobox('getValue');
	 	var date_end = $("#date_end").combobox('getValue');
	 	if(date_start==""||date_end==""){
			alert("请选择日期！");
			return false;
		}
	    var params="guzhiname="+$("#guzhiname_zg_1").combobox('getValue')+"&date_start="+$("#date_start").combobox('getValue')+"&date_end="+$("#date_end").combobox('getValue');
	    //alert(params);
	    $('#filepzdg_worktimelist').datagrid({method:'get',url:"ziguan/getWorkTimeList?"+params}).datagrid('clientPaging'); 


}

 function pz_searchdetailvalue(){
	 $('#filepzdg_workdetaildefaultvalue').datagrid({url:"<%=cp%>/ziguan/queryFundSearchWorkDetailValue"}); 
}
 
 function pz_searchproductset(){
	    var params="guzhiname="+$("#guzhiname_zg_2").combobox('getValue');
	    $('#filepzdg_fundsort').datagrid({method:'post',url:"ziguan/queryFundsearchproductset?"+params}).datagrid('clientPaging'); 
	}
 
 function pz_searchfundvalue(){
	    var params="guzhiname="+$("#guzhiname_zg_1").combobox('getValue');
	    $('#filepzdg_fundvalue').datagrid({method:'post',url:"ziguan/queryFundsearchFundvalue?"+params}).datagrid('clientPaging'); 
	}
 
 function pz_searchfund_undefined(){
	    var params="guzhizt_sort="+$("#guzhizt_sort").combobox('getValue');
	    $('#filepzdg_fund_undefined').datagrid({method:'post',url:"ziguan/queryFundsearchFundUndefined?"+params}).datagrid('clientPaging'); 
	}

 function pz_searchfundtotalvalue(){
	    var params="guzhiname="+$("#guzhiname_zg").combobox('getValue');
	    $('#filepzdg_fundtotalvalue').datagrid({method:'post',url:"ziguan/queryFundsearchFundtotalvalue?"+params}).datagrid('clientPaging'); 
	}


 
 function pz_searchdetaildefaultvalue(){
	 $('#filepzdg_workdetail').datagrid({url:"<%=cp%>/ziguan/queryFundSearchWorkDetaildefaultvalue"}); 
}
 
 function pz_adddata(){
	 $('#hdpz_adddetail').dialog('open');
 }
 
 function pz_addsortdata(){
	 $('#hdpz_addsort').dialog('open');
 }
 
 function pz_editsortdata(){
	 	if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var row = $("#filepzdg_worksort").datagrid('getSelected');
			$("#xuhao").textbox('setValue',row.xuhao.trim());
			$("#cname").textbox('setValue',row.cname.trim());
			$("#quanzhong").textbox('setValue',row.qz);
			$("#opid").textbox('setValue',row.id);
			id = row.id;
			$('#hdpz_addsort').dialog('open');
	 	}
	 }
 
 function pz_editdetaildata(){
	 	if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
			var row = $("#filepzdg_workdetail").datagrid('getSelected');
			$("#description").textbox('setValue',row.description.trim());
			$("#is_auto").combobox('setValue',row.is_auto.trim());
			$("#fund_sort_id").combobox('setValue',row.xuhao);
			$("#zhi").textbox('setValue',row.zhi);
			$("#level_id").textbox('setValue',row.level_id);
			$("#opid").textbox('setValue',row.id);
			id = row.id;
			$('#hdpz_adddetail').dialog('open');
	 	}
	 } 
 function pz_adddetaildefaultvalue(){
	 $('#hdpz_adddetaildefaultvalue').dialog('open');
 }
 
 function pz_addfundsort(){
	 $('#hdpz_fundsort').dialog('open');
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

<div title="指标类型维护" style="padding: 5px">
	  <div style ="height:15px;">
	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_addsortdata()">新增</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchsort()">查询</a> 
	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dr_removesortdata_1()">删除</a> 
	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_editsortdata_1()">修改</a> 
      </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_worksort"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="xuhao" width="100" sortable="true">类型序号</th>
						<th field="cname" width="150"  sortable="true">类别名称</th>
						<!-- <th field="qz" width="100"  sortable="true">权重</th> -->
						<th field="show" width="100"  sortable="true">是否显示</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 <div title="指标信息维护" style="padding: 5px">
	  <div style ="height:15px;">
	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddata()">新增</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchdetail()">查询</a> 
 	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dr_removedetaildata_1()">删除</a>
 	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_editdetaildata_1()">修改</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_workdetail"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="80" sortable="true">序号</th>
						<th field="description" width="500"  sortable="true">指标描述</th>
						<th field="is_auto" width="80"  sortable="true">是否为自动计算项目</th>
						<th field="level_id" width="80"  sortable="true">类型编号</th>
						<th field="xuhao" width="80"  sortable="true">所属分类</th>
						<!-- <th field="zhi" width="80"  sortable="true">指标分值</th> -->
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
   <div title="设定产品分类" style="padding: 5px">
	  <div style ="height:15px;">
	    <span>估值人员:</span> 
			<input class="easyui-combobox" name="guzhiname_zg_2" id="guzhiname_zg_2"> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchproductset()">查询</a> 
 	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_addfundsort()">新增</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_fundsort"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="50" sortable="true">序号</th>
						<th field="sort" width="60" sortable="true">产品类型</th>
						<th field="c_port_code" width="60" sortable="true">帐套号</th>
						<th field="c_port_name" width="300" sortable="true">产品名称</th>
						<th field="d_establish" width="100"  sortable="true">成立时间</th>
						<th field="username" width="80"  sortable="true">估值人员</th>
						<th field="sj" width="80"  sortable="true">数据</th>
						<th field="dz" width="80"  sortable="true">对账</th>
						<th field="tz" width="80"  sortable="true">投资</th>
						<th field="xp" width="80"  sortable="true">信批</th>
						<th field="qt" width="80"  sortable="true">其他</th>
						<th field="addtime" width="100"  sortable="true">新增</th>
						<th field="updatetime" width="100"  sortable="true">修改</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
    <div title="查询产品分值" style="padding: 5px">
	  <div style ="height:15px;">
	    <span>估值人员:</span> 
			<input class="easyui-combobox" name="guzhiname_zg_1" id="guzhiname_zg_1"> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchfundvalue()">查询分值</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_fundvalue"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="50" sortable="true">序号</th>
						<th field="sort" width="60" sortable="true">产品类型</th>
						<th field="c_port_code" width="60" sortable="true">帐套号</th>
						<th field="c_port_name" width="300" sortable="true">产品名称</th>
						<th field="d_establish" width="100"  sortable="true">成立时间</th>
						<th field="status" width="100"  sortable="true">状态</th>
						<th field="username" width="80"  sortable="true">估值人员</th>
						<th field="sj" width="80"  sortable="true">数据</th>
						<th field="dz" width="80"  sortable="true">对账</th>
						<th field="tz" width="80"  sortable="true">投资</th>
						<th field="xp" width="80"  sortable="true">信批</th>
						<th field="qt" width="80"  sortable="true">其他</th>
						<th field="totalvalue" width="80"  sortable="true">合计</th>
						<th field="addtime" width="100"  sortable="true">新增</th>
						<th field="updatetime" width="100"  sortable="true">修改</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
     <div title="查询未定义产品" style="padding: 5px">
	  <div style ="height:15px;">
	    <span>账套类型:</span> 
			<input class="easyui-combobox" name="guzhizt_sort" id="guzhizt_sort"> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchfund_undefined()">查询未定义工作量产品</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_fund_undefined"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th field="sort" width="60" sortable="true">产品类型</th>
						<th field="c_port_code" width="60" sortable="true">帐套号</th>
						<th field="c_port_name" width="300" sortable="true">产品名称</th>
						<th field="d_establish" width="100"  sortable="true">成立时间</th>
						<th field="status" width="100"  sortable="true">状态</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 
     <div title="统计工作量" style="padding: 5px">
	  <div style ="height:15px;">
	    <span>估值人员:</span> 
			<input class="easyui-combobox" name="guzhiname_zg" id="guzhiname_zg"> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchfundtotalvalue()">统计分值</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_fundtotalvalue"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th field="username" width="80"  sortable="true">估值人员</th>
						<th field="sort" width="60" sortable="true">产品类型</th>
						<th field="shu" width="60" sortable="true">产品数</th>
						<th field="sj" width="80"  sortable="true">数据</th>
						<th field="dz" width="80"  sortable="true">对账</th>
						<th field="tz" width="80"  sortable="true">投资</th>
						<th field="xp" width="80"  sortable="true">信批</th>
						<th field="qt" width="80"  sortable="true">其他</th>
						<th field="avgvalue" width="80"  sortable="true">平均</th>
						<th field="totalvalue" width="80"  sortable="true">合计</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 	<div title="上传产品分类" style="padding: 5px">
	  <div style ="height:15px;">
	  <div style ="float:left">
		  <form id="uploadfile" style="float:left" enctype="multipart/form-data">
			<input type="file" name="file"id ="fi"> 
			<input type="button" value="导入文件"   onclick="upfile()"/> 
          <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dr_signdataCheck()">删除</a> 
		  </form>
 	  </div>
	  <br /><br />
	  
	  </div>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_upload"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false
				               ">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="username" width="80"  sortable="true">估值人员</th>
						<th field="zhaiyao" width="500" sortable="true">财务摘要</th>
						<th field="jine" width="120"  sortable="true">财务金额</th>
						<th field="yue" width="120"  sortable="true">余额</th>
						<th field="rq" width="100"  sortable="true">收到时间</th>
						<th field="n_money" width="120"  sortable="true">估值金额</th>
						<th field="c_port_code" width="100"  sortable="true">估值代码</th>
						<th field="c_port_name" width="300"  sortable="true">估值名称</th>
						<th field=rq1 width="100"  sortable="true">估值日期</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 
 <!-- 
  <div title="投资类型维护" style="padding: 5px">
	  <div style ="height:15px;">
	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_addtouzi()">新增</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchtouzi()">查询</a> 
 	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="dr_removetouzi()">删除</a>
 	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="pz_edittouzi()">修改</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_work_touzi"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="100" sortable="true">序号</th>
						<th field="tz_leixing" width="300"  sortable="true">投资类型</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
  <div title="设置指标默认值" style="padding: 5px">
	  <div style ="height:15px;">
	    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="pz_adddetaildefaultvalue()">新增</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchdetailvalue()">查询</a> 
 	  </div>
 	  <br>
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_workdetaildefaultvalue"  
				data-options="selectOnCheck:true,checkOnSelect:false,rownumbers:true,checkOnSelect:false,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="100" sortable="true">序号</th>
						<th field="cname" width="300"  sortable="true">类别名称</th>
						<th field="detail_name" width="300"  sortable="true">估值频率</th>
						<th field="tz_leixing" width="300"  sortable="true">投资类型</th>
						<th field="default_value" width="200"  sortable="true">默认值</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 
	<div title="工作量计算" style="padding: 5px">
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
		 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="dr_signdata()">开始计算</a> 
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="pz_searchworktimelist()">查询</a> 


 	  </div>
	  <br /><br />
	  <div style="margin-top: 10px;">
			<table  id="filepzdg_worktimelist"  
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,checkOnSelect:true,selectOnCheck:true,
								              singleSelect:false,autoRowHeight:false,pagination:true,pageSize:500,showFooter:true,remoteSort:false
				               ">
				<thead>
					<tr>
						<th field="username" width="120"  sortable="true">估值人员名称</th>
						<th field="num" width="100"  sortable="true">产品数量</th>
						<th field="worktime" width="100"  sortable="true">每日时间</th>
						<th field="totaltime" width="100"  sortable="true">总时间</th>
					</tr>
				</thead>
			</table>
		</div>
 </div>
 
 </div>
  -->


<div id="hdpz_addsort" class="easyui-dialog" closed="true" title="添加/修改指标类型"
			style="width: 450px; height: 250px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
		  	<span>类型序号:</span>
				<input  style="width:150px;height:25px;" type="text" class="easyui-textbox"  name="xuhao" id="xuhao" />
			 <span style="color: red;">*</span>
			<br></br>	
			
			<span >类型名称:</span> 
			<span> 
             <input  style="width:150px;height:25px;" type="text" class="easyui-textbox"  name="cname" id="cname" />
			</span> <span style="color: red;">*</span>
			<br></br>	
			
			<span >权 重 值:</span> 
			<span> 
             <input  style="width:150px;height:25px;" type="text" class="easyui-textbox"  name="quanzhong" id="quanzhong" />
			</span><span style="color: red;">*</span>
			<input type="hidden" class="easyui-numberbox" id="opid" name="opid">
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensuresort()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
<div id="hdpz_adddetail" class="easyui-dialog" closed="true" title="添加/修改产品指标参数"
			style="width: 550px; height: 350px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			
			<span >指标名称:</span> 
			<span> 
              <input  style="width:350px;height:25px;" type="text" class="easyui-textbox"  name="description" id="description" />
			</span> 
			<span style="color: red;">*</span>
<br></br>	
			<span >是否自动:</span> 
			<span> 
             <select id="is_auto" class="easyui-combobox" name="is_auto" style="width:50px;">
                <option value="否">否</option>
                <option value="是">是</option>
             </select>
             <span style="color: red;">*</span>
             <input type="hidden" class="easyui-numberbox" id="opid" name="opid">
			</span> 
			<br></br>
			<span >类型编码:</span> 
			<span> 
              <input  style="width:150px;height:25px;" type="text" class="easyui-textbox"  name="level_id" id="level_id" />
			</span> 
			<span style="color: red;">*</span>
           <br></br>	
			<span >选择类型:</span> 
			<span> 
              <span> 
				<input class="easyui-combobox" name="fund_sort_id" id="fund_sort_id"
										data-options="
							                      valueField: 'value',
												  textField: 'text',
												  mode:'local',
												  url:'<%=cp%>/ziguan/getworksort',
						                          method:'post',
												  multiple:false,
												  width:150,
												  filter: function(q, row){
															var opts = $(this).combobox('options');
															return row[opts.textField].indexOf(q) >-1;
														},
										         onLoadSuccess:function(){
													 $('fund_sort').next('.combo').find('input').focus(function (){
													            $('fund_sort').combobox('clear');
													 });
											     }
									  ">
					</span> <span style="color: red;">*</span>	
			</span> 
			
           <br></br>	
			<span >指    标    值:</span> 
			<span> 
              <input  style="width:150px;height:25px;" type="text" class="easyui-textbox"  name="zhi" id="zhi" />
			</span> 
			<span style="color: red;">*</span>
           <br></br>	
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensuredetailTarget()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>		
<div id="hdpz_adddetaildefaultvalue" class="easyui-dialog" closed="true" title="添加指标默认值"
			style="width: 450px; height: 250px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span>选择类型:</span>
			<span> 
				<input class="easyui-combobox" name="fund_sort" id="fund_sort"
										data-options="
							                      valueField: 'value',
												  textField: 'text',
												  mode:'local',
												  url:'<%=cp%>/ziguan/getworksort',
						                          method:'post',
												  multiple:false,
												  width:250,
												  filter: function(q, row){
															var opts = $(this).combobox('options');
															return row[opts.textField].indexOf(q) >-1;
														},
										         onLoadSuccess:function(){
													 $('fund_sort').next('.combo').find('input').focus(function (){
													            $('fund_sort').combobox('clear');
													 });
											     }
									  ">
					</span> <span style="color: red;">*</span>
			<br></br>
			<span >选择频率:</span> 	
			<input class="easyui-combobox" name="fund_detail" id="fund_detail"
													data-options="
										                      valueField: 'value',
															  textField: 'text',
															  mode:'local',
															  url:'<%=cp%>/ziguan/getworkdetail',
									                          method:'post',
															  multiple:false,
															  width:250,
															  filter: function(q, row){
																		var opts = $(this).combobox('options');
																		return row[opts.textField].indexOf(q) >-1;
																	},
													         onLoadSuccess:function(){
																 $('fund_detail').next('.combo').find('input').focus(function (){
																            $('fund_detail').combobox('clear');
																 });
														     }
												  ">
								</span> <span style="color: red;">*</span>			
			<br></br>
			<span >选择投资:</span> 	
			<input class="easyui-combobox" name="fund_touzi" id="fund_touzi"
													data-options="
										                      valueField: 'value',
															  textField: 'text',
															  mode:'local',
															  url:'<%=cp%>/ziguan/getworktouzi',
									                          method:'post',
															  multiple:false,
															  width:250,
															  filter: function(q, row){
																		var opts = $(this).combobox('options');
																		return row[opts.textField].indexOf(q) >-1;
																	},
													         onLoadSuccess:function(){
																 $('fund_detail').next('.combo').find('input').focus(function (){
																            $('fund_detail').combobox('clear');
																 });
														     }
												  ">
								</span> <span style="color: red;">*</span>			
			<br></br>
			<span >默认数值:</span> 	
			<span> 
             <input type="text" class="easyui-numberbox" id="zhi" name="zhi" data-options="min:0,precision:4" >
			</span> 
			<span style="color: red;">*</span>
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensuredetaildefaultvalue()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

<div id="hdpz_fundsort" class="easyui-dialog" closed="true" title="设定产品分类"
			style="width: 550px; height: 450px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
					
			<span >产品名称:</span> 
			<span> 
				<input class="easyui-combobox" name="jzzx_fundcode" id="jzzx_fundcode"
										data-options="
							                      valueField: 'value',
												  textField: 'text',
												  mode:'local',
												  url:'<%=cp%>/ziguan/getWorkProductID',
						                          method:'post',
												  multiple:false,
												  width:350,
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
			<br></br>
			<span >数据处理:</span> 
			<span> 第
             <select id="F1" class="easyui-combobox" name="F1" style="width:50px;">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
             </select>档
             <span style="color: red;">*</span>
             <br></br>
             
			<span >对账情况:</span> 
			<span> 第
             <select id="F2" class="easyui-combobox" name="F2" style="width:50px;">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
             </select>档
             <span style="color: red;">*</span>
             <br></br>

			<span >投资类型:</span> 
			<span> 第
             <select id="F3" class="easyui-combobox" name="F3" style="width:50px;">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
             </select>档
             <span style="color: red;">*</span>
             <br></br>
					
			<span>信息披露:</span> 
			<span> 第
             <select id="F4" class="easyui-combobox" name="F4" style="width:50px;">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
             </select>档
             <span style="color: red;">*</span>
             <br></br>
             
           <span >其他工作:</span> 
			<span> 第
             <select id="F5" class="easyui-combobox" name="F5" style="width:50px;">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
             </select>档
             <span style="color: red;">*</span>
             <br></br>
             
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="pz_ensurefundsort()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

</body>



