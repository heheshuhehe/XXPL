<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="resoures.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>excel工具</title> 
<script type="text/javascript"
	src="<%=basePath%>/modules/guzhi/exceltools.js"></script>
<!-- 
/**
 * author     : chenlin 
 * createTime : 20210331 
 * describe   : 
 *      传入两个路径 A path， B path 
 *      这两个路径都是共享盘下的文件路径，将两个文件夹下文件名相同的excel进行比较，比较内容差异。
 *      比对结果生成excel 
 */ 
 --> 
</head>
<body>
	<div id="tabsidk" class="easyui-tabs" style="">
		<div title="数据比对" style="padding: 5px">
			<span>文件目录A:</span> 
			<input class="easyui-textbox" name="compare_a_file"
				id="compare_a_file" style="width: 400px;"/>
			<p /> 
			<span>文件目录B:</span> 
			<input class="easyui-textbox" name="compare_b_file" 
			    id="compare_b_file" style="width: 400px;"/>
			<p /> 
			<input type="checkbox" name="compfile" id="compfile" value="0" /> 
			<span style="font-size: 8px;">文件差异</span> 
			<input type="checkbox" name="compsheet" id="compsheet" value="0" style="display:" /> 
			<span style="font-size: 8px; display:">页签差异</span>
			<input type="checkbox" name="comprow" id="comprow" value="0" style="display:" /> 
			<span style="font-size: 8px; display:">页签行数差异</span>
			<input type="checkbox" name="comprow" id="comprow" value="0" style="display:" /> 
			<span style="font-size: 8px; display:">行内单元格数差异</span>
			<input type="checkbox" name="comprow" id="comprow" value="0" style="display:" /> 
			<span style="font-size: 8px; display:">单元格类型差异</span>
			<input type="checkbox" name="comprow" id="comprow" value="0" style="display:" /> 
			<span style="font-size: 8px; display:">单元格数值差异</span>
			<p /> 
			<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit'" onclick="excel_comparison()">对比</a> 
			<span style="font-size: 8px; display:"></span>		
			<a href="javascript:void(0)" class="easyui-linkbutton"
					data-options="iconCls:'icon-print'" onclick="download_compar_result()">结果导出</a>
		</div>
		
		<div title="sheet页签替换" style="padding: 5px">
			<span>基础文件目录:</span> 
			<input class="easyui-textbox" name="replace_old_file"
				id="replace_old_file" style="width: 400px;"/>
			<p /> 
			<span>替换数据目录:</span> 
			<input class="easyui-textbox" name="replace_sub_file" 
			    id="replace_sub_file" style="width: 400px;"/>
			<p /> 
			<span>替换结果目录:</span> 
			<input class="easyui-textbox" name="replace_new_file" 
			    id="replace_new_file" style="width: 400px;"/> 
			<p />  
			<div name="replace_sheets"  id= "replace_sheets">  
			         <input  class="easyui-textbox" name="sheet1" id="sheet1" style="width: 400px;"/>  
			         <p/>       
			</div>   
  
			<p />   
			<span id="test"> test </span> 
		    <p />   
			<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-add'" onclick ="replace_add_sheet()"/> 
			<span style="font-size: 8px; display:">新增替换页签</a>
			</span>	
			<p />   
			<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit'" onclick="excel_replase()">替换</a> 
			<span style="font-size: 8px; display:"></span>	 	 
		</div>
	</div>
</body>
</html>