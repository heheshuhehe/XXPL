package com.fh.util.file;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.GZIPInputStream;

public class TestFileDown {
	private static void ungz(String sourceGz, String destDir) {
		GZIPInputStream gzi;
		try {
			gzi = new GZIPInputStream(new FileInputStream(sourceGz));
			int to = sourceGz.lastIndexOf('.');
			if (to == -1) {
				System.out.println("usage:  java expandgz  filename.gz");
				System.exit(0);
			}
			String newdestDir = sourceGz.substring(0, to);
			// String newdestDir=destDir.substring(0,
			// destDir.toString().lastIndexOf("."));
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(destDir+"/"+newdestDir.substring(newdestDir.lastIndexOf("\\")+1, newdestDir.length())));
			System.out.println("writing " + newdestDir);

			int b;
			do {
				b = gzi.read();
				if (b == -1)
					break;
				bos.write(b);
			} while (true);
			gzi.close();
			bos.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void deCompress(String sourceFile, String destDir)
			throws Exception {

		File file = new File(sourceFile);
		File[] files = file.listFiles();
		// 保证文件夹路径最后是"/"或者"\"
		for (int i = 0; i < files.length; i++) {
			// String filepath = fileCode(files[i].toString());
			char lastChar = destDir.charAt(destDir.length() - 1);
			if (lastChar != '/' && lastChar != '\\') {
				destDir += File.separator;
				// System.out.println(destDir);
				System.out.println();
			}
			String filepath = files[i].toString();

			if (files[i].isDirectory()) {
				String[] strs = filepath.split("\\\\");
				String thisPaths = strs[strs.length - 1];
				File s = new File(destDir + "\\" + thisPaths);
				String newspath = destDir + "\\" + thisPaths;
				System.out.println(s + "....." + thisPaths);
				s.mkdir();
				deCompress(filepath, newspath);
			}

			// 根据类型，进行相应的解压缩
			String type = filepath.substring(filepath.lastIndexOf(".") + 1);

			if (type.equals("gz")) {
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().indexOf("."));
				File s = new File(destDir + "\\" + newthisPath);
				s.mkdir();
				TestFileDown.ungz(files[i].getAbsolutePath(), destDir + "\\"
						+ newthisPath);
				deCompress(destDir + "\\" + newthisPath, destDir + "\\"
						+ newthisPath);
				//
			}

		}
	}


	public static void main(String[] args) {
		try {
			deCompress("C://Users//Administrator//Desktop//20160923",
					"C://Users//Administrator//Desktop//20160924//");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
