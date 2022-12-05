var i = 4 ; 
var et;

function addtab(){     
         //注意:每个Tab标签只渲染一次     
          tabs = new Ext.TabPanel({
             renderTo: "divright",//绑定在标签上     
             activeTab: 0,//初始显示第几个Tab页     
             deferredRender: false,//是否在显示每个标签的时候再渲染标签中的内容.默认true     
             tabPosition: 'top',//表示TabPanel头显示的位置,只有两个值top和bottom.默认是top.     
             enableTabScroll: true,//当Tab标签过多时,出现滚动条   
             autoScroll : false,
             iconCls : 'icon-tab-default',
             id:'tab_panel',
//             bodyStyle : "margin:0;padding:0;width:80%;height:100%",
             width:allwidth, 
             height:$(window).height()-83,
             listeners: {
                 load: function(store, records, successful, eOpts ) {
                   //如果session超时，则返回的记录应该是没有的
                   if(records.length <= 0){
                       Ext.Msg.alert('提示','请重新登录',function(){
                           location.href = 'login.html';
                       });
                   }
                 }
              },
             items: [//Tab的个数   
             {    
            	 id : 'inittab',
                 title: '首页',     
//                 frame:true, 
                 html:'<iframe src="mainPage.jsp" frameborder="0" width="100%" scrolling="no" height="100%"></iframe>' ,
//                autoLoad:{url:'test.jsp'},
           	    closable: false
             	}
             ]
         });    
}   
function addtab1(url,name){
	//关闭初始页面
	if(url==null){
		url="http://www.baidu.com";
	}else if(url.substring(0,2)=="id"){
		url="external/sjzxzdbb.jsp?"+url;
	}
	 var t = tabs.getActiveTab();   
    if(t.closable){     
    	if('inittab'==t.id){
    		tabs.remove(t);//删除标签     
    	}
    }else{     
        //Ext.Msg.alert("提示","该标签不能关闭") ;     
    }     
    var flag = true;
    for(var qp=0;qp<tabs.items.length;qp++){
        var code = tabs.items.get(qp).getItemId();
        if(name==code){
        	flag = false;
        }
    }
    if(flag){
	    tabs.add({     
	        id: name,     
	        title:name,   
	        frame:true, 
	        html:'<iframe src='+url+' frameborder="0" width="100%" scrolling="yes" height="100%"></iframe>' ,
	        closable: true
	    }) ;     
    }
    tabs.setActiveTab(name) ;//当id为"id"的Tab标签显示(变为活动标签)
//    alert(document.getElementById("main").style.height);  
    
//    alert($("#main").css("height"));  
//    tabs.setHeight($("#main").css("height"));
//    alert(et);
    tabs.setHeight( $(window).height()-83);
    status=0;
    allwidth=switchSysBar();
    tabs.setWidth(allwidth);
    tabs.show();
}


