<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>基金账套维护</title>
</head>
<!-- 初始化操作 ,一般来讲初始化操作都是用来初始化表和用来绑定下拉列表框的-->
<script type="text/javascript">
$(function (){
	   
        $("#dgl").datagrid({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-140
		 });
		 $("#dgl1").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-160)
		 });
		 $("#dgl2").datagrid({
		 	 width : '100%',
		 	 height : (document.documentElement.clientHeight-160)
		 });	
	 
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
	 //此段代码是绑定下拉列表框用的,绑定tab2的产品名称的下拉列表框
	 $("#c_cp_name1").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getCPname',
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
	  
	 //绑定增加框的下拉列表框
	  $("#c_cp_name_add").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/getCPname2',
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
//绑定交易机构的
$("#c_trade_jg_add").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'',text:'--请选择交易机构--'},{value:'申万',text:'申万'},{value:'宏源',text:'宏源'},{value:'其他',text:'其他'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
			   
		     }
	  });
//绑定柜台资金账号类型
$("#gt_zj_zh_lx_add").combobox({
              valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'',text:'--请选择资金账号类型--'},{value:'1',text:'普通柜台'},{value:'2',text:'融资融券柜台'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
			   
		     }
	  });
	  
	  
	      //估值人员
      $("#userInfo").combobox({
            valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=02',
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

	   
});

//关于日期的二级联动
	function changetime() {
		//1.先获取 newdate 的日期
		var ndate = $("#wbdate").datebox("getValue");
		var a = new Date(ndate.replace(/\-/g, "\/"));
//得到第一个日期，它有onSelect属性，可以触发第二个日期
		var mailsdate = a.getFullYear() + "-";
		mailsdate += a.getMonth() + 1 + "-";
		mailsdate += a.getDate();

		$("#wbdate2").datebox({
		//给第二个日期设置值（将第一个日期放进去）
			value : mailsdate,
			required : true
		});

		
	}

