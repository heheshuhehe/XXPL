package com.fh.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.ibatis.annotations.Case;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;

import com.fh.dao.OuterJiBaoXinXiPiLuDao;
import com.fh.dao.OuterJiDuGengXinXXPLDao;
import com.fh.dao.OuterXinXiPiLuDao;
import com.fh.dao.XinxipiluDao;
import com.fh.util.Constants;
import com.fh.util.DateUtil;
import com.fh.util.DelAllFile;
import com.fh.util.FileZip;
import com.fh.util.MyFilePart;
import com.fh.util.PageData;
import com.fh.util.PropertyUitls;
import com.fh.util.file.CopyFileTool;
import com.fh.util.file.DeleteFile;
import com.fh.util.file.FileUtil;
import com.fh.util.reportService.com.swhy.report.ReportApp;
import com.fh.util.reportService.com.swhy.report.ReportHelper;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptCreateJson4Xml;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.jibao.Rept_qu_fund_info;
import com.swhy.xxpl.model.jibao.Rept_qu_ivst_info;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.DefaultDefaultValueProcessor;
import net.sf.json.util.CycleDetectionStrategy;
import sinosoft.utils.PropertyUtils;

@Service("OuterXXPLService")
public class OuterXXPLService {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	@Resource(name = "outerXinXinPiLuDao") 			//???????????????????????????????????????
	OuterXinXiPiLuDao outerXinXinPiLuDao ;  
	
	@Resource(name = "outerJiBaoXinXiPiLuDao") 		//???????????????????????????
	OuterJiBaoXinXiPiLuDao outerJiBaoXinXiPiLuDao ;  
	
	@Resource(name = "outerJiDuGengXinXXPLDao") 	//???????????????????????????
	OuterJiDuGengXinXXPLDao outerJiDuGengXinXXPLDao ;  
	
	@Resource(name = "XinXiPiLuYueBaoServiceNew")
	XinXiPiLuYueBaoServiceNew yueBaoS;
	
	@Resource(name = "xinxiPiLuSMOService")
	OuterSMOService outerSMO;
	
	@Resource(name = "reptCreateJson4Xml")
	ReptCreateJson4Xml reptCreateJson4Xml; 
	
	@Resource(name = "datasourceXXPLHDMDS") 
	DataSource datasourceXXPLHDMDS ;  
	//??????
	private  final Boolean SIGN_PDF 	= true;
	private  final Integer SIGN_X		= 440;
	private  final Integer SIGN_Y		= 630;
	private  final String TOBEPRINTED	= "1";
	private  final String INTHELIST		= "1";			//?????????
	private  final String OUTOFLIST		= "0";			//?????????
	private  final String MANULADD		= "2";			//????????????
	public final String ALLSELECT 		= "??????";
	static final String LIQUIDATIONEXCELFOLDER 	= 
			PropertyUitls.getProperties("config.properties").getProperty("LIQUIDATIONEXCELFOLDER"); 
	static final String QUIEXCELFOLDER 	= 
			PropertyUitls.getProperties("config.properties").getProperty("QUIEXCELFOLDER"); 
	static final String SMOEXCELFOLDER 	= 
			PropertyUitls.getProperties("config.properties").getProperty("SMOEXCELFOLDER"); 
	static final String WORDFOLDER 		= "word\\";
	static final String PDFFOLDER 		= "PDF\\";
	public static final String QUIJSONFOLDER = 
			PropertyUitls.getProperties("config.properties").getProperty("QUIJSONFOLDER"); 

	public static final String REPORTINGSERVICEJARPATH 		= PropertyUtils.getSysConfigSet("reportservicejarPath");
	public static final String MONTHLYREPORTEXCELTEMPLATE	="????????????????????????.xls";
	public static final String MONTHLYREPORTDOCSTEMPLATE	="??????????????????.docx";
	public static final String QUARTERLYREPORTEXCELTEMPLATE	="????????????????????????.xls";
	public static final String QUARTERLYREPORTDOCSTEMPLATE	="??????????????????.xls";
	public static final String JBKCHECKGOOD = "1";
	public static final String JBKUNCHECKED = "0";
	public static final String JBKCHECKBAD = "2";
	public static final String NONEEDCHECK = "9";
	
	
	/**
	 * ?????????????????????????????????????????????????????????????????????
	 * @param fundCode
	 * @param dateType
	 * @param reportType
	 * @param rds Rept_Disc_Situ
	 * @return	????????????
	 */
//	public Boolean pushQUI2FMprocc(String fundCode, String dateType, String reportType,ReptDiscSitu rds) {
//		
//		
//		return true;
//	}
//	
	
