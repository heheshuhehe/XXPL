/**
 * 
 */
package com.fh.controller.system.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;

import com.fh.util.Logger;
import com.fh.util.PropertyUitls;
import com.sinosoft.scs.core.Param;


/**
 * @author scnjjs(jiang.shan@sinosoft.com.cn)
 *
 * @project 外部系统接口调用组件
 *
 * @file HttpClientCall.java
 *
 * @description //TODOdescription
 *
 * @time 2016年6月5日 下午3:47:13
 */
public class HttpClientCall {
	protected static Logger logger = Logger.getLogger(HttpClientCall.class);

	public String call(Param param,HttpServletRequest request, String func_id) {
		long t1 = System.currentTimeMillis();
		if (param.getOperatorRole() == null || param.getFuncId() == null || param.getUserName() == null || param.getVersionId() == null) {
			return "参数不全，请检查！";
		}
		String info="";
		// 创建默认的httpClient实例.    
		CloseableHttpClient httpclient = HttpClients.createDefault();
		// 创建httppost    
        HttpPost httppost=null; 
        if(param.getFuncId().startsWith("YWB_")){
    	    httppost = new HttpPost(PropertyUitls.getSysConfigSet("interfaceURLYWB"));
        }else{
    	    httppost = new HttpPost(PropertyUitls.getSysConfigSet("interfaceURL"));
        }
        // 创建参数队列    
        List<NameValuePair> formparams = new ArrayList<NameValuePair>(); 
		
		formparams.add(new BasicNameValuePair("userName", param.getUserName()));
		formparams.add(new BasicNameValuePair("matchedCloumn", param.getMatchedCloumn()));
		formparams.add(new BasicNameValuePair("operatorRole", param.getOperatorRole()));
		formparams.add(new BasicNameValuePair("funcId", param.getFuncId()));
		formparams.add(new BasicNameValuePair("versionId", param.getVersionId()));
        if(param.getBizParams()!=null && !param.getBizParams().isEmpty()){
			for (Entry<String, String> entry : param.getBizParams().entrySet()) {
				formparams.add(new BasicNameValuePair(entry.getKey(), String.valueOf(entry.getValue())));
			}
        }
        CloseableHttpResponse response = null;
		UrlEncodedFormEntity uefEntity;
		try {  
            uefEntity = new UrlEncodedFormEntity(formparams, "UTF-8"); 
            
            httppost.setEntity(uefEntity);  
            RequestConfig requestConfig =  RequestConfig.custom().build();
            HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
            httpClientBuilder.setDefaultRequestConfig(requestConfig);
            response = httpclient.execute(httppost);
            HttpEntity entity = response.getEntity();  
            if (entity != null) {  
                 info = EntityUtils.toString(entity, "UTF-8");
            }  
        } catch (ClientProtocolException e) {  
//              logger.error(request, e.toString(),e);
        } catch (UnsupportedEncodingException e1) {  
//        	  logger.error(request, e1.toString(),e1);
        } catch (IOException e2) {  
//        	  logger.error(request, e2.toString(),e2);
        } finally {  
            try {  
            	response.getEntity().getContent().close();
                httpclient.close();  
                long t2 = System.currentTimeMillis();
//            	logger.info(request,"【"+func_id+"】查询成功，此次查询用时【"+String.valueOf(t2-t1)+"】");
            } catch (IOException e) {  
//                logger.error(request, e.toString(),e);
            }  
        }  
		return info;
	}
}
