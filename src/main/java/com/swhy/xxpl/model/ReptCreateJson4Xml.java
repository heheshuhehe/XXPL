package com.swhy.xxpl.model;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
 
import com.fh.service.XinXiPiLuService;
import com.fh.util.DaoUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.DefaultDefaultValueProcessor;
import net.sf.json.util.CycleDetectionStrategy;
import oracle.sql.CLOB;
 
/** 
 * @author chenlin 
 * 变量中必须带的参数 ，需要更加这些参数加工 featuers 
 * variables.put("date_no","2021");  
 * variables.put("fund_code","1233");  
 * variables.put("rept_type","YSE");   
 * YSE 	： 	证券类年报 
 * M	:	月报
 * ReptCreateJson4Xml.create(HashMap<String , ReptSqlConfig> readXml , HashMap<String, String> variables)  
 */
@Repository("reptCreateJson4Xml") 
public class ReptCreateJson4Xml {
	protected Logger logger = Logger.getLogger(this.getClass()); 

	@Resource(name = "datasourceXXPLHDMDS") 
	DataSource datasourceXXPLHDMDS ;  
	
	@Resource(name = "XinXiPiLuService") 
	XinXiPiLuService xinXiPiLuService ;
	
	// @Resource(name = "reptFeatures") 
	// ReptFeatures reptFeatures ;  
	
	public boolean create( HashMap<String , ReptSqlConfig> readXml , HashMap<String, String> variables) {
		return create(readXml, variables,null,null);
	} 
	
	/**
	 * 
	 * @param readXml
	 * @param variables
	 * @return
	 */
	public boolean create( HashMap<String , ReptSqlConfig> readXml , HashMap<String, String> variables, Map<String, String> featuresMap, Connection conn) { 
		logger.info("create json files ReptCreateJson4Xml" ); 
		// 循环执行sql读取数据 
		// 数据库返回结果集生成json
		JSONObject jsonObject = new JSONObject(); 
		try { 
			System.out.println("sql config  --- "+readXml.keySet().toString()); 
			if (conn == null) conn =datasourceXXPLHDMDS.getConnection();
			for (String key : readXml.keySet()) {
				ReptSqlConfig sqlConfig = readXml.get(key);
				
				String name = sqlConfig.getName();
				System.out.println("sql config name --- "+name); 
				
				boolean isArray = sqlConfig.isArray();
				System.out.println("sql config isArray  --- "+isArray);  
				
				String Sql = sqlConfig.replaseSql(variables);  
				System.out.println("sql config Sql text --- "+Sql);

				Statement stat = conn.createStatement(); 
				ResultSet rs = stat.executeQuery(Sql); 
				HashMap<String, String> metaMap = sqlConfig.getMetaMap(rs); 
				
				int cont = 0; 
				JSONArray  _jsonA = null; 
				JSONObject _jsonO = null; 
				if (isArray) {
				    _jsonA = new JSONArray();  
				} 
				while(rs.next()) { 
					_jsonO = new JSONObject();
					cont = cont++; 
					// 返回结果集不是数组
					if (cont > 1 && !isArray ) { 
						break; 
					}  
					for( String colname:metaMap.keySet()) {
						String colnType = metaMap.get(colname); 
						// System.out.println(colname); 
						// System.out.println(colnType);   
						if(colnType.equals("VARCHAR2") ||colnType.equals("VARCHAR") || colnType.equals("CHAR") || colnType.equals("CHAR2")  ) {
							// System.out.println(rs.getString(colname));
							if (name.equals( "features") && colname .equals( "sign_pdf") ) {
								_jsonO.put(colname , 
										          (rs.getString(colname).equals("Y")|| rs.getString(colname).equals("1"))?true:false 
										  ) ; 
							}else { 
								_jsonO.put(colname, rs.getString(colname)); 
							}
							
						}else if(colnType.equals("NUMBER")) {
							//System.out.println(rs.getBigDecimal(colname));
							_jsonO.put(colname, rs.getBigDecimal(colname));  
						}else if(colnType.equals("CLOB")) {
							CLOB c = (oracle.sql.CLOB)rs.getClob(colname);   
							String value = "";
							if ( c != null) {
								value = c.getSubString(1, (int)c.length()); 
							} 
							_jsonO.put(colname, value);  
						}else if(colnType.equals("DATE")) {
							// System.out.println(rs.getString(colname));   
							_jsonO.put(colname, rs.getString(colname)); 
						} 
					} 
					if (isArray ) { 
						_jsonA.add(_jsonO);  
					} 
					 
				} 

				if (isArray ) { 
					jsonObject.put(name , _jsonA);  
				} else {
					jsonObject.put(name , _jsonO );   
				} 
			} 
			System.out.println("Json --- "+jsonObject.toString());
			
			// HashMap<String, Object> features = reptFeatures.getFeatures(variables.get("date_no"), variables.get("fund_code"), variables.get("rept_type")); 
	    	// jsonObject.put("featuers", JSONObject.fromObject(features)); 
	    	
			JSONObject features = jsonObject.getJSONObject("features");  
			if( features.isNullObject() && featuresMap==null) { 
	    		logger.error("未获取到 features ！, 不生成该json!"); 
	    		return false; 
	    	}  
			String jsonUrl ="";
	    	if (!features.isNullObject()) {jsonUrl = features.getString("json_path") ;}
	    	else {jsonObject.put("features", featuresMap);}
	    	System.out.println("json_path --- "+jsonUrl );

			xinXiPiLuService.printingJSONtoFolder(jsonObject, jsonUrl ); 
			DaoUtil.release(conn);
			return true; 
		}catch(Exception e) { 
			logger.error(e.getMessage(), e); 
			return false; 
		} finally {
			DaoUtil.release(conn);
		}
	}   
	
}
