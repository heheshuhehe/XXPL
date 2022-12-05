package com.fh.util.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class copyDirectiory {
		public static void directioryCopy(String sourceDir,String targetDir){
			 
	        (new File(targetDir)).mkdirs();
	        
	        //获取源文件夹当下的文件或目录
	        File[] f=(new File(sourceDir)).listFiles();
	        
	        for (int K = 0; K < f.length; K++) {
	            if(f[K].isFile()){
	                //源文件
	                File sourceFile=f[K];
	                    //目标文件
	               File targetFile=new File(new File(targetDir).getAbsolutePath()+File.separator+f[K].getName());
	                
	               try {
					copyFile(sourceFile, targetFile);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            
	            }
	            
	            
	            if(f[K].isDirectory()){
	                //准备复制的源文件夹
	                String dir1=sourceDir+"//"+f[K].getName();
	                //准备复制的目标文件夹
	                String dir2=targetDir+"//"+f[K].getName();
	                
	                directioryCopy(dir1, dir2);
	            }
	        }
		}

		  public static void copyFile(File sourcefile,File targetFile) throws IOException{
		        
		        //新建文件输入流并对它进行缓冲
		        FileInputStream input=new FileInputStream(sourcefile);
		        BufferedInputStream inbuff=new BufferedInputStream(input);
		        
		        //新建文件输出流并对它进行缓冲
		        FileOutputStream out=new FileOutputStream(targetFile);
		        BufferedOutputStream outbuff=new BufferedOutputStream(out);
		        
		        //缓冲数组
		        byte[] b=new byte[1024*5];
		        int len=0;
		        while((len=inbuff.read(b))!=-1){
		            outbuff.write(b, 0, len);
		        }
		        
		        //刷新此缓冲的输出流
		        outbuff.flush();
		        
		        //关闭流
		        inbuff.close();
		        outbuff.close();
		        out.close();
		        input.close();
		        
		        
		    }
}
