<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>账套对应关系配置</title>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
	<script>document.documentElement.focus();</script>
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>
$(function (){
	    //初始化table
	 	 $("#dg").datagrid({
	 	 	 width : '100%',
	      	 height : document.documentElement.clientHeight-80
	 	 });
});
</script>

<!-- 自定义js -->
<script type="text/javascript">
function searchdata(){
  	 var params="wb_zth="+$("#wb_zth").combobox('getValue')+"&wb_ztmc="+$("#wb_zth").combobox('getText')+"&stus="+$("#ztstus").combobox('getValue');
	 $('#dg').datagrid({url:"<%=cp%>/guzhidz/getAccountMappingInfo?"+params}).datagrid('clientPaging'); 
}
function addAcountMapping(){
	
	var tg_zth=$("#tg_zth1").combobox('getValue');
	var wb_zth=$("#wb_zth1").combobox('getValue');
	var trade_branch=$("#trade_branch").combobox('getValue');
	var trade_branch_text=$("#trade_branch").combobox('getText');
	var gth=$("#gth").numberbox('getValue');
	var rzrq_gth=$("#rzrq_gth").numberbox('getValue');
	var  zts=$("#zts").combobox('getValue');
	var stock_option = $("#stock_option").numberbox('getValue');
	
	
	 var yjbc_date = $("#yjbc_date").textbox('getValue');
	 var yjbc_fl = $("#yjbc_fl").textbox('getValue');
	 var yjbc_kfq = $("#yjbc_kfq").textbox('getValue');
	 var yjbc_qt = $("#yjbc_qt").textbox('getValue');
	 var yjbc_fj = $("#yjbc_fj").combobox('getValue');
	 var dzfreq = $("#dzfreq").combobox('getValue');
	 var is_ppw=0;
	 if ($("#ppw_add")[0].checked)
		 is_ppw=1;
	 var dz_mail = $("#dz_mail").textbox('getValue');
	 var ma_mail = $("#ma_mail").textbox('getValue');
	 
	 
	 var report=$("#report_add").combobox('getValues');
	var report_fz=report.join(",");
	 
	if(wb_zth==""){
		alert("请选择外包账套名称");
		return false;
	}else if(trade_branch=="" || trade_branch=="0"){
		alert("请选择交易机构");
		return false;
	}else if(gth==-1){
		alert("请输入柜台号");
		return false;
	}else if(gth==""){
		alert("普通柜台号不能为空!");
		return false;
	}else if(yjbc_fj == "0"){
		alert("请选择是否分级");
	}
	else{
			$.ajax({
				url:'<%=cp%>/guzhidz/addAccountMapping',
				type:'post',
				data:{tg_zth:tg_zth,wb_zth:wb_zth,trade_branch:trade_branch_text,gth:gth,rzrq_gth:rzrq_gth,zts:zts,stock_option:stock_option,
					yjbc_date:yjbc_date,yjbc_fl:yjbc_fl,yjbc_kfq:yjbc_kfq,yjbc_qt:yjbc_qt,yjbc_fj:yjbc_fj,dzfreq:dzfreq,is_ppw:is_ppw,report_fz:report_fz,ma_mail:ma_mail,dz_mail:dz_mail},
				dataType: "json",
				success: function(data){
					if(data.msg="success"){
						alert("保存成功！");
						$('#dlg').dialog('close');
						closeDialog();
						searchdata();
					}else{
						alert("保存失败！");
					}
				}
			});
	}
}


