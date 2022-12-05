/*查询清单明细*/
function searchdata(type, prefix){
	var heDuiBuYiZhi = ""; 
	var heDuiYiZhi = "";
	if($("input[name='heDuiBuYiZhi']:checked").length>0){
		heDuiBuYiZhi = "&heDuiBuYiZhi=2"
	}
	if (type=='minfo'){
		if ($("#monthNO").combobox('getText')==''  ){
			alert ('请选择月份');
			$("#monthNO").focus();
		}else if ($("#monthNO").combobox('getText').length!=6){
			alert ('请输入合法月份, 如 '+'202012');
		}else {	//合法月份
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
		   	params = "dateNO="+$("#monthNO").combobox('getText')+"&waiBoOrTuoGuan=wb"+heDuiBuYiZhi+"&fundName="+$("#fundName").combobox('getText')
		    +"&serv_scop="+$("#serv_scop").combobox('getText')+"&gzry="+$("#guzhirenyuan").combobox('getText')
		   	+"&isPrinted="+$("#isPrinted").combobox('getValue')+"&data_chk_rslt_code="+$("#data_chk_rslt_code").combobox('getText') //.combobox('getText')
			+"&ivsp_chk_rslt_code="+$("#ivsp_chk_rslt_code").combobox('getText')
		   	+"&reportType=M";
			$('#heduiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchYueBao?"+params}).datagrid('clientPaging'); 
		}		
	}
	if (type=='mMingXi'){
		if($("input[name='heDuiYiZhi']:checked").length>0){
			heDuiYiZhi = "&heDuiYiZhi=yes"
		}
		if ($("#monthNOMingXi").combobox('getText')==''  ){
			alert ('请选择月份');
			$("#monthNOMingXi").focus();
		}else if ($("#monthNOMingXi").combobox('getText').length!=6){
			alert ('请输入合法月份, 如 '+'202012');
		}else {	//合法月份
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			 var params =  "dateNO="+$("#monthNOMingXi").combobox('getText')+heDuiYiZhi+"&fundName="+$("#fundNameMingxi").combobox('getText')+"&reportType=month";
			 $('#mingXiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchMingXi?"+params}).datagrid('clientPaging'); 
		}		
	}
	if (type=='qinfo'){
		if ($("#quaterNO").combobox('getText')==''  ){
			alert ('请选择季度');
			$("#quaterNO").focus();
		}else if ($("#quaterNO").combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202003');
		}else {	//合法月份
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
		   	params = "dateNO="+$("#quaterNO").combobox('getText')+"&fund_Code=2039&waiBoOrTuoGuan=wb"+heDuiBuYiZhi+"&fundName="+$("#fundName").combobox('getText')
		    +"&serv_scop="+$("#serv_scop").combobox('getText')+"&gzry="+$("#guzhirenyuan").combobox('getText')
		   	+"&isPrinted="+$("#isPrinted").combobox('getValue')+"&data_chk_rslt_code="+$("#data_chk_rslt_code").combobox('getText')
			+"&ivsp_chk_rslt_code="+$("#ivsp_chk_rslt_code").combobox('getText')
		   	+"&reportType=Q";
			$('#jibaoheduiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchYueBao?"+params}).datagrid('clientPaging'); 
		}		
	}
	if (type=='qMingXi'){
		if($("input[name='heDuiYiZhi']:checked").length>0){
			heDuiYiZhi = "&heDuiYiZhi=yes"
		}
		if ($("#quaterNOMingXi").combobox('getText')==''  ){
			alert ('请选择季度');
			$("#quaterNOMingXi").focus();
		}else if ($("#quaterNOMingXi").combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202009');
		}else {	//合法季度
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			 var params =  "dateNO="+$("#quaterNOMingXi").combobox('getText')+heDuiYiZhi+"&fundName="+$("#fundNameMingxi").combobox('getText')+"&reportType=quater";
			 $('#jibaomingXiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchMingXi?"+params}).datagrid('clientPaging'); 
		}		
	}
	
	if (type=='quinfo'){
		if ($("#quaterNO").combobox('getText')==''  ){
			alert ('请选择季度');
			$("#quaterNO").focus();
		}else if ($("#quaterNO").combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202003');
		}else {	//合法月份
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			params = "dateNO="+$("#quaterNO").combobox('getText')+"&fund_Code=2039&waiBoOrTuoGuan=wb"+heDuiBuYiZhi+"&fundName="+$("#fundName").combobox('getText')
		    +"&serv_scop="+$("#serv_scop").combobox('getText')+"&gzry="+$("#guzhirenyuan").combobox('getText')
		   	+"&isPrinted="+$("#isPrinted").combobox('getValue')+"&data_chk_rslt_code="+$("#data_chk_rslt_code").combobox('getText')
			+"&ivsp_chk_rslt_code="+$("#ivsp_chk_rslt_code").combobox('getText')
		   	+"&reportType=QU";
			$('#jidugengxinheduiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchYueBao?"+params}).datagrid('clientPaging'); 
		}		
	}
	if (type=='quMingXi'){
		if($("input[name='heDuiYiZhi']:checked").length>0){
			heDuiYiZhi = "&heDuiYiZhi=yes"
		}
		if ($("#quaterNOMingXi").combobox('getText')==''  ){
			alert ('请选择季度');
			$("#quaterNOMingXi").focus();
		}else if ($("#quaterNOMingXi").combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202003');
		}else {	//合法季度
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			 var params =  "dateNO="+$("#quaterNOMingXi").combobox('getText')+heDuiYiZhi+"&fundName="+$("#fundNameMingxi").combobox('getText')+"&reportType=quaterlyUpdate";
			 $('#qumingXiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchMingXi?"+params}).datagrid('clientPaging'); 
		}		
	}

	if (type=='hsrinfo'){
		if ($("#hsrNO").combobox('getText')==''  ){
			alert ('请选择季度');
			$("#hsrNO").focus();
		}else if ($("#hsrNO").combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202003');
		}else {	//合法月份
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			params = "dateNO="+$("#hsrNO").combobox('getText')+"&fund_Code=2039&waiBoOrTuoGuan=wb"+heDuiBuYiZhi+"&fundName="+$("#fundName").combobox('getText')
		    +"&serv_scop="+$("#serv_scop").combobox('getText')+"&gzry="+$("#guzhirenyuan").combobox('getText')
		   	+"&isPrinted="+$("#isPrinted").combobox('getValue')+"&data_chk_rslt_code="+$("#data_chk_rslt_code").combobox('getText')
			+"&ivsp_chk_rslt_code="+$("#ivsp_chk_rslt_code").combobox('getText')
		   	+"&reportType=HSR";
			$('#heduiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchYueBao?"+params}).datagrid('clientPaging'); 
		}		
	}
	if (type=='hsrMingXi'){
		if($("input[name='heDuiYiZhi']:checked").length>0){
			heDuiYiZhi = "&heDuiYiZhi=yes"
		}
		if ($("#hsrNOMingXi").combobox('getText')==''  ){
			alert ('请选择季度');
			$("#hsrNOMingXi").focus();
		}else if ($("#hsrNOMingXi").combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202003');
		}else {	//合法季度
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			 var params =  "dateNO="+$("#hsrNOMingXi").combobox('getText')+heDuiYiZhi+"&fundName="+$("#fundNameMingxi").combobox('getText')+"&reportType=HSR";
			 $('#hsrmingXiTable').datagrid({method:'post',url:prefix+"/xinxipilu/searchMingXi?"+params}).datagrid('clientPaging'); 
		}		
	}	
}

/*查询清单明细*/
function searchManagerMingXi(type, prefix,tableName,dateNO){
//		if (type=='quant'){
		if ($(managerName).combobox('getText')==''  ){
			alert ('请选择日期');
			$(dateNO).focus();
		}
		if($("input[name='heDuiYiZhi']:checked").length>0){
			heDuiYiZhi = "&heDuiYiZhi=yes"
		}
		if ($(dateNO).combobox('getText')==''  ){
			alert ('请选择日期');
			$(dateNO).focus();
		}else if ($(dateNO).combobox('getText').length!=6){
			alert ('请输入合法日期, 如 '+'202003');
		}else {	//合法季度
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
			 var params =  "dateNO="+$(dateNO).combobox('getText')+heDuiYiZhi+"&fundName="+$("#fundNameMingxi").combobox('getText')+"&reportType="+type;
			 $(tableName).datagrid({method:'post',url:prefix+"/xinxipilu/searchMingXi?"+params}).datagrid('clientPaging'); 
		}		
//	}	
}

function exportExcel(reportType,prefixURL,tableName,dateNO){
	alert ('its in'+reportType+' '+prefixURL+' '+tableName+ dateNO);
	return ;
}


/*发送吉贝克校验并返回结果*/
function generateAndPushToJBK(reportType, mandatory, prefixURL,tableName,dateNO){
 	var rows = $(tableName).datagrid('getChecked');//.datagrid('getSelected');row
	var dateNOString ="";
	if (dateNO!=null && dateNO!='' && dateNO!= undefined){
		dateNOString=$(dateNO).combobox('getText');
	}
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}
	 if( mandatory==1 && $("input[name='ck']:checked").length>1){
		alert("强制生成一次只能选择一条要修改的记录");
		return false;
	} 
	var msg = "推送 "+$("input[name='ck']:checked").length + " 条基金？";
	$.messager.confirm("确认", msg, function (r) {
		if (r) {	//点击确认继续
			$.messager.progress({
			title: '生成报告',
			text: '正在生成报告，请稍后....'
			});
			$.post(
				prefixURL+"/xinxipilu/notifyJiBeKeRept?"+"report_type="+reportType+"&mandatory="+mandatory+"&date_no="+dateNOString,
				{"data":JSON.stringify(rows)},　　　　　　　　　　　//提交的数据是把上面的hero转化为json格式
				function(data) { 
					$.messager.progress('close');
					console.log('data.code is '+data.code);
					console.log('data.message is '+data.message);
					console.log('data.wrongList is '+data.wrongList);
				    if(data) {
						var errorCode = data.code;
						var json=eval(data.wrongList);
						var wrongMessage="";
						if (json !=undefined)
						for(var i=0; i<json.length; i++) { 
								wrongMessage +=(json[i].fund_code+" " + json[i].errorMSG+"\n"); 
							} 
						if (errorCode==200){
							if (data.errorNum==0){
								alert ('尝试推送'+ data.totalNum+'条数据， '+'失败'+data.errorNum+'条。\n'); 							
							}else {
								alert ('尝试推送'+ data.totalNum+'条数据， '+'失败'+data.errorNum+'条。\n'+'详细错误包括：\n'+wrongMessage); 
							}	
						}
						if (errorCode==501){	//强制推送
							alert ('强制推送失败，只有财务指标错误才可以强制推送 \n'+wrongMessage); 
						}
						if (errorCode==300){
							alert ('由于其他原因，尝试推送'+ data.totalNum+'条数据， '+'失败'+data.errorNum+'条。\n'+'可能错误包括：\n'+wrongMessage); 
						}
						if (errorCode<200 || errorCode >510){
							alert ('由于其他原因，尝试推送'+ data.totalNum+'条数据， '+'失败'+data.errorNum+'条。\n'+'可能错误包括：\n'+wrongMessage); 
						}
				    } else {
				       	alert("未能成功提交导出请求，请联系系统人员");
				    }
					searchfunds(tableName,prefixURL,reportType,dateNO); 
				}); 
			}else {	//点击取消退出
				return false;
			}
		});
}

/*明细表修改数据*/
function modifyOrConfrim(reportType,prefixURL,modifyType,tableName){
	var rows = $(tableName).datagrid('getChecked');//.datagrid('getSelected');row
	var length = $("input[name='ck']:checked").length;
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}
	var checkFlag=true;
	var wrongphrase="";
	var i=0;
	if (modifyType ==3){
		for( i=0; i<rows.length; i++){
			if ( rows[i].indx_type_code == 'N' && !isNumber( rows[i].upd_aft_data) && rows[i].upd_aft_data!='null' ){
				wrongphrase+=rows[i].indx_name+" 必须是数字！\n";
				checkFlag=false;
				continue;
			} 
			if (rows[i].upd_aft_data == ''){
				checkFlag=false;
				wrongphrase+=rows[i].indx_name+" 不能为空，若填写空值请使填写单词 null \n";
				continue;
			}
		}
		if (!checkFlag){
			alert (wrongphrase);
			return false;
		}
	}
	length=length;
	var msg = '点击确认将会变更 '+i+' 条数据，是否继续？';
	$.messager.confirm("确认", msg, function (r) {
        if (r) {
            $.post(
	       	prefixURL+"/xinxipilu/modifyData?modifyType="+modifyType+"&reportType="+reportType,
	        {"data":JSON.stringify(rows)},　　　　　　　　　　　//提交的数据是把上面的hero转化为json格式
	        function(data) { 
	        	if(data) {
	        		//console.log("data is "+data);
	        		if (data.indexOf("success")>=0) {
	        			alert("修改成功");
	        		} else{
	        			alert(data.replace('fail=',''));
	        			return;
	        		}
        			$(tableName).datagrid('reload'); 
	        	} else {
	        		alert("修改失败");
	        	}
			}); 
        }
		else{
			return false;
		}
    });
}


//	判断是否未数字
function isNumber(target){
	if (target==null || target ==null) {return false;}
	if(!isNaN(target)){ return true;}　　
	return false;　　
}


/**
 * 动态地将字体变红
 */
function turnRed(val,row){
 	if (val == '核对不一致'){
 		return '<span style="color:red;">'+val+'</span>';
 	} else {
		return val;
	} 
}


/* 鼠标悬停 */
function addMessageBox(val,row){
	validVal= "'"+val+"'"; 
	return '<span title="' +val+'" class="easyui-tooltip">'+val+'</span>'
	//return '<a href="javascript:void(0);" onclick="	alert(' +validVal+')">'+val+'</a>';
}

/**
 * 导出3份文件
function exportFiles(){
	var rows = $('#jidugengxinheduiTable').datagrid('getChecked');//.datagrid('getSelected');row
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}else{
		$.post(
		       	"<%=cp%>/xinxipilu/generate3Files?reportType=quaterUpdate&isRecollect=1",
		        {"data":JSON.stringify(rows)},　　　　　　　　　　　//提交的数据是把上面的hero转化为json格式
		        function(data) { 
		        	if(data) {
		        		//console.log("data is "+data);
		        		if (data.indexOf("success")>=0) {
		        			alert("提交成功，请稍后在共享盘中查看文件");
		        		} else{
		        			alert(data.replace('fail=',''));
		        			return;
		        		}
		        	} else {
		        		alert("未能成功提交导出请求，请联系系统人员");
		        	}
		}); 
		$('#jidugengxinheduiTable').datagrid('reload'); 
	}
} */

/**
 * 重新采集数据，导入外包和ta信息
 */
function recollection(tableName,prefix,reportType,dateNO ){
	var rows = $(tableName).datagrid('getChecked');//.datagrid('getSelected');row
	if($("input[name='ck']:checked").length<1){
		alert("请至少选择一条要修改的记录！");
		return false;
	}else{		
		$.messager.progress({
			title: '重新采集',
			text: '正在重新采集外包托管数据中，请稍后....'
		});
		$.post(
		       	prefix+"/xinxipilu/recollection?reportType="+reportType,
		        {"data":JSON.stringify(rows)},　　　　　　　　　　　//提交的数据是把上面的hero转化为json格式
		        function(data) { 
					$.messager.progress('close');
		        	if(data) {
					    alert("重新采集完成,点击确认重新刷新页面");
						searchfunds(tableName,prefix,reportType,dateNO); 
		        	} else {
		        		alert("重新采集失败");
		        	}
		}); 
		
	}
}

//查询特定产品
function searchfunds(tableName,prefix,reportType,dateNO){
	var dateNOString=$(dateNO).combobox('getText');
	var rows = $(tableName).datagrid('getChecked');
	var datastr = "";
	if($("input[name='ck']:checked").length<1){
		return false;
	}
	datastr = rows[0].fund_code;
	for (var i=1; i<rows.length; i++){''
		datastr = datastr + "," +rows[i].fund_code;
	}
	params = "dateNO="+dateNOString+"&reportType="+reportType + "&data="+datastr;	
	$(tableName).datagrid({method:'post',url:prefix+"/xinxipilu/searchFunds?"+params}).datagrid('clientPaging'); 
}

function exportDiscSitu(type, prefix,dateNO){
	var heDuiBuYiZhi = ""; 
	var heDuiYiZhi = "";
	if($("input[name='heDuiBuYiZhi']:checked").length>0){
		heDuiBuYiZhi = "&heDuiBuYiZhi=2"
	}
	/*if (type=='q'){*/
		if ($(dateNO).combobox('getText')==''  ){
			alert ('请选择季度');
			$(date_no).focus();
		}else if ($(dateNO).combobox('getText').length!=6){
			alert ('请输入合法季度, 如 '+'202003');
		}else {	//合法月份
		   	//var params="fund_name="+$("#fund_name").combobox('getText')+"&groupType="+$("#groupType").combobox('getValue');
		   	params = "dateNO="+$(dateNO).combobox('getText')+"&waiBoOrTuoGuan=wb"+heDuiBuYiZhi+"&fundName="+$("#fundName").combobox('getText')
		    +"&serv_scop="+$("#serv_scop").combobox('getText')+"&gzry="+$("#guzhirenyuan").combobox('getText')
		   	+"&isPrinted="+$("#isPrinted").combobox('getValue')+"&data_chk_rslt_code="+$("#data_chk_rslt_code").combobox('getText')
			+"&ivsp_chk_rslt_code="+$("#ivsp_chk_rslt_code").combobox('getText')
		   	+"&reportType="+type;
		//	$('#jibaoheduiTable').datagrid({method:'post',url:prefix+"/utility/exportDiscSitu?"+params}).datagrid('clientPaging'); 
				var url=prefix+"/utility/exportDiscSitu?"+params; 
				window.location.href=url;
		}		
	/*}*/
}