function list(){
//		$.ajax({
//			url : '../../queryMenu.asp?mathid='+Math.random(),
//			type : 'post',
//			dataType:'json',//接受数据格式 
//			success : function(data) {
//				initMenu(data);
//			},
//			failure : function(data) {
//				alert('初始化菜单失败');
//			},
//			error :function(data){
//				top.window.location.href= '/webapp-inner/index.jsp';
//			}
//		});
	
	var data=[/*{"cdid":"01","fcdid":"0","cdname":"1 私募外包综合业务","cdsx":"01"},
	         // {"cdid":"0100","fcdid":"01","cdname":"1.0 账套基本信息999","cdurl":"/maven-new/modules/guzhi/accountSet.jsp","cdsx":"0100"},
	          {"cdid":"0100","fcdid":"01","cdname":"1.1 账套基本信息","cdurl":"/maven-new/modules/guzhi/accountinfo.jsp","cdsx":"0100"},
	        //  {"cdid":"0101","fcdid":"01","cdname":"1.0 账套对应关系配置","cdurl":"/maven-new/modules/guzhi/accountSetNew.jsp","cdsx":"0101"},
	          {"cdid":"0102","fcdid":"01","cdname":"1.2 估值人员账套批量配置","cdurl":"/maven-new/modules/guzhi/guzhiUserConfig.jsp","cdsx":"0102"},
	          {"cdid":"0103","fcdid":"01","cdname":"1.3 科目对应关系配置","cdurl":"/maven-new/modules/guzhi/kemuConfig.jsp","cdsx":"0103"},
	          {"cdid":"0104","fcdid":"01","cdname":"1.4 账套核对","cdurl":"/maven-new/modules/guzhi/kemuCheck.jsp","cdsx":"0104"},
	          {"cdid":"0105","fcdid":"01","cdname":"1.5 估值表查询","cdurl":"/maven-new/modules/guzhi/gzb.jsp","cdsx":"0105"},
	          
	        	         
	         // {"cdid":"0105","fcdid":"01","cdname":"1.5 托管柜台核对","cdurl":"/maven-new/modules/guzhi/tgGthCheck.jsp","cdsx":"0105"},
	         //{"cdid":"0113","fcdid":"01","cdname":"1.13估值表发送","cdurl":"/maven-new/modules/guzhi/reportval.jsp","cdsx":"0113"},	        
	        //  {"cdid":"0110","fcdid":"01","cdname":"1.10 托管天天利天天增分红信息","cdurl":"/maven-new/modules/guzhi/smttlandttz.jsp","cdsx":"0110"},
	         // {"cdid":"0116","fcdid":"01","cdname":"1.16外包估值与柜台核对","cdurl":"/maven-new/modules/guzhi/WBcheckBalance.jsp","cdsx":"0116"},
	         // {"cdid":"0117","fcdid":"01","cdname":"1.17托管估值与柜台核对","cdurl":"/maven-new/modules/guzhi/TGcheckBalance.jsp","cdsx":"0117"},
	        //  {"cdid":"0126","fcdid":"01","cdname":"1.26费用数据查询(新)","cdurl":"/maven-new/modules/guzhi/feeExportnew.jsp","cdsx":"0126"},
	        
	        
	          
	          {"cdid":"02","fcdid":"0","cdname":"2 托管业务","cdsx":"02"},
	          {"cdid":"0201","fcdid":"02","cdname":"2.1 托管资金账号配置","cdurl":"/maven-new/modules/guzhi/zjzhconfigtg.jsp","cdsx":"0201"},
	          {"cdid":"0202","fcdid":"02","cdname":"2.2 托管估值与柜台核对(新)","cdurl":"/maven-new/modules/guzhi/TGcheckBalanceNew.jsp","cdsx":"0202"},
	          {"cdid":"0203","fcdid":"02","cdname":"2.3托管场外登记标的","cdurl":"/maven-new/modules/guzhi/tg4otcmanage.jsp","cdsx":"0203"},
	          {"cdid":"0204","fcdid":"02","cdname":"2.4 托管结息数据","cdurl":"/maven-new/modules/guzhi/shQsGth2tg.jsp","cdsx":"0204"},	       	     	          
	          {"cdid":"0205","fcdid":"02","cdname":"2.5 托管天天利天天增业务","cdurl":"/maven-new/modules/guzhi/fundsqshtg.jsp","cdsx":"0205"},
	          {"cdid":"0206","fcdid":"02","cdname":"2.6 报表核对","cdurl":"/maven-new/modules/tgyw/excelcompare.jsp","cdsx":"0206"},
	          {"cdid":"0207","fcdid":"02","cdname":"2.7 每日指令导出","cdurl":"/maven-new/modules/guzhi/TransOrder.jsp","cdsx":"0207"},
	          {"cdid":"0208","fcdid":"02","cdname":"2.8 最高额度申报","cdurl":"/maven-new/modules/tgyw/mosthighreport.jsp","cdsx":"0208"},
	          {"cdid":"0209","fcdid":"02","cdname":"2.9 估值问题知识库","cdurl":"/maven-new/modules/tgyw/tggzwtk.jsp","cdsx":"0209"},
	          {"cdid":"0210","fcdid":"02","cdname":"2.10母子基金信息配置","cdurl":"/maven-new/modules/tgyw/subfundconfig.jsp","cdsx":"0210"},
	          
	          {"cdid":"03","fcdid":"0","cdname":"3 外包业务","cdsx":"03"},
	          {"cdid":"0301","fcdid":"03","cdname":"3.1 外包资金账号配置","cdurl":"/maven-new/modules/guzhi/zjzhconfig.jsp","cdsx":"0301"},
	          {"cdid":"0307","fcdid":"03","cdname":"3.2 外包估值与柜台核对(新)","cdurl":"/maven-new/modules/guzhi/WBcheckBalanceNew.jsp","cdsx":"0302"},
	          {"cdid":"0302","fcdid":"03","cdname":"3.3  外包结息数据","cdurl":"/maven-new/modules/guzhi/shQsGth2.jsp","cdsx":"0303"},
	          {"cdid":"0303","fcdid":"03","cdname":"3.4  银行余额核对","cdurl":"/maven-new/modules/guzhi/guzhibank.jsp","cdsx":"0304"},
	          {"cdid":"0303","fcdid":"03","cdname":"3.4  银行余额核对(新)","cdurl":"/maven-new/modules/guzhi/guzhibanknew.jsp","cdsx":"0304"},
	          {"cdid":"0304","fcdid":"03","cdname":"3.5 基金开放周期","cdurl":"/maven-new/modules/guzhi/fundopeninfo.jsp","cdsx":"0305"},
	          {"cdid":"0305","fcdid":"03","cdname":"3.6 费用数据查询（旧）","cdurl":"/maven-new/modules/guzhi/feeExport.jsp","cdsx":"0306"},
	          {"cdid":"0306","fcdid":"03","cdname":"3.7 季度更新","cdurl":"/maven-new/modules/guzhi/report_jdgx.jsp","cdsx":"0307"},	         
	          {"cdid":"0307","fcdid":"03","cdname":"3.8 外包天天利天天增业务","cdurl":"/maven-new/modules/guzhi/fundsqsh.jsp","cdsx":"0308"},
	          {"cdid":"0308","fcdid":"03","cdname":"3.9 纯外包产品对账","cdurl":"/maven-new/modules/guzhi/reportval4cwb.jsp","cdsx":"0309"},
	          {"cdid":"0309","fcdid":"03","cdname":"3.10 增值税核对","cdurl":"/maven-new/modules/guzhi/zzscompare.jsp","cdsx":"0310"},
	          {"cdid":"0310","fcdid":"03","cdname":"3.11 协会编码维护","cdurl":"/maven-new/modules/guzhi/amaccode4report.jsp","cdsx":"0311"},
	          {"cdid":"0311","fcdid":"03","cdname":"3.12 柜台资金余额查询","cdurl":"/maven-new/modules/guzhi/gtbalance.jsp","cdsx":"0312"},
	          {"cdid":"0312","fcdid":"03","cdname":"3.13 外包场外登记标的","cdurl":"/maven-new/modules/guzhi/wb4otcmanage.jsp","cdsx":"0313"},
	          {"cdid":"0313","fcdid":"03","cdname":"3.14外包服务邮箱","cdurl":"/maven-new/modules/guzhi/wbmailinfo.jsp","cdsx":"0314"},
	          	          
	          
	          
	          {"cdid":"04","fcdid":"0","cdname":"4TA业务","cdsx":"04"},
	         // {"cdid":"0201","fcdid":"02","cdname":"2.1 净值对照2.5版","cdurl":"/maven-new/modules/guzhi/zuorijizhiold.jsp","cdsx":"0201"},
	          {"cdid":"0401","fcdid":"04","cdname":"4.1 净值对照4.5版","cdurl":"/maven-new/modules/guzhi/zuorijizhi.jsp","cdsx":"0401"},
	          {"cdid":"0402","fcdid":"04","cdname":"4.2 分TA与估值核对","cdurl":"/maven-new/modules/guzhi/zls.jsp","cdsx":"0402"},
	          {"cdid":"0403","fcdid":"04","cdname":"4.3 分红清盘信息","cdurl":"/maven-new/modules/ziguan/FhQp.jsp","cdsx":"0403"},
	          {"cdid":"0404","fcdid":"04","cdname":"4.4 TA划款单","cdurl":"/maven-new/modules/ziguan/FhHk.jsp","cdsx":"0404"},
	          {"cdid":"0405","fcdid":"04","cdname":"4.5 货币基金收益核对","cdurl":"/maven-new/modules/guzhi/profitdz.jsp","cdsx":"0405"},
	          
	          {"cdid":"05","fcdid":"0","cdname":"5 资管业务","cdsx":"05"},
	          {"cdid":"0501","fcdid":"05","cdname":"5.1 柜台资金核对","cdurl":"/maven-new/modules/guzhi/shQsGth.jsp","cdsx":"0501"},
	          {"cdid":"0502","fcdid":"05","cdname":"5.2 账套信息配置","cdurl":"/maven-new/modules/ziguan/accountfenlei.jsp","cdsx":"0502"},
	          {"cdid":"0503","fcdid":"05","cdname":"5.3 佣金费用","cdurl":"/maven-new/modules/ziguan/yongjin.jsp","cdsx":"0503"},
	          {"cdid":"0504","fcdid":"05","cdname":"5.4 实收资本","cdurl":"/maven-new/modules/ziguan/ziguanquery.jsp","cdsx":"0504"},
	          {"cdid":"0505","fcdid":"05","cdname":"5.5 母子账套核对","cdurl":"/maven-new/modules/guzhi/mcrelation.jsp","cdsx":"0505"},
	          {"cdid":"0506","fcdid":"05","cdname":"5.6 佣金核对 ","cdurl":"/maven-new/modules/ziguan/yongjinchecknew.jsp","cdsx":"0506"},
			  {"cdid":"0507","fcdid":"05","cdname":"5.7 多基金余额表","cdurl":"/maven-new/modules/ziguan/fundsbalance.jsp","cdsx":"0507"},
			  {"cdid":"0508","fcdid":"05","cdname":"5.8 增值税","cdurl":"/maven-new/modules/ziguan/zzsinfo.jsp","cdsx":"0508"},
			  {"cdid":"0509","fcdid":"05","cdname":"5.9 报表核对","cdurl":"/maven-new/modules/ziguan/formcheck.jsp","cdsx":"0509"},
			  {"cdid":"0510","fcdid":"05","cdname":"5.10 佣金核对(上海专用)","cdurl":"/maven-new/modules/ziguan/yongjinsh.jsp","cdsx":"0510"},		 
			  {"cdid":"0511","fcdid":"05","cdname":"5.11 风控指标查询","cdurl":"/maven-new/modules/ziguan/fkzbhd.jsp","cdsx":"0511"},
			  {"cdid":"0512","fcdid":"05","cdname":"5.12 交易指令查询","cdurl":"/maven-new/modules/ziguan/fund_directive_enquiry_lmd.jsp","cdsx":"0512"},
			  {"cdid":"0513","fcdid":"05","cdname":"5.13 交易指令核对","cdurl":"/maven-new/modules/ziguan/fund_directive_enquiry_check_lmd.jsp","cdsx":"0513"},
			  {"cdid":"0514","fcdid":"05","cdname":"5.14 增值税-核对","cdurl":"/maven-new/modules/ziguan/fund_tax_check_lmd.jsp","cdsx":"0514"},
			  //{"cdid":"0415","fcdid":"04","cdname":"4.15 佣金费用(上海集合)","cdurl":"/maven-new/modules/ziguan/yongjinshjh.jsp","cdsx":"0415"},
			  {"cdid":"0515","fcdid":"05","cdname":"5.15 佣金核对(上海集合)（新）","cdurl":"/maven-new/modules/ziguan/yongjinshjh_new.jsp","cdsx":"0515"},
			  {"cdid":"0516","fcdid":"05","cdname":"5.16 估值表发送","cdurl":"/maven-new/modules/ziguan/reportval.jsp","cdsx":"0516"},
			  {"cdid":"0517","fcdid":"05","cdname":"5.17 净值增长率计算","cdurl":"/maven-new/modules/ziguan/zzlCalc.jsp","cdsx":"0517"},
			  {"cdid":"0518","fcdid":"05","cdname":"5.18 业绩报酬计提审核","cdurl":"/maven-new/modules/ziguan/yjbc_sh.jsp","cdsx":"0518"},
			  {"cdid":"0519","fcdid":"05","cdname":"5.19 上交所结算明细查询","cdurl":"/maven-new/modules/ziguan/sjsmx.jsp","cdsx":"0519"},
			  {"cdid":"0520","fcdid":"05","cdname":"5.20 深交所结算明细查询","cdurl":"/maven-new/modules/ziguan/sjsmx_sz.jsp","cdsx":"0520"},
			  {"cdid":"0521","fcdid":"05","cdname":"5.21 基金确认单认领","cdurl":"/maven-new/modules/ziguan/jjqrd.jsp","cdsx":"0521"},
			  {"cdid":"0522","fcdid":"05","cdname":"5.22 预估年化收益率","cdurl":"/maven-new/modules/ziguan/ygnhsyl.jsp","cdsx":"0521"},
	          {"cdid":"0523","fcdid":"05","cdname":"5.23 产品开放状态核对","cdurl":"/maven-guzhi/modules/ziguan/chanpinhedui.jsp","cdsx":"0523"},
	          
	          
	          {"cdid":"06","fcdid":"0","cdname":"6定时任务","cdsx":"06"},
	          {"cdid":"0601","fcdid":"06","cdname":"6.1 数据准备","cdurl":"/maven-new/modules/guzhi/downLoadFile2.jsp","cdsx":"0601"},
	          {"cdid":"0602","fcdid":"06","cdname":"6.2 数据处理","cdurl":"/maven-new/modules/guzhi/datadeal.jsp","cdsx":"0602"},
	          {"cdid":"0603","fcdid":"06","cdname":"6.3 工作量计算","cdurl":"/maven-new/modules/ziguan/worktime_count_lmd.jsp","cdsx":"0603"},
	          {"cdid":"0604","fcdid":"06","cdname":"6.4 清算文件公共配置","cdurl":"/maven-new/modules/guzhi/qsdataprocessini.jsp","cdsx":"0604"},
	          {"cdid":"0605","fcdid":"06","cdname":"6.5 外包清算文件处理","cdurl":"/maven-new/modules/guzhi/qsdataprocess_wb.jsp","cdsx":"0605"},
	          {"cdid":"0606","fcdid":"06","cdname":"6.6 托管清算文件处理","cdurl":"/maven-new/modules/guzhi/qsdataprocess_tg.jsp","cdsx":"0606"},
	          {"cdid":"0607","fcdid":"06","cdname":"6.7 邮件自动发送","cdurl":"/maven-new/modules/guzhi/automailsend.jsp","cdsx":"0607"},
	          {"cdid":"0607","fcdid":"06","cdname":"6.7 邮件自动发送(补发)","cdurl":"/maven-new/modules/guzhi/automailsend4glr.jsp","cdsx":"0607"},
	          {"cdid":"0608","fcdid":"06","cdname":"6.8 定时任务查询","cdurl":"/maven-new/modules/guzhi/dsTask.jsp","cdsx":"0608"},
	          {"cdid":"0609","fcdid":"06","cdname":"6.9邮件信息查询","cdurl":"/maven-new/modules/guzhi/mailinfo.jsp","cdsx":"0609"},
	         

	          
	          
			  {"cdid":"07","fcdid":"0","cdname":"7 短信息服务","cdsx":"07"},
			  {"cdid":"0701","fcdid":"07","cdname":"7.1 短信服务","cdurl":"/maven-new/modules/ziguan/sms.jsp","cdsx":"0701"},
			  {"cdid":"0702","fcdid":"07","cdname":"7.2 自定义短信服务","cdurl":"/maven-new/modules/ziguan/sms_new.jsp","cdsx":"0702"},
			  
			  
			  
			  {"cdid":"08","fcdid":"0","cdname":"8 投资监督","cdsx":"08"},
			  {"cdid":"0801","fcdid":"08","cdname":"8.1 代销产品评审","cdurl":"/maven-new/modules/ziguan/dxlist.jsp","cdsx":"0801"},
			  
			  
			  {"cdid":"09","fcdid":"0","cdname":"9 综合查询","cdsx":"09"},
			  {"cdid":"0901","fcdid":"09","cdname":"9.1 私募基金综合信息","cdurl":"/maven-new/modules/guzhi/fundinfo_all.jsp","cdsx":"0901"},
			  {"cdid":"0902","fcdid":"09","cdname":"9.2 私募基金统计查询","cdurl":"/maven-new/modules/guzhi/smjjtjcx.jsp","cdsx":"0902"},
	          {"cdid":"0903","fcdid":"09","cdname":"9.3 托管外包费（已付）查询","cdurl":"/maven-new/modules/guzhi/relationTrade.jsp","cdsx":"0903"},
	          {"cdid":"0904","fcdid":"09","cdname":"9.4 业务总结","cdurl":"/maven-new/modules/guzhi/businessSum.jsp","cdsx":"0904"},
	          
	         
	          {"cdid":"10","fcdid":"0","cdname":"10 系统管理","cdsx":"10"},
	          {"cdid":"1001","fcdid":"10","cdname":"10.1 人员管理","cdurl":"/maven-new/modules/guzhi/guzhiUserInfo.jsp","cdsx":"1001"},
	          {"cdid":"1002","fcdid":"10","cdname":"10.2 字典管理","cdurl":"/maven-new/modules/guzhi/codeManage.jsp","cdsx":"1002"},
	          */
	          //托管外包核对
	          {"cdid":"11","fcdid":"0","cdname":"11 信息披露","cdsx":"11"},

	          {"cdid":"1101","fcdid":"11","cdname":"1.1 月报","cdurl":"/maven-guzhi/modules/xinxipilu/yueBao.jsp","cdsx":"1101"}, 	// monthly report
	          {"cdid":"1102","fcdid":"11","cdname":"1.2 季度更新","cdurl":"/maven-guzhi/modules/xinxipilu/jiDuGengXin.jsp","cdsx":"1102"},// quarterly report
	          {"cdid":"1103","fcdid":"11","cdname":"1.3 季报","cdurl":"/maven-guzhi/modules/xinxipilu/jiBao.jsp","cdsx":"1103"},// quarterly report
  		  	  {"cdid":"1104","fcdid":"11","cdname":"1.4 量化运行月报","cdurl":"/maven-guzhi/modules/xinxipilu/quantYueBao.jsp","cdsx":"1104"} 	     ,
  		  	  {"cdid":"1106","fcdid":"11","cdname":"1.6 半年报","cdurl":"/maven-guzhi/modules/xinxipilu/hsr.jsp","cdsx":"1106"} 	     ,
  		  	  {"cdid":"1107","fcdid":"11","cdname":"1.7 规模以上运行表报","cdurl":"/maven-guzhi/modules/xinxipilu/smo.jsp","cdsx":"1107"} 	     ,
  		  	  {"cdid":"1107","fcdid":"11","cdname":"1.8 季度更新（托管）","cdurl":"/maven-guzhi/modules/xinxipilu/C_jiDuGengXin.jsp","cdsx":"1107"} 	     ,
  		  	  {"cdid":"1107","fcdid":"11","cdname":"1.9 季报（托管）","cdurl":"/maven-guzhi/modules/xinxipilu/C_jiBao.jsp","cdsx":"1107"} 	     ,

			  {"cdid":"1105","fcdid":"11","cdname":"11.5管理人报告意见","cdurl":"/maven-guzhi/modules/xinxipilu/glrbg.jsp","cdsx":"1105"} ,
				//  {"cdid":"1106","fcdid":"11","cdname":"11.6邮件数据发送准备","cdurl":"/xxplpl/modules/xinxipilu/maildata.jsp","cdsx":"1106"} ,
  		  	   ]	
	
	initMenu(data);
	
	
}
//加载本地ext图片
Ext.BLANK_IMAGE_URL = "ext/resources/images/default/s.gif";
Ext.onReady(function(){
	list();

	et = $(window).height()-83;
});


