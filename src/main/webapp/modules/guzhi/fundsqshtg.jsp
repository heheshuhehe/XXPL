<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <%@include file="resoures.jsp"%>
	<base href="<%=basePath%>" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>   
    <title>文件信息</title>
    <script>document.documentElement.focus();</script>
    
</head>
<script type="text/javascript">
/*=================导出  */
	/*导出excel 按钮*/ 
 function outFile() {
	
	  var str =$("#d_ywrq").combobox('getValue');
      str=str.replace(/-/g,'');
      if(str=="" ){
		  alert("请选择日期起！");
		  return false;
	  } 
		 //获取开始日期
 		 var params = {zth:$("#zth").combobox('getValue'),d_ywrq:str,ttlz:$("#ttlz").combobox('getValue')};
		 
		 var par="d_ywrq="+str;
		 window.open("<%=basePath%>simu/downloadTAdatatg?"+par);
		// $.download('simu/downloadsmttl',params,'post');
		// alert(params);
		 /*  $.ajax({
			type : 'POST',
			url : 'simu/downloadTAdata?',
					data:params,
			dataType : 'json',
			beforeSend : function() {
				load("正在导出中，请稍后...");
			},
			success : function(data) {
				disLoad();
				alert("下载完成！");
				//searchdata();
			},error : function() {
				disLoad();
				alert("系统异常！");
			}
		});  */
}
	/*导出excel 按钮*/ 
 function outFiletg() {
	  var str =$("#d_ywrq").combobox('getValue');
      str=str.replace(/-/g,'');
      if(str=="" ){
		  alert("请选择日期起！");
		  return false;
	  } 
		 //获取开始日期
 		 var params = {zth:$("#zth").combobox('getValue'),d_ywrq:str,ttlz:$("#ttlz").combobox('getValue')};
		 
		 var par="d_ywrq="+str;
		 window.open("<%=basePath%>simu/downloadTAdataTG?"+par);
}

 function myCellStyler(value,row,index){
		if (!isNaN(value)){
			return 'color:bleak;';
		}
 }
function inFile() {  
    var filename= $("#filename").filebox('getValue');
	if (filename == "") {
		alert("请选择要导入数据库的文件");
		return false;
	}
    var params="filename="+$("#filename").filebox('getValue');
     $.ajax({   
          url: '<%=cp%>/simu/filecsvdelup?'+params,   
          type: 'POST',   
          dataType:"json",
          beforeSend : function() {
				load("正在导出中，请稍后...");
			},
          success: function (result) { 
          		if(result.msg="success"){
					 disLoad();
					 alert("导出数据库完成..");
					 
				} 
				
          }
     });   
}  
		
							
$(function (){
	 $("#tabsidk").tabs({
	 	 width : '100%',
     	 height:document.documentElement.clientHeight-20
	 });
	 $("#dg").datagrid({
	 	 width : '100%',
     	 height :document.documentElement.clientHeight-130
	 });
	 $("#filename").filebox({    
	    buttonText: '选择文件', 
	    buttonAlign: 'right',
	    accept:'.csv'
	});
	  
});

function searchdata(){


    var str =$("#d_ywrq").combobox('getValue');
    str=str.replace(/-/g,'');
      if(str=="" ){
		  alert("请选择日期起！");
		  return false;
	  } 
      
    //var params="zth="+$("#zth").combobox('getValue');
    var params="zth="+$("#zth").combobox('getValue') + "&d_ywrq=" + str + "&ttlz="+$("#ttlz").combobox('getValue');
	 $('#dg').datagrid({method:'get',
	 url:"simu/getalldatatg?"+params
	 }).datagrid('clientPaging'); 
/* 	$('#zth').combobox('clear','zth');
 */	 
	  
}



//弹出加载层
	function load(msg) {
		$("<div class=\"datagrid-mask\"></div>").css({
			display : "block",
			width : "100%",
			height : $(window).height()
		}).appendTo("body");
		$("<div class=\"datagrid-mask-msg\"></div>").html(msg)
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
</script>
<body>
<div id="tabsidk" class="easyui-tabs" style="">
	<div title="TA申赎及分红信息" style="padding: 5px">
			<div style="margin-top: 5px; margin-bottom: 5px;">
			<span  style="display: none;">外包账套名称
			<input class="easyui-combobox" type="text"
						name="text" id="zth" 
						 data-options=		 "valueField: 'value',
	  										  textField: 'text',
											  mode:'local',
											  url:'<%=cp%>/simu/querygetname?selectType=02',
					                          method:'post',
											  multiple:false,
											  width:280,
											  filter: function(q, row){
														var opts = $(this).combobox('options');
														return row[opts.textField].indexOf(q) >-1;
													},
														  onLoadSuccess: function(){
				 $('#zth').next('.combo').find('input').focus(function (){
			            $('#zth').combobox('clear');
			            
			     });
				 
		     }
													
													
													" 	
		    > </span> 
		    &nbsp; &nbsp;   	<span style="display: none;"> <span>产品类型 </span>
		 
			    <select class="easyui-combobox" name="ttlz" id="ttlz" >
						    <option value="5">全部</option>
						    <option value="ttl">天天利</option>
						    <option value="ttz">天天増</option>
				</select> 
			</span>
		   <span style="margin-left: 0px"  >确认日期（TA）</span>  	
	       <span><input id="d_ywrq" name="d_ywrq" class="easyui-datebox" style="width: 150px" data-options="editable:false";></input></span>
	       <span style="color: red;">*</span>

		   <span style="margin-left: 15px;"></span>  	
		   <span hidden><input id="datetime1" name="datetime1" class="easyui-datebox" style="width: 150px"></input></span>
		   <span style="color: red;"></span>
		   <span style="color: red;"></span>		 			
		   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdata()">查询</a>
	
		   <a href="javascript:void(0)" class="easyui-linkbutton"
                data-options="iconCls:'icon-print'" onclick="outFiletg()">托管导出</a> 
            <br></br>
            <!-- <input class="easyui-filebox" id="filename" type="text" style="width:300px">
          	<input class="easyui-filebox" name="file1" id="filename"
           				data-options="
           				onChange:function(){
           				alert($(this).filebox('getValue'))
           				},
           				prompt:'选择文件'" 
           				style="width:300px"> 
		    <a href="javascript:void(0)" class="easyui-linkbutton"
                data-options="iconCls:'icon-print'" onclick="inFile()">导入</a>   -->
			
		</div>
		<div style="margin-top: 10px;">
			<table id="dg" style="width: 777px; height: 480px"
				data-options="selectOnCheck:true,checkOnSelect:true,rownumbers:true,
				              singleSelect:true,autoRowHeight:false,pagination:true,pageSize:500">
				<thead>
					<tr>
					   <!--  <th data-options="field:'ck',checkbox:true"></th> -->
                        <th field="accountmappingid" data-options="hidden:true"></th>
                       
						<th field="d_date"  >业务申请日期 </th>
						<th field="wb_zth"  hidden="true"  >外包账套号</th>
						<th field="tg_zth" >托管账套号</th>
						<th field="ztmc"  >账套名称</th>
						 <th field="fundacco"  >基金账号</th>
						<th field="c_fundcode"  >证券上市代码</th>
						<th field="fhmc"  >业务类型</th>
						<th field="fhje"    data-options="align:'right',formatter:myformatter,styler:myCellStyler">结算金额</th>
						<th field="d_cdate"  >业务确认日期</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
</html>
