  
/* 未开放的功能，可以直接用这个字符串标记在页面上*/
var tips_wkf = '<font color="red">(未启用)</font>';

/* 这个在listMenu.js中初始化*/
var tabs;

/* 表格对应标题  -- 可设置 -- 默认不显示标题 */
var panelNameMap = new Object();
/* 查询窗口，与功能号对应  -- 可自行注入 --*/
var queryWindowMap = new Object();

/* 导出窗口，与功能号对应  -- 可自行注入 --*/
var exportWindowMap = new Object();


/* 每个功能对应的参数集合， --可自行注入-- 最好在每个页面对应的 getParameters(funcId) 进行放置，比较容易管理 */
var parametersMap = new Object();
/* 是否显示表格前面单选按钮*/
var showRadioBoxMap = new Object();
/* 是否显示表格前面多选框*/
var showCheckBoxMap = new Object();
/* 是否显示序列号*/
var showTrIndexMap = new Object();
/* 是否添加双击事件  -- 可设置 -- ，但在自己的方法中必须 实现showDoubleClickWindow(obj)方法 */
var canDoubleClickMap = new Object();
/* 窗口默认长度  -- 可设置 -- */
var defaultFieldSetWidth = 653;
/* 是否展示 工具条  -- 可设置 -- */
var showToolsBar = new Object();

/* 是否展示 工具条  -- 可设置 -- */
var showRequeryWin = new Object();

/* 是否展示 工具条中的按钮操作  -- 可设置 -- */
var showToolsWin = new Object();
/* 是否展示 工具条中的按钮操作  -- 可设置 -- */
var showPageSetImg = new Object();

/* 表格是否全屏显示  -- 可设置 -- */
var fullScreenMap = new Object();
/* 默认页面条数 -- 可设置 --*/
var defaultPageSizeMap = new Object();
/* 总计数据条数 */
var totalResultsMap = new Object();
/* 总计页码数，由数据库查询给出 ，不需要设置*/
var totalPagesMap = new Object();
/* 当前页码 */
var currPagesMap = new Object();
/* 提示数据库查询耗时的tip */
var print = '';
/* 提示框最小宽度 */
var min_width= 350;

/* 单选、单击、双击后 存放这个TR中的数据 ，可直接传到后台，key对应的是表格的'英文小写'。*/
var trDataInfoMap = new Object();
/* 表格中当页全部的数据 key为：1，2，--- N */
var allTrDataMap = new Object();
/* 多选的序列号，*/
var allTrDataMap_Checked = new Object();
/* 存储过程处理信息，包含info_ok,info_err*/
var proMessageMap = new Object();

/*
 * 导出所需参数
 */
var exportQueryWin;
//当前页码
var currentPage= new Object();
//接受查询数据
var judge_data;
//导出的页码选择
var pageNumber;
//导出sheet行数选择
var sheetNumber;
//查询出的总数据条数
var dataCount;
//公共url
var publicUrl;
//doquery时div（panel）的高度
var queryHeight;

var listName;
//表格的高度
var defaultTableHeight;
//底部是否有按钮。
var existsButtonInBottom;


var HeaderNames_enMap = new Object();
var HeaderNames_zhMap = new Object();
var HeaderNames_en_exportMap = new Object();
var HeaderNames_zh_exportMap = new Object();
var HeaderNames_wdMap = new Object();
var HeaderNames_clsMap = new Object();
//单个点击事件
var HeaderNames_oprMap = new Object();
//多个点击事件，标志为'cz'
var HeaderNames_oprsMap = new Object();

var selectedTrMap = new Object();
var canExportMap = new Object();
var width_total;

var basePath = 'http://localhost:8080/maven-guzhi/';


var ListField_winMap = new Object();
//加载本地ext图片
Ext.BLANK_IMAGE_URL = "../../ext/resources/images/default/s.gif";

function setCanDoubleClick(funcId,canDoubleClick){
	canDoubleClickMap[funcId] = canDoubleClick;
}

function initPanel(listName_,funcId,panelName,queryWindow) {
 	
	if(isNull(defaultTableHeight)){
		defaultTableHeight = $(window).height()-75;
	}
	if(!isNull(existsButtonInBottom)){
		defaultTableHeight = defaultTableHeight-45;
	}
 	
 	listName  = listName_ ;
	if(!isNull(queryWindow)){
		queryWindowMap[funcId]=queryWindow;
	}
	if(isNull(defaultPageSizeMap[funcId])){
		defaultPageSizeMap[funcId]= 20;
	}
	var args = arguments;
	var tr_Head = '';
	
	tableHeight = defaultPageSizeMap[funcId]*24+6;
	
	/* 第3个参数及之后参数的处理 */
	for(var i=4;i<args.length;i++){
		 var type = args[i].getType();
		 if(type=='ListGrid'){
			 tr_Head = initTable(funcId,args[i]);
		 }
	}
	
	var showCheckBox = showCheckBoxMap[funcId];
	var showRadioBox = showRadioBoxMap[funcId];
	var showTrIndex = showTrIndexMap[funcId];
	
	if(showCheckBox||showRadioBox){
		width_total += 38;
	}
	if(showTrIndex){
		width_total += 38;
	}
	var width_str = 'width:'+(width_total)+'px;';
	var width_str_toolsbar = 'width:'+(width_total-17)+'px;';
	
	if(!isNull(fullScreenMap[funcId])){
		width_str = 'width:auto;';
		width_str_toolsbar= 'width:auto;';
	}
	var str = '';
	if(!isNull(panelNameMap[funcId])){
		str+='<div class="panelNamecls" style="'+width_str+'">'+panelNameMap[funcId]+'</div>';;
	}
	
		if(showToolsBar[funcId]){
		  str +=  '<!-- tools bar -->'
				+ '<div class="tools_bar" style="width:100%; position:fixed;z-index:100;top:0px;">'
			    + '<div  id="pagesize_set_'+funcId+'" style="display:none;z-index:10"></div>'
				+ '<table cellpadding="0" cellspacing="0">'
				+ '<tr class="tools_bar_imgs">'
				+ '<td><img onclick="refresh_(\''+funcId+'\')" class="img1" src="'+basePath+'images/arrow_refresh_small.png" title="刷新统计结果" height="26"/><img onclick="refresh_(\''+funcId+'\')" src="'+basePath+'images/arrow_refresh_small1.png" class="img2 hidden" title="刷新统计结果" height="26"/></td>';
			
				if(showToolsWin[funcId]){
					if(showPageSetImg[funcId]==null){
						str+='<td><img onclick="pageSet_(\''+funcId+'\')" class="img1" src="'+basePath+'images/dataGrid-pageset.gif" title="设置每页显示条数" height="26" /><img onclick="pageSet_(\''+funcId+'\')" class="img2 hidden" src="'+basePath+'images/dataGrid-pageset1.gif" title="设置每页显示条数" height="26" /></td>';
					}
					str+='<td><img onclick="export_excel(\''+funcId+'\')" class="img1" src="'+basePath+'images/dataGrid-excel.gif" title="导出统计结果" height="26" /><img onclick="export_excel(\''+funcId+'\')" class="img2 hidden" src="'+basePath+'images/dataGrid-excel1.gif" title="导出统计结果" height="26" /></td>';	
				}
	
				if(showToolsWin[funcId]){
					str+= '<td style="width:70%;text-align:right;padding-right:100px;"><div class="jdsearch"><input class="" id="matchInfo_'+funcId+'" type="text" name="" value="">'
					     +'<img class="search-icon"  src="'+basePath+'images/search-icon.png" title="" height="18" onclick="doQuery(\''+funcId+'\',true)"/>'
					     +'<img class="search-icon search-icon2 hidden" src="'+basePath+'images/search3-icon.png" title="" height="18" onclick="doQuery(\''+funcId+'\',true)"/>';
				}
				if(showRequeryWin[funcId]==null){
					str+='<img onclick="requery_(\''+funcId+'\')" src="'+basePath+'images/icon_view.png" title="设置查询条件" class="gjsearch" height="26"/><img onclick="requery_(\''+funcId+'\')" src="'+basePath+'images/icon_view1.png" title="设置查询条件"  class="gjsearch hidden searchShow" height="26"/>'
				}
				str+=  '</div></td>'
				+ '</tr>'
				+ '</table>'
				+ '</div>';
				+ '</div>';
			}
		str +='<div class="biaotou" style="border-bottom:0px;width:100%;position:fixed;z-index:10;top:40px;"><span class="tit">'+listName_ +'</span>'
		str +='<div class="fenye">'
		str	+='<span class="shouye" onclick="pageClickToFirst(\''+funcId+'\')">首页</span>'
		str +='<span><img onclick="pageClickToPrev(\''+funcId+'\')" src="'+basePath+'images/page-prev.gif" title="上一页" /></span>'
		str +='<span><input id="currPage_'+funcId+'" onkeypress="pageClickToPos(\''+funcId+'\',event)" onkeydown="pageClickToPos(\''+funcId+'\')" style="width:30px;text-align:center;"/></span>'
		str +='<span style="margin-left:8px;">/</span>'
		str +='<span id="totalPages_'+funcId+'"></span>'
		str +='<span><img onclick="pageClickToNext(\''+funcId+'\')" src="'+basePath+'images/page-next.gif" title="下一页" /></span>'
		str	+='<span class="shouye" onclick="pageClickToLast(\''+funcId+'\')">尾页</span>'
		str +='</div>'
		str +='<div class="zts">'
			if(showToolsWin[funcId]){
				str+= '<div id = "timeCost_'+funcId+'" class="timeCost"></div>';
			}
		str +='</div>'
			 + '<div  class="fixed-div" style="line-height:20px;"><table class="hovertable" id="table-head-fixed" style="width:100%;overflow:hidden;left:-1px;">'
			    + '<thead id="data_table_head_fixed_'+funcId+'" class="tableHeader-processed "></thead>'
			    + '</table></div>'
		str +='</div>'
		str += '<div id="table_parent" style="top:69px;height:'+defaultTableHeight+'px;font-size:9pt;font-fammily:\'微软雅黑\',\'黑体\',\'宋体\';position:relative; width:100%; border-bottom:2px solid #ccc; overflow-x:auto;overflow-y:auto;">';
		   str += '<!-- Table goes in the document BODY -->'
			    + '<div style="height:100%;font-size:9pt;font-fammily:\'微软雅黑\',\'黑体\',\'宋体\'; ">'
			    + '<table class="hovertable" id="table-fixed" style="width:100%;">'
			    + '<thead id="data_table_head_'+funcId+'" class="tableHeader-processed "></thead>'
			    + '<tbody id="data_table_content_'+funcId+'"></tbody>'
			    + '</table></div></div>'
			;
		   
		   
		   str += "<script> $('.tools_bar_imgs td').hover(function(){"
	    		+" $(this).children('.img1').addClass('hidden');"
	    		+" $(this).children('.img2').addClass('show');"
	    		+" },function(){"
	    		+" $(this).children('.img1').removeClass('hidden');"
	    		+" $(this).children('.img2').removeClass('show');"
	    		+" $(this).children('.img2').addClass('hidden');"
	    		+" });"
	    		+" $('.search-icon').hover(function(){"
	    		+" $(this).addClass('hidden');"
	    		+" $('.search-icon2').addClass('show');"
	    		+" },function(){"
	    		+" $(this).removeClass('hidden');"
	    		+" $('.search-icon2').removeClass('show');"
	    		+" $('.search-icon2').addClass('hidden');"
	    		+" });"
	    		+" $('.gjsearch').hover(function(){"
	    		+" $(this).addClass('hidden');"
	    		+" $('.searchShow').addClass('show');"
	    		+" },function(){"
	    		+" $(this).removeClass('hidden');"
	    		+" $('.searchShow').removeClass('show');"
	    		+" $('.searchShow').addClass('hidden');"
	    		+" })"
	    		+" </script> ";

	$("#" + panelName).html(str);
	$("#data_table_head_fixed_"+funcId).html(tr_Head.replace('allControlBox_'+funcId,'allControlBox_fixed_'+funcId));
	$("#data_table_head_"+funcId).html(tr_Head);
    $('#table_parent').scroll(function () {
    	var leftwidth = $(this).scrollLeft();
    	if(leftwidth==0){
    		$('#table-head-fixed').css("left",'-1px');
    	}else{
    		$('#table-head-fixed').css("left", -leftwidth-1);
    	}
    	 
    });
    var winWidth = $('.biaotou').width();
    $('.fixed-div').css({'width': '98.4%','overflow':'hidden'});
    $('.ext-el-mask').css({"width":"100%"});
}