function initChildTree(data,parnode) {
	 var obj = $(".x-panel-body").children(".x-panel").not($(".x-panel-collapsed")).children('.x-panel-header');
	  obj.css({'background':'#D9ECF6'});
	  obj.children('span').css({'color':'#fff'});
	var str = '';
	var ss = false;
	for (var j = 0; j <data.length ; j++) 
	{
		var json = data[j];
		if(json.fcdid==parnode){
			ss = true;
			var ob = json.cdid+"-"+json.cdname+"-"+json.fcdid+"-"+json.cdurl+"-"+json.imgpath+"-"+json.cdsx;
			var childs = 0;
			for(var k =0 ;k<data.length; k++){
				if(data[k].fcdid==json.cdid){
					childs++;
				}
			}
			if(childs>0){
				str =str+"{'text':'"+json.cdname+"','expanded':false,'children':[";
				str += initChildTree(data,json.cdid);
				str = str + "]";
			}else{
				str += "{'text':'"+json.cdname+"','leaf':true,'iconCls':'blueDot','listeners':{'click':function(){addtab1('"+json.cdurl+"','"+json.cdname+"');}}";
			
			}
			str +="},";
		}
	}
	if(ss){
		str = str.substring(0,str.length-1);
	}else{
		str =str +"{}";
	}
	
	return str;
}

