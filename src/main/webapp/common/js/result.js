
var tips_wkf = '<font color="red">(未启用)</font>';
var defaultFieldSetWidth = 673;
var defaultPageSize = 30;
var totalPages = 0;
var totalResults=0;
var khkztj_html="";
var khkztj_val=[];
var cxtj_inner="";
var bjlx_inner="";
var cxnr_inner="";
Ext.override(Ext.menu.Menu, {
	autoWidth : function() {
		var el = this.el, ul = this.ul;
		if (!el) {
			return;
		}
		var w = this.width;
		if (w) {
			el.setWidth(w);
		} else if (Ext.isIE && !Ext.isIE8) {
			el.setWidth(this.minWidth);
			el.setWidth(ul.getWidth() + el.getFrameWidth("lr"));
		}
	}
});

var canExport = false;
/*导出*/
function export_() {
	if(canExport){
	   var url = 'DownloadServlet.action';
	   window.location.href = url;
	}else{
		Ext.Msg.alert("请先查询");
	}
}

function pageSet_() {
	var eee=document.getElementById("pagesize_set_sinosoft");
	chg_pagesize_style(eee);
}

function setpageSize(ele){
	var t=$("#page_si").val();
	var p=defaultPageSize;
	if("on"==$(ele).val()&&(""==t||null==t)){
		$(ele).attr("checked",false);
		Ext.Msg.alert('提示信息',"请先输入条数");
	}else{
		 if("on"==$(ele).val()){
				defaultPageSize=t;
		}else{
			defaultPageSize=$(ele).val();
		}
		totalPages=getPagecount(totalResults,defaultPageSize);
		document.getElementById("pagesize_set_sinosoft").style.display="none";
			$("#pager").pager({ 
			pagenumber: 1,//当前页数
			pagecount: totalPages, //页面显示的页数
			buttonClickCallback: PageClick
		});
		pageClick(1);
	}
	
}
function chg_pagesize_style(ele){
	ele.style.display="block";
	ele.style.position="absolute";
	ele.style.left="93px";
	ele.style.top="6px";
	ele.style.width="140px";
	ele.style.height="160px";
	ele.style.background="#97CBFF";
	ele.style.border="1px";
	ele.innerHTML="<input type='radio' onclick='setpageSize(this)' name='page'>每页显示<input type='text' style='width:25px' id='page_si'>条 </br><input type='radio' onclick='setpageSize(this)' name='page' value='20'>每页显示20条</br><input onclick='setpageSize(this)' type='radio' name='page' value='50'>每页显示50条</br><input onclick='setpageSize(this)' type='radio' name='page' value='100'>每页显示100条</br>"+
	"<input onclick='setpageSize(this)' type='radio' name='page' value='250'>每页显示250条</br><input onclick='setpageSize(this)' type='radio' name='page' value='500'>每页显示500条</br><input onclick='setpageSize(this)' type='radio' name='page' value='1'>每页显示1条</br>";
}
var base_query_win_js; //主查询窗口
$(function(){

	/*添加分页组件*/
	$("#pager").pager({ 
		pagenumber: 0, 
		pagecount: 0, 
		buttonClickCallback: PageClick 
	}); 
	
	
	//变相实现表头固定。
	var scrollLeft = 0;
	window.onscroll = function(){
		 var scrollLeftCurr = document.documentElement.scrollLeft||document.body.scrollLeft;
		if(scrollLeftCurr != scrollLeft){
			$("#data_table_content1").css('left',-scrollLeftCurr);
			scrollLeft = scrollLeftCurr;
		}
	};
	//第一个表单组,客户基本条件。
	var khjbtj = new Ext.form.FieldSet(
			{
				xtype:'fieldset',
	            title: '客户基本条件',
	            collapsible: true,
	            autoHeight:true,
	            width:defaultFieldSetWidth,
	            layout : "form",
				items : [{ // 行1
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.45, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						items : [{
							xtype : "textfield",
							fieldLabel : "客户编号",
							name :"khbh",
							id:"khbh",
							width : 100
						}]
					}, {
						columnWidth : 0.5,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "分支机构",
							name:"fzjg",
							id:"fzjg",
							width : 180
							//value : '8019'
						}]
					}]
				},{	// 行2
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "资金账号",
							name :"zjzh",
							id :"zjzh",
							width : 150
						}]
					}, {
						columnWidth : .5,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "客户组",
							name : "khz",
							id: "khz",
							width : 150
						}]
					}]
				}, {// 行3
					layout : "form",
					bodyStyle:'margin-top:5px;',
					items : [{
						xtype : 'lovcombo',      
						name : 'khlx',   
						id : 'khlx',  
						fieldLabel : '客户类型',      
						store : store_khlx,      
						valueField : 'value',      
						displayField : 'name',      
						mode : 'local',      
						editable : true,      
						triggerAction : 'all',
						width : 300
					}]
				}, {// 行4
					layout : "form",
					bodyStyle:'margin-top:5px;',
					items : [{      
							xtype : 'lovcombo',      
							name : 'khjb',   
							id : 'khjb',  
							fieldLabel : '客户级别',      
							store : store_khjb,      
							valueField : 'value',      
							displayField : 'name',      
							mode : 'local',      
							editable : true,      
							triggerAction : 'all',
							width : 300
							}
					]
				}, {// 行5
					layout : "form",
					bodyStyle:'margin-top:5px;',
					items : [{
						xtype : 'lovcombo',      
						name : 'khzt',   
						id : 'khzt',  
						fieldLabel : '客户状态',      
						store : store_khzt,      
						valueField : 'value',      
						displayField : 'name',      
						mode : 'local',      
						editable : true,      
						triggerAction : 'all',
						width : 300
					}]
				}, 
				 {// 行5
					layout : "form",
					bodyStyle:'margin-top:5px;',
					items : [{
						xtype : 'lovcombo',      
						name : 'qycp',   
						id : 'qycp',  
						fieldLabel : '签约产品',      
						store : store_qycp,      
						valueField : 'value',      
						displayField : 'name',      
						mode : 'local',      
						editable : true,      
						triggerAction : 'all',
						width : 300
					}]
				}, {// 行6
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
							layout : "form",
							columnWidth : 0.35,
							items : [{
								xtype : "datefield",
								id:'khrq_ksrq',
								name:'khrq_ksrq',
								fieldLabel : "开户日期",
								width : 80,
								format: 'Ymd'
								}]
						},{
							layout : "form",
							columnWidth : 0.35,
							items : [{
								xtype : "datefield",
								id:'khrq_jzrq',
								name:'khrq_jzrq',
								hideLabel :true,
								width : 80,
								format: 'Ymd'
								}]
						}]
				}, {// 行7
					layout : "form",
					bodyStyle:'margin-top:5px;',
					items : [{
						xtype : "combo",
						fieldLabel : "客户规范",
						name:'khgf',
						id:'khgf',
						store: store_khgf,
						valueField:"value",  
				        displayField:'name',
				        typeAhead: true,
				        mode: 'local',
				        triggerAction: 'all',
				        emptyText:'————请选择————',
				        selectOnFocus:true,
				        width:160
					}]
				}]
			}
	);

	//第二个表单组  -- 客户扩展条件.
	var khkztj = new Ext.form.FieldSet({
			xtype:'fieldset',
            title: '客户扩展条件'+tips_wkf,
            collapsible: true,
            collapsed:true,
            autoHeight:true,
            width:defaultFieldSetWidth,
            layout : "form",
            items:[{
            	layout:"column",
            	items:[
            		{
            			columnWidth:0.5,
            			layout:"form",
            			items:[
            				{
            					xtype : "combo",
								fieldLabel : "资料分类",
								name:'zlfl',
								id:'zlfl',
								store: store_zlfl,
								valueField:"value",  
						        displayField:'name',
						        typeAhead: true,
						        mode: 'local',
						        triggerAction: 'all',
						        selectOnFocus:true,
						        width:140,
						       	listeners:{
						       		select:function(combo,record,index){
						       			//alert(record.data.value);
						       			getCxtj(record.data.value,record.data.name,'zlfl_cxtj');
						       		}
						       	}
            				},
            				{
            					xtype : "combo",
								fieldLabel : "查询条件",
								name:'cxtj',
								id:'cxtj',
								store: store_cxtj,
								valueField:"value",  
						        displayField:'name',
						        autoScroll:true,
						        autoSelect:true,
						        typeAhead: true,
						        mode: 'local',
						        triggerAction: 'all',
						        selectOnFocus:true,
						        width:140,
						        listeners:{
						       	    select:function(combo,record,index){
						       	    cxtj_inner=record.data.name;
						       			getCxtj(record.data.value,record.data.name,'cxtj_cxnr');
						       		}
						        }
            				},
            				{
            					xtype : "combo",
								fieldLabel : "比较类型",
								name:'bjlx',
								id:'bjlx',
								store: store_bjlx,
								valueField:"value",  
						        displayField:'name',
						        typeAhead: true,
						        mode: 'local',
						        triggerAction: 'all',
						        selectOnFocus:true,
						        width:140,
						        listeners:{
						       	    select:function(combo,record,index){
						       	 		   bjlx_inner=record.data.name;
						       	 		   console.log(bjlx_inner);
						       	 		   if("是"==record.data.name){
						       	 		   	  var t=[['null','空'],[' not null','非空']];
						       	 		   	  Ext.getCmp('cxnr').store.loadData(t);
						       	 		   }else if("包含"==record.data.name){
						       	 		   }
						       		}
						        }
            				},
            				{
            					xtype : "combo",
								fieldLabel : "查询内容",
								name:'cxnr',
								id:'cxnr',
								store: store_cxnr,
								valueField:"value",  
						        displayField:'name',
						        typeAhead: true,
						        mode: 'local',
						        triggerAction: 'all',
						        selectOnFocus:true,
						        width:120,
						        listeners:{
						       	    select:function(combo,record,index){
						       	    cxnr_inner=record.data.name;
						       		}
						        }
            				},{
            					xtype:"button",
            					text:'增加',
            					handler:function(){
            					    var r=Math.random(); 
            					    var tmp="";
            						tmp='<tr><td width="50px">'+cxtj_inner+'</td><td width="50px">'+bjlx_inner+'</td><td width="50px">'+cxnr_inner+'</td><td><span id='+r+' onclick="changeHtml(this)">并且</span></td><td><input  onclick="delPar(this)" type="button" value="删除"  ></td></tr>';
            							var t=document.getElementById("khkztj_table");
            							var newNode = document.createElement("tr");
										newNode.innerHTML = tmp;
										 t.appendChild(newNode);	
										 
            							khkztj_val.push("m."+Ext.getCmp('cxtj').getValue()+" "+Ext.getCmp('bjlx').getValue()+" "+Ext.getCmp('cxnr').getValue()+" "+getchangeHtmlVal($(document.getElementById(r)).html())+","+r);
            					}
            					
            				}
            			]
            		},
            		{
            			columnWidth : 0.5,
            			layout:"form",
            			items:[
								//{
								//id:'khkztjcx',
								//name:'khkztjcx',
								//xtype:"textarea",
								//enterIsSpecial:false,
								//// autoWidth:true,
								//width:200,
								//height:100,
								//readOnly:true
								//}
		                        	new Ext.Panel({
		                        	id:"khkztjcx",
		                        		width:200,
		                        		height:100,
		                        		border:true,
		                        		html:'<table id="khkztj_table"></table>'
		                        	})
		                        
            			       ]
            		}	
            	]
            	
            }]
	});
	//第三个表单组 -- 员工关系条件
	var yggxtj = new Ext.form.FieldSet(
			{
				xtype:'fieldset',
	            title: '员工关系条件',
	            collapsible: true,
	            autoHeight:true,
	            width:defaultFieldSetWidth,
	            layout : "form",
				items : [{ // 行1
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.6, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						items : [{
							xtype : "combo",
							fieldLabel : "关系类型",
							name:'gxlx',
							id:'gxlx',
							store: store_gxlx,
							valueField:"value",  
					        displayField:'name',
					        typeAhead: true,
					        mode: 'local',
					        triggerAction: 'all',
					        value:'',
					        selectOnFocus:true
						}]
					}]
				}, {	// 行2
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .4,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "员工编号",
							name :"ygbh",
							id :"ygbh",
							width : 130
						}]
					}, {
						columnWidth : .4,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "团队编号",
							name : "tdbh",
							id : "tdbh",
							width : 130
						}]
					}]
				}, {	// 行3
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .4,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "员工角色",
							name :"ygjs",
							id :"ygjs",
							width : 130
						}]
					}, {
						columnWidth : .4,
						layout : "form",
						items : [{
							xtype : 'lovcombo',      
							name : 'ygzt',   
							id : 'ygzt',  
							fieldLabel : '员工状态',      
							store : store_ygzt,      
							valueField : 'value',      
							displayField : 'name',      
							mode : 'local',      
							editable : true,      
							triggerAction : 'all',
							width : 130
						}]
					}]
				}, {	// 行4
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .4,
						layout : "form",
						items : [{							
							xtype : 'lovcombo',      
							name : 'jljb',   
							id : 'jljb',  
							fieldLabel : '经理级别',      
							store : store_jljb,      
							valueField : 'value',      
							displayField : 'name',      
							mode : 'local',      
							editable : true,      
							triggerAction : 'all',
							width : 130
							
						}]
					}, {
						columnWidth : .4,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "员工单位",
							name : "ygdw",
							id : "ygdw",
							width : 130
						}]
					}]
				}, {// 行6
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
							layout : "form",
							columnWidth : 0.35,
							items : [{
								xtype : "datefield",
								id:'rzrq_ksrq',
								name:'rzrq_ksrq',
								fieldLabel : "入职日期",
								width : 80,
								format: 'Ymd'
								}]
						},{
							layout : "form",
							columnWidth : 0.35,
							items : [{
								xtype : "datefield",
								id:'rzrq_jzrq',
								name:'rzrq_jzrq',
								hideLabel :true,
								width : 80,
								format: 'Ymd'
								}]
						}]
				}]
			}
	);
	
	//第四个表单  客户交易条件表单
	var khjytj_js = new Ext.form.FieldSet(
			{
				xtype:'fieldset',
	            title: '客户交易条件',
	            collapsible: true,
	            autoHeight:true,
	            width:defaultFieldSetWidth,
	            layout : "form",
				items : [{ // 行1
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.45, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						items : [{
							xtype : "textfield",
							fieldLabel : "证券代码",
							name:'zqdm',
							id:'zqdm',
							width : 150
						}]
					}, {
						columnWidth : .45,
						layout : "form",
						items : [{
//							xtype : "textfield",
//							fieldLabel : "证券市场",
//							name : "zqsc",
//							id : "zqsc",
//							value:"'1','2','9'",
//							width : 150
							xtype : 'lovcombo',      
							name : 'zqsc',   
							id : 'zqsc',  
							fieldLabel : '证券市场',      
							store : store_zqsc,      
							valueField : 'value',      
							displayField : 'name',      
							mode : 'local',      
							editable : true,      
							triggerAction : 'all',
							width : 150
						}]
					}
					]
				}, {	// 行2
					layout : "column",
					bodyStyle:'margin-top:5px;',
					items : [{
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "证券类别",
							store:store_zqlb,
							name :"zqlb",
							id :"zqlb",
							width : 150
						}]
					}, {
						columnWidth : .45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "委托方式",
							name : "wtfs",
							id : "wtfs",
							width : 150
						}]
					}]
				}, {	// 行3
					layout : "column",
					bodyStyle:'margin-top:3px;',
					items : [{
						columnWidth : 0.45,
						layout : "form",
						items : [{
							xtype : "textfield",
							fieldLabel : "交易类别",
							name :"jylb",
							id :"jylb",
							width : 150
						}]
					}]
				}, { // 行4
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							fieldLabel : "单笔成交金额",
							name :"dbcjje_min",
							id :"dbcjje_min",
							width : 100
						}]
					},{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							name :"dbcjje_max",
							id :"dbcjje_max",
							hideLabel:true,
							width : 100
						}]
					}]
				}, { // 行5
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							fieldLabel : "单笔佣金",
							name :"dbyj_min",
							id :"dbyj_min",
							width : 100
						}]
					},{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							name :"dbyj_max",
							id :"dbyj_max",
							hideLabel:true,
							width : 100
						}]
					}]
				}, { // 行6
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							fieldLabel : "单笔净佣金",
							name :"dbjyj_min",
							id :"dbjyj_min",
							width : 100
						}]
					},{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							name :"dbjyj_max",
							id :"dbjyj_max",
							hideLabel:true,
							width : 100
						}]
					}]
				}, { // 行7
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							fieldLabel : "累计成交金额",
							name :"ljcjje_min",
							id :"ljcjje_min",
							width : 100
						}]
					},{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							name :"ljcjje_max",
							id :"ljcjje_max",
							hideLabel:true,
							width : 100
						}]
					}]
				}, { // 行8
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							fieldLabel : "累计佣金",
							name :"ljyj_min",
							id :"ljyj_min",
							width : 100
						}]
					},{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							name :"ljyj_max",
							id :"ljyj_max",
							hideLabel:true,
							width : 100
						}]
					}]
				}, { // 行9
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							fieldLabel : "累计净佣金",
							name :"ljjyj_min",
							id :"ljjyj_min",
							width : 100
						}]
					},{
						columnWidth : 0.35, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						bodyStyle:'margin-top:3px;',
						items : [{
							xtype : "textfield",
							name :"ljjyj_max",
							id :"ljjyj_max",
							hideLabel:true,
							width : 100
						}]
					}]
				},{// 行10
					layout : "column",
					bodyStyle:'margin-top:3px;',
					items : [{
							layout : "form",
							columnWidth : 0.35,
							items : [{
								bodyStyle:'padding-left:50px;',
								xtype : "datefield",
								id:'jyrq_ksrq',
								name:'jyrq_ksrq',
								fieldLabel : "交易日期",
								width : 80,
								format: 'Ymd',
								labelWidth:100,
								value:new Date().add(Date.DAY,-8)
								}]
						},{
							layout : "form",
							columnWidth : 0.35,
							items : [{
								xtype : "datefield",
								id:'jyrq_jzrq',
								name:'jyrq_jzrq',
								hideLabel :true,
								width : 80,
								format: 'Ymd',
								//value : '20130131',
								labelWidth:100,
								value:new Date().add(Date.DAY,-1)
								}]
						}]
				}]
			}
	);
	
	
	
	//第五个表单 统计方式
	var jytjfs = new Ext.form.FieldSet(
			{
				xtype:'fieldset',
	            title: '交易统计方式',
	            collapsible: true,
	            autoHeight:true,
	            width:defaultFieldSetWidth,
	            layout : "form",
				items : [{ // 行1
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.7, // 该列有整行中所占百分比
						layout : "form", // 从上往下的布局
						items : [{
						//	xtype : 'lovcombo',      
						//	name : 'tjfs',   
						//	id : 'tjfs',  
						//	fieldLabel : '统计方式',      
						//	store : store_tjfs,      
						//	valueField : 'value',      
						//	displayField : 'name',      
						//	mode : 'local',      
						//	editable : true,      
						//	triggerAction : 'all',
						//	width : 350
							xtype : "textfield",
							fieldLabel : "统计方式",
							name : "tjfs",
							id : "tjfs",
							width : 150
						}]
					}, {
						columnWidth : .25,
						layout : "form",
						items : [{
							xtype : "checkbox",
							fieldLabel : "统计占比",
							name : "tjzb",
							id : "tjzb"
						}]
					}]
				},{ // 行2
					layout : "column", // 从左往右的布局
					items : [{
						columnWidth : 0.16, // 该列有整行中所占百分比
						bodyStyle:'margin-top:5px;',
						layout : "form", // 从上往下的布局
						items : [{
							xtype : "panel",
							fieldLabel : "统计目标",
							name:'tjmb',
							id:'tjmb',
							isFormField: true,
							labelWidth:0,
							width : 0
						}]
					}, {
						columnWidth : .2,
						layout : "form",
						bodyStyle:'margin-top:5px;',
						items : [{
							xtype : "checkbox",
							fieldLabel : "平均佣金率‰",
							labelWidth : 60,
							name : "pjyjl",
							id : "pjyjl",
							labelAlign : "right",
							width : 20
						}]
					}, {
						columnWidth : .2,
						layout : "form",
						bodyStyle:'margin-top:5px;',
						items : [{
							xtype : "checkbox",
							fieldLabel : "平均净佣金率‰",
							labelWidth : 60,
							name : "pjjyjl",
							id : "pjjyjl",
							width : 20
						}]
					}, {
						columnWidth : .2,
						layout : "form",
						bodyStyle:'margin-top:5px;',
						items : [{
							xtype : "checkbox",
							fieldLabel : "客户数",
							labelWidth : 60,
							name : "khs",
							id : "khs",
							width : 20
						}]
					}, {
						columnWidth : .2,
						layout : "form",
						bodyStyle:'margin-top:5px;',
						items : [{
							xtype : "checkbox",
							fieldLabel : "成交金额",
							labelWidth : 60,
							name : "cjje",
							id : "cjje",
							checked : true,
							width : 20
						}]
					}]
				}, {// 行3
				layout : "column", // 从左往右的布局
				labelAlign : "right",
				items : [{
					columnWidth : 0.16, // 该列有整行中所占百分比
					layout : "form", // 从上往下的布局
					bodyStyle:'margin-top:0px;',
					items : [{
						xtype : "panel",
						isFormField: true,
						hideLabel:true,
						value:1,
						width : 100
					}]
				}, {
					columnWidth : .2,
					layout : "form",
					bodyStyle:'margin-top:0px;',
					items : [{
						xtype : "checkbox",
						fieldLabel : "成交数量",
						labelWidth : 60,
						name : "cjsl",
						id : "cjsl",
						width : 20
					}]
				}, {
					columnWidth : .2,
					layout : "form",
					bodyStyle:'margin-top:0px;',
					items : [{
						xtype : "checkbox",
						fieldLabel : "佣金",
						labelWidth : 60,
						name : "yj",
						id : "yj",
						checked : true,
						width : 20
					}]
				}, {
					columnWidth : .2,
					layout : "form",
					bodyStyle:'margin-top:0px;',
					items : [{
						xtype : "checkbox",
						fieldLabel : "资金发生数",
						labelWidth : 60,
						name : "zjfss",
						id : "zjfss",
						width : 20
					}]
				}, {
					columnWidth : .2,
					layout : "form",
					bodyStyle:'margin-top:0px;',
					items : [{
						xtype : "checkbox",
						fieldLabel : "净佣金",
						labelWidth : 60,
						name : "zyj",
						id : "zyj",
						checked : true,
						width : 20
					}]
				}]
			}]
			}
	);
	
	//khjytj.collapse(true);
	var queryForm =  new Ext.FormPanel(
			{
				width : defaultFieldSetWidth,
				autoHeight : true,
				frame : true,
				renderTo : Ext.getBody(),
				layout : "form", // 整个大的表单是form布局
				id:'base_query_form',
				labelWidth : 100,
				standardSubmit:true,
				labelAlign : "right",
				onSubmit: Ext.emptyFn,
				submit: function() {
				   this.getEl().dom.action='http://localhost:8080/marketing_statistics/handelParameter.action'; //连接到服务器的url地址
				   this.getEl().dom.submit();
				   },
				items : [khjbtj,khkztj,yggxtj,khjytj_js,jytjfs]
			}
	);
	
	base_query_win_js = new Ext.Window({
		id:'base_query_win_js',
		title:'查询条件',
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
		items:[queryForm,{
			buttonAlign : "center",
			buttons : [{
				text : "查询",
				type : 'button',
				handler: function(){
					saveUser_ajaxSubmit1();
				}
			}, {
				text : "显示结果",
				type : 'button',
				handler : function(){
					base_query_win_js.hide();
				}
			}]
		}]
	});
	/*日期处理*/
	$("#khrq_ksrq").before('从');
	$("#khrq_jzrq").before('到');
	$("#rzrq_ksrq").before('从');
	$("#rzrq_jzrq").before('到');
	$("#jyrq_ksrq").before('从');
	$("#jyrq_jzrq").before('到');
	/*交易流水条件显示*/
	$("#dbcjje_min").before('从');
	$("#dbcjje_max").before('至');
	$("#dbyj_min").before('从');
	$("#dbyj_max").before('至');
	$("#dbjyj_min").before('从');
	$("#dbjyj_max").before('至');
	$("#ljcjje_min").before('从');
	$("#ljcjje_max").before('至');
	$("#ljyj_min").before('从');
	$("#ljyj_max").before('至');
	$("#ljjyj_min").before('从');
	$("#ljjyj_max").before('至');
	//$("#khbh").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'khbh\',1)" src="images/s.gif"/>');
	$("#zqlb").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'zqlb\',0)" src="images/s.gif"/>');
	$("#fzjg").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'fzjg\',1)" src="images/s.gif"/>');
	//$("#ygdw").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'ygdw\',1)" src="images/s.gif"/>');
	$("#tdbh").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'tdbh\',1)" src="images/s.gif"/>');
	$("#ygbh").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'ygbh\',1)" src="images/s.gif"/>');
	$("#khz").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'khz\',1)" src="images/s.gif"/>');
	$("#tjfs").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'tjfs\',0)" src="images/s.gif"/>');
	$("#ygjs").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'ygjs\',0)" src="images/s.gif"/>');
	$("#wtfs").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'wtfs\',0)" src="images/s.gif"/>');
	$("#jylb").after('<img class="x-form-trigger" onclick="queryFormItems(this,\'jylb\',0)" src="images/s.gif"/>');
	base_query_win_js.show();
});
function login(){
	   Ext.get.form.submit();
}

