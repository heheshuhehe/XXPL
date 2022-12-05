<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>分红清算</title>
    <%@include file="/modules/guzhi/resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<!-- 初始化操作 -->
<script>
(function($){
    function buildMenu(target){
        var state = $(target).data('datagrid');
        if (!state.columnMenu){
            state.columnMenu = $('<div></div>').appendTo('body');
            state.columnMenu.menu({
                onClick: function(item){
                    if (item.iconCls == 'tree-checkbox1'){
                        $(target).datagrid('hideColumn', item.name);
                        $(this).menu('setIcon', {
                            target: item.target,
                            iconCls: 'tree-checkbox0'
                        });
                    } else {
                        $(target).datagrid('showColumn', item.name);
                        $(this).menu('setIcon', {
                            target: item.target,
                            iconCls: 'tree-checkbox1'
                        });
                    }
                }
            })
            var fields = $(target).datagrid('getColumnFields',true).concat($(target).datagrid('getColumnFields',false));
            for(var i=0; i<fields.length; i++){
                var field = fields[i];
                var col = $(target).datagrid('getColumnOption', field);
                state.columnMenu.menu('appendItem', {
                    text: col.title,
                    name: field,
                    iconCls: 'tree-checkbox1'
                });
            }
        }
        return state.columnMenu;
    }
    $.extend($.fn.datagrid.methods, {
        columnMenu: function(jq){
            return buildMenu(jq[0]);
        }
    });
})(jQuery);
$(function (){
		 $("#tabsidk").tabs({
		 	 width : '100%',
		 	 height : document.documentElement.clientHeight-20
		 });
		 $("#dg").datagrid({
		 	 width : '100%',
	   	     height :document.documentElement.clientHeight-135
		 });
		 $("#initdg").datagrid({
		 	 width : '100%',
	   	     height :document.documentElement.clientHeight-135
		 });
		 $("#dg1").datagrid({
		 	 width : '100%',
	   	     height :document.documentElement.clientHeight-135,
	   	     fitColumns: true,
	   	  	 onHeaderContextMenu: function(e, field){
	              e.preventDefault();
	              $(this).datagrid('columnMenu').menu('show', {
	                  left:e.pageX,
	                  top:e.pageY
	              });
         	 }
		 });	
		 $("#dg2").datagrid({
		 	 width : '100%',
	   	     height :document.documentElement.clientHeight-135,
	   	     fitColumns: true,
	   	  	 onHeaderContextMenu: function(e, field){
	              e.preventDefault();
	              $(this).datagrid('columnMenu').menu('show', {
	                  left:e.pageX,
	                  top:e.pageY
	              });
         	 }
		 });	
		 
	 	$('#dlgReleaseTime').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
                span.trigger('click'); //触发click事件弹出月份层
                if (!tds)
                    setTimeout(function () { //延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                        tds = p.find('div.calendar-menu-month-inner td');
                        tds.click(function (e) {
                            e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                            var year = /\d{4}/.exec(span.html())[0] //得到年份
                                ,
                                month = parseInt($(this).attr('abbr'), 10); //月份
                            $('#dlgReleaseTime').datebox('hidePanel') //隐藏日期对象
                                .datebox('setValue', year + '-' + month); //设置日期的值
                        });
                    }, 0);
            },
            parser: function (s) {//配置parser，返回选择的日期
                if (!s) return new Date();
                var arr = s.split('-');
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
            },
            formatter: function (d) { return d.getFullYear() + '-' + (d.getMonth() + 1); }//配置formatter，只返回年月
        });
        var p = $('#dlgReleaseTime').datebox('panel'), //日期选择对象
            tds = false, //日期选择对象中月份
            span = p.find('span.calendar-text'); //显示月份层的触发控件
        var curr_time = new Date();
      //  $("#dlgReleaseTime").datebox("setValue", myformatter()(curr_time));
      
      var currTime=new Date();
            var strDate=currTime.getFullYear()+"-"+(currTime.getMonth()+1)+"-01";
            $('#init_date').datebox({formatter:function(date){
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? '0' + m : m;
                return y.toString() + '-' + m.toString();
            },parser:function(date){
                console.log(date);
                if (date) {
                    return new Date(String(date).substring(0, 4) + '-'
                            + String(date).substring(5,7));
                } else {
                    return new Date();
                }
            }});
            $('#init_date').datebox('setValue',strDate);//默认加载当前月份
            $('#init_date2').datebox({formatter:function(date){
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? '0' + m : m;
                return y.toString() + '-' + m.toString();
            },parser:function(date){
                console.log(date);
                if (date) {
                    return new Date(String(date).substring(0, 4) + '-'
                            + String(date).substring(5,7));
                } else {
                    return new Date();
                }
            }});
            $('#init_date2').datebox('setValue',strDate);//默认加载当前月份

            $('#subjcode').combobox({
    			onChange:onchangesubj
    		});
      
      $("#tjlx").combobox({
    	 width:150,
   		 onSelect:function(val){
   			 if(val.value==1){
   				 $("#leixing").show();
   			     $('#firsttype').combobox('clear');
   			     $('#secondtype').combobox('clear');
   				 $("#renyuan").hide();
   			 }else if(val.value==2){
   				 $("#leixing").hide();
   			     $('#userInfo').combobox('clear');
   				 $("#renyuan").show();
   				 
   			 }
          }		
       });
      
      $("#tjlx_lx").combobox({
     	 width:150,
    		 onSelect:function(val){
    			 if(val.value==1){
    				 $("#leixing_lx").show();
    			     $('#firsttype_lx').combobox('clear');
    			     $('#secondtype_lx').combobox('clear');
    				 $("#renyuan_lx").hide();
    			 }else if(val.value==2){
    				 $("#leixing_lx").hide();
    			     $('#userInfo_lx').combobox('clear');
    				 $("#renyuan_lx").show();
    				 
    			 }
           }		
        });
      
      
      
      $("#tjlx_zr").combobox({
     	 width:150,
    		 onSelect:function(val){
    			 if(val.value==1){
    				 $("#leixing_zr").show();
    			     $('#firsttype_zr').combobox('clear');
    			     $('#secondtype_zr').combobox('clear');
    				 $("#renyuan_zr").hide();
    			 }else if(val.value==2){
    				 $("#leixing_zr").hide();
    			     $('#userInfo_zr').combobox('clear');
    				 $("#renyuan_zr").show();
    				 
    			 }
           }		
        });
      
      //估值人员
      $("#userInfo").combobox({
            valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo&usertype=2',
              method:'post',
			  multiple:false,
			  width:200,
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
      
      //估值人员
      $("#userInfo_zr").combobox({
            valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo&usertype=2',
              method:'post',
			  multiple:false,
			  width:200,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			  onLoadSuccess: function(){
				 $('#userInfo_zr').next('.combo').find('input').focus(function (){
			            $('#userInfo_zr').combobox('clear');
			     });
		     }
	  });
      //估值人员
      $("#userInfo_lx").combobox({
            valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/guzhidz/querySelectValue?selectType=queryUserInfo&usertype=2',
              method:'post',
			  multiple:false,
			  width:200,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) >-1;
					},
			  onLoadSuccess: function(){
				 $('#userInfo_lx').next('.combo').find('input').focus(function (){
			            $('#userInfo_lx').combobox('clear');
			     });
		     }
	  });
    //初始化分类
      $("#firsttype").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		      method:'post',
		      multiple:true,
			  multiline:true,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onChange:function(val){
						 $('#secondtype').combobox('clear');
					     var rec = $("#firsttype").combobox('getValues');
						 if(rec.toString().indexOf(",") > -1 ){
							$("#secondtype").combobox('disable');
						 }else{
						 	 $("#secondtype").combobox('enable');
							 $("#secondtype").combobox({ 
									  valueField: 'value',
									  textField: 'text',
									  disabled:true,
									  mode:'local',
									  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+rec,
						              method:'get',
									  multiple:false,
									  width:80,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
								      onLoadSuccess: function(){
								    	  $(this).combobox('enable');
									  }		
						    });
						}
					},
					  onLoadSuccess: function(){
								 $('#firsttype').next('.combo').find('input').focus(function (){
							            $('#firsttype').combobox('clear');
							            $('#secondtype').combobox('clear');
							            $("#secondtype").combobox("reload","yongjin/getUserSelectVal?selectType=04");
							            $("#firsttype").combobox("reload","yongjin/getUserSelectVal?selectType=03");
							     });
								 
						     }
					
		 }); 
    
      $("#firsttype_lx").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		      method:'post',
		      multiple:true,
			  multiline:true,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onChange:function(val){
						 $('#secondtype_lx').combobox('clear');
					     var rec = $("#firsttype_lx").combobox('getValues');
						 if(rec.toString().indexOf(",") > -1 ){
							$("#secondtype_lx").combobox('disable');
						 }else{
						 	 $("#secondtype_lx").combobox('enable');
							 $("#secondtype_lx").combobox({ 
									  valueField: 'value',
									  textField: 'text',
									  disabled:true,
									  mode:'local',
									  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+rec,
						              method:'get',
									  multiple:false,
									  width:80,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
								      onLoadSuccess: function(){
								    	  $(this).combobox('enable');
									  }		
						    });
						}
					},
					  onLoadSuccess: function(){
								 $('#firsttype_lx').next('.combo').find('input').focus(function (){
							            $('#firsttype_lx').combobox('clear');
							            $('#secondtype_lx').combobox('clear');
							            $("#secondtype_lx").combobox("reload","yongjin/getUserSelectVal?selectType=04");
							            $("#firsttype_lx").combobox("reload","yongjin/getUserSelectVal?selectType=03");
							     });
								 
						     }
					
		 }); 
      
      $("#firsttype_zr").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		      method:'post',
		      multiple:true,
			  multiline:true,
			  width:150,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onChange:function(val){
						 $('#secondtype_zr').combobox('clear');
					     var rec = $("#firsttype_zr").combobox('getValues');
						 if(rec.toString().indexOf(",") > -1 ){
							$("#secondtype_zr").combobox('disable');
						 }else{
						 	 $("#secondtype_zr").combobox('enable');
							 $("#secondtype_zr").combobox({ 
									  valueField: 'value',
									  textField: 'text',
									  disabled:true,
									  mode:'local',
									  url:'<%=cp%>/ziguan/getUserSelect?selectType=04&firsttype='+rec,
						              method:'get',
									  multiple:false,
									  width:80,
									  filter: function(q, row){
												var opts = $(this).combobox('options');
												return row[opts.textField].indexOf(q) >-1;
											},
								      onLoadSuccess: function(){
								    	  $(this).combobox('enable');
									  }		
						    });
						}
					},
					  onLoadSuccess: function(){
								 		$('#firsttype_zr').next('.combo').find('input').focus(function (){
							            $('#firsttype_zr').combobox('clear');
							            $('#secondtype_zr').combobox('clear');
							            $("#secondtype_zr").combobox("reload","yongjin/getUserSelectVal?selectType=04");
							            $("#firsttype_zr").combobox("reload","yongjin/getUserSelectVal?selectType=03");
							     });
								 
						     }
					
		 }); 
