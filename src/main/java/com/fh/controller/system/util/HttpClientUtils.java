package com.fh.controller.system.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.fh.util.Logger;

/**
 * @web http://www.mobctrl.net
 * @author Zheng Haibo
 */
public class HttpClientUtils {
	protected Logger logger = Logger.getLogger(this.getClass());
	public static final int THREAD_POOL_SIZE = 5;

	public interface HttpClientDownLoadProgress {
		public void onProgress(int progress);
	}
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
	private static HttpClientUtils httpClientDownload;

	private ExecutorService downloadExcutorService;

	public HttpClientUtils() {
		downloadExcutorService = Executors.newFixedThreadPool(THREAD_POOL_SIZE);
	}

	public static HttpClientUtils getInstance() {
		if (httpClientDownload == null) {
			httpClientDownload = new HttpClientUtils();
		}
		return httpClientDownload;
	}

	/**
	 * �����ļ�
	 * 
	 * @param url
	 * @param filePath
	 */
	public void download(final String url,final String fileName,final String auth_key, final String filePath) {
		downloadExcutorService.execute(new Runnable() {

			@Override
			public void run() {
				httpDownloadFile(url,fileName,auth_key,filePath, null);
			}
		});
	}

	/**
	 * �����ļ�
	 * 
	 * @param url
	 * @param filePath
	 * @param progress
	 *            ��Ȼص�
	 */
	public void download(final String url,final String fileName,final String auth_key, final String filePath,
			final HttpClientDownLoadProgress progress) {
		downloadExcutorService.execute(new Runnable() {

			@Override
			public void run() {
				httpDownloadFile(url,fileName,auth_key,filePath, null);
			}
		});
	}

