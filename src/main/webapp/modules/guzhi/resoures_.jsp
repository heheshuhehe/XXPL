<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp+"/";
%>
<link href="<%=basePath%>common/easyui/themes/icon.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>common/easyui/themes/default/easyui.css">
<script type="text/javascript" src="<%=basePath%>common/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/easyui/locale/easyui-lang-zh_CN.js"></script>
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
					};
					onRefresh:function(pageNum, pageSize){
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



</script>