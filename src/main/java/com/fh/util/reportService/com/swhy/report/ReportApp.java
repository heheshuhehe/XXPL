package com.fh.util.reportService.com.swhy.report;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import sinosoft.utils.PropertyUtils;

public class ReportApp {

	//static Logger logger = LoggerFactory.getLogger(ReportApp.class);
	
	static String 	TempDirectory = "./temp";
	static String 	FontFamily = "宋体";
	static int 		Width = 100, Height = 100; 
	static String 	FillColor = "Silver";
	static boolean 	IsTranslucent = true;
	static boolean 	IsHorizontal = false;
	static String 	PngFilePath = "./png/sign.png";
	static float 	PngFilePercent = 0.5f;
	static int 		SignXPos = 100, SignYPos = 80, SignPage = 0;
	
	static {
		try {
			Properties properties = new Properties();
			// 使用ClassLoader加载properties配置文件生成对应的输入流
			ClassLoader cl = PropertyUtils.class.getClassLoader();
			System.out.println(cl.getResource("").getPath());
			// 使用properties对象加载输入流
			properties.load(new InputStreamReader(cl.getResourceAsStream("config.properties"), "UTF-8"));
//			InputStream stream = ReportApp.class.getClassLoader().getResourceAsStream("/XinXiPiLu/src/main/resources/config.properties"); 
//			InputStreamReader in = new InputStreamReader(stream, "UTF-8");			
//			properties.load(in);

			//获取key对应的value值
			String temp = properties.getProperty("temp_directory");
			if (temp == null) TempDirectory = new File("temp").getAbsolutePath(); 
			else TempDirectory = temp;
			
			temp = properties.getProperty("watermark_font_family");
			if (temp == null) FontFamily = "宋体";
			else FontFamily = temp;
			
			temp = properties.getProperty("watermark_width");
			if (temp == null) Width = 100;
			else Width = Integer.valueOf(temp, 10);
			
			temp = properties.getProperty("watermark_height");
			if (temp == null) Height = 100;
			else Height = Integer.valueOf(temp, 10);
			
			temp = properties.getProperty("watermark_fill_color");
			if (temp == null) FillColor = "Silver"; 
			else FillColor = temp;
			
			temp = properties.getProperty("watermark_is_translucent");
			if (temp == null) IsTranslucent = true;
			else IsTranslucent = Boolean.valueOf(temp);
			
			temp = properties.getProperty("watermark_is_horizontal");
			if (temp == null) IsHorizontal = true;
			else IsHorizontal = Boolean.valueOf(temp);
			
			temp = properties.getProperty("sign_png_path");
			if (temp == null) PngFilePath = new File("png/sign.png").getAbsolutePath();
			else PngFilePath = temp;
			
			temp = properties.getProperty("sign_png_percent");
			if (temp == null) PngFilePercent = 0.5f;
			else PngFilePercent = Float.valueOf(temp);
			
			temp = properties.getProperty("sign_xpos");
			if (temp == null) SignXPos = 100;
			else SignXPos = Integer.valueOf(temp, 10);
			
			temp = properties.getProperty("sign_ypos");
			if (temp == null) SignYPos = 80;
			else SignYPos = Integer.valueOf(temp, 10);
			
			temp = properties.getProperty("sign_page");
			if (temp == null) SignPage = 100;
			else SignPage = Integer.valueOf(temp, 10);
			
		} catch (IOException e) {
//			logger.error(e.getLocalizedMessage());
			e.printStackTrace();
		}
	}
	