function pageClickToFirst(funcId){
	var currPage = currPagesMap[funcId];
	if(currPage==1){
		Ext.Msg.minWidth= min_width; 
		Ext.Msg.alert("提示","已经是第一页!");
	}else{
		pageClick(funcId,1);
	}
}
function pageClickToPrev(funcId){
	var currPage = currPagesMap[funcId];
	if(currPage==1){
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert("提示","已经是第一页!");
	}else{
		pageClick(funcId,currPage-1);
	}
}
function pageClickToNext(funcId){
	var currPage = currPagesMap[funcId];
	if(currPage==totalPagesMap[funcId]){
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert("提示","已经是最后一页!");
	}else if(currPage-1==totalPagesMap[funcId]){
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert("提示","已经是最后一页!");
	}
	else{
		pageClick(funcId,currPage+1);
	}
}
function pageClickToLast(funcId){
	var currPage = currPagesMap[funcId];
	if(currPage==totalPagesMap[funcId]){
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert("提示","已经是最后一页!");
	}else if(currPage-1==totalPagesMap[funcId]){
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert("提示","已经是最后一页!");
	}
	else{
		pageClick(funcId,totalPagesMap[funcId]);
	}
}
function pageClickToPos(funcId,e){
	var ev = e||window.event; 
	if(ev.keyCode == 13){
		var goPage = $("#currPage_"+funcId).val();
		var intgoPage = parseInt(goPage+'');
		if(intgoPage<1 || intgoPage>totalPagesMap[funcId]){
			Ext.Msg.minWidth= min_width;
			Ext.Msg.alert("提示","页码超出范围");
		}else{
			pageClick(funcId,intgoPage);
		}
	}
}

function requery_(funcId){
	if(!isNull(queryWindowMap[funcId])){
		queryWindowMap[funcId].show();
	}
}
/* 每页显示条数设置  begin */
function pageSet_(funcId) {
	var eee=document.getElementById("pagesize_set_"+funcId);
	chg_pagesize_style(funcId,eee);
}

function setpageSize(funcId,ele){
	var t=$("#page_si_"+funcId).val();
	if("on"==$(ele).val()&&(""==t||null==t)){
		$(ele).attr("checked",false);
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert('提示信息',"请先输入条数");
	} else{
		 if("on"==$(ele).val()){
				defaultPageSizeMap[funcId]=t;
		}else{
			defaultPageSizeMap[funcId]=$(ele).val();
		}
		totalPagesMap[funcId]=getPagecount(totalResultsMap[funcId],defaultPageSizeMap[funcId]);
		document.getElementById("pagesize_set_"+funcId).style.display="none";
		pageClick(funcId,1);
	}
	
}

function getPagecount(recordsCount,defaultPageSize){
	var records = parseInt(recordsCount+'');
	var pageSize = parseInt(defaultPageSize+'');
	return Math.ceil(records/pageSize);
}

function chg_pagesize_style(funcId,ele){
	if(ele.style.display=="block"){
		ele.style.display="none";
	}else{
		ele.style.display="block";
	}
	ele.style.position="absolute";
	ele.style.left="115px";
	ele.style.top="43px";
	ele.style.width="120px";
	ele.style.height="115px";
//	ele.style.background="#A4CDF6";
	ele.style.border="1px";
//ie支持在select中设置onclick事件，在option中设置无效，但是在Firefox中，支持option的 onclick事件，在select中设置无效
	ele.innerHTML='<select style="z-index:100000" onchange="setpageSize(\''+funcId+'\',this)"> '
	+ '<option >页面显示条数</option>'
	+ '<option name="page" value="10">每页显示10条</option>'
	+ '<option name="page" value="20">每页显示20条</option>'
	+ '<option name="page" value="50">每页显示50条</option>'
	+ '<option name="page" value="100">每页显示100条</option>'
	+ '<option name="page" value="250">每页显示250条</option>'
	+ '</select >';
	

//	ele.innerHTML='<input type="radio"   onclick="setpageSize(\''+funcId+'\',this)" name="page">每页显示<input type="text" style="width:25px" id="page_si_'+funcId+'">条 </br>'
//	+ '<input type="radio" onclick="setpageSize(\''+funcId+'\',this)" name="page" value="20">每页显示20条</br>'
//	+ '<input type="radio" onclick="setpageSize(\''+funcId+'\',this)" name="page" value="50">每页显示50条</br>'
//	+ '<input type="radio" onclick="setpageSize(\''+funcId+'\',this)" name="page" value="100">每页显示100条</br>'
//	+ '<input type="radio" onclick="setpageSize(\''+funcId+'\',this)" name="page" value="250">每页显示250条</br>'
//	+ '<input type="radio" onclick="setpageSize(\''+funcId+'\',this)" name="page" value="500">每页显示500条</br>';
}
/* 每页显示条数设置  end  */

