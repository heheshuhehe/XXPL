<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>场外投资标的净值查询</title>
    <script>document.documentElement.focus();</script>
    
</head>
<!-- 初始化操作 -->
<script type="text/javascript">
$(function (){
	$("#tabsidk").tabs({
		width : '98%' 
	});

	 $("#wbdg").datagrid({
	 	 width : '98%' 
	 });
	 $("#dg2").datagrid({
	 	 width : '98%' 
	 });
	 $("#dg3").datagrid({
	 	 width : '98%' 
	 });
	 $("#userInfo").combobox({
         valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo',
         method:'post',
         multiple:false,
		  multiline:true,
		  width:200,
		  onChange:function() {  
	            var valueField = $(this).combobox("options").valueField;  
	            var val = $(this).combobox("getValue");  //当前combobox的值  
	            var allData = $(this).combobox("getData");   //获取combobox所有数据  
	            var result = true;      //为true说明输入的值在下拉框数据中不存在  
	            for (var i = 0; i < allData.length; i++) {  
	                if (val == allData[i][valueField]) {  
	                    result = false;  
	                    break;  
	                }  
	            }  
	            if (result) {  
	                $(this).combobox("clear");  
	            }  
	      
	        },
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
function updateInfonew(){
	 //获取选中行
			var row = $('#dg3').datagrid('getSelected');
			if (row){
				
				 $('#yhdzhds').dialog('open');
	 			
			}
			else{
				$.messager.alert('提示','请先选中一行！');

			}


	 }
	 
function deleteInfonew(){
	 //获取选中行
			var row = $('#dg3').datagrid('getSelected');
			if (row){
				
				$.messager.confirm('删除', '确定要删除这条数据吗？', function(r){
					if (r){

						var code1=row.otccode;
						
						$.ajax({
							url:'<%=cp%>/guzhidz/tg4otcmanagecode',
							type:'post',
							data:{
								code:code1,oper:"d"
							},
							dataType: "json",
							success: function(data){
								if(data[0].info=="success"){  
									alert("删除成功");
									closeDialog();
									s_search();
									
								}else{
									alert("删除失败");
								}
								
							}
						});
						
						
					}
				});
				
			}
			else{
				$.messager.alert('提示','请先选中一行！');

			}


	 }
function addInfonew(){

				
				
				 $("#c_subj_code_u").textbox('setValue','');
				 $("#amac_code_u").textbox('setValue','');
				 $("#oper").textbox('setValue','a');
				
				 $('#yhdzhds').dialog('open');
		

	 }


function createwbdata(){
 	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+$("#wbzth").combobox('getValue')+"&userInfo="+$("#userInfo").combobox('getValues');
	$('#wbdg').datagrid({method:'get',url:'<%=cp%>/guzhidz/tg4otcmanage?'+params}).datagrid('clientPaging');
} 
function s_search(){
 //	var params="tgdate="+$("#tgdate").combobox('getValue')+"&oper=s";
	$('#dg3').datagrid({method:'get',url:'<%=cp%>/guzhidz/tg4otcmanagecode?oper=s'}).datagrid('clientPaging');
} 
function queryMXInfo(){
	var rows = $('#wbdg').datagrid('getSelections');
	if(rows.length==0){
		$.messager.alert('提示','没有选择任何数据!');
		return;
	}
	var ssinfo="";
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		ssinfo=ssinfo+"'"+row.vc_kmdm+"',";
	
	}
	$("#tabsidk").tabs('select', "需更新估值产品");
	
	var params="wbdate="+$("#wbdate").combobox('getValue')+"&wbzth="+$("#wbzth").combobox('getValue')+"&userInfo="+$("#userInfo").combobox('getValues');
	params=params+"&ssinfo="+ssinfo;
	$('#dg2').datagrid({method:'post',url:'<%=cp%>/guzhidz/tg4otcmanagebydown?'+params}).datagrid('clientPaging');
}
</script>
<script>
 $(function (){
			var curr_time = new Date();
			$("#wbdate").datebox("setValue", myformatter(curr_time));

			 //初始化table
			 $("#wbdg").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
			 //初始化table
			 $("#dg2").datagrid({
			 	 width : '100%',
		     	 height : document.documentElement.clientHeight-80
			 });
	});
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
			$("#c_subj_code_u").combobox('clear');
			$("#tgzth").combobox('clear');
		   $('#yhdzhds').dialog('close');
		 
	 } 
	 function saveInfonew(){
		   var oper=  $("#oper").textbox('getValue');
			var subj=  $("#c_subj_code_u").combobox('getValue');
			var text=  $("#c_subj_code_u").combobox('getText');
			var oldcode=$("#oldcode").combobox('getValue');
			var newcode=text.split('_');
			var code1='';
			var code2='';
			
			if(newcode.length<2){
				$.messager.alert('提示','请选择下拉列表的值，或者手工输入代码和名称，以下划线（_）间隔');
				return ;
			}
			code1=newcode[0];
			code2=text.replace(code1+"_","");
			
			
			$.ajax({
				url:'<%=cp%>/guzhidz/tg4otcmanagecode',
				type:'post',
				data:{
					code:code1,name:code2,oper:oper,oldcode:oldcode
				},
				dataType: "json",
				success: function(data){
					if(data[0].info=="success"){  
						alert("保存成功");
						closeDialog();
						s_search();
						
					}else{
						alert("保存失败");
					}
					
				}
			});
		}
	 function mailgo(){
		/* 	var rows = $('#wbdg').datagrid('getSelections');
			if(rows.length==0){
				$.messager.alert('提示','没有选择任何数据!');
				return;
			}
			var ssinfo="";
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				ssinfo=ssinfo+row.c_port_code+","+row.c_port_name+","+row.c_key_code+","+row.c_subj_name+","+row.gzlxr+"###";
				
			
			} */
			var params={wbdate:$("#wbdate").combobox('getValue'),
					ssinfo:'',
					userInfo:$("#userInfo").combobox('getValue')};
			$.ajax({
				url:'<%=cp%>/guzhidz/tg4otcmanagemail',
				type:'post',
				data:params,
				dataType: "json",
				success: function(data){
					if(data[0].msg=="success"){  
						alert("发送完成");
						
						
					}else{
						alert("发送失败");
					}
					
				}
			});
		}
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="场外投资标的净值" style="padding: 10px">
		<table>
				<tr>
				<td><span>日期</span>
				     <input id="wbdate" name="wbdate"
						class="easyui-datebox"
						data-options="formatter:myformatter1,parser:myparser"
						style="width: 120px"></input>
					 <span style="color: red;">*</span>
			     </td>
					<td>帐套名称：
					  <input class="easyui-combobox"
						name="wbzth" id="wbzth"
						 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('#wbzth').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 "
		               >
		               <span style="color: red;">*</span>
					   </td><td> <span>估值人员:</span>
			 <input class="easyui-combobox" name="userInfo" id="userInfo"></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="createwbdata()">查询</a>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="queryMXInfo()">反查产品</a>
								<a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-note_go'" onclick="mailgo()">发送提醒邮件</a>
					</td>		
				</tr>
		</table>
		 <div style="margin-top: 10px;">
			<table id="wbdg"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
					  <th data-options="field:'ck',checkbox:true"></th>
						<th field="l_fundid" >账套号</th>
						<th field="vc_name" >账套名称</th>	
						<th field="kflx" >开放类型</th>
						<th field="fwfw" >服务范围</th>											
						<th field="vc_kmdm" >标的代码</th>
						<th field="vc_kmmc" >标的名称</th>	
						<th field="vc_tpxx" >标的信息</th>	
						<th field="gzlxr" >估值联系人</th>	
						<th field="tggz" >估值人员</th>
						<th field="mailzt" >邮件状态</th>		
						
	
					</tr>
				</thead>
			</table>
	 </div>
    </div>
	<div title="需更新估值产品" style="padding: 10px">
	
	 <div style="margin-top: 10px;">
			<table id="dg2"  data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
				<thead>
					<tr>
						 
						<th field="l_fundid" >账套号</th>
						<th field="vc_name" >账套名称</th>																		
						<th field="vc_kmdm" >标的代码</th>
						<th field="vc_kmmc" >标的名称</th>	
						<th field="tggz" >估值人员</th>						
	
					</tr>
				</thead>
			</table>
	 </div>
	</div>	
    <div title="场外投资标的维护" style="padding: 10px">
				    
      <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="s_search()">查询</a>
     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="addInfonew()">新增</a>
     <!--   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="updateInfonew()">修改</a> -->
        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="deleteInfonew()">删除</a>
       
       	<table id="dg3" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>

						<th field="otccode" width="">科目代码</th>
						<th field="otcname" width="">科目名称</th>

					</tr>
				</thead>
			</table>
    </div>
 
</div>

  <div id="yhdzhds" class="easyui-dialog" closed="true" title="新增/修改场外标的"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
					帐套名称：
					  <input class="easyui-combobox"
						name="tgzth" id="tgzth"
						 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=02',
			                          method:'post',
									  multiple:false,
									  width:150,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('#wbzth').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     },
								     onChange:function(n,o){
								      $('#c_subj_code_u').combobox( 'reload','<%=cp%>/guzhidz/querySelectValue?selectType=tgkmselect&zth='+n)
								     	
								     }
									 "
		               >
		               <span style="color: red;">*</span><br/> <br/>
				<span style="margin-left: 0px">科目代码:</span>
			<span> 
			 	<input type="text" class="easyui-combobox" id="c_subj_code_u" name="c_subj_code_u" 
			 	 data-options="
				                      valueField: 'value',
									  textField: 'text',
									  mode:'local',
									  url:'<%=cp%>/guzhidz/querySelectValue?selectType=tgkmselect',
			                          method:'post',
									  multiple:false,
									  width:450,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q)>-1;
											},
									  onLoadSuccess: function(){
										 $('#wbzth').next('.combo').find('input').focus(function (){
									            $('#wbzth').combobox('clear');
									     });
								     }
									 ">
			 	<input type="hidden" class="easyui-textbox" id="oper" name="oper"  >
			 		<input type="hidden" class="easyui-combobox" id="oldcode" name="oldcode"  >
			</span>
			
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
</body>
</div>