function initTreeMenu(data){
	
	var str = "";
	var jsonarr = [];
	 for (var i = 0; i < data.length; i++) 
	 {
		 var json = data[i];
		if(json.fcdid=='0'){
			var str1 = "{'text':'菜单','expanded':true,'lines':false,'children':[";
			var jsondata1 = initChildTree(data,json.cdid);
			str1 = str1+ jsondata1 + "]}";
			var obj =  (new Function("return" + str1))(); 
			var tree = new Ext.tree.TreePanel({
				rootVisible: false,
		        loader: new Ext.tree.TreeLoader(),
		        root: new Ext.tree.AsyncTreeNode(
		        		obj)
		    });
			 
			str = {title:json.cdname,autoHeight:true,layout:'fit',items:[tree]};
			jsonarr.push(str);
		}
	}
	 return jsonarr;
}

function initMenu(data){
	var jsonData = initTreeMenu(data);
	new Ext.Panel({
      renderTo:"divleft", 
      title:"菜单导航",
      width:$(window).width()*0.18,
      height:$(window).height()-83,
      layout:"accordion",
      id:'tree',
      layoutConfig:{
       collapseFirst:true,
       animate:false
      },
      items:jsonData
      });
    addtab();
    allwidth=switchSysBar();
    addcls();
   var obj = $(".x-panel-body").children(".x-panel").not($(".x-panel-collapsed")).children('.x-panel-header');
   obj.css({'background':'#0E83B9'});
   obj.children('span').css({'color':'#fff'});
  var wd =  $('.divSmall').find('#tree').width();
  if(wd<214){
	  $('.divSmall').find('#tree').children('.x-panel-header').children('span').css({'margin-left':'0'});
  }else{
	  var mgl = (wd-214)/2;
	  $('.divSmall').find('#tree').children('.x-panel-header').children('span').css({'margin-left':'0px'});
  }
  
   $('.x-panel-body').css({'width':'100%'});
   $('.x-tree').css({'width':'100%'});
   /*$('.x-tree-elbow-plus').parent('.x-tree-node-el').addClass("x-tree-two-bg");*/
   $('.x-panel-body-noheader').css({'height':'100%'});
   $(".x-tree-node img").remove('.x-tree-node-icon');
   $('#divright').children('#tab_panel').css({'width':'1115px'});
   $('#divright').children('#tab_panel').children('.x-tab-panel-header').css({'width':'1115px'});
   $('#divright').children('#tab_panel').children('.x-tab-panel-header').children('.x-tab-strip-wrap').css({'width':'1115px'});
}