function refresh_(funcId){
	//判断 若是当前页码数为0
	var currPage = currPagesMap[funcId];
	if(currPage>=1 && currPage<=totalPagesMap[funcId]){
		pageclickednumber=1;
		pageClick(funcId,pageclickednumber);
	}else{
		pageclickednumber=0;
	}
}

function initTable(funcId,listGrid){
	width_total = 0;
	var showCheckBox = showCheckBoxMap[funcId];
	var showRadioBox = showRadioBoxMap[funcId];
	var showTrIndex = showTrIndexMap[funcId];
	
	var th_str = '';
	if(showCheckBox){
		th_str += '<th width="30" style="text-align:center;">'
			     +'<input type="checkbox" id="allControlBox_'+funcId+'" name="checkbox_'+funcId+'0'+'" onClick="setAllChecked(\''+funcId+'\')"  value=""/></th>';
	}else if(showRadioBox){
		th_str += '<th width="30" style="text-align:center;"><div style="width:30px;text-align:center;"></div></th>';
	}
	if(showTrIndex){
		th_str += '<th width="30" style="text-align:center;"><div style="width:30px;text-align:center;">序号</div></th>';
	}
	
	var HeaderNames_en = new Array();
	var HeaderNames_zh = new Array();
	var HeaderNames_en_export = new Array();
	var HeaderNames_zh_export = new Array();
	var HeaderNames_wd = new Array();
	var HeaderNames_cls = new Array();
	var HeaderNames_opr = new Object();
	var HeaderNames_oprs = new Object();
	var tr_Head = '<tr>';
	tr_Head+=th_str;
	var listGridFields = listGrid.getListGridFields();
	for (var k = 0 ; k< listGridFields.length; k++){
		
		HeaderNames_wd.push(listGridFields[k].getWidth());
		HeaderNames_cls.push(listGridFields[k].getClazz());
		
		HeaderNames_en.push(listGridFields[k].getName());
		
		
		if(listGridFields[k].getName().toLowerCase()=='cz'&&"OprListGridField"!=listGridFields[k].getType()){
			HeaderNames_oprs = listGridFields[k].getOprs();
		}else{
			HeaderNames_zh.push(listGridFields[k].getTitle());
		}
		
		width_total += parseInt(listGridFields[k].getWidth())+8;
		var styleStr = '';
		if("hideCls" == listGridFields[k].getClazz()){
			styleStr += 'style="display:none;"';
		}else{
			styleStr += 'style="width:'+listGridFields[k].getWidth()+'px; text-align:center;"';
			if(listGridFields[k].getName().toLowerCase()!='cz'){
				HeaderNames_en_export.push(listGridFields[k].getName().toLowerCase());
				HeaderNames_zh_export.push(listGridFields[k].getTitle());
			}
		}
		
		if(listGridFields.length<=4){
			styleStr = 'style="width:auto;"';
		}
//		tr_Head += '<th '+styleStr+'><div '+styleStr+ 'onclick = sortColumn(' +"'"+ listGridFields[k].getName()+"'"+')>'+listGridFields[k].getTitle() +'</div></th>';
		tr_Head += '<th '+styleStr+'>'+listGridFields[k].getTitle()+'</th>';
		/* 处理字段点击事件的   */
		if("OprListGridField"==listGridFields[k].getType()){
		 	var name =  listGridFields[k].getName();
		 	var orpGridField = new Object();
		 	orpGridField['trContent'] = listGridFields[k].getTrContent();
		 	orpGridField['clickName'] = listGridFields[k].getClickName();
		 	orpGridField['clazz'] = listGridFields[k].getClazz();
		 	HeaderNames_opr[name]=orpGridField;
		}
	}
	if(funcId=="fundvaluation"){
		HeaderNames_en.push("kmjb");
		HeaderNames_en.push("km_p");
	}
	tr_Head += '</tr>';
	HeaderNames_enMap[funcId] = HeaderNames_en;
	HeaderNames_zhMap[funcId] = HeaderNames_zh;
	HeaderNames_en_exportMap[funcId] = HeaderNames_en_export;
	HeaderNames_zh_exportMap[funcId] = HeaderNames_zh_export;
	HeaderNames_wdMap[funcId] = HeaderNames_wd;
	HeaderNames_clsMap[funcId] = HeaderNames_cls;
	/* grid中的 td 点击 事件信息  */
	HeaderNames_oprMap[funcId] = HeaderNames_opr;
	HeaderNames_oprsMap[funcId] = HeaderNames_oprs;
	return tr_Head;
}

//11.18新增点击事件处理函数（升降序）
var columnTitle = " " ;
var count = 0;
function sortColumn(columnName)
{	
	if(columnName == "" ||  columnName !=columnTitle ){
		count = 1;
		 columnTitle = columnName;
	}else{
		count ++;
	}
  p_sortColumnValue =  count %2==1? columnName +' asc' : columnName +' desc';
 //alert("count:"+ count + "p_sortColumnValue:"+p_sortColumnValue);
  doQuery(funcId_A);
	//doDynamicQuery(funcId_A);

}

/**
 * 注意如果重写page_click和doquery方法时，
 * 将这两个方法中的currentPage按照page_click和doquery中的重写
 * @param funcId
 */

