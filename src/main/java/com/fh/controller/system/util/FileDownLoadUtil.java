package com.fh.controller.system.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.util.Logger;
import com.sinosoft.scs.core.PropertyUitls;

@Controller
public class FileDownLoadUtil {
protected Logger logger = Logger.getLogger(this.getClass());
	
	/*默认单例，@Scope("prototype")多例
	 * */
	@RequestMapping(value="/FileServerDowload")
	@Scope("prototype")
	@ResponseBody
	public void fileDowload(HttpServletRequest request, HttpServletResponse response)throws Exception{
		DbserviceController dbservice = new DbserviceController();
		
		String fileName = request.getParameter("fileName");
		String auth_key = request.getParameter("auth_key");//
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("auth_key", auth_key);
		
		//查询数据库将获取的json格式的文件路径转换成String类型的文件全路径
		String pathOfFile=dbservice.downloadParamMaps(map,request);
		JsonArrayUtil jsontostring = new JsonArrayUtil();
		String filePath = jsontostring.jsonArray(pathOfFile);
		
		//校正文件路径格式，替换乱码文件名
		File filepath = new File(filePath);
		String pa=filepath.getPath().replace("\\\\", "/");
		String path = pa.substring(0, pa.lastIndexOf("\\")); 
		File newfile=new File(path+"\\"+fileName);
		filepath.renameTo(newfile);
		String filePathAll = newfile.getPath().replaceAll("\\\\", "/");
		
		//获取服务器文件路径生成文件流
		File file = new File(filePathAll);
		String filename = file.getName();
		String fileName1 = java.net.URLDecoder.decode(filename, "UTF-8");
		if (fileName1.length() > 150) {
		 
			String guessCharset = request.getCharacterEncoding();
			//根据request的locale 得出可能的编码，中文操作系统通常是gb2312
			fileName1 = new String(filename.getBytes(guessCharset), "ISO8859-1");
		}
		 
		FileInputStream fis = new FileInputStream(file);
//		response.addHeader("Content-Disposition", "attachment; filename=" + filename);
		response.setHeader("Content-Type","application/octet-stream");
        response.setContentType("multipart/form-data");  
        
		String agent =request.getHeader("USER-AGENT");
		//兼容火狐浏览器下载
		if (null != agent && -1 != agent.indexOf("Firefox")) {
			response.addHeader("Content-Disposition", "attachment; filename=" +  new String( filename.getBytes("UTF-8"), "ISO-8859-1" ));
		}else{
			response.addHeader("Content-Disposition", "attachment; filename=" +  java.net.URLEncoder.encode(filename,"UTF-8"));
		}
		ServletOutputStream out = response.getOutputStream();
		response.setBufferSize(32768);
		int bufSize = response.getBufferSize();
		byte[] buffer = new byte[bufSize];
		BufferedInputStream bis = new BufferedInputStream(fis, bufSize);

		int bytes;
		while ((bytes = bis.read(buffer, 0, bufSize)) >= 0)
			out.write(buffer, 0, bytes);
		bis.close();
		fis.close();
		out.flush();
		out.close();
		try{
			Thread.sleep(30000);
			file.delete();
		}catch (InterruptedException e){
			e.printStackTrace();
		}
	}
//	public static void main(String[] args) {
//		
//		HttpClientCall hcc = new HttpClientCall();
//		String clientType = "pc";
//		String operator_role = "1";
//		String ipAdress = "127.0.0.1";
//		String operator_id ="opr-0001";
//		String userName = "admin";
//		String func_id = "filedownload";
//		String version_id = "V1.0";
//		String fileName = "�����ļ�";
//		Map<String,String> map = new HashMap<String,String>();
//		map.put("p1", "6cc1e1f33f08cc699395db6d040f46e3");
//		
//		Param param = new Param(clientType,ipAdress,operator_role,operator_id, userName, func_id, version_id , map);
//		String result = hcc.call(param);
//		JsonArrayUtil jsontostring = new JsonArrayUtil();
//		String filePath = jsontostring.jsonArray(result);
//		logger.info(filePath);
//		File filepath = new File(filePath);
//		String pa=filepath.getPath().replace("\\\\", "/");//�õ��ļ�·��
//		String[] splitStr = pa.split("\\.");  
//		int len = splitStr.length;  
//		String type = splitStr[len-1];
//		String path = pa.substring(0, pa.lastIndexOf("\\")); //����ϲ�·��
//		File newfile=new File(path+"\\"+fileName);//��Ҫ����޸Ĺ����ļ���ȫ·����Ҫ�½�һ��File����
//		filepath.renameTo(newfile);//�����·��
//		String filePathAll = newfile.getPath().replaceAll("\\\\", "/")+"."+type;
//		logger.info(filePathAll);
//	}
}
