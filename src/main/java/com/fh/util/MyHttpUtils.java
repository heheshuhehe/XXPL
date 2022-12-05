package com.fh.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.imageio.stream.FileImageInputStream;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class MyHttpUtils {

	public static String doGet(String url) {
        // ������
        InputStream is = null;
        BufferedReader br = null;
        String result = null;
        // ����httpClientʵ��
        HttpClient httpClient = new HttpClient();
        // ����http������������ʱʱ�䣺15000����
        // �Ȼ�ȡ���ӹ����������ٻ�ȡ��������,�ٽ��в����ĸ�ֵ
        httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(15000);
        // ����һ��Get����ʵ������
        GetMethod getMethod = new GetMethod(url);
        // ����get����ʱΪ60000����
        getMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 60000);
        // �����������Ի��ƣ�Ĭ�����Դ�����3�Σ���������Ϊtrue�����Ի��ƿ��ã�false�෴
        getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler(3, true));
        try {
            // ִ��Get����
            int statusCode = httpClient.executeMethod(getMethod);
            // �жϷ�����
            if (statusCode != HttpStatus.SC_OK) {
                // ���״̬�뷵�صĲ���ok,˵��ʧ����,��ӡ������Ϣ
                System.err.println("Method faild: " + getMethod.getStatusLine());
            } else {
                // ͨ��getMethodʵ������ȡԶ�̵�һ��������
                is = getMethod.getResponseBodyAsStream();
                // ��װ������
                br = new BufferedReader(new InputStreamReader(is, "UTF-8"));

                StringBuffer sbf = new StringBuffer();
                // ��ȡ��װ��������
                String temp = null;
                while ((temp = br.readLine()) != null) {
                    sbf.append(temp).append("\r\n");
                }

                result = sbf.toString();
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // �ر���Դ
            if (null != br) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != is) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            // �ͷ�����
            getMethod.releaseConnection();
        }
        return result;
    }

    public static String doPost(String url, Map<String, Object> paramMap) {
        // ��ȡ������
        InputStream is = null;
        BufferedReader br = null;
        String result = null;
        // ����httpClientʵ������
        HttpClient httpClient = new HttpClient();
        // ����httpClient����������������ʱʱ�䣺15000����
        httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(15000);
        // ����post���󷽷�ʵ������
        PostMethod postMethod = new PostMethod(url);
        // ����post����ʱʱ��
        postMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 60000);

        NameValuePair[] nvp = null;
        // �жϲ���map����paramMap�Ƿ�Ϊ��
        if (null != paramMap && paramMap.size() > 0) {// ��Ϊ��
            // ������ֵ�����������飬��СΪ�����ĸ���
            nvp = new NameValuePair[paramMap.size()];
            // ѭ��������������map
            Set<Entry<String, Object>> entrySet = paramMap.entrySet();
            // ��ȡ������
            Iterator<Entry<String, Object>> iterator = entrySet.iterator();

            int index = 0;
            while (iterator.hasNext()) {
                Entry<String, Object> mapEntry = iterator.next();
                // ��mapEntry�л�ȡkey��value������ֵ�����ŵ�������
                try {
                    nvp[index] = new NameValuePair(mapEntry.getKey(),
                            new String(mapEntry.getValue().toString().getBytes("UTF-8"), "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                index++;
            }
        }
        // �ж�nvp�����Ƿ�Ϊ��
        if (null != nvp && nvp.length > 0) {
            // ��������ŵ�requestBody������
            postMethod.setRequestBody(nvp);
        }
        // ִ��POST����
        try {
            int statusCode = httpClient.executeMethod(postMethod);
            // �ж��Ƿ�ɹ�
            if (statusCode != HttpStatus.SC_OK) {
                System.err.println("Method faild: " + postMethod.getStatusLine());
            }
            // ��ȡԶ�̷��ص�����
            is = postMethod.getResponseBodyAsStream();
            postMethod.getResponseBodyAsString();
            // ��װ������
            br = new BufferedReader(new InputStreamReader(is, "UTF-8"));

            StringBuffer sbf = new StringBuffer();
            String temp = null;
            while ((temp = br.readLine()) != null) {
                sbf.append(temp).append("\r\n");
            }

            result = sbf.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
           // �ر���Դ
            if (null != br) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != is) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            // �ͷ�����
            postMethod.releaseConnection();
        }
        return result;
    }
    public String post(String url,String xmlFileNamefullpath){
        //�ر�
        System.setProperty("org.apache.commons.logging.Log", "org.apache.commons.logging.impl.SimpleLog");
        System.setProperty("org.apache.commons.logging.simplelog.showdatetime", "true");
        System.setProperty("org.apache.commons.logging.simplelog.log.org.apache.commons.httpclient", "stdout");

        //����httpclient���߶���
        HttpClient client = new HttpClient();
        //����post���󷽷�
        PostMethod myPost = new PostMethod(url);
        //��������ʱʱ��
        client.setConnectionTimeout(300*1000);
        String responseString = null;
        try{
            //��������ͷ������
            myPost.setRequestHeader("Content-Type","text/xml");
            myPost.setRequestHeader("charset","utf-8");

            //���������壬��xml�ı����ݣ�ע������д�����ַ�ʽ��һ����ֱ�ӻ�ȡxml�����ַ�����һ���Ƕ�ȡxml�ļ���������ʽ
//          myPost.setRequestBody(xmlString);

           // InputStream body=this.getClass().getResourceAsStream("/"+xmlFileName);
          
            myPost.setRequestEntity(new StringRequestEntity(readTxtFile(xmlFileNamefullpath,"utf-8")));
//            myPost.setRequestEntity(new StringRequestEntity(xmlString,"text/xml","utf-8"));
            int statusCode = client.executeMethod(myPost);
            if(statusCode == HttpStatus.SC_OK){
                BufferedInputStream bis = new BufferedInputStream(myPost.getResponseBodyAsStream());
                byte[] bytes = new byte[1024];
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                int count = 0;
                while((count = bis.read(bytes))!= -1){
                    bos.write(bytes, 0, count);
                }
                byte[] strByte = bos.toByteArray();
                responseString = new String(strByte,0,strByte.length,"utf-8");
                bos.close();
                bis.close();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        myPost.releaseConnection();
        return responseString;
    }
    public static String  readTxtFile(String filePath,String encoding){
    	String result="";
        try {
           
                File file=new File(filePath);
                if(file.isFile() && file.exists()){ //�ж��ļ��Ƿ����
                    InputStreamReader read = new InputStreamReader(
                    new FileInputStream(file),encoding);//���ǵ������ʽ
                    BufferedReader bufferedReader = new BufferedReader(read);
                    String lineTxt = null;
                    while((lineTxt = bufferedReader.readLine()) != null){
                    	result+= lineTxt;
                    }
                    read.close();
        }else{
            System.out.println("�Ҳ���ָ�����ļ�");
        }
        } catch (Exception e) {
            System.out.println("��ȡ�ļ����ݳ���");
            e.printStackTrace();
        }
        return result;
     
    }


    public String postxmlString(String url,String xmlcontent){
        //�ر�
        System.setProperty("org.apache.commons.logging.Log", "org.apache.commons.logging.impl.SimpleLog");
        System.setProperty("org.apache.commons.logging.simplelog.showdatetime", "true");
        System.setProperty("org.apache.commons.logging.simplelog.log.org.apache.commons.httpclient", "stdout");

        //����httpclient���߶���
        HttpClient client = new HttpClient();
        //����post���󷽷�
        PostMethod myPost = new PostMethod(url);
        //��������ʱʱ��
        client.setConnectionTimeout(300*1000);
        String responseString = null;
        try{
            //��������ͷ������
            myPost.setRequestHeader("Content-Type","text/xml");
            myPost.setRequestHeader("charset","utf-8");

            //���������壬��xml�ı����ݣ�ע������д�����ַ�ʽ��һ����ֱ�ӻ�ȡxml�����ַ�����һ���Ƕ�ȡxml�ļ���������ʽ
//          myPost.setRequestBody(xmlString);

           // InputStream body=this.getClass().getResourceAsStream("/"+xmlFileName);
           // InputStream body =   new  FileInputStream(new File(xmlFileNamefullpath)) ;
           // myPost.setRequestBody(body);
            myPost.setRequestEntity(new StringRequestEntity(xmlcontent,"text/xml","utf-8"));
            int statusCode = client.executeMethod(myPost);
            if(statusCode == HttpStatus.SC_OK){
                BufferedInputStream bis = new BufferedInputStream(myPost.getResponseBodyAsStream());
                byte[] bytes = new byte[1024];
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                int count = 0;
                while((count = bis.read(bytes))!= -1){
                    bos.write(bytes, 0, count);
                }
                byte[] strByte = bos.toByteArray();
                responseString = new String(strByte,0,strByte.length,"utf-8");
                bos.close();
                bis.close();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        myPost.releaseConnection();
        return responseString;
    }
    
   
}