/* 导出 弹出框*/
function export_excel(funcId){
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
	        // request发送请求
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
	
	if(canExportMap[funcId]){

		if (exportQueryWin != undefined) {
			exportQueryWin.show();
			return exportQueryWin;
		}
		
		var ymfwxz= new Ext.form.FieldSet({
			title : '页面范围选择',
			collapsible : true,
			autoHeight : true,
			width : 600,
			layout : 'form',
			items:[{
					layout : 'column',
					labelWidth :80, // 默认标签宽度板 
		            labelAlign : 'right', 
					items: [{
							layout : 'form',
							items:[{
								xtype : 'radio',
							    name: 'ymfwxz',
							    inputValue: '0',
							    labelSeparator :'',
							    boxLabel: '全部',
							    checked: true,
							    listeners:{
							    	check: function(){
							    		if(this.checked){
							    			Ext.getCmp('page_number_select').setVisible(false);
							    			Ext.getCmp('page_number').setVisible(false);
							    		}
							    	}
							    }
							 }]
						},{
							layout : 'form',
							items:[{
								xtype : 'radio',
							    name: 'ymfwxz',
							    inputValue: '1',
							    labelSeparator :'',
							    boxLabel: '当前页',
							    listeners:{
							    	check: function(){
							    		if(this.checked){
							    			Ext.getCmp('page_number_select').setVisible(false);
							    			Ext.getCmp('page_number').setVisible(false);
							    		}
							    	}
							    }
							}]
						},{
							layout : 'form',
							items:[{
								xtype : 'radio',
							    name: 'ymfwxz',
							    inputValue: '2',
							    labelSeparator :'',
							    boxLabel: '指定页',
							    listeners:{
							    	check: function(){
							    		if(this.checked){
							    			Ext.getCmp('page_number').setVisible(false);
							    			Ext.getCmp('page_number_select').setVisible(true);
							    		}
							    	}
							    }
							}]
						},{
							layout : 'form',
							items:[{
								xtype : 'radio',
							    name: 'ymfwxz',
							    inputValue: '3',
							    labelSeparator :'',
							    boxLabel: '页码范围',
							    listeners:{
							    	check: function(){
							    		if(this.checked){
							    			Ext.getCmp('page_number_select').setVisible(false);
							    			Ext.getCmp('page_number').setVisible(true);
							    		}
							    	}
							    }
							}]
						}]
				},{//行2
					id:'page_number',
					layout : 'column',
					bodyStyle : 'margin-top:5px;',
					labelWidth :180, // 默认标签宽度板 
		            labelAlign : 'right',
		            hidden: true,
					items: [{
							columnWidth : 0.45,
							layout : 'form',
							items:[{
								xtype : 'textfield',
							    fieldLabel: '起始页码',
							    name: 'qsym',
							    id : 'qsym',
							    width : 30
							}]
						},{
							columnWidth : 0.45,
							layout : 'form',
							items:[{
								xtype : 'textfield',
							    fieldLabel: '截止页码',
							    name: 'jzym',
							    id : 'jzym',
							    width : 30
							}]
					}]
				},{//行3
					id:'page_number_select',
					layout : 'column',
					bodyStyle : 'margin-top:5px;',
					labelWidth :180, // 默认标签宽度板 
		            labelAlign : 'right',
		            hidden: true,
					items: [{
							columnWidth : 0.45,
							layout : 'form',
							items:[{
								xtype : 'textfield',
							    fieldLabel: '选择页码',
							    name: 'xzym',
							    id : 'xzym',
							    width : 30
							}]
						}]
				}]
		});
		
		var dhxz= new Ext.form.FieldSet({
			title : '单个sheet页列行数选择',
			collapsible : true,
			autoHeight : true,
			width : 600,
			layout : 'form',
			items:[{
					layout : 'column',
					labelWidth :80, // 默认标签宽度板 
		            labelAlign : 'right', 
					items: [{
//						columnWidth : 0.65,
						layout : 'form',
						items:[{
							xtype : 'radio',
						    name: 'hsxz',
						    inputValue: '2',
						    labelSeparator :'',
						    boxLabel: '默认大小',
						    checked: true,
						    listeners:{
						    	check: function(){
						    		if(this.checked){
						    			Ext.getCmp('line_number').setVisible(false);
						    		}
						    	}
						    }
						 }]
						},{
//							columnWidth : 0.65,
							layout : 'form',
							items:[{
								xtype : 'radio',
							    name: 'hsxz',
							    inputValue: '0',
							    labelSeparator :'',
							    boxLabel: '当前页面大小',
							    listeners:{
							    	check: function(){
							    		if(this.checked){
							    			Ext.getCmp('line_number').setVisible(false);
							    		}
							    	}
							    }
							 }]
						},{
							layout : 'form',
							items:[{
								xtype : 'radio',
							    name: 'hsxz',
							    inputValue: '1',
							    labelSeparator :'',
							    boxLabel: '自定义设置',
							    listeners:{
							    	check: function(){
							    		if(this.checked){
							    			Ext.getCmp('line_number').setVisible(true);
							    		}
							    	}
							    }
							}]
						}]
				},{//行2
					id:'line_number',
					layout : 'form',
					bodyStyle : 'margin-top:5px;',
					labelWidth :200, // 默认标签宽度板 
		            labelAlign : 'right',
		            hidden: true,
					items: [{
						columnWidth : 0.45,
						layout : 'form',
						items:[{
							xtype : 'textfield',
						    fieldLabel: 'sheet最大行数',
						    name: 'zdhs',
						    id : 'zdhs',
						    width : 150
						}]
					}]
				}]
		});
		
		var exportFormDetail =  new Ext.FormPanel(
				{
					width : 623,
					autoHeight : true,
					frame : true,
					//renderTo : Ext.getBody(),
					layout : "form", // 整个大的表单是form布局
					id:'exportFormDetail',
					labelWidth : 100,
					labelAlign : "right",
					method : 'POST',
					enctype : 'multipart/form-data',
					url : "",
					items : [ymfwxz,dhxz,{
						layout : 'form',
						bodyStyle : 'margin-top:5px;',
						items:[{
							layout:'coulumn',
							xtype : 'textfield',
							fieldLabel : "导出文件名",
							name : "wjm",
							id : "wjm",
							listeners : {  
	                            render : function() {  
	                                var font = document.createElement("font");  
	                                font.setAttribute("color","red");  
	                                var redStar = document.createTextNode('可输入自定义文件名称(默认是窗口名称)');  
	                                font.appendChild(redStar);  
	                                this.el.dom.parentNode.appendChild(font);  
	                            }  
	                        }
						}]
					},{
						buttonAlign : "center",
						buttons:[{
							text : "确定",
							type : 'button',
							handler : function() {
								//此处获取到的是选中的单选按钮对象
//								var ymfwxzRadio=$(":radio[name='ymfwxz']");
								var ymfwxzValue=Ext.getCmp("exportFormDetail").getForm().findField("ymfwxz").getGroupValue(); //此处获取到的是选中的inputValue的值;
								var hsxzValue=Ext.getCmp("exportFormDetail").getForm().findField("hsxz").getGroupValue();
								var exportFileName=Ext.getCmp("wjm").getValue(); //获得填写的导出文件名
								page_deal(funcId,ymfwxzValue,hsxzValue);
								
								var HeaderNames_en="";
								var HeaderNames_zh="";
								for(var i=0;i<HeaderNames_en_exportMap[funcId].length;i++){
									HeaderNames_en+=HeaderNames_en_exportMap[funcId][i]+",";
									HeaderNames_zh+=HeaderNames_zh_exportMap[funcId][i]+",";
								}
								if(pageNumber!=null){
									/* 导出 */
//									var url = 'DownloadExcel.down?funcId=' + funcId
//											 +"&page_size="+defaultPageSizeMap[funcId]
//											 +"&pageNumber="+pageNumber
//											 +"&sheetNumber="+sheetNumber
//											 +"&exportFileName="+encodeURIComponent(encodeURIComponent(exportFileName))
//											 +"&HeaderNames_zh="+HeaderNames_zh_exportMap[funcId]
//											 +"&HeaderNames_en="+HeaderNames_en_exportMap[funcId];
//									exportQueryWin.hide();
//									window.location.href = url;
									var dataPara = parametersMap[funcId];
									
									var dataParaString = '';
									
									for(var key in dataPara){
										if(key=="pageSize"){
											dataParaString += '@@'+key+'_@_'+100000;
										}else{
											dataParaString += '@@'+key+'_@_'+dataPara[key];
										}
									}
									//调用自定义的下载方法
									var param = 'funcId=' + funcId
									 	+"&page_size="+100000
									 	+"&pageNumber="+pageNumber
									 	+"&sheetNumber="+sheetNumber
									 	+"&exportFileName="+exportFileName
									 	+"&HeaderNames_zh="+HeaderNames_zh_exportMap[funcId]
									 	+"&HeaderNames_en="+HeaderNames_en_exportMap[funcId]
										+"&dataParaString="+dataParaString
										+"&listName="+listName;
									exportQueryWin.hide();
									$.download('DownloadExcel.down',param,'post');
								}else{
									Ext.Msg.show({
									     title:'温馨提示',
									     msg: '页码选择错误,请重新选择!',
									     buttons: Ext.Msg.CANCEL,
									     icon: Ext.Msg.QUESTION
									});
								}
							}
						}]
					}]
				}
		);
		
		exportQueryWin = new Ext.Window({
			id:'exportQueryWin',
			title:'导出设置',
			autoHeight:true,
			collapsible:true,
			closeable:true,
			closeAction:'hide',
			draggable:false,
			shadow:false,
			width:650,
			y : 60,
			layout:'fit',
			modal:true,
			items:[exportFormDetail]
		});
		exportQueryWin.show();
	}else{
		Ext.Msg.minWidth= min_width;
		Ext.Msg.alert("提示","你好！查询后，才能进行数据的导出操作!");
	}
}