///////////////////////////////////AJAX请求/////////////////////////////////////////


$("#firsttype4").combobox({
			 valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  url:'<%=cp%>/ziguan/getUserSelect?selectType=03',
		      method:'post',
		      multiple:false,
			  multiline:true,
			  width:120,
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						console.log(opts);
						return row[opts.textField].indexOf(q) >-1;
					},
					onChange:function(val){},
					  onLoadSuccess: function(){}
					
		 }); 





//----------------------------




});
</script>

<!-- 自定义js -->
<script type="text/javascript">
///////////////////////////////Ajax请求///////////////////////////////////////////////////

function Yjinitialize(){
     $("#dkmh").text("多科目号:");
	$.ajax({
	   type: "POST",
	   url: "<%=cp%>/ziguan/initYongJin?type="+$("#firsttype").combobox('getValues').toString(),
	   success: function(data){
		    var type1 = "";
		    var type2 = "";
		    var type3 = "";
		    var type4 = "";
	        $.each(eval(data),function(i,value){
	        	 if(value.type==1){
	        		 type1+=value.code+",";
	        	 }else if(value.type==2){
	        		 type2+=value.code+",";
	        	 }else if(value.type==3){
	        		 type3+=value.code+",";
	        	 }else if(value.type==4){
	        		 type4+=value.code+"+";
	        	 }else if(value.type==10){
	        		 
	        		 type4+=value.code+"+";
	        	 }
	        });
	        if(type1!=""){
	        	type1 = type1.substring(0,type1.length-1);
	        }
	        if(type2!=""){
	        	type2 = type2.substring(0,type2.length-1);
	        }
	        if(type3!=""){
	        	type3 = type3.substring(0,type3.length-1);
	        }
	        if(type4!=""){
	        	type4 = type4.substring(0,type4.length-1);
	        }
	        $("#dkmh").text($("#dkmh").text()+type4);
	   }
	});   
      
} 

function cell1Styler(value,row,index){
	return 'background-color:#FFEFDB';
}
function cell2Styler(value,row,index){
	return 'background-color:#E0EEEE';
}
</script>

<script type="text/javascript">

function searchdata(){
	/* Yjinitialize();  */
	var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
	var firsttype = $("#firsttype").combobox('getValues').toString();
	var secondtype= $("#secondtype").combobox('getValue');
	var userInfo = $("#userInfo").combobox('getValue');
 	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#'); 
	if(dlgReleaseTime==""){
		alert("请选择时间");
		return false;
	} 
	
	var t = $("#tjlx").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		} else{
			
			if(secondtype==""){
				
				$('#dg').datagrid({method:'post',
	             	url:"<%=cp%>/ziguan/getZSSInfo",
					queryParams:{dlgReleaseTime:dlgReleaseTime,
						         firsttype:firsttype,chanzt:chanzt
						        }
	             	}).datagrid('clientPaging'); 
	             	$("#secondtype").combobox("reload","yongjin/getUserSelectVal?selectType=04");
					$("#firsttype").combobox("reload","yongjin/getUserSelectVal?selectType=03");
			}else{
		 		$('#dg').datagrid({method:'post',
             	url:"<%=cp%>/ziguan/getZSSInfo",
				queryParams:{dlgReleaseTime:dlgReleaseTime,
					         firsttype:firsttype,
					         secondtype:secondtype,chanzt:chanzt} 
             	}).datagrid('clientPaging'); 
			}
		}
	}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
		$('#dg').datagrid({method:'post',
            url:"<%=cp%>/ziguan/getZSSInfo",
			queryParams:{dlgReleaseTime:dlgReleaseTime,
				         user_id:userInfo,chanzt:chanzt
				        } 
            }).datagrid('clientPaging'); 
		}
	}
	
	
} 

function searchdata_lx(){
	/* Yjinitialize();  */
	var start = $("#lstartTime").datebox('getValue');
	var end = $("#lendTime").datebox('getValue');
	var firsttype = $("#firsttype_lx").combobox('getValues').toString();
	var secondtype= $("#secondtype_lx").combobox('getValue');
	var userInfo = $("#userInfo_lx").combobox('getValue');
	var ysfs = $("#ysfs_lx").combobox('getValue');
	var zqxx = $("#zqxx_lx").val();
	var sjlx = $("#sjlx_lx").combobox('getValue');
/*  	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');  */
	if(start=="" || end == ""){
		alert("请选择时间");
		return false;
	}
	if(ysfs==""){
		alert("请选择应税方式");
		return false;
	}
	
	var t = $("#tjlx_lx").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		} else{
			
			if(secondtype==""){
				
				$('#dg1').datagrid({method:'post',
	             	url:"<%=cp%>/ziguan/getZZSLx",
					queryParams:{start:start,end:end,
						         firsttype:firsttype,ysfs:ysfs,zqxx:zqxx,sjlx:sjlx
						        }
	             	}).datagrid('clientPaging'); 
	             	$("#secondtype_lx").combobox("reload","yongjin/getUserSelectVal?selectType=04");
					$("#firsttype_lx").combobox("reload","yongjin/getUserSelectVal?selectType=03");
			}else{
		 		$('#dg1').datagrid({method:'post',
             	url:"<%=cp%>/ziguan/getZZSLx",
				queryParams:{start:start,end:end,
					         firsttype:firsttype,zqxx:zqxx,sjlx:sjlx,
					         secondtype:secondtype,ysfs:ysfs} 
             	}).datagrid('clientPaging'); 
			}
		}
	}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
		$('#dg1').datagrid({method:'post',
            url:"<%=cp%>/ziguan/getZZSLx",
			queryParams:{start:start,end:end,zqxx:zqxx,sjlx:sjlx,
				         user_id:userInfo,ysfs:ysfs
				        } 
            }).datagrid('clientPaging'); 
		}
	}

}

