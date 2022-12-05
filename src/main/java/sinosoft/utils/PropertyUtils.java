package sinosoft.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import org.apache.log4j.Logger;


/**
 * 获取配置文件中的设置字段
 * 
 * @author yqzhilan
 *
 */
public class PropertyUtils {
	protected static Logger logger = Logger.getLogger(PropertyUtils.class);
	 //保存系统文件。
	 private static String sysFile = "config.properties";
	 private static Properties Sysproperties ;
	 static {
		File f= new File("EW.hg");
		 System.out.println(f.getAbsolutePath());
		 Sysproperties = PropertyUtils.getProperties(sysFile);
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
			ClassLoader cl = PropertyUtils.class.getClassLoader();
			System.out.println(cl.getResource("").getPath());
			pros.load(new InputStreamReader(cl.getResourceAsStream(configPath), "UTF-8"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return pros;
	}
	
	public static String getSysConfigSet(String key){
		return Sysproperties.getProperty(key);
	}
	

}
