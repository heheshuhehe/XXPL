package com.fh.util.file;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.zip.GZIPInputStream;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Expand;

import de.innosystec.unrar.Archive;
import de.innosystec.unrar.rarfile.FileHeader;

public class Unzip1 {
	/**
	 * 解压zip格式压缩包 对应的是ant.jar
	 */
	private static void unzip(String sourceZip, String destDir)
			throws Exception {
		try {
			Project p = new Project();
			Expand e = new Expand();
			e.setProject(p);
			e.setSrc(new File(sourceZip));
			e.setOverwrite(false);
			e.setDest(new File(destDir));
			/*
			 * ant下的zip工具默认压缩编码为UTF-8编码， 而winRAR软件压缩是用的windows默认的GBK或者GB2312编码
			 * 所以解压缩时要制定编码格式
			 */
			e.setEncoding("gbk");
			e.execute();
		} catch (Exception e) {
			throw e;
		}
	}

	// public static void unZip(String src, String outPath) throws IOException {
	// String unzipfile = ""; // 解压缩的文件名
	// try {
	// ZipInputStream zin = new ZipInputStream(new FileInputStream(
	// unzipfile));
	// ZipEntry entry;
	// // 创建文件夹
	// while ((entry = zin.getNextEntry()) != null) {
	// if (entry.isDirectory()) {
	// File directory = new File(outPath, entry.getName());
	// if (!directory.exists()) {
	// if (!directory.mkdirs()) {
	// System.exit(0);
	// }
	// }
	// zin.closeEntry();
	// } else {
	// File myFile = new File(entry.getName());
	// FileOutputStream fout = new FileOutputStream(outPath
	// + myFile.getPath());
	// DataOutputStream dout = new DataOutputStream(fout);
	// byte[] b = new byte[1024];
	// int len = 0;
	// while ((len = zin.read(b)) != -1) {
	// dout.write(b, 0, len);
	// }
	// dout.close();
	// fout.close();
	// zin.closeEntry();
	// }
	// }
	// // return true;
	// } catch (IOException e) {
	// e.printStackTrace();
	// // return false;
	// }
	// }

	private static void ungz(String sourceGz, String destDir) {
		GZIPInputStream gzi;
		try {
			gzi = new GZIPInputStream(new FileInputStream(sourceGz));
			int to = sourceGz.lastIndexOf('.');
			if (to == -1) {
				System.out.println("usage:  java expandgz  filename.gz");
				System.exit(0);
			}
			String destDirnew = sourceGz.substring(0, to);
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(destDir
							+ "/"
							+ destDirnew.substring(
									destDirnew.lastIndexOf("\\") + 1,
									destDirnew.length())));
			System.out.println("writing " + destDir);

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

	/**
	 * 解压rar格式压缩包。
	 * 对应的是java-unrar-0.3.jar，但是java-unrar-0.3.jar又会用到commons-logging-1.1.1.jar
	 */
	private static void unrar(String sourceRar, String destDir)
			throws Exception {

		if (!sourceRar.toLowerCase().endsWith(".rar")) {
			System.out.println("非rar文件！");
			return;
		}
		File dstDiretory = new File(destDir);
		if (!dstDiretory.exists()) {// 目标目录不存在时，创建该文件夹
			dstDiretory.mkdirs();
		}
		try {
			// Archive a = null;
			Archive a = new Archive(new File(sourceRar));
			System.out.println(a.toString());
			if (a != null) {
				System.out.println(a + "________________________");
				a.getMainHeader().print(); // 打印文件信息.
				FileHeader fh = a.nextFileHeader();
				while (fh != null) {
					// 防止文件名中文乱码问题的处理
					String fileName = fh.getFileNameW().isEmpty() ? fh
							.getFileNameString() : fh.getFileNameW();
					if (fh.isDirectory()) { // 文件夹
						File fol = new File(destDir + File.separator + fileName);
						fol.mkdirs();
					} else { // 文件
						File out = new File(destDir + File.separator
								+ fileName.trim());
						// System.out.println(out.getAbsolutePath());
						try {// 之所以这么写try，是因为万一这里面有了异常，不影响继续解压.
							if (!out.exists()) {
								if (!out.getParentFile().exists()) {// 相对路径可能多级，可能需要创建父目录.
									out.getParentFile().mkdirs();
								}
								out.createNewFile();
							}
							FileOutputStream os = new FileOutputStream(out);
							a.extractFile(fh, os);
							os.close();
						} catch (Exception ex) {
							ex.printStackTrace();
						}
					}
					fh = a.nextFileHeader();
				}
				a.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String fileCode(String str)
			throws UnsupportedEncodingException {
		// String fileCode = (String)
		// System.getProperties().get("file.encoding");
		// String filename = new String(str.getBytes(fileCode), fileCode);
		return str;
	}

	/**
	 * 解压缩
	 */
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

			if (type.equals("zip")) {
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().lastIndexOf("."));
				File s = new File(destDir + "\\" + newthisPath);

				/*
				 * String[] strs =
				 * (files[i].getAbsoluteFile().toString()).split("\\\\"); String
				 * thisPaths = strs[strs.length-1]; String newthisPath="";
				 * System.out.println(thisPaths.split(".").length);
				 */

				s.mkdir();
				Unzip1.unzip(files[i].getAbsolutePath(), destDir + "\\"
						+ newthisPath);
				deCompress(destDir + "\\" + newthisPath, destDir + "\\"
						+ newthisPath);

			} else if (type.equals("rar")) {
				// String
				// fileCode=(String)System.getProperties().get("file.encoding");
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().lastIndexOf("."));
				// File s = new File(destDir + "\\" + newthisPath);
				String pathname = destDir + "\\" + newthisPath;
				Unzip1.unrar(files[i].getAbsolutePath(), pathname);
				deCompress(pathname, pathname);
			} else if (type.equals("gz")) {
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().indexOf("."));
				File s = new File(destDir + "\\" + newthisPath);
				s.mkdir();
				String path = files[i].getName().substring(0,
						files[i].getName().toString().lastIndexOf("."));
				Unzip1.ungz(files[i].getAbsolutePath(), destDir + "\\" + path);
				// deCompress(destDir + "\\" + newthisPath+ "\\" + path, destDir
				// + "\\"+ newthisPath+ "\\"
				// + path);

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
