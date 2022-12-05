package com.fh.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import javax.xml.ws.http.HTTPException;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;

import net.sf.json.JSONObject;


public class HTTPJiBeKeUtil {
    public static Logger logger = Logger.getLogger(HTTPJiBeKeUtil.class);

	public HTTPJiBeKeUtil() {
		// TODO Auto-generated constructor stub
	}

	public static String sendRequst (String url,  Map<String,String> resultMap, @RequestBody String json/*, ReptMFundInfo rds*/) {
	        //check validity
	        if (url == null || "".equals(url)) return "unexpected url";
	        
			url = "http://10.200.5.80:7777/xbrl/common/request";

	        try {
	            //cipher the params with public Key
	            //prepare headers
	            RestTemplate restTemplate = new RestTemplate();
	            HttpHeaders headers = new HttpHeaders();
	            //设置请求头为multipart/form-data类型
	            //headers.setContentType(MediaType.MULTIPART_FORM_DATA);
	            headers.setContentType(MediaType.APPLICATION_JSON);

	            MultiValueMap<String, Object> form = new LinkedMultiValueMap<>();
	            form.add("body", json.toString());
	            //如果需要上传/下载文件路径

	            //拼装HttpEntity
	            HttpEntity<MultiValueMap<String, Object>> datas = new HttpEntity<>(form, headers);
	            //发送http请求
	            datas.hasBody();
	            logger.info("sending request to "+url);
	            ResponseEntity<Object> responseEntity = restTemplate.postForEntity(url, datas,Object.class);
	            if(responseEntity.getStatusCode()== HttpStatus.OK){
	                //调用接口上传文件成功
	                String bodyString = responseEntity.getBody().toString();
	                //JSONObject body = JSONObject.parseObject(bodyString);
	                logger.info("返回成功！");
	                logger.info("returned plaintext is " + bodyString);
	                resultMap.put("code","200");
	                return bodyString;//responseEntity.getBody().toString();
	            } else {    //如果失败
	                logger.info("返回失败！");
	                return responseEntity.getBody().toString();
	            }
	        } catch (HTTPException e) {
	            e.printStackTrace();
	            logger.error(e.getMessage());
	            resultMap.put("code", "300");
	            resultMap.put("message", " 返回错误信息,详情见data");
	            resultMap.put("data", e.toString());
	            return e.toString();
	        }catch (Exception e) {
	            e.printStackTrace();
	            logger.error(e.getMessage());
	            resultMap.put("code", "300");
	            resultMap.put("message", " 返回错误信息,详情见data");
	            resultMap.put("data", e.toString());
	            return e.toString();
	        }
	    }
	
	
		 	/**
		 	 * 
		 	 * @param json
		 	 * @return
		 	 */
		    public static String post(JSONObject json) {

		        String result="";

		    try {

		        HttpClient client=new DefaultHttpClient();

		            HttpPost post=new HttpPost("http://10.200.5.80:7777/xbrl/common/request");

		            post.setHeader("Content-Type", "appliction/json");

		            //post.addHeader("Authorization", "Basic YWRtaW46");

		            StringEntity s=new StringEntity(json.toString());

		            s.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));

		            post.setEntity(s);

		            HttpResponse httpResponse=client.execute(post);

		            InputStream in=httpResponse.getEntity().getContent();

		            BufferedReader br=new BufferedReader(new InputStreamReader(in, "utf-8"));

		            StringBuilder strber=new StringBuilder();

		            String line=null;

		            while ((line=br.readLine())!=null) {

		                strber.append(line+"\n");

		            }

		            in.close();

		            result=strber.toString();

