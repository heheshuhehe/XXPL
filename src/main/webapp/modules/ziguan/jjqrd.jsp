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
   	     height :document.documentElement.clientHeight-130
	 });	
	
	 
	 
 	 
 $('#tabsidk').tabs({
    border:false,
    onSelect:function(title,index){
        searchdata();

    }
});
	 
 

 $("#jtuser").combobox({
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
					 $('#jtuser').next('.combo').find('input').focus(function (){
				            $('#jtuser').combobox('clear');
				            
				     });
					 
			     }
 });
 

 })
	
</script>
<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
	
	if($("#wbdate").combobox('getValue')==''){
		$.messager.alert('提示','请选择日期！');
		return;
	}
		
    var params="wbdate="+$("#wbdate").combobox('getValue');
         
                    
    $('#dg').datagrid({method:'get',url:"ziguan/queryjjqrd?op=s&"+params}).datagrid('clientPaging'); 
}

function searchdata_e(){
	var row=$('#dg').datagrid('getSelected');
	
	if (row){
		
		$('#filepath_u').val(row.filepath);
	 	$('#filename_u').textbox('setValue',row.filename);
	 	$('#rq_u').val(row.jjrq);
	 	
	 	if(row.userid!='' &&row.userid!=null)
	 		$('#jtuser').combobox('select',row.userid);
	 	
		
		
		 $('#yhdzhds').dialog('open');
	}
	else{
		$.messager.alert('提示','请先选中一行！');

	}
         

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

	 

	 function closeDialog(){
	 	$('#filepath_u').val('');
	 	$('#rq_u').val('');
	 	$('#filename_u').textbox('clear');
	 	$('#jtuser').combobox('clear');
	 	$('#yhdzhds').dialog('close');

	 }
	 function saveInfonew(){

		   var filepath_u=  $("#filepath_u").val();
		   var rq_u=  $("#rq_u").val();
			var filename_u=  $("#filename_u").textbox('getValue');
		
			var jtuser=$("#jtuser").combobox('getValue');
			var op='u';


			$.ajax({
				url:'<%=cp%>/ziguan/queryjjqrd',
				type:'post',
				data:{
					filepath_u:filepath_u,filename_u:filename_u,jtuser:jtuser,op:op,rq_u:rq_u
				},
				dataType: "json",
				success: function(data){
					if(data[0].msg=="success"){  
						alert("保存成功");
						closeDialog();
						searchdata()
					}else{
						alert("保存失败");
					}
					
				}
			});
		
	 }

</script>
<body>
	<div id="tabsidk"  class="easyui-tabs" style="">
	 <div title="业绩报酬审核" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
				<div>
				<span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
				
				   
					
	 	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_e()">认领</a>
			
				</div>

			</div>
			<div style="margin-top: 10px;">
				<table id="dg" style="width: 777px; height: 480px"
					data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:100">
					<thead>
						<tr>
							<!-- <th data-options="field:'ck',checkbox:true"></th>  -->
							 <th field="jjrq" >日期</th>
							 <th field="filename" >文件名称</th>
							<th field="filepath" hidden="true">文件路径</th>
							<th field="username" >认领人员</th>
							<th field="userid" hidden="true" >认领</th>
							

													
						</tr>
					</thead>
				</table>
			</div>
		</div>
	
	


</div>

<div id="yhdzhds" class="easyui-dialog" closed="true" title="认领人员"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
						<input type="text"   id="filepath_u"  name="filepath_u" style="display: none" >
							<input type="text"   id="rq_u"  name="rq_u" style="display: none" >
							<span style="margin-left: 0px">文件名称:</span>
				
			<span> 
			 	<input type="text" class="easyui-textbox" id="filename_u" name="filename_u"  style="width: 400px" readonly="readonly">
			</span>
				 </br></br>
				<span style="margin-left: 0px">认领人员:</span>
			<span> 
			 		<input class="easyui-combobox" name="jtuser" id="jtuser"> 
			</span>
		
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)"    class="easyui-linkbutton"		onclick="saveInfonew()">保存</a> 
			<a href="javascript:void(0)"		class="easyui-linkbutton"	onclick="closeDialog()">取消</a>
		</div>
</body>



