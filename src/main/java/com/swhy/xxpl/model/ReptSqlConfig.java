package com.swhy.xxpl.model;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException; 
import java.util.HashMap;

public class ReptSqlConfig {
    private String name ;
    private boolean isArray  ;
    private String Sql;
    private HashMap<String,String> metaMap; 
    
	public String getName() {
		return name;
	}
	public void setName(String name) { 
		this.name = name.trim();
	}
	public boolean isArray() {
		return isArray;
	}
	public void setArray(String isArray) { 
		isArray = isArray.trim(); 
		if( isArray.equals("Y") || isArray.equals("1") ) {
			this.isArray = true;
		}else {
			this.isArray = false;
		}  
	}
	public String getSql() {
		return this.Sql;
	}
	public void setSql(String sql) {
		this.Sql = sql;
	} 
	
	/**
	 * 用 variables 中的 key : value 替换 sql 中变量，变量格式为 ${key}  
	 * @param variables
	 * @return
	 */
	public String replaseSql(HashMap<String, String> variables ) { 
		String Sql = this.Sql; 
		if(variables != null ) { 
		    for ( String key :variables.keySet()) { 
	    		System.out.println("variables key is "+key );
		    	if ( key != null ) { 
		    		String value = variables.get(key); 
		    		System.out.println("variables value is "+value );
		    		if( value != null) {
		    	        Sql = Sql.replaceAll("\\$\\{"+key.trim()+"\\}", variables.get(key));  
		    		} 
		    	}
		    }
		}
		return Sql; 
	}
    
	/**
	 * 传入该语句的查询结果，获取metaData的属性 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	public HashMap<String,String> getMetaMap(ResultSet rs) throws SQLException{
		if (this.metaMap == null) {
			HashMap<String,String> metaMap = new HashMap<String,String>();
			ResultSetMetaData metadata  = rs.getMetaData();  
			int columnCount =  metadata.getColumnCount();
			for( int i =1 ; i<= columnCount ;i++ ) {
			    String columnName =  metadata.getColumnName(i).toLowerCase();  
			    String columnType =  metadata.getColumnTypeName(i); 
			    metaMap.put(columnName, columnType); 
			} 
			this.metaMap = metaMap; 
		}
		return this.metaMap ; 
	}
    
}