function updateInfo(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		var tgzth = $("input[name='ck']:checked").closest("tr").find("td[field='tg_zth']");
		var wbzth = $("input[name='ck']:checked").closest("tr").find("td[field='wb_zth']");
		var gth = $("input[name='ck']:checked").closest("tr").find("td[field='gth']");
		var grouptype = $("input[name='ck']:checked").closest("tr").find("td[field='trade_branch']");
		var gth_lx = $("input[name='ck']:checked").closest("tr").find("td[field='gth_lx']");
		var rzrq_gth = $("input[name='ck']:checked").closest("tr").find("td[field='rzrq_gth']");
		var zt = $("input[name='ck']:checked").closest("tr").find("td[field='zt']");
		tgzth.find("div").html("<input type='text' value='"+tgzth.find("div").text()+"'></input>");
		wbzth.find("div").html("<input type='text' value='"+wbzth.find("div").text()+"'></input>");
		gth.find("div").html("<input type='text' value='"+gth.find("div").text()+"'></input>");
		rzrq_gth.find("div").html("<input type='text' value='"+rzrq_gth.find("div").text()+"'></input>");
		zt.find("div").html("<input type='text' value='"+rzrq_gth.find("div").text()+"'></input>");
		
		
		var trade_branch = grouptype.find("div").text();
		grouptype.find("div").html("<select><option value='1'>宏源</option><option value='2'>申万</option><option value='3'>其他</option></select>");
		if(trade_branch=="宏源"){
			grouptype.find("div").find("select").val("1");
		}else if(trade_branch=="申万"){
			grouptype.find("div").find("select").val("2");
		}else if(trade_branch=="其他"){
			grouptype.find("div").find("select").val("3");
		}
		
		/* var gth_lx_1 = gth_lx.find("div").text();
		gth_lx.find("div").html("<select><option value='1'>普通柜台</option><option value='2'>融资融券柜台</option></select>");
		if(gth_lx_1=="普通柜台"){
			gth_lx.find("div").find("select").val("1");
		}else if(gth_lx_1=="融资融券柜台"){
			gth_lx.find("div").find("select").val("2");
		} */
		$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
		$("input[name='ck']").prop("disabled",true);
	}
}


function updateInfonew(){
	 if($("input[name='ck']:checked").length!=1){
			alert("请选择一条记录！");
			return false;
		}else{
		var id = $("input[name='ck']:checked").val();
		$.ajax({
				url:'<%=cp%>/guzhidz/getAccountMappingInfoById',
				type:'post',
				data:{id:id},
				dataType: "json",
				success: function(data){
					if(data.msg="success"){
						 var json =data.data;
						 if(json.length>0){
						 var id=json[0].id;
						 $("#idnew").textbox('setValue',id);
						 $("#idnew").textbox('disable');
						 
						 var wb_zth=json[0].wb_zth;
						 $("#wb_zthnew").textbox('setValue',wb_zth);
						 
						 var wb_ztmc=json[0].wb_ztmc;
						 $("#wb_ztmcnew").textbox('setValue',wb_ztmc);
						 $("#wb_ztmcnew").textbox('disable');
						 
						 var tg_zth=json[0].tg_zth;
						 $("#tg_zthnew").textbox('setValue',tg_zth);
						  
						 var tg_ztmc=json[0].tg_ztmc;
						 $("#tg_ztmcnew").textbox('setValue',tg_ztmc);
						 $("#tg_ztmcnew").textbox('disable');
						 
						 var trade_branch=json[0].trade_branch;
						 $("#trade_branchnew").combobox('setText',trade_branch);
						 
						 var gth=json[0].gth;
						 $("#gthnew").textbox('setValue',gth);
						 
						 var rzrq_gth=json[0].rzrq_gth;
						 $("#rzrq_gthnew").textbox('setValue',rzrq_gth);
						 
						 var status=json[0].status;
						 $("#ztnew").combobox('setValue',status);
						 
						 var stockoption = json[0].stock_option;
						 $("#stockoption").textbox('setValue',stockoption);
						 
						 
						 var yjbc_date = json[0].yjbc_date;
						 $("#yjbc_date1").textbox('setValue',yjbc_date);
						 var yjbc_fl = json[0].yjbc_fl;
						 $("#yjbc_fl1").textbox('setValue',yjbc_fl);
						 var yjbc_kfq = json[0].yjbc_kfq;
						 $("#yjbc_kfq1").textbox('setValue',yjbc_kfq);
						 var yjbc_qt = json[0].yjbc_qt;
						 $("#yjbc_qt1").textbox('setValue',yjbc_qt);
						 
						 var dzfreq = json[0].dzfreq;
						 $("#dzfreq_update").combobox('setValue',dzfreq);
						 $("#dzfreq_update").combobox('setText',dzfreq);
						 
						 if(json[0].is_ppw==1){
							 $("#ppw_update")[0].checked=true;
						 }
						 
						 if(json[0].is_ppw==0){
							 $("#ppw_update")[0].checked=false;
						 }
						 $("#report_update").combobox('setValues',json[0].report_fz);
						 $("#ma_mail_update").textbox('setValue',json[0].ma_mail);
						 $("#dz_mail_update").textbox('setValue',json[0].dz_mail);
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						}
					}
				}
			});
			$('#yhdzhds').dialog('open');
	 }
	 }