function searchdata_zr(){       
	var start = $("#zstartTime").datebox('getValue');
	var end = $("#zendTime").datebox('getValue');
	var firsttype = $("#firsttype_zr").combobox('getValues').toString();
	var secondtype= $("#secondtype_zr").combobox('getValue');
	var userInfo = $("#userInfo_lx").combobox('getValue');
	var ysfs = $("#ysfs_zr").combobox('getValue');
	var zqxx = $("#zqxx_zr").val();
	var sjlx = $("#sjlx_zr").combobox('getValue');
/*  	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');  */
	if(start=="" || end == ""){
		alert("请选择时间");
		return false;
	}
	if(ysfs==""){
		alert("请选择应税方式");
		return false;
	}
	
	var t = $("#tjlx_zr").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		} else{
			
			if(secondtype==""){
				
				$('#dg2').datagrid({method:'post',
	             	url:"<%=cp%>/ziguan/getZZSZr",
					queryParams:{start:start,end:end,
						         firsttype:firsttype,ysfs:ysfs,zqxx:zqxx,sjlx:sjlx
						        }
	             	}).datagrid('clientPaging'); 
	             	$("#secondtype_zr").combobox("reload","yongjin/getUserSelectVal?selectType=04");
					$("#firsttype_zr").combobox("reload","yongjin/getUserSelectVal?selectType=03");
			}else{
		 		$('#dg2').datagrid({method:'post',
             	url:"<%=cp%>/ziguan/getZZSZr",
				queryParams:{start:start,end:end,
					         firsttype:firsttype,zqxx:zqxx,sjlx:sjlx,
					         secondtype:secondtype,ysfs:ysfs} 
             	}).datagrid('clientPaging'); 
			}
		}
	}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
		$('#dg2').datagrid({method:'post',
            url:"<%=cp%>/ziguan/getZZSZr",
			queryParams:{start:start,end:end,user_id:userInfo,ysfs:ysfs,zqxx:zqxx,sjlx:sjlx	 } 
            }).datagrid('clientPaging'); 
		}
	}
}

function ExporterExcel_zr(){       
	var start = $("#zstartTime").datebox('getValue');
	var end = $("#zendTime").datebox('getValue');
	var firsttype = $("#firsttype_zr").combobox('getValues').toString();
	var secondtype= $("#secondtype_zr").combobox('getValue');
	var firstvalue = $("#firsttype_zr").combobox('getText').toString();
	var secondvalue = $("#secondtype_zr").combobox('getText');
	var userInfo = $("#userInfo_lx").combobox('getValue');
	var ysfs = $("#ysfs_zr").combobox('getValue');
	var ysfs_value = $("#ysfs_zr").combobox('getText');
	var zqxx = $("#zqxx_zr").val();
	var sjlx = $("#sjlx_zr").combobox('getValue');
	var params;
/*  	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');  */
	if(start=="" || end == ""){
		alert("请选择时间");
		return false;
	}
	if(ysfs==""){
		alert("请选择应税方式");
		return false;
	}
	
	var t = $("#tjlx_zr").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		} else{
			
			if(secondtype==""){
				params = "start="+start+"&firsttype="+firsttype+"&end="+end+"&ysfs="+ysfs+"&sjlx="+sjlx+"&zqxx="+zqxx+"&firstvalue="+firstvalue+"&secondvalue="+secondvalue+"&ysfs_value="+ysfs_value;
				window.location.href='<%=cp%>/ziguan/exportexcel_zr?'+params;
	            $("#secondtype_zr").combobox("reload","yongjin/getUserSelectVal?selectType=04");
				$("#firsttype_zr").combobox("reload","yongjin/getUserSelectVal?selectType=03");
			}else{
				params = "start="+start+"&firsttype="+firsttype+"&end="+end+"&ysfs="+ysfs+"&secondtype="+secondtype+"&sjlx="+sjlx+"&zqxx="+zqxx+"&firstvalue="+firstvalue+"&secondvalue="+secondvalue+"&ysfs_value="+ysfs_value;
				window.location.href='<%=cp%>/ziguan/exportexcel_zr?'+params;
			}
		}
	}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
			params = "start="+start+"&user_id="+userInfo+"&end="+end+"&ysfs="+ysfs+"&sjlx="+sjlx+"&zqxx="+zqxx+"&firstvalue="+firstvalue+"&secondvalue="+secondvalue+"&ysfs_value="+ysfs_value;
			window.location.href='<%=cp%>/ziguan/exportexcel_zr?'+params;
		}
	}
}