/* 导出参数处理 */
function page_deal(funcId,ymValue,hsValue) {
	//总页数
	var totalPage=getPagecount(totalResultsMap[funcId],defaultPageSizeMap[funcId]);
	var minPage=0;
	var maxPage=0;
	if(ymValue==1){
		pageNumber=currentPage;
	}else if(ymValue==2){
		var yema=Ext.getCmp('xzym').getValue();
		if(yema<=totalPage&&yema>=1){
			pageNumber=yema;
		}else{
			pageNumber=null;
		}
	}else if(ymValue==3){
		minPage=Ext.getCmp('qsym').getValue();
		maxPage=Ext.getCmp('jzym').getValue();
		if(minPage==''&&maxPage!=''){
			pageNumber=1+","+maxPage;
		}else if(minPage!=''&&maxPage==''){
			pageNumber=minPage+","+totalPage;
		}else if(minPage==''&&maxPage==''){
			pageNumber=1+","+totalPage;
		}else if(minPage<maxPage&&minPage>=1&&maxPage<=totalPage){
			pageNumber=minPage+","+maxPage;
		}else{
			pageNumber=null;
		}
	}else{
		pageNumber=0;
	}
	
	if(hsValue==1){
		sheetNumber=Ext.getCmp('zdhs').getValue();
		if(sheetNumber==''||sheetNumber==0){
			if(sheet==2){
				sheetNumber=20000;
			}else{
				sheetNumber=defaultPageSizeMap[funcId];
			}
		}else{
			if(ymValue==1||ymValue==2){
				if(sheetNumber>defaultPageSizeMap[funcId]){
					sheetNumber=defaultPageSizeMap[funcId];
				}
			}else{
				if(ymValue==3){
					var difference=parseInt(maxPage)-parseInt(minPage)+1;
					var alldata=difference*defaultPageSizeMap[funcId];
					if(sheetNumber>alldata){
						sheetNumber=alldata;
					}
				}else{
					if(sheetNumber>dataCount){
						sheetNumber=dataCount;
					}
				}
				
			}
		}
	}else{
		if(hsValue==2){
			sheetNumber=20000;
		}else{
			sheetNumber=defaultPageSizeMap[funcId];
		}
		
	}
};

//11.23  新增条件重置按钮功能实现
function buttonReset(queryFormDetail){
	Ext.getCmp('queryFormDetail').getForm().reset();
}
function buttonReset1(updateFormDetail){
	Ext.getCmp('updateFormDetail').getForm().reset();
}



