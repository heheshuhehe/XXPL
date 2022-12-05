<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <%@include file="../guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>   
    <title>文件信息</title>
    <script>document.documentElement.focus();</script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href='<%=basePath%>calendar/fullcalendar.min.css' rel='stylesheet' />
    <link href='<%=basePath%>calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <script src='<%=basePath%>calendar/lib/moment.min.js'></script>
<%--     <script src='<%=basePath%>calendar/lib/jquery.min.js'></script> --%>
    <script src='<%=basePath%>calendar/fullcalendar.js'></script>
    
    <script src='<%=basePath%>calendar/locale-all.js'></script>
    
</head>
<script type="text/javascript">

function getyyyyMMdd(){
    var d = $('#calendar').fullCalendar('getDate');
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1; 
    var curr_year = d.getFullYear();
    String(curr_month).length < 2 ? (curr_month = "0" + curr_month): curr_month;
    String(curr_date).length < 2 ? (curr_date = "0" + curr_date): curr_date;
    var yyyyMMdd = curr_year + "" + curr_month ;
    return yyyyMMdd;
}    

$(document).ready(function() {

	
	
	$("#hduser").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/xinxipilu/getComboBoxSource?tbname=guzhiuserinfo&code=id&name=id||'_'||username||'('||userid||')'&option=   order by id desc",
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 
	     }
});
	$("#hduser2").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/xinxipilu/getComboBoxSource?tbname=guzhiuserinfo&code=id&name=id||'_'||username||'('||userid||')'&option=   order by id desc",
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 
	     }
});
    $("#llr").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/xinxipilu/getComboBoxSource?tbname=guzhiuserinfo&code=id&name=id||'_'||username||'('||userid||')'&option=   order by id desc",
        method:'post',
		  multiple:false,
		  width:200,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 
	     }
});
    $("#jbr").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/xinxipilu/getComboBoxSource?tbname=guzhiuserinfo&code=id&name=username||'('||userid||')'&option=   order by id desc",
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			
	     }
});
    $("#fhr").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:"<%=cp%>/xinxipilu/getComboBoxSource?tbname=guzhiuserinfo&code=id&name=username||'('||userid||')'&option=   order by id desc",
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			
	     }
});
    $("#shzt").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/xinxipilu/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option= where datatype  =\'BB_SHZT\'  order by datacode desc',
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			
	     }
});
    $("#wglx").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/xinxipilu/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option= where datatype  =\'BB_WGLX\'  order by datacode desc',
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#wglx').next('.combo').find('input').focus(function (){
		            $('#wglx').combobox('clear');
		     });
	     }
}); 
    $("#wgtype").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/xinxipilu/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option= where datatype  =\'BB_WGLX\'  order by datacode desc',
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			
	     }
});
    $("#bbtype").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/xinxipilu/getComboBoxSource?tbname=codemanage&code=datacode&name=datavalue&option= where datatype  =\'BB_BBTYPE\'  order by datacode desc',
        method:'post',
		  multiple:false,
		  width:150,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			
	     }
});
    $("#fundname").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/xinxipilu/getComboBoxSource?tbname=accountmappinginfo&code=fund_code&name=fund_name&option=   order by fund_code desc',
        method:'post',
		  multiple:false,
		  width:260,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			 $('#fundname').next('.combo').find('input').focus(function (){
		            $('#fundname').combobox('clear');
		     });
	     }
});    
    $("#cpname").combobox({
        valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/xinxipilu/getComboBoxSource?tbname=accountmappinginfo&code=fund_code&name=fund_name&option=   order by fund_code desc',
        method:'post',
		  multiple:false,
		  width:260,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				},
		 onLoadSuccess: function(){
			
	     }
});  
    /*s&
    
    
    */ 
   
    
    $("#tablename").combobox({
    	onChange:function(){
    		initGrid();
    	}
    });
    initGrid();
    //**********************************datagird 2********************************************************************//
    var curr_time = new Date();
	$("#wbdate").datebox("setValue", myformatter(curr_time));

	 //初始化table
	 $("#wbdg").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-80
	 });

	 $("#wbdg2").datagrid({
	 	 width : '100%',
    	 height : document.documentElement.clientHeight-80
	 });

});



