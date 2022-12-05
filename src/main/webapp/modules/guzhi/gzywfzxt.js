//管理人综合信息
var queryDetailWin;
var queryWin;
var mxDetailWin;
var uploadQueryWin;
var detailWin;
/* 提示框最小宽度 */
var min_width = 150;

var updateDetailWin;

$(function() {
	createPanel_A();
});
// 管理人档案审核信息
var funcId_A = '';
/*//提交审核操作  更新库
var funcId_U = 'updateRecordReviewStatus';
//判断某个管理人是否存在有效档案
var custodianOperate_A='decideValidRecordManager';
//将有效置为无效
var custodianOperate_C='validToInvalidFund'; */

// 创建表格
function createPanel_A() {
	var id = new ListGridField("id", "序号", null, "class_c");
	var fileName = new ListGridField("fileName", "文件名称", null, "class_c");
	var remark = new ListGridField("remark", "文件来源标识", 80, "class_c");
	var updateTime = new ListGridField("updatetime", "更新时间", 80, "class_c");
	var cz = new ListGridField("cz", "操作", null, "class_c");

	var ccc = new ListGrid(id, fileName,remark, updateTime,cz);

	setCanDoubleClick(funcId_A, false);
	showToolsBar[funcId_A] = true;
	showRadioBoxMap[funcId_A] = false;
	showTrIndexMap[funcId_A] = true;
	showToolsWin[funcId_A] = true;

	queryWin = getQueryWin(funcId_A);
	initPanel('管理人档案信息', funcId_A, 'panel', queryWin, ccc);
	doQuery(funcId_A);
	$("#table-fixed").resizableColumns({
		store : store
	});
	if ($('#table-fixed').height()<defaultTableHeight){
		  $('.fixed-div').css({'display': 'none'});
	}else{
		  $('.fixed-div').css({'display': 'block'});
	}
}

