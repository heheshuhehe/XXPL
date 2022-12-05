 $(function(){
	createPanel_A();
});

function createPanel_A(){
	eval(str);
	
	var queryWin = null;
	
	setCanDoubleClick(funcId_A,false);
	fullScreenMap[funcId_A]=true;
	showToolsBar[funcId_A]=false;
//	showCheckBoxMap[funcId_A]=true;
	showCheckBoxMap[funcId_A]=true;
	showTrIndexMap[funcId_A]=true;
	defaultPageSizeMap[funcId_A]= 10;
//	panelNameMap[funcId_A]= '员工基本信息';
	/*funcId_A:功能号; 'panel'：功能显示的位置; 查询窗口：可以为null; ccc:表格列定义*/
	initPanel('',funcId_A,'panel_123',queryWin,cccman);
	doQuery(funcId_A);
}

function getParameters(funcId){
	if(funcId==funcId_A){
		/* 获取第一个panel的查询窗口的参数*/
		p_ygbh=$('#inner_qtext').val();
		var data={
				v_ygbh:p_ygbh
		};
		parametersMap[funcId_A] = data;
	}
}

function innerQueryWin(){
	doQuery(funcId_A);
}

function chechForm(){
	return true;
}

function add(){
	window.parent.setData(allTrDataMap_Checked,allTrDataMap);
}

function closeWin(){
	window.parent.hzs_innerQueryWin.destroy();
}
