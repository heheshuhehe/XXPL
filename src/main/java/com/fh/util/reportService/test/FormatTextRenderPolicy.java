package com.fh.util.reportService.test;

import java.util.HashMap;
import java.util.Map;

import com.fh.util.reportService.com.swhy.report.ReportHelper;
  


public class FormatTextRenderPolicy {
	
	public static void main(String[] args) { 
    	Map<String, Object> jsonMap = new HashMap<String ,Object>();
    	jsonMap.put("test", 23456789.00);

        /**
         * 根据docx模板生成响应的docx文件（无水印或固定水印）
         * @param jsonMap 数据json映射对象实例
         * @param templatePath docx模板文件路径
         * @param docxPath 输出docx结果文件路径
         * @throws Exception 
         */
		try {
			ReportHelper.createDocx(jsonMap, "C:\\Users\\chenlin\\Desktop\\新建 DOCX 文档.docx", "C:\\Users\\chenlin\\Desktop\\新建 DOCX 文档2.docx");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
