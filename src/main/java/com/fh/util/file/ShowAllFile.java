package com.fh.util.file;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

public class ShowAllFile {
	private static Logger logger = Logger.getLogger(ShowAllFile.class);

	/*
	 * 通过递归得到某一路径下所有的目录及其文件
	 */
	List<String> list = new ArrayList<String>();
	List<String> list1 = new ArrayList<String>();
	List<String> list2 = new ArrayList<String>();
	List<String> list3 = new ArrayList<String>();

	// 获取交易所的文件
	public List<String> getFiles(String filePath, List<String> folders) {

		File root = new File(filePath);
		File[] files = root.listFiles();
		for (File file : files) {

			boolean f = false;

			if (file.isDirectory()) {

				f = false;

				for (int i = 0; i < folders.size(); i++) {

					if (file.getName().equals(folders.get(i))) {
						f = true;
					}
				}

				/*
				 * 递归调用
				 */
				if (f) {
					getFiles(file.getAbsolutePath(), folders);
				}
			} else {
				for (int i = 0; i < folders.size(); i++) {

					if (file.getAbsolutePath().contains(
							File.separator + folders.get(i) + File.separator)) {
						list.add(file.getAbsolutePath());
					}
				}
			}
		}
		logger.info("交易所文件夹：" + list.toString());

		return list;
	}

	/**
	 * 获取所有的文件
	 * 
	 * @param filePath
	 * @return
	 */
	public List<String> getFiles1(String filePath) {
		File root = new File(filePath);
		File[] files = root.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {

				/*
				 * 递归调用
				 */
				getFiles1(file.getAbsolutePath());
			} else {
				list1.add(file.getAbsolutePath());
			}
		}
		// System.out.println("@@@@@@@@@@@@@@@@@@@@@@@" + list.size());
		return list1;
	}

	// 获取期货的文件
	public List<String> getFiles2(String filePath, List<String> folders) {
		File root = new File(filePath);
		File[] files = root.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {

				boolean f = false;
				// List<String> folders = null;
				//
				// if (FileMove.zxrq == null || "".equals(FileMove.zxrq)) {
				// folders = FengeStr.foldernameSplit();
				// } else {
				// folders = FengeStr.foldernameSplit(FileMove.zxrq);
				// }

				for (int i = 0; i < folders.size(); i++) {

					if (file.getName().equals(folders.get(i))) {
						f = true;
					}
				}
				/*
				 * 递归调用
				 */
				if (!f) {
					getFiles2(file.getAbsolutePath(), folders);
				}
			} else {
				list2.add(file.getAbsolutePath());
			}
		}
		return list2;
	}

	// 获取期货的文件夹
	public List<String> getQHFolder(String filePath, List<String> folders) {

		File root = new File(filePath);

		File[] files = root.listFiles();

		for (File file : files) {

			if (file.isDirectory()) {

				boolean f = false;

				for (int i = 0; i < folders.size(); i++) {

					if (file.getName().equals(folders.get(i))) {
						f = true;
					}
				}
				/*
				 * 递归调用
				 */
				if (!f) {
					list3.add(file.getAbsolutePath());
				}
			}
		}
		return list3;
	}

	// public static void main(String[] args) {
	// new ShowAllFile().getFiles("cpxx0923.txt");
	// }

}
