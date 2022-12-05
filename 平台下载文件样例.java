import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.http.HttpServletRequest;

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


	@ResponseBody
	@RequestMapping(value = "/xinxipilu/downloadFile")
	public String newFileDowload(String fileName,
			String auth_key) throws Exception {


		String downloadFileAbsolutePath = "";
		String regexp = "^((?![\\\\/]).)*$";
		Pattern p = Pattern.compile(regexp);
		if (StringUtils.isNotEmpty(fileName)) {
			Matcher m = p.matcher(fileName);
			boolean pand = m.find();
			if (pand == true) {
				try {
					// 文件服务器生成文件到服务器端
					HttpClientUtils hcu = new HttpClientUtils();
					String url = PropertyUitls.getProperties("config.properties").getProperty("FMFileDownloadUrl");
					downloadFileAbsolutePath = PropertyUitls.getProperties("config.properties")
							.getProperty("WORD2PDFDOWNLOADPATH") + "/" + fileName;
					String result = hcu.newHttpDownloadFile2(url, fileName, auth_key, downloadFileAbsolutePath, null);

					// 获取服务器文件路径生成文件流
					File file = new File(downloadFileAbsolutePath);
					String filename = file.getName();


				} catch (Exception e) {
						logger.error(request, e.toString(),e);
				} finally {

				}

			}
		}
		return downloadFileAbsolutePath;

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