package com.fh.task;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;



public class WebInvokeTask   implements Runnable {
	

	SimpleDateFormat df=new SimpleDateFormat("yyyyMMdd"); 
	SimpleDateFormat df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd"); 
	
	protected Logger logger = Logger.getLogger(this.getClass());
	String taskname="";;
	String webUrl;
	String downloadPath;
	int change=0;
	Properties pro=new Properties();
	
	public WebInvokeTask(String url,String downloadPath,String change) {
		this.webUrl=url;
		this.downloadPath=downloadPath;
		if(StringUtils.isEmpty(change))
			this.change=0;
		this.change=Integer.parseInt(change);
	//	this.downloadPath="C:/2/";
		
	}
	
	/**
	 * 仅发送请求
	 * */
	public boolean webInvokeProcess() {

	    	Calendar cal=Calendar.getInstance();
	    	cal.add(Calendar.DAY_OF_MONTH, change);
	        String data=   HttpClientUtils.excuteurl(webUrl.replace("YYYYMMDD", df.format(cal.getTime())).replace("YYYY-MM-DD", df3.format(cal.getTime())));

			
			//String data="success";
	        if(data.contains("success"))
	        	return true;
	        else
	        	return false;

	}

	/**
	 * 发送请求,并将文件下载到指定目录
	 * @return 
	 * */
	public boolean webInvokeProcessWithFile() {
		Calendar cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, change);
		 String data=   HttpClientUtils.download(webUrl.replace("YYYYMMDD", df.format(cal.getTime())).replace("YYYY-MM-DD", df3.format(cal.getTime())), downloadPath);
		
		//String data="success";
	        if(data.contains("success"))
	        	return true;
	        else
	        	return false;
		
	}

	@Override
	public void run() {
		if("".equals(downloadPath)){
			if(webInvokeProcess()){
				logger.info(taskname+df2.format(Calendar.getInstance().getTime())+"执行成功");
			}else{
				logger.info(taskname+df2.format(Calendar.getInstance().getTime())+"执行失败");
			}
		}else{
			if(webInvokeProcessWithFile()){
				logger.info(taskname+df2.format(Calendar.getInstance().getTime())+"执行成功");
			}else{
				logger.info(taskname+df2.format(Calendar.getInstance().getTime())+"执行失败");
			}
		}
		
	}

}