</script>
 <!-- 自定义js -->
 <script type="text/javascript">
 
 //第一个tab1页的查询 
 function searchdata(){  
      $('#dg').datagrid({method:'post',url:"guzhidz/getQuerySY",
    	                     queryParams:{c_cp_name:$("#c_cp_name").combobox('getValue'),
		   	  }}).datagrid('clientPaging'); 
      $('#c_cp_name').combobox('clear','c_cp_name');

 }
 
 //第二个tab页面的查询
 function searchdata2(){
 		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		
 //var params="c_occur_date="+$("#c_occur_date").datebox('getValue')
 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		var edate = $("#wbdate2").datebox('getValue');
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		    
 		
 		var params = {c_cp_name:$("#c_cp_name1").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue')};
 		
        if($("#userInfo").combobox('getValue')!=""){
          
            var params = {userInfo:$("#userInfo").combobox('getValue'),c_cp_name:$("#c_cp_name1").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue')};
        	//params +="&userInfo="+$("#userInfo").combobox('getValue');
        }
 		//alert(params.c_cp_name +":hhh:" + params.wbdate);
 
      
      $('#dg2').datagrid({method:'post',url:"guzhidz/getQuerySY2",queryParams:params}).datagrid('clientPaging'); 
 }
 //第一个页面的修改
 function editdata(){
 	
 	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	} else {

		var c_tzh_25 = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").find(
						"td[field='c_tzh_25']");
		var c_tzh_45 = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").closest(
						"tr").find("td[field='c_tzh_45']");
		var c_trade_jg = $("div[class='tabs-panels']").find("div[class='panel']")
		.eq(0).find("input[name='ck']:checked").closest("tr").closest(
		"tr").find("td[field='c_trade_jg']");
		
		var gt_zj_zh = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").closest(
						"tr").find("td[field='gt_zj_zh']");
		var gt_zj_zh_lx = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").closest(
						"tr").find("td[field='gt_zj_zh_lx']");
		var rzrq_gth = $("div[class='tabs-panels']").find("div[class='panel']")
		.eq(0).find("input[name='ck']:checked").closest("tr").closest(
				"tr").find("td[field='rzrq_gth']");
		
		c_tzh_25.find("div").html(
				"<input type='text' value='" + c_tzh_25.find("div").text()
						+ "'></input>");
		/* c_tzh_45.find("div").html(
				"<input type='text' value='" + c_tzh_45.find("div").text()
						+ "'></input>"); */
		gt_zj_zh.find("div").html(
				"<input type='text' value='" + gt_zj_zh.find("div").text()
						+ "'></input>");
		rzrq_gth.find("div").html(
				"<input type='text' value='" + rzrq_gth.find("div").text()
						+ "'></input>");
		//前台下拉列表框的显示
		var c_trade_jg_1 = c_trade_jg.find("div").text();
		
		if (c_trade_jg_1 == "申万"){
			c_trade_jg.find("div").html(
			"<select id='selector'><option value='申万' selected>申万</option><option value='宏源'>宏源</option><option value='其他'>其他</option></select>");
		} else if (c_trade_jg_1 == "宏源"){
			c_trade_jg.find("div").html(
			"<select id='selector'><option value='申万'>申万</option><option value='宏源' selected>宏源</option><option value='其他'>其他</option></select>");
		} else {
			c_trade_jg.find("div").html(
			"<select id='selector'><option value='申万'>申万</option><option value='宏源'>宏源</option><option value='其他' selected>其他</option></select>");
		}
		
		//柜台资金账号类型
		var gt_zj_zh_lx_1 = gt_zj_zh_lx.find("div").text();
		
		if (gt_zj_zh_lx_1 == "普通柜台"){
			gt_zj_zh_lx.find("div").html(
			"<select id='selector_1'><option value='1' selected>普通柜台</option><option value='2'>融资融券柜台</option></select>");
		} else if (gt_zj_zh_lx_1 == "融资融券柜台"){
			gt_zj_zh_lx.find("div").html(
			"<select id='selector_1'><option value='1'>普通柜台</option><option value='2' selected>融资融券柜台</option></select>");
		} else {
			gt_zj_zh_lx.find("div").html(
			"<select id='selector_1'><option value='1' selected>普通柜台</option><option value='2'>融资融券柜台</option></select>");
		}
		
		
		$("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
				"itable[class='datagrid-htable']").find("td[field='ck']").find(
				"input").prop("disabled", true);

		$("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
				"input[name='ck']").prop("disabled", true);

	}
 	
 }

 // 保存
 function savedata(){
	 if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要修改的数据");
		return false;
	 }
 	var obj = $("div[class='tabs-panels']").find("div[class='panel']").eq(0)
			.find("input[name='ck']:checked");

	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length == 1) {

		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(0)
				.find("input[name='ck']:checked").val();

						
		var c_tzh_45 = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").find(
						"td[field='c_tzh_45']").find("input").val();
						
		var gt_zj_zh = $("div[class='tabs-panels']").find("div[class='panel']")
				.eq(0).find("input[name='ck']:checked").closest("tr").find(
						"td[field='gt_zj_zh']").find("input").val();
		var rzrq_gth = $("div[class='tabs-panels']").find("div[class='panel']")
		.eq(0).find("input[name='ck']:checked").closest("tr").find(
				"td[field='rzrq_gth']").find("input").val();
						
		var c_trade_jg = $("#selector").val();
		
		var gt_zj_zh_lx = $("#selector_1").val();
		
		if(typeof(c_trade_jg)=="undefined"){
			alert("请点击修改按钮！");
			return false;
		}
		else if (c_tzh_45 == "" || gt_zj_zh == "") {
			alert("柜台资金账号不能为空！");
			return false;
		} else {
			$.ajax({
				type : "POST",
				//前后都可以没有'/'
				url : "guzhidz/updatePage1",
				data : {
				//第一个id是指必须和后台页面的值一样，即在后台中获取前台的值就是第一个id,它作为key,第二个参数id是指 var 中的值
					id : id,
					c_tzh_45 : c_tzh_45,
					gt_zj_zh : gt_zj_zh,
					c_trade_jg : c_trade_jg,
					rzrq_gth : rzrq_gth
				},
				dataType : "json",
				success : function(data) {
					if (data.msg == "success") {
						alert("修改成功");
						$('#c_cp_name').combobox('reload');
	        	   		$('#c_cp_name1').combobox('reload'); 
	        	   		$('#c_cp_name_add').combobox('reload'); 
						searchdata();
					} else {
						alert("修改失败");
					}
				},
				error : function() {
					alert("系统异常，修改失败");
				}
			});
		}
	}
 	
 }
 
 //删除
 function removedata(){
 	if ($("div[class='tabs-panels']").find("div[class='panel']").eq(0).find(
			"input[name='ck']:checked").length != 1) {
		alert("请选择1条要删除的数据");
		return false;
	}else{
		var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(0)
				.find("input[name='ck']:checked").val();
		if(id==-1){
			alert("此条数据为自动匹配数据，不需删除");
 			return false;
		}else{
			$.ajax({ 
 		        type: "POST", 
 		        url: "guzhidz/deletePage1", 
 		        data: {id:id}, 
 		        dataType: "json", 
 		        success: function(data) {
 		        	if(data.msg=="success"){
 		        	   alert("删除成功");
 		        	   $('#c_cp_name').combobox('reload');
	        	   	   $('#c_cp_name1').combobox('reload');
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
 }
 
  function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:bleak;';
		}
 }

//第一个页面增加的保存代码
 function adddata(){
	
	 var c_cp_name_add = $("#c_cp_name_add").combobox('getValue');
		if (c_cp_name_add == null || c_cp_name_add == "") {
			alert("请选择产品名称");
			return false;
		}
		var c_trade_jg_add = $("#c_trade_jg_add").combobox('getValue');
		if (c_trade_jg_add == null || c_trade_jg_add == "") {
			alert("请选择交易机构");
			return false;
		}
		var rzrq_gth_add = $("#rzrq_gth_add").numberbox('getValue');
		if (rzrq_gth_add == null || rzrq_gth_add == "") {
			alert("请填写融资融券柜台号 ");
			return false;
		}
		var gt_zj_zh_add = $("#gt_zj_zh_add").numberbox('getValue');
		if (gt_zj_zh_add == null || gt_zj_zh_add == "") {
			alert("请填写普通柜台号 ");
			return false;
		}
		
		/* var gt_zj_zh_lx_add = $("#gt_zj_zh_lx_add").combobox('getValue');
		if (gt_zj_zh_lx_add == null || gt_zj_zh_lx_add == "") {
			alert("请填写柜台资金账号类型");
			return false;
		} */
		
	
	 var zth = $("#c_cp_name_add").combobox('getText');
	 var c_trade_jg = $("#c_trade_jg_add").combobox('getValue');
	 var gt_zj_zh = $("#gt_zj_zh_add").textbox('getValue');
	 var c_tzh_45= zth.substring(0,zth.indexOf("-"));
	 //var c_cp_name = $("#c_cp_name_add").combobox('getValue');
	 var c_cp_name = zth.substring(zth.indexOf("-")+1,zth.length);
	 //var gt_zj_zh_lx = $("#gt_zj_zh_lx_add").combobox('getValue');
	 var rzrq_gth = $("#rzrq_gth_add").textbox('getValue');
	 
	 $.ajax({ 
	        type: "POST", 
	        url: "guzhidz/addPage1", 
	        data: {c_cp_name:c_cp_name,c_trade_jg:c_trade_jg,gt_zj_zh:gt_zj_zh,c_tzh_45:c_tzh_45,rzrq_gth:rzrq_gth}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   closeDialog();
	        	   $('#c_cp_name').combobox('reload');
	        	   $('#c_cp_name1').combobox('reload');   
	        	   $('#c_cp_name_add').combobox('reload'); 
	        	   alert("操作成功");
	        	   searchdata();
	        	   
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
	 $('#dlg').dialog('close');
	 
 }
 function clears(){
	 $('#c_cp_name_add').combobox('clear','c_cp_name_add');
	 $('#c_trade_jg_add').combobox('clear', 'c_trade_jg_add');
	 $('#gt_zj_zh_add').numberbox('clear', 'gt_zj_zh_add');
	 $('#gt_zj_zh_lx_add').combobox('clear', 'gt_zj_zh_lx_add');
	 $('#rzrq_gth_add').numberbox('clear', 'rzrq_gth_add');
	 
 }
 
 function exportDBF() {
	
	jQuery.download = function(url, data, method){
	    // 获得url和data
	    if( url && data ){ 
	        // data 是 string 或者 array/object
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 把参数组装成 form的 input
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request发送请求
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
	
		var wbdate = $("#wbdate").datebox('getValue');

		if (wbdate == null || wbdate == "") {

			alert("请选择日期！");

			return;
		}
		
		 //获取开始日期
 		var sdate = $("#wbdate").datebox('getValue');
 		//获取结束日期
 		var edate = $("#wbdate2").datebox('getValue');
 		
 		if (edate < sdate){
 		
 			alert("结束日期不能小于开始日期");
 			
 			return;
 		}
 		
 		var params = {c_cp_name:$("#c_cp_name1").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue')};
 		 if($("#userInfo").combobox('getValue')!=""){
          
            var params = {userInfo:$("#userInfo").combobox('getValue'),c_cp_name:$("#c_cp_name1").combobox('getValue'),wbdate:$("#wbdate").datebox('getValue'),wbdate2:$("#wbdate2").datebox('getValue')};
        	//params +="&userInfo="+$("#userInfo").combobox('getValue');
        }		
		$.download('guzhidz/downloadsjxxx',params,'post');
		
};
 
 
 </script>
  <!-- 自定义js -->
<script type="text/javascript">
function zgbfjsearchdata(){
	<%-- if($("#d_ywrq").datebox("getValue")==""){
		alert("请选择日期起！");
		return false;
	}else{
   		var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&wb_ztmc="+$("#wb_zth").combobox('getText')+
   		"&d_ywrq="+$("#d_ywrq").datebox('getValue')+"&userInfo="+$("#userInfo").combobox('getValue')+"&tgiseql="+$("#tgiseql").combobox('getValue')+
   		"&wbiseql="+$("#wbiseql").combobox('getValue')+"&d_ywrq_end="+$("#d_ywrq_end").datebox('getValue');
		$('#dgl').datagrid({method:'get',
			               url:"<%=cp%>/zgbfj/getnewJingZhiInfo?"+params,
			               onLoadSuccess:function(data){
			            	     if(data.rows.length>0){
				            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
	 			            	        $("#noteqlNum").html("不一致总数:<span style='color:red;'>"+data.rows[0].noteqlnum+"</span>");
				            	     }
			            	     }else{
			            	    	 $("#noteqlNum").html("");
			            	     }
			            		
			               }
			              }).datagrid('clientPaging'); 
		
	
	} --%>
	  var str =$("#d_ywrq").combobox('getValue');
	  var strs =$("#d_ywrq_end").combobox('getValue');
	  strs=strs.replace(/-/g,'');
	  str=str.replace(/-/g,'');
	  if(str=="" ){
		  alert("请选择日期起！");
		  return false;
	  }else{
	  	if(strs==""){
	  	strs=str;
	  	}
	  	if(str>strs){
	  		alert("请正确选择日期区间！");
		 	return false;
	  	}else{
	  	
	        var params="d_ywrq="+str.replace(/-/g,'') + "&d_ywrq_end=" + strs+"&tgiseql="+$("#tgiseql").combobox('getValue')+"&wbiseql="+$("#wbiseql").combobox('getValue');
	        if($("#wb_zth").combobox('getValue')!=""){
	        	params +="&wb_zth="+$("#wb_zth").combobox('getValue');
	        }
	        $('#dgl').datagrid({method:'get',
	        	               url:"zgbfj/getbfjgtInfo?"+params,
	        	                onLoadSuccess:function(data){
				            	     if(data.rows.length>0){
					            	     if(typeof(data.rows[0].noteqlnum)!="undefined"){
		 			            	        $("#noteqlNum").html("<span style='font-size:8px;'>普通柜台科目不一致总数:</span><span style='color:red;font-size:8px'>"+data.rows[0].sumbd +"</span>"+
		 			            	        "<span style='font-size:8px;'>融资融券科目不一致总数</span><span style='color:red; font-size:8px;'>"+data.rows[0].noteqlnum+"</span>");
		 			            	        
					            	     }
					            	      
				            	     }else{
				            	    	 $("#noteqlNum").html("<span style='font-size:8px;'>普通柜台科目不一致总数:</span><span style='color:red; font-size:8px;'>"+0+"</span>"+
				            	    	 "<span style='font-size:8px;'>融资融券科目不一致总数:</span><span style='color:red; font-size:8px;'>"+0+"</span>");
				            	     }
				            	}	
					           }).datagrid('clientPaging'); 
		  	}
			
	  }
}

function queryZTKMInfo(gth,biz_dt,rzrq_gth){
	$("#tabsidk").tabs('select', "证券/资金明细");
	var params="gth="+gth+"&biz_dt="+biz_dt+"&rzrq_gth="+rzrq_gth;
	$('#dgl1').datagrid({method:'get',url:"<%=cp%>/zgbfj/queryZQMX?"+params}).datagrid('clientPaging'); 
	$('#dgl2').datagrid({method:'get',url:"<%=cp%>/zgbfj/queryZJMX?"+params}).datagrid('clientPaging'); 
}
    
</script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="基金账号维护" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<span> 
			 	<input class="easyui-combobox" name="c_cp_name"
						id="c_cp_name"
						data-options="
						                      valueField: 'value',
											  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/getCPname',
					                          method:'post',
											  multiple:false,
											  width:150,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) > -1;
													}
				">
			</span>
<!-- 		   <span style="color: red;">*</span> -->
<!-- 		   <span style="margin-left: 15px;">日期</span>  	 -->
<!-- 		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px"></input></span> -->
<!-- 		   <span style="color: red;">*</span> -->
					<span>&nbsp&nbsp&nbsp</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editdata()">修改</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savedata()">保存</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="$('#dlg').dialog('open'),clears()">新增</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removedata()">删除</a>
<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveAllData()">批量保存</a> -->
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                         <th field="id" width="80px" name="id" id="id">序号</th> -->
<!--                         <th field="c_tzh_25" width="150px" id="c_tzh_25" name="c_tzh_25">2.5套帐号</th> -->
						<th field="c_tzh_45" width="150px"  id="c_tzh_45" name="c_tzh_45">账套号</th>
						<th field="c_cp_name" width="150px" id="c_cp_name">产品名称</th>
						<th field="c_trade_jg" width="150px" id="c_trade_jg">交易机构</th>
						<th field="gt_zj_zh" width="150px" id="gt_zj_zh">柜台资金账号</th>
						<th field="rzrq_gth" width="150px" id="rzrq_gth">融资融券柜台资金账号</th>
<!-- 						<th field="c_version" width="80px"  data-options="align:'right'">版本</th> -->
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div title="备付金与柜台核对信息" style="padding: 5px">
		<div style="margin-top: 5px; margin-bottom: 5px;">
			<span>基金名称:</span> <input class="easyui-combobox" name="wb_zth"
				id="wb_zth"
				data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/ZGBFJ/queryGWDSelectVal?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:200,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
									 onLoadSuccess: function(){
										 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									     });
								     }
									 ">
		   	 <span style="margin-left: 16px"  >日期起</span>  	
		     <span><input id="d_ywrq" name="d_ywrq" class="easyui-datebox" style="width: 150px" data-options="editable:false";></input></span>
		     <span style="color: red;">*</span>
		     <span style="margin-left: 16px" >日期止</span>  	
		     <span><input id="d_ywrq_end" name="d_ywrq_end" class="easyui-datebox" style="width: 150px" data-options="editable:false";></input></span>
		     <!-- <span style="color: red;">*</span> -->
			 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="zgbfjsearchdata()">查询</a> <br></br>
			<!-- <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
			 <br/>
			  <span>估值人员:</span>
			 <input class="easyui-combobox" name="userInfo" id="userInfo">-->
			 
			 <span>普通柜台科目余额一致:</span>
			 <span>
				<select id="tgiseql" class="easyui-combobox" name="tgiseql" style="width: 130px;">
					<option value="5">--请选择--</option>
					<option value="tg_eql">普通柜台一致</option>
					<option value="tg_noteql">普通柜台不一致</option>
				</select>
			 </span>
			 &nbsp;
			 <span>融资融券柜台科目余额一致:</span>
			 <span>
				<select id="wbiseql" class="easyui-combobox" name="wbiseql" style="width: 150px;">
					<option value="6">--请选择--</option>
					<option value="wb_eql">融资融券一致</option>
					<option value="wb_noteql">融资融券不一致</option>
				</select>
			 </span>
			  <span id='noteqlNum' style="font-size:20px;float: right;"></span>
		</div>
		<div style="margin-top: 10px;">
		   
			<table id="dgl" style="width: 770px; height: 480px"
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<!-- <tr>
					    <th field="noteqlnum" width="150" data-options="hidden:true"></th>
					    <th field="rq" width="150">日期</th>
					    <th field="zt_code" width="150">帐套号</th>
						<th field="zt_name" width="150">帐套名称</th>
					    <th field="pt_gtname" width="70">普通柜台</th>
					    <th field="rzrj_gtname" width="70">融资融券柜台</th>
						<th field="zc_code" width="100">资产账号</th>
						<th field="gzye" width="100" >估值系统 科目余额</th>
						<th field="taye" width="100" >柜台系统科目余额</th>
						<th field="zthye" width="100">差额</th> 
						<th field="gw_xq" width="100" >详情</th>
					</tr> -->
					<tr>
						<!-- <th width="180px"     rowspan="2" data-options="field:'ck',checkbox:true"></th> -->
                        <th field="rq"    width="90px"     rowspan="2">日期</th>
                        <th field="zt_code"  width="80px"   rowspan="2">帐套号</th>
                        <th field="zt_name"  width="180px"   rowspan="2">帐套名称</th>
                        <th field="zc_code" width="100px" rowspan="2">普通柜台</th>
						<th   colspan="3"  width="200px"  >普通柜台科目余额</th>
                        <th field="rzrq_gth" width="100px" rowspan="2">融资融券柜台</th>
						<th   colspan="3"  width="200px"  >融资融券科目余额</th>
						<th field="gw_xq"    width="180px"     rowspan="2">详情</th>
					</tr>
					<tr>
					  <th field="gzye" width="60px" data-options="align:'right',formatter:myformatter,styler:myCellStyler">估值系统</th>
					  <th field="taye" width="60px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">柜台系统</th>
					  <th field="zthye" width="80px" >差额</th>
					  
					  <th field="gzyexy" width="60px" data-options="align:'right',formatter:myformatter,styler:myCellStyler">估值系统</th>
					  <th field="tayexy" width="60px"  data-options="align:'right',formatter:myformatter,styler:myCellStyler">柜台系统</th>
					  <th field="zthye1" width="80px">差额</th>

				      <th field="sumnoteql" data-options="hidden:true"></th>
                      <th field="sumbd" data-options="hidden:true"></th>
					</tr>
					
				</thead>
			</table>
		</div>
	</div>
	
	<div title="证券/资金明细" style="padding: 5px;">
	
	 <div class="easyui-accordion" style="height:440px;">
	     <div title="资金明细信息" style="overflow:auto;">
					<table id="dgl1" data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
						              pageList:[10,20,50,100]
						              ">
						<thead>
							<tr>
								<th field="dt" width="80">时间</th>
								<th field="cust_no" width="80">柜台资金号</th>
								<th field="cust_name" width="100">基金名称</th>
								<th field="sec_code" width="80">证券代码</th>
								<th field="sec_short_name" width="130">证券名称</th>
								<th field="business_name" width="130">交易行为</th>
								<th field="sec_chg" width="80">证券变动</th>
								<th field="sec_bal" width="80">证券余额</th>
								<th field="fund_chg" width="80">资金变动</th>
								<th field="fund_bal" width="80">资金余额</th>
								<th field="done_amt" width="80">资金发生额</th>
								<!--   
								<th field="currency_type" width="30">货币类型</th>
								<th field="sec_type" width="30">sec_type</th>
								<th field="business_code" width="50">业务编码</th>
								<th field="done_amt" width="50">done_amt</th>
								<th field="flag" width="50">flag</th>
								<th field="branch_name" width="50">交易机构</th>
								<th field="currency_name" width="50">货币名称</th>
								<th field="sec_typt_desc" width="50">sec_typt_desc</th>
								  <th field="occur_date" width="50">时间</th>
								<th field="occur_time" width="50">发生时间</th>
								<th field="serial_no" width="50">serial_no</th>
								<th field="branch_code_1" width="50">branch_code_1</th>
								<th field="holder_acc_no" width="50">holder_acc_no</th>
								-->
							</tr>
						</thead>
					</table>
	   </div>
	  	
	  	 <div title="证券明细信息" style="overflow:auto;">
			<table id="dgl2"  
				data-options="selectOnCheck:false,checkOnSelect:false,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500,
				              ">
				<thead>
					<tr>
						<th field="dt" width="80">时间</th>
						<th field="cust_no" width="80">柜台资金号</th>
						<th field="name" width="100">基金名称</th>
						<th field="market_name" width="100">市场</th>
						<th field="sec_code" width="100">证券代码</th>  
						<th field="sec_short_name" width="100">证券名称</th>
						<th field="pos_qutty" width="100">股份数</th>
						<th field="sec_price" width="100">股票价格</th>
						<th field="mkt_value" width="100">市值</th>
						<!--  <th field="flag" width="100">flag</th>
						<th field="market_code" width="100">市场</th>
						-->
					</tr>
				</thead>
			</table>
		</div>
	</div>
	</div>


   	<div title="数据结息查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<input class="easyui-combobox"
						name="c_cp_name" id="c_cp_name1"
		    >
			<span>估值人员:</span> 
			<input class="easyui-combobox"
						name="userInfo" id="userInfo"
		    >
		   
		   <span style="margin-left: 15px;">开始日期</span>  	
		   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 150px" editable="false" data-options="onSelect:changetime"></input></span>
		   <span style="color: red;">*</span>
		    <span style="margin-left: 15px;">结束日期</span>  	
		   <span><input id="wbdate2" name="wbdate" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;">*</span>
					<span>&nbsp&nbsp&nbsp</span>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="exportDBF()">导出</a>
		  
<!-- 		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveAllData()">批量保存</a> -->
		</div>
		<div style="margin-top: 10px;">
			<table id="dg2" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                    <th field="id" width="80px">序号</th> --> 
                        <th field="trade" width="150px">结息日期</th>
						<th field="code" width="150px">账套号</th>
						<th field="c_cp_name" width="150px">账套名称</th>
						<th field="c_trade_jg" width="150px">交易机构</th>
						<th field="gt_zj_zh" width="150px">柜台资金账号</th>
						<th field="money_acc" width="150px">结息金额</th>
						
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
</body>







<div id="dlg" class="easyui-dialog" closed="true" title="新增基金账套信息"
			style="width: 550px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
<!-- 			<span style="margin-left: 20px">版本号:</span>  -->
			
<!-- 			<span> <input -->
<!-- 			type="text" class="easyui-combobox" id="c_version_add" name="c_version" /> -->
<!-- 			</span> -->
			
			<span style="margin-left: 20px">产品名称:</span>
			<span> 
			<input type="text" class="easyui-combobox" id="c_cp_name_add" name="c_port_name" />
			</span>
			
			<span style="margin-left: 20px">交易机构:</span>
			<span> 
			<input type="text" class="easyui-combobox" id="c_trade_jg_add" name="c_trade_jg" />
			</span>
			<br/><br/>
			<!-- <span style="margin-left: 20px">柜台类型:</span>
			<span> 
				<input type="text" class="easyui-combobox" id="gt_zj_zh_lx_add" name="c_trade_jg" />
			</span> -->
			<span style="margin-left: 20px">融资融券柜台号:</span>
			<span> 
			 	<input type="text" class="easyui-numberbox" id="rzrq_gth_add" name="rzrq_gth">
			</span>
			<br/><br/>
			<span style="margin-left: 20px">普通柜台号:</span>
			<span> 
			 	<input type="text" class="easyui-numberbox" id="gt_zj_zh_add" name="c_gt_zj_zh">
			</span>
			<br/><br/>
<!-- 			<span id="zmm">  -->
<!-- 			<span style="margin-left: 25px">4.5账套号:</span> -->
<!-- 			<span>  -->
<!-- 			 	<input type="text" class="easyui-textbox" id="c_tzh_45_add" name="c_tzh_45"> -->
<!-- 			</span> -->
<!-- 			</span> -->
			
		</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton"
		onclick="adddata()">保存</a> <a href="javascript:void(0)"
		class="easyui-linkbutton"
		onclick="closeDialog()">取消</a>
</div>





