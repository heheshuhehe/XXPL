<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>数据结息查询</title>
    <script>document.documentElement.focus();</script>
    	<style scoped="scoped">
	        .md{
	            height:16px;
	            line-height:16px;
	            background-position:2px center;
	            text-align:right;
	            font-weight:bold;
	            padding:0 2px;
	            color:red;
	        }
    </style>
    <style>
    body { font-size: 62.5%; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
  </style>
    
    
</head>
<script type="text/javascript">







		function myformatter(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
		}
		function myparser(s){
			if (!s) return new Date();
			var ss = s.split('-');
			var y = parseInt(ss[0],10);
			var m = parseInt(ss[1],10);
			var d = parseInt(ss[2],10);
			if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
				return new Date(y,m-1,d);
			} else {
				return new Date();
			}
		}
	


	</script>
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#dg').datagrid('validateRow', editIndex)){
				var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'date258'});
				//var productname = $(ed.target).combobox('getText');
				//$(ed.target).val();
				var productname = ''
				
				$('#dg').datagrid('getRows')[editIndex]['date258'] = productname;
				
				
				 productname =$('#dg').datagrid('getRows')[editIndex]['date2589']
				 if(productname==undefined)
					 productname='';
				// var tvalue=	$(ed.target).combobox('getText'); $(ed.target).val();
				 var tvalue=	'';
					if(productname.indexOf(tvalue)>-1)
						productname=productname.replace(tvalue+'#','')
						else if(tvalue.length==10)
							productname=productname+tvalue+'#';
						
					$('#dg').datagrid('getRows')[editIndex]['date2589'] = productname;
				 
				$('#dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function myselect(s){
			endEditing()
		}
		

		
		
		function onClickRow(index){
			if (editIndex != index){
				/*  if (endEditing()){
					$('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
					editIndex = index;
				}  
				else {
					
				} 
				$('#dg').datagrid('selectRow', editIndex); */ 
			}
			$('#indexq').val(index);
			
			 var row=$('#dg').datagrid('getRows')[$('#indexq').val()];
	
			 //  $('#selecttxt').val(row.date2589);
			$('#dg').datagrid('selectRow', editIndex);
		}
		function append(){
			if (endEditing()){
				$('#dg').datagrid('appendRow',{status:'P'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function remove(){
			if (editIndex == undefined){return}
			$('#dg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function accept(){
			if (endEditing()){
				$('#dg').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
		function getChanges(){
			var rows = $('#dg').datagrid('getChanges');
			alert(rows.length+' rows are changed!');
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
	     height : document.documentElement.clientHeight-140
	 });
	  $("#dg2").datagrid({
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
			  width:250,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) > -1;
					},
			 onLoadSuccess: function(){
		     }
	  });
	 $("#c_port_name_1").combobox({
         valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  width:250,
		  url:'<%=cp%>/guzhidz/getDataName',
         method:'post',
		  multiple:false,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) > -1;
				},
		 onLoadSuccess: function(){
	     }
 });
	 $("#userInfo").combobox({
		    valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
		    method:'post',
		    multiple:true,
			  width:190,
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
	 
	 $("#userInfo_1").combobox({
		    valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
		    method:'post',
		    multiple:true,
			  width:190,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			 onLoadSuccess: function(){
				 $('#userInfo_1').next('.combo').find('input').focus(function (){
			            $('#userInfo_1').combobox('clear');
			     });
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
	  

	  $("#report_type").combobox({
		  
		  onChange:changedisplay
	  });

	  $("#report_day").css('display','');
	  $("#report_all").css('display','none');
	  
	  
	  
  $("#report_type_1").combobox({
		  
		  onChange:changedisplay_1
	  });
  $("#report_day_1").css('display','');
  $("#report_all_1").css('display','none');

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
 function searchdata(){
	 var c_port_code=$("#c_port_name").combobox('getValue');
	 var report_type=$("#report_type").combobox('getValue');
	 var date=$("#t_wbdatebatch").val();
	 var year=$("#report_year").combobox('getValue');
	 var quarter=$("#report_quar").combobox('getValue');
	 var month=$("#report_month").combobox('getValue');
	 var userid=$("#userInfo").combobox('getValues');
	 var dzfreq=$("#dzfreq").combobox('getValues');
	 dzfreq=dzfreq.toString().replace(/\+/g,'%2B');
	var param="c_port_code="+c_port_code+"&report_type="+report_type+"&date="+date+"&year="+year
	+"&quarter="+quarter+"&month="+month+"&userid="+userid+"&dzfreq="+dzfreq;
	 
   $('#dg').datagrid({method:'post',url:"<%=cp%>/guzhidz/searchMailAccount?"+param}).datagrid('clientPaging'); 
}
 function senddata_dz(){

	 var c_port_code=$("#c_port_name").combobox('getValue');
	 var report_type=$("#report_type").combobox('getValue');
	 var date=$("#selectdate").val();
	 var year=$("#report_year").combobox('getValue');
	 var quarter=$("#report_quar").combobox('getValue');
	 var month=$("#report_month").combobox('getValue');
	 var userid=$("#userInfo").combobox('getValues');
	 var dzfreq=$("#dzfreq").combobox('getValues');
	 dzfreq=dzfreq.toString().replace(/\+/g,'%2B');
	 
	 var ssinfo ="";
	 if($("#pdf_b")[0].checked)
		 report_b="pdf";
	 else
		 report_b="excel";
	 var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ssinfo=ssinfo+row.wb_zth+",";
		}
		$.messager.alert('info', '请耐心等待发送结果，');
	 
		$.ajax({
			url:'<%=cp%>/guzhidz/sendmail4cwb',
			type:'post',
			data:{ssinfo:ssinfo,report_type:report_type,report_b:report_b,date:date,year:year,month:month,quarter:quarter},
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
 
 function senddata_ma(){

	 if (endEditing()){
			$('#dg').datagrid('acceptChanges');
		}
	 var report_b="";
	 if($("#pdf_b")[0].checked)
		 report_b="pdf";
	 else
		 report_b="excel";
	 var ssinfo ="";
	 var rows = $('#dg').datagrid('getSelections');
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			ssinfo=ssinfo+row.datacode+"#"+row.date2589+"#";
		
		}
		$.messager.alert('info', '请耐心等待发送结果，');
	 
		$.ajax({
			url:'<%=cp%>/guzhidz/sendmail',
			type:'post',
			data:{ssinfo:ssinfo,type:'ma',report_b:report_b},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("发送完成");
				}else{
					alert("发送失败！！！");
				}
				
			}
		});
	  
	}
  //数据结息查询
 function searchdata2(){
	 var c_port_code=$("#c_port_name_1").combobox('getValue');
	 var report_type=$("#report_type_1").combobox('getValue');
	 var date=$("#selectdate_1").val();
	 var year=$("#report_year_1").combobox('getValue');
	 var quarter=$("#report_quar_1").combobox('getValue');
	 var month=$("#report_month_1").combobox('getValue');
	 var userid=$("#userInfo_1").combobox('getValues');
	 var dzfreqs=$("#dzfreq_1").combobox('getValues');
	// dzfreq=dzfreq.toString().replace(/\+/g,'%2B');
	 var userids=userid.join(',');
	 var dzfreq=dzfreqs.join(',');
	  
 		var wbdate = $("#wbdate").datebox('getValue'); 
		if (wbdate == null || wbdate == "") {
			alert("请选择日期！");
			return;
		} 
		

 		var r_flag = $("#r_flag").combobox('getValue');
 		var params = {c_port_code:c_port_code,wbdate:wbdate,report_type:report_type,date:date,year:year,quarter:quarter,month:month,userids:userids,dzfreq:dzfreq,r_flag:r_flag};
 		

 
      
      $('#dg2').datagrid({method:'post',url:"<%=cp%>/guzhidz/searchdata4cwb",queryParams:params}); 
 }

 


  function changedisplay(n,o){
	  var  type= $("#report_type").combobox('getValue');
	  if(type==0){
		  $("#report_day").css('display','');
		  $("#report_all").css('display','none');
		 
	  }
	  if(type==1){
		  $("#report_day").css('display','none');
		  $("#report_all").css('display','');
		  $("#report_name0").html('年度');
		  $("#report_name1").html('');
		  $("#report_name2").html('月度');
		  $("#report_year").next('.combo').show();
		  $("#report_quar").next('.combo').hide();
		  $("#report_month").next('.combo').show();
		  
	  }
	  if(type==2){
		  $("#report_day").css('display','none');
		  $("#report_all").css('display','');
		  $("#report_name0").html('年度');
		  $("#report_name1").html('季度');
		  $("#report_name2").html('');
		  $("#report_year").next('.combo').show();
		  $("#report_quar").next('.combo').show();
		  $("#report_month").next('.combo').hide();
		  
	  }
	  
	  if(type==3){
		  $("#report_day").css('display','none');
		  $("#report_all").css('display','');
		  $("#report_name0").html('年度');
		  $("#report_name1").html('');
		  $("#report_name2").html('');
		  $("#report_year").next('.combo').show();
		  $("#report_quar").next('.combo').hide();
		  $("#report_month").next('.combo').hide();
		  
	  }
	  
	  
  }
  
  
  function changedisplay_1(n,o){
	  var  type= $("#report_type_1").combobox('getValue');
	  if(type==0){
		  $("#report_day_1").css('display','');
		  $("#report_all_1").css('display','none');
		 
	  }
	  if(type==1){
		  $("#report_day_1").css('display','none');
		  $("#report_all_1").css('display','');
		  $("#report_name0_1").html('年度');
		  $("#report_name1_1").html('');
		  $("#report_name2_1").html('月度');
		  $("#report_year_1").next('.combo').show();
		  $("#report_quar_1").next('.combo').hide();
		  $("#report_month_1").next('.combo').show();
		  
	  }
	  if(type==2){
		  $("#report_day_1").css('display','none');
		  $("#report_all_1").css('display','');
		  $("#report_name0_1").html('年度');
		  $("#report_name1_1").html('季度');
		  $("#report_name2_1").html('');
		  $("#report_year_1").next('.combo').show();
		  $("#report_quar_1").next('.combo').show();
		  $("#report_month_1").next('.combo').hide();
		  
	  }
	  
	  if(type==3){
		  $("#report_day_1").css('display','none');
		  $("#report_all_1").css('display','');
		  $("#report_name0_1").html('年度');
		  $("#report_name1_1").html('');
		  $("#report_name2_1").html('');
		  $("#report_year_1").next('.combo').show();
		  $("#report_quar_1").next('.combo').hide();
		  $("#report_month_1").next('.combo').hide();
		  
	  }
	  
	  
  }
 
 </script>

<body>
<div id="tabsidk" class="easyui-tabs" style="">
   	<div title="估值表发送" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
	    <span>产品名称:</span> 	<input class="easyui-combobox"	name="c_port_name" id="c_port_name"   /> 
	    <span>报表类型:</span> 	<select id="report_type" class="easyui-combobox" name="report_type" style="width: 80px;" >
					<option value="0">估值表</option>
					<option value="1">月报</option>
					<option value="2">季报</option>
					<option value="3">年报</option>
					
				</select>
	    
	     <span  id="report_day" style="">估值日期:<input  type="text" name="selectdate" id="selectdate" class="auto-kal"    data-kal="mode:'multiple'" style="width:380px"  ></span>
	     
	     <span  id="report_all" style=""> <span id="report_name0"> 年度  </span>  <select id="report_year" class="easyui-combobox" name="report_year" style="width: 80px;">
					<option value="2021">2021</option>
					<option value="2020">2020</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
					<option value="2016">2016</option>
					
				</select>  <span id="report_name1"> 季度  </span> 
				  <select id="report_quar" class="easyui-combobox" name="report_quar" style="width: 80px;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					
				</select> <span id="report_name2"> 月度  </span> 
				 <select id="report_month" class="easyui-combobox" name="report_month" style="width: 80px;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					
				</select> 
				
				 </span>
	
	<br/><br/>
	 <span   > 对账频率 </span> 
				  <select id="dzfreq" class="easyui-combobox" name="dzfreq"      multiple="multiple" style="width: 130px; "> 
					<option value="T1">T1</option>
					<option value="T2">T2</option>
					<option value="TN">TN</option>

				</select>
	<span style="margin-left: 0px;">估值人员:</span> 
			<input class="easyui-combobox"	name="userInfo" id="userInfo"  >		
		 <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
		<span style="display: none">  <input type="checkbox"   id="pdf_b" name="p df_b"> PDF盖章版</span> 
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="senddata_dz()">发送</a>
		 <!--  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="senddata_ma()">管理人邮箱发送</a> -->
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="rownumbers:true,  autoRowHeight:false,pagination:true,pageSize:500,
				singleSelect: false,
				selectOnCheck:true,
				checkOnSelect:true

			">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
					     <th field="wb_zth"  >账套号</th>
                        <th field="c_port_name"  >账套名称</th>
					    <th field="dzfreq"   >对账频率</th>
					     <th field="username"  >估值人员</th>
						 <th field="dz_mail"  ">对账邮箱</th>
					
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	

	
	
	<div title="发送记录查询" style="padding: 5px">
	  <div style="margin-top: 5px; margin-bottom: 5px;">
			<span>产品名称:</span> 
			<input class="easyui-combobox" name="c_port_name_1" id="c_port_name_1" >
			   <span style="margin-left: 15px;">发送日期</span>   <span><input id="wbdate" name="wbdate" class="easyui-datebox" style="width: 100px"  data-options=""></input></span>
		    
		     <span>报表类型:</span> 	<select id="report_type_1" class="easyui-combobox" name="report_type_1" style="width: 80px;" >
					<option value="0">估值表</option>
					<option value="1">月报</option>
					<option value="2">季报</option>
					<option value="3">年报</option>
					
				</select>
				
		 
	     <span  id="report_day_1" style="">估值日期:<input  type="text" name="selectdate_1" id="selectdate_1" class="auto-kal"    data-kal="mode:'multiple'" style="width:250px"  ></span>
	     
	     <span  id="report_all_1" style="display: "> <span id="report_name0_1"> 年度  </span>  <select id="report_year_1" class="easyui-combobox" name="report_year_1" style="width: 80px;">
					<option value="2020">2020</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
					<option value="2016">2016</option>
					
				</select>  <span id="report_name1_1"> 季度  </span> 
				  <select id="report_quar_1" class="easyui-combobox" name="report_quar_1" style="width: 80px;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					
				</select> <span id="report_name2_1"> 月度  </span> 
				 <select id="report_month_1" class="easyui-combobox" name="report_month_1" style="width: 80px;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					
				</select> </span> <br /><br />
		  <span   > 对账频率 </span> 
				  <select id="dzfreq_1" class="easyui-combobox" name="dzfreq_1"      multiple="multiple" style="width: 130px; "> 
					<option value="T1">T+1</option>
					<option value="T2">T+2</option>
					<option value="TN">T+N</option>

				</select>
		   <span style="color: red;"> </span>
		   <span>状态:</span>
			<span>
				<select id="r_flag" class="easyui-combobox" name="r_flag" style="width: 175px;">
					<option value="0">全部</option>
					<option value="1">成功</option>
					<option value="2">失败</option>
					
				</select>
			</span>
			<span style="margin-left: 0px;">估值人员:</span> 
			<input class="easyui-combobox"	name="userInfo_1" id="userInfo_1"  >		
		 
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata2()">查询</a>
		  <br />	
	</div>
		<div style="margin-top: 10px;">
			<table id="dg2" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
<!--                    <th field="id" width="80px">序号</th> -->
                       
						<th field="wb_zth" >外包账套号</th>
						<th field="ztmc" >账套名称</th>
						<th field="senddate">发送日期</th>						
						<th field="flag" >发送结果</th>
						<th field="reportclass" >邮件种类</th>
						<th field="reportdate" >估值表日期</th>
						<th field="year" >年</th>
						<th field="quarter" >季度</th>
						<th field="month" >月</th>
						<th field="tomail" >接收人</th>
						<th field="fujian" >附件</th>
						
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
  </div>






</body>