/* 新查询-----查看、修改、密码重置在一个单元格 */
function doQuery(funcId) {
	// 复选框
	var showCheckBox = showCheckBoxMap[funcId];
	// 单选框
	var showRadioBox = showRadioBoxMap[funcId];
	var showTrIndex = showTrIndexMap[funcId];
	canExportMap[funcId] = false;
	// 当前页码
	currPagesMap[funcId] = 1;
	// 打印时间
	if (print != null) {
		window.clearInterval(print);
	}
	var beginTime = 0;
	print = setInterval(function() {
		beginTime++;
		$("#timeCost_"+funcId).html("已用时" + beginTime + "秒");
	}, 1000);
	getParameters(funcId);
	var dataPara = parametersMap[funcId];
	currentPage=1;
	
	dataPara['funcId']=funcId;
	dataPara['pageSize']=defaultPageSizeMap[funcId];
	dataPara['curPage']=currPagesMap[funcId];
	dataPara['v_first_query']='Y';
	dataPara['isOptionsQuery']='N';
	
	if(!isNull(queryWindowMap[funcId])){
		queryWindowMap[funcId].show();
		queryWindowMap[funcId].hide();
	}
	
	$("#timeCost_"+funcId).html("");
//	$("#data_table_content_"+funcId).html("");
	$("#data_table_content_"+funcId).append('<img  src="'+basePath+'images/icon-44.gif" style="position:fixed;left:47%;top:20%;z-index:111">');
	
	var flag = chechForm();
	if (flag) {
		$.ajax({
			url : '../../guzhisas/queryXXZWJ',
			type : 'post',
			data : dataPara, // 要发送的数据
			dataType : 'json',// 接受数据格式
			success : function(data) {// data为返回的数据，这里做数据绑定
				var operInfo='';
				var click_name='';
				var DataInfo = data[0];
				// recordsCount 查询出多少条数据
				var recordsCount = DataInfo.maxSize;
				totalPages = Math.ceil(parseInt(recordsCount)/parseInt(defaultPageSizeMap[funcId]));
				$("#currPage_"+funcId).val(1);
				$("#totalPages_"+funcId).html(totalPages);
				totalPagesMap[funcId] = totalPages;
				var resultFlag = "true";
				// 查询出需要的数据，花费时间
				var timeCost = 0;
				
				if ("false" == resultFlag) {
					if (undefined == pro_Info) {
						Ext.Msg.minWidth= min_width;
						Ext.Msg.alert('查询失败', "系统正在维护请联系管理员");
					} else {
						Ext.Msg.minWidth= min_width;
						Ext.Msg.alert('查询失败', pro_Info);
					}
					window.clearInterval(print);
				} else {
					window.clearInterval(print);

					if (recordsCount > 0) {
						canExportMap[funcId] = true;
					}

					totalResultsMap[funcId] = recordsCount;
					$("#timeCost_"+funcId).html(
							"共计&nbsp;:" + recordsCount
									+ "&nbsp;条数据&nbsp;&nbsp;耗时:&nbsp;"
									+ timeCost + "&nbsp;秒");
					var trs = '';
					trs_head = trs;
					allTrDataMap[funcId] = data;
					allTrDataMap_Checked[funcId] = new Array();
					for ( var j = 1; j <=data.length; j++) {
						var td_str='';
						var oneCol=data[j];
						if(data.length>1&&j <data.length){
							if(showCheckBox){
								td_str += '<td width="30" style="text-align:center;">'
									     +'<input id="check" type="checkbox" name="checkbox_'+funcId+'" value="'+j+'"/></td>';
							} else if(showRadioBox){
								td_str += '<td width="30" style="text-align:center;"><input id="radio" type="radio" name="radiobutton_'+funcId+'" value="aa"/></td>';
							}
							if(showTrIndex){
								td_str += '<td width="30" style="text-align:center;">' + j + '</td>';
							}
							/* 加载真实列的数据 */
							for ( var k = 0; k < HeaderNames_enMap[funcId].length; k++) {
								var realKey = HeaderNames_enMap[funcId][k];
								var oprInfo = HeaderNames_oprMap[funcId][realKey];
								if(!isNull(oprInfo)){
								// ListGridField
									operInfo=oprInfo;
									var clickName = oprInfo['clickName'];
									click_name=clickName;
									var trContent = oprInfo['trContent'];
									if(isNull(trContent)){
										var key = HeaderNames_enMap[funcId][k].toLowerCase();
										trContent =  oneCol[key]==null||undefined ? "" : oneCol[key];
									}
									var clazz = oprInfo['clazz'];
									td_str += '<td class="'+clazz+'"><a id="oprclick" href="javascript:void(0)" style="text-align:center;" onclick='
									          +click_name+'>'+trContent+'</a></td>';
								}else{
									// 带有操作的ListGridField
									var clazz = HeaderNames_clsMap[funcId][k];
									var key = HeaderNames_enMap[funcId][k].toLowerCase();
									var vv = oneCol[key]==null||undefined ? "" : oneCol[key];
									// 判断
									if(key=="cz"){
									    td_str += '<td class="'+clazz+'">'
									    		  + '<center><a id="showClick" href="javascript:void(0)" style="text-align:center;" onclick="download_('+j+');">'  
									              +"下载"+'</a>&nbsp;'
									              +'<a id="updateClick" href="javascript:void(0)" style="text-align:center;" onclick="check_('+j+');">'
									              +"审核"+'</a></center></td>';
								   }else{
									   td_str += '<td class="'+clazz+'">' + vv + '</td>';
								   }
								}
							}
						}else if(data.length==1){
							$("#currPage_"+funcId).val(0);
							td_str ='<td  colspan='+HeaderNames_enMap[funcId].length+' style="border-style:none;padding-left:200px;"><font>'+"对不起，没有查询到相关记录!"+'</font></td>';
						}
						
						trs += '<tr>';
						trs += td_str;
						trs += '</tr>';
					}
					$("#data_table_content_"+funcId).html(trs);
					queryHeight=$("#table_parent").height();
				}
				bindEvent(funcId,operInfo,click_name);
			},
			failure : function(data) {
				Ext.Msg.minWidth= min_width;
				Ext.Msg.alert("提示","查询失败，请联系管理员！");
				window.clearInterval(print);
			}
		});
	} else {
		window.clearInterval(print);
	};
}

// 获取查询条件
function getParameters(funcId) {
	if (funcId == funcId_A) {
		/* 获取第一个panel的查询窗口的参数 */

		// alert(p_rzzt);
		// alert(p_glrmc+" "+p_babm+' '+p_lxrxm+" "+p_mobile+" "+p_rzzt);
		var data = {

		};
		parametersMap[funcId_A] = data;

	}
}

function chechForm() {
	return true;
}