//伸缩菜单
var status = 0;
var Menus = new DvMenuCls;
var allwidth;
var allwidt_gd;

document.onclick=Menus.Clear;
function switchSysBar(){
	var frmTitle=document.getElementById("divleft");
	var frmTitle_=document.getElementById("divright");
	var tab_panel=Ext.getCmp("tab_panel");
	//图片切换
	var zyss=document.getElementById("zyss");
	var zyss_right=document.getElementById("zyss_right");
     if (status%2==1){
    	  status ++;
    	  
    	  zyss.style.display="none";
    	  zyss_right.style.display="";
          frmTitle.style.display="none";
          frmTitle_.style.width="99.4%";
          allwidth=$(window).width()*0.994;
          tab_panel.setWidth(allwidth);
          tab_panel.render();
     }else{
		  status ++;
		  zyss.style.display="";
    	  zyss_right.style.display="none";
		  
          frmTitle.style.display="";
      
          frmTitle_.style.width="81.4%";
          allwidth=$(window).width()*0.814;
          if(status==1){
        	  allwidt_gd = $(window).width()*0.814;
          }
          tab_panel.setWidth(allwidt_gd);
//          tab_panel.render();
     }
     return allwidth;
}

function DvMenuCls(){
	var MenuHides = new Array();
	this.Show = function(obj,depth){
		var childNode = this.GetChildNode(obj);
		if (!childNode){return ;}
		if (typeof(MenuHides[depth])=="object"){
			this.closediv(MenuHides[depth]);
			MenuHides[depth] = '';
		};
		if (depth>0){
			if (childNode.parentNode.offsetWidth>0){
				childNode.style.left= childNode.parentNode.offsetWidth+'px';
				
			}else{
				childNode.style.left='100px';
			};
			
			childNode.style.top = '-2px';
		};

		childNode.style.display ='none';
		MenuHides[depth]=childNode;
	
	};

	this.Clear = function(){
		for(var i=0;i<MenuHides.length;i++){
			if (MenuHides[i]!=null && MenuHides[i]!=''){
				MenuHides[i].style.display='none';
				MenuHides[i]='';
			}
		}
	};

}

