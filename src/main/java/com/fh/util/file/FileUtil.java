package com.fh.util.file;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

public class FileUtil {
	static String propertiesdir = "matecfg.properties";
	public static Properties pros = new Properties();
	static {
		ClassLoader cl = FileUtil.class.getClassLoader();
		try {
			pros.load(cl.getResourceAsStream(propertiesdir));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void createFolder(String str) {
		// path表示你所创建文件的路径
		String path = (String) FileUtil.pros.get(str);
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}
	}
	
	/**
	 * 创建目录
	 * 
	 * @param destDirName
	 *            目标目录名
	 * @return 目录创建成功返回true，否则返回false
	 */
	public static boolean createDir(String destDirName) {
		File dir = new File(destDirName);
		if (dir.exists()) {
			return false;
		}
		if (!destDirName.endsWith(File.separator)) {
			destDirName = destDirName + File.separator;
		}
		// 创建单个目录
		if (dir.mkdirs()) {
			return true;
		} else {
			return false;
		}
	}

	public static void main(String[] args) {
		// System.out.println(pros.get("tofilepath"));
		
		FileUtil.createFolder("fromfilepath");
		FileUtil.createFolder("toQHfilepath");
		FileUtil.createFolder("tofilepath");
	}

}
