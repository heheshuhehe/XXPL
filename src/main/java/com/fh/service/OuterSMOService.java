package com.fh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.fh.util.PropertyUitls;
import com.swhy.xxpl.model.ReptCreateJson4Xml;
import com.swhy.xxpl.model.ReptSqlConfig;
import com.swhy.xxpl.model.ReptXmlConfig;

@Service("xinxiPiLuSMOService")
public class OuterSMOService {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "reptCreateJson4Xml")
	ReptCreateJson4Xml reptCreateJson4Xml; 
 
	// features 
	@Resource(name = "datasourceXXPLHDMDS") 
	DataSource datasourceXXPLHDMDS ;  
	public OuterSMOService() {
		// TODO Auto-generated constructor stub
	}

	public String createJson( List<Map<String,String>> funds ) throws Exception {
		String xmlFileName = PropertyUitls.getProperties("config.properties")
				.getProperty("SMOXMLPATH");
		String jsonFilePath = PropertyUitls.getProperties("config.properties")
				.getProperty("TEMPJSONFILEPATH");
//		String xmlFileName = "Y:/系统专用/信息披露/模板/规模以上运行表/规模以上运行表.xml"; 
		logger.info("create json files service" ); 
		
		// 读 xml 配置 
//		ReptXmlConfig reptXmlConfig = new ReptXmlConfig();
		HashMap<String , ReptSqlConfig>  readXml = ReptXmlConfig.readXml(xmlFileName); 
	    System.out.println("sql info for xml --- "+ readXml.toString());
		int all_num = 0; 
		int err_num = 0; 
		// for (Map<String,String> fund: funds2) {
		for (Map<String,String> fund: funds) {
			all_num = all_num + 1; 
		    HashMap<String, String> variables = new HashMap<String, String>();
		    String date_no = fund.get("date_no"); 
//		    String fund_code = fund.get("fund_code"); 
		    String magr_p_code = fund.get("magr_p_code");
		    String magr_no = fund.get("magr_no"); 

		    // 几个个必须传入的参数 
		    variables.put("date_no", date_no );       
//		    variables.put("fund_code", fund_code); 
		    variables.put("magr_p_code", magr_p_code); 
		    variables.put("magr_no", magr_no); 

		    variables.put("rept_type", "SMO");  // ReptFeatures 根据这个参数选择获取不同的 features 
		    boolean flag = reptCreateJson4Xml.create(readXml , variables ); 
		     
		    if(!flag) {
		    	err_num = err_num + 1; 
		    } 
		} 
		String msg = "create json task "+all_num+",err number is "+err_num;   
		System.out.println(msg); 
		return msg ;
	}
	
}
