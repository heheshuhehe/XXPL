package com.fh.util.file;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.GZIPInputStream;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Expand;

import com.fh.util.Logger;

import de.innosystec.unrar.Archive;
import de.innosystec.unrar.rarfile.FileHeader;

public class Unzip {

	private static Logger logger = Logger.getLogger(Unzip.class);

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
			// System.out.println("writing " + destDir);

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
		Archive a = null;
		try {
			a = new Archive(new File(sourceRar));
			if (a != null) {
				// a.getMainHeader().print(); // 打印文件信息.
				FileHeader fh = a.nextFileHeader();
				if (fh == null){
					throw new Exception();
				}
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
			a.close();
			throw new Exception();
		}
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
			char lastChar = destDir.charAt(destDir.length() - 1);
			if (lastChar != '/' && lastChar != '\\') {
				destDir += File.separator;
			}
			String filepath = files[i].toString();

			if (files[i].isDirectory()) {
				String[] strs = filepath.split("\\\\");
				String thisPaths = strs[strs.length - 1];
				File s = new File(destDir + "\\" + thisPaths);
				String newspath = destDir + "\\" + thisPaths;
				s.mkdir();
				deCompress(filepath, newspath);
			}

			// 根据类型，进行相应的解压缩
			String type = filepath.substring(filepath.lastIndexOf(".") + 1);

			if (type.equalsIgnoreCase("zip")) {
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().lastIndexOf("."));
				File s = new File(destDir + "\\" + newthisPath);
				s.mkdir();
				Unzip.unzip(files[i].getAbsolutePath(), destDir + "\\"
						+ newthisPath);
				deCompress(destDir + "\\" + newthisPath, destDir + "\\"
						+ newthisPath);

			} else if (type.equalsIgnoreCase("rar")) {
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().lastIndexOf("."));
				String pathname = destDir + "\\" + newthisPath;

				try {
					Unzip.unrar(files[i].getAbsolutePath(), pathname);

				} catch (Exception e) {
					if (files[i].toString().toLowerCase().contains("rar")) {

						String name = files[i].toString().substring(0,
								files[i].toString().lastIndexOf("."));

						FileCopy.Copy(files[i].toString(), name + ".zip");

						unzip(name + ".zip", pathname);

						Boolean b = new File(name + ".zip").delete();

						logger.info("删除zip文件：" + name + ".zip:" + b);
					}

				}
				deCompress(pathname, pathname);
			} else if (type.equalsIgnoreCase("gz")) {
				String newthisPath = files[i].getName().substring(0,
						files[i].getName().toString().indexOf("."));
				File s = new File(destDir + "\\" + newthisPath);
				s.mkdir();
				Unzip.ungz(files[i].getAbsolutePath(), destDir + "\\"
						+ newthisPath);
				// 删除压缩文件
				files[i].delete();
				deCompress(destDir + "\\" + newthisPath, destDir + "\\"
						+ newthisPath);
			}

		}
	}

	public static void copyfolder(String sourceFile, String destDir) {
		// 获取源文件夹当前下的文件或目录
		File[] file = (new File(sourceFile)).listFiles();
		for (int i = 0; i < file.length; i++) {

			// if (file[i].toString().contains("rar")) {
			// String name = file[i].toString().substring(0,
			// file[i].toString().lastIndexOf("."));
			// file[i].renameTo(new File(name + ".zip"));
			// }

			if (file[i].isDirectory()) {
				// 复制目录
				String sorceDir = sourceFile + File.separator
						+ file[i].getName();
				String targetDir = destDir + File.separator + file[i].getName();
				copyDirectiory.directioryCopy(sorceDir, targetDir);
			}

		}
	}

	public static void main(String[] args) {
		try {
			logger.info("文件解压开始");
			copyfolder("C://Users//Administrator//Desktop//20160923",
					"C://Users//Administrator//Desktop//20160924//");

			deCompress("C://Users//Administrator//Desktop//20160923",
					"C://Users//Administrator//Desktop//20160924//");
			logger.info("文件解压结束");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