function ExporterExcel_lx(){       
	var start = $("#lstartTime").datebox('getValue');
	var end = $("#lendTime").datebox('getValue');
	var firsttype = $("#firsttype_lx").combobox('getValues').toString();
	var firstvalue = $("#firsttype_lx").combobox('getText').toString();
	var secondtype= $("#secondtype_lx").combobox('getValue');
	var secondvalue = $("#secondtype_lx").combobox('getText');
	var userInfo = $("#userInfo_lx").combobox('getValue');
	var ysfs = $("#ysfs_lx").combobox('getValue');
	var ysfs_value = $("#ysfs_lx").combobox('getText');
	var zqxx = $("#zqxx_lx").val();
	var sjlx = $("#sjlx_lx").combobox('getValue');
	var params;
/*  	var chanzt = $("input[name='chanzt']:checked").map(function () {
        return $(this).val();
    }).get().join('#');  */
	if(start=="" || end == ""){
		alert("请选择时间");
		return false;
	}
	if(ysfs==""){
		alert("请选择应税方式");
		return false;
	}
	
	var t = $("#tjlx_lx").combobox('getValue');
	if (t==1) {
		if(firsttype==""){
			alert("请选择一级分类");
		    return false;
		} else{
			if(secondtype==""){
				params = "start="+start+"&firsttype="+firsttype+"&end="+end+"&ysfs="+ysfs+"&sjlx="+sjlx+"&zqxx="+zqxx+"&firstvalue="+firstvalue+"&secondvalue="+secondvalue+"&ysfs_value="+ysfs_value;
				window.location.href='<%=cp%>/ziguan/exportexcel_lx?'+params;
	            $("#secondtype_lx").combobox("reload","yongjin/getUserSelectVal?selectType=04");
				$("#firsttype_lx").combobox("reload","yongjin/getUserSelectVal?selectType=03");
			}else{
				params = "start="+start+"&firsttype="+firsttype+"&end="+end+"&ysfs="+ysfs+"&secondtype="+secondtype+"&sjlx="+sjlx+"&zqxx="+zqxx+"&firstvalue="+firstvalue+"&secondvalue="+secondvalue+"&ysfs_value="+ysfs_value;
				window.location.href='<%=cp%>/ziguan/exportexcel_lx?'+params;
			}
		}
	}
	if(t==2){
		if(userInfo==""){
			alert("请选择估计人员");
		    return false;
		}else{
			 params = "start="+start+"&user_id="+userInfo+"&end="+end+"&ysfs="+ysfs+"&sjlx="+sjlx+"&zqxx="+zqxx+"&firstvalue="+firstvalue+"&secondvalue="+secondvalue+"&ysfs_value="+ysfs_value;
			 window.location.href='<%=cp%>/ziguan/exportexcel_lx?'+params;
		}
	}
}
 
 function ExporterExcel(){
	 Yjinitialize(); 
		var dlgReleaseTime = $("#dlgReleaseTime").datebox('getValue');
		var firsttype = $("#firsttype").combobox('getValues').toString();
		var firstvalue = $("#firsttype").combobox('getText').toString();
		var secondtype= $("#secondtype").combobox('getValue');
		var userInfo = $("#userInfo").combobox('getValue');
		var params;
	 	var chanzt = $("input[name='chanzt']:checked").map(function () {
	        return $(this).val();
	    }).get().join('#'); 
		if(dlgReleaseTime==""){
			alert("请选择时间");
			return false;
		} 
		
		var t = $("#tjlx").combobox('getValue');
		if (t==1) {
			if(firsttype==""){
				alert("请选择一级分类");
			    return false;
			} else{
				
				if(secondtype==""){
					params = "dlgReleaseTime="+dlgReleaseTime+"&firsttype="+firsttype+"&firstvalue="+firstvalue+"&chanzt="+chanzt;
					 window.location.href='<%=cp%>/ziguan/exportexcel?'+params;
		             	$("#secondtype").combobox("reload","yongjin/getUserSelectVal?selectType=04");
						$("#firsttype").combobox("reload","yongjin/getUserSelectVal?selectType=03");
				}else{
			 		params = "dlgReleaseTime="+dlgReleaseTime+"&firsttype="+firsttype+"&secondtype="+secondtype+"&firstvalue="+firstvalue+"&chanzt="+chanzt;
					 window.location.href='<%=cp%>/ziguan/exportexcel?'+params;
				}
			}
		}
		if(t==2){
			if(userInfo==""){
				alert("请选择估计人员");
			    return false;
			}else{
				params = "dlgReleaseTime="+dlgReleaseTime+"&user_id="+userInfo+"&chanzt="+chanzt;
				 window.location.href='<%=cp%>/ziguan/exportexcel?'+params;
			}
		}
 }
	function chadata_zr(){
		var str ="";
		$("#zth1_e option:checked").each(function(){
			str+=$(this).text()+",";
		});
		alert(str);
	}
	function chadata_lx(){
		var str ="";
		$("#zth2_e option:checked").each(function(){
			str+=$(this).text()+",";
		});
		alert(str);
	}
	 function setStyle(d) {
         var trs = $(this).prev().find('div.datagrid-body').find('tr');
    
         for (var row = 0; row < trs.length; row++) {

	             if (trs[row].cells[35].firstChild.innerHTML==1){
	            	 trs[row].cells[12].style.cssText = 'background:#0f0;color:#f00';
		             trs[row].cells[16].style.cssText = 'background:#0f0;color:#f00';
		             trs[row].cells[20].style.cssText = 'background:#0f0;color:#f00';
	            	 
	             }
	             if (trs[row].cells[36].firstChild.innerHTML==1){
	            	 trs[row].cells[12].style.cssText = 'background:#ff0;color:#00f';
		             trs[row].cells[8].style.cssText = 'background:#ff0;color:#00f';
		            
	            	 
	             }
	             

         }
     }
function taxconfig(){
	$.ajax({
		url:"<%=cp%>/ziguan/searchTaxfeeinfo?areaid=",
		type:'post',
		data:{},
		dataType: "json",
		success: function(data){
			
			for(var i=0;i<data.length;i++){
				if(data[i].areaid==1 ){
					$('#taxtypecj_bj').textbox('setValue',data[i].cj);
					$('#taxtypejy_bj').textbox('setValue',data[i].jy);
					$('#taxtypedfjy_bj').textbox('setValue',data[i].dfjy);
					
			
				}else{

				}
				if(data[i].areaid==2 ){
					$('#taxtypecj_sh').textbox('setValue',data[i].cj);
					$('#taxtypejy_sh').textbox('setValue',data[i].jy);
					$('#taxtypedfjy_sh').textbox('setValue',data[i].dfjy);
				}else{
		
				}
			}

			 $('#yhdzhds').dialog('open');
			
			
		}
	});
}
function closeDialog(){
	$('#taxtypecj_bj').textbox('setValue','');
	$('#taxtypejy_bj').textbox('setValue','');
	$('#taxtypedfjy_bj').textbox('setValue','');
	$('#taxtypecj_sh').textbox('setValue','');
	$('#taxtypejy_sh').textbox('setValue','');
	$('#taxtypedfjy_sh').textbox('setValue','');
   $('#yhdzhds').dialog('close');
 
}
function closeDialog2(){
	$("#filesname").val('');
	 $('#yhdzhds2').dialog('close');
 
}
function saveInfonew(){
	
	var cj_bj=$('#taxtypecj_bj').textbox('getValue');
	var jy_bj=$('#taxtypejy_bj').textbox('getValue');
	var dfjy_bj=$('#taxtypedfjy_bj').textbox('getValue');
	var cj_sh=$('#taxtypecj_sh').textbox('getValue');
	var jy_sh=$('#taxtypejy_sh').textbox('getValue');
	var dfjy_sh=$('#taxtypedfjy_sh').textbox('getValue');
	$.ajax({
		url:"<%=cp%>/ziguan/searchTaxfeeinfo?areaid=",
		type:'post',
		data:{type:"3",cj_bj:cj_bj,jy_bj:jy_bj,dfjy_bj:dfjy_bj,cj_sh:cj_sh,jy_sh:jy_sh,dfjy_sh:dfjy_sh},
		dataType: "json",
		success: function(data){
			if(data[0].msg=='success'){
				$.messager.alert('提示','保存成功');
				closeDialog();
			}else
				$.messager.alert('提示','保存失败');
			
		}
	});
}
function managedata(op) {
	
	if('a'==op){
		
		$('#c_cp_name2').combobox('enable');
		$('#init_date2').combobox('enable');
		$('#in_type').combobox('enable');
		
		$('#in_type').combobox('select','0');
		$('#proc_type').combobox('select','0');
		
		$('#c_cp_name2').combobox('setValue','');
		$('#c_cp_name2').combobox('setText','');
		
		$('#subjcode').combobox('setValue','2221');
		$('#subjcode').combobox('setText','2221 应交税费余额');
		$('#qc_ye').textbox('setValue','');
		$('#qm_ye').textbox('setValue','');
		$('#j_ye').textbox('setValue','');
		$('#d_ye').textbox('setValue','');
		$("#filesname").val('');
		$('#op').val('a');
		 $('#yhdzhds2').dialog('open');
	}
	
	if('u'==op){
		
		var row= $('#initdg').datagrid('getSelected');
		if(row==null){
			$.messager.alert('提示','请先选中一行');
			return;
		}
	
		$('#op').val('u');
		$('#c_cp_name2').combobox('disable');
		$('#init_date2').combobox('disable');
		$('#in_type').combobox('disable');
		//----------------------------
		$('#c_cp_name2').combobox('setValue',row.account_id);
		$('#c_cp_name2').combobox('setText',row.c_port_name);
		$('#init_date2').datebox('setValue',row.yearmonth);
		$('#init_date2').datebox('setText',row.yearmonth);
		$('#proc_type').combobox('setValue',row.proc_type);
		var proc_type=""; var proc_typename="";
		if(row.proc_type=='固定值'){
			proc_type="0";
			proc_typename="0_固定值";
		}
		if(row.proc_type=='浮动值'){
			proc_type="1";
			proc_typename="1_浮动值";
		}
		$('#proc_type').combobox('setValue',proc_type);
		$('#proc_type').combobox('setText',proc_typename);
		$('#in_type').combobox('setText',row.in_type);
		
	 	$('#qc_ye').textbox('setValue',row.subjcode2221_qc);
		$('#qm_ye').textbox('setValue',row.subjcode2221_qm);
		$('#j_ye').textbox('setValue',row.subjcode2221_j);
		$('#d_ye').textbox('setValue',row.subjcode2221_d); 
		
		$('#subjcode').combobox('setValue','2221');
		$('#subjcode').combobox('setText','2221 应交税费余额');
		
		$("#filesname").val('');
		
		 $('#yhdzhds2').dialog('open');
		
	}
	if(op=='s'){
	
	

		var account_id=$('#c_cp_name').combobox('getValue');
		var init_date=$('#init_date').combobox('getValue');
		var f_type=$('#firsttype4').combobox('getValue');
		
		$('#initdg').datagrid({method:'post',
            url:"<%=cp%>/ziguan/getinitdata",
			queryParams:{account_id:account_id,init_date:init_date,f_type:f_type}  }).datagrid('clientPaging'); 
		
	}
	if(op=='d'){
		var row= $('#initdg').datagrid('getSelected');
		if(row==null){
			$.messager.alert('提示','请先选中一行');
			return;
		}
		
		$.messager.confirm('警告', '确认要删除吗?', function(r){
			if (r){
				var account_id=row.account_id;;
				var init_date2=row.yearmonth;
				$.ajax({
					url:"<%=cp%>/ziguan/saveinitdata?op="+op,
					type:'post',
					data:{account_id:account_id,init_date2:init_date2},
					dataType: "json",
					success: function(data){
						if(data[0].msg=='success'){
							$.messager.alert('提示','删除成功');
							//closeDialog2();
							managedata('s');
						}else
							$.messager.alert('提示','删除失败');
						
					}
				});
				
			}
		});

		
		
	}

	
}

