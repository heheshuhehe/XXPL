package com.fh.util.file;

import java.io.File;
import java.io.IOException;

public class CreateFile {
	public static void main(String[] args) {

		// path表示你所创建文件的路径
		String path = (String) FileUtil.pros.get("tofilepath");
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}
		// fileName表示你创建的文件名；为txt类型；
		String fileName = (String) FileUtil.pros.get("filename");
		File file = new File(f, fileName);
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
