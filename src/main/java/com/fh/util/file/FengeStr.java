package com.fh.util.file;

import java.util.ArrayList;
import java.util.List;

public class FengeStr {
	// private static Logger logger = Logger.getLogger(FileMove.class);

	public static String[] StrSplit(String filename) {
		// String filename = FileUtil.pros.getProperty("filename");
		String[] files = filename.split(",");
		return files;
	}

	public static List<String> foldernameSplit(String foldername, String newdate) {

		List<String> list = new ArrayList<String>();

		// String foldername = FileUtil.pros.getProperty("foldername");

		String[] foldernames = foldername.split(",");

		for (int i = 0; i < foldernames.length; i++) {
			// if (foldernames[i].endsWith("@")) {
			// list.add(foldernames[i].substring(0,
			// foldernames[i].length() - 1) + day);
			// }
			if (foldernames[i].contains("YYYYMMDD")) {
				list.add(foldernames[i].replace("YYYYMMDD", newdate));
			} else {
				list.add(foldernames[i]);
			}
		}
		// logger.info("交易所文件夹：" + list.toString());
		return list;
	}

	public static List<String> foldernameSplit(String str, String foldername,
			String newdate) {

		List<String> list = new ArrayList<String>();

		// String foldername = FileUtil.pros.getProperty("foldername");

		String[] foldernames = foldername.split(",");

		for (int i = 0; i < foldernames.length; i++) {
			// if (foldernames[i].endsWith("@")) {
			// list.add(foldernames[i].substring(0,
			// foldernames[i].length() - 1) + "20160923");
			// }
			if (foldernames[i].contains("YYYYMMDD")) {
				list.add(foldernames[i].replace("YYYYMMDD", newdate));
			} else {
				list.add(foldernames[i]);
			}
		}
		// logger.info("交易所文件夹：" + list.toString());
		return list;
	}

}
