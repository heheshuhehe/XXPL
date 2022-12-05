package com.fh.util.file;

import java.io.File;

public class FileRename {

	/**
	 * 获取字符串中的非数字字符串
	 * 
	 * @param s
	 * @return
	 */
	public static String trimToNumber(String s) {
		int n = s.length();
		char[] a = new char[n];
		int len = 0;
		for (int i = 0; i < n; i++) {
			char ch = s.charAt(i);
			if (ch >= '0' && ch <= '9') {
			} else {
				a[len++] = ch;
			}

		}
		return new String(new String(a, 0, len));
	}

	/**
	 * 判断是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		for (int i = str.length(); --i >= 0;) {
			if (!Character.isDigit(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 
	 * @param source
	 */
	static String zjzh = "";

	public static String getZJZH(String source) {

		zjzh = "";

		File file = new File(source);

		File[] files = file.listFiles();

		for (int i = 0; i < files.length; i++) {

			// 如果是目录并且不是纯数字的目录
			if (files[i].isDirectory() && !isNumeric(files[i].getName())) {

				if (files[i].getName().matches("^[0-9-0-9]+$")) {
					String zjzh = files[i].getName().substring(0,
							files[i].getName().indexOf("-"));
					return zjzh;
				} else if (files[i].getName().matches("^[0-9 0-9]+$")) {
					String zjzh = files[i].getName().substring(0,
							files[i].getName().indexOf(" "));
					return zjzh;
				} else if (files[i].getName().contains("海纳混合型1号")) {

					String zjzh = files[i].getName().substring(
							files[i].getName().indexOf("号") + 1,
							files[i].getName().length());
					return zjzh;
				}

				// 递归
				getZJZH(source + File.separator + files[i].getName());

				// 如果是目录，并且是纯数字，则为资金账号
			} else if (files[i].isDirectory() && isNumeric(files[i].getName())) {
				// 获取资金账号
				zjzh = files[i].getName();
				return zjzh;

			} else if (files[i].isFile()) {
				String sb = files[i].getName().substring(0,
						files[i].getName().indexOf("."));
				// 如果文件是纯数字，则为资金账号
				if (isNumeric(sb)) {
					zjzh = sb;
					return zjzh;
				} else if (sb.matches("^[0-9_0-9]+$")) {// 数字_数字
					zjzh = sb.substring(sb.indexOf("_") + 1, sb.length());
					return zjzh;
				} else if (sb.contains("帐单(盯市)")) { // 数字
					zjzh = sb.substring(0, sb.indexOf("帐"));
					return zjzh;
				}
			}
		}
		return zjzh;
	}

	public static void renameFileName(String source, String zjzh) {

		File file = new File(source);

		File[] files = file.listFiles();

		for (int i = 0; i < files.length; i++) {

			if (files[i].isDirectory()) {

				String source1 = source + File.separator + files[i].getName();

				renameFileName(source1, zjzh);
			} else {
				String filename = files[i].getName();

				// 如果文件名称是以四位数字开头，并且第五位不是数字，则改名称

				String ss = trimToNumber(filename);

				if (ss != null && ss.length() > 0) {

					int index = filename.indexOf(ss.substring(0, 1));

					String nfilename = filename.substring(0, index);

					if (!nfilename.equals(zjzh) && nfilename.length() != 8) {

						files[i].renameTo(new File(source + File.separator
								+ zjzh
								+ filename.substring(index, filename.length())));

					}

				}
			}

		}

	}

	/**
	 * 
	 * 如果是文件，将文件名前面的数字替换为资金账号
	 * 
	 */
	public static void changeFileName(String source) {

		System.out.println("文件夹：" + source + "的资金账号为：" + getZJZH(source));

		String zjzh = getZJZH(source);

		renameFileName(source, zjzh);

	}

	public static void main(String[] args) {
		// getZJZH("C://Users//Administrator//Desktop//2016101111//");
		// changeFileName("C://Users//Administrator//Desktop//2016101111//291300+福钥2号+20161013//");

		String source = "C://Users//Administrator//Desktop//2016101111//";

		File file = new File(source);

		File[] files = file.listFiles();

		for (int i = 0; i < files.length; i++) {

			if (files[i].isDirectory()) {

				String folder = source + File.separator + files[i].getName();

				System.out.println(folder);

				changeFileName(folder);

			}
		}
	}

}