	/**
	 * ?????????????????????????????? qui ?????? smo ??????
	 * @param fileDirectoryPath	???????????????
	 * @param fileName
	 * @return fm??????????????????
	 */
	public String uploadBatchExcelZip2FM(String reportType, String fileDirectoryPath, String zipFileName, Map<String,String> resultMap) {
		final String FMbatchUploadURL=PropertyUitls.getProperties("config.properties").getProperty("FMbatchUpload"+reportType+"URL"); 
		String feedbackfromFM ="";
		String url = FMbatchUploadURL;//"http:// 50.2.68.184:9002/xp-file-server/uploadFile";
		try {
			logger.info("			FileZip.zip("+fileDirectoryPath+", "+zipFileName+");\r\n"
					+ "");
			//if(!reportType.equals("SMO")) {
				FileZip.zip(fileDirectoryPath, zipFileName);
			//}else {
		//		zipFileName = "W:\\????????????\\????????????\\?????????????????????\\202207\\excel\\excel.zip";
			//}
			PostMethod post = new PostMethod(url);			
			post.getParams().setContentCharset("utf-8");
			String charset=post.getParams().getContentCharset();
            post.setRequestHeader("enctype","multipart/form-data");
            List<Part> list = new ArrayList<Part>();
           
            //list.add(new MyFilePart("zipfile", new File("D:\\Users\\lixuqiang\\Desktop\\jdgx.zip"),null,"UTF-8"));
            list.add(new MyFilePart("zipfile", new File(zipFileName),null,"UTF-8"));
            Part[] parts = new Part[list.size()];
           
            parts =  list.toArray(parts);
            post.setRequestEntity(new MultipartRequestEntity(parts, post.getParams()));
            
            HttpClient httpClient = new HttpClient();
            logger.info("["+reportType+"]??????"+zipFileName+"???"+FMbatchUploadURL);
            httpClient.executeMethod(post);
            feedbackfromFM = post.getResponseBodyAsString();
            logger.info(feedbackfromFM);
		} catch (FileNotFoundException e) {
			e.printStackTrace();logger.error(e);
			resultMap.put("code",Constants.OTHER_ERRORCODE);
			resultMap.put("message","fail,cannot zip file; "+e.getMessage());
			resultMap.put("data",e.getMessage()+e.getCause());

		} catch (HttpException e) {
			e.printStackTrace();logger.error(e);
			resultMap.put("code",Constants.OTHER_ERRORCODE);
			resultMap.put("message","failed when sending request to "+FMbatchUploadURL+", file:"+fileDirectoryPath);
			resultMap.put("data",e.getMessage()+e.getCause());			
		} catch (IOException e) {
			e.printStackTrace();logger.error(e);
			resultMap.put("code",Constants.OTHER_ERRORCODE);
			resultMap.put("message","failed when sending request to "+FMbatchUploadURL+", file:"+fileDirectoryPath);
			resultMap.put("data",e.getMessage()+e.getCause());			
		} catch (Exception e) {
			e.printStackTrace();logger.error(e);
			resultMap.put("code",Constants.OTHER_ERRORCODE);
			resultMap.put("message","failed when sending request to "+FMbatchUploadURL+", file:"+fileDirectoryPath);
			resultMap.put("data",e.getMessage()+e.getCause());					
		}finally {
			logger.info("???????????????"+ fileDirectoryPath);
			 DelAllFile.delAllFile(fileDirectoryPath);	//???????????????
			 //DeleteFile.deleteZip(zipFileName);
		}

		return feedbackfromFM;
	}
	
	
	/**
	 * ??????QUI(??????excel)
	 * @param funds
	 * @param reportType // month, quater, year
	 * @return resultMSG, ???????????????????????????
	 * 						targetDirPath, ?????????zip????????????
	 * 						toZipAbsolutePath, ??????zip????????????zip???????????????????????????
	 * 						JSONInvestorPath???json????????????
	 * 						fail???????????????
	 * 						success,????????????
	 * @throws InterruptedException 
	 */
	public Map<String,String> printQUI (List<Map<String,String>> funds,  Map<String,String> resultMap, String recollect)  {
		String time= DateUtil.getTimeQUI();
		logger.info("Start printing QUI, time:" +time);
		String targetDirPath = QUIEXCELFOLDER+time+"\\";
		if (Constants.LIQUIDATION.equals(recollect)) {
			targetDirPath = LIQUIDATIONEXCELFOLDER;
		}
		FileUtil.createDir(targetDirPath);
		Map<String,String> resultMSG = new HashedMap();
		resultMSG.put("targetDirPath",targetDirPath);
		resultMSG.put("toZipAbsolutePath",QUIEXCELFOLDER+time+".zip");
		
		if (funds==null || funds.size()<1) {	
			resultMap.put("fail","??????????????????");
			resultMSG.put("fail","??????????????????");
			return resultMSG;
		}
		resultMSG.put("targetDirPath",targetDirPath);
		Integer fail=0;		Integer success=0; JSONArray wrongListArray= new JSONArray();
		Map<String,String> duplicated = new HashMap<String,String>();
		for (Map<String,String> fund: funds) {		//???????????????????????????
			try {
				if (duplicated.get(fund.get("fund_code")) ==null ) {duplicated.put(fund.get("fund_code"), "1"); }
				else {continue;}
				ReptDiscSitu  reptDiscSitu = //xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Disc_Situ", null, fund.get("fund_code"),  fund.get("date_no"),"wb", ReptDiscSitu.class).get(0);
							xinXiPiLuDao.get1DiscSituByType_Month_FundCode("QUI",fund.get("date_no"),fund.get("fund_code"))	;
				Rept_qu_fund_info rept_qu_fund_info = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_fund_info", null, fund.get("fund_code"), fund.get("date_no"),"wb",Rept_qu_fund_info.class).get(0);
				//????????????????????????????????????
				logger.info("????????????????????????");
				if (!callProcedure2PushQUI2FMDB(reptDiscSitu.getFund_code(),reptDiscSitu.getRept_date())) {continue;}
				logger.info("????????????????????????");

				
				//????????????????????????????????????
				if (recollect==null || !("0".equals(recollect))) {
					if (!callProcedure2PushQUI2FMDB(reptDiscSitu.getFund_code(),reptDiscSitu.getRept_date())) {continue;}
				}
				//????????????
				Map<String, Object> features = xinXiPiLuDao.getPaths();
				//???????????????
				String folderPath = features.get("tgzx_disk_drive").toString()+
						features.get("quaterly_update_report_path").toString()
						+"\\"+reptDiscSitu.getDate_no()
						+"\\"+reptDiscSitu.getServ_scop()+"\\";
				FileUtil.createDir(folderPath+"json\\");
//				String JSONPriavtePath = folderPath+ "json\\"+rept_qu_fund_info.getFund_name()+"?????????????????????.json";
				String JSONInvestorPath = folderPath+ "json\\"+reptDiscSitu.getFund_name()+"???????????????.json";

				//???????????????json
//				JSONObject quaterlyPrivateJson = generateQuaterlyUpdatePrivacyEquityReportJSON(reptDiscSitu, rept_qu_fund_info, fillQuaterlyUpdateFeatures(rept_qu_fund_info, reptDiscSitu, null,folderPath, "private"));//??????json?????????json?????????????????????
				if (Constants.LIQUIDATION.equals(recollect)) {folderPath=targetDirPath;}
				features=  fillQuaterlyUpdateFeatures(rept_qu_fund_info, reptDiscSitu, null,folderPath,"investor");
				JSONObject quaterlyInvestorJson = generateQuaterlyUpdateInvestorReportJSON(reptDiscSitu, null,features);//??????json?????????json?????????????????????

				if (quaterlyInvestorJson!=null && yueBaoS.printingJSONtoFolder(quaterlyInvestorJson, JSONInvestorPath ) && !Constants.LIQUIDATION.equals(recollect))  { 
					if(yueBaoS.updatePrinting3FilesfromJSON( reptDiscSitu, JSONInvestorPath, yueBaoS.PRINTED)) {//???????????????????????????
						outerXinXinPiLuDao.updateReptDiscSituMemo("??????????????????????????????", reptDiscSitu.getFund_code(), "QUI", reptDiscSitu.getDate_no(), Constants.SUCCESSFULLYGENERATED);
						success++;
						resultMSG.put("JSONInvestorPath", JSONInvestorPath);
						resultMap.put("success","success");
					}	
					else {
						fail++;
						pushWrongJSONObject(wrongListArray, reptDiscSitu.getFund_code(), reptDiscSitu.getDate_no(), "?????????????????????");
						if (resultMSG.get("fail")==null) {
							resultMSG.put("fail", "?????????????????????????????????????????????????????????excel??????,?????? " +reptDiscSitu.getFund_name()); 
						}else {
							resultMSG.put("fail", resultMSG.get("fail")+", "+reptDiscSitu.getFund_name());
						}
					}
				}
				else {logger.error("Printing JSON for "+ reptDiscSitu.getFund_code()+ " "+ reptDiscSitu.getFund_name()+" failed");}
				String[] argument = {JSONInvestorPath};
				ReportApp.start(argument);			//??????excel
				String excelPath = String.valueOf( features.get("excel_path")); 
				resultMSG.put("excelAbsolutePath", excelPath);
				resultMSG.put("file_path", excelPath);
				if (Constants.LIQUIDATION .equals(recollect)) { return resultMSG;}
				File fSource = new File(excelPath);
				File fTarget = new File(targetDirPath+String.valueOf(features.get("fileName"))+".xlsx" );
				fTarget.createNewFile();
				logger.info("fSource :"+excelPath);
				logger.info("fTarget :"+targetDirPath+String.valueOf(features.get("fileName")) );
				CopyFileTool.copyFile(fSource, fTarget);
				logger.info("End printing QUI to "+JSONInvestorPath);

			} catch (IOException e) {
				e.printStackTrace();logger.error(e);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());
				resultMap.put("data", e.getMessage());
				resultMap.put("code", "500");
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	
				logger.error(e);
			} catch (InterruptedException e2) {
				e2.printStackTrace();logger.error(e2);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());		
				resultMap.put("code", "500");
				resultMap.put("data", e2.getMessage());
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	

			} catch (Exception e) {
				e.printStackTrace();logger.error(e);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());
				resultMap.put("data", e.getMessage());
				resultMap.put("code", "500");
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	
				logger.error(e);
			}
		}
		resultMSG.put("fail", fail.toString());
		resultMSG.put("success", success.toString());
		resultMap.put("success", success.toString());	
		resultMap.put("fail", fail.toString());
		return resultMSG;
	}	

	/**
	 * ??????????????????liquidation(??????excel)
	 * @param funds
	 * @param reportType // month, quater, year
	 * @return resultMSG, ???????????????????????????
	 * 						targetDirPath, ?????????zip????????????
	 * 						toZipAbsolutePath, ??????zip????????????zip???????????????????????????
	 * 						JSONInvestorPath???json????????????
	 * 						fail???????????????
	 * 						success,????????????
	 * @throws InterruptedException 
	 */
	public Map<String,String> printLiquidation (List<Map<String,String>> funds,  Map<String,String> resultMap, String recollect)  {
		StopWatch stopWatch = new StopWatch("??????????????????||??????");
		stopWatch.start("????????????");

		String targetDirPath = LIQUIDATIONEXCELFOLDER;
		FileUtil.createDir(targetDirPath);
		Map<String,String> resultMSG = new HashedMap();
		resultMSG.put("targetDirPath",targetDirPath);
		
		if (funds==null || funds.size()<1) {	
			resultMap.put("fail","??????????????????");
			resultMSG.put("fail","??????????????????");
			return resultMSG;
		}
		resultMSG.put("targetDirPath",targetDirPath);
		Integer fail=0;		Integer success=0; JSONArray wrongListArray= new JSONArray();
		Map<String,String> duplicated = new HashMap<String,String>();
		for (Map<String,String> fund: funds) {		//???????????????????????????
			try {
				if (duplicated.get(fund.get("fund_code")) ==null ) {duplicated.put(fund.get("fund_code"), "1"); }
				else {continue;}
				ReptDiscSitu  reptDiscSitu = //xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Disc_Situ", null, fund.get("fund_code"),  fund.get("date_no"),"wb", ReptDiscSitu.class).get(0);
							xinXiPiLuDao.get1DiscSituByType_Month_FundCode("QUI",fund.get("date_no"),fund.get("fund_code"))	;
				if ( reptDiscSitu==null) {
					logger.error("erronues fund is printing! the printing-json function is skipped ????????????????????????");
					continue;
				}
				//????????????????????????????????????
				stopWatch.stop();
				stopWatch.start("??????????????????");
				logger.info("????????????????????????");
				if (!callProcedure2PushQUI2FMDB(reptDiscSitu.getFund_code(),reptDiscSitu.getRept_date())) {continue;}
				logger.info("????????????????????????");
				stopWatch.stop();

				stopWatch.start("??????????????????");
				//????????????????????????????????????
				if (recollect==null || !("0".equals(recollect))) {
					if (!callProcedure2PushQUI2FMDB(reptDiscSitu.getFund_code(),reptDiscSitu.getRept_date())) {continue;}
				}
				stopWatch.stop();
				stopWatch.start("??????json");
				//????????????
				Map<String, Object> features = xinXiPiLuDao.getPaths();
				//???????????????
				String folderPath = features.get("tgzx_disk_drive").toString()+
						features.get("quaterly_update_report_path").toString()
						+"\\"+reptDiscSitu.getDate_no()
						+"\\"+reptDiscSitu.getServ_scop()+"\\";
				FileUtil.createDir(folderPath+"json\\");
				String JSONInvestorPath = folderPath+ "json\\"+reptDiscSitu.getFund_name()+"???????????????.json";

				//???????????????json
				if (Constants.LIQUIDATION.equals(recollect)) {folderPath=targetDirPath;}
				features=  fillLiquidationFeatures(reptDiscSitu, null,folderPath,"investor");
				JSONObject quaterlyInvestorJson = generateQuaterlyUpdateInvestorReportJSON(reptDiscSitu, null,features);//??????json?????????json?????????????????????
                if (quaterlyInvestorJson!=null && yueBaoS.printingJSONtoFolder(quaterlyInvestorJson, JSONInvestorPath ) )  { 
//                if(yueBaoS.updatePrinting3FilesfromJSON( reptDiscSitu, JSONInvestorPath, yueBaoS.PRINTED)) {//???????????????????????????
//                    outerXinXinPiLuDao.updateReptDiscSituMemo("????????????????????????", reptDiscSitu.getFund_code(), "QUI", reptDiscSitu.getDate_no(), Constants.SUCCESSFULLYGENERATED);
                    success++;
                    resultMSG.put("JSONInvestorPath", JSONInvestorPath);
                }    else {
					resultMSG.put("excelAbsolutePath", "");
					resultMSG.put("file_path", "");		
					resultMap.put("data", "????????????json "+JSONInvestorPath);
					resultMap.put("code", Constants.PRINTER_ERRORCODE);
					resultMap.put("fail", fail.toString());		
                    resultMap.put("success","fail");
                    return resultMSG;
                }				
				stopWatch.stop();
				stopWatch.start("??????excel??????");
				System.out.println("?????????????????????" + stopWatch.getTaskCount());
				String[] argument = {JSONInvestorPath};
				ReportApp.start(argument);			//??????excel
				stopWatch.stop();
//				System.out.println(stopWatch.shortSummary());
				System.out.println( stopWatch.prettyPrint());
				String excelPath = String.valueOf( features.get("excel_path"));
				File testExcelFile = new File (excelPath);
				if (testExcelFile.exists()) {
					resultMSG.put("excelAbsolutePath", excelPath);
					resultMSG.put("file_path", excelPath);					
				}else {
					resultMSG.put("excelAbsolutePath", "");
					resultMSG.put("file_path", "");		
					resultMap.put("data", "???????????? "+excelPath);
					resultMap.put("code", Constants.OTHER_ERRORCODE);
					resultMap.put("fail", fail.toString());					
				}
				return resultMSG;
			} catch (IOException e) {
				e.printStackTrace();logger.error(e);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());
				resultMap.put("data", e.getMessage());
				resultMap.put("code", "500");
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	
				logger.error(e);
			} catch (InterruptedException e2) {
				e2.printStackTrace();logger.error(e2);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());		
				resultMap.put("code", "500");
				resultMap.put("data", e2.getMessage());
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	

			} catch (Exception e) {
				e.printStackTrace();logger.error(e);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());
				resultMap.put("data", e.getMessage());
				resultMap.put("code", "500");
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	
				logger.error(e);
			}
		}
		resultMSG.put("fail", fail.toString());
		resultMSG.put("success", success.toString());
		resultMap.put("success", success.toString());	
		resultMap.put("fail", fail.toString());
		return resultMSG;
	}	
		
	
	/**
	 * ??????SMO(??????excel)
	 * @param funds
	 * @param reportType // month, quater, year
	 * @return resultMSG, ???????????????????????????
	 * 						targetDirPath, ?????????zip????????????
	 * 						toZipAbsolutePath, ??????zip????????????zip???????????????????????????
	 * 						JSONInvestorPath???json????????????
	 * 						fail???????????????
	 * 						success,????????????
	 * @throws Exception 
	 * @throws InterruptedException 
	 */
	public Map<String,String> printSMO (List<Map<String,String>> funds,  Map<String,String> resultMap, String realTime) {
		String SMOPATH = PropertyUitls.getSysConfigSet("SMOPATH");
		Integer fail=0;		Integer success=0; JSONArray wrongListArray= new JSONArray();
		String time= DateUtil.getTimeQUI();
		logger.info("Start printing SMO, time:" +time);
		String targetDirPath = SMOEXCELFOLDER+time+"\\";
		FileUtil.createDir(targetDirPath);
		Map<String,String> resultMSG = new HashedMap();
		resultMSG.put("targetDirPath",targetDirPath);
		resultMSG.put("toZipAbsolutePath",SMOEXCELFOLDER+time+".zip");
		try {
			String msg= outerSMO.createJson(funds);//?????????????????????json
		} catch (Exception e1) {
			resultMap.put("code", "500");
			resultMap.put("fail", fail.toString());
			resultMap.put("message", "??????json?????????");	
			e1.printStackTrace();
			logger.error(e1);
		}		
		int i=-1;
		for (Map<String, String> fund:funds) {
			try {				
				i++;
				String date_no= funds.get(i).get("date_no");
				String magr_name= funds.get(i).get("magr_name");
				String magr_num= funds.get(i).get("magr_p_code");
				String excelPath=SMOPATH+date_no+"/excel/";
				logger.info("excelPath is"+excelPath);
				//resultMSG.put("targetDirPath",excelPath);
				String[] argument = {SMOPATH+date_no+"\\json\\"+String.valueOf(funds.get(i).get("magr_no"))+".json"};
				String excelFileName=magr_num+"_"+magr_name+"-??????????????????????????????????????????_"+date_no+".xlsx";
				ReportApp.start(argument);			//??????excel
				resultMSG.put("excelAbsolutePath", excelPath);
				File fSource = new File(excelPath+excelFileName);
				File fTarget = new File(targetDirPath+excelFileName);
				fTarget.createNewFile();
				logger.info("fSource :"+excelPath+excelFileName);
				logger.info("fTarget :"+targetDirPath+excelFileName );
				CopyFileTool.copyFile(fSource, fTarget);
				//???????????????????????????????????????
				outerXinXinPiLuDao.updateReptDiscSituMemo("????????????", funds.get(i).get("magr_no"), "SMO", date_no, Constants.SUCCESSFULLYGENERATED);
				success++;
				resultMSG.put("excelPath", excelPath);
				resultMap.put("success","success");
				logger.info("End printing SMO to "+targetDirPath);

			} catch (Exception e) {
				e.printStackTrace();logger.error(e);
				resultMSG.put("fail", fail.toString());
				resultMSG.put("success", success.toString());
				resultMap.put("data", e.getMessage());
				resultMap.put("code", "500");
				resultMap.put("fail", fail.toString());
				resultMap.put("message", "???????????????");	
				resultMap.put("success", success.toString());	
				resultMap.put("wrongListArray", wrongListArray.toString());	
				logger.error(e);
			}
		}
		

		return resultMSG;
	}
	
	public void testZip () throws Exception {
		FileZip.zip("D:\\XXPLTemp\\202201", "D:\\XXPLTemp\\202201.zip");
		
	}
	
	
	/**
	 * Either build a new feature or finish a feature for investor information Report
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return
	 * @throws DecoderException 
	 */
	public Map<String, Object> fillQuaterlyUpdateFeatures (Rept_qu_fund_info rept_qu_fund_info, ReptDiscSitu reptDiscSitu, Map<String, Object> features,String folderPath, String privateOrInvestor ) throws DecoderException {
		features= features==null?new HashMap<String, Object>():features;
		String fundName = reptDiscSitu.getFund_name();
		String quaterNoString = reptDiscSitu.getDate_no();
		Map<String, Object>pathsMap = xinXiPiLuDao.getPaths();
		String fileNamePostFix = "private".equals(privateOrInvestor)?"???????????????????????????_":"?????????????????????_";
		String fileName = outerXinXinPiLuDao.getfundNumByfund_code( reptDiscSitu.getFund_code()).get(0).get("fund_num").toString()+"_"+fundName+"_????????????"+ fileNamePostFix+ quaterNoString+"_"+reptDiscSitu.getRept_date(); 
		fileName=fileName.replaceAll("/", "");
		features.putIfAbsent("fileName", fileName);
		String modelFilePath = pathsMap.get("tgzx_disk_drive").toString()+pathsMap.get("quaterly_update_report_model_path").toString()+"\\";
//		features.putIfAbsent("excel_tpl_path", modelFilePath+pathsMap.get(reptDiscSitu.hasCFID()? 
//				"monthly_report_cfid_model_excel":"monthly_report_model_excel"));		//??????????????????????????????
		features.putIfAbsent("excel_tpl_path", modelFilePath+pathsMap.get("private".equals(privateOrInvestor)?"quaterly_update_?????????????????????_model_excel": "quaterly_update_???????????????_model_excel"));
//		features.putIfAbsent("docx_tpl_path", modelFilePath+pathsMap.get("quaterly_report_model_word"));
		features.putIfAbsent("excel_path", folderPath+yueBaoS.EXCELFOLDER+fileName +".xlsx");
//		features.putIfAbsent("docx_path", folderPath+xinXiPiLuService.WORDFOLDER+fileName+".docx");
//		features.putIfAbsent("pdf_path", folderPath+xinXiPiLuService.PDFFOLDER+fileName+".pdf");
		features.putIfAbsent("watermark", reptDiscSitu.getFund_name());
		features.putIfAbsent("sign_pdf", "true".equals(pathsMap.get("quaterly_update_report_sign_pdf"))?true:false);
		features.putIfAbsent("sign_x", (Integer.valueOf(pathsMap.get("quaterly_update_report_sign_X").toString()) ));
		features.putIfAbsent("sign_y", (Integer.valueOf(pathsMap.get("quaterly_update_report_sign_Y").toString()) ));
		features.putIfAbsent("sign_page", (Integer.valueOf(pathsMap.get("quaterly_update_report_sign_page").toString()) ));
//		FileUtil.createDir(folderPath+xinXiPiLuService.WORDFOLDER);
		FileUtil.createDir(folderPath+yueBaoS.EXCELFOLDER);
//		FileUtil.createDir(folderPath+xinXiPiLuService.PDFFOLDER);
		return features;
	}	
	
	/**
	 * Either build a new feature or finish a feature for investor information Report
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return
	 */
	public Map<String, Object> fillLiquidationFeatures ( ReptDiscSitu reptDiscSitu, Map<String, Object> features,String folderPath, String privateOrInvestor ) {
		features= features==null?new HashMap<String, Object>():features;
		String fundName = reptDiscSitu.getFund_name();
		String quaterNoString = reptDiscSitu.getDate_no();
		Map<String, Object>pathsMap = xinXiPiLuDao.getPaths();
		String fileNamePostFix = "private".equals(privateOrInvestor)?"???????????????????????????_":"?????????????????????_";
		String fileName = reptDiscSitu.getFund_num()+"_"+fundName+"_????????????"+ fileNamePostFix+ quaterNoString+"_"+reptDiscSitu.getRept_date(); 
		fileName=fileName.replaceAll("/", "");
		features.putIfAbsent("fileName", fileName);
		String modelFilePath = pathsMap.get("tgzx_disk_drive").toString()+pathsMap.get("quaterly_update_report_model_path").toString()+"\\";
		features.putIfAbsent("excel_tpl_path", modelFilePath+pathsMap.get("private".equals(privateOrInvestor)?"quaterly_update_?????????????????????_model_excel": "quaterly_update_???????????????_model_excel"));
		features.putIfAbsent("excel_path", folderPath+yueBaoS.EXCELFOLDER+fileName +".xlsx");
		features.putIfAbsent("watermark", reptDiscSitu.getFund_name());
		features.putIfAbsent("sign_pdf", "true".equals(pathsMap.get("quaterly_update_report_sign_pdf"))?true:false);
		features.putIfAbsent("sign_x", (Integer.valueOf(pathsMap.get("quaterly_update_report_sign_X").toString()) ));
		features.putIfAbsent("sign_y", (Integer.valueOf(pathsMap.get("quaterly_update_report_sign_Y").toString()) ));
		features.putIfAbsent("sign_page", (Integer.valueOf(pathsMap.get("quaterly_update_report_sign_page").toString()) ));
		FileUtil.createDir(folderPath+yueBaoS.EXCELFOLDER);
		return features;
	}		
	
	
	
	/**
	 * ?????????????????????????????????json
	 * @param reptDiscSitu
	 * @param rept_qu_ivst_info
	 * @param features
	 * @return
	 */
	public  JSONObject generateQuaterlyUpdateInvestorReportJSON(ReptDiscSitu reptDiscSitu,Rept_qu_fund_info rept_qu_ivst_info, Map<String, Object> features) {
		String fundCode = reptDiscSitu.getFund_code();
		String qut_NO = reptDiscSitu.getDate_no();
		String info_Src_Code = "wb"; 
		JSONObject json_QuaterlyReport = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT); 
		jsonConfig.registerDefaultValueProcessor(BigDecimal.class, new DefaultDefaultValueProcessor() {
			public Object getDefaultValue(Class type) {
				return null;
			}
		});
		List<Rept_qu_ivst_info> list_rept_qu_ivst_info = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_ivst_info", null, fundCode, qut_NO,"wb", Rept_qu_ivst_info.class);
		/* ??????json */
		json_QuaterlyReport.put("rept_qu_ivst_info", JSONArray.fromObject(list_rept_qu_ivst_info,jsonConfig));
		json_QuaterlyReport.put("features", JSONObject.fromObject(features,jsonConfig));
		return json_QuaterlyReport;
	}


	 /**
	 * ??????fundcodes ????????????funds
	 * @param pd pagedata
	 * @param sort
	 * @param order
	 * @param reportType
	 * @param fundCodes
	 * @return ??????pagedata(???controller???request?????????)???????????????????????????????????????getSpecificFunds
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,Object>> getSpecificFunds(PageData pd, String sort, String order, String reportType, String fundCodes) 
			throws IOException, Exception {

		return (pd!=null)? outerXinXinPiLuDao.getSpecificFunds(pd.getString("dateNO"),
				  pd.getString("heDuiBuYiZhi"),
				  sort, order, 
				  yueBaoS.change2MQQUIQUP(reportType),								//????????????
				  fundCodes
				 ):null;
	}
	
	/**
	 * ?????????????????????????????????p???
	 * @param fund
	 * @return
	 */
	public String getMagrPCode (String funds) {
		if (funds==null||"".equals(funds)) {
			return "";
		}
		List<Map<String,Object>> magrs= new LinkedList<Map<String,Object>>();
		String magr = "";
		funds = "'"+funds+"'";
		try {
			magrs= outerXinXinPiLuDao.getFundsMagr("","",funds);
			if (magrs == null || magrs.size()<1) {return null;}
			magr = String.valueOf( magrs.get(0).get("magr_num") );
			return magr;
		} catch (DecoderException e) {
			logger.error(e);
			e.printStackTrace();
		}
		return magr;

	}
	
	public String getMagrNOByPcode (String pCode) {
		if (pCode==null||"".equals(pCode)) {
			return "";
		}
		String magr_no = "";

		List<Map<String,Object>> magr_nos= new LinkedList<Map<String,Object>>();
		try {
			magr_nos= outerXinXinPiLuDao.getMagrNOByPcode(pCode);
			if (magr_nos == null || magr_nos.size()<1) {return null;}
			magr_no = String.valueOf( magr_nos.get(0).get("magr_no") );
			return magr_no;
		} catch (DecoderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error(e);
		}
		return magr_no;
	}

	/**
	 * ???p????????????????????????
	 * @param pCode
	 * @return
	 */
	public String getMagrName (String pCode, String date_no) {
		if (pCode==null||"".equals(pCode)) {
			return "";
		}
		String magr_name = "";

		List<Map<String,Object>> magr_names= new LinkedList<Map<String,Object>>();
		try {
			magr_names= outerXinXinPiLuDao.getMagrName(pCode, date_no);
			if (magr_names == null || magr_names.size()<1) {return null;}
			magr_name = String.valueOf( magr_names.get(0).get("magr_name") );
			return magr_name;
		} catch (DecoderException e) {
			e.printStackTrace();
			logger.error(e);
		}
		return magr_name;
	}
	
	/**
	 * ???magr_no??????p???
	 * @param magr_no
	 * @return
	 */
	public String getMagrPCodeByMagrNo (String magr_no) {
		if (magr_no==null||"".equals(magr_no)) {
			return "";
		}
		String magr_p_code = "";

		List<Map<String,Object>> magr_p_codes= new LinkedList<Map<String,Object>>();
		try {
			magr_p_codes= outerXinXinPiLuDao.getMagrPCodeByMagrNo(magr_no);
			if (magr_p_codes == null || magr_p_codes.size()<1) {return null;}
			magr_p_code = String.valueOf( magr_p_codes.get(0).get("magr_num") );
			return magr_p_code;
		} catch (DecoderException e) {
			e.printStackTrace();
			logger.error(e);
		}
		return magr_no;
	}
	
	/**
	 * ???pdf????????????????????????D:\\sign.png
	 * @param pdfFilePath
	 * @param signedPath
	 * @param sealPath
	 * @throws Exception
	 */
	public void addSign2PDF(String pdfFilePath,String signedPath,String sealPath  ) throws Exception {
		ReportHelper.signPdf(pdfFilePath, signedPath, "D:\\sign.png", 390, 680,  70.0f,0);
	}

	/**
	 * ???p????????????????????????
	 * @param pCode
	 * @return
	 */
	public String getFund_codeByC_Pord_Code (String reportType , String date_no, String c_pord_code) {
		if (c_pord_code==null||"".equals(c_pord_code)) {
			return "";
		}
		String fund_code = "";
		List<Map<String,Object>> fund_codes= new LinkedList<Map<String,Object>>();
		try {
			fund_codes= outerXinXinPiLuDao.getFund_codeByC_Pord_Code(reportType, date_no, c_pord_code);
			if (fund_codes == null || fund_codes.size()<1) {return null;}
			fund_code = String.valueOf( fund_codes.get(0).get("fund_code") );
			return fund_code;
		} catch (DecoderException e) {
			e.printStackTrace();
			logger.error(e);
		}
		return fund_code;
	}
	
	
	/**
	 * ??????????????????sign pdf
	 * @param fileName
	 * @return
	 */
	public boolean needSign (String fileName) {
		if (null==fileName || fileName.equals("")) return false;		//????????????false
		if (fileName.contains(yueBaoS.change2PBRS("M"))) return true;	//????????????
		if (fileName.contains( "??????" )) return true;	//????????????

		return false;
		
	}
	
	/**
	 * ????????????????????????????????????????????????
	 * @see com.fh.dao.OuterXinXiPiLuDao#callProcedure2PushQUI2FMDB(String, String)
	 * @param fundCode
	 * @param dateNO
	 * @return
	 */
	public Boolean callProcedure2PushQUI2FMDB(String fundCode, String dateNO) {
		return outerXinXinPiLuDao.callProcedure2PushQUI2FMDB(fundCode, dateNO);
	}
	
	/**
	 * ??????????????????????????????????????????????????????????????????
	 * @see com.fh.dao.OuterXinXiPiLuDao#callProcedure2PushQUI2FMDB(String, String)
	 * @param fundCode
	 * @param dateNO
	 * @return
	 */
	public Boolean callProcedureRept_QUI_Main(String fundCode, String dateNO, Map<String, String> resultMap  ) throws Exception{
		return outerXinXinPiLuDao.callProcedureRept_QUI_Main(fundCode, dateNO,  resultMap );
	}
	
	
	public Boolean callProc_Entrance(String fundOrMagrNO, String dateNO, String reportType) throws DecoderException {
		switch (yueBaoS.change2MQQUIQUP(reportType)) {
		case Constants.MONTHLY:
			return callProcedurePro_Update_Report(fundOrMagrNO, dateNO);
		case Constants.QUANT:
			return callManagerProcecedure_etl_init_xp_data(fundOrMagrNO, dateNO);
		case Constants.SMO:
			return callProcedureProc_SMO_Data(dateNO,fundOrMagrNO );
		case Constants.QUATERLY:
			return callProcedurePro_Update_Report(fundOrMagrNO, dateNO);
		case Constants.QUATERLYUPDATE:
			return callProcedurePro_Update_Report(fundOrMagrNO, dateNO);
		case Constants.QUATERLYUPDATEIN:
			return callProcedurePro_Update_Report(fundOrMagrNO, dateNO);
		case Constants.HALFYEAR:
			return outerXinXinPiLuDao.callPro_half_update_Report(fundOrMagrNO, dateNO.substring(0, 4));
		default: 
			return false;

		}
	}
	
	
	/**
	 * {@link #callProcedurePro_Update_Report(String, String)}	 
	 * ?????????????????????????????????
	 * @param fundCode
	 * @param dateNO
	 * @return
	 */
	public Boolean callProcedurePro_Update_Report(String fundCode, String dateNO) {
		return outerXinXinPiLuDao.callPro_Update_Report(fundCode, dateNO);
	}
	
	
	public Boolean callProcedureProc_SMO_Data( String dateNO, String magr_no) throws DecoderException {
		return outerXinXinPiLuDao.procSMOData(dateNO, magr_no);
	}
	public Boolean callManagerProcecedure_etl_init_xp_data( String magr_no, String report_date) throws DecoderException { 
		return outerXinXinPiLuDao.procEtl_init_xp_data(magr_no, report_date); 
	}
	/**
	 * ???wrong??????????????????list???
	 * @param list
	 * @param fundCode
	 * @param dateNO
	 * @param errorMSG
	 * @return
	 */
	public JSONObject pushWrongJSONObject(JSONArray list, String fundCode, String dateNO, String errorMSG  ) {
		JSONObject wrong = new JSONObject();
		wrong.put("fund_code", fundCode);
		wrong.put("date_nO", dateNO);
		wrong.put("errorMSG", errorMSG);
		list.add(wrong);
		return wrong;
	}
	
	
	
}
