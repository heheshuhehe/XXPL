package com.fh.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.dao.XinxipiluDao;
import com.fh.util.DaoUtil;
import com.fh.util.PageData;
import com.fh.util.file.FileUtil;
import com.google.gson.JsonArray;
import com.swhy.xxpl.model.ReptCreateJson4Xml;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptMFundInfo;
import com.swhy.xxpl.model.ReptMNetVal;
import com.swhy.xxpl.model.ReptSqlConfig;
import com.swhy.xxpl.model.ReptXmlConfig;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_info;
import com.swhy.xxpl.model.jibao.Rept_Q_ast_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_fin_indx;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_shr_chg;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_hkcsivsm_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_hkcsivsm_grp_dtl;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_stkivsm_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_magr_rept;
import com.swhy.xxpl.model.jibao.Rept_Q_net_val;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.DefaultDefaultValueProcessor;
import net.sf.json.util.CycleDetectionStrategy;

/**
 * @author 230355 信息披露季度更新service层
 *
 */
@Service("xinxiPiLuNianBaoService")
public class XinxiPiLuNianBaoService {
	protected Logger logger = Logger.getLogger(this.getClass());

	@Resource(name = "reptCreateJson4Xml")
	ReptCreateJson4Xml reptCreateJson4Xml; 
 
	// features 
	@Resource(name = "datasourceXXPLHDMDS") 
	DataSource datasourceXXPLHDMDS ;  
	
	
	public String createJson( List<Map<String,String>> funds ) throws Exception {
		String xmlFileName = "Y:/系统专用/信息披露/模板/年报/证券类年报.xml"; 
		String jsonFilePath = "D:/temp/证券类年报/"; 
		logger.info("create json files service" ); 
        
//		List<Map<String,String>> funds2 = new ArrayList<Map<String,String>>(); 
//		String sql = "select  fund_code , fund_name , serv_scop\r\n"
//				+ "from rept_disc_data_stat \r\n"
//				+ "where date_no = '2021' \r\n"
//				+ "and INFO_DISC_TYPE_CODE = 'Y' \r\n"
//				+ "and INFO_DISC_SUB_TYPE_CODE = 'YSE' "; 
//		Connection conn = datasourceXXPLHDMDS.getConnection();
//		Statement s = conn.createStatement();
//		ResultSet rs = s.executeQuery(sql);
//		while(rs.next()) {
//			Map<String,String> fund = new HashMap<String,String>(); 
//			fund.put("date_no","2021");
//			fund.put("fund_code",rs.getString("fund_code"));
//			funds2.add(fund); 
//		}
//		DaoUtil.release(conn); 
		
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
		    String fund_code = fund.get("fund_code"); 
		    // 三个必须传入的参数 
		    variables.put("date_no", date_no );       
		    variables.put("fund_code", fund_code); 
		    variables.put("rept_type", "YSE");  // ReptFeatures 根据这个参数选择获取不同的 features 
		    boolean flag = reptCreateJson4Xml.create(readXml , variables ); 
		     
		    if(!flag) {
		    	err_num = err_num + 1; 
		    } 
		} 
		String msg = "create json task "+all_num+",err number is "+err_num;   
		System.out.println(msg); 
		return msg ;
	}
	

	@Test
	public void testFunction(/* PageData pd, String sort, String order */) throws IOException, Exception {
		ReptCreateJson4Xml reptCreateJson4Xml;   
		
	} 
}