function getIndex(array, val) {
	for ( var i = 0; i < array.length; i++) {
		if (array[i] == val) {
			return i;
		}
	}
}

// 显示查询窗口
function getQueryWin(funcId){
	if(undefined != queryDetailWin){
//		queryDetailWin.destroy();
		queryDetailWin.show();
		return queryDetailWin;
	}
	var khcxtj = new Ext.form.FieldSet(
			{
				xtype:'fieldset',
	            title: '',
	            collapsible: true,
	            autoHeight:true,
	            width:defaultFieldSetWidth,
	            layout : "form",
				items : [{
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "管理人名称",
							name :"v_khmc",
							id :"v_khmc",
							editable : true,      
							triggerAction : 'all',
							width : 150
						}]
					},{
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "备案编码",
							name :"v_jjdm",
							id :"v_jjdm",
							valueField : 'value',
							displayField : 'name',
							editable : true,      
							triggerAction : 'all',
							width : 150
						}]
					}							
					]
				},{
					buttonAlign : "center",
					buttons : [{
						text : "条件重置",
						type : 'button',
						handler: function(){
							buttonReset(queryFormDetail);
							 Ext.getCmp('v_zjlx').setDisabled(true);
						}
					},{
						text : "查询",
						type : 'button',
						handler: function(){
//							doQuery(funcId_A);
							queryDetailWin.hide();
						}
					}]
				}]
			}
	);
	var queryFormDetail =  new Ext.FormPanel(
			{
				width : defaultFieldSetWidth,
				autoHeight : true,
				frame : true,
				layout : "form", // 整个大的表单是form布局
				id:'queryFormDetail',
				labelWidth : 100,
				standardSubmit:true,
				labelAlign : "right",
				onSubmit: Ext.emptyFn,
				submit: function() {
				   this.getEl().dom.action='../custMessadd.do'; //连接到服务器的url地址
				   this.getEl().dom.submit();
				   },
				items : [khcxtj]
			}
	);
	 queryDetailWin = new Ext.Window({
		id:'queryDetailWin',
		title:'查询条件设置',
		autoHeight:true,
		collapsible:true,
		closeable:true,
		closeAction:'hide',
		draggable:false,
		shadow:false,
		width:700,
		y : 30,
		layout:'fit',
		modal:true,
		items:[queryFormDetail]
	 
	});
}

var selectedColumn;
/* radio事件处理 */
function dealRadioChecked(funcfuncIdId, columnNum) {
	selectedColumn = columnNum;
}


/**
 * 点击下载
 * @param column
 */
function download_(column){
	var record = allTrDataMap[funcId_A][column];   //直接获取到该sql语句的所有参数
	filedownload(record['file_name'],record['auth_key']);
}

/**文件下载方法   公共使用**/
function filedownload(fileName,auth_key){
	//自定义下载
	jQuery.download = function(url, data, method){
		// 获得url和data
		if( url && data ){ 
			// data 是 string 或者 array/object
			data = typeof data == 'string' ? data : jQuery.param(data);
			// 把参数组装成 form的  input
			var inputs = '';
			jQuery.each(data.split('&'), function(){ 
				var pair = this.split('=');
				inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
			});
			jQuery('<form action="'+ url +'" method="post">'+inputs+'</form>')
			.appendTo('body').submit().remove();
		};
	};
	//调用自定义的下载方法
	var param= "fileName="+fileName
				+"&auth_key="+auth_key;
				
	$.download(basePath+'fileDownloadMethod.asp',param,'post');
}


/**
 * 审核
 * @param column
 */
