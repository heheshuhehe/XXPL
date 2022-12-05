<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp+"/";
%>
<link href="<%=basePath%>common/easyui/themes/icon.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>common/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/kalendae.css">
 <script type="text/javascript" src="<%=basePath%>common/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/kalendae.standalone.js"></script>
<script type="text/javascript" src="<%=basePath%>common/js/datagrid-filter.js"></script>

<script type="text/javascript" src="<%=basePath%>common/easyui/demo.css"></script>
<script type="text/javascript" src="<%=basePath%>common/easyui/themes/icon.css"></script>

<script  type="text/javascript">
function getSelected(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		$.messager.alert('Info',"["+ row.ck+"]"+row.id+":"+row.username+":"+row.status);
	}
	var checkedItems = $('#dg').datagrid('getChecked'); 
	var names = [];  
	$.each(checkedItems, function(index, item){    
		names.push(item.productname); 
		});                 
}
function getSelections(){
	var ss = [];
	var rows = $('#dg').datagrid('getSelections');
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		ss.push('<span>['+row.ck+"]"+row.itemid+":"+row.productid+":"+row.attr1+'</span>');
	}
	$.messager.alert('Info', ss.join('<br/>'));
}

(function($){
	function pagerFilter(data){
		if ($.isArray(data)){	// is array
			data = {
				total: data.length,
				rows: data
			}
		}
		var dg = $(this);
		var state = dg.data('datagrid');
		var opts = dg.datagrid('options');
		if (!state.allRows){
			state.allRows = (data.rows);
		}
		var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
		var end = start + parseInt(opts.pageSize);
		data.rows = $.extend(true,[],state.allRows.slice(start, end));
		return data;
	}

	var loadDataMethod = $.fn.datagrid.methods.loadData;
	$.extend($.fn.datagrid.methods, {
		clientPaging: function(jq){
			return jq.each(function(){
				var dg = $(this);
                var state = dg.data('datagrid');
                var opts = state.options;
                opts.loadFilter = pagerFilter;
                var onBeforeLoad = opts.onBeforeLoad;
                opts.onBeforeLoad = function(param){
                    state.allRows = null;
                    return onBeforeLoad.call(this, param);
                }
				dg.datagrid('getPager').pagination({
					onSelectPage:function(pageNum, pageSize){
						opts.pageNumber = pageNum;
						opts.pageSize = pageSize;
						$(this).pagination('refresh',{
							pageNumber:pageNum,
							pageSize:pageSize
						});
						dg.datagrid('loadData',state.allRows);
					}
				});
                $(this).datagrid('loadData', state.data);
                if (opts.url){
                	$(this).datagrid('reload');
                }
			});
		},
        loadData: function(jq, data){
            jq.each(function(){
                $(this).data('datagrid').allRows = null;
            });
            return loadDataMethod.call($.fn.datagrid.methods, jq, data);
        },
        getAllRows: function(jq){
        	return jq.data('datagrid').allRows;
        }
	})
})(jQuery);

function myformatter(value,row,index){
	
	 if(typeof(value)!='undefined'){ 
       if(!isNaN(value)){ //如果是数字 
		 if(((value+"").indexOf("%")==-1)){//不带%号
			  var  num = value+"";
			  if(/^.*\..*$/.test(num)){
			   var pointIndex =num.lastIndexOf(".");
			   var intPart = num.substring(0,pointIndex);
			   var pointPart =num.substring(pointIndex+1,pointIndex+3);
			   intPart = intPart +"";
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2")
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(num)){
			     num =num.replace(re,"$1,$2");
			    }
			    num +=".00";
			 
			    if(num==".00"){
			    	num="";
			    }
			    
			  }
			 
			  return  "<span style='font-family:SimSun'>"+num+"</span>";
		 }else{
			 return "<span style='font-family:SimSun'>"+value+"</span>";
	 	 }
	   }else{//如果不是数字
		   if(value.indexOf("jrdwjz")==-1){
			   return "<span style='font-family:SimSun'>"+value+"</span>";
		   }else{
			   return "<span style='font-family:SimSun'>"+value.split("jrdwjz")[0]+"</span>";
		   }
	   }
	 }else{
		 return "";
	 }
}
function myformatterFlat(value,row,index){
	value=new Number(value);
	 if(typeof(value)!='undefined'){ 
      if(!isNaN(value)){ //如果是数字 
		 if(((value+"").indexOf("%")==-1)){//不带%号
			  var  num = value+"";
			  if(/^.*\..*$/.test(num)){
			   var pointIndex =num.lastIndexOf(".");
			   var intPart = num.substring(0,pointIndex);
			   var pointPart =num.substring(pointIndex+1,pointIndex+3);
			   intPart = intPart +"";
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2")
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(num)){
			     num =num.replace(re,"$1,$2");
			    }
			    num +=".00";
			 
			    if(num==".00"){
			    	num="";
			    }
			    
			  }
			 
			  return  "<span style='font-family:SimSun'>"+num+"</span>";
		 }else{
			 return "<span style='font-family:SimSun'>"+value+"</span>";
	 	 }
	   }else{//如果不是数字
		   if(value.indexOf("jrdwjz")==-1){
			   return "<span style='font-family:SimSun'>"+value+"</span>";
		   }else{
			   return "<span style='font-family:SimSun'>"+value.split("jrdwjz")[0]+"</span>";
		   }
	   }
	 }else{
		 return "";
	 }
}
function myformatter4(value,row,index){
	 if(typeof(value)!='undefined'){ 
      if(!isNaN(value)){ //如果是数字 
		 if(((value+"").indexOf("%")==-1)){//不带%号
			  var  num = value+"";
			  if(/^.*\..*$/.test(num)){
			   var pointIndex =num.lastIndexOf(".");
			   var intPart = num.substring(0,pointIndex);
			   var pointPart =num.substring(pointIndex+1,pointIndex+3);
			   intPart = intPart +"";
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(intPart)){
			     intPart =intPart.replace(re,"$1,$2")
			    }
			   if(pointPart.length==1){
				   pointPart = pointPart+"0";
			   }
			    num = intPart+"."+pointPart;
			  }else{
			    var re =/(-?\d+)(\d{3})/
			    while(re.test(num)){
			     num =num.replace(re,"$1,$2");
			    }
			    num +=".0000";
			 
			    if(num==".0000"){
			    	num="";
			    }
			    
			  }
			 
			  return  "<span style='font-family:SimSun'>"+num+"</span>";
		 }else{
			 return "<span style='font-family:SimSun'>"+value+"</span>";
	 	 }
	   }else{//如果不是数字
		   if(value.indexOf("jrdwjz")==-1){
			   return "<span style='font-family:SimSun'>"+value+"</span>";
		   }else{
			   return "<span style='font-family:SimSun'>"+value.split("jrdwjz")[0]+"</span>";
		   }
	   }
	 }else{
		 return "";
	 }
}
function load(msg) {
	$("<div class=\"datagrid-mask\"></div>").css({
		display : "block",
		width : "100%",
		height : $(window).height()
	}).appendTo("body");
	$("<div class=\"datagrid-mask-msg\"></div>").html(msg + "，请稍候。。。")
			.appendTo("body").css({
				display : "block",
				left : ($(document.body).outerWidth(true) - 190) / 2,
				top : ($(window).height() - 45) / 2
			});
}
//取消加载层  
function disLoad() {
	$(".datagrid-mask").remove();
	$(".datagrid-mask-msg").remove();
}

formatterDate = function(date) {
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	return date.getFullYear() + '-' + month + '-' + day;
	};

</script>