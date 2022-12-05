package com.fh.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.dao.OuterJiBaoXinXiPiLuDao;
import com.fh.dao.OuterJiDuGengXinXXPLDao;
import com.fh.dao.OuterXinXiPiLuDao;
import com.fh.dao.XinxipiluDao;
import com.fh.util.ExcelReaderFor2007;
import com.fh.util.PageData;
import com.fh.util.reportService.com.swhy.report.ReportApp;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("utilityService")
public class UtilityService {
	protected Logger logger = Logger.getLogger(this.getClass());

	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	@Resource(name = "outerXinXinPiLuDao") 			//及贝克一般数据以及月报推送
	OuterXinXiPiLuDao outerXinXinPiLuDao ;  
	
	@Resource(name = "outerJiBaoXinXiPiLuDao") 		//吉贝克一般季报推送
	OuterJiBaoXinXiPiLuDao outerJiBaoXinXiPiLuDao ;  
	
    @Resource(name="XinXiPiLuYueBaoServiceNew")
    XinXiPiLuYueBaoServiceNew yueBaoS;
    
	public UtilityService() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 打印清单excel，
	 * @param json
	 * @return 文件路径
	 * @throws IOException 
	 */
	@SuppressWarnings("unchecked")
	synchronized public String printReptDiscSitu(List<Map<String, Object>> reptDiscSitu) throws IOException {
		JSONObject main = new JSONObject();
//		for(int i=0; i<reptDiscSitu.size();i++) {
//			String fundNumString = String.valueOf(reptDiscSitu.get(i).get("fund_num"));
//			reptDiscSitu.get(i).put("fund_num",  fundNumString.substring(fundNumString.length()-10, fundNumString.length()-5));
//		}
		for (Map<String, Object> rds: reptDiscSitu) {
			String fundNumString = String.valueOf(rds.get("fund_num")) ;
			rds.put("fund_num",  fundNumString.substring(fundNumString.length()-10, fundNumString.length()-5));
		}
		JSONArray reptDiscSitujson =  JSONArray.fromObject(reptDiscSitu);

		main.put("rept_disc_situ", reptDiscSitujson);
		Map<String,String> features = new  HashedMap();
		
//		String modelFilePath = pathsMap.get("tgzx_disk_drive").toString()+pathsMap.get("monthly_report_model_path").toString()+"\\";
		features.putIfAbsent("excel_tpl_path", "L:/系统专用/信息披露/模板/rept_disc_situ.xlsx");		//分级基金使用特殊模板
		features.putIfAbsent("excel_path", "L:/系统专用/信息披露/模板/rept_disc_situ_temp.xlsx");
		features.putIfAbsent("watermark", "test");
//		features.putIfAbsent("sign_pdf", "true".equals(pathsMap.get("monthly_report_sign_pdf"))?true:false );
//		features.putIfAbsent("sign_x", (Integer.valueOf(pathsMap.get("monthly_sign_X").toString()) ));
//		features.putIfAbsent("sign_y", (Integer.valueOf(pathsMap.get("monthly_sign_Y").toString()) ));
		features.putIfAbsent("sign_page", "0");
		
		main.put("features", JSONObject.fromObject(features));
		yueBaoS.printingJSONtoFolder(main, "L:/系统专用/信息披露/模板/rept_disc_situ_temp.json");
//		logger.info(main.toString());
		String[] argument = {"L:/系统专用/信息披露/模板/rept_disc_situ_temp.json"};
//		String excelFileName=magr_num+"_"+magr_name+"-规模以上证券类管理人运行报表_"+date_no+".xlsx";
		ReportApp.start(argument);
		
		return "L:/系统专用/信息披露/模板/rept_disc_situ_temp.xlsx";
	}


	

}
