package com.fh.util;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * java压缩成zip
 * 创建人：FH 创建时间：2015年1月14日
 * @version
 */
public class FileZip {

	/**
	 * @param inputFileName 你要压缩的文件夹(整个完整路径)
	 * @param zipFileName 压缩后的文件(整个完整路径)
	 */
	public static void zip(String inputFileName, String zipFileName) throws Exception {
		zip(zipFileName, new File(inputFileName));
	}

	private static void zip(String zipFileName, File inputFile) throws Exception {
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
				zipFileName));
		zip(out, inputFile, "");
		out.flush();
		out.close();
	}

	private static void zip(ZipOutputStream out, File f, String base) throws Exception {
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			out.putNextEntry(new ZipEntry(base + "/"));
			base = base.length() == 0 ? "" : base + "/";
			for (int i = 0; i < fl.length; i++) {
				zip(out, fl[i], base + fl[i].getName());
			}
		} else {
			out.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(f);
			int b;
			//logger.info(base);
			while ((b = in.read()) != -1) {
				out.write(b);
			}
			in.close();
		}
	}
	
	 public static void main(String [] temp){       
		 try {           
			 zip("E:\\ftl","E:\\test.zip");//你要压缩的文件夹      和  压缩后的文件 
			 }catch (Exception ex) {       
				 ex.printStackTrace();    
			 }   
		}
	 public static String ReadTxtFile(String strFilePath)  
     {  
         String path = strFilePath;  
         StringBuilder sb=new StringBuilder();
             //打开文件  
             File file = new File(path);  
             //如果path是传递过来的参数，可以做一个非目录的判断  
             if (file.isDirectory())  
             {  
                 System.out.println("目录");
             }  
             else  
             {  
                 try {  
                     InputStream instream = new FileInputStream(file);   
                     if (instream != null)   
                     {  
                         InputStreamReader inputreader = new InputStreamReader(instream);  
                         BufferedReader buffreader = new BufferedReader(inputreader);  
                         String line;  
                         //分行读取  
                         while (( line = buffreader.readLine()) != null) {   
                            sb.append(line+"\n");
                         }                  
                         instream.close();  
                     }  
                 }  
                 catch (java.io.FileNotFoundException e)   
                 {  
                    System.out.println("TestFile The File doesn't not exist.");  
                 }   
                 catch (IOException e)   
                 {  
                  System.out.println("TestFile");  
                 }  
             }  
           //  System.out.println(sb.toString());
             return sb.toString();  
     }

}



//=====================文件压缩=========================
/*//把文件压缩成zip
File zipFile = new File("E:/demo.zip");
//定义输入文件流
InputStream input = new FileInputStream(file);
//定义压缩输出流	
ZipOutputStream zipOut = null;
//实例化压缩输出流,并制定压缩文件的输出路径  就是E盘下,名字叫 demo.zip
zipOut = new ZipOutputStream(new FileOutputStream(zipFile));
zipOut.putNextEntry(new ZipEntry(file.getName()));
//设置注释
zipOut.setComment("www.demo.com");
int temp = 0;
while((temp = input.read()) != -1) {
	zipOut.write(temp);	
}		
input.close();
zipOut.close();*/
//==============================================
