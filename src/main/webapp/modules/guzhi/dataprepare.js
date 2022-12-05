//------------------------------ftp--------------------------
$(function (){
	     //初始化table
		 $("#ftpdgs").datagrid({
		 	 width : '100%',
	     	 height :390
		 });
	  ftpsearchdata();
	  
	  
});

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

function ftpsearchdata(){
    var params="filename="+$("#ftpname").textbox('getValue');
     $('#ftpdgs').datagrid({method:'get',url:"guzhisas/queryConfigureInfo?" + params}).datagrid('clientPaging'); 
}

//zttype   userInfo1 
function ftpadddata(){
	if($("#ftps").textbox('getValue')==""||$("#ftpvalue").textbox('getValue')==""){
		alert("请填写配置文件的名称和配置文件的值！");
		return false;
	}else{
		var ftpname=$("#ftps").textbox('getValue');
		var ftppwd = $("#ftpvalue").textbox('getValue');
//		var remark = $("#otherlogo").textbox('getValue');
		
		$.ajax({ 
		        type: "POST", 
		        url: "guzhisas/insertConfigureInfo", 
		        data: {ftpname:ftpname,ftppwd:ftppwd}, 
		        dataType: "json", 
		        success: function(data) {                
		           if(data.msg=="success"){
		        	   alert("操作成功");
		        	   ftpcloseDialog();
		        	   ftpsearchdata();
		           }else{ 
		        	   alert("操作失败");
		        	   ftpcloseDialog();
		           }
		        }, 
		        error: function() { 
		           alert("系统异常，操作失败");     
		        } 
		    });  
	}
}


function ftpremovedata(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择要删除的数据");
		return false;
	}else{
		var id = $("input[name='ck']:checked").val();
		if(id==-1){
			alert("此条数据为自动匹配数据，不需删除");
			return false;
		}else{ 
			$.ajax({ 
		        type: "POST", 
		        url: "guzhisas/deleteConfigureInfo", 
		        data: {ID:id}, 
		        dataType: "json", 
		        success: function(data) {                
		           if(data.msg=="success"){
		        	   alert("删除成功");
		        	   ftpsearchdata();
		           }else{ 
		        	   alert("删除失败");
		           }
		        }, 
		        error: function() { 
		           alert("系统异常，删除失败");     
		        } 
		    });
		}
	}
}


function ftpeditdata(){
	if($("input[name='ck']:checked").length!=1){
		alert("请选择1条要修改的数据");
		return false;
	}else{
		var ftpname = $("input[name='ck']:checked").closest("tr").find("td[field='ftpname']");
		var ftppwd = $("input[name='ck']:checked").closest("tr").find("td[field='ftppwd']");
//		var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']");
 	    ftpname.find("div").html("<input type='text' value='"+ftpname.find("div").text()+"'></input>");
 	   ftppwd.find("div").html("<input type='text' value='"+ftppwd.find("div").text()+"'></input>");
//	    remark.find("div").html("<input type='text' value='"+remark.find("div").text()+"'></input>");
		
		//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
		$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
		$("input[name='ck']").prop("disabled",true);
	}
}
 function ftpsavedata(){
	if($("input[name='ck']:checked").length==1){
		
		var id = $("input[name='ck']:checked").val();
		
		var ftpname = $("input[name='ck']:checked").closest("tr").find("td[field='ftpname']").find("input").val();
		//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
		var ftppwd = $("input[name='ck']:checked").closest("tr").find("td[field='ftppwd']").find("input").val();
//		var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']").find("input").val();
		
		if(ftpname==""){
			alert("配置文件的值不能为空！");
			return false;
		}else if(typeof(ftppwd)=="undefined"){
			alert("请点击修改按钮！");
			return false;
		}else{
			$.ajax({ 
		        type: "POST", 
		        url: "guzhisas/updatConfigureInfo", 
		        data: {ID:id,ftpname:ftpname,ftppwd:ftppwd}, 
		        dataType: "json", 
		        success: function(data) {                
		           if(data.msg=="success"){
		        	   alert("修改成功");
		        	   ftpsearchdata();
		           }else{ 
		        	   alert("修改失败");
		           }
		        }, 
		        error: function() { 
		           alert("系统异常，修改失败");     
		        } 
		    });
		}
	} 
}


function ftpcloseDialog(){
	 $('#ftps').textbox('clear');
	 $('#ftpvalue').textbox('clear');
//	 $('#otherlogo').textbox('clear');
	 $('#ftpdlg').dialog('close');
}
//----------------------path(路径)---------------------------------
$(function (){
    //初始化table
	 $("#pathdgs").datagrid({
	 	 width : '100%',
    	 height :390
	 });
 pathsearchdata();
});
function pathsearchdata(){
$('#pathdgs').datagrid({method:'get',url:"guzhisas/queryConfigureInfo"}).datagrid('clientPaging'); 
}

