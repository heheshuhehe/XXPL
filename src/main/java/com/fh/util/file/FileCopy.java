package com.fh.util.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class FileCopy {
	/*
	 * 文件拷贝
	 */
	public static void Copy(String from, String to) throws Exception {
		FileInputStream fis = new FileInputStream(from);
		BufferedInputStream bufferedInputStream = new BufferedInputStream(fis);
		FileOutputStream fos = new FileOutputStream(to);
		BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(
				fos);
		int len = 0;
		while ((len = bufferedInputStream.read()) != -1) {
			bufferedOutputStream.write(len);
		}
		bufferedOutputStream.close();
		bufferedInputStream.close();
	}

	// public static void main(String[] args) throws Exception {
	// Copy("C://Users//hysec//Desktop//workdemo//20160923//291300+福钥2号+20160923//291300+福钥2号+20160923//291300.txt",
	// "C://Users//hysec//Desktop//20160923//291300.txt");
	// }
}