function onchangesubj(n,o){
	
	var row=$('#initdg').datagrid('getSelected')
	if(row==null)
		return;
	var op=$('#op').val();
	if(op=='u'){
		if(n=='2221'){
			
			$('#qc_ye').textbox('setValue',row.subjcode2221_qc);
			$('#qm_ye').textbox('setValue',row.subjcode2221_qm);
			$('#j_ye').textbox('setValue',row.subjcode2221_j);
			$('#d_ye').textbox('setValue',row.subjcode2221_d);
		}
		if(n=='2221.07'){
			
			$('#qc_ye').textbox('setValue',row.subjcode222107_qc);
			$('#qm_ye').textbox('setValue',row.subjcode222107_qm);
			$('#j_ye').textbox('setValue',row.subjcode222107_j);
			$('#d_ye').textbox('setValue',row.subjcode222107_d);
		}
		if(n=='2221.05.01'){
			
			$('#qc_ye').textbox('setValue',row.subjcode22210501_qc);
			$('#qm_ye').textbox('setValue',row.subjcode22210501_qm);
			$('#j_ye').textbox('setValue',row.subjcode22210501_j);
			$('#d_ye').textbox('setValue',row.subjcode22210501_d);
		}
		if(n=='2221.05.02'){
			
			$('#qc_ye').textbox('setValue',row.subjcode22210502_qc);
			$('#qm_ye').textbox('setValue',row.subjcode22210502_qm);
			$('#j_ye').textbox('setValue',row.subjcode22210502_j);
			$('#d_ye').textbox('setValue',row.subjcode22210502_d);
		}
		if(n=='2221.05.03'){
			
			$('#qc_ye').textbox('setValue',row.subjcode22210503_qc);
			$('#qm_ye').textbox('setValue',row.subjcode22210503_qm);
			$('#j_ye').textbox('setValue',row.subjcode22210503_j);
			$('#d_ye').textbox('setValue',row.subjcode22210503_d);
		}
		if(n=='2221.07.01'){
			
			$('#qc_ye').textbox('setValue',row.subjcode22210701_qc);
			$('#qm_ye').textbox('setValue',row.subjcode22210701_qm);
			$('#j_ye').textbox('setValue',row.subjcode22210701_j);
			$('#d_ye').textbox('setValue',row.subjcode22210701_d);
		}
		if(n=='2221.07.02'){
			
			$('#qc_ye').textbox('setValue',row.subjcode22210702_qc);
			$('#qm_ye').textbox('setValue',row.subjcode22210702_qm);
			$('#j_ye').textbox('setValue',row.subjcode22210702_j);
			$('#d_ye').textbox('setValue',row.subjcode22210702_d);
		}
		if(n=='2221.07.03'){
			
			$('#qc_ye').textbox('setValue',row.subjcode22210703_qc);
			$('#qm_ye').textbox('setValue',row.subjcode22210703_qm);
			$('#j_ye').textbox('setValue',row.subjcode22210703_j);
			$('#d_ye').textbox('setValue',row.subjcode22210703_d);
		}
	}
		
		
		/*  <option value="2221">2221 应交税费余额</option>
		    <option value="2221.07">2221.07应付税费_附加税余额</option>
		    <option value="2221.05.01">2221.05.01应付税费_增值税</option>
		    <option value="2221.05.02">2221.05.02应付税费_销项税_金融商品转让</option>
		    <option value="2221.05.03">2221.05.03应付税费_销项税_贷款服务收入</option>
		    <option value="2221.07.01">2221.07.01应付税费_附加城建税</option>
		    <option value="2221.07.02">2221.07.02应付税费_销项税_附加教育税</option>
		    <option value="2221.07.03">2221.07.03应付税费_销项税_地方教育附加</option> */
}

