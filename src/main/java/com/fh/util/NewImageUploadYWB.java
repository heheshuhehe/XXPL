package com.fh.util;

//package com.fh.util;

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
import java.util.Properties;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;


/**
 * 上传图片以及文件至平台
 * 创建人：ywb 创建时间：2016年05月09日
 * @version
 */
public class NewImageUploadYWB {

    protected static Logger logger = Logger.getLogger(NewImageUploadYWB.class);
/*    *//**
     * @param file 			//文件对象
     * @param filePath		//上传路径
     * @param fileName		//文件名
     * @return  文件名
     * @throws Exception
     */
    public static String fileUp(MultipartFile file, String filePath, String fileName,Map map) throws Exception{
        CheckFileSuffix checkFileSuffix= new CheckFileSuffix();
    	if(checkFileSuffix.checkFile(file.getOriginalFilename())){
            copyFile(file.getInputStream(), filePath,file.getOriginalFilename()).replaceAll("-", "");
            String response = NewImageUploadYWB.imageUp(filePath,  file.getOriginalFilename(),map);
            return response;
        }else{
            return "99";
        }
    }

    /**
     * 写文件到当前目录的upload目录中
     *
     * @param in
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
        if(CheckFileSuffix.checkFile(fileName)){//判断后缀名是否符合要求
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
                    String hy_jx_fileName = HY_JX_Coder.URLEncode(fileName.getBytes("UTF-8"),"UTF-8");//codedFileName, "UTF-8"); 

                    map.put("fileName", hy_jx_fileName);

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
                    //word高版本
                    if(fileName.endsWith(".docx") || fileName.endsWith(".xlsx")){
                        sb.append("Content-Type:application/vnd.openxmlformats-officedocument.wordprocessingml.document\r\n\r\n");
                    }else{
                        sb.append("Content-Type:application/octet-stream\r\n\r\n");
                    }

                    byte[] data = sb.toString().getBytes("utf-8");
                    out.write(data);

                    //读取本地文件
                    in = new DataInputStream(new FileInputStream(file));
                    int bytes = 0;
                    byte[] bufferOut = new byte[1024];
                    while ((bytes = in.read(bufferOut)) != -1) {
                        out.write(bufferOut, 0, bytes);
                    }
                    // out.write("\r\n".getBytes()); //多个文件时，二个文件之间加入这个
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
                logger.error("发送POST请求出现异常！" + e);
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
        }else{
            logger.error("文件后缀名不符合要求！");
            return "99";
        }
    }

    public  static String imageUpForUeditor(String filestr) throws Exception{
        StringBuffer sb = new StringBuffer();
        StringBuffer returnSb = new StringBuffer();
        String response="";
        String BOUNDARY = "---------------------------123821742118716";

        OutputStream out=null;
        DataInputStream in=null;
        BufferedReader reader=null;
        HttpURLConnection connection=null;
        try {

            Properties properties =  PropertyUitls.getProperties("config.properties");
            if(properties!=null){
                URL url=new URL(properties.getProperty("ImgServerUrlForEditor"));
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
                //拼接请求参数
                StringBuffer paramSb=new StringBuffer();
                out.write("\r\n".getBytes()); //多个文件时，二个文件之间加入这个
                File file = new File(filestr);
                sb.append("--");
                sb.append(BOUNDARY);
                sb.append("\r\n");
                sb.append("Content-Disposition: form-data;name=\"file\";filename=\""+ file.getName() + "\"\r\n");
//	           sb.append("Content-Type:application/octet-stream\r\n\r\n");
                //word高版本
                String fileName = file.getName();
                System.out.println("上传百度编辑器附件:"+fileName);
                if(file.getName().endsWith(".docx") ||
                        file.getName().endsWith(".DOCX")){
                    sb.append("Content-Type:application/vnd.openxmlformats-officedocument.wordprocessingml.document\r\n\r\n");
                }else if( file.getName().endsWith(".xlsx")||
                        file.getName().endsWith(".XLSX")){
                    sb.append("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet\r\n\r\n");
                }else{
                    sb.append("Content-Type:application/octet-stream\r\n\r\n");
                }
                byte[] data = sb.toString().getBytes("utf-8");
                out.write(data);

                //读取本地文件
                in = new DataInputStream(new FileInputStream(file));
                int bytes = 0;
                byte[] bufferOut = new byte[1024];
                while ((bytes = in.read(bufferOut)) != -1) {
                    out.write(bufferOut, 0, bytes);
                }
//	           out.write("\r\n".getBytes()); //多个文件时，二个文件之间加入这个
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
            e.printStackTrace();
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