function requery_(){
	base_query_win_js.show();
}

function writeAfterField(obj,tips){
	var font=document.createElement("font"); 
	font.setAttribute("color","red"); 
	var redStar=document.createTextNode(tips); 
	font.appendChild(redStar);     
	obj.el.dom.parentNode.appendChild(font);  
} 

var print;
var header_zh_js = '';

PageClick = function(pageclickednumber) { 
	$("#pager").pager({ 
		pagenumber: pageclickednumber,//当前页数
		pagecount: totalPages, //页面显示的页数
		buttonClickCallback: PageClick
	});
	pageClick(pageclickednumber);
};

function pageClick(pageclickednumber) {
	var dataPara = {
		   v_page_size:defaultPageSize,
		   v_page:pageclickednumber
	  };
	$.ajax({
			url : 'PagerServlet.action?mathid='+Math.random(),
			type : 'post',
			data : dataPara,
			dataType:'json',//接受数据格式 
			success : function(data) {
					var headers_zh = header_zh_js.split(",");
					var th_str = '';
					for (var k = 0 ; k< headers_zh.length; k++){
						th_str += '<th><div style="max-width:200px;max-height:40px;">'+headers_zh[k]+'</div></th>';
					}
					var trs ='<tr>' + th_str + '</tr>';
					for(var j=1;j<data.length;j++){
						trs += '<tr>';
						var oneCol = data[j];
						for(var key in oneCol){
							trs +='<td>'+oneCol[key]+'</td>';
						}
						trs += '</tr>';
					}
					$("#data_table_content").html(trs);
			},
			failure : function(data) {
				alert('gaga');
				window.clearInterval(print);
			}
		});
}