function saveInfonew2(){
	
	var account_id=$('#c_cp_name2').combobox('getValue');
	var init_date2=$('#init_date2').combobox('getValue');
	var proc_type=$('#proc_type').combobox('getValue');
	var in_type=$('#in_type').combobox('getValue');
	var subjcode=$('#subjcode').combobox('getValue');
	var qc_ye=$('#qc_ye').textbox('getValue');
	var qm_ye=$('#qm_ye').textbox('getValue');
	var j_ye=$('#j_ye').textbox('getValue');
	var d_ye=$('#d_ye').textbox('getValue');
	var op=$('#op').val();
	var bz=$('#bz').textbox('getValue');
		if(op=='a'){
	
		if(in_type=='0'||in_type=='2'){
			if(account_id==''){
				$.messager.alert('提示','请选择账套');
				return;
			}
				
			$.ajax({
				url:"<%=cp%>/ziguan/saveinitdata?op="+op,
				type:'post',
				data:{account_id:account_id,init_date2:init_date2,proc_type:proc_type,in_type:in_type,subjcode:subjcode,qc_ye:qc_ye,qm_ye:qm_ye,j_ye:j_ye,d_ye:d_ye,bz:bz},
				dataType: "json",
				success: function(data){
					if(data[0].msg=='success'){
						$.messager.alert('提示','保存成功');
						//closeDialog2();
					}else
						$.messager.alert('提示','保存失败');
					
				}
			});
		}	
		if(in_type=='1'){
			
		var files=  document.getElementById("filesname").files
			
			if(files.length==0){
				$.messager.alert('提示','没有选择文件！！');
				return;
			}
			
			 var formData = new FormData($("#uploadfile" )[0]); 
			$.ajax({
				url:'<%=cp%>/ziguan/saveinitdata4import',
				type:'post',
				data:formData,
				 async: false,   
		          cache: false,   
		          contentType: false,   
		          processData: false, 
				dataType: "json",
				success: function(data){
					if(data[0].msg=="success"){
						alert("上传成功！");
						closeDialog2();
						managedata('s');
						
					}else{
						alert("上传失败！");
					}
				}
			});
		}
	
	}
		
		if(op=='u'){
			$.ajax({
				url:"<%=cp%>/ziguan/saveinitdata?op="+op,
				type:'post',
				data:{account_id:account_id,init_date2:init_date2,proc_type:proc_type,in_type:in_type,subjcode:subjcode,qc_ye:qc_ye,qm_ye:qm_ye,j_ye:j_ye,d_ye:d_ye,bz:bz},
				dataType: "json",
				success: function(data){
					if(data[0].msg=='success'){
						$.messager.alert('提示','保存成功');
						//closeDialog2();
					}else
						$.messager.alert('提示','保存失败');
					
				}
			});
		}
		
		
			
}
</script>
<body> 
	   <div id="tabsidk" class="easyui-tabs" style="">
	   
	   		 <div title="增值税查询" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
				
					  <span>时间:</span>
					  <span><input id="dlgReleaseTime" name="dlgReleaseTime" class="easyui-datebox" style="width: 150px"></input></span>
					   <span style="color: red;">*</span>
					  <span>统计类型:</span>
					  <select class="easyui-combobox" name="tjlx" id="tjlx" >
					    <option value="1">按类型统计</option>
					    <option value="2">按人员统计</option>
					  </select> 
					   <span style="color: red;">*</span>
					  <span id="leixing"> 
					   <span>一级分类:</span>
					    <input class="easyui-combobox" name="firsttype" id="firsttype"> 
					      <span style="color: red;">*</span>
					   <span>二级分类:</span>
					   <input class="easyui-combobox" name="secondtype" id="secondtype">
					  </span>
					  <span id="renyuan" style="display:none;">  
					   <span>估值人员:</span>
					   <input class="easyui-combobox" name="userInfo" id="userInfo" />
					      <span style="color: red;">*</span>
					   </span>
					    <input type="checkbox" name="chanzt" value="1"  id="chanzt" />是否显示无数据账套信息<br /><br />
					     <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="taxconfig()">配置附加税方案</a> &nbsp;
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a> &nbsp;
					   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel()">导出</a> 
					   说明：(1)背景色 绿色为2221.05.02(贷)+2221.05.03(贷)≠2221.05.01(贷)  (2)背景色  黄色2221.05.01(贷)*附加税率 ≠2221.07(贷)
				</div>
				<div style="margin-top: 10px;">
					<table  id="dg" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,onLoadSuccess:setStyle,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500, pageList:[50,100,200,500]
						               ">
							<thead>
								<tr>
								<th field="account_id"  rowspan="2" width="50px">账套号</th>
							     <th field="fsetname"  rowspan="2" width="120px">基金名称</th>
							     <th colspan="4"  width="150px">2221 应交税费余额</th>
								<!-- <th field="2221"  rowspan="2" data-options="align:'right',formatter:myformatter()">2221 应交税费余额</th> -->
								<th colspan="4"  width="150px">2221.07应付税费_附加税余额</th>
								
								<!-- <th field="2221.05"  rowspan="2" data-options="align:'right',formatter:myformatter()">2221.05 应付税费_增值税余额</th>
								<th field="2221.07"  rowspan="2" data-options="align:'right',formatter:myformatter()">2221.07应付税费_附加税余额</th> -->
								<th  colspan="4"   width="200px" >2221.05.01应付税费_增值税</th>
								<th  colspan="4"   width="200px" >2221.05.02应付税费_销项税_金融商品转让</th>
								<th  colspan="4"  width="200px" >2221.05.03 应付税费_销项税_贷款服务收入</th>
								<th  colspan="4"   width="300px">2221.07.01应付税费_附加城建税</th>
								<th  colspan="4"   width="300px">2221.07.02应付税费_附加教育税</th>
								<th  colspan="4"   width="300px">2221.07.03应付税费_地方教育附加</th>
								<th field="username"  rowspan="2">估值人员</th>
								<th field="check1"  rowspan="2"  hidden="true"> 校验规则1</th>
								<th field="check2"  rowspan="2"  hidden="true"> 校验规则2</th>
							</tr>
							<tr>
								<th field="q2221" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="j2221" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="d2221" data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="2221" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="q2221.07" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="j2221.07" data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="d2221.07" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="2221.07" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
								<th field="q2221.05.01" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="j2221.05.01" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="d2221.05.01" data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="2221.05.01" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="q2221.05.02"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="j2221.05.02"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="d2221.05.02" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="2221.05.02" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
								<th field="q2221.05.03" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="j2221.05.03" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="d2221.05.03" data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="2221.05.03" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="q2221.07.01" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="j2221.07.01" data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="d2221.07.01" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="2221.07.01" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
								<th field="q2221.07.02" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="j2221.07.02" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="d2221.07.02"data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="2221.07.02" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="q2221.07.03" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="j2221.07.03" data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="d2221.07.03" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="2221.07.03" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div title="增值税利息查询" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
				
					  <span>起止时间:</span>
					  <span>
					  		<input id="lstartTime" name="lstartTime" class="easyui-datebox" style="width: 120px"></input>>>
					  		<input id="lendTime" name="lendTime" class="easyui-datebox" style="width: 120px"></input>
					  </span>
					<span>统计类型:</span>
					  <select class="easyui-combobox" name="tjlx_zr" id="tjlx_lx" >
					    <option value="1">按类型统计</option>
					    <option value="2">按人员统计</option>
					  </select> 
					   <span style="color: red;">*</span>
					  <span id="leixing_lx"> 
					   <span>一级分类:</span>
					    <input class="easyui-combobox" name="firsttype_lx" id="firsttype_lx"> 
					      <span style="color: red;">*</span>
					   <span>二级分类:</span>
					   <input class="easyui-combobox" name="secondtype_lx" id="secondtype_lx">
					  </span>
					  <span id="renyuan_lx" style="display:none;">  
					   <span>估值人员:</span>
					   <input class="easyui-combobox" name="userInfo_lx" id="userInfo_lx" />
					      <span style="color: red;">*</span>
					   </span>
					  &nbsp;&nbsp;&nbsp;&nbsp;<span>应税方式:</span>
						  <select class="easyui-combobox"  data-options="panelHeight:'auto'" name="ysfs_lx" id="ysfs_lx" >
							    <option value="">请选择</option>
							    <option value="M_TAX">免税</option>
							    <option value="Y_TAX">应税</option>
						  </select> 
					  &nbsp;&nbsp;&nbsp;&nbsp;
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_lx()">查询</a>
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel_lx()">导出</a> 
					  <br>
					   <span>证券信息:</span>
					   <input id="zqxx_lx" class="easyui-textbox"  style="line-height:26px;border:1px solid #ccc"/>
					   &nbsp;&nbsp;&nbsp;&nbsp;
					   <span style="margin-left:70px">数据类型:</span>
					  <select class="easyui-combobox"  data-options="panelHeight:'auto',width:120" name="sjlx_lx" id="sjlx_lx" >
							    <option value="2">汇总和明细</option>
							    <option value="0">汇总</option>
							    <option value="1">明细</option>
					   </select>
				</div>
				<div style="margin-top: 10px;">
						<table  id="dg1" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500, pageList:[50,100,200,500]
						               ">
							<thead>
								<tr>
									<th field="c_port_name_st"   data-options="align:'center'">投资组合</th>
								    <th field="c_port_code"   data-options="align:'center'">组合代码</th>
								    <th field="rq"  data-options="align:'center'">日期</th>
								    <th field="c_tax_way"  data-options="align:'center'">应税方式</th>
								    <th field="c_tax_type"  data-options="align:'center'">税费类型</th>
									<th field="c_sec_code" data-options="align:'center'">证券代码</th>
									<th field="c_sec_name" data-options="align:'center'">证券名称</th>
									<th field="c_sec_var_name"  data-options="align:'center'">证券品种</th>
									<th field="c_mkt_name"  data-options="align:'center'">交易市场</th>
									<th field="c_td_attr_name"  data-options="align:'center'">交易属性</th>
									<th field="c_dt_name"  data-options="align:'center'">投资分类</th>
									<th field="c_dv_name"  data-options="align:'center'">发行方式</th>
									<th field="n_interest_restore"  data-options="align:'right',formatter:myformatter">还原税前计税基准</th>
									<th field=n_interest  data-options="align:'right',formatter:myformatter">计税基准(利息、红利收入发生额)</th>
									<th field="n_interest_bal"    data-options="align:'right',formatter:myformatter">当日计税基准余额</th>
									<th field="n_tax_last"   data-options="align:'right',formatter:myformatter">上一日税费余额</th>
									<th field="n_tax"  data-options="align:'right',formatter:myformatter">当日税费发生额</th>
									<th field="n_tax_bal"  data-options="align:'right',formatter:myformatter">当日税费余额</th>
									<th field="n_kmbal_last"   data-options="align:'right',formatter:myformatter">上一日科目余额</th>
									<th field="n_val_money"   data-options="align:'right',formatter:myformatter">当日凭证计提</th>
									<th field="n_km_bal"  data-options="align:'right',formatter:myformatter">当日科目余额</th>
									<!-- <th field="c_data_idf" style="width: 150px"data-options="align:'center'">数据来源</th> -->
