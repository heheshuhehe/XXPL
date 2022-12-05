package com.fh.util.file;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
 
public class DownLoad {   
  public static void downloadFile(URL theURL, String filePath) throws IOException {  
     File dirFile = new File(filePath);
        if(!dirFile.exists()){//文件路径不存在时，自动创建目录
          dirFile.mkdir();
        }
   //从服务器上获取图片并保存
      URLConnection  connection = theURL.openConnection();
      InputStream in = connection.getInputStream();  
      FileOutputStream os = new FileOutputStream(filePath+"\\123.dlt"); 
      byte[] buffer = new byte[4 * 1024];  
      int read;  
      while ((read = in.read(buffer)) > 0) {  
          os.write(buffer, 0, read);  
           }  
        os.close();  
        in.close();
   }   
      public static void main(String[] args) throws MalformedURLException {   
        String urlPath = "50.2.68.83:8080/download/allbranchbalance89.dlt";   
        String filePath = "d:\\excel";   
        URL url = new URL(urlPath);   
          try {   
              downloadFile(url,filePath);   
           } catch (IOException e) {   
            e.printStackTrace();   
         }   
      }   
 
}