//zttype   userInfo1 
function pathadddata(){
if($("#paths").textbox('getValue')==""||$("#pathvalue").textbox('getValue')==""){
	alert("请填写配置文件的名称和配置文件的值！");
	return false;
}else{
	var pathname=$("#paths").textbox('getValue');
	var pathpwd = $("#pathvalue").textbox('getValue');
//	var remark = $("#otherlogo").textbox('getValue');
	
	$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/insertConfigureInfo", 
	        data: {pathname:pathname,pathpwd:pathpwd}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("操作成功");
	        	   pathcloseDialog();
	        	   pathsearchdata();
	           }else{ 
	        	   alert("操作失败");
	        	   pathcloseDialog();
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，操作失败");     
	        } 
	    });  
}
}
function pathremovedata(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择要删除的数据");
	return false;
}else{
	var id = $("input[name='ck']:checked").val();
	if(id==-1){
		alert("此条数据为自动匹配数据，不需删除");
		return false;
	}else{ 
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/deleteConfigureInfo", 
	        data: {ID:id}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("删除成功");
	        	   pathsearchdata();
	           }else{ 
	        	   alert("删除失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，删除失败");     
	        } 
	    });
	}
}
}
function patheditdata(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择1条要修改的数据");
	return false;
}else{
	var pathname = $("input[name='ck']:checked").closest("tr").find("td[field='pathname']");
	var pathpwd = $("input[name='ck']:checked").closest("tr").find("td[field='pathpwd']");
//	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']");
    pathname.find("div").html("<input type='text' value='"+pathname.find("div").text()+"'></input>");
   pathpwd.find("div").html("<input type='text' value='"+pathpwd.find("div").text()+"'></input>");
//   remark.find("div").html("<input type='text' value='"+remark.find("div").text()+"'></input>");
	
	//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
	$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
	$("input[name='ck']").prop("disabled",true);
}
}

function pathsavedata(){
if($("input[name='ck']:checked").length==1){
	
	var id = $("input[name='ck']:checked").val();
	
	var pathname = $("input[name='ck']:checked").closest("tr").find("td[field='pathname']").find("input").val();
	//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
	var pathpwd = $("input[name='ck']:checked").closest("tr").find("td[field='pathpwd']").find("input").val();
//	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']").find("input").val();
	
	if(pathname==""){
		alert("配置文件的值不能为空！");
		return false;
	}else if(typeof(pathpwd)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}else{
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/updatConfigureInfo", 
	        data: {ID:id,pathname:pathname,pathpwd:pathpwd}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("修改成功");
	        	   pathsearchdata();
	           }else{ 
	        	   alert("修改失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，修改失败");     
	        } 
	    });
	}
} 
}


function pathcloseDialog(){
$('#paths').textbox('clear');
$('#pathvalue').textbox('clear');
//$('#otherlogo').textbox('clear');
$('#pathdlg').dialog('close');
}
//-----------------------------------------邮箱--------------------
$(function (){
    //初始化table
	 $("#maildgs").datagrid({
	 	 width : '100%',
    	 height :390
	 });
 mailsearchdata();
 
 
});

function mailsearchdata(){
var params="filename="+$("#mailname").textbox('getValue');
$('#maildgs').datagrid({method:'get',url:"guzhisas/queryConfigureInfo?" + params}).datagrid('clientPaging'); 
}

//zttype   userInfo1 
function mailadddata(){
if($("#mails").textbox('getValue')==""||$("#mailvalue").textbox('getValue')==""){
	alert("请填写配置文件的名称和配置文件的值！");
	return false;
}else{
	var mailname=$("#mails").textbox('getValue');
	var mailpwd = $("#mailvalue").textbox('getValue');
//	var remark = $("#otherlogo").textbox('getValue');
	
	$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/insertConfigureInfo", 
	        data: {mailname:mailname,mailpwd:mailpwd}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("操作成功");
	        	   mailcloseDialog();
	        	   mailsearchdata();
	           }else{ 
	        	   alert("操作失败");
	        	   mailcloseDialog();
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，操作失败");     
	        } 
	    });  
}
}


