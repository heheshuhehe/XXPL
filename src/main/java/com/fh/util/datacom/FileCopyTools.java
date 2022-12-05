package com.fh.util.datacom;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

public class FileCopyTools {
	
	static String  winrarPath="C:/Program Files/WinRAR/WinRAR.exe";

	
	/**
	 * 
	 * copyType    0 文件存在 不复制      1文件存在，直接覆盖      2文件存在复制但重命名
	 * 
	 * withdir    true  源目录 带文件夹 复制      false复制源目录下的所有文件和文件夹
	 * 
	 * */
	public static String copydirFile(String fromDir, String toDir, int copyType) {
		String result = "";
		try {
			// 创建目录的File对象
			File dirSouce = new File(fromDir);
			File toSouce = new File(toDir);
			
		
			// 判断源目录是不是一个目录
			if (!dirSouce.isDirectory()) {
				
				if(!toSouce.isDirectory()){
					return "toDir is not a  Directory";
				}
				String  tofile=(toSouce.getAbsolutePath().endsWith("\\") ? toSouce.getAbsolutePath() : toSouce.getAbsolutePath() + "\\")+dirSouce.getName(); 
				
				
				copyFile(fromDir, tofile, copyType);
				
				
				// 如果不是目录那就不复制
				return "file copy done";
			}
			// 创建目标目录的File对象
			File destDir = new File(toDir);
			// 如果目的目录不存在
			if (!destDir.exists()) {
				// 创建目的目录
				destDir.mkdir();
			}
			// 获取源目录下的File对象列表
			File[] files = dirSouce.listFiles();
			for (File file : files) {
				// 拼接新的fromDir(fromFile)和toDir(toFile)的路径
				String strFrom = fromDir + File.separator + file.getName();
				System.out.println(strFrom);
				String strTo = toDir + File.separator + file.getName();
				System.out.println(strTo);
				// 判断File对象是目录还是文件
				// 判断是否是目录
				if (file.isDirectory()) {
					// 递归调用复制目录的方法
					copydirFile(strFrom, strTo, copyType);
				}
				
				
				// 判断是否是文件
				if (file.isFile()) {
					copyFile(strFrom, strTo,copyType);
					}
				}
			

			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = e.getMessage();
		}

		return result;
	}
	public static boolean deleteDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            //递归删除目录中的子目录
            for (int i=0; i<children.length; i++) {
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }
        // 目录此时为空，可以删除
        return dir.delete();
    }

	public static void copyFile(String fromFile, String toFile) throws IOException {
		
	File f=new File(toFile);

	if(f.exists())
		f.delete();
		// 字节输入流——读取文件
		FileInputStream in = new FileInputStream(fromFile);
		// 字节输出流——写入文件
		FileOutputStream out = new FileOutputStream(toFile);
		// 把读取到的内容写入新文件
		// 把字节数组设置大一些 1*1024*1024=1M
		byte[] bs = new byte[1 * 1024 * 1024];
		int count = 0;
		while ((count = in.read(bs)) != -1) {
			out.write(bs, 0, count);
		}
		// 关闭流
		in.close();
		out.flush();
		out.close();
	}
	
	
	public static String copyFile(String fromFile, String toFile, boolean iscover) throws IOException {
		
	File f=new File(toFile);
	if(!iscover){
		int i=1;
		while(f.exists()){
			
			toFile=toFile.substring(0,	toFile.lastIndexOf("."))+"("+i+")."+ext(toFile);
			f=new File(toFile);
			i++;
		}
			
		}
	if(!f.exists()&&!f.isDirectory()){
		f.getParentFile().mkdirs();
	}else if(!f.exists()&&f.isDirectory()){
		f.mkdirs();
	}
		
	
		// 字节输入流——读取文件
		FileInputStream in = new FileInputStream(fromFile);
		// 字节输出流——写入文件
		FileOutputStream out = new FileOutputStream(toFile);
		// 把读取到的内容写入新文件
		// 把字节数组设置大一些 1*1024*1024=1M
		byte[] bs = new byte[1 * 1024 * 1024];
		int count = 0;
		while ((count = in.read(bs)) != -1) {
			out.write(bs, 0, count);
		}
		// 关闭流
		in.close();
		out.flush();
		out.close();
		return toFile;
	}
	/**
	 * 
	 * copyType    0 文件存在 不复制      1文件存在，直接覆盖      2文件存在复制但重命名
	 * 
	 * */
	//public static String copydirFile(String fromDir, String toDir, int copyType) {
	public static String copyFile(String fromFile, String toFile, int copyType) throws IOException {
		
		File f=new File(toFile);
		if(f.exists()&&copyType==0){
			return "file exists and not copy";
		}
		
		if(copyType==2){
			int i=1;
			while(f.exists()){
				
				toFile=toFile.substring(0,	toFile.lastIndexOf("."))+"("+i+")."+ext(toFile);
				f=new File(toFile);
				i++;
			}
				
		}
		if(!f.exists()&&!f.isDirectory()){
			f.getParentFile().mkdirs();
		}else if(!f.exists()&&f.isDirectory()){
			f.mkdirs();
		}
			
		
			// 字节输入流——读取文件
			FileInputStream in = new FileInputStream(fromFile);
			// 字节输出流——写入文件
			FileOutputStream out = new FileOutputStream(toFile);
			// 把读取到的内容写入新文件
			// 把字节数组设置大一些 1*1024*1024=1M
			byte[] bs = new byte[1 * 1024 * 1024];
			int count = 0;
			while ((count = in.read(bs)) != -1) {
				out.write(bs, 0, count);
			}
			// 关闭流
			in.close();
			out.flush();
			out.close();
			return toFile;
		}
	public static String ext(String filename) {
		int index = filename.lastIndexOf(".");
		if (index == -1) {
			return null;
		}
		String result = filename.substring(index + 1);
		return result;
	}
	public static String fileNameWithoutExt(String filename) {
		int index = filename.lastIndexOf(".");
		if (index == -1) {
			return null;
		}
		String result = filename.substring(0,index);
		return result;
	}
	  public static boolean unzip2sameFolder(String zipFile,String despath) {   
		     boolean bool = false;   
		    
		        File f=new File(zipFile);
		        if(!f.exists())
		        {
		         return false;
		        }
		        String folder = despath;
		        System.out.println(folder);
		        String cmd = "\""+ winrarPath+"\"" + " x -inul -o- -ep -ibck \""+zipFile + "\"  "+despath;  
		        //cmd="C://Program Files//WinRAR//WinRAR.exe X  D://a.rar D://a";
		        System.out.println(cmd);     
		            try {   
		                Process proc = Runtime.getRuntime().exec(cmd);   
		                if (proc.waitFor() != 0) {   
		                    if (proc.exitValue() == 0) {   
		                        bool = false;   
		                    }   
		                } else {   
		                    bool = true;   
		                }   
		            } catch (Exception e) {   
		                e.printStackTrace();   
		            }   
		        return bool;  
		    }   
	  public static boolean unzip(String zipFile,String despath) {   
		     boolean bool = false;   
		    
		        File f=new File(zipFile);
		        if(!f.exists())
		        {
		         return false;
		        }
		        String folder = despath;
		        System.out.println(folder);
		        String cmd = "\""+ winrarPath+"\"" + " x -inul -or  -ibck  \""+zipFile + "\" \""+despath+"\"";  
		        //cmd="C://Program Files//WinRAR//WinRAR.exe X  D://a.rar D://a";
		        System.out.println(cmd);     
		            try {   
		                Process proc = Runtime.getRuntime().exec(cmd);   
		                if (proc.waitFor() != 0) {   
		                    if (proc.exitValue() == 0) {   
		                        bool = false;   
		                    }   
		                } else {   
		                    bool = true;   
		                }   
		            } catch (Exception e) {   
		                e.printStackTrace();   
		            }   
		        return bool;  
		    } 
	public static ArrayList<File> getListFiles(Object obj) {
					File directory = null;  
			        if (obj instanceof File) {  
			            directory = (File) obj;  
			        } else {  
			            directory = new File(obj.toString());  
			        }  
			        ArrayList<File> files = new ArrayList<File>();  
			        if (directory.isFile()) {  
			            files.add(directory);  
			            return files;  
			        } else if (directory.isDirectory()) {  
			            File[] fileArr = directory.listFiles();  
			            for (int i = 0; i < fileArr.length; i++) {  
			                File fileOne = fileArr[i];  
			                files.addAll(getListFiles(fileOne));  
			            }  
			        }  
			        return files;  
	
	}
	public  static void copyAll(File srcFile, File destFile) {
		if (srcFile.isFile()) {
			// 是文件，递归结束，开始拷贝 
			FileInputStream in = null; 
			FileOutputStream out = null; 
			try {
				// in = new FileInputStream(srcFile.getAbsoluteFile());
				// 或者这么写
				in = new FileInputStream(srcFile);
				byte[] bytes = new byte[1024 * 1024]; 
				out = new FileOutputStream((destFile.getAbsolutePath().endsWith("\\") ? destFile.getAbsolutePath() : destFile.getAbsolutePath() + "\\" ) + srcFile.getName()); 
				int readCount = 0; 
				while((readCount = in.read(bytes)) != -1){ 
					out.write(bytes,0, readCount);
				} out.flush(); 
			} catch (FileNotFoundException e) {
				e.printStackTrace(); 
			} catch (IOException e) {
				e.printStackTrace(); 
			} finally {
				if (out != null) {
					try { 
						out.close(); 
					} catch (IOException e) {
						e.printStackTrace(); 
					}
				} 
				if (in == null) {
					try { in.close();
					} catch (IOException e) { 
						e.printStackTrace();
					}
				} 
			} 
			return; 
		} 
		File[] files = srcFile.listFiles();
		// 如果是目录，则需要对应新建目录 
		for (File f : files) { 
			if (f.isDirectory()){
				String srcDir = f.getAbsolutePath(); // 原文件绝对路径 
				String srcDir2 = srcDir.substring(3); //截掉前面的盘符
				// 这里是因为有时候复制到 F:\\ 和 F:\\a\\b\\ 下读取的绝对路径不一样 
				String destDir = (destFile.getAbsolutePath().endsWith("\\") ? destFile.getAbsolutePath() : destFile.getAbsolutePath() + "\\" ) + srcDir2;
				// 新建一个 File 对象 
				File newFile = new File(destDir);
				// 目录不存在，则以多重目录的方式新建目录 
				if (!newFile.exists()){ 
					newFile.mkdirs(); 
				} 
			} 
			// 递归 
			copyAll(f, destFile); 
		}
	}







	public static void main(String[] args) {
		
		File srcFile=new File("C:/2/222/清算通知调整数据-汇划手续费20210510.xls");
		File destFile=new File("C:/3");
		//FileCopyTools.copyAll(srcFile, destFile);
		//FileCopyTools.copydirFile("C:/2/222/清算通知调整数据-汇划手续费20210510.xls", "C:/3", false);
		
			FileCopyTools.copydirFile("C:/2/222", "C:/3/", 2);
		
	}
}