		            if(httpResponse.getStatusLine().getStatusCode()!=200){

		                result="服务器异常";

		            }

		    } catch (Exception e) {

		      System.out.println("请求异常");

		      throw new RuntimeException(e);

		    }

		    System.out.println("result=="+result);

		    return result;

		  }

		    /**
		     * 
		     * @param url
		     * @param msg
		     * @return
		     */
		    public static String sendPostJson(String url, String json) {
		    	url="http\\://50.2.68.184:9002/xp-file-server/uploadFile";
				 json = ("&data=[{\r\n"
						+ "	\"fund_code\": \"99\",\r\n"
						+ "	\"date_no\": \"202201\"\r\n"
						+ "},{\r\n"
						+ "	\"fund_code\": \"5007\",\r\n"
						+ "	\"date_no\": \"202201\"\r\n"
						+ "}]");
		        PrintWriter out = null;
		        BufferedReader in = null;
		        String result = "";


		        try {
		            URL realUrl = new URL(url);
		            // 打开和URL之间的连接
		            URLConnection conn = realUrl.openConnection();
		            // 设置通用的请求属性
		            conn.setRequestProperty("accept", "*/*");
		            conn.setRequestProperty("connection", "Keep-Alive");
		            conn.setRequestProperty("content-type", "application/x-www-form-urlencoded");
		            conn.setRequestProperty("Accept-Charset", "utf-8");
		            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
		            // 发送POST请求必须设置如下两行
		            conn.setDoOutput(true);
		            conn.setDoInput(true);
		            
		            // 获取URLConnection对象对应的输出流
		            out = new PrintWriter(conn.getOutputStream());
		            // 发送请求参数
		            logger.info("param:{}"+json);
		            out.print(json);
		            // flush输出流的缓冲
		            out.flush();
		            // 定义BufferedReader输入流来读取URL的响应
		            in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		            String line;
		            while ((line = in.readLine()) != null) {
		                result += line;
		            }
		        } catch (Exception e) {
		            logger.error(e.getMessage(), e);
		        }
		        //使用finally块来关闭输出流、输入流
		        finally {
		            try {
		                if (out != null) {
		                    out.close();
		                }
		                if (in != null) {
		                    in.close();
		                }
		            } catch (IOException ex) {
		                ex.printStackTrace();
		            }
		        }
		        return result;
		    }

				    
		    
		    /**
		     * 发送json请求通知及贝克生成报告
		     * @param textMap
		     * @param pathUrl
		     * @param userName
		     * @param json
		     * @return
		     * @throws IOException
		     */
		    public static String doJiBeiKePost(HashMap<String, String> textMap ,String pathUrl,String userName, String json) throws IOException {
		    	
		        //String pathUrl = "http://localhost:19090/oneapon/api/jsonws/vgc-apon-it-equipment-portlet.ienewemployeesapplication/upload-file";
		        String BOUNDARY = "---------------------------123821742118716";
		        logger.info("url=====================:"+pathUrl);
		        URL url = new URL(pathUrl);
		        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();

		        httpConn.setRequestMethod("POST");
		        httpConn.setDoOutput(true);
		        httpConn.setRequestProperty("Content-Type","application/json;" );
		        logger.info(httpConn.getRequestProperties());

		        OutputStream out = new DataOutputStream(httpConn.getOutputStream());
		        byte[] jsonByte = json.getBytes("UTF-8");
		        out.write(jsonByte);
		        out.flush();
		        out.close();
		        
		        
		        Reader in = new BufferedReader(new InputStreamReader(httpConn.getInputStream(), "UTF-8"));

		        StringBuilder sb = new StringBuilder();
		        for (int c; (c = in.read()) >= 0;)
		            sb.append((char)c);
		        String responseString = sb.toString();
		        logger.info(responseString);
		        return responseString;

		    }

		 
		 
		 
//		 public void testOK () {
//			 OkHttpClient client = new OkHttpClient().newBuilder()
//					  .build();
//					MediaType mediaType = MediaType.parse("application/json");
//					RequestBody body = RequestBody.create(mediaType, "{\r\n    \"_sysCode_\": \"xxplxt\",\r\n    \"_userCode_\": \"xtyh\",\r\n    \"_bizType_\": \"XBRL\",\r\n    \"_bizOP_\": \"create\",\r\n    \"checkCode\": \"654321\",\r\n    \"data\": {\r\n        \"requestUUID\": \"4faab9af2acb4e70995414a7a62224c4\",\r\n        \"fundCode\": \"SCL373\",\r\n        \"reportType\": \"PB0001\",\r\n        \"reportEndDate\": \"2022-03-31\",\r\n        \"companyCode\": \"P1021826\"\r\n    }\r\n}");
//					Request request = new Request.Builder()
//					  .url("http://10.200.5.80:7777/xbrl/common/request")
//					  .method("POST", body)
//					  .addHeader("Content-Type", "application/json")
//					  .build();
//					Response response = client.newCall(request).execute();
//		 }
	 


	 
}