//function initWin(x) {
//	
//	var j = 0;//换行
//	var y =0;//列
//	var items_line = new Array();
//	var items_column = new Array();
//	items_column[0] = new Array();
//	for(var i=1;i<x;i++){
//		if(j!=ListField_winMap[i].getLine()){
//			j = ListField_winMap[i].getLine();
//			items_column[j] = new Array();
//			y=0;
//		}
//		if('combo'==ListField_winMap[i].getXtype()||'lovcombo'==ListField_winMap[i].getXtype()){//下拉
//			
//			items_column[j][y] = {
//					columnWidth : .45,
//					layout : "form",
//					items : [{
//						xtype : ListField_winMap[i].getXtype(),
//						fieldLabel : ListField_winMap[i].getFieldLabel(),
//						name:ListField_winMap[i].getName(),
//						id:ListField_winMap[i].getId(),
//						store: ListField_winMap[i].getStore(),
//						valueField:"value",  
//						displayField:'name',
//						typeAhead: true,
//						mode: 'local',
//						triggerAction: 'all',
//						emptyText:'————请选择————',
//						selectOnFocus:true,
//						width:ListField_winMap[i].getWidth()
//					}]
//			};
//		} else if('datefield'==ListField_winMap[i].getXtype()){//日期
//			items_column[j][y] = {
//					columnWidth : .45,
//					layout : "form",
//					items : [{
//						xtype : ListField_winMap[i].getXtype(),
//						id:ListField_winMap[i].getId(),
//						name:ListField_winMap[i].getName(),
//						fieldLabel : ListField_winMap[i].getFieldLabel(),
//						width : ListField_winMap[i].getWidth(),
//						format: ListField_winMap[i].getFormat()
//					}]
//			};
//		} else if('button'==ListField_winMap[i].getXtype()){//按钮
//			var fun = ListField_winMap[i].getStore();
//			items_column[j][y] = {
//					buttonAlign : "center",
//					buttons : [{
//						text : ListField_winMap[i].getFieldLabel(),
//						type : 'button',
//						handler: function(){
//							eval(fun);
//							queryDetailWin1.hide();
//						}
//					}]
//			};
//		} else if('textfield'==ListField_winMap[i].getXtype()){//输入框
//			items_column[j][y] = {
//					columnWidth : .45,
//					layout : "form",
//					items : [{
//						xtype : ListField_winMap[i].getXtype(),
//						fieldLabel : ListField_winMap[i].getFieldLabel(),
//						name :ListField_winMap[i].getName(),
//						id :ListField_winMap[i].getId(),
//						width : ListField_winMap[i].getWidth()
//					}]
//			};
//		}
//		y++;
//	}
//	
//	for(var i=0;i<items_column.length;i++){
//		items_line[i] = {	// 行1
//				layout : "column",
//				bodyStyle:'margin-top:5px;',
//				items : items_column[i]
//		};
//	}
//	var khcxtj = new Ext.form.FieldSet(
//			{
//				xtype:'fieldset',
//				title: ListField_winMap[0].getF_title(),
//				collapsible: false,
//				autoHeight:true,
//				width:defaultFieldSetWidth,
//				layout : "form",
//				items : items_line
//			}
//	);
//	
//	var queryFormDetail =  new Ext.FormPanel(
//			{
//				width : defaultFieldSetWidth,
//				autoHeight : true,
//				frame : true,
//				layout : "form", // 整个大的表单是form布局
//				id:'queryFormDetail',
//				labelWidth : 100,
//				standardSubmit:true,
//				labelAlign : "right",
//				onSubmit: Ext.emptyFn,
//				submit: function() {
//					this.getEl().dom.action='../custMessadd.do'; //连接到服务器的url地址
//					this.getEl().dom.submit();
//				},
//				items : [khcxtj]
//			}
//	);
//	
//	queryDetailWin1 = new Ext.Window({
//		id:'queryDetailWin1',
//		title:ListField_winMap[0].getW_title(),
//		autoHeight:true,
//		collapsible:true,
//		closeable:true,
//		closeAction:'close',
//		draggable:false,
//		shadow:false,
//		width:ListField_winMap[0].getWidth(),
//		y : ListField_winMap[0].getY(),
//		layout:'fit',
//		modal:true,
//		items:[queryFormDetail]
//	});
//	return queryDetailWin1;
//	
//}
//每页显示条数方法
function pageClick(funcId,pageclickednumber) {
	var showCheckBox = showCheckBoxMap[funcId];
	var showRadioBox = showRadioBoxMap[funcId];
	var showTrIndex = showTrIndexMap[funcId];
	
	$("#currPage_"+funcId).val(pageclickednumber);
	$("#totalPages_"+funcId).html(totalPagesMap[funcId]);
//	$("#data_table_content_"+funcId).html("查询中...");
	$("#data_table_content_"+funcId).append('<img  src="'+basePath+'images/icon-44.gif" style="position:fixed;left:47%;top:20%;z-index:111">');
	
	var indexIdBase = parseInt((pageclickednumber-1) * defaultPageSizeMap[funcId]);
	
	currPagesMap[funcId]=pageclickednumber;
	currentPage=pageclickednumber;
	
	var dataPara = parametersMap[funcId];
	
	dataPara['funcId']=funcId;
	dataPara['pageSize']=defaultPageSizeMap[funcId];
	dataPara['curPage']=pageclickednumber;
	dataPara['v_first_query']='Y';
	dataPara['isOptionsQuery']='N';
	
//	$("#data_table_content_"+funcId).html("查询中...");
	$("#data_table_content_"+funcId).append('<img  src="'+basePath+'images/icon-44.gif" style="position:fixed;left:47%;top:20%;z-index:111">');
	
//	$("#table_parent").height(queryHeight);
	$.ajax({
		url : '../../public.asp',
		type : 'post',
		data : dataPara,
		async : false,
		dataType : 'json',// 接受数据格式
		success : function(data) {
			var operInfo='';
			var click_name='';
			
			var trs = '';
			trs_head = trs;
			allTrDataMap[funcId] = data;
			allTrDataMap_Checked[funcId] = new Array();
			for ( var j = 1; j < data.length; j++) {
				var td_str='';
				var oneCol=data[j];
				
				if(showCheckBox){
					td_str += '<td width="30" style="text-align:center;">'
						     +'<input id="check" type="checkbox" name="checkbox_'+funcId+'" value="'+j+'"/></td>';
				} else if(showRadioBox){
					td_str += '<td width="30" style="text-align:center;"><input id="radio" type="radio" name="radiobutton_'+funcId+'" value="aa"/></td>';
				}
				if(showTrIndex){
					td_str += '<td width="30" style="text-align:center;">' + (indexIdBase+j) + '</td>';
				}
				/* 加载真实列的数据 */
				for ( var k = 0; k < HeaderNames_enMap[funcId].length; k++) {
					var realKey = HeaderNames_enMap[funcId][k];
					var oprInfo = HeaderNames_oprMap[funcId][realKey];
					if(!isNull(oprInfo)){
						operInfo=oprInfo;
						var clickName = oprInfo['clickName'];
						click_name=clickName;
						var trContent = oprInfo['trContent'];
						if(isNull(trContent)){
							var key = HeaderNames_enMap[funcId][k].toLowerCase();
							trContent =  oneCol[key]==null||undefined ? "" : oneCol[key];
							//trContent =  oneCol[key] ;
						}
						var clazz = oprInfo['clazz'];
						td_str += '<td class="'+clazz+'"><a id="oprclick" href="javascript:void(0)" style="text-align:center;"  onclick='+click_name+'>'+trContent+'</a></td>';
					}else{
						var clazz = HeaderNames_clsMap[funcId][k];
						var key = HeaderNames_enMap[funcId][k].toLowerCase();

//						td_str += '<td class="'+clazz+'">' + oneCol[key] + '</td>';
						var vv = oneCol[key]==null||undefined ? "" : oneCol[key];
						if(key=="cz"){
							td_str += '<td class="'+clazz+'"><center>'
							var oprs =  HeaderNames_oprsMap[funcId].split("_@@_");
							for(var i = 0 ;i < oprs.length ;i++){
								var opr_detail = oprs[i].split("@@");
								var opr_func = opr_detail[0];
								var opr_name = opr_detail[1];
								if(opr_func=="previewHl"){
									td_str += '<a id="'+opr_func+'" href="javascript:void(0)" style="text-align:center;" onMouseOver="'+opr_func+'('+j+');" onMouseOut="hlPreview('+j+');">'+opr_name+'</a>&nbsp;';
								}else{
									td_str += '<a id="'+opr_func+'" href="javascript:void(0)" style="text-align:center;" onclick="'+opr_func+'('+j+');">'+opr_name+'</a>&nbsp;';
								}
							}
							td_str += '</center></td>';
						}else{
							if(funcId=="fundBasicInformationQuery"){
								if(realKey=="fund_name"){
									  td_str += '<td style="text-align:center;" class="'+clazz+'"><a  href="javascript:void(0)">' + vv + '</a></td>';
								}else{
									  td_str += '<td style="text-align:center;" class="'+clazz+'">' + vv + '</td>';
								}
							}else{
								  td_str += '<td style="text-align:center;" class="'+clazz+'">' + vv + '</td>';
							}
						}
					}
				}
				
//				var doubleClickStr = '';
//				
//				if(isNull(canDoubleClickMap[funcId])||canDoubleClickMap[funcId]){
//					doubleClickStr = ' ondblclick="showTrInfo(\''+funcId+'\',this,'+j+')" ';
//				}
//				doubleClickStr += ' onclick="getTrInfo(\''+funcId+'\',this,'+j+')" ';
				
//				trs += '<tr '+doubleClickStr+'>';
				trs += '<tr>';
				trs += td_str;
				trs += '</tr>';
			}
			$("#data_table_content_"+funcId).html(trs);
			var hgt = $('#table-fixed tbody').height();
			$('.rc-handle').css({'height':hgt + 20});
			
			$("#table-fixed").resizableColumns({
				store: store
			});
			if ($('#table-fixed').height()<defaultTableHeight){
				  $('.fixed-div').css({'display': 'none'});
			}else{
				  $('.fixed-div').css({'display': 'block'});
			}
			bindEvent(funcId,operInfo,click_name);
		},
		failure : function(data) {
			window.clearInterval(print);
		},
		error : function(data) {
			top.window.location.href= '/webapp-inner/index.jsp';
		}
	});
}
function doQuery(funcId,machedQuery) {
	var showCheckBox = showCheckBoxMap[funcId];
	var showRadioBox = showRadioBoxMap[funcId];
	var showTrIndex = showTrIndexMap[funcId];

	canExportMap[funcId] = false;
	//当前页码
	currPagesMap[funcId] = 1;
	//打印时间
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
	
	if(!isNull(machedQuery)&&machedQuery){
		dataPara['matchedCloumn']=$("#matchInfo_"+funcId).val();
	}

	if(!isNull(queryWindowMap[funcId])){
		queryWindowMap[funcId].show();
		queryWindowMap[funcId].hide();

	}

	$("#timeCost_"+funcId).html("");
	$("#data_table_content_"+funcId).append('<img  src="'+basePath+'images/icon-44.gif" style="position:fixed;left:47%;top:20%;z-index:111">');
	
	var flag = chechForm();
	if (flag) {
		$.ajax({
			url : '../../public.asp',
			type : 'post',
			data : dataPara, //要发送的数据
			async : false,
			dataType : 'json',// 接受数据格式
			success : function(data) {//data为返回的数据，这里做数据绑定
				var operInfo='';
				var click_name='';
				
				var DataInfo = data[0];
				
				if(DataInfo['error_code']!=null){
					$("#data_table_content_"+funcId).html("查询失败...");
				}
				
				//recordsCount 查询出多少条数据
				var recordsCount = DataInfo.maxSize;
				if(recordsCount==null){
					recordsCount = 0;
				}
				totalPages = Math.ceil(parseInt(recordsCount)/parseInt(defaultPageSizeMap[funcId]));

				$("#currPage_"+funcId).val(1);
				$("#totalPages_"+funcId).html(totalPages);
				
				totalPagesMap[funcId] = totalPages;
				
				var resultFlag = "true";
		//		查询出需要的数据，花费时间
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
					for ( var j = 1; j <data.length; j++) {
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
									operInfo=oprInfo;
									var clickName = oprInfo['clickName'];
									click_name=clickName;
									var trContent = oprInfo['trContent'];
									if(isNull(trContent)){
										var key = HeaderNames_enMap[funcId][k].toLowerCase();
										trContent =  oneCol[key]==null||undefined ? "" : oneCol[key];
										//trContent =  oneCol[key] ;
									}
									var clazz = oprInfo['clazz'];
									td_str += '<td class="'+clazz+'"><a id="oprclick" href="javascript:void(0)" style="text-align:center;" onclick='+click_name+' >'+trContent+'</a></td>';
								}else{
									var clazz = HeaderNames_clsMap[funcId][k];
									var key = HeaderNames_enMap[funcId][k].toLowerCase();
	
	//								td_str += '<td class="'+clazz+'">' + oneCol[key] + '</td>';
									var vv = oneCol[key]==null||undefined ? "" : oneCol[key];
									if(key=="cz"){
										td_str += '<td class="'+clazz+'"><center>'
										var oprs =  HeaderNames_oprsMap[funcId].split("_@@_");
										for(var i = 0 ;i < oprs.length ;i++){
											var opr_detail = oprs[i].split("@@");
											var opr_func = opr_detail[0];
											var opr_name = opr_detail[1];
											if(opr_func=="previewHl"){
												td_str += '<a id="'+opr_func+'" href="javascript:void(0)" style="text-align:center;" onMouseOver="'+opr_func+'('+j+');" onMouseOut="hlPreview2('+j+');">'+opr_name+'</a>&nbsp;';
											}else{
												td_str += '<a id="'+opr_func+'" href="javascript:void(0)" style="text-align:center;" onclick="'+opr_func+'('+j+');">'+opr_name+'</a>&nbsp;';
											}
										}
										td_str += '</center></td>';
									}else{
										if(funcId=="fundBasicInformationQuery"){
											if(realKey=="fund_name"){
												  td_str += '<td style="text-align:center;" class="'+clazz+'"><a  href="javascript:void(0)"  onclick="proInformation('+j+')">' + vv + '</a></td>';
											}else{
												  td_str += '<td style="text-align:center;" class="'+clazz+'">' + vv + '</td>';
											}
										}else{
											  td_str += '<td style="text-align:center;" class="'+clazz+'">' + vv + '</td>';
										}
									}
								}
							}
						}else if(data.length==1){
							$("#currPage_"+funcId).val(0);
							var col_length = HeaderNames_enMap[funcId].length-3;
							if(col_length<=0){
								col_length = 1;
							}
							if(showRadioBoxMap[funcId]){
								td_str ='<td  colspan='+(col_length+1)+' style="border-style:none;padding-left:200px;"><font>'+"对不起，没有查询到相关记录!"+'</font></td>';
							}else{
								td_str ='<td  colspan='+col_length+' style="border-style:none;padding-left:200px;"><font>'+"对不起，没有查询到相关记录!"+'</font></td>';
							}
							
						}
						
//						var doubleClickStr = '';
//						
//						if(isNull(canDoubleClickMap[funcId])||canDoubleClickMap[funcId]){
//							doubleClickStr = ' ondblclick="showTrInfo(\''+funcId+'\',this,'+j+')" ';
//						}
//						doubleClickStr += ' onclick="getTrInfo(\''+funcId+'\',this,'+j+')" ';
						
						trs += '<tr>';
						trs += td_str;
						trs += '</tr>';
					}
					$("#data_table_content_"+funcId).html(trs);
					var hgt = $('#table-fixed tbody').height();
					$('.rc-handle').css({'height':hgt + 20});
					
					$("#table-fixed").resizableColumns({
						store: store
					});
					if ($('#table-fixed').height()<defaultTableHeight){
						  $('.fixed-div').css({'display': 'none'});
					}else{
						  $('.fixed-div').css({'display': 'block'});
					}
				}
				bindEvent(funcId,operInfo,click_name);
			},
			failure : function(data) {
				alert('查询失败，请联系管理员！');
				window.clearInterval(print);
			},
			error : function(data) {
				top.window.location.href= '/webapp-inner/index.jsp';
			}
		});
	} else {
		window.clearInterval(print);
	};
}