function check_(column){
	if(undefined != updateDetailWin){
		updateDetailWin.destroy();
	}
	
	//var record = trDataInfoMap[funcId_A];
	var record = allTrDataMap[funcId_A][column];   //直接获取到该sql语句的所有参数
	var review_record_id = record['record_id'];    //档案编号
	var review_flow_id = record['review_flow_id'];   //审核流水号
	var trail_flow_id = record['trail_flow_id'];     //轨迹流水号
	
	var wjlbHtml=fileselect(record['file_name'],record['auth_key']);
	if(wjlbHtml==undefined){
		wjlbHtml="";
	}
	
	var khcxtj = new Ext.form.FieldSet(
			{
				xtype:'fieldset',
	            title: '',
	            collapsible: true,
	            autoHeight:true,
	            width:defaultFieldSetWidth,
	            layout : "form",
				items : [{
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "管理人名称",
							name :"v_glrmc",
							id :"v_glrmc",
							valueField : 'value',
							displayField : 'name',
							editable : true,  
							disabled:true,
							value:record['fm_name'],
							triggerAction : 'all',
							width : 150
						}]
					
					},{
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "材料类型",
							name :"v_cllx",
							id :"v_cllx",
							valueField : 'value',
							displayField : 'name',
							disabled:true,
							editable : true,
							value:record['record_type'],
							triggerAction : 'all',
							width : 150
						}]
					}]
				},{
					layout : "column",
					bodyStyle:'margin-top:5px;',
						items : [{
							columnWidth : .45,
							layout : "form",
							items : [{
								xtype : "textfield",
								fieldLabel : "档案名称",
								name :"v_jjdm",
								id :"v_jjdm",
								valueField : 'value',
								displayField : 'name',
								editable : true,
								disabled:true,
								value:record['record_name'],
								triggerAction : 'all',
								width : 180
							}]
					},{
						columnWidth : .25,
						layout : "form",
						items : [{
							width : 150,
							html:'<table>'+wjlbHtml+'</table>', 
							border:false
						}]
					}]						
				},{
					layout : "column",
					bodyStyle:'margin-top:5px;',
						items : [{
							columnWidth : .90,
							layout : "form",
							items : [{
								xtype : "textfield",
								fieldLabel : "档案备注",
								name :"v_dabz",
								id :"v_dabz",
								valueField : 'value',
								displayField : 'name',
								editable : true,
								disabled:true,
								value:record['remark'],
								triggerAction : 'all',
								width : 450
							}]
					}]						
				},{
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
							columnWidth : .90,
							layout : "form",
							items : [{
								xtype : "textfield",
								fieldLabel : "审核备注",
								name :"v_glrshbz",
								id :"v_glrshbz",
								editable : true,      
								triggerAction : 'all',
								width : 450
							}]
					}]
				},{
					buttonAlign : "left",
					buttons : [{
						text : "通过",
						type : 'button',
						handler: function(){
							adopt(record,funcId_U,review_record_id,review_flow_id,trail_flow_id);
						}
					},{
						text : "不通过",
						type : 'button',
						handler: function(){
							notThrough(funcId_U,review_record_id,review_flow_id,trail_flow_id);
						}
					},{
						text : "返回",
						type : 'button',
						handler: function(){
							//doQuery(funcId_A);
							updateDetailWin.hide();
						}
					}]
				}]
			}
	);
	var updateFormDetail =  new Ext.FormPanel(
			{
				width : defaultFieldSetWidth,
				autoHeight : true,
				frame : true,
				layout : "form", // 整个大的表单是form布局
				id:'updateFormDetail',
				labelWidth : 100,
				standardSubmit:true,
				labelAlign : "right",
				onSubmit: Ext.emptyFn,
				submit: function() {
				   this.getEl().dom.action='../custMessadd.do'; // 连接到服务器的url地址
				   this.getEl().dom.submit();
				   },
				items : [khcxtj]
				   
			}
	);
	updateDetailWin = new Ext.Window({
		id:'updateDetailWin',
		title:'<font style="font-size:13px">管理人档案</font>&gt;管理人档案审核<font style="font-size:13px"></font>',
		autoHeight:true,
		collapsible:true,
		closeable:true,
		closeAction:'hide',
		draggable:false,
		shadow:false,
		width:700,
		y : 30,
		layout:'fit',
		modal:true,
		items:[updateFormDetail]
	});
	updateDetailWin.show();
	
}

function requery_(funcId){ 
	getQueryWin(funcId_A);
	queryDetailWin.show();
}

