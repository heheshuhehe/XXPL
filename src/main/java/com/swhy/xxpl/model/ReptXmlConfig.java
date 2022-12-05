package com.swhy.xxpl.model;

import java.util.HashMap;
import java.util.Iterator;

import org.dom4j.Attribute;
import org.dom4j.Document; 
import org.dom4j.Element;

import com.swhy.xxpl.util.XmlUtil;

public class ReptXmlConfig {
	
	public static HashMap<String , ReptSqlConfig> readXml(String fileName) throws Exception{
		HashMap<String, ReptSqlConfig> reptMap = new HashMap<String, ReptSqlConfig>();
		
		XmlUtil xmlutil = new XmlUtil();
		Document domxml = xmlutil.dom4jUpload( fileName );

		Element root = domxml.getRootElement();

		// 取所有的sql节点
		for (Iterator ie = root.elementIterator(); ie.hasNext();) {
			Element element = (Element) ie.next();
			// System.out.println(element.getName());
			String elentkey = element.getName();
			if (elentkey.equals("sql")) {
				ReptSqlConfig reptSqlConfig = new ReptSqlConfig(); 
				// 枚举属性 
				String name = null ;  
				String isArray = null ; 
				
				for (Iterator ia = element.attributeIterator(); ia.hasNext();) {
					Attribute attribute = (Attribute) ia.next();
					String attrbuteName = attribute.getName(); 
					// System.out.println(attrbuteName);
					if (attrbuteName.equals("name")) { 
						name = attribute.getData().toString();
					} else if (attrbuteName.equals("isArray")) {
						isArray = attribute.getData().toString(); 
					}
				}

				System.out.println( "sql name -- " + name );
				if(name != null) {
				    reptSqlConfig.setName(name);
				} 
				
				System.out.println( "sql resultset is Array -- " + isArray );
				if(isArray != null) {
					reptSqlConfig.setArray(isArray);  
				} 
				
				String sql = element.getText();  
				System.out.println( "sql text -- " + sql );
				if(sql != null) {
					reptSqlConfig.setSql(sql); 
				}   
				reptMap.put( name , reptSqlConfig);
			} 
		} 
		return reptMap; 
	} 
	 
}
