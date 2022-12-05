package com.swhy.xxpl.model;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.fh.util.DaoUtil;
 

@Repository("reptFeatures")   
public class ReptFeatures {
	protected Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name = "datasourceXXPLHDMDS") 
	DataSource datasourceXXPLHDMDS ;  
	
	/**
	 * 获取 一个产品Json中的 features 
	 * @param String date_no
	 * @param String fund_code 
	 * @return (JSONObject)features 
	 */
	public HashMap<String, Object> getFeatures( String date_no , String fund_code , String type) {
		//证券类年报 
		if(type.equals("YSE")) {
			// S66759_双安誉信宏观对冲5号基金_年报(证券投资类)_202001_20201231.xlsx  
			String data_path = "Y:/系统专用/信息披露/年报/"+date_no+"/";  
			String sql =  "select  \r\n"
			+ "           fund_code \r\n"
			+ "         , fund_name \r\n"
			+ "         , fund_num  \r\n"
			+ "         , to_char(busi_date , 'yyyymmdd') busi_date \r\n"
			+ "         , serv_scop \r\n"
			+ "from rept_disc_data_stat \r\n"
			+ "where date_no = '"+date_no+"' \r\n"
			+ "and  INFO_DISC_TYPE_CODE = 'Y' "
			+ "and  fund_code = '"+fund_code+"' " ; 
			
			String fund_name = null;
			String fund_num = null;
			String busi_date = null;
			String serv_scop = null;
			
			Connection conn;
			try {
				conn = datasourceXXPLHDMDS.getConnection();

				Statement stat = conn.createStatement();
				ResultSet rs = stat.executeQuery(sql); 
				if(rs.next()) {
					fund_name = rs.getString("fund_name"); 
					fund_num  = rs.getString("fund_num"); 
					busi_date = rs.getString("busi_date"); 
					serv_scop = rs.getString("serv_scop"); 
				}
				
				if (fund_name == null) {
					return null; 
				}
				String watermark = fund_name; 
				
				String excel_tpl_path  = "Y:/系统专用/信息披露/模板/年报/证券类年报模板.xlsx"; 
				String docx_tpl_path   = "Y:/系统专用/信息披露/模板/年报/证券类年报模板.docx"; 
				 
				String json_path  = data_path+serv_scop+"/json/"+ fund_code+".json" ;  
				// S66759_双安誉信宏观对冲5号基金_年报(证券投资类)_202001_20201231.xlsx 
				String excel_path  = data_path+serv_scop+"/"+fund_num +"_"+fund_name+"_年报(证券投资类)_"+date_no+"01_"+busi_date+".xlsx"; 
				String docx_path   = data_path+serv_scop+"/"+fund_num +"_"+fund_name+"_年报(证券投资类)_"+date_no+"01_"+busi_date+".docx";  
				String pdf_path    = data_path+serv_scop+"/"+fund_num +"_"+fund_name+"_年报(证券投资类)_"+date_no+"01_"+busi_date+".pdf"; 
				
				boolean sign_pdf = true; 
				int sign_page = 0  ;
				int sign_x    = 440 ; 
				int sign_y    = 630 ;  
				HashMap<String, Object> features = new HashMap<String, Object>();
				features.put("watermark", watermark); 
				features.put("excel_tpl_path", excel_tpl_path); 
				features.put("docx_tpl_path", docx_tpl_path); 
				
				features.put("json_path", json_path); 
				features.put("excel_path", excel_path); 
				features.put("docx_path", docx_path); 
				features.put("pdf_path", pdf_path); 
				
				features.put("sign_pdf", sign_pdf);   
				features.put("sign_page", sign_page);   
				features.put("sign_x", sign_x);   
				features.put("sign_y", sign_y);   
				return features ; 
			} catch (SQLException e) {
				// TODO Auto-generated catch block 
				logger.error(e.getMessage(), e) ; 
				return null; 
			}finally {
				DaoUtil.release(datasourceXXPLHDMDS);  
			}  
		}else {
			logger.info("未知的新批报告类型") ; 
			return null; 
		}  
	}
}
