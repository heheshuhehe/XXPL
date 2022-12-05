package com.fh.util.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CopyFileTool {
	/**
	 * 用于备份基本配置文件及业务逻辑文件,
	 * 此方法会在参数路径下查找是否存在\baseConfig及\curr文件夹,并备份其目录以及其目录下子目录和文件到备份文件夹
	 * 
	 * @param confPath
	 *            配置文件的根目录
	 * @return
	 * @throws IOException
	 */
	public static boolean doCopy(String confPath) throws IOException {
		if (!new File(confPath).exists()) {
			System.out.println("参数路径不存在!");
			return false;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		String lastMonthStr = sdf.format(calendar.getTime());

		File baseConfig = new File(confPath + File.separator + "baseConfig");
		File curr = new File(confPath + File.separator + "curr");
		File back = new File(confPath + File.separator + lastMonthStr);
		File backBaseConfig = null;
		File backCurr = null;

		if (!baseConfig.exists() || !curr.exists()) {
			System.out.println("baseConfig或curr文件夹不存在");
			return false;
		}
		if (back.exists()) {
			System.out.println("备份文件夹已存在!");
			deleteDir(back.getAbsolutePath());
		}

		back.mkdirs();
		backBaseConfig = new File(back.getAbsolutePath() + File.separator
				+ baseConfig.getName());
		backCurr = new File(back.getAbsolutePath() + File.separator
				+ curr.getName());

		doCopy(baseConfig.getAbsolutePath(), backBaseConfig.getAbsolutePath());
		doCopy(curr.getAbsolutePath(), backCurr.getAbsolutePath());

		return true;
	}

	/**
	 * @param file
	 *            文件、文件夹 路径
	 * @return 文件、文件夹 是否存在
	 */
	public static boolean checkFileExists(String file) {
		boolean result = new File(file).exists();

		if (!result) {
			System.out.println("源路径不存在，请检查后再试");
		}

		return result;
	}

	/**
	 * @param fileFolder
	 *            文件夹路径
	 * @return 文件夹是否存在
	 */
	public static boolean checkIsFolder(String fileFolder) {
		boolean result = new File(fileFolder).isDirectory();

		if (!result) {
			System.out.println("目标路径不是有效目录，请检查后再试");
		}

		return result;
	}

	/**
	 * 如果文件夹不存在就创建
	 * 
	 * @param fileFolder
	 *            文件夹
	 * @return 创建文件夹是否存在。
	 */
	public static boolean createFolder(String fileFolder) {
		boolean isExists = false;
		File f = new File(fileFolder);
		if (!f.exists()) {
			f.mkdirs();
			isExists = true;
		}
		return isExists;
	}

	/**
	 * 复制某一个路径下的文件夹及其以下所有文件到另一个路径
	 * 
	 * @param sPath
	 *            源路径
	 * @param tPath
	 *            目标路径
	 * @return 是否复制成功
	 * @throws IOException
	 */
	public static boolean doCopy(String sPath, String tPath) throws IOException {
		// 判断源文件夹是否存在.
		if (!checkFileExists(sPath)) {
			return false;
		}
		// 判断目标文件夹是否存在。
		if (!checkIsFolder(tPath)) {
			return false;
		}
		// 获取源文件夹当前下的文件或目录
		File[] files = (new File(sPath)).listFiles();

		for (File f : files) {
			if (f.isFile()) {
				// 复制文件
				copyFile(f, new File(tPath + File.separator + f.getName()));
			}
			if (f.isDirectory()) {
				// 复制目录
				String sDir = sPath + File.separator + f.getName();
				String tDir = tPath + File.separator + f.getName();
				copyDirectiory(sDir, tDir);
			}
		}
		return true;
	}

	/**
	 * 将某一个路径下的文件夹及其以下所有文件 move到另一个路径
	 * 
	 * @param sPath
	 *            源路径
	 * @param tPath
	 *            目标路径
	 * @return 是否 move 成功
	 * @throws IOException
	 */
	public static boolean doMove(String sPath, String tPath) throws IOException {
		// 判断源文件夹是否存在.
		if (!checkFileExists(sPath)) {
			return false;
		}
		// 判断目标文件夹是否存在。
		if (!checkIsFolder(tPath)) {
			return false;
		}
		// 获取源文件夹当前下的文件或目录
		File[] files = (new File(sPath)).listFiles();

		for (File f : files) {
			if (f.isFile()) {
				// 复制文件
				copyFile(f, new File(tPath + File.separator + f.getName()));
				f.delete();
			}
			if (f.isDirectory()) {
				// 复制目录
				String sDir = sPath + File.separator + f.getName();
				String tDir = tPath + File.separator + f.getName();
				moveDirectiory(sDir, tDir);
				f.delete();
			}
		}
		return true;
	}

	/**
	 * 移动文件夹下所有的文件到目标文件夹
	 * 
	 * @param sDir
	 *            源文件夹
	 * @param tDir
	 *            目标文件夹
	 * @throws IOException
	 */
	private static void moveDirectiory(String sDir, String tDir)
			throws IOException {
		new File(tDir).mkdirs();

		File[] files = new File(sDir).listFiles();

		for (File f : files) {
			if (f.isFile()) {
				File sFile = f;
				File tFile = new File(new File(tDir).getAbsolutePath()
						+ File.separator + f.getName());

				copyFile(sFile, tFile);
				f.delete();
			}

			if (f.isDirectory()) {
				String s = sDir + File.separator + f.getName();
				String t = tDir + File.separator + f.getName();
				moveDirectiory(s, t);
				f.delete();
			}
		}
	}

	/**
	 * 复制文件夹下所有的文件到目标文件夹
	 * 
	 * @param sDir
	 *            源文件夹
	 * @param tDir
	 *            目标文件夹
	 * @throws IOException
	 */
	private static void copyDirectiory(String sDir, String tDir)
			throws IOException {
		new File(tDir).mkdirs();

		File[] files = new File(sDir).listFiles();

		for (File f : files) {
			if (f.isFile()) {
				File sFile = f;
				File tFile = new File(new File(tDir).getAbsolutePath()
						+ File.separator + f.getName());

				copyFile(sFile, tFile);
			}

			if (f.isDirectory()) {
				String s = sDir + File.separator + f.getName();
				String t = tDir + File.separator + f.getName();
				copyDirectiory(s, t);
			}
		}
	}

	public static void copyFile(File sFile, File tFile) throws IOException {
		FileInputStream fis = new FileInputStream(sFile);
		FileOutputStream fos = new FileOutputStream(tFile);
		BufferedInputStream bis = new BufferedInputStream(fis);
		BufferedOutputStream bos = new BufferedOutputStream(fos);

		byte[] buffer = new byte[1024];
		int i;
		while ((i = bis.read(buffer)) != -1) {
			bos.write(buffer, 0, i);
		}
		bos.flush();

		close(bis, fis, bos, fos);

		return;
	}

	/**
	 * 递归删除目录下的所有文件及子目录下所有文件
	 * 
	 * @param dir
	 *            将要删除的文件目录
	 * @return boolean
	 */
	private static boolean deleteDir(String path) {
		File dir = new File(path);
		if (dir.isDirectory()) {
			String[] children = dir.list();
			// 递归删除目录中的子目录下
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(path + File.separator + children[i]);
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}

	private static void close(InputStream is, FileInputStream fis,
			OutputStream os, FileOutputStream fos) throws IOException {
		if (null != is) {
			is.close();
		}
		if (null != os) {
			os.close();
		}
		if (null != fis) {
			fis.close();
		}
		if (null != fos) {
			fos.close();
		}
	}

	public static void bakFolderByCMD(String sPath, String tPath) {
		File[] files = (new File(sPath)).listFiles();
		try {
			for (File f : files) {
				String sfile = sPath + File.separator + f.getName();
				String tfile = tPath + File.separator + f.getName();
				Runtime.getRuntime().exec("cmd /c move " + sfile + " " + tfile);
				System.out.println("备份成功!");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void bakFileByCMD(String sfile, String tfile) {
		try {
			Runtime.getRuntime().exec("cmd /c move " + sfile + " " + tfile);
			System.out.println("备份成功!");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void getFileInfo(String folder,
			List<HashMap<String, String>> results) {

		if (results == null) {
			results = new ArrayList<HashMap<String, String>>();
		}

		if (results.size() % 10000 == 0) {
			System.out.println("目前扫描文件数目：" + results.size());
		}

		File[] files = new File(folder).listFiles();
		if (files.length == 0) {
			long last_modified = new File(folder).lastModified();
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("file_folder", folder);
			map.put("file_name", folder);
			map.put("file_type", "folder");
			map.put("last_modified", last_modified + "");
			results.add(map);
		}

		for (File f : files) {
			if (f.isFile()) {
				long last_modified = f.lastModified();
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("file_folder", folder);
				map.put("file_name", f.getName());
				// map.put("create_time",
				// getCreateTime(folder+File.separator+f.getName(),f.getName()));
				map.put("last_modified", TimeManager.getTimeString(
						last_modified, "yyyyMMddHHmmss"));
				map.put("file_size_k", f.length() + "");
				results.add(map);
			}

			if (f.isDirectory()) {
				getFileInfo(folder + File.separator + f.getName(), results);
			}
		}

	}

	/**
	 * 读取文件创建时间
	 */
	public static String getCreateTime(String filePath, String filename) {
		String strTime = null;
		try {
			Process p = Runtime.getRuntime().exec(
					"cmd /C dir " + filePath + "/tc");
			InputStream is = p.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String line;
			while ((line = br.readLine()) != null) {
				if (line.endsWith(filename)) {
					strTime = line.substring(0, 17);
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return strTime;
		// 输出：创建时间 2009-08-17 10:21
	}

	/**
	 * 文件夹下所有的文件的创建信息
	 */
	public static Map<Integer, String> getFolderCreateTime(String filePath) {
		Map<Integer, String> result = new HashMap<Integer, String>();
		int i = 0;
		try {
			Process p = Runtime.getRuntime().exec(
					"cmd /C dir " + filePath + "/tc");
			InputStream is = p.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is,
					"gbk"));
			String line;
			while ((line = br.readLine()) != null) {
				result.put(i++, line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
		// 输出：创建时间 2009-08-17 10:21
	}

	public static void main(String[] args) {

	}

}