function mailremovedata(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择要删除的数据");
	return false;
}else{
	var id = $("input[name='ck']:checked").val();
	if(id==-1){
		alert("此条数据为自动匹配数据，不需删除");
		return false;
	}else{ 
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/deleteConfigureInfo", 
	        data: {ID:id}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("删除成功");
	        	   mailsearchdata();
	           }else{ 
	        	   alert("删除失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，删除失败");     
	        } 
	    });
	}
}
}
function maileditdata(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择1条要修改的数据");
	return false;
}else{
	var mailname = $("input[name='ck']:checked").closest("tr").find("td[field='mailname']");
	var mailpwd = $("input[name='ck']:checked").closest("tr").find("td[field='mailpwd']");
//	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']");
    mailname.find("div").html("<input type='text' value='"+mailname.find("div").text()+"'></input>");
   mailpwd.find("div").html("<input type='text' value='"+mailpwd.find("div").text()+"'></input>");
//   remark.find("div").html("<input type='text' value='"+remark.find("div").text()+"'></input>");
	
	//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
	$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
	$("input[name='ck']").prop("disabled",true);
}
}
function mailsavedata(){
if($("input[name='ck']:checked").length==1){
	
	var id = $("input[name='ck']:checked").val();
	
	var mailname = $("input[name='ck']:checked").closest("tr").find("td[field='mailname']").find("input").val();
	//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
	var mailpwd = $("input[name='ck']:checked").closest("tr").find("td[field='mailpwd']").find("input").val();
//	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']").find("input").val();
	
	if(mailname==""){
		alert("配置文件的值不能为空！");
		return false;
	}else if(typeof(mailpwd)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}else{
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/updatConfigureInfo", 
	        data: {ID:id,mailname:mailname,mailpwd:mailpwd}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("修改成功");
	        	   mailsearchdata();
	           }else{ 
	        	   alert("修改失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，修改失败");     
	        } 
	    });
	}
} 
}
function mailcloseDialog(){
$('#mails').textbox('clear');
$('#mailvalue').textbox('clear');
//$('#otherlogo').textbox('clear');
$('#maildlg').dialog('close');
}
//-------------------------------------文件列表------------------

$(function (){
	//初始化table
	 $("#filedgs").datagrid({
	 	 width : '100%',
   	 height :390
	 });
	$("#filelogo").combobox({
        valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'01',text:'邮箱'},{value:'02',text:'FTP'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
			}
		})
		
		$("#filevalue").combobox({
        valueField: 'value',
			  textField: 'text',
			  mode:'local',
			  multiple:false,
			  width:150,
			  data:[{value:'01',text:'邮箱'},{value:'02',text:'FTP'}],
			  filter: function(q, row){
						var opts = $(this).combobox('options');
						return row[opts.textField].indexOf(q) == 0;
			}
		})
    
		filesearchdata();
 
 
});

function filesearchdata(){
	var params="filename="+$("#filename").textbox('getValue')+"&remark="+$("#filelogo").combobox('getValue');
    $('#filedgs').datagrid({method:'get',url:"guzhisas/queryConfigureInfo?" + params}).datagrid('clientPaging');
}
//zttype   userInfo1 
function fileadddata(){
	if($("#files").textbox('getValue')==""||$("#filevalue").combobox('getValue')==""){
	alert("请填写文件名称和w文件标识！");
	return false;
}else{
	var filename=$("#files").textbox('getValue');
	var filepwd = $("#filevalue").combobox('getValue');
//	var remark = $("#otherlogo").textbox('getValue');
	
	$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/insertConfigureInfo", 
	        data: {filename:filename,filepwd:filepwd}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("操作成功");
	        	   filecloseDialog();
	        	   filesearchdata();
	           }else{ 
	        	   alert("操作失败");
	        	   filecloseDialog();
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，操作失败");     
	        } 
	    });  
}
}


function fileremovedata(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择要删除的数据");
	return false;
}else{
	var id = $("input[name='ck']:checked").val();
	if(id==-1){
		alert("此条数据为自动匹配数据，不需删除");
		return false;
	}else{ 
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/deleteConfigureInfo", 
	        data: {ID:id}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("删除成功");
	        	   filesearchdata();
	           }else{ 
	        	   alert("删除失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，删除失败");     
	        } 
	    });
	}
}
}


function fileeditdata(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择1条要修改的数据");
	return false;
}else{
	var filename = $("input[name='ck']:checked").closest("tr").find("td[field='filename']");
	var filepwd = $("input[name='ck']:checked").closest("tr").find("td[field='filepwd']");
//	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']");
    filename.find("div").html("<input type='text' value='"+filename.find("div").text()+"'></input>");
   filepwd.find("div").html("<input type='text' value='"+filepwd.find("div").text()+"'></input>");
//   remark.find("div").html("<input type='text' value='"+remark.find("div").text()+"'></input>");
	
	//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
	$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
	$("input[name='ck']").prop("disabled",true);
}
}