function saveUser_ajaxSubmit1() {
	
	header_zh_js = '';
	
	canExport = false;
	if(print!=null){
		window.clearInterval(print);
	}
	var beginTime = 0;
	print = setInterval(function(){
		beginTime++;
		$("#timeCost").html("已用时"+beginTime+"秒");
	},1000);
	var headerNames_tjfs = getHeaderNames_tjfs();
	var headerNames_tjmb = getHeaderNames_tjmb();
	var tjnm_value=getSelectedValue_tjmb();
	
	header_zh_js = headerNames_tjfs + headerNames_tjmb;
	header_zh_js = header_zh_js.substring(0,header_zh_js.length-1);
	
	var khkztj_val_r=" ";
	for(var i=0;i<khkztj_val.length;i++){
	     var t=khkztj_val[i]; 
		if(i==khkztj_val.length-1){
			if(t.indexOf("or")>0){
				t=t.substring(0,t.indexOf("or"));
			}else if(t.indexOf("and")>0){
				t=t.substring(0,t.indexOf("and"));
			}
			khkztj_val_r+=t+" ";
		}else{
			t=t.substring(0,t.indexOf(","));
			khkztj_val_r=t+" ";
		}
	}
	//console.log("header_zh_js:"+header_zh_js);
	//alert("v_login_user:"+login_user);
	
	var dataPara = {
		  v_khbh:Ext.getCmp('khbh').getValue(),
		  fzjg:Ext.getCmp('fzjg').getValue(),
		  v_zjzh:Ext.getCmp('zjzh').getValue(),
		   khz:Ext.getCmp('khz').getValue(),
		   v_khlx:Ext.getCmp('khlx').getValue(),
		   v_khjb:Ext.getCmp('khjb').getValue(),
		   v_khzt:Ext.getCmp('khzt').getValue(),
		   khjbtj_khrq_qsrq:Ext.getCmp('khrq_ksrq').getRawValue(),
		   khjbtj_khrq_jsrq:Ext.getCmp('khrq_jzrq').getRawValue(),
		   v_khgf:Ext.getCmp('khgf').getValue(),
		   gxlx:Ext.getCmp('gxlx').getValue(),
		   v_khjl:Ext.getCmp('ygbh').getValue(),
		   tdbh:Ext.getCmp('tdbh').getValue(),
		   ygjs:Ext.getCmp('ygjs').getValue(),
		   ygzt:Ext.getCmp('ygzt').getValue(),
		   jljb:Ext.getCmp('jljb').getValue(),
		   ygdw:Ext.getCmp('ygdw').getValue(),
		   rzrq_ksrq:Ext.getCmp('rzrq_ksrq').getRawValue(),
		   rzrq_jzrq:Ext.getCmp('rzrq_jzrq').getRawValue(),
		   v_zqdm:Ext.getCmp('zqdm').getValue(),
		   v_zqsc:Ext.getCmp('zqsc').getValue(),
		   v_zqlb:Ext.getCmp('zqlb').getValue(),
		   v_wtfs:Ext.getCmp('wtfs').getValue(),
		   v_jylb:Ext.getCmp('jylb').getValue(), 
		   v_qscjje :Ext.getCmp('dbcjje_min').getValue(),      //起始成交金额
		   v_zzcjje :Ext.getCmp('dbcjje_max').getValue(),       // 终止成交金额
		   v_qsyj :Ext.getCmp('dbyj_min').getValue(),      //起始佣金
		   v_zzyj :Ext.getCmp('dbyj_max').getValue(),       // 终止佣金
		   v_qszyj :Ext.getCmp('dbjyj_min').getValue(),// 起始净佣金
		   v_zzzyj :Ext.getCmp('dbjyj_max').getValue(),//终止净佣金

		   v_qsyj_lj : Ext.getCmp('ljyj_min').getValue(),//起始佣金
		   v_zzyj_lj :Ext.getCmp('ljyj_max').getValue(),//终止佣金
		   v_qszyj_lj :Ext.getCmp('ljjyj_min').getValue(),// 起始净佣金
		   v_zzzyj_lj :Ext.getCmp('ljjyj_max').getValue(),//终止净佣金
		   v_qscjje_lj :Ext.getCmp('ljcjje_min').getValue(),//起始成交金额  空查全部
		   v_zzcjje_lj  :Ext.getCmp('ljcjje_max').getValue(),//终止成交金额  空查全部
		   khjytj_jyrq_qsrq:Ext.getCmp('jyrq_ksrq').getRawValue(),
		   test_g:Ext.getCmp('jyrq_jzrq').getRawValue(),
		   v_tjzds:Ext.getCmp('tjfs').getValue(),
		   tjfs:Ext.getCmp('tjfs').getValue(),
		   v_qycp:Ext.getCmp('qycp').getValue(),
		  // v_tjmb:Ext.getCmp('pjyjl').getValue()
		   v_tjmb:tjnm_value,
		   v_dwbh_dl: dept_id,
		   v_login_user:login_user,
		   v_header_zh:header_zh_js, //表头
		   v_page_size:defaultPageSize,
		   v_kzcx_sql:khkztj_val_r
	  };
	
	base_query_win_js.hide();
	$("#timeCost").html("");
	$("#data_table_content").html("");
	$("#data_table_content1").html("");
	var flag=chechForm();
	if(flag){
		$.ajax({
			url : 'handelParameter.action?mathid='+Math.random(),
			type : 'post',
			data : dataPara,
			dataType:'json',//接受数据格式 
			success : function(data) {
				var DataInfo = data[0];
				var pro_Info = DataInfo.pro_Info;
				var resultFlag=DataInfo.resultFlag;
				var recordsCount = DataInfo.recordsCount;
				totalPages = getPagecount(recordsCount,defaultPageSize);
				var timeCost = DataInfo.timeCost;
				if("false"==resultFlag){
					if(undefined==pro_Info){						
						Ext.Msg.alert('查询失败',"系统正在维护请联系管理员");
					}else{
						Ext.Msg.alert('查询失败',pro_Info);
					}
					window.clearInterval(print);
				}else{
					window.clearInterval(print);
					
					if(recordsCount > 0){
						canExport = true;
					}
					
					$("#pager").pager({ 
						pagenumber: 1, 
						pagecount: totalPages, // 页面显示的页数
						buttonClickCallback: PageClick 
					}); 
					totalResults=recordsCount;
					$("#timeCost").html("共计&nbsp;:"+recordsCount+"&nbsp;条数据&nbsp;&nbsp;耗时:&nbsp;"+timeCost+"&nbsp;秒");
					var trs_head = '';
					var headers_zh = header_zh_js.split(",");
					var th_str = '';
					for (var k = 0 ; k< headers_zh.length; k++){
						th_str += '<th><div style="max-width:200px;">'+headers_zh[k]+'</div></th>';
					}
					var trs ='<tr>' + th_str + '</tr>';
					trs_head = trs;
					for(var j=1;j<data.length;j++){
						trs += '<tr>';
						var oneCol = data[j];
						for(var key in oneCol){
							trs +='<td>'+oneCol[key]+'</td>';
						}
						trs += '</tr>';
					}
					$("#data_table_content1").html(trs_head);
					$("#data_table_content").html(trs);
				}
				
			},
			failure : function(data) {
				alert('gaga');
				window.clearInterval(print);
			}
		});
	}else{
		window.clearInterval(print);
	};
}
var itemsInfoWin ;
function queryFormItems(btn,info,queryFlag){
	//查询窗口公共定义
	itemsInfoWin = new Ext.Window({ 
		id:'itemsInfoWin',
		title:info,
		closeable:true,
		draggable:true,
		shadow:false,
		width:634,
		height:381,
		modal:true,     
        items: [{  title: '弹出的窗口', 
                            header:false, 
                            html : '<iframe style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; width: 620px; height: 350px; border-right-width: 0px" src=ssstj_queryGrid.jsp?t='+info+'&q='+queryFlag+' frameborder="0" width="100%" scrolling="no" height="100%"></iframe>', 
                            border:false 
                        }] 
    }); 
	itemsInfoWin.show();
}

