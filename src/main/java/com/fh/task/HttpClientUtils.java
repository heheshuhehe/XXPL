package com.fh.task;
import java.io.File;  
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.apache.http.Header;  
import org.apache.http.HeaderElement;  
import org.apache.http.HttpEntity;  
import org.apache.http.HttpResponse;  
import org.apache.http.NameValuePair;  
import org.apache.http.client.HttpClient;  
import org.apache.http.client.methods.HttpGet;  
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;  
  
/** 
 * ˵�� 
 * ����httpclient�����ļ� 
 * maven���� 
 * <dependency> 
*           <groupId>org.apache.httpcomponents</groupId> 
*           <artifactId>httpclient</artifactId> 
*           <version>4.0.1</version> 
*       </dependency> 
*  ������http�ļ���ͼƬ��ѹ���ļ� 
*  bug����ȡresponse header��Content-Disposition��filename������������ 
 * @author tanjundong 
 * 
 */  
public class HttpClientUtils  implements Runnable {  
  
    public static final int cache = 10 * 1024;  
    public static final boolean isWindows;  
    public static final String splash;  
    public static final String root;  
    static {  
        if (System.getProperty("os.name") != null && System.getProperty("os.name").toLowerCase().contains("windows")) {  
            isWindows = true;  
            splash = "\\";  
            root="D:";  
        } else {  
            isWindows = false;  
            splash = "/";  
            root="/search";  
        }  
    }  
      
    /** 
     * ����url�����ļ����ļ�����response headerͷ�л�ȡ 
     * @param url 
     * @return 
     */  
    public static String download(String url) {  
        return download(url, null);  
    }  
  
    /** 
     * ����url�����ļ������浽filepath�� 
     * @param url 
     * @param filepath 
     * @return 
     */  
    public static String download(String url, String filepath) {  
        try {  
            HttpClient client = HttpClientBuilder.create().build();//
            HttpGet httpget = new HttpGet(url);  
            HttpResponse response = client.execute(httpget);  
  
            HttpEntity entity = response.getEntity();  
            InputStream is = entity.getContent();  
            String filename = getFileName(response);  
            if (filepath == null)  
                filepath = getFilePath(response);  
            File file = new File(filepath+"/"+URLDecoder.decode(filename,"utf-8"));  
            file.getParentFile().mkdirs();  
            FileOutputStream fileout = new FileOutputStream(file);  
            /** 
             * ����ʵ������Ч�� ���û�������С 
             */  
            byte[] buffer=new byte[cache];  
            int ch = 0;  
            while ((ch = is.read(buffer)) != -1) {  
                fileout.write(buffer,0,ch);  
            }  
            is.close();  
            fileout.flush();  
            fileout.close();  
  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
    public static String excuteurl(String url) {  
        try {  
            HttpClient client = HttpClientBuilder.create().build();//
            HttpGet httpget = new HttpGet(url);  
       	 HttpResponse response = client.execute(httpget);  
   	  
            if(response!=null){
            
                 HttpEntity entity = response.getEntity();
                 return EntityUtils.toString(entity);
            }
           
            
            
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
    /** 
     * ��ȡresponseҪ���ص��ļ���Ĭ��·�� 
     * @param response 
     * @return 
     */  
    public static String getFilePath(HttpResponse response) {  
        String filepath = root + splash;  
        String filename = getFileName(response);  
  
        if (filename != null) {  
            filepath += filename;  
        } else {  
            filepath += getRandomFileName();  
        }  
        return filepath;  
    }  
    /** 
     * ��ȡresponse header��Content-Disposition�е�filenameֵ 
     * @param response 
     * @return 
     */  
    public static String getFileName(HttpResponse response) {  
        Header contentHeader = response.getFirstHeader("Content-Disposition");  
        String filename = null;  
        if (contentHeader != null) {  
            HeaderElement[] values = contentHeader.getElements();  
            if (values.length == 1) {  
                NameValuePair param = values[0].getParameterByName("filename");  
                if (param != null) {  
                    try {  
                        //filename = new String(param.getValue().toString().getBytes(), "utf-8");  
                        //filename=URLDecoder.decode(param.getValue(),"utf-8");  
                        filename = param.getValue();  
                    } catch (Exception e) {  
                        e.printStackTrace();  
                    }  
                }  
            }  
        }  
        return filename;  
    }  
    /** 
     * ��ȡ����ļ��� 
     * @return 
     */  
    public static String getRandomFileName() {  
        return String.valueOf(System.currentTimeMillis());  
    }  
    public static void outHeaders(HttpResponse response) {  
        Header[] headers = response.getAllHeaders();  
        for (int i = 0; i < headers.length; i++) {  
            System.out.println(headers[i]);  
        }  
    }  


	@Override
	public void run() {
		

		
	   	    Properties pro=new Properties();
	    	InputStream inputStream =HttpClientUtils.class.getClassLoader().getResourceAsStream("com/swhysc/config.pro");
	    	try {
	    		InputStreamReader in =new InputStreamReader(inputStream,"GBK");
				pro.load(in);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    
	    	
	    	SimpleDateFormat df=new SimpleDateFormat("yyyyMMdd"); 
	    	SimpleDateFormat df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	    	Calendar  cal =Calendar.getInstance();
	    	cal.add(Calendar.DAY_OF_MONTH, -1);
	    	String DateStr=df.format(cal.getTime());
	    	System.out.println("��ʼ����TA�깺��طֺ����ݽӿ�����"+df2.format(Calendar.getInstance().getTime()));
	        String url1="http://172.18.152.128/simu/downloadTAdataTG?d_ywrq="+DateStr;  
	    	String url2="http://172.18.152.128/simu/downloadTAdata?d_ywrq="+DateStr;  
	    	String YYYY=DateStr.substring(0,4);String MM=DateStr.substring(4,6); String DD=DateStr.substring(6,8);
	        String tgpath=pro.get("tgfilepath").toString(); 
	       // tgpath=tgpath.replace("YYYY", YYYY); tgpath=tgpath.replace("MM", MM);tgpath=tgpath.replace("DD", DD);
	        tgpath=tgpath.replace("YYYYMMDD", YYYY+MM+DD);
	        tgpath=tgpath.replace("YYYY-MM-DD", YYYY+"-"+MM+"-"+DD);
	        String wbpath=pro.get("wbfilepath").toString();
	        wbpath=wbpath.replace("YYYYMMDD", YYYY+MM+DD);
	        wbpath=wbpath.replace("YYYY-MM-DD", YYYY+"-"+MM+"-"+DD);
	    	
	    	
	        HttpClientUtils.download(url1, tgpath);
	        try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        HttpClientUtils.download(url2, wbpath);
	        
	        System.out.println("TA�깺��طֺ����ݽӿ��������"+df2.format(Calendar.getInstance().getTime()));
	}  
}