</script>
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '100%' 
	});
	 //初始化table

	 $("#wbdg").datagrid({
	 	 width : '99%' 
	 });
});


function searchdata(){
	var cpname=$("#fundname").combobox('getValue');
	var wgtype=$("#wglx").combobox('getValue');
	var jbr=$("#llr").combobox('getValue');
	var params="cpname="+cpname+"&wgtype="+wgtype+"&jbr="+jbr+"&op=s";
	$('#wbdg').datagrid("options").url='<%=cp%>/xinxipilu/updateBBinfo?'+params; 
	$('#wbdg').datagrid('clientPaging');
 	
	<%-- $('#wbdg').datagrid({method:'get',url:"<%=cp%>/xinxipilu/updateBBinfo?"+params}).datagrid('clientPaging');  --%>
} 
function initGrid(){
	var tablename=$("#tablename").combobox('getValue');
	var sql=" select p_field,p_title,p_options ,ismodi,ispk from smgz_xxpl_item_cfg where  tablename ='"+tablename+"'  ";
	
	var columns=new Array();
	//获取该表需要修改的列，动态加载datagrid
	
	$.post('<%=cp%>/xinxipilu/getCommonSQLSearch',{sql:sql},function(data){
		for(var i=0;i<data.length;i++){
			var filed=data[i].p_field;
			var title=data[i].p_title;
			var ismodi=data[i].ismodi;
			var ispk=data[i].ispk;
			var option=data[i].p_options.split(';');
			
			var column={};
			column["field"]=filed;
			column["title"]=title;
			
			column["ismodi"]=ismodi;
			column["ispk"]=ispk;

			for(var j=0;j<option.length;j++){
				if(option[j].split(':')<2)
					continue;
				column[option[j].split(':')[0]]=option[j].split(':')[1];
			}
			columns.push(column);
		}
			
			
			$('#wbdg2').datagrid({
				idFiled:'id',
				method:'post',
				rowsnumbers:true,
				pagination:true,
				pageList:[20,50,100,200],
				columns:[columns],
				//loadFilter:pagerFilter
			});
	},'json');
	

}
function searchnewdata(){
	
	
	var tablename=$("#tablename").combobox('getValue');
	var cpname=$("#fundname").combobox('getValue');
	var wgtype=$("#wglx").combobox('getValue');
	var bbnum=$("#bbnum").textbox('getValue');
	var hdstatus=$("#hdstatus").combobox('getValue');
	var hduser=$("#hduser").combobox('getValue');
	var hdcpname=$("#hdcpname").textbox('getValue');
	var wgLevel=$("#wgLevel").combobox('getValue');
	 if(bbnum.length!=4&&bbnum.length!=6){
		 alert("“年度/季度” 输入错误 ，请核对");
		 return;
	 }
	  
	var params="cpname="+cpname+"&wgtype="+wgtype+"&bbnum="+bbnum+"&op=s"+"&tablename="+tablename
	+"&hdstatus="+hdstatus +"&hduser="+hduser+"&hdcpname="+encodeURI(hdcpname)+"&wgLevel="+wgLevel;

	$('#wbdg2').datagrid("options").url='<%=cp%>/xinxipilu/updateCheckinfo?'+params; 
	$('#wbdg2').datagrid('clientPaging');

 	
	<%-- $('#wbdg').datagrid({method:'get',url:"<%=cp%>/xinxipilu/updateBBinfo?"+params}).datagrid('clientPaging');  --%>
} 
function exportdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&fylx="+$("#fylx").combobox('getValue')+"&down=1";
	var url="<%=cp%>/guzhidz/feeExportDown?"+params; 
	window.location.href=url;
	
} 
</script>