function setAllChecked(funcId){
	allTrDataMap_Checked[funcId] = new Array();
	//判断是否被选中
	if($("#allControlBox_"+funcId).is(":checked") || $("#allControlBox_fixed_"+funcId).is(":checked")){
		$("input[name='checkbox_"+funcId+"']").attr("checked",true);
		for(var k = 1;k< allTrDataMap[funcId].length ;k++){
			allTrDataMap_Checked[funcId].push(k);
		}
	}else{
		$("input[name='checkbox_"+funcId+"']").attr("checked",false);
	}
}

function oprClickDear(funcId,ele,columnNum,callback){
	getTrInfo(funcId,ele,columnNum);
	callback();
}

function setOneChecked(funcId,columnNum,ele){
	var index= jQuery.inArray(columnNum,allTrDataMap_Checked[funcId]);
	if($(ele).is(":checked")&&index == -1){
		allTrDataMap_Checked[funcId].push(columnNum);
	}else if(!$(ele).is(":checked")&&index != -1){
		allTrDataMap_Checked[funcId].splice(jQuery.inArray(columnNum,allTrDataMap_Checked[funcId]),1);
	}
}

function dealRadioChecked(funcId,columnNum){
	trDataInfoMap[funcId]= allTrDataMap[funcId][columnNum];
	radioCheckedDeal(trDataInfoMap[funcId]);
}

function showTrInfo(funcId,ele,columnNum){
	
	getTrInfo(funcId,ele,columnNum);
	showDoubleClickWindow(trDataInfoMap[funcId]);
}

function getTrInfo(funcId,ele,columnNum){
	oldEle = selectedTrMap[funcId];
	if(!isNull(oldEle)){
//		oldEle.style.backgroundColor="#FFFFFF";
		oldEle.css("background-color","#f6fbfe");
	}
	selectedTrMap[funcId] = ele;
//	ele.style.backgroundColor="#ECF5FF";
	ele.css("background-color","#b5b8c8");
	trDataInfoMap[funcId]= allTrDataMap[funcId][columnNum];
}

function IDU(idu_funcId,obj,query_funcId) {
	
	var dataPara = obj;
	dataPara['funcId']=idu_funcId;
	dataPara['mathid']=Math.random();
	
		$.ajax({
			url : 'CommonDealer.do',
			type : 'post',
			data : dataPara,
			dataType : 'json',// 接受数据格式
			success : function(data) {
				doQuery(query_funcId);
			},
			failure : function(data) {
				window.clearInterval(print);
			}
		});
}
function IDUOnly(idu_funcId,obj,successMsg,failureMsg) {
	var dataPara = obj;
	dataPara['funcId']=idu_funcId;
	dataPara['mathid']=Math.random();
		$.ajax({
			url : 'CommonDealer.do',
			type : 'post',
			data : dataPara,
			dataType : 'json',// 接受数据格式
			success : function(data) {
				if(!isNull(successMsg)){
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', successMsg);
				}else{
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', '执行成功!');
				}
			},
			failure : function(data) {
				if(!isNull(failureMsg)){
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', failureMsg);
				}else{
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', '执行失败!');
				}
				window.clearInterval(print);
			}
		});
}
function doProducer(pro_funcId,obj,funcId,successMsg,failureMsg) {
	var dataPara = obj;
	dataPara['funcId']=pro_funcId;
	dataPara['mathid']=Math.random();
		$.ajax({
			url : 'CommonDealer.do',
			type : 'post',
			data : dataPara,
			dataType : 'json',// 接受数据格式
			success : function(data) {
				var message = data[0];
				proMessageMap[pro_funcId] = message;
				if(isNull(message['info_err'])||message['info_err']==''){
					if(!isNull(funcId)){
						doQuery(funcId);
					}
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', message['info_ok']);
				}else{
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', message['info_err']);
				}
				
			},
			failure : function(data) {
				if(!isNull(failureMsg)){
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', failureMsg);
				}else{
					Ext.Msg.minWidth= min_width;
					Ext.Msg.alert('提示', '系统错误，请联系管理员');
				}
				window.clearInterval(print);
			}
		});
}

function queryInfoFromDataBase(funcId,params,callback){
	var dataPara = params;
	dataPara['v_first_query']='Y';
	dataPara['v_page_size']=10000;
	dataPara['v_page']= 1;
	dataPara['funcId']=funcId;
	dataPara['mathid']=Math.random();
	$.ajax({
		url : 'CommonDealer.do',
		type : 'post',
		data : dataPara,
		dataType : 'json',// 接受数据格式
		success : function(data) {
			callback(data);
		},
		failure : function(data) {
			callback(data);
		}
	});
}



