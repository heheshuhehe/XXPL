package com.fh.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

 
public class FileUpload {

	/**
	 * @param file 			//文件对象
	 * @param filePath		//上传路径
	 * @param fileName		//文件名
	 * @return  文件名
	 * @throws Exception 
	 */
	public static String fileUp(MultipartFile file, String filePath, String fileName,Map map) throws Exception{
		    String extName = ""; // 扩展名格式
		 
//			if (file.getOriginalFilename().lastIndexOf(".") >= 0){
//				extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
//			}
//			 String realName = copyFile(file.getInputStream(), filePath, fileName+extName).replaceAll("-", "");
//		    String response = ImageUploadYWB.imageUp(filePath,  fileName+extName);
		    
		     String realName = copyFile(file.getInputStream(), filePath,file.getOriginalFilename()).replaceAll("-", "");
		    
		     String response = ImageUploadYWB.imageUp(filePath,  file.getOriginalFilename(),map);
			
			
		    return realName;
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




}