	public static void start(String[] args) {
		
		String excelTemplateFilePath = null;
		String docTemplateFilePath = null;
		String excelFilePath = null;
		String docxFilePath = null;
		String pdfFilePath = null;
		String jsonFilePath = null;
		String watermark = null;
		boolean isSignPdf = false;
		int sign_x = SignXPos, sign_y = SignYPos;
		
		int retValue = 0;
		Map<String, Object> jsonMap = null;
		try {			
//			logger.info("enter report service");
			
			if (args.length == 0) {
//				logger.error("no input parameter");
				return;
			}
			jsonFilePath = args[0];
			File jsonFile = new File(jsonFilePath);
			if (!jsonFile.exists() || !jsonFile.canRead()) {
//				logger.error("json file " + jsonFilePath + " noexist or can not be readable");
				return;
			}
			
			ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            jsonMap = objectMapper.readValue(jsonFile, new TypeReference<Map<String, Object>>(){});
            
//            jsonMap.forEach((k, v) -> logger.trace("Key : " + k + " Value : " + v));
            
            
            Object features = jsonMap.get("features");
            if (features != null && features instanceof Map<?, ?>) {
            	@SuppressWarnings("unchecked") 
            	Map<String, Object> featuresMap = (Map<String, Object>)features;
            	
            	Object temp = featuresMap.get("excel_tpl_path");
            	if (temp != null) excelTemplateFilePath = (String)temp; 
            	
            	temp = featuresMap.get("docx_tpl_path");
            	if (temp != null) docTemplateFilePath = (String)temp; 

            	temp = featuresMap.get("excel_path");
            	if (temp != null) excelFilePath = (String)temp; 
            	
            	 			
            	temp = featuresMap.get("docx_path");
            	if (temp != null) docxFilePath = (String)temp; 
            	
            	 			
            	temp = featuresMap.get("pdf_path");
            	if (temp != null) pdfFilePath = (String)temp; 
            	 			
            	temp = featuresMap.get("watermark");
            	if (temp != null) watermark = (String)temp; 
            	 				
            	temp = featuresMap.get("sign_pdf");
            	if (temp != null) isSignPdf = (Boolean)temp; 
            	
            	temp = featuresMap.get("sign_x");
            	if (temp != null) sign_x = (Integer)temp; 
            	
            	temp = featuresMap.get("sign_y");
            	if (temp != null) sign_y = (Integer)temp; 

            } else {
//            	logger.error("features value noexist or invalid features value type in json file");
				return;
            }
            jsonMap.remove("features");
            
            // 生成excel文档
            if (excelTemplateFilePath != null && !excelTemplateFilePath.isEmpty() && excelFilePath != null && !excelFilePath.isEmpty()) {
            	ReportHelper.createExcel(jsonMap, excelTemplateFilePath, excelFilePath);
            }
            
            // 生成docx和pdf文档
            if ( docTemplateFilePath != null && !docTemplateFilePath.isEmpty() && (docxFilePath != null && !docxFilePath.isEmpty() || pdfFilePath != null && !pdfFilePath.isEmpty())) {
            	Path docxPath = Paths.get(docxFilePath);
            	Path pdfPath  = Paths.get(pdfFilePath);
            	Path docxTempPath = Paths.get(TempDirectory, docxPath.getFileName().toString());
            	Path pdfTempPath  = Paths.get(TempDirectory, pdfPath.getFileName().toString());
            	System.out.println("docTemplateFilePath : "+docTemplateFilePath );
            	System.out.println("docxPath : "+docxPath );
            	// 生成docx文档
            	ReportHelper.createDocx(jsonMap, docTemplateFilePath, docxTempPath.toString());
            	
            	// 生成pdf文档
            	if (pdfFilePath != null && !pdfFilePath.isEmpty()) {
            		ReportHelper.createPdf(docxTempPath.toString(), pdfTempPath.toString());
            		
            		// 添加pdf文档签章
            		if (isSignPdf) {
            			ReportHelper.signPdf(pdfTempPath.toString(), pdfPath.toString(), PngFilePath, sign_x, sign_y, PngFilePercent, SignPage);
            			File testValidFile = new File(pdfTempPath.toString());
            			if ( testValidFile!=null && testValidFile.exists())Files.delete(pdfTempPath);
            		}
            		else {
            			Files.move(pdfTempPath, pdfPath, StandardCopyOption.REPLACE_EXISTING);
            		}
            		
            	}
            	// 添加docx文档水印
            	if (docxFilePath != null && !docxFilePath.isEmpty()) {
            		if (watermark != null && !watermark.isEmpty()) {
            			ReportHelper.addDocxWaterMark(docxTempPath.toString(), docxFilePath, watermark, FontFamily, Width, Height, FillColor, IsTranslucent, IsHorizontal);
            			File testValidFile = new File(docxTempPath.toString());
            			if( testValidFile!=null && testValidFile.exists())Files.delete(docxTempPath);
            		}
            		else {
            			Files.move(docxTempPath, docxPath, StandardCopyOption.REPLACE_EXISTING);
            		}
            	}
//            	//移动doc文件
//            	Files.move(docxTempPath, docxPath, StandardCopyOption.REPLACE_EXISTING);
            	
            } 
            
		}
		catch (Exception e) {
//			logger.error(e.getLocalizedMessage());
			e.printStackTrace();
			retValue = -1;
		}
		finally {
//			logger.info("exit report service");
			//System.exit(retValue);
		}
	}

}