window.onresize=resizeBannerImage;//当窗口改变宽度时执行此函数
function resizeBannerImage(){
    var winW = $(window).width();
    var winH = $(window).height();
    Ext.getCmp("tree").setWidth(winW*0.18);
    Ext.getCmp("tab_panel").setWidth(winW*0.814);
    Ext.getCmp("tree").setHeight(winH-83);
    Ext.getCmp("tab_panel").setHeight(winH-83);
 }


//设置菜单大项颜色变化
function addcls(){
	var color = $(".x-panel-body").children(".x-panel .x-panel-collapsed").children('.x-panel-header').children('span').css("color");
	//获得所有大项菜单所对应的对象
	var obj = $(".x-panel-body").children(".x-panel");
	var objspan = $(".x-panel-body").children(".x-panel").find('.x-tool-toggle');
	objspan.on('click',function(){
		//获得对应菜单大项的对象
		var obj = $(".x-panel-body").children(".x-panel").not($(".x-panel-collapsed")).children('.x-panel-header');
		//点击设置背景色和颜色
		obj.css({'background':'#0E83B9'});
	    obj.children('span').css({'color':'#fff'});
	    //获得其他菜单大项的对象
		var obj2 = $(".x-panel-body").children(".x-panel .x-panel-collapsed").children('.x-panel-header');
		//恢复到之前默认背景色和颜色
		obj2.css({'background':'#D9ECF6'});
	    obj2.children('span').css({'color':color});
	});
	$('.x-tree-node').on('click',function(){
		 $('#divright').children('#tab_panel').css({'width':'2115px'});
		 $('#divright').children('#tab_panel').children('.x-tab-panel-header').css({'width':'2115px'});
		 $('#divright').children('#tab_panel').children('.x-tab-panel-header').children('.x-tab-strip-wrap').css({'width':'2115px'});
	})
	
	obj.on('click',function(){
		//获得对应菜单大项的对象
		var obj = $(".x-panel-body").children(".x-panel").not($(".x-panel-collapsed")).children('.x-panel-header');
		//点击设置背景色和颜色
		obj.css({'background':'#0E83B9'});
	    obj.children('span').css({'color':'#fff'});
	    //获得其他菜单大项的对象
		var obj2 = $(".x-panel-body").children(".x-panel .x-panel-collapsed").children('.x-panel-header');
		//恢复到之前默认背景色和颜色
		obj2.css({'background':'#D9ECF6'});
	    obj2.children('span').css({'color':color});
	   /* $('#tree').children('.x-panel-bwrap').children('.x-panel-body').css({"overflow":"hidden"});*/
	});
}