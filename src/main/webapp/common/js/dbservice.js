function doIDUQ(parametersMap){
	var data_;
	parametersMap['sssssid']=Math.random();
	$.ajax({
		url : '../../public.asp',
		type : 'post',
		data : parametersMap, //要发送的数据
		dataType : 'json',// 接受数据格式
		async: false,
		success : function(data) {//data为返回的数据，这里做数据绑定
			data_ = data;
		},
		failure : function(data) {
			alert("接口调取错误！");
			data_ = data;
		}
	});
	return data_ ;
}
function doIDUQ$refresh(){
	
}

function initOptions(optionId,parametersMap){
	parametersMap['sssssid']=Math.random();
	var data = doIDUQ(parametersMap);
	$("#"+optionId).empty();
	$("#"+optionId).append($('<option value="">--请选择--</option>'));
	for(var i=1;i<data.length;i++){
		var option="<option value='"+data[i]['id']+"'>"+data[i]['name']+"</option>";
		var $option=$(option);
		$("#"+optionId).append($option);
	}
}