	/**
	 * 
	 * @param url
	 * @param filePath
	 */
	public String httpDownloadFile(String url,String fileName,String auth_key,String filePath, Map<String, String> headMap) {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpGet httpGet = new HttpGet(url+"?fileName="+fileName.replaceAll(" ", "")+"&auth_key="+auth_key);
			setGetHead(httpGet, headMap);
			CloseableHttpResponse response1 = httpclient.execute(httpGet);

			try {
//				logger.info(null,response1.getStatusLine());
				HttpEntity httpEntity = response1.getEntity();
				InputStream is = httpEntity.getContent();
				if(is!=null&&!"".equals(is)){
					ByteArrayOutputStream output = new ByteArrayOutputStream();
					byte[] buffer = new byte[1024*10];
					int r = 0;
					long totalRead = 0;
					
					while ((r = is.read(buffer)) > 0) {
						output.write(buffer, 0, r);
						totalRead += r;
					}
					FileOutputStream fos = new FileOutputStream(filePath);
					output.writeTo(fos);
					output.flush();
					output.close();
					fos.close();
					EntityUtils.consume(httpEntity);
				}
			} finally {
				response1.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return filePath;
	}
	
	
	

	
    
	/**
	 * 
	 * @param url
	 * @param filePath
	 */
	public String newHttpDownloadFile2(String url,String fileName,String auth_key,String filePath, Map<String, String> headMap) {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpGet httpGet = new HttpGet(url+"?auth_key="+auth_key);
			setGetHead(httpGet, headMap);
			CloseableHttpResponse response1 = httpclient.execute(httpGet);

			try {
//				logger.info(null,response1.getStatusLine());
				FileOutputStream fos = new FileOutputStream(filePath);
				HttpEntity httpEntity = response1.getEntity();
				InputStream is = httpEntity.getContent();
				if(is!=null&&!"".equals(is)){
					BufferedOutputStream output = new BufferedOutputStream(fos);
					byte[] buffer = new byte[1024*8];
					int r = 0;
					long totalRead = 0;
					
					while ((r = is.read(buffer)) != -1) {
						output.write(buffer, 0, r);
						totalRead += r;
					}
					logger.info("totalRead is "+totalRead);
//					output.writeTo(fos);
					output.flush();
					output.close();
					fos.close();
					EntityUtils.consume(httpEntity);
				}
			} finally {
				response1.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return filePath;
	}
														
	/**
	* 从某个接口取返回数据内容
	* @param url
	* @return
	*/
	public  String newHttpDownloadFile(String url,String fileName,String auth_key,String filePath, Map<String, String> headMap) throws IOException {
		
		String strUrl=(url+"?fileName="+fileName.replaceAll(" ", "")+"&auth_key="+auth_key);
			URL url1 = null;
		BufferedReader reader = null;
		HttpURLConnection connection = null;
		InputStreamReader ins = null ;
		try {
			url1 = new URL(strUrl);
			connection = (HttpURLConnection) url1.openConnection();
			connection.setConnectTimeout(2*1000);
			connection.setReadTimeout(2*1000);
		
			connection.connect();
			ins =new InputStreamReader(connection.getInputStream(),"ISO8859-1");
			reader = new BufferedReader(ins);
			StringBuffer sb = new StringBuffer();
			String line;
		
			while ((line = reader.readLine()) != null) {
				sb.append(line+ "\n");
			}
			writeFile(filePath,sb.toString());
			return sb.toString();
		} catch (IOException e) {
			System.out.println("Error getURL:" + e);
			System.out.println("Error getURL:" + strUrl);
		}finally{
			if(ins != null) {
				try {
					ins.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(reader != null) {
				try {
				reader.close();
				} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}
			}
			if(connection != null) {
				connection.disconnect();
			}
		}
		return null;

	}																																															
	
	
	public  void writeFile(String fileName, String fileContent)
	{
	try
	{
	File f = new File(fileName);
	if (!f.exists())
	{
	f.createNewFile();
	}
	OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f),"ISO8859-1");
	BufferedWriter writer=new BufferedWriter(write);
	writer.write(fileContent);
	writer.close();
	} catch (Exception e)
	{
	e.printStackTrace();
	}
	}
	
	
	
	/**
	 * 
	 * @param url
	 * @return
	 */
	public String httpGet(String url) {
		return httpGet(url,null);
	}

	/**
	 * http get����
	 * 
	 * @param url
	 * @return
	 */
	public String httpGet(String url, Map<String, String> headMap) {
		String responseContent = null;
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpGet httpGet = new HttpGet(url);
			CloseableHttpResponse response1 = httpclient.execute(httpGet);
			setGetHead(httpGet, headMap);
			try {
//				logger.info(null,response1.getStatusLine());
				HttpEntity entity = response1.getEntity();
				InputStream is = entity.getContent();
				StringBuffer strBuf = new StringBuffer();
				byte[] buffer = new byte[4096];
				int r = 0;
				while ((r = is.read(buffer)) > 0) {
					strBuf.append(new String(buffer, 0, r, "UTF-8"));
				}
				responseContent = strBuf.toString();
//				logger.info(null,"debug:" + responseContent);
				EntityUtils.consume(entity);
			} finally {
				response1.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return responseContent;
	}

	public String httpPost(String url, Map<String, String> paramsMap) {
		return httpPost(url, paramsMap, null);
	}

	/**
	 * http��post����
	 * 
	 * @param url
	 * @param paramsMap
	 * @return
	 */
	public String httpPost(String url, Map<String, String> paramsMap,
			Map<String, String> headMap) {
		String responseContent = null;
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpPost httpPost = new HttpPost(url);
			setPostHead(httpPost, headMap);
			setPostParams(httpPost, paramsMap);
			CloseableHttpResponse response = httpclient.execute(httpPost);
			try {
//				logger.info(null,response.getStatusLine());
				HttpEntity entity = response.getEntity();
				InputStream is = entity.getContent();
				StringBuffer strBuf = new StringBuffer();
				byte[] buffer = new byte[4096];
				int r = 0;
				while ((r = is.read(buffer)) > 0) {
					strBuf.append(new String(buffer, 0, r, "UTF-8"));
				}
				responseContent = strBuf.toString();
				EntityUtils.consume(entity);
			} finally {
				response.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
//		logger.info(null,"responseContent = " + responseContent);
		return responseContent;
	}

	/**
	 * ����POST�Ĳ���
	 * 
	 * @param httpPost
	 * @param paramsMap
	 * @throws Exception
	 */
	private void setPostParams(HttpPost httpPost, Map<String, String> paramsMap)
			throws Exception {
		if (paramsMap != null && paramsMap.size() > 0) {
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			Set<String> keySet = paramsMap.keySet();
			for (String key : keySet) {
				nvps.add(new BasicNameValuePair(key, paramsMap.get(key)));
			}
			httpPost.setEntity(new UrlEncodedFormEntity(nvps));
		}
	}

	/**
	 * ����http��HEAD
	 * 
	 * @param httpPost
	 * @param headMap
	 */
	private void setPostHead(HttpPost httpPost, Map<String, String> headMap) {
		if (headMap != null && headMap.size() > 0) {
			Set<String> keySet = headMap.keySet();
			for (String key : keySet) {
				httpPost.addHeader(key, headMap.get(key));
			}
		}
	}

	/**
	 * 
	 * @param httpGet
	 * @param headMap
	 */
	private void setGetHead(HttpGet httpGet, Map<String, String> headMap) {
		if (headMap != null && headMap.size() > 0) {
			Set<String> keySet = headMap.keySet();
			for (String key : keySet) {
				httpGet.addHeader(key, headMap.get(key));
			}
		}
	}

	/**
	 * 远程访问合同制作接口
	 * 
	 * @param url
	 * @param filePath
	 */
	public String httpContractMakeDownloadFile(HttpServletRequest request,String url,String wjmc,String wjbs,String jjdm,String jjmc,String filePath, Map<String, String> headMap) {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpGet httpGet = new HttpGet(url+"?wjmc="+wjmc.replaceAll(" ", "")+"&wjbs="+wjbs+"&jjdm="+jjdm+"&jjmc="+jjmc.replaceAll(" ", ""));
//			logger.info(request,"HTTP INFO 01 "+"wjmc:"+wjmc+";wjbs:"+wjbs+";jjdm:"+jjdm+";jjmc:"+jjmc);
			setGetHead(httpGet, headMap);
			CloseableHttpResponse response1 = httpclient.execute(httpGet);
			try {
				//logger.info(request, response1.getStatusLine());
				
				//logger.info(request,"HTTP INFO 02   调用远程服务器:"+response1.getStatusLine());
				HttpEntity httpEntity = response1.getEntity();
				InputStream is = httpEntity.getContent();
				
				ByteArrayOutputStream output = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int r = 0;
				long totalRead = 0;
				while ((r = is.read(buffer)) > 0) {
					output.write(buffer, 0, r);
					totalRead += r;
				}
				//logger.info(request,"HTTP INFO 03   调用远程服务器:filePath"+filePath);
				FileOutputStream fos = new FileOutputStream(filePath);
				
				output.writeTo(fos);
				output.flush();
				output.close();
				fos.close();
				EntityUtils.consume(httpEntity);
			} finally {
				response1.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			//logger.info(request,"HTTP ERROR 01   调用远程服务器报错:"+e);
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
				//logger.info(request,"HTTP ERROR 02   调用远程服务器报错:"+e);
			}
		}
		//logger.info(request,"HTTP INFO 04   调用远程服务器成功");
		return filePath;
	}
	
	
	/**
	 * 远程访问合同制作划款授权书接口
	 * 
	 * @param url
	 * @param filePath
	 * @throws Exception 
	 */
	public String httpContractMakeTransferAuthorization(HttpServletRequest request,String url,String fm_id,String fund_code,String auth_key,String valid_date,String ischecktransfer,String handlemans,String auditmans,String checkmans,String filePath, Map<String, String> headMap) throws Exception {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		
		try {
			HttpGet httpGet = new HttpGet(
					url+"?fm_id="+fm_id
					   +"&fund_code="+fund_code
					   +"&auth_key="+auth_key
					   +"&valid_date="+valid_date
					   +"&ischecktransfer="+ischecktransfer
					   +"&handlemans="+handlemans
					   +"&auditmans="+auditmans
					   +"&checkmans="+checkmans);
			setGetHead(httpGet, headMap);
			CloseableHttpResponse response1 = httpclient.execute(httpGet);
			/*System.out.println();
			if(exist(url)==false){
				throw new Exception("请求失败！");
			}*/
			try {
				HttpEntity httpEntity = response1.getEntity();
				InputStream is = httpEntity.getContent();
				
				ByteArrayOutputStream output = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int r = 0;
				long totalRead = 0;
				while ((r = is.read(buffer)) > 0) {
					output.write(buffer, 0, r);
					totalRead += r;
				}
				FileOutputStream fos = new FileOutputStream(filePath);
				
				output.writeTo(fos);
				output.flush();
				output.close();
				fos.close();
				EntityUtils.consume(httpEntity);
			} finally {
				response1.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return filePath;
	}
	
	private static boolean exist(String url) {
	    try {
	        URL u = new URL(url);
	        HttpURLConnection huc = (HttpURLConnection) u.openConnection();
	        huc.setRequestMethod ("HEAD");
	        huc.setConnectTimeout(5000); //视情况设置超时时间
	        huc.connect();
	        return huc.getResponseCode() == HttpURLConnection.HTTP_OK;
	    } catch (Exception e) {
	       return false;
	    }
	}
	
	
	
	/**
	 * 远程访问估值表下载
	 * 
	 * @param url
	 * @param filePath
	 */
	public String httpBatchGuzhiTableFileUpload(
			HttpServletRequest request,
			String url,
			String funcId,
			String pageNumber,
			String sheetNumber,
			String operType,
			String dataParaString,
			String dataParaString2,
			String modelname,
			String level,
			String filePath, 
			String filename,
			Map<String, String> headMap) {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpGet httpGet = new HttpGet(
					url+"?funcId="+funcId+
					    "&pageNumber="+pageNumber +
					    "&sheetNumber="+sheetNumber+
					    "&operType="+operType +
					    "&dataParaString="+dataParaString +
					    "&dataParaString2="+dataParaString2 +
					    "&modelname="+modelname+
					    "&level="+level+
					    "&filename="+filename
					);
			setGetHead(httpGet, headMap);
			CloseableHttpResponse response1 = httpclient.execute(httpGet);
			try {
				//logger.info(request, response1.getStatusLine());
				//logger.info(request,"HTTP INFO 调用远程服务器:"+response1.getStatusLine());
				HttpEntity httpEntity = response1.getEntity();
				InputStream is = httpEntity.getContent();
				
				ByteArrayOutputStream output = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int r = 0;
				long totalRead = 0;
				while ((r = is.read(buffer)) > 0) {
					output.write(buffer, 0, r);
					totalRead += r;
				}
				//logger.info(request,"HTTP INFO 03   调用远程服务器:filePath"+filePath);
				FileOutputStream fos = new FileOutputStream(filePath);
				
				output.writeTo(fos);
				output.flush();
				output.close();
				fos.close();
				EntityUtils.consume(httpEntity);
			} finally {
				response1.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			//logger.info(request,"HTTP ERROR 调用远程服务器报错:"+e);
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
				//logger.info(request,"HTTP ERROR调用远程服务器报错:"+e);
			}
		}
		//logger.info(request,"HTTP INFO 调用远程服务器成功");
		return filePath;
	}
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
	             * 根据实际运行效果 设置缓冲区大小 
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
	 /*
	  * filename 仅传递文件名称即可  不含 扩展名和点
	  * 
	  * */
	 public static String download(String url, String filepath,String filename) {  
		 String fullname="";
	        try {  
	            HttpClient client = HttpClientBuilder.create().build();//
	            HttpGet httpget = new HttpGet(url);  
	            HttpResponse response = client.execute(httpget);  
	           String   origion_filename = getFileName(response); 
	           	String extName=getFileExtension(new File(origion_filename));
	            HttpEntity entity = response.getEntity();  
	            InputStream is = entity.getContent();  
	          
	            if (filepath == null)  
	                filepath = getFilePath(response);  
	            File file = new File(filepath+"/"+URLDecoder.decode(filename,"utf-8")+"."+extName);  
	            file.getParentFile().mkdirs();  
	            FileOutputStream fileout = new FileOutputStream(file);  
	            /** 
	             * 根据实际运行效果 设置缓冲区大小 
	             */  
	            byte[] buffer=new byte[cache];  
	            int ch = 0;  
	            while ((ch = is.read(buffer)) != -1) {  
	                fileout.write(buffer,0,ch);  
	            }  
	            is.close();  
	            fileout.flush();  
	            fileout.close();  
	  fullname=file.getAbsolutePath();
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        return fullname;  
	    } 
	 /** 
	     * 获取response要下载的文件的默认路径 
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
	    	public static String getFileExtension(File file) {
	    		        String fileName = file.getName();
	    		        if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
	    		        return fileName.substring(fileName.lastIndexOf(".")+1);
	    		        else return "";
	    	}

	    /** 
	     * 获取response header中Content-Disposition中的filename值 
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
	    }   public static String getRandomFileName() {  
	        return String.valueOf(System.currentTimeMillis());  
	    }  
	    public static void outHeaders(HttpResponse response) {  
	        Header[] headers = response.getAllHeaders();  
	        for (int i = 0; i < headers.length; i++) {  
	            System.out.println(headers[i]);  
	        }  
	    }  
	    public static void main(String[] args) {
			System.out.println(HttpClientUtils.getFileExtension(new File("hh.lkj")));
		}

}