function saveInfonew(){
 var  idnew=$("#idnew").textbox('getValue');
 var  wb_zthnew=$("#wb_zthnew").textbox('getValue');
 var  wb_ztmcnew=$("#wb_ztmcnew").textbox('getValue');
 var  tg_zthnew=$("#tg_zthnew").textbox('getValue');
 var  tg_ztmcnew=$("#tg_ztmcnew").textbox('getValue');
 var  trade_branchnew=$("#trade_branchnew").combobox('getText');
 var  gthnew = $("#gthnew").textbox('getValue');
 var  rzrq_gthnew = $("#rzrq_gthnew").textbox('getValue');
 var  ztnew=$("#ztnew").combobox('getValue');
 var stockoption = $("#stockoption").textbox('getValue');
 
 var yjbc_date1 = $("#yjbc_date1").textbox('getValue');
 var yjbc_fl1 = $("#yjbc_fl1").textbox('getValue');
 var yjbc_kfq1 = $("#yjbc_kfq1").textbox('getValue');
 var yjbc_qt1 = $("#yjbc_qt1").textbox('getValue');
 var  dzfreq_update=$("#dzfreq_update").combobox('getValue');
 
 var is_ppw_u;
 if($("#ppw_update")[0].checked)
	 is_ppw_u="1";
 else is_ppw_u=0;
 
 var report_update= $("#report_update").combobox('getValues').join(",");
 var dz_mail = $("#dz_mail_update").textbox('getValue');
 var ma_mail = $("#ma_mail_update").textbox('getValue');
 
 
 if(isNaN(gthnew)){
	alert("柜台号为数字！");
	return false;
 }else if(gthnew==""){
		alert("普通柜台号不能为空!");
		return false;
  }else {
	$.ajax({
		url:'<%=cp%>/guzhidz/updateAccountMappingnew',
		type:'post',
		data:{idnew:idnew,wb_zthnew:wb_zthnew,wb_ztmcnew:wb_ztmcnew,tg_zthnew:tg_zthnew,tg_ztmcnew:tg_ztmcnew,trade_branchnew:trade_branchnew,
			gthnew:gthnew,rzrq_gthnew:rzrq_gthnew,ztnew:ztnew,stockoption:stockoption,
			yjbc_date1:yjbc_date1,yjbc_fl1:yjbc_fl1,yjbc_kfq1:yjbc_kfq1,yjbc_qt1:yjbc_qt1,dzfreq_update:dzfreq_update,is_ppw_u:is_ppw_u,report_update:report_update,dz_mail:dz_mail,ma_mail:ma_mail
			},
		dataType: "json",
		success: function(data){
			if(data.msg=="success"){  
				alert("保存成功");
				
				searchdata();
				closeDialog();
				
			}else{
				alert("保存失败");
			}
			
		}
	});
}

}
function saveInfo(){
	var id = $("input[name='ck']:checked").closest("tr").find("td[field='id']").text();
	var tgzth = $("input[name='ck']:checked").closest("tr").find("td[field='tg_zth']").find("input").val();
	var wbzth = $("input[name='ck']:checked").closest("tr").find("td[field='wb_zth']").find("input").val();
	var gth = $("input[name='ck']:checked").closest("tr").find("td[field='gth']").find("input").val();
	var grouptype = $("input[name='ck']:checked").closest("tr").find("td[field='trade_branch']").find("select").val();
	var gth_lx = $("input[name='ck']:checked").closest("tr").find("td[field='gth_lx']").find("select").val();
	var rzrq_gth = $("input[name='ck']:checked").closest("tr").find("td[field='rzrq_gth']").find("input").val();
	var zt = $("input[name='ck']:checked").closest("tr").find("td[field='zt']").find("input").val();
	
	
	
	
	
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条要修改的记录！");
		return false;
	}else if(typeof(tgzth)=="undefined"||typeof(wbzth)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}else if(isNaN(gth)){
		alert("柜台号为数字！");
		return false;
	}else if(gth==""){
		alert("普通柜台号不能为空!");
		return false;
	}
	else{
		$.ajax({
			url:'<%=cp%>/guzhidz/updateAccountMapping',
			type:'post',
			data:{id:id,tgzth:tgzth,wbzth:wbzth,gth:gth,trade_branch:grouptype,gth_lx:gth_lx,rzrq_gth:rzrq_gth,zt:zt},
			dataType: "json",
			success: function(data){
				if(data.msg=="success"){  
					alert("操作成功");
				 	$('#dg').datagrid('reload');
				}else{
					alert("操作失败");
				}
				
			}
		});
	}
}
function opendialog(){

	$("#tg_zth1").combobox({
		  valueField: 'value',
		  textField: 'text',
		  mode:'local',
		  url:'<%=cp%>/guzhidz/querySelectVal?selectType=queryTGZTH&isnull=Y',
          method:'post',
		  multiple:false,
		  width:200,
		  filter: function(q, row){
					var opts = $(this).combobox('options');
					return row[opts.textField].indexOf(q) >-1;
				}
    });
	$("#wb_zth1").combobox({
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
    });
	
	
	$('#dlg').dialog('open');
}