var tjnames;
function getHeaderNames_tjfs(){
	var tjfs = Ext.getCmp('tjfs').getValue();
	var tjzds = tjfs.split(',');
	tjnames = '';
	for(var i=0;i<tjzds.length;i++){
		tjnames += '按'+ tjzdname_map[tjzds[i]]+',';
	}
	return tjnames;
}
function getHeaderNames_tjmb(){
	tjmbnames = '';
	for(var key in tjmb_name_map){
		if(Ext.getCmp(key).getValue()==true){
			tjmbnames += tjmb_name_map[key]+",";
		}
	}
	return tjmbnames;
}


function getSelectedValue_tjmb(){
	tjmbnames = '';
	for(var key in tjmb_name_map){
		if(Ext.getCmp(key).getValue()==true){
			tjmbnames += key+",";
		}
	}
	return tjmbnames;
}
function errorResult(btn,info){
	Ext.Msg.alert('查询结果信息',info);
}
function chechForm(){
	var jy_tjzd=Ext.getCmp('tjfs').getValue();
	var jy_tjmb=getSelectedValue_tjmb();
	var jy_jyrq_ksrq=Ext.getCmp('jyrq_ksrq').getRawValue();
	var jy_jyrq_jzrq=Ext.getCmp('jyrq_jzrq').getRawValue();

	if(""==jy_tjzd){
		Ext.Msg.alert('查询失败','统计字段不能为空!');
		return false;
	}
	if(""==jy_tjmb){
		Ext.Msg.alert('查询失败','统计目标不能为空!');
		return false;
	}
	if(jy_jyrq_ksrq<19000000||jy_jyrq_jzrq<19000000){
		Ext.Msg.alert('查询失败','起始日期，终止日期参数不合法或者超过范围！');
		return false;
	}
	if(jy_jyrq_ksrq>jy_jyrq_jzrq){
		Ext.Msg.alert('查询失败','起始日期不能大于终止日期！');
		return false;
	}
	if((jy_jyrq_jzrq/10000-jy_jyrq_jzrq/10000)>3){
		Ext.Msg.alert('查询失败','查询日期范围不能超过三年！');
		return false;
	}
	return true;
}

