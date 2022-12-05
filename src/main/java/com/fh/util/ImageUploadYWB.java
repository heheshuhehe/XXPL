package com.fh.util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

/**
 * 上传图片
 * 创建人：ywb 创建时间：2016年05月09日
 * @version
 */
public class ImageUploadYWB {
	
	protected static Logger logger = Logger.getLogger(ImageUploadYWB.class);
	/**
	 * @param file 			//文件对象
	 * @param filePath		//上传路径
	 * @param fileName		//文件名
	 * @return  文件名
	 * @throws Exception 
	 */
	public static String fileUp(MultipartFile file, String filePath, String fileName,Map map) throws Exception{
		      copyFile(file.getInputStream(), filePath,file.getOriginalFilename()).replaceAll("-", "");
		     String response = ImageUploadYWB.imageUp(filePath,  file.getOriginalFilename(),map);
		    return response;
	}
	
	/**
	 * 写文件到当前目录的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 */
	private static String copyFile(InputStream in, String dir, String realName)
			throws IOException {
		File file = new File(dir, realName);
		if (!file.exists()) {
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			file.createNewFile();
		}
		FileUtils.copyInputStreamToFile(in, file);
		return realName;
	}
   /**
    *本地图片同步到图片服务器
    * @param filePath
    * @param fileName
    * @return
 * @throws Exception 
    */
	@SuppressWarnings("unchecked")
	public  static String imageUp(String filePath, String fileName,Map map) throws Exception{
		StringBuffer sb = new StringBuffer();
		StringBuffer returnSb = new StringBuffer();
		String response="";
		String BOUNDARY = "---------------------------123821742118716";
		
		OutputStream out=null;
		DataInputStream in=null;
		BufferedReader reader=null;
		HttpURLConnection connection=null;
		try {
			  if(StringUtils.isNotEmpty(PropertyUitls.getSysConfigSet(("ImgServerUrl")))){
	            URL url=new URL(PropertyUitls.getSysConfigSet(("ImgServerUrl")));
	            connection=(HttpURLConnection)url.openConnection();
	            connection.setConnectTimeout(500000);  
	            connection.setReadTimeout(300000); 
	            connection.setDoInput(true);
	            connection.setDoOutput(true);
	            connection.setUseCaches(false);  
	            connection.setRequestMethod("POST");
	            connection.setRequestProperty("connection", "Keep-Alive");
	            connection.setRequestProperty("Charsert", "UTF-8");
	            connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
	            connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
	            out = new DataOutputStream(connection.getOutputStream());
	            byte[] end_data = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();// 定义最后数据分隔线
	           
	            map.put("fileName", HY_JX_Coder.URLEncode(fileName,"UTF-8"));
	            map.put("TestStr", "汉字怎么样？");
	            
	           //拼接请求参数
	           StringBuffer paramSb=new StringBuffer();
               if(map!=null && !map.isEmpty()){
            	         Iterator iter = map.entrySet().iterator();  
            	         while (iter.hasNext()) { 
            	        	 Map.Entry entry = (Map.Entry) iter.next();  
            	        	 String inputName = (String) entry.getKey();  
                             String inputValue = (String) entry.getValue(); 
            	        	 paramSb.append("\r\n").append("--").append(BOUNDARY).append("\r\n")
                    	  .append("Content-Disposition: form-data; name=\""+inputName+"\"\r\n\r\n").append(inputValue);  
            	         }
            	 out.write(paramSb.toString().getBytes("utf-8"));  
               }
               out.write("\r\n".getBytes()); //多个文件时，二个文件之间加入这个

	           File file = new File(filePath,fileName);
	           sb.append("--");
	           sb.append(BOUNDARY);
	           sb.append("\r\n");
	           sb.append("Content-Disposition: form-data;name=\"file\";filename=\""+ file.getName() + "\"\r\n");
	           sb.append("Content-Type:application/octet-stream\r\n\r\n");
	           byte[] data = sb.toString().getBytes("utf-8");
	           out.write(data);
	           
	           //读取本地文件
	           in = new DataInputStream(new FileInputStream(file));
	           int bytes = 0;
	           byte[] bufferOut = new byte[1024];
	           while ((bytes = in.read(bufferOut)) != -1) {
	              out.write(bufferOut, 0, bytes);
	           }
	           out.write("\r\n".getBytes()); //多个文件时，二个文件之间加入这个
	           in.close();
	           out.write(end_data);
	           out.flush();
	           out.close();
	          // 定义BufferedReader输入流来读取URL的响应
	           reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));
	           
	           String line = null;
	           while ((line = reader.readLine()) != null) {
	        	     returnSb.append(line);
	            }
	          //图片服务器返回数据 
	           response = returnSb.toString();
	           logger.info(response);
			  }
		   } catch (Exception e) {
	              logger.info("发送POST请求出现异常！" + e);
	              return "99";
	     }finally{
	    	 if(connection!=null){
	    		 connection.disconnect();  
	    		 connection = null;  
	    	 }
	    	 if(out!=null){
	    		 out.close();
	    	 }
	    	 if(in!=null){
	    		 in.close();
	    	 }
	    	 if(reader!=null){
	    		 reader.close();
	    	 }
	     }
		
		  return response;
   }
}	
	
	