<!--  									<th field="6"  width="120px" data-options="align:'center'">制作人</th>
									<th field="6"  width="120px" data-options="align:'center'">制作时间</th> -->
								</tr>
						</thead>
					</table>
				</div>
			</div>
			<div title="增值税转让查询" style="padding: 5px">
				<div style="margin-top: 5px; margin-bottom: 5px;" >
				
					  <span>起止时间:</span>
					  <span>
					  		<input id="zstartTime" name="zstartTime" class="easyui-datebox" style="width: 120px"></input>>>
					  		<input id="zendTime" name="zendTime" class="easyui-datebox" style="width: 120px"></input>
					  </span>
					  <span>统计类型:</span>
					  <select class="easyui-combobox" name="tjlx_zr" id="tjlx_zr" >
					    <option value="1">按类型统计</option>
					    <option value="2">按人员统计</option>
					  </select> 
					   <span style="color: red;">*</span>
					  <span id="leixing_zr"> 
					   <span>一级分类:</span>
					    <input class="easyui-combobox" name="firsttype_zr" id="firsttype_zr"> 
					      <span style="color: red;">*</span>
					   <span>二级分类:</span>
					   <input class="easyui-combobox" name="secondtype_zr" id="secondtype_zr">
					  </span>
					  <span id="renyuan_zr" style="display:none;">  
					   <span>估值人员:</span>
					   <input class="easyui-combobox" name="userInfo_zr" id="userInfo_zr" />
					      <span style="color: red;">*</span>
					   </span>
					   	 &nbsp;&nbsp;&nbsp;&nbsp;<span>应税方式:</span>
						  <select class="easyui-combobox"  data-options="panelHeight:'auto'" name="ysfs_zr" id="ysfs_zr" >
							    <option value="">请选择</option>
							    <option value="M_TAX">免税</option>
							    <option value="Y_TAX">应税</option>
						  </select> 
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata_zr()">查询</a>
					  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="ExporterExcel_zr()">导出</a> 
					  <br>
					   <span>证券信息:</span>
					   <input id="zqxx_zr" class="easyui-textbox"  style="line-height:26px;border:1px solid #ccc"/>
					   &nbsp;&nbsp;&nbsp;&nbsp;
					   <span style="margin-left:70px">数据类型:</span>
					  <select class="easyui-combobox"  data-options="panelHeight:'auto',width:120" name="sjlx_zr" id="sjlx_zr" >
							    <option value="2">汇总和明细</option>
							    <option value="0">汇总</option>
							    <option value="1">明细</option>
					   </select>
				</div>
				<div style="margin-top: 10px;">
						<table  id="dg2" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500, pageList:[50,100,200,500]
						               ">
							<thead>
								<tr>
									<th field="c_port_name_st"   data-options="align:'center'">投资组合</th>
								    <th field="c_port_code"  data-options="align:'center'">组合代码</th>
								    <th field="rq"   data-options="align:'center'">日期</th>
								    <th field="c_tax_way"   data-options="align:'center'">应税方式</th>
								    <th field="c_tax_type"   data-options="align:'center'">税费类型</th>
									<th field="c_sec_code"   data-options="align:'center'">证券代码</th>
									<th field="c_sec_name"  data-options="align:'center'">证券名称</th>
									<th field="c_sec_var_name"  data-options="align:'center'">证券品种</th>
									<th field="c_mkt_name"   data-options="align:'center'">交易市场</th>
									<th field="c_td_attr_name"   data-options="align:'center'">交易属性</th>
									<th field="c_dt_name"   data-options="align:'center'">投资分类</th>
									<th field="c_dv_name"  data-options="align:'center'">发行方式</th>
									<th field="n_port_price"   data-options="align:'right',formatter:myformatter">卖出金额</th>
									<th field="n_port_cost"   data-options="align:'right',formatter:myformatter">卖出成本</th>
									<th field="n_last_dedu_bal"    data-options="align:'right',formatter:myformatter">上一日期初抵扣估增</th>
									<th field="n_dedu_money"   data-options="align:'right',formatter:myformatter">当日估增抵扣发生额</th>
									<th field="n_dedu_bal"   data-options="align:'right',formatter:myformatter">当日剩余期初抵扣估增</th>
									<th field="n_val"   data-options="align:'right',formatter:myformatter">差价收入</th>
									<th field="n_base"   data-options="align:'right',formatter:myformatter">计税基准</th>
									<th field="n_base_bal"   data-options="align:'right',formatter:myformatter">当日计税基准余额</th>
									<th field="n_taxbal_last"   data-options="align:'right',formatter:myformatter">上一日税费余额</th>
									<th field="n_tax"   data-options="align:'right',formatter:myformatter">当日税费发生额</th>
									<th field="n_tax_bal"   data-options="align:'right',formatter:myformatter">当日税费余额</th>
									<th field="n_kmbal_last"   data-options="align:'right',formatter:myformatter">上一日科目余额</th>
									<th field="n_val_money"   data-options="align:'right',formatter:myformatter">当日凭证计提</th>
									<th field="n_km_bal"   data-options="align:'right',formatter:myformatter">当日科目余额</th>
									<!-- <th field="c_data_idf"  width="120px" data-options="align:'center'">数据来源</th> -->
<!-- 									<th field="6"  width="120px" data-options="align:'center'">制作人</th>
									<th field="6"  width="120px" data-options="align:'center'">制作时间</th> -->
								</tr>
						</thead>
					</table>
				</div>
			</div>
			
			
			<div title="科目初始化" style="padding: 5px">
			<table>
				<tr>
				<td>账套名称：<input class="easyui-combobox" name="c_cp_name"
						id="c_cp_name"
						data-options="		valueField: 'value',
											  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/getCPname2',
					                          method:'post',
											  multiple:false,
											  width:220,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) > -1;
													}
				">   月度： <input id="init_date" name="init_date" class="easyui-datebox" style="width: 80px" />
			     </td>

					<td>	   一级分类： <input class="easyui-combobox" name="firsttype4" id="firsttype4"> 
					
					</td>
							   
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('s')">查询</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('a')">添加</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('u')">修改</a>
								<td><a href="javascript:void(0);" class="easyui-linkbutton"data-options="iconCls:'icon-search'" onclick="managedata('d')">删除</a>
					
					</td>		
				</tr>
		</table>
		<div style="margin-top: 10px;">
			<table  id="initdg" data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
						              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500, pageList:[50,100,200,500]
						               ">
							<thead>
								<tr>
								<th field="account_id"  rowspan="2" width="50px">账套号</th>
							     <th field="c_port_name"  rowspan="2" width="120px">基金名称</th>
							      <th field="yearmonth"  rowspan="2" >年月</th>
							       <th field="proc_type"  rowspan="2" >处理方式</th>
							        <th field="in_type"  rowspan="2" >维护类型</th>
							     <th colspan="4"  width="150px">2221 应交税费余额</th>
								<!-- <th field="2221"  rowspan="2" data-options="align:'right',formatter:myformatter()">2221 应交税费余额</th> -->
								<th colspan="4"  width="150px">2221.07应付税费_附加税余额</th>
								
								<!-- <th field="2221.05"  rowspan="2" data-options="align:'right',formatter:myformatter()">2221.05 应付税费_增值税余额</th>
								<th field="2221.07"  rowspan="2" data-options="align:'right',formatter:myformatter()">2221.07应付税费_附加税余额</th> -->
								<th  colspan="4"   width="200px" >2221.05.01应付税费_增值税</th>
								<th  colspan="4"   width="200px" >2221.05.02应付税费_销项税_金融商品转让</th>
								<th  colspan="4"  width="200px" >2221.05.03 应付税费_销项税_贷款服务收入</th>
								<th  colspan="4"   width="300px">2221.07.01应付税费_附加城建税</th>
								<th  colspan="4"   width="300px">2221.07.02应付税费_附加教育税</th>
								<th  colspan="4"   width="300px">2221.07.03应付税费_地方教育附加</th>
								<!-- <th field="username"  rowspan="2">估值人员</th> -->
								<th field="check1"  rowspan="2"  hidden="true"> 校验规则1</th>
								<th field="check2"  rowspan="2"  hidden="true"> 校验规则2</th>
								<th field="bz"  rowspan="2"   >  备注</th>
							</tr>
							<tr>
								<th field="subjcode2221_qc" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="subjcode2221_j" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="subjcode2221_d" data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="subjcode2221_qm" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="subjcode222107_qc" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="subjcode222107_j" data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="subjcode222107_d" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="subjcode222107_qm" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
								<th field="subjcode22210501_qc" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="subjcode22210501_j" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="subjcode22210501_d" data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="subjcode22210501_qm" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="subjcode22210502_qc"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="subjcode22210502_j"  data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="subjcode22210502_d" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="subjcode22210502_qm" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
								<th field="subjcode22210503_qc" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="subjcode22210503_j" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="subjcode22210503_d" data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="subjcode22210503_qm" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="subjcode22210701_qc" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="subjcode22210701_j" data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="subjcode22210701_d" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="subjcode22210701_qm" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
								<th field="subjcode22210702_qc" data-options="align:'right',formatter:myformatter">期初余额</th>
								<th field="subjcode22210702_j" data-options="align:'right',formatter:myformatter">借方</th>
								<th field="subjcode22210702_d"data-options="align:'right',formatter:myformatter">贷方</th>
								<th field="subjcode22210702_qm" data-options="align:'right',formatter:myformatter">期末余额</th>
								
								<th field="subjcode22210703_qc" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期初余额</th>
								<th field="subjcode22210703_j" data-options="align:'right',formatter:myformatter,styler:cell2Styler">借方</th>
								<th field="subjcode22210703_d" data-options="align:'right',formatter:myformatter,styler:cell2Styler">贷方</th>
								<th field="subjcode22210703_qm" data-options="align:'right',formatter:myformatter,styler:cell2Styler">期末余额</th>
								
							</tr>
						</thead>
					</table>
	 </div>
	</div>
			
			
		</div>
       
 </body>