function getPagecount(recordsCount,defaultPageSize){
	var records = parseInt(recordsCount+'');
	var pageSize = parseInt(defaultPageSize+'');
	return Math.ceil(records/pageSize);
}

function setData(eleid,valid){
	itemsInfoWin.destroy();
	document.getElementById(eleid).value=valid;
}
function cloWin(){
	itemsInfoWin.destroy();
}
function changeHtml(ele){
	var eleHTML=$(ele).html();
	var eid=ele.id;
	if("并且"==eleHTML){
		$(ele).html('或者');
		for(var i=0;i<khkztj_val.length;i++){
			var tm=khkztj_val[i];
			if(tm.indexOf(eid)>0){
				tm=tm.replace("and","or");
				khkztj_val[i]=tm;
			    break;
			}
		}
	}else{
		$(ele).html('并且');
			for(var i=0;i<khkztj_val.length;i++){
				var tm=khkztj_val[i];
				if(tm.indexOf(eid)>0){
					tm=tm.replace("or","and");
					khkztj_val[i]=tm;
					break;
				}
			}	
	}
}

function getchangeHtmlVal(ele){
	if("并且"==ele){
		return 'and';
	}else if("或者"==ele){
		return 'or';
	}
}

function delPar(ele){
	ele.parentNode.parentNode.parentNode.removeChild(ele.parentNode.parentNode);
	var eid=ele.parentNode.previousSibling.firstChild.id;
	for(var i=0;i<khkztj_val.length;i++){
		var tm=khkztj_val[i];
		if(tm.indexOf(eid)>0){
			khkztj_val.remove(tm);
		}
	}
}

function getCxtj(data,d_name,cmd){
	$.ajax({
			url : 'HandelCustExtend.action?mathid='+Math.random(),
			type : 'post',
			data : {'zlfl':data,'zlfl_name':d_name,'cmd':cmd},
			dataType:'json',//接受数据格式 
			success : function(data) {
				    eval("var t_cxnr="+data.cxnr)
					if('zlfl_cxtj'==cmd){
						Ext.getCmp('cxtj').clearValue();
						eval("var t="+data.data)
						if(t.length>0){
							Ext.getCmp('cxtj').store.loadData(t);
						}
					}
						Ext.getCmp('cxnr').clearValue();
						Ext.getCmp('bjlx').clearValue();
						if(t_cxnr.length>0){
						Ext.getCmp('cxnr').store.loadData(t_cxnr);
						eval("var cxnr_type="+data.cxnr_type);
						if("1"==cxnr_type){
							
						}
					}
			},
			failure : function(data) {
				
			}
		});
}