function filesavedata(){
if($("input[name='ck']:checked").length==1){
	
	var id = $("input[name='ck']:checked").val();
	
	var filename = $("input[name='ck']:checked").closest("tr").find("td[field='filename']").find("input").val();
	//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
	var filepwd = $("input[name='ck']:checked").closest("tr").find("td[field='filepwd']").find("input").val();
//	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']").find("input").val();
	
	if(filename==""){
		alert("配置文件的值不能为空！");
		return false;
	}else if(typeof(filepwd)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}else{
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/updatConfigureInfo", 
	        data: {ID:id,filename:filename,filepwd:filepwd}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("修改成功");
	        	   filesearchdata();
	           }else{ 
	        	   alert("修改失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，修改失败");     
	        } 
	    });
	}
} 
}


function filecloseDialog(){
$('#files').textbox('clear');
$('#filevalue').combobox('clear');
//$('#otherlogo').textbox('clear');
$('#filedlg').dialog('close');
}


//---------------------------------其他配置-----------------------------
$(function (){
    //初始化table
	 $("#otherdgs").datagrid({
	 	 width : '100%',
    	 height :390
	 });
 searchdatas();
});
function searchdatas(){
var params="filename="+$("#othername").textbox('getValue')+"&remark="+$("#othervalue").textbox('getValue');
$('#otherdgs').datagrid({method:'get',url:"guzhisas/queryConfigureInfo?" + params}).datagrid('clientPaging'); 
}

//zttype   userInfo1 
function adddatas(){
if($("#others").textbox('getValue')==""||$("#othvalue").textbox('getValue')==""){
	alert("请填写配置文件的名称和配置文件的值！");
	return false;
}else{
	var key=$("#others").textbox('getValue');
	var value = $("#othvalue").textbox('getValue');
	var remark = $("#otherlogo").textbox('getValue');
	
	$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/insertConfigureInfo", 
	        data: {key:key,value:value,remark:remark}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("操作成功");
	        	   closeDialogs();
	        	   searchdatas();
	           }else{ 
	        	   alert("操作失败");
	        	   closeDialogs();
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，操作失败");     
	        } 
	    });  
}
}
function removedatas(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择要删除的数据");
	return false;
}else{
	var id = $("input[name='ck']:checked").val();
	if(id==-1){
		alert("此条数据为自动匹配数据，不需删除");
		return false;
	}else{ 
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/deleteConfigureInfo", 
	        data: {ID:id}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("删除成功");
	        	   searchdatas();
	           }else{ 
	        	   alert("删除失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，删除失败");     
	        } 
	    });
	}
}
}


function editdatas(){
if($("input[name='ck']:checked").length!=1){
	alert("请选择1条要修改的数据");
	return false;
}else{
	var key = $("input[name='ck']:checked").closest("tr").find("td[field='key']");
	var value = $("input[name='ck']:checked").closest("tr").find("td[field='value']");
	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']");
    key.find("div").html("<input type='text' value='"+key.find("div").text()+"'></input>");
    value.find("div").html("<input type='text' value='"+value.find("div").text()+"'></input>");
   remark.find("div").html("<input type='text' value='"+remark.find("div").text()+"'></input>");
	
	//wbTd.find("div").html("<input type='text' value='"+wbTd.find("div").text()+"'></input>");
	$("table[class='datagrid-htable']").find("td[field='ck']").find("input").prop("disabled",true);
	$("input[name='ck']").prop("disabled",true);
}
}

function savedatas(){
if($("input[name='ck']:checked").length==1){
	
	var id = $("input[name='ck']:checked").val();
	
	var key = $("input[name='ck']:checked").closest("tr").find("td[field='key']").find("input").val();
	//var wbVal = $("input[name='ck']:checked").closest("tr").find("td[field='wbkmh']").find("input").val();
	var value = $("input[name='ck']:checked").closest("tr").find("td[field='value']").find("input").val();
	var remark = $("input[name='ck']:checked").closest("tr").find("td[field='remark']").find("input").val();
	
	if(value==""){
		alert("配置文件的值不能为空！");
		return false;
	}else if(typeof(key)=="undefined"){
		alert("请点击修改按钮！");
		return false;
	}else{
		$.ajax({ 
	        type: "POST", 
	        url: "guzhisas/updatConfigureInfo", 
	        data: {ID:id,key:key,value:value,remark:remark}, 
	        dataType: "json", 
	        success: function(data) {                
	           if(data.msg=="success"){
	        	   alert("修改成功");
	        	   searchdatas();
	           }else{ 
	        	   alert("修改失败");
	           }
	        }, 
	        error: function() { 
	           alert("系统异常，修改失败");     
	        } 
	    });
	}
} 
}


function closeDialogs(){
$('#others').textbox('clear');
$('#othvalue').textbox('clear');
$('#otherlogo').textbox('clear');
$('#othersdlg').dialog('close');
}