function initWin(ListWindow) {
	
	var args = arguments;
	var detailWindow = '';
	
	/* 第1个参数及之后参数的处理 */
	for(var i=1;i<args.length;i++){
		 var type = args[i].getType();
		 if(type=='ListGridSet'){
			 detailWindow = initWinSet(ListWindow,args[i]);
		 }
	}
	return detailWindow;
	
	$('.x-panel-bwrap div').remove('.x-panel-nofooter');
	
}
function initWinSet(ListWindow,listGrid) {
	
	var listGridFields = listGrid.getListGridFields();
	var j = 0;//换行
	var y =0;//列
	var items_line = new Array();
	var items_column = new Array();
	items_column[0] = new Array();
	for(var i=0;i<listGridFields.length;i++){
		if(j!=listGridFields[i].getLine()){
			j = listGridFields[i].getLine();
			items_column[j] = new Array();
			y=0;
		}
			if('combo'==listGridFields[i].getXtype()||'lovcombo'==listGridFields[i].getXtype()){//下拉
				
				items_column[j][y] = {
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : listGridFields[i].getXtype(),
							fieldLabel : listGridFields[i].getFieldLabel(),
							name:listGridFields[i].getId(),
							id:listGridFields[i].getId(),
							store: listGridFields[i].getStore(),
							valueField:"value",  
					        displayField:'name',
					        typeAhead: true,
					        mode: 'local',
					        triggerAction: 'all',
					        emptyText:'————请选择————',
					        selectOnFocus:true,
					        width:listGridFields[i].getWidth()
						}]
				};
			} else if('datefield'==listGridFields[i].getXtype()){//日期
				items_column[j][y] = {
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : listGridFields[i].getXtype(),
							id:listGridFields[i].getId(),
							name:listGridFields[i].getId(),
							fieldLabel : listGridFields[i].getFieldLabel(),
							width : listGridFields[i].getWidth(),
							format: listGridFields[i].getFormat()
						}]
				};
			} else if('button'==listGridFields[i].getXtype()){//按钮
				var fun = listGridFields[i].getFun();
				items_column[j][y] = {
							buttonAlign : "center",
							buttons : [{
								text : listGridFields[i].getFieldLabel(),
								type : 'button',
								handler: function(){
									eval(fun);
									queryDetailWin1.hide();
								}
							}]
				};
			} else if('textfield'==listGridFields[i].getXtype()){//输入框
				items_column[j][y] = {
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : listGridFields[i].getXtype(),
							fieldLabel : listGridFields[i].getFieldLabel(),
							name :listGridFields[i].getId(),
							id :listGridFields[i].getId(),
							width : listGridFields[i].getWidth()
						}]
				};
			}
			y++;
	}
	
	for(var i=0;i<items_column.length;i++){
		items_line[i] = {	// 行1
				layout : "column",
				bodyStyle:'margin-top:5px;',
				items : items_column[i]
		};
	}
	 var khcxtj = new Ext.form.FieldSet(
				{
					xtype:'fieldset',
		            title: ListWindow.getF_title(),
		            collapsible: false,
		            autoHeight:true,
		            width:defaultFieldSetWidth,
		            layout : "form",
					items : items_line
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
	
	 queryDetailWin1 = new Ext.Window({
			id:'queryDetailWin1',
			title:ListWindow.getW_title(),
			autoHeight:true,
			collapsible:true,
			closeable:true,
			closeAction:'close',
			draggable:false,
			shadow:false,
			width:ListWindow.getWidth(),
			y : ListWindow.getY(),
			layout:'fit',
			modal:true,
			items:[queryFormDetail]
		});
	 
	 return queryDetailWin1;
}

function clickAfter(){
	// 如果需要，在具体的页面中重写即可。
}

//绑定事件
function bindEvent(funcId,oprInfo,clickname){
	var i=0;
	
	//绑定双击事件
	if(isNull(canDoubleClickMap[funcId])||canDoubleClickMap[funcId]){
		$(".hovertable tr").dblclick(function() {
	        var row = $(this).index() + 1; // 行位置
	        showTrInfo(funcId,$(this),row);
	    });
	}
	$(".hovertable tr").click(function() {
        var row = $(this).index() + 1; // 行位置
        getTrInfo(funcId,$(this),row);
        i=row;
        clickAfter();
    });
	
	//鼠标移入移出变色
	$(".hovertable tr").mouseover(function() {
		var row = $(this).index() + 1; // 行位置
		if(i!=row){
			$(this).css("background-color","#eee");
		}
    });
	$(".hovertable tr").mouseout(function() {
		var row = $(this).index() + 1; // 行位置
		if(i!=row){
			$(this).css("background-color","#f6fbfe");
		}
    });
	
	if(showCheckBoxMap[funcId]){
		$(".hovertable #check").click(function() {
			var col = $(this).parent("td");
			var row=col.parent("tr").index()+1;// 行位置
	        setOneChecked(funcId,row,$(this));
	    });
	} else if(showRadioBoxMap[funcId]){
		$(".hovertable #radio").click(function() {
			var col = $(this).parent("td");
			var row=col.parent("tr").index()+1;// 行位置
	        setOneChecked(funcId,row);
	    });
	}
	
	if(!isNull(oprInfo)){
		$(".hovertable #oprclick").click(function() {
			var col = $(this).parent("td");
			var row=col.parent("tr").index()+1;// 行位置
	        oprClickDear(funcId,$(this),row,eval(clickname));
	    });
	}
	
}

//鼠标悬停
function titleMouseOver(obj,event,words_per_line) {
    //无TITLE悬停，直接返回
    if(typeof obj.title == 'undefined' || obj.title == '') return false;
    //不存在title_show标签则自动新建
    var title_show = document.getElementById("title_show");
    if(title_show == null){
        title_show = document.createElement("div");                            //新建Element
        document.getElementsByTagName('body')[0].appendChild(title_show);    //加入body中
        var attr_id = document.createAttribute('id');                        //新建Element的id属性
        attr_id.nodeValue = 'title_show';                                    //为id属性赋值
        title_show.setAttributeNode(attr_id);                                //为Element设置id属性
        
        var attr_style = document.createAttribute('style');                    //新建Element的style属性
        attr_style.nodeValue = 'position:absolute;'                            //绝对定位
            +'border:solid 1px #999999; background:#EDEEF0;'                //边框、背景颜色
            +'border-radius:2px;box-shadow:2px 3px #999999;'                //圆角、阴影
            +'line-height:18px;'                                            //行间距
            +'font-size:12px; padding: 2px 5px;';                            //字体大小、内间距
        try{
            title_show.setAttributeNode(attr_style);                        //为Element设置style属性
        }catch(e){
            //IE6
            title_show.style.position = 'absolute';
            title_show.style.border = 'solid 1px #999999';
            title_show.style.background = '#EDEEF0';
            title_show.style.lineHeight = '18px';
            title_show.style.fontSize = '18px';
            title_show.style.padding = '2px 5px';
        }
    }
    //存储并删除原TITLE
    document.title_value = obj.title;
    obj.title = '';
    //单行字数未设定，非数值，则取默认值50
    if(typeof words_per_line == 'undefined' || isNaN(words_per_line)){
        words_per_line = 10;
    }
    //格式化成整形值
    words_per_line = parseInt(words_per_line);
    //在title_show中按每行限定字数显示标题内容，模拟TITLE悬停效果
    title_show.innerHTML = split_str(document.title_value,words_per_line);
    //显示悬停效果DIV
    title_show.style.display = 'block';
    
    //根据鼠标位置设定悬停效果DIV位置
    event = event || window.event;                            //鼠标、键盘事件
    var top_down = 15;                                        //下移15px避免遮盖当前标签
    //最左值为当前鼠标位置 与 body宽度减去悬停效果DIV宽度的最小值，否则将右端导致遮盖
    var left = Math.min(event.clientX,document.body.clientWidth-title_show.clientWidth);
    title_show.style.left = left+"px";            //设置title_show在页面中的X轴位置。
    title_show.style.top = (event.clientY + top_down)+"px";    //设置title_show在页面中的Y轴位置。
}
//鼠标移出
function titleMouseOut(obj) {
    var title_show = document.getElementById("title_show");
    //不存在悬停效果，直接返回
    if(title_show == null) return false;    
    //存在悬停效果，恢复原TITLE
    obj.title = document.title_value;
    //隐藏悬停效果DIV
    title_show.style.display = "none";
}

/**
 * JS字符切割函数
 * @params     string                原字符串
 * @params    words_per_line        每行显示的字符数
 */
function split_str(string,words_per_line) {
    //空串，直接返回
    if(typeof string == 'undefined' || string.length == 0) return '';
    //单行字数未设定，非数值，则取默认值50
    if(typeof words_per_line == 'undefined' || isNaN(words_per_line)){
        words_per_line = 10;
    }
    //格式化成整形值
    words_per_line = parseInt(words_per_line);
    //取出i=0时的字，避免for循环里换行时多次判断i是否为0
    var output_string = string.substring(0,1);
    //循环分隔字符串
    for(var i=1;i<string.length;i++) {
        //如果当前字符是每行显示的字符数的倍数，输出换行
        if(i%words_per_line == 0) {
            output_string += "<br/>";
        }
        //每次拼入一个字符
        output_string += string.substring(i,i+1);
    }
    return output_string;
}
//自适应ie,日期组件
Ext.override(Ext.menu.Menu,{
	 autoWidth:function(){
		 this.width+="px";
	 }
});

function getPublicUrl(){
	$.ajax({
		url : 'Com.purl',
		type : 'post',
		data : {},
		dataType : 'json',// 接受数据格式
		success : function(data) {
			//得到属性文件中设置的url
			publicUrl=data[0]['address'];
		},
		failure : function(data) {
			window.clearInterval(print);
		}
	});
}

function check_qx(){
	var qz='';
	$.ajax({
		url:'CommonDealer.acp',
		type : 'post',
		data : {'acp_id':'qxyz'},
		dataType : 'json',
		async: false,
		success : function(data){
			qz=data[0]['zdqz'];
		}
	});
	return qz;
}
/* 下拉框 */
function setSelection(elem, leftIndex, rightIndex) {
    if (elem.selectionStart !== undefined) { //IE 9 ，10，其他浏览器
        elem.selectionStart = leftIndex;
        elem.selectionEnd = rightIndex;
    } else { //IE 6,7,8
        var range = elem.createTextRange();

        range.move("character", -elem.value.length); //光标移到0位置。
        //这里一定是先moveEnd再moveStart
        //因为如果设置了左边界大于了右边界，那么浏览器会自动让右边界等于左边界。
        range.moveEnd("character", rightIndex);
        range.moveStart("character", leftIndex);
        range.select();
    }
}


