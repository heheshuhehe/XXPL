/* 注意：该方法不能进行大量数据的查询，尽量在1W条数据以下  */
function getData(funcId) {
	getParameters(funcId);
	var dataPara = parametersMap[funcId];
	dataPara['v_first_query']='Y';
	dataPara['v_page_size']=10000;
	dataPara['v_page']= 1;
	dataPara['funcId']=funcId;
	dataPara['mathid']=Math.random();
	
	if (flag) {
		$.ajax({
			url : 'CommonDealer.do',
			type : 'post',
			data : dataPara,
			dataType : 'json',// 接受数据格式
			success : function(data) {
				var DataInfo = data[0];
				var recordsCount = DataInfo.maxSize;
				totalPages = DataInfo.tottalPages;
				
				$("#currPage_"+funcId).val(1);
				$("#totalPages_"+funcId).html(totalPages);
				
				totalPagesMap[funcId] = totalPages;
				
				var resultFlag = "true";
				
				var timeCost = 0;
				
				if ("false" == resultFlag) {
					if (undefined == pro_Info) {
						Ext.Msg.alert('查询失败', "系统正在维护请联系管理员");
					} else {
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
					var th_str = '';
					if(showCheckBox){
						th_str += '<th width="30" style="text-align:center;">'
							     +'<input type="checkbox" id="allControlBox_'+funcId+'" name="checkbox_'+funcId+'0'+'" onClick="setAllChecked(\''+funcId+'\')"  value=""/></th>';
					}else if(showRadioBox){
						th_str += '<th width="30"  style="text-align:center;"><div style="width:30px;text-align:center;"></div></th>';
					}
					if(showTrIndex){
						th_str += '<th width="30" style="text-align:center;"><div style="width:30px;text-align:center;">序号</div></th>';
					}
					
					for ( var k = 0; k < HeaderNames_zhMap[funcId].length; k++) {
						th_str += '<th width="'+HeaderNames_wdMap[funcId][k]+'"><div style="width:'+HeaderNames_wdMap[funcId][k]+'px;">'
						+ HeaderNames_zhMap[funcId][k] + '</div></th>';
					}
					var trs = '<tr>' + th_str + '</tr>';
					trs_head = trs;
					allTrDataMap[funcId] = data;
					allTrDataMap_Checked[funcId] = new Array();
					for ( var j = 1; j < data.length; j++) {
						var td_str='';
						var oneCol=data[j];
						
						if(showCheckBox){
							td_str += '<td width="30" style="text-align:center;">'
								     +'<input type="checkbox" onclick="setOneChecked(\''+funcId+'\','+j+',this)" name="checkbox_'+funcId+'" value="'+j+'"/></td>';
						} else if(showRadioBox){
							td_str += '<td width="30" style="text-align:center;"><input type="radio" onclick="dealRadioChecked(\''+funcId+'\','+j+')" name="radiobutton_'+funcId+'" value="aa"/></td>';
						}
						if(showTrIndex){
							td_str += '<td width="30" style="text-align:center;">' + j + '</td>';
						}
						
						/* 加载真实列的数据 */
						for ( var k = 0; k < HeaderNames_enMap[funcId].length; k++) {
							var key = HeaderNames_enMap[funcId][k].toLowerCase();
							td_str += '<td>' + oneCol[key] + '</td>';
						}
						
						var doubleClickStr = '';
						
						if(isNull(canDoubleClickMap[funcId])||canDoubleClickMap[funcId]){
							doubleClickStr = ' ondblclick="showTrInfo(\''+funcId+'\',this,'+j+')" ';
						}
						doubleClickStr += ' onclick="getTrInfo(\''+funcId+'\',this,'+j+')" ';
						
						trs += '<tr '+doubleClickStr+'>';
						trs += td_str;
						trs += '</tr>';
					}
					$("#data_table_content_"+funcId).html(trs);
				}

			},
			failure : function(data) {
				alert('gaga');
				window.clearInterval(print);
			}
		});
	} else {
		window.clearInterval(print);
	};
}