function closeDialog(){
	$('#trade_branch').combobox('clear');
	$('#tg_zth1').combobox('clear');
	$('#wb_zth1').combobox('clear');
	$('#gth').numberbox('clear');
	$('#dlg').dialog('close');
	$('#rzrq_gth').numberbox('clear');
	$('#yhdzhds').dialog('close');
	$("#trade_branchnew").combobox('clear');
	
	$("#yjbc_date").textbox('clear');
	$("#yjbc_fl").textbox('clear');
	$("#yjbc_kfq").textbox('clear');
	$("#yjbc_qt").textbox('clear');
	$("#stock_option").numberbox('clear');
 	$("#ppw_add").attr('checked',false)
 	$("#dzfreq").combobox('clear');
	$("#report_add").combobox('clear');
 	$("#dz_mail").textbox('clear');
 	$("#ma_mail").textbox('clear');
}


function delInfo(){
	var id = $("input[name='ck']:checked").closest("tr").find("td[field='id']").text();
	if($("input[name='ck']:checked").length!=1){
		alert("请选择一条记录！");
		return false;
	}else{
		if(confirm("确定要删除吗？")){
			$.ajax({
				url:'<%=cp%>/guzhidz/deleteAccountMapping',
				type : 'post',
				data : {id : id},
				dataType : "json",
				success : function(data) {
						alert("删除成功！");
						searchdata();
				}
			});
		}
	}

}
</script>
 
 <body> 
	   <div id="tabsidk" >
			<div title="账套对应关系配置" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;">
					  <span>外包账套名称:</span>
					  <input class="easyui-combobox" name="wb_zth" id="wb_zth"
						data-options="
			                      valueField: 'value',
								  textField: 'text',
								  mode:'local',
								  url:'<%=cp%>/guzhidz/querySelectVal?selectType=02',
		                          method:'post',
								  multiple:false,
								  width:250,
								  filter: function(q, row){
											var opts = $(this).combobox('options');
											return row[opts.textField].indexOf(q) >-1;
										},
						         onLoadSuccess:function(){
									 $('#wb_zth').next('.combo').find('input').focus(function (){
									            $('#wb_zth').combobox('clear');
									 });
							     }
					  ">
					 
					状态： <input class="easyui-combobox" name="ztstus"
						id="ztstus"
						data-options="
						                     valueField: 'value',
 											 textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/StatusBox',
					                          method:'post',
											  multiple:false,
											  width:120,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}
			    ">
					 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="opendialog()">添加</a> 
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="updateInfonew()">修改</a> 
					<!-- <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveInfo()">保存</a>  -->
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="delInfo()">删除</a>
				</div>
				<div style="margin-top: 10px;">
					<table  id="dg"  
						data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:50">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th field="id" width="50" >ID</th>
								<th field="wb_zth" width="70" >外包账套号</th>
								<th field="wb_ztmc" width="200" >外包账套名称</th>
								<th field="tg_zth" width="70" >托管账套号</th>
								<th field="tg_ztmc" width="200" >托管账套名称</th>
								<th field="trade_branch" width="60">交易机构</th>
								<th field="gth" width="100">普通柜台号</th>
								<!-- <th field="gth_lx" width="150">柜台号类型</th> -->
								<th field="rzrq_gth" width="150">融资融券柜台号</th>
								<th field="stock_option" width="150">个股期权柜台号</th>
								<th field="zt" width="85" >状态</th>
								<th field="yjbc_date"   >业绩报酬时间</th>
								<th field="dzfreq"   >对账频率</th>
								<th field="yjbc_fl"  >业绩报酬费率</th>
								<th field="yjbc_kfq"   >开放期</th>
								<th field="yjbc_qt"   >其他</th>
								<th field="is_ppw"   hidden=true  >发送拍拍网（0否1是）</th>
								<th field="report_fz"   >发送频率</th>
								<th field="dz_mail"   >对账邮箱</th>
								<th field="ma_mail"   >管理人邮箱</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
         <!-- dialog弹出框 -->
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
			<span>
				<select id="trade_branch" class="easyui-combobox" name="trade_branch" style="width: 175px;">
					<option value="0">--请选择--</option>
					<option value="1">申万</option>
					<option value="2">宏源</option>
					<option value="3">其他</option>
				</select>
			</span>
			
			<!-- <span style="margin-left: 90px">柜台号类型:</span>
			
			<span>
				<select id="gth_lx" class="easyui-combobox" name="gth_lx" style="width: 175px;">
					<option value="">--请选择--</option>
					<option value="1">普通柜台</option>
					<option value="2">融资融券柜台</option>
				</select>
			</span>
			<br/><br/> -->
			
			<span style="margin-left: 75px">融资融券柜台号:</span>
			<span> 
			 	<input type="text" class="easyui-numberbox" id="rzrq_gth" name="rzrq_gth">
			</span>
			<br/><br/>
			
			<span>普通柜台号:</span>
			<span> 
			 	<input type="text" class="easyui-numberbox" id="gth" name="gth">
			</span>
			<!--  <span>状&nbsp;&nbsp;态:&nbsp;&nbsp;</span> 
			<span> 
				 <input class="easyui-combobox" name="zts" id="zts"/>
			</span>  -->
			
			<span style="margin-left: 75px">个股期权柜台号:</span>
			<span> 
			 	<input type="text" class="easyui-numberbox" id="stock_option" name="stock_option">
			</span>
			<br/><br/>
			<span>状&nbsp; 态:&nbsp; </span>
			<span> 
				<input class="easyui-combobox" name="zts"
						id="zts"
						data-options="
						                     valueField: 'value',
 											 textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/StatusBox',
					                          method:'post',
											  multiple:false,
											  width:200,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}
			    ">
						 
			</span>
			<span style="margin-left: 75px">计提业绩报酬时间:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_date" name="yjbc_date">
			</span>
			<br><br>
			<span style="margin-left: 0px">业绩报酬费率:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_fl" name="yjbc_fl">
			</span>
			<span style="margin-left: 75px">开放期:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_kfq" name="yjbc_kfq">
			</span>
			<br><br>
			<span style="margin-left: 0px">其他</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_qt" name="yjbc_qt">
			</span>
			<span style="margin-left: 100px">分级:</span>
			<span>
				<select id="yjbc_fj" class="easyui-combobox" name="yjbc_fj" style="width: 175px;">
					<option value="0">--请选择--</option>
					<option value="2">无分级</option>
					<option value="1">有分级</option>
					<option value="">空</option>
				</select>
			</span><br></br>
				<span style="display: none"> 
			 	<input type="checkbox"   id="ppw_add" name="ppw_add">
			
			<span style="margin-left: 0px">是否拍拍网公布</span> </span>
			<span >对账频率:</span>
			<span>
				<select id="dzfreq" class="easyui-combobox" name="dzfreq" style="width: 80px;">
					<option value="0">--请选择--</option>
					<option value="T+1">T+1</option>
					<option value="T+2">T+2</option>
					<option value="T+N">T+N</option>
				</select>
			</span>
		
			<span style="margin-left: 100px">估值表发送分组</span>
			<span> 
			 	<input class="easyui-combobox"  style="width: 200px" id ="report_add" 	name="report_add"	data-options="url:'<%=cp%>/guzhidz/getGroupName',
					valueField:'datacode',
					textField:'datavalue',
					multiple:true,
					panelHeight:'auto'
			">

			</span>
			<br /> 	<br />
			<span style="margin-left: 0px">对账邮箱(多个用分号分隔):</span>
			<span> 
			 	<input type="text" style="width:400px" class="easyui-textbox" id="dz_mail" name="dz_mail">
			</span></br></br>
			<span style="margin-left: 0px">管理人邮箱(多个用分号分隔):</sp an>
			<span> 
			 	<input type="text"   style="width:400px"  class="easyui-textbox" id="ma_mail" name="ma_mail">
			</span>
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="addAcountMapping()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
		<!-- 修改弹框 -->
		<div id="yhdzhds" class="easyui-dialog" closed="true" title="修改账套对应关系"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons'
					">
			<span  >&nbsp;&nbsp;I&nbspD:&nbsp;&nbsp;&nbsp;</span> 
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="idnew" id="idnew" data-options="multiline:true"/>
			</span>
			<span  style="margin-left: 75px">外包账套号:</span> 	
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="wb_zthnew" id="wb_zthnew" data-options="multiline:true"/>
			</span> 
			<br></br>
			<span>外包账套名称:&nbsp;</span> 
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="wb_ztmcnew" id="wb_ztmcnew" data-options="multiline:true"/>
			</span>  
			<span style="margin-left: 75px">托管账套号:</span> 
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="tg_zthnew" id="tg_zthnew" data-options="multiline:true"/>
			</span>
			<br></br>
			<span>托管账套名称:&nbsp;</span> 
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="tg_ztmcnew" id="tg_ztmcnew" data-options="multiline:true"/>
			</span>  
			<span style="margin-left: 75px">&nbsp;交易机构:</span> 
			<span>
				<select id="trade_branchnew" class="easyui-combobox" name="trade_branchnew" style="width: 175px;">
					<option value="0">--请选择--</option>
					<option value="1">申万</option>
					<option value="2">宏源</option>
					<option value="3">其他</option>
				</select>
			</span>
			<br></br>
			<span>&nbsp;普通柜台号:&nbsp;</span> 
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="gthnew" id="gthnew" data-options="multiline:true"/>
			</span>
			<span style="color: red;">*</span>
			<span style="margin-left: 75px">状&nbsp;&nbsp;态:</span>
			<span> 
				<input class="easyui-combobox" name="ztnew"
						id="ztnew"
						data-options="
						                     valueField: 'value',
 											 textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/StatusBox',
					                          method:'post',
											  multiple:false,
											  width:175,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													}
			    ">
						 
			</span>
			<br></br>
			<span style="width:175px">融资融券柜台号:</span> 
			<span> 
				<input  style="width:175px" type="text" class="easyui-textbox"    name="rzrq_gthnew" id="rzrq_gthnew" data-options="multiline:true"/>
			</span>
			<span style="margin-left: 75px">个股期权柜台号:</span>
			<span> 
			 	<input style="width:175px" type="text" class="easyui-textbox"   id="stockoption"  name="stockoption" data-options="multiline:true"/>
			</span>
			<br/><br/>
			
			<span style="margin-left: 0px">计提业绩报酬时间:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_date1" name="yjbc_date1">
			</span>
			<span style="margin-left: 75px">业绩报酬费率:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_fl1" name="yjbc_fl1">
			</span>
			<br/><br/>
			<span style="margin-left: 0px">开放期:</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_kfq1" name="yjbc_kfq1">
			</span>
			<span style="margin-left: 75px">其他</span>
			<span> 
			 	<input type="text" class="easyui-textbox" id="yjbc_qt1" name="yjbc_qt1">
			</span>
			
			
			<br></br>
				<span style="display: none"> 
			 	<input type="checkbox"   id="ppw_update" name="ppw_update">
			
			<span style="margin-left: 0px">是否拍拍网公布</span> </span>
			<span >对账频率:</span>
			<span>
				<select id="dzfreq_update" class="easyui-combobox" name="dzfreq_update" style="width: 80px;">
					<option value="0">--请选择--</option>
					<option value="T+1">T+1</option>
					<option value="T+2">T+2</option>
					<option value="T+N">T+N</option>
				</select>
			</span>
		
			<span style="margin-left: 100px">估值表发送分组</span>
			<span> 
			 	<input class="easyui-combobox"  style="width: 200px" id ="report_update" 	name="report_update"	data-options="url:'<%=cp%>/guzhidz/getGroupName',
					valueField:'datacode',
					textField:'datavalue',
					multiple:true,
					panelHeight:'auto'
			">

			</span>
			<br /> 	<br />
			<span style="margin-left: 0px">对账邮箱(多个用分号分隔):</span>
			<span> 
			 	<input type="text" style="width:400px" class="easyui-textbox" id="dz_mail_update" name="dz_mail_update">
			</span></br></br>
			<span style="margin-left: 0px">管理人邮箱(多个用分号分隔):</span>
			<span> 
			 	<input type="text"   style="width:400px"  class="easyui-textbox" id="ma_mail_update" name="ma_mail_update">
			</span>
			
			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew()">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
 </body>
</html>





