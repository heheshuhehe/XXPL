package com.fh.util.file;

import java.io.File;

public class DeleteFile {

	/**
	 * 
	 * @param folderPath
	 *            文件夹完整绝对路径
	 * @param flag
	 *            true 删除文件以及空文件夹 flase 只删除文件，保留空文件夹
	 */
	public static void delFolder(String folderPath, Boolean flag) {
		try {
			delAllFile(folderPath, flag); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			if (flag) { // 如果flag为true 删除整个文件夹，如果flag为false 删除所有文件，留下空文件夹
				myFilePath.delete(); // 删除空文件夹
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 删除指定文件夹下所有文件
	 * 
	 * @param path
	 *            文件夹完整绝对路径
	 * @param flag1
	 *            true 删除文件以及空文件夹 flase 只删除文件，保留空文件夹
	 * @return
	 */
	public static boolean delAllFile(String path, Boolean flag1) {
		boolean flag = false;
		File file = new File(path);
		if (!file.exists()) {
			return flag;
		}
		if (!file.isDirectory()) {
			return flag;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i], flag1);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i], flag1);// 再删除空文件夹
				flag = true;
			}
		}
		return flag;
	}
   /***
	* 删除其他版本安装包
    */
	public static void deleteZip(String abpath) {
	   abpath=abpath.replace("//", "\\");
       String[] ss = abpath.split("/");
       String name = ss[ss.length - 1];
       String path = abpath.replace("/" + name, "");

       File file = new File(path);// 里面输入特定目录
       File temp = null;
       File[] filelist = file.listFiles();
       for (int i = 0; i < filelist.length; i++) {
           temp = filelist[i];
           if (temp.getName().endsWith("zip") && !temp.getName().endsWith(name))// 获得文件名，如果后缀为“”，这个你自己写，就删除文件
           {
               temp.delete();// 删除文件}
           }
       }
   }

	public static void main(String args[]) {
		delFolder("d:/sc/scwenjian", false);
		System.out.println("OK");
	}
}