<script type="text/javascript">
	function myformatter1(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + '-' + (m < 10 ? ('0' + m) : m) + '-'
				+ (d < 10 ? ('0' + d) : d);
	}
	function myparser(s) {
		if (!s)
			return new Date();
		var ss = (s.split('-'));
		var y = parseInt(ss[0], 10);
		var m = parseInt(ss[1], 10);
		var d = parseInt(ss[2], 10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
			return new Date(y, m - 1, d);
		} else {
			return new Date();
		}
	}
	
	function format (number) {
		var num;
		try{
			num=Number(number);
			
		}
		catch (e) {
			return number;
		}
	if(isNaN(num))
		return num;
	    return (num.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'); 

	} 
	 function updateInfonew(op){
		 $("#op").val(op);
		 //获取选中行
		 if(op=='a'){
			 $("#cpname").combobox('readonly',false)
			 $('#yhdzhds').dialog('open');
			
		 }else if(op=='u'){
			 var row = $('#wbdg').datagrid('getSelected');
				if (row){
					 $("#cpname").combobox('readonly',true);
					 
					 $("#ider").val(row.ider);
					  $("#cpname").combobox('select',row.fundcode);
					  $("#wgtype").combobox('select',row.wgtypecode);
					 $("#bbtype").combobox('select',row.bbtypecode);
					 $("#edate").datebox('setValue',row.edate);
					$("#sdate").datebox('setValue',row.sdate);
					$("#ord").numberbox('setValue',row.ord);
					$("#jbr").combobox('select',row.jbrcode);
					$("#fhr").combobox('select',row.ssrcode);
					$("#content").textbox('setValue',row.wginfo);
					$("#shzt").combobox('select',row.ischeckcode);
					
					 $('#yhdzhds').dialog('open');
				}
				else{
					$.messager.alert('提示','请先选中一行！');

				} 
		 }
	}
	 function recalc() {
		 var row = $('#wbdg2').datagrid('getSelected');
			if (row){
				
			}
			else{
				$.messager.alert('提示','请先选中一行！');
				return;

			} 
		 var tablename=$("#tablename").combobox('getValue');
		 var bbnum=$("#bbnum").textbox('getValue');
		 var reportdate="";
		 if(bbnum.length==4){
			 
		 }else if(bbnum.length==6&&tablename=='mds.rept_q_magr_rept'){
			 if(bbnum.slice(-2)=='01'){
				 reportdate=bbnum.substring(0,4)+'0331';
			 }
			 if(bbnum.slice(-2)=='02'){
				 reportdate=bbnum.substring(0,4)+'0630';
			 }
			 if(bbnum.slice(-2)=='03'){
				 reportdate=bbnum.substring(0,4)+'0930';
			 }
			 if(bbnum.slice(-2)=='04'){
				 reportdate=bbnum.substring(0,4)+'1231';
			 }
		 }else if(bbnum.length==6&&tablename=='mds.rept_hsr_magr_rept'){
			 if(bbnum.slice(-2)=='01'){
				 reportdate=bbnum.substring(0,4)+'0630';
			 }
			 
		 }
		 var fundcode=row.fund_code;
		 $.messager.confirm('重新计算', '即将重新计算该指标值，是否继续？', function(r){
				if (r){
					load("正在计算");
					 $.ajax({
							url:'<%=cp%>/xinxipilu/updateCheckBBinfo',
							type:'post',
							data:{
								op:'recalc',reportdate:reportdate,fundcode:fundcode,tablename:tablename
							},
							dataType: "json",
							success: function(data){
								disLoad();
								if(data[0].msg=="success"){  
									alert("计算成功");	
									
								}else{
									alert("计算失败");
								}
								
							}
						});
				}
		 });
		
	}
	 function checkdata(op){

		 //获取选中行
		 if(op=='all'){
			 var bbnum=$("#bbnum").textbox('getValue');
			 var name=$("#tablename").combobox('getText');
			 var tablename=$("#tablename").combobox('getValue');
			 var wgLevel=$("#wgLevel").combobox('getValue');
			 var wgLevelname=$("#wgLevel").combobox('getText');
			 if(bbnum.length!=4&&bbnum.length!=6){
				 alert("“年度/季度” 输入错误 ，请核对");
				 return;
			 }
			 
			var hduser=   $('#hduser').combobox('getValue');
			 if(''==hduser){
				 alert("请选择查询条件的“核对人”，作为本次全部复核的复核人");
				 return;
			 }
			 
			 var tipstr='所有数据';
			 if(''!=wgLevelname){
				 tipstr=wgLevelname;
			 }
			 $.messager.confirm('全部审核', '即将“'+name+'”批次【'+bbnum+'】'+'【'+tipstr+'】'+'进行全部复核，是否继续', function(r){
					if (r){
						$.ajax({
							url:'<%=cp%>/xinxipilu/updateCheckBBinfo',
							type:'post',
							data:{
								bbnum:bbnum,op:op,tablename:tablename,hduser:hduser,wgLevel:wgLevel
							},
							dataType: "json",
							success: function(data){
								if(data[0].msg=="success"){  
									alert("保存成功");
								
									
								}else{
									alert("保存失败");
								}
								
							}
						});
					}
				});

			
		 }else if(op=='one'){
			 var needshowinfo="";
			 var row = $('#wbdg2').datagrid('getSelected');
				if (row){
					var datagridTitle_show = {};
					var datagridTitle_pk = {};
			        var fields = $("#wbdg2").datagrid('getColumnFields');
			            for (var i = 0; i < fields.length; i++) {
			                var option = $("#wbdg2").datagrid('getColumnOption', fields[i]);
			                if (option.field != "checkItem" && option.hidden != true ) { //过滤勾选框和隐藏列
			                    //datagridTitle.push(option.title);
			                	if( option.ismodi=="1") 
			                		datagridTitle_show[fields[i]]=option.title;
			                	if( option.ispk=="1") 
			                		datagridTitle_pk[fields[i]]=option.title;
			                }
			            }
			            for (var i = 0; i < Object.keys(datagridTitle_pk).length; i++) {
			            	needshowinfo= needshowinfo + datagridTitle_pk[Object.keys(datagridTitle_pk)[i]]+":"+row[Object.keys(datagridTitle_pk)[i]] +"<br/>";
			            }
					
			            
			            $('#info').append(needshowinfo);
			            
			            for (var i = 1; i <=Object.keys(datagridTitle_show).length; i++) {

			                $('#cc').accordion('getPanel',i-1).panel('setTitle',datagridTitle_show[Object.keys(datagridTitle_show)[i-1]]);

			            	//$('#mydiv'+i).attr('title',datagridTitle_show[Object.keys(row)[i-1]])
			            	$('#content'+i+'A').textbox('setValue',row[Object.keys(datagridTitle_show)[i-1]+"_first"]);
			            	$('#content'+i+'B').textbox('setValue',row[Object.keys(datagridTitle_show)[i-1]]);
			            }
			            
			           
			            $('#hduser2').combobox('select',row.hduser);
			            $('#content1A').textbox('readonly');
			            $('#content2A').textbox('readonly');
			            $('#content3A').textbox('readonly');
			            		
			            
					 $('#yhdzhds2').dialog('open');
				}
				else{
					$.messager.alert('提示','请先选中一行！');

				} 
		 }
	} 
	 function closeDialog(){
		 $("#cpname").combobox('clear');
		 $("#wgtype").combobox('clear');
		 $("#bbtype").combobox('clear');
		 $("#edate").datebox('clear');
		 $("#sdate").datebox('clear');
		 $("#ord").numberbox('clear');
		 $("#jbr").combobox('clear');
		 $("#fhr").combobox('clear');
		 $("#content").textbox('clear');
		 $("#shzt").combobox('clear');
		 $('#yhdzhds').dialog('close');
		 
	 }
	 function closeDialog2(){
		 
		 $("#info").empty();
		 $("#content1A").textbox('clear');
		 $("#content1B").textbox('clear'); 
		 $("#content2A").textbox('clear');
		 $("#content2B").textbox('clear');
		 $("#content3A").textbox('clear');
		 $("#content3B").textbox('clear');
		 $('#yhdzhds2').dialog('close');
		 
	 }
	 function saveInfonew(){
		 var cpname= $("#cpname").combobox('getValue');
		 var wgtype= $("#wgtype").combobox('getValue');
		var bbtype= $("#bbtype").combobox('getValue');
		var edate= $("#edate").datebox('getValue');
		var sdate =$("#sdate").datebox('getValue');
		var ord=$("#ord").numberbox('getValue');
		var jbr=$("#jbr").combobox('getValue');
		var fhr= $("#fhr").combobox('getValue');
		var content= $("#content").textbox('getValue');
		var shzt= $("#shzt").combobox('getValue');
		var op=$("#op").val();
	
		var ider=$("#ider").val();
			if(cpname==''){
				$.messager.alert('提示','请选择产品');
				return ;
			}
			$.ajax({
				url:'<%=cp%>/xinxipilu/updateBBinfo',
				type:'post',
				data:{
					cpname:cpname,wgtype:wgtype,bbtype:bbtype,edate:edate,sdate:sdate,ord:ord,jbr:jbr,fhr:fhr,content:content,op:op,shzt:shzt,ider:ider
				},
				dataType: "json",
				success: function(data){
					if(data[0].msg=="success"){  
						alert("保存成功");
						
						searchdata();
						closeDialog();
						
					}else{
						alert("保存失败");
					}
					
				}
			});
		}
	 function saveInfonew2(){
		 
		 var row = $('#wbdg2').datagrid('getSelected');
		 var tablename=$("#tablename").combobox('getValue');
		 var pkinfo="";
		 var modyinfo="";
		 var fundcode="";
		 var bbnum="";
		 var op="u";
		 var hduser2=$("#hduser2").combobox('getValue');
		 if(hduser2==''||hduser2==null){
			 alert('请选择核对人');
			 return;
			 
		 }
			 
		 if (row){
			 fundcode= row.fund_code;
			 bbnum=row.qut_no;
			 if(bbnum==null){
				 bbnum=row.date_no; 
			 }
				var datagridTitle_show = {};
				var datagridTitle_pk = {};
		        var fields = $("#wbdg2").datagrid('getColumnFields');
		            for (var i = 0; i < fields.length; i++) {
		                var option = $("#wbdg2").datagrid('getColumnOption', fields[i]);
		                if (option.field != "checkItem" && option.hidden != true ) { //过滤勾选框和隐藏列
		                    //datagridTitle.push(option.title);
		                	if( option.ismodi=="1") 
		                		datagridTitle_show[fields[i]]=option.title;
		                	if( option.ispk=="1") 
		                		datagridTitle_pk[fields[i]]=option.title;
		                }
		            }
		            for (var i = 0; i < Object.keys(datagridTitle_pk).length; i++) {
		            	pkinfo= pkinfo + Object.keys(datagridTitle_pk)[i]+":"+row[Object.keys(datagridTitle_pk)[i]] +"#";
		            }
		            
		            
		            for (var i = 1; i <=Object.keys(datagridTitle_show).length; i++) {

		            	modyinfo=modyinfo+Object.keys(datagridTitle_show)[i-1]+"@#"+$('#content'+i+'B').textbox('getValue')+"@@$$";
		              
		            }
		 }   
		 
			$.ajax({
				url:'<%=cp%>/xinxipilu/updateCheckBBinfo',
				type:'post',
				data:{
					pkinfo:pkinfo,modyinfo:modyinfo,op:op,tablename:tablename,fundcode:fundcode,bbnum:bbnum,hduser:hduser2
				},
				dataType: "json",
				success: function(data){
					if(data[0].msg=="success"){  
						alert("保存成功");
						
						closeDialog2();
						searchnewdata();
						
					}else{
						alert("保存失败");
					}
					
				}
			});
		}
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
<div title="管理人报告" style="padding: 5px">
			<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
					产品名称：<select id="fundname"
						class="easyui-combobox" name="fundname" style="width: 100px;">
					    
							</select>
			     </td>

					<td>违规类型：<select id="wglx"
						class="easyui-combobox" name="wglx" style="width: 100px;">
					    
							</select>
							录入人：<select id="llr"
						class="easyui-combobox" name="llr" style="width: 100px;">
					    	
							</select></td>
							   
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="updateInfonew('a')">添加</a>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="updateInfonew('u')">查看/修改</a></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="exportdata()">导出</a>
					
					</td>		
				</tr>
		</table>
		<div style="margin-top: 10px;">
			<table id="wbdg"  class="easyui-datagrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id', singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
						<th field=ider hidden="true" >pk</th>
						<th field="fundcode"  >基金编码</th>
						<th field="fundname"  >产品名称</th>
						<th field="wgtypecode" hidden="true" > </th>
						<th field="wgtypename"  >违规类型</th>
						<th field="bbtypecode"  hidden="true"></th>
						<th field="bbtypename"  >报表类型</th>
						<th field="sdate"  >有效期始</th>
						<th field="edate"  >有效期止</th>
						<th field="jbrcode"hidden="true"  ></th>
						<th field="jbrname"  >经办</th>
						<th field="ssrcode"  hidden="true"></th>
						<th field="ssrname"  >复核</th>
						
						<th field="wginfo"  width="200px" >违规信息</th>
						<th field="ord"  >顺序</th>
						<th field="ischeckcode" hidden="true" ></th>
						<th field="ischeckname"  >审核状态</th>

					</tr>
				</thead>
			</table>
	 </div>
	</div>
	
	<div title="管理人报告-核对" style="padding: 5px">
			<table>
				<tr>
				<td>
			     </td>
			     <td>报表指标：<select id="tablename"				class="easyui-combobox" name="tablename" style="width: 150px;">	
			     	<option value="mds.rept_q_magr_rept">管理人报告(季报)</option>
			     	<option value="mds.rept_hsr_magr_rept">管理人报告(股权半年报)</option>
					<option value="mds.rept_yse_trus_rept">托管人报告(证券年报)</option>
			        </select></td>
		<td>年度/季度编号：<input name="bbnum" required id="bbnum" class="easyui-textbox" data-options=""  value="" style="width:80px;">
			核对人：<select id="hduser"						class="easyui-combobox" name="hduser" style="width: 100px;"></select>
			核对状态：<select id="hdstatus"						class="easyui-combobox" name="hdstatus" style="width: 80px;">
			<option value="-1" selected >全部</option>
			<option value="0"  >未核对</option>
			<option value="1"  >核对一致</option>
			<option value="2"  >核对不一致</option>
			<option value="9"  >不需要核对</option>
			
			</select>
			</td>
				<!-- 	产品名称：<select id="hdcpname"				class="easyui-combobox" name="hdcpname" style="width: 220px;">					    	
							</select> -->
							<td>产品名称<input id="hdcpname"				class="easyui-textbox" name="hdcpname" style="width: 220px;">					    	
							</input>
							</td>
							   
				</tr>
		</table>
		违规程度：<select id="wgLevel"				class="easyui-combobox" name="wgLevel" style="width: 150px;">
					<option value="00" selected>无违规</option>
					<option value="01">特别提示</option>
					<option value="10"> 轻度违规</option>
					<option value="11">轻度违规且特别提示</option>
					<option value="20">重度违规</option>
					<option value="21">重度违规且特别提示</option>
			        </select>
		<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="searchnewdata()">查询</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="recalc()">重新计算</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="checkdata('one')">核对</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="checkdata('all')">全部复核</a>
		<div style="margin-top: 10px;">
			<table id="wbdg2"  class="easyui-datagrid" data-options="rownumbers:true,autoRowHeight:false,idField: 'id', singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500
				 ">
				<thead>
					<tr>
						<th field="wbzth"  >产品编码</th>
						<th field="ztmc"  >产品名称</th>
						<th field="bfzh"  >季报（原始）</th>
						<th field="rq"  >季报（最终）</th>
						<th field="lb"  >核对人</th>
						

					</tr>
				</thead>
			</table>
	 </div>
	</div>
</div>

 <div id="yhdzhds" class="easyui-dialog" closed="true" title="添加/修改"
			style="width: 750px; height: 620px; padding: 10px;"
			data-options="iconCls: 'icon-save',	buttons: '#dlg-buttons'	">
			
				<input id ="op"  name="op" type="text" style="display: none;">
				<input id ="ider"  name="ider" type="text" style="display: none;">
			
				<span style="margin-left: 0px">产品名称:
				<select id="cpname"	 required class="easyui-combobox" name="cpname" style="width: 220px;"> </select>	
				<span> 
				<span style="margin-left: 0px">违规类型:
				<select id="wgtype"	class="easyui-combobox" name="wgtype" style="width: 150px;"> </select>	
				<span> 
				<br><br>
				<span style="margin-left: 0px">报表类型:
				<select id="bbtype"	class="easyui-combobox" name="bbtype" style="width: 100px;"> </select>	
				<span> 
				顺序：<input class="easyui-numberbox" required data-options="	" id="ord" name= "ord">
				<br><br>
				<span style="margin-left: 0px">生效区间:
				<input id="sdate" name="sdate"	required class="easyui-datebox"	data-options="formatter:myformatter1,parser:myparser" style="width: 120px">-
				<input id="edate" name="edate" required	class="easyui-datebox"	data-options="formatter:myformatter1,parser:myparser" style="width: 120px">
				<span> 
				
				<br><br>
			 	经办人：<select id="jbr"	class="easyui-combobox" name="jbr" style="width: 150px;"> </select>	
			 	复核人：<select id="fhr"	class="easyui-combobox" name="fhr" style="width: 150px;"> </select>	
			 	审核状态：<select id="shzt"	class="easyui-combobox" name="shzt" style="width: 150px;"> </select>	
			</span>
			<br><br>
			违规内容：<br>
			<input name="content"  required id="content" class="easyui-textbox" data-options="multiline:true"  style="width:650px;height:350px">
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>

 <div id="yhdzhds2" class="easyui-dialog" closed="true" title="查看/修改"
			style="width: 750px; height: 620px; padding: 10px;"
			data-options="iconCls: 'icon-save',	buttons: '#dlg-buttons'	,modal: true,closable:false">
			
			<div id="info">
			
			</div>
			核对人：<select id="hduser2"			class="easyui-combobox" name="hduser2" style="width: 100px;"></select>
			
			
			<div id="cc" class="easyui-accordion" data-options="border:false" style="width:99%;height:90%">
				
				<div  id="mydiv1" title="无指标" style="padding:10px;;height:95%">
					<div class="easyui-layout" data-options="fit:true,selected:true">
						<div data-options="region:'west',split:true" style="width:350px;padding:10px">
							<input name="content1A" required id="content1A" class="easyui-textbox" data-options="multiline:true"  style="width:99%;height:99%">
						</div>
						<div data-options="region:'center'" style="width:350px;padding:10px">
						<input name="content1B" required id="content1B" class="easyui-textbox" data-options="multiline:true"  style="width:99%;height:99%">
						</div>
					</div>
				</div>
				<div  id="mydiv2" title="无指标" data-options="" style="padding:10px;">
					<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'west',split:true" style="width:350px;padding:10px">
							<input name="content2A" required id="content2A" class="easyui-textbox" data-options="multiline:true"  style="width:99%;height:99%">
						</div>
						<div data-options="region:'center'" style="width:350px;padding:10px">
						<input name="content2B" required id="content2B" class="easyui-textbox" data-options="multiline:true"  style="width:99%;height:99%">
						</div>
					</div>
				</div>
				<div id="mydiv3" title="无指标" style="padding:10px">
					<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'west',split:true" style="width:350px;padding:10px">
							<input name="content3A" required id="content3A" class="easyui-textbox" data-options="multiline:true"  style="width:99%;height:99%">
						</div>
						<div data-options="region:'center'" style="width:350px;padding:10px">
						<input name="content3B" required id="content3B" class="easyui-textbox" data-options="multiline:true"  style="width:99%;height:99%">
						</div>
				</div>
			
			</div>
			
		
			
		</div>
</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew2()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog2()">取消</a>
		</div>

</html>