</html>
<div id="yhdzhds" class="easyui-dialog" closed="true" title="配置附加税方案"
			style="width: 750px; height: 300px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons',
						modal:true,
						onClose:closeDialog
					">
					<div style="float: left" >
					<div id="p" class="easyui-panel" title="北京" style="width:330px;height:200px;padding:10px;">
						<span>1_北京:</span> <span>附加税税率：</span>   <br>  <br>
					   增值税_城建附加(%)： <input id="taxtypecj_bj"class="easyui-textbox" name="taxtypecj_bj" style="width: 50px;" />
					   <br>  <br>
					  增值税_地方教育附加(%)： <input id="taxtypedfjy_bj"class="easyui-textbox" name="taxtypedfjy_bj" style="width: 50px;" />
					    <br>  <br>
					    增值税_教育附加(%)： <input id="taxtypejy_bj"class="easyui-textbox" name="taxtypejy_bj" style="width: 50px;" />
					    
					    
					</div>
					
					</div>
					<div style="float: left;margin-left: 30px" >
					<div id="q" class="easyui-panel" title="上海" style="width:330px;height:200px;padding:10px;">
						<span>2_上海:</span> <span>附加税税率：</span>   <br>  <br>
					   增值税_城建附加(%)： <input id="taxtypecj_sh"class="easyui-textbox" name="taxtypecj_sh" style="width: 50px;" />
					   <br>  <br>
					  增值税_地方教育附加(%)： <input id="taxtypedfjy_sh"class="easyui-textbox" name="taxtypedfjy_sh" style="width: 50px;" />
					    <br>  <br>
					    增值税_教育附加(%)： <input id="taxtypejy_sh"class="easyui-textbox" name="taxtypejy_sh" style="width: 50px;" />
					</div>
					</div>
				
				    
				

			
		</div>
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew('a')">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog()">取消</a>
		</div>
		
		<div id="yhdzhds2" class="easyui-dialog" closed="true" title="初始化"
			style="width: 750px; height: 350px; padding: 10px;"
			data-options="
						iconCls: 'icon-save',
						buttons: '#dlg-buttons2',
						modal:true
					">
			<form id="uploadfile" style="float: left" enctype="multipart/form-data">		
				<table> 
				<tr>
				<td>账套名称：<input class="easyui-combobox" name="c_cp_name2"
						id="c_cp_name2"
						data-options="
						                      valueField: 'value',
											  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/guzhidz/getCPname2',
					                          method:'post',
											  multiple:false,
											  width:260,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) > -1;
													}
				"> </td>  <td>月度： <input id="init_date2" name="init_date2" class="easyui-datebox" style="width: 80px" /></td></tr>
				
				<tr>
				<td>处理方式： <select class="easyui-combobox"  data-options="panelHeight:'auto',width:120" name="proc_type" id="proc_type" >
							    <option value="0">0_固定值</option>
							    <option value="1">1_浮动值</option>
							    							  
					   </select></td>  <td>
					   维护类型： <select class="easyui-combobox"  data-options="panelHeight:'auto',width:120" name="in_type" id="in_type" >
							    <option value="0">0_手工录入</option>
							    <option value="1">1_EXEL导入</option>
							    <option value="2">2_复制上月数据</option>
							    							  
					  </select>
					 </td></tr>
					<tr>
				<td> 科目代码： <select class="easyui-combobox"  data-options="panelHeight:'auto',width:260" name="subjcode" id="subjcode" >
							    <option value="2221">2221 应交税费余额</option>
							    <option value="2221.07">2221.07应付税费_附加税余额</option>
							    <option value="2221.05.01">2221.05.01应付税费_增值税</option>
							    <option value="2221.05.02">2221.05.02应付税费_销项税_金融商品转让</option>
							    <option value="2221.05.03">2221.05.03应付税费_销项税_贷款服务收入</option>
							    <option value="2221.07.01">2221.07.01应付税费_附加城建税</option>
							    <option value="2221.07.02">2221.07.02应付税费_销项税_附加教育税</option>
							    <option value="2221.07.03">2221.07.03应付税费_销项税_地方教育附加</option>
							    							  
					   </select>
					   </td>  <td>  </td></tr>
					<tr>
				<td>    期初余额：<input id="qc_ye"class="easyui-textbox" name="qc_ye" style="width: 150px;" /></td>  <td> 
					   期末余额：<input id="qm_ye"class="easyui-textbox" name="qm_ye" style="width: 150px;" /></td></tr>
				  <tr>
				<td> 	借方发生额：<input id="j_ye"class="easyui-textbox" name="j_ye" style="width: 150px;" /></td>  <td> 
					   贷方发生额：<input id="d_ye"class="easyui-textbox" name="d_ye" style="width: 150px;" /></td></tr>
	

<tr> <td>	 备注：<input id="bz"class="easyui-textbox" name="bz" style="width: 240px;" />  </td>
 <td>	<span> 选择模板：<input type="file" id="filesname" name="updateFiles"  />   </td> </tr>
				
				</table>
 			<input id="op" name="op" hidden="true" style="width: 240px;" />
			<br><br>	
		说明：(1)维护类型：手工录入 ，一次维护一条数据，所有项必填<br>
		&nbsp;&nbsp;&nbsp;(2)维护类型：EXCEL导入，可以导入多条数据，月度和处理方式为必选项<br>
		&nbsp;&nbsp;&nbsp;(3)维护类型：复制上月数据，一次维护一条数据，账套名称和月度为必选项
				    
				</form>

			
		</div>
		<div id="dlg-buttons2">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveInfonew2('a')">保存/导入/复制</a> <a href="javascript:void(0)"
				class="easyui-linkbutton"
				onclick="closeDialog2()">取消</a>
		</div>