//通过
function adopt(record,funcId_U,review_record_id,review_flow_id,trail_flow_id){
	//var record = allTrDataMap[funcId_A][column];   //直接获取到该sql语句的所有参数
	var data={
			funcId:custodianOperate_A,
			record_number:record['record_number'],
			record_type:record['recordType']
	};
	parametersMap[custodianOperate_A] = data;
	
	Ext.MessageBox.confirm("确认", " 确定此次审核通过吗？  ", function(btn){
		if(btn=="yes"){
			//查询是否存在有效的
			$.ajax({
				url : '../../public.asp',
				type : 'post',
				data : data, //要发送的数据
				dataType : 'json',// 接受数据格式
				success : function(data){//data为返回的数据，这里做数据绑定
					if(data[0] != '' && data[0] != null){ //说明已经存在有效档案了
						//先将原来的有效档案置为无效，   然后再将审核通过的档案置为有效
						var record1 = data[0].record_id;
						var trailFlowId = data[0].flow_id;
						var data1={
								funcId:custodianOperate_C,
								record_id:record1,
								trail_flow_id:trailFlowId,
								p1:'02'
						};
						parametersMap[custodianOperate_C] = data1;
						$.ajax({
							url : '../../public.asp',
							type : 'post',
							data : data1, //要发送的数据
							dataType : 'json',// 接受数据格式
							success : function(data){//data为返回的数据，这里做数据绑定
								//设置提示框宽度，格式
								Ext.Msg.minWidth= min_width;
								if(data[0].err_message){
									Ext.Msg.alert("提示",data[0].err_message);
								}else{
									doSubmit(funcId_U,review_record_id,review_flow_id,trail_flow_id,'02','02','02','审核通过');
								}
							},
							failure : function(data) {
								alert("操作失败，请联系管理员！");
								window.clearInterval(print);
							}
						});
					}else{
						doSubmit(funcId_U,review_record_id,review_flow_id,trail_flow_id,'02','02','02','审核通过');
					}
				},
				failure : function(data) {
					alert("操作失败，请联系管理员！");
					window.clearInterval(print);
				}
			});
		}
	});
}

//不通过
function notThrough(funcId_U,review_record_id,review_flow_id,trail_flow_id){
	Ext.MessageBox.confirm("确认", " 确定此次审核不通过吗？  ", function(btn){
		if(btn=="yes"){
			var shbz=Ext.getCmp("v_glrshbz").getValue(); //获取管理人审核备注的值
			if(shbz == "" || shbz == undefined || shbz == null){
				Ext.Msg.alert("提示","审核备注不能为空！");
			}else if(shbz.indexOf('<') >= 0||shbz.indexOf('>') >= 0){
				Ext.Msg.alert("提示",'审核备注不能包含"<"和">"！');
			}else if(shbz.length>127){
				Ext.Msg.alert("提示","审核备注长度过长！");
			}else{
				doSubmit(funcId_U,review_record_id,review_flow_id,trail_flow_id,'01','03','03','审核不通过');
			}
		}
	});
}

/**
 * 提交审核
 */
function doSubmit(funcId,reviewRecordId,reviewFlowId,trailFlowId,recordStatus,checkStatus,operateResult,auditConclusion){
	var v_jjshbz=Ext.getCmp("v_glrshbz").getValue(); //获取管理人审核备注的值
	var data={
			funcId:funcId,
			record_id:reviewRecordId,	//档案编号
			review_flow_id:reviewFlowId,	//审核流水号
			trail_flow_id:trailFlowId,	//轨迹流水号
			record_status:recordStatus,   //档案状态
			check_status:checkStatus,     //档案审核状态
			operate_result:operateResult,  //轨迹中审核状态
			check_remark:v_jjshbz,     //基金审核备注
			audit_conclusion:auditConclusion   //审核结论
	};
	parametersMap[funcId_U] = data;
	//发送ajax请求
	$.ajax({
		url : '../../public.asp',
		type : 'post',
		data : data, //要发送的数据
		dataType : 'json',// 接受数据格式
		success : function(data) {//data为返回的数据，这里做数据绑定
				//设置提示框宽度，格式
				Ext.Msg.minWidth= min_width;
				if(data[0].err_message){
					Ext.Msg.alert("提示",data[0].err_message);
				}else{
					doQuery(funcId_A);
					updateDetailWin.hide();
					Ext.Msg.alert("提示","提交成功！");
				}
		},
		failure : function(data) {
			alert("提交失败，请联系管理员！");
			window.clearInterval(print);
		}
	});
}

function fileselect(file_name,auth_key){
	var wjlbdiv=""; //文件列表
			wjlbdiv+="<tr><td>"+
			"<div style='margin-left: 10px;'>"+
    		"<span style='cursor:pointer;' onclick='filedownload(\""+file_name+"\",\""+auth_key+"\")'>" +
    		"<img style='vertical-align: bottom;margin-left: 6px;' src='../../images/icon-down.png' width='16'>下载</span>" +
    		"</div>" +
    		"</td></tr>";
	return wjlbdiv;
}
