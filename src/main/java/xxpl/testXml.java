package xxpl;

import java.util.HashMap;
import java.util.Iterator;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.springframework.context.support.ClassPathXmlApplicationContext;
 
import com.swhy.xxpl.model.ReptCreateJson4Xml;
import com.swhy.xxpl.model.ReptSqlConfig;
import com.swhy.xxpl.model.ReptXmlConfig;
import com.swhy.xxpl.util.XmlUtil;

import org.junit.Test;

public class testXml {

	@Test 
	public static void main(String[] args) throws Exception {
//		XmlUtil xmlutil = new XmlUtil();
//		try {
//			Document domxml =  xmlutil.dom4jUpload("Y:/系统专用/信息披露/模板/年报/年报sql.xml"); 
//			
//			Element root = domxml.getRootElement(); 
//			
//			// 枚举根节点下所有子节点
//	        for (Iterator ie = root.elementIterator(); ie.hasNext();) {
//	            System.out.println("======");
//	            Element element = (Element) ie.next();
//	            System.out.println(element.getName());
//                
//	            // 枚举属性
//	            for (Iterator ia = element.attributeIterator(); ia.hasNext();) {
//	                Attribute attribute = (Attribute) ia.next();
//	                System.out.println(attribute.getName() + ":"
//	                        + attribute.getData());
//	            }
//	            
//	            System.out.println(element.getText());
//	            
//	        }
//	        
//		} catch (DocumentException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}	
//		 
		  
    	
//		ReptXmlConfig reptXmlConfig = new ReptXmlConfig();
//		try {
//			
//			HashMap<String , ReptSqlConfig> readXml = reptXmlConfig.readXml("Y:/系统专用/信息披露/模板/年报/年报sql.xml");
//			HashMap<String, String> variables = new HashMap<String, String>();
//			variables.put("date_no", "2021");
//			variables.put("fund_code", "105"); 
//			for(String key : readXml.keySet() ) { 
//				
//				ReptSqlConfig sqlConfig = readXml.get(key);
//				System.out.println("name    = " + sqlConfig.getName());
//				System.out.println("isArray = " + sqlConfig.isArray());
//				System.out.println("SqlOri  = " + sqlConfig.getSql());
//				System.out.println("Sqlexce = " + sqlConfig.replaseSql(variables));
//				
//			}
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} 
		// ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("D:/workspace/Eclipse/maven-guzhi/bin/src/main/resources/spring/ApplicationContext-mvc.xml"); 

		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("classpath:bin/src/main/resources/spring/ApplicationContext-mvc.xml"); 

		//ClassPathXmlApplicationContext classPathXmlApplicationContext = new ClassPathXmlApplicationContext("classpath:spring-configs.xml");
		//1.从邮件表复制文件到指定目录
		ReptCreateJson4Xml reptXmlConfig = (ReptCreateJson4Xml)context.getBean("reptCreateJson4Xml");
		//reptXmlConfig.analysisXml("Y:/系统专用/信息披露/模板/年报/年报sql.xml"); 

		HashMap<String, String> variables = new HashMap<String, String>();
		variables.put("date_no", "2021");
		variables.put("fund_code", "105"); 
		//reptXmlConfig.create("D:/年报/105.xml", variables);  
		
	}
	
}
