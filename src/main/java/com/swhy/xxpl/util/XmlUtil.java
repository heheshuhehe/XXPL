package com.swhy.xxpl.util;

import java.io.File;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader; 
public class XmlUtil {
    
	/**
	 * 读xml 文件返回 Dom对象 
	 * @param fileName
	 * @return Document xml的Dom对象 
	 * @throws DocumentException
	 */
	public Document dom4jUpload(String fileName) throws DocumentException {
		SAXReader saxReader = new SAXReader();
		Document xmlDocument = saxReader.read(new File(fileName) );  ; 
		return  xmlDocument; 
	}
	
	
	
}
