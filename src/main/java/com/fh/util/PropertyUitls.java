package com.fh.util;
 
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 读取配置文件通用类
 * 
 * @author YqZhilan
 *
 */
public class PropertyUitls {
	protected static Logger logger = Logger.getLogger(PropertyUitls.class);
	 //保存系统文件。
	 private static String sysFile = "config.properties";
	 private static Properties Sysproperties ;
	 static {
		 Sysproperties = PropertyUitls.getProperties(sysFile);
	 }
	
	/**
	 * 获取指定路径下的配置文件信息
	 * 
	 * @param configPath
	 * @return
	 */
	public static Properties getProperties(String configPath) {
		Properties pros = new Properties();
		try {
			ClassLoader cl = PropertyUitls.class.getClassLoader();
			pros.load(new InputStreamReader(cl.getResourceAsStream(configPath), "UTF-8"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return pros;
	}
	
	public static String getSysConfigSet(String key){
		return Sysproperties.getProperty(key);
	}
	/**
	 * 获取当前系统
	 * PROD: 生产
	 * TOUCHAN:投产环境
	 * UAT: uat环境
	 * LOCAL:local
	 * @return
	 */
	public static String getSystemEnvironmentMark(){
		return getProperties("config.properties").getProperty("SYSTEMENVIRONMENTMARK");
	}
 
}
