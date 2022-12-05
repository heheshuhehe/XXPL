package com.fh.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.math3.dfp.BracketingNthOrderBrentSolverDFP;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.stereotype.Service;

import com.fh.dao.OuterHSRXXPLDao;
import com.fh.dao.OuterJiBaoXinXiPiLuDao;
import com.fh.dao.OuterJiDuGengXinXXPLDao;
import com.fh.dao.OuterQuantXXPLDao;
import com.fh.dao.OuterXinXiPiLuDao;
import com.fh.dao.XinxipiluDao;
import com.fh.util.Const;
import com.fh.util.Constants;
import com.fh.util.Encoding;
import com.fh.util.ExcelException;
import com.fh.util.HTTPJiBeKeUtil;
import com.fh.util.LoginUtil;
import com.fh.util.PageData;
import com.fh.util.PropertyUitls;
import com.fh.util.file.FileUtil;
import com.fh.util.reportService.com.swhy.report.ReportApp;
import com.fh.util.reportService.com.swhy.report.ReportHelper;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptCreateJson4Xml;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptDiscSitu_MAGR;
import com.swhy.xxpl.model.ReptMFundInfo;
import com.swhy.xxpl.model.ReptMNetVal;
import com.swhy.xxpl.model.ReptSqlConfig;
import com.swhy.xxpl.model.ReptXmlConfig;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.Rept_M_Magr_Info;
import com.swhy.xxpl.model.Rept_m_qunt_prfund_run;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_info;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import sinosoft.utils.PropertyUtils;

@Service("XinXiPiLuYueBaoServiceNew")

public class XinXiPiLuYueBaoServiceNew {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	@Resource(name = "outerXinXinPiLuDao") 			//及贝克一般数据以及月报推送
	OuterXinXiPiLuDao outerXinXinPiLuDao ;  
	
	@Resource(name = "outerJiBaoXinXiPiLuDao") 		//吉贝克一般季报推送
	OuterJiBaoXinXiPiLuDao outerJiBaoXinXiPiLuDao ;  
	
	@Resource(name = "outerJiDuGengXinXXPLDao") 	//吉贝克季度更新推送
	OuterJiDuGengXinXXPLDao outerJiDuGengXinXXPLDao ;  
	
	@Resource(name = "outerHSRXXPLDao") 	//吉贝克季度更新推送
	OuterHSRXXPLDao outerhsrDao ; 
	
	@Resource(name = "outerQuantXXPLDao") 	//吉贝克季度更新推送
	OuterQuantXXPLDao outerQuantDao ; 
	
	@Resource(name = "reptCreateJson4Xml")
	ReptCreateJson4Xml reptCreateJson4Xml; 
	
	@Resource(name = "datasourceXXPLHDMDS") 
	DataSource datasourceXXPLHDMDS ;  
	
	@Resource(name = "OuterXXPLService")
	OuterXXPLService outerService;
	//常量
	private  final Boolean SIGN_PDF 	= true;
	private  final Integer SIGN_X		= 440;
	private  final Integer SIGN_Y		= 630;
	private  final String TOBEPRINTED	= "1";
	public 	 final String PRINTED		= "2";
	private  final String INTHELIST		= "1";			//清单内
	private  final String OUTOFLIST		= "0";			//清单外
	private  final String MANULADD		= "2";			//人工新增
	public final String ALLSELECT 		= "全选";
	static final String EXCELFOLDER 	= "excel\\";
	static final String WORDFOLDER 		= "word\\";
	static final String PDFFOLDER 		= "PDF\\";
	public static final String JSONFOLDER 	= "json\\";
	
	public static final String REPORTINGSERVICEJARPATH 		= PropertyUtils.getSysConfigSet("reportservicejarPath");
	public static final String MONTHLYREPORTEXCELTEMPLATE	="信息披露月报模板.xls";
	public static final String MONTHLYREPORTDOCSTEMPLATE	="基金月报模板.docx";
	public static final String QUARTERLYREPORTEXCELTEMPLATE	="信息披露季报模板.xls";
	public static final String QUARTERLYREPORTDOCSTEMPLATE	="基金季报模板.xls";
	public static final String JBKCHECKGOOD = "1";
	public static final String JBKUNCHECKED = "0";
	public static final String JBKCHECKBAD = "2";
	public static final String NONEEDCHECK = "9";

	public static final String SYSTEMENVIRONMENTMARK = PropertyUitls.getSystemEnvironmentMark();	//判断系统环境
	
	public XinXiPiLuYueBaoServiceNew() {logger.info("当前系统环境为:"+SYSTEMENVIRONMENTMARK);
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 搜寻某1个月的ReptDiscSitu数据，调用get1MonthReptDiscSitu方法实现
	 * @param pd pagedata
	 * @return 如果pagedata(从controller的request中获取)为空则直接返回空，否则执行get1MonthReptDiscSitu
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,Object>> search1MonthlyData(PageData pd, String data_chk_rslt_code,String ivsp_chk_rslt_code, String serv_scop, String isPrinted, String sort, String order, String gzry,String reportType) throws IOException, Exception {
		if (ivsp_chk_rslt_code!= null && "".equals(ivsp_chk_rslt_code) ) {
			ivsp_chk_rslt_code=null;
		}
		if (data_chk_rslt_code!= null && "".equals(data_chk_rslt_code) ) {
			data_chk_rslt_code=null;
		}
		if (isPrinted!= null && "".equals(isPrinted)) {
			isPrinted=null;
		}
		if (serv_scop!=null) {			
			if (serv_scop!=null && !Constants.LOCAL.equals(SYSTEMENVIRONMENTMARK) ) {serv_scop = new String( serv_scop.getBytes("ISO-8859-1"),"utf-8");}
			if( ALLSELECT.equals(serv_scop)) serv_scop=null;
		}
		String fundName =pd.getString("fundName");
		if (fundName!=null && !Constants.LOCAL.equals(SYSTEMENVIRONMENTMARK) ) { fundName=new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8");}
		
		if (gzry!=null && !Constants.LOCAL.equals(SYSTEMENVIRONMENTMARK) ) {
			gzry = new String( gzry.getBytes("ISO-8859-1"),"utf-8");
		}



		return (pd!=null)? xinXiPiLuDao.get1MonthReptDiscSitu(pd.getString("dateNO"),
															  pd.getString("heDuiBuYiZhi"),
															  fundName,
															  //new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8"),
															  data_chk_rslt_code, 										//数据核对状态
															  isPrinted,												//吉贝克报告状态
															  serv_scop,												//服务范围
															  sort, order, gzry,										//估值人员名单
															  change2MQQUIQUP(reportType),								//报告类型
															  ivsp_chk_rslt_code										//投监核对
															 ):null;
	}	
	
	/**
	 * 创建文件夹，生成并打印fund的json，再通过json打印3个文件(docs,excel and PDF)
	 * @param funds
	 * @param reportType // month, querter, year
	 * @return resultMSG, 包含生成月报的结果，比如更新失败的原因
	 * @throws Exception 
	 * @throws IOException 
	 */
	public Map<String,String> prepareAndPrint3Files4FundsMonthConcurrent (List<Map<String,String>> funds) throws IOException, Exception{
		Map<String,String> resultMSG = new HashedMap();
		if (funds==null || funds.size()<1) {	
			resultMSG.put("fail","没有基金产品");
			return resultMSG;
		}
		String xmlFileName = "Y:/系统专用/信息披露/模板/月报/MonthReport.xml"; 
		String jsonFilePath = "D:/temp/证券类月报/"; 
		logger.info("create json files service" ); 
		
		// 读 xml 配置 
//		ReptXmlConfig reptXmlConfig = new ReptXmlConfig();
		HashMap<String , ReptSqlConfig>  readXml = ReptXmlConfig.readXml(xmlFileName); 
	    System.out.println("sql info for xml --- "+ readXml.toString());
		int all_num = 0; 
		int err_num = 0; 
		// for (Map<String,String> fund: funds2) {
		ExecutorService pool = Executors.newFixedThreadPool(10);			//创建线程池
		Map threadMap = new  HashMap<String, String>();
		threadMap.put("jsonFilePath", jsonFilePath);
		threadMap.put("readXml", readXml);
		Map<String, String> features = transferMapObject( xinXiPiLuDao.getPaths());
		Connection conn = datasourceXXPLHDMDS.getConnection();
		try {
			for (Map<String,String> fund: funds) {
				all_num = all_num + 1; 
			    HashMap<String, String> fundVariables = new HashMap<String, String>();
			    String date_no = fund.get("date_no"); 
			    String fund_code = fund.get("fund_code"); 
			    String serv_scop = fund.get("serv_scop");						//填充业务参数
			    // 三个必须传入的参数 
			    /*threadMap.put("rept_type", "MONTH"); 
			    fundVariables.put("date_no", date_no );       
			    fundVariables.put("fund_code", fund_code); 
				//创建文件夹
			    String folderPath = features.get("tgzx_disk_drive").toString()+
						features.get("monthly_report_path").toString()
						+"\\"+date_no
						+"\\"+serv_scop+"\\";
				FileUtil.createDir(folderPath+"json\\");
				fundVariables.put("folderPath", folderPath);*/
				//吉贝克消息沟通
				sendToJiBeiKeDataBase(fund_code,  change2PBRS("PB0001") , date_no, null, resultMSG);
				//记得解开String result = notifyJiBeKe(fund_code, change2PBRS("PB0001") , date_no, resultMSG,"0",0);
				//记得解开updateReptDiscSituJBK(result, fund_code, change2PBRS("PB0001") , date_no, resultMSG, false,0);
			    //pool.submit(new ExportFileThread(threadMap, fundVariables, null, 0, null,conn));
	
				/*
				 * boolean flag = reptCreateJson4Xml.create(readXml , fundVariables, features);
				 * String JSONPath = folderPath+ JSONFOLDER+ fund_code+".json";
				 * createReportsByJSON(JSONPath);
				 * 
				 * if(!flag) { err_num = err_num + 1; }
				 */
			} 
		}catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}/*finally {
			DaoUtil.release(conn); 
		}  */
		String msg = "create json task "+all_num+",err number is "+err_num;   
		System.out.println(msg); 

		return resultMSG;
	}	
	
	/**
	 * 创建文件夹，生成并打印fund的json，再通过json打印3个文件(docs,excel and PDF)
	 * @param funds
	 * @param reportType // month, querter, year
	 * @return resultMSG, 包含生成月报的结果，比如更新失败的原因
	 * @throws Exception 
	 * @throws IOException 
	 */
	public Map<String,String> prepareAndPrint3Files4FundsMonth (List<Map<String,String>> funds) throws IOException, Exception{
		Map<String,String> resultMSG = new HashedMap();
		if (funds==null || funds.size()<1) {	
			resultMSG.put("fail","没有基金产品");
			return resultMSG;
		}
//		create(funds);
		String xmlFileName = "Y:/系统专用/信息披露/模板/月报/MonthReport.xml"; 
		String jsonFilePath = "D:/temp/证券类月报/"; 
		logger.info("create json files service" ); 
		
		// 读 xml 配置 
//		ReptXmlConfig reptXmlConfig = new ReptXmlConfig();
		HashMap<String , ReptSqlConfig>  readXml = ReptXmlConfig.readXml(xmlFileName); 
	    System.out.println("sql info for xml --- "+ readXml.toString());
		int all_num = 0; 
		int err_num = 0; 
		// for (Map<String,String> fund: funds2) {
		for (Map<String,String> fund: funds) {
			all_num = all_num + 1; 
		    HashMap<String, String> variables = new HashMap<String, String>();
		    String date_no = fund.get("date_no"); 
		    String fund_code = fund.get("fund_code"); 
		    String serv_scop = fund.get("serv_scop");
		    // 三个必须传入的参数 
		    variables.put("date_no", date_no );       
		    variables.put("fund_code", fund_code); 
		    variables.put("rept_type", "MONTH");  // ReptFeatures 根据这个参数选择获取不同的 features 
			//创建文件夹
		    Map<String, String> features = transferMapObject( xinXiPiLuDao.getPaths());
		    String folderPath = features.get("tgzx_disk_drive").toString()+
					features.get("monthly_report_path").toString()
					+"\\"+date_no
					+"\\"+serv_scop+"\\";
			FileUtil.createDir(folderPath+"json\\");
		    boolean flag = reptCreateJson4Xml.create(readXml , variables, features,null); 
		    String JSONPath = folderPath+ JSONFOLDER+ fund_code+".json";
			createReportsByJSON(JSONPath);

		    if(!flag) {
		    	err_num = err_num + 1; 
		    } 
		} 
		String msg = "create json task "+all_num+",err number is "+err_num;   
		System.out.println(msg); 

		return resultMSG;
	}
	
	/**
	 * 季报，调用及贝克
	 * @param funds
	 * @param reportType // month, quater, year
	 * @return resultMSG, 包含生成月报的结果，比如更新失败的原因
	 * @throws InterruptedException 
	 */
//	public Map<String,String> prepareAndPrint3Files4FundsQuater (List<Map<String,String>> funds) throws InterruptedException{
//		Map<String,String> resultMSG = new HashedMap();
//		if (funds==null || funds.size()<1) {	
//			resultMSG.put("fail","没有基金产品");
//			return resultMSG;
//		}
//		for (Map<String,String> fund: funds) {		//遍历每只基金并打印
//			try {
//				ReptDiscSitu  reptDiscSitu = //xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Disc_Situ", null, fund.get("fund_code"),  fund.get("date_no"),"wb", ReptDiscSitu.class).get(0);
//							xinXiPiLuDao.get1DiscSituByType_Month_FundCode("Q",fund.get("date_no"),fund.get("fund_code"))	;
//				Rept_Q_fund_info rept_Q_Fund_Info = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.rept_Q_Fund_Info", null, fund.get("fund_code"), fund.get("date_no"),"wb",Rept_Q_fund_info.class).get(0);
//				String result; 
//				sendToJiBeiKeDataBase(reptDiscSitu.getFund_code(), "RS0001", reptDiscSitu.getDate_no(), null, resultMSG);
//				result = notifyJiBeKe(reptDiscSitu.getFund_code(), "RS0001", reptDiscSitu.getDate_no(), resultMSG);
//				updateReptDiscSituJBK(result, reptDiscSitu.getFund_code(), "RS0001", reptDiscSitu.getDate_no(), resultMSG, false);
//				
//				sendToJiBeiKeDataBase(reptDiscSitu.getFund_code(), "PB0002", reptDiscSitu.getDate_no(), null, resultMSG);
//				result = notifyJiBeKe(reptDiscSitu.getFund_code(), "PB0002", reptDiscSitu.getDate_no(), resultMSG, "0",0);
//				updateReptDiscSituJBK(result, reptDiscSitu.getFund_code(), "PB0002", reptDiscSitu.getDate_no(), resultMSG, false,0);
//				
//				
//				if (rept_Q_Fund_Info==null || reptDiscSitu==null) {
//					logger.error("erronues fund is printing! the printing-json function is skipped 基金基本信息有错");
//					continue;
//				}
//
//			} catch (IOException e) {
//				e.printStackTrace();
//				resultMSG.put("fail", e.getMessage());
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				resultMSG.put("fail", e.getMessage());
//			}
//		}
//		return resultMSG;
//	}
	
	/**
	 * 接受打印某个fund的请求，调用更新该fund打印状态字段的数据库的方法
	 * @param fund， 从核对应用数据库中提取综合管理平台中的基金属性信息
	 * @param reptDiscSitu
	 * @param JSONPath	通过数据库取得路径前缀并结合基金名称的组合。
	 * @return 如果原料JSON文件不存在, 返回false;反之为 true
	 * @throws InterruptedException
	 */
	public Boolean updatePrinting3FilesfromJSON(ReptDiscSitu reptDiscSitu, String JSONPath) throws InterruptedException {
		
		//prepare printing
		if(new File(JSONPath)==null) return false;//如果文件不存在, 返回失败
		try {
			return xinXiPiLuDao.updateReptDiscSituPrintStatus(reptDiscSitu, TOBEPRINTED, JSONPath);
			//return xinXiPiLuDao.updateReptDiscSituPrintStatus(reptDiscSitu, OUTOFLIST.equals(reptDiscSitu.getBill_flag())?MANULADD:TOPRINT, JSONPath);	
		} catch (IOException e) {
			logger.error(e);
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * 新方法,老方法只接受2个参数接受打印某个fund的请求，调用更新该fund打印状态字段的数据库的方法
	 * @param fund， 从核对应用数据库中提取综合管理平台中的基金属性信息
	 * @param reptDiscSitu
	 * @param JSONPath	通过数据库取得路径前缀并结合基金名称的组合。
	 * @param printStatus 打印状态
	 * @return 如果原料JSON文件不存在, 返回false;反之为 true
	 * @throws InterruptedException
	 */
	public Boolean updatePrinting3FilesfromJSON(ReptDiscSitu reptDiscSitu, String JSONPath,String printStatus) throws InterruptedException {
		if (printStatus == null) {return updatePrinting3FilesfromJSON(reptDiscSitu,JSONPath);}
		
		//prepare printing
		if(new File(JSONPath)==null) return false;//如果文件不存在, 返回失败
		try {
			return xinXiPiLuDao.updateReptDiscSituPrintStatus(reptDiscSitu, printStatus, JSONPath);
		} catch (IOException e) {
			logger.error(e);
			e.printStackTrace();
		}
		return false;
	}
	
	
	/**
	 * 打印json到filePath
	 * @param json
	 * @param filePath
	 * @return true:成功， false:失败
	 * @throws IOException 
	 */
	public Boolean printingJSONtoFolder(JSONObject json, String jSONPath) throws IOException {
		File file = new File(jSONPath);
		// logger.info("jSONPath-- "+jSONPath); 
        if (!file.exists()) { 
        	// File file_dir = new File(file.getAbsolutePath()) ; 
        	File file_dir = file.getParentFile(); 
        	// logger.info("file_dir-- "+file_dir); 
        	if(!file_dir.exists())  {
        		 file_dir.mkdirs();
        	}
            file.createNewFile();// 如果文件不存在则创建
        }
        // 获取该文件的缓冲输出流
        BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
        // 写入信息
        bufferedWriter.write(json.toString());
        bufferedWriter.flush();// 清空缓冲区
        bufferedWriter.close();// 关闭输出流
		return file!=null;
	}
	
	/**
	 * Either build a new feature or finish a feature for Monthly Report
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return
	 */
	public Map<String, Object> fillMonthFeatures (ReptMFundInfo fundInfo, ReptDiscSitu reptDiscSitu, Map<String, Object> features,String folderPath ) {
		features= features==null?new HashMap<String, Object>():features;
		String fundName = fundInfo.getFund_name();
		String monthNoString = fundInfo.getMth_no();
		Map<String, Object>pathsMap = xinXiPiLuDao.getPaths();
		String fileName = fundInfo.getFund_num()+"_"+fundName+"_月报_"+monthNoString+"_"+reptDiscSitu.getRept_date(); 
		String modelFilePath = pathsMap.get("tgzx_disk_drive").toString()+pathsMap.get("monthly_report_model_path").toString()+"\\";
		features.putIfAbsent("excel_tpl_path", modelFilePath+pathsMap.get(reptDiscSitu.hasCFID()? 
				"monthly_report_cfid_model_excel":"monthly_report_model_excel"));		//分级基金使用特殊模板
		features.putIfAbsent("docx_tpl_path", modelFilePath+pathsMap.get("monthly_report_model_word"));
		features.putIfAbsent("excel_path", folderPath+EXCELFOLDER+fileName+".xls");
		features.putIfAbsent("docx_path", folderPath+WORDFOLDER+fileName+".docx");
		features.putIfAbsent("pdf_path", folderPath+PDFFOLDER+fileName+".pdf");
		features.putIfAbsent("watermark", fundInfo.getFund_name());
		features.putIfAbsent("sign_pdf", "true".equals(pathsMap.get("monthly_report_sign_pdf"))?true:false );
		features.putIfAbsent("sign_x", (Integer.valueOf(pathsMap.get("monthly_sign_X").toString()) ));
		features.putIfAbsent("sign_y", (Integer.valueOf(pathsMap.get("monthly_sign_Y").toString()) ));
		features.putIfAbsent("sign_page", (Integer.valueOf(pathsMap.get("monthly_sign_page").toString()) ));

		FileUtil.createDir(folderPath+WORDFOLDER);FileUtil.createDir(folderPath+EXCELFOLDER);FileUtil.createDir(folderPath+PDFFOLDER);
		return features;
	}	
	

	
	/**
	 * 最终装配成JSON，生成JSON的底层方法
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return	Map<String,String> json_monthlyReport
	 */
	public  JSONObject generateMonthlyReportJSON(ReptDiscSitu reptDiscSitu, ReptMFundInfo fundInfo, ReptMNetVal netVal, Map<String, Object> features) {
		JSONObject json_monthlyReport = new JSONObject();
		json_monthlyReport.put("rept_m_fund_info", JSONObject.fromObject(fundInfo));
		if (reptDiscSitu.hasCFID()) json_monthlyReport.put("ReptMNetVal_Cifds", JSONArray.fromObject(reptDiscSitu.getReptMNetVal_Cifds()));
		// fix cycle hierarchy in JSON
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT); 
		json_monthlyReport.put("rept_m_net_val", JSONObject.fromObject(netVal,jsonConfig));
		json_monthlyReport.put("features", JSONObject.fromObject(features));
		logger.info("generating JSON: "+json_monthlyReport.toString());
		return json_monthlyReport;
	}
	
	/**
	 * 
	 * @param funds
	 * @throws IOException, Exception 
	 */
	public boolean create(List<Map<String,String>> funds ) throws IOException, Exception {
		String xmlFileName = "Y:/系统专用/信息披露/模板/年报/证券类年报.xml"; 
		String jsonFilePath = "D:/temp/证券类年报/"; 
		logger.info("create json files service" ); 
		
		// 读 xml 配置 
//		ReptXmlConfig reptXmlConfig = new ReptXmlConfig();
		HashMap<String , ReptSqlConfig>  readXml = ReptXmlConfig.readXml(xmlFileName); 
	    System.out.println("sql info for xml --- "+ readXml.toString());
		int all_num = 0; 
		int err_num = 0; 
		// for (Map<String,String> fund: funds2) {
		for (Map<String,String> fund: funds) {
			all_num = all_num + 1; 
		    HashMap<String, String> variables = new HashMap<String, String>();
		    String date_no = fund.get("date_no"); 
		    String fund_code = fund.get("fund_code"); 
		    // 三个必须传入的参数 
		    variables.put("date_no", date_no );       
		    variables.put("fund_code", fund_code); 
		    variables.put("rept_type", "YSE");  // ReptFeatures 根据这个参数选择获取不同的 features 
		    boolean flag = reptCreateJson4Xml.create(readXml , variables, null,null); 
		     
		    if(!flag) {
		    	err_num = err_num + 1; 
		    } 
		} 
		String msg = "create json task "+all_num+",err number is "+err_num;   
		System.out.println(msg); 
		if (all_num!=0 || err_num!=0) return false;
		return true ;	
	}
	 
	/**
	 * 获取数据库中mds.Rpt的已存在的不同的产品名称
	 * @param pg
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,String>> getGuZhiRenYuanOptions(PageData pg) throws IOException, Exception{
		String ReportType = pg.getString("reportType");
		String validReportType = change2MQQUIQUP(ReportType);
		return null!=validReportType?xinXiPiLuDao.getGuZhiRenYuanOptions(validReportType):null;
	}
	
	/**
	 * 
	 * @param pd
	 * @return
	 * @throws InterruptedException
	 * @throws DecoderException 
	 * @throws UnsupportedEncodingException 
	 */
	public List<Map<String, Object>> search1QuaterlyDisctChkRsltData(PageData pd) throws InterruptedException, DecoderException, UnsupportedEncodingException {
		return (pd!=null)? xinXiPiLuDao.get1QuaterlyDisctChkRsltData(pd.getString("quaterNO"),
																	pd.getString("heDuiYiZhi"),
																	new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8")
				 ):null;
	}
	
	
	/**
	 * 使用reportservice的方法生成报告,
	 */
	public void createReportsByJSON(String JSONFilePath) {
		String[] argument = {JSONFilePath};
		ReportApp.start(argument);
		//logger.info("开始打印了");
	}
	
	/**
	 * 调用存储过程在保存修改/指标确认之后 更新清单表
	 * @param disc_type_code
	 * @param date_no
	 * @param fund_code
	 * @return 是否有异常抛出
	 */
	public Boolean callRept_data_chk_rslt(String disc_type_code,String date_no  ,String fund_code) {
		return xinXiPiLuDao.callRept_data_chk_rslt(disc_type_code, date_no, fund_code);
	}
	
	/**
	 * 获取1个清单表 reptdiscSitu
	 * @throws Exception
	 */
	public ReptDiscSitu get1DiscSituByType_Month_FundCode(String reportType, String date_no, String fund_code ) throws Exception {
		ReptDiscSitu rds = xinXiPiLuDao.get1DiscSituByType_Month_FundCode(reportType, date_no, fund_code);
		return rds;
	}

	
	/**
	 * 修改明细数据
	 * @param modifyElementList
	 * @param result
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,Object>> modifyData (List<Map<String,String>> modifyElementList, Map<String, String> result, String modifyType) throws IOException, Exception {
		if (modifyType==null)return null;
//		modifyType=change2MQQUIQUP(modifyType);
		String chineseModifyType = translateModifyType(modifyType);
		Map <String, String> distinctFundCode =new HashMap<String, String>();
		for (Map <String, String> element: modifyElementList) {
			logger.info(element);
			String disc_type_code= element.get("disc_type_code");
			String date_no= element.get("date_no");
			String fund_code= element.get("fund_code");
			distinctFundCode.putIfAbsent(fund_code, fund_code);
			String indx_name= element.get("indx_name");
			String upd_aft_data= element.get("upd_aft_data");
			String upder_ip= element.get("upder_ip");
			String indx_src_tab = element.get("indx_src_tab");
			String indx_src_fld = element.get("indx_src_fld");
			String indx_dim = element.get("indx_dim");
			String magr_no = null;
			if ("M2".equals(change2MQQUIQUP(disc_type_code)) || "SMO".equals(change2MQQUIQUP(disc_type_code)) ) {magr_no = element.get("magr_no");}
			Rept_Disct_Chk_Rslt rdcr= xinXiPiLuDao.get1DisctChkRsltData(disc_type_code, date_no, fund_code, indx_src_tab , indx_src_fld , indx_dim,magr_no );			
			if (rdcr==null || rdcr.getDate_no()==null) throw new Exception("无此明细！");
			String fund_name = rdcr.getFund_name();
			String upder_name = "未知";
			String opt_desc = chineseModifyType+":"+indx_name+",从 "+ rdcr.getWb_data() +" 改为："+upd_aft_data;
			String opt_sql = rdcr.getUpd_sql()==null?"":rdcr.getUpd_sql().toString(); 
			String chk_rslt_code= rdcr.getChk_rslt_code();
			result.put("fail","success");
			if (!xinXiPiLuDao.updateReptDiscChkRslt( upd_aft_data, upder_ip,disc_type_code, date_no, fund_code, indx_name,result, chk_rslt_code, modifyType,rdcr) ){
				result.put("fail","确认失败");
				opt_desc=opt_desc+"___执行SQL失败";
				insertHistory(disc_type_code, date_no, fund_code, fund_name , chineseModifyType , upder_ip, upd_aft_data, upder_name, opt_desc , opt_sql, result);
				continue;
			}
			
			
			if (Constants.MODIFY.equals(modifyType) && !executeModifySQL(opt_sql, upd_aft_data)) {	//只有当操作类型为指标确认时 如果执行失败
				opt_desc=opt_desc+"___执行SQL失败";
				result.put("fail","确认失败");
				insertHistory(disc_type_code, date_no, fund_code, fund_name , chineseModifyType , upder_ip, upd_aft_data, upder_name, opt_desc , opt_sql, result);
				continue;
			}

			opt_desc=opt_desc+"___执行SQL成功";
			if (Constants.MODIFY.equals(modifyType)) {callRept_data_chk_rslt(disc_type_code, date_no, fund_code);}	//如果是修改操作，每次loop更新清单
			
			insertHistory(disc_type_code, date_no, fund_code, fund_name , chineseModifyType , upder_ip, upd_aft_data, upder_name, opt_desc , opt_sql, result);
		}
		if (Constants.CONFIRM.equals(modifyType)) {
			Map <String, String> singleElement =modifyElementList.get(0);
				callRept_data_chk_rslt(singleElement.get("disc_type_code"), singleElement.get("date_no"), singleElement.get("fund_code"));
			}	//如果是确认操作，loop完再更新清单

		return null;
	}
	
	/**
	 * 插入操作历史
	 * @param disc_type_code	报告类型
	 * @param date_no			报告日期
	 * @param fund_code			基金编码
	 * @param fund_name			基金名称
	 * @param modyType			修改类型
	 * @param upder_ip			操作者IP
	 * @param updt_data			操作数据内容
	 * @param upder_name		操作者名字
	 * @param opt_desc			操作描述
	 * @param opt_sql			操作相关SQL
	 * @param result			结果是否成功
	 * @throws IOException		
	 */
	public void insertHistory (  String disc_type_code, String date_no, String fund_code, String fund_name, String modyType, 
			String upder_ip, String updt_data, String upder_name,  String opt_desc, String opt_sql	,Map<String, String> result) throws IOException {
		xinXiPiLuDao.insertHistory(disc_type_code, date_no, fund_code, fund_name , modyType , upder_ip, updt_data, upder_name, opt_desc , opt_sql, result);
	}
	
	/**
	 * 执行修改操作的sql
	 * @param SQL
	 * @param upd_data
	 */
	public Boolean executeModifySQL(String SQL, String upd_data) {
		if ("null".equals(upd_data)||"\"null\"".equals(upd_data)  ) {upd_data="";}
		return xinXiPiLuDao.executeModify(SQL,upd_data);
	}
	
	/**
	 * 转换word成pdf
	 * @param docxFilePath	word文件路径
	 * @param pdfFilePath	pdf文件路径
	 * @return
	 * @throws Exception 
	 */
	public Boolean word2PDF(String docxFilePath, String pdfFilePath) throws Exception  {
//		ReptCreateJson4Xml reptCreateJson4Xml = new ReptCreateJson4Xml();
		logger.info("转换"+docxFilePath + " 至 "+pdfFilePath);
		try {
			ReportHelper.createPdf(docxFilePath, pdfFilePath);
		logger.info("转换"+docxFilePath + " 至 "+pdfFilePath+" 完毕");
		} catch (Exception e) {	
			logger.error(e);
			e.printStackTrace();
			throw (e);
		}
		return true;
		
	}
	
	/**
	 * 推送管理人至及贝克
	 * @param rdsm
	 * @param reportType
	 * @param dateNo
	 * @param resultMap
	 * @return
	 */
	public boolean sendMAGRToJiBeiKeDataBase(ReptDiscSitu_MAGR rdsm, String reportType, String dateNo, Map<String,String>resultMap){
		if (rdsm==null ||  reportType==null || "".equals(reportType)  )  return false;

		try {
			switch (reportType){
			case "M2":	//量化月报
				logger.info("处理量化运行月报及贝克推送");
//				ReptDiscSitu reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("M", dateNo, fundCode);
				Rept_M_Magr_Info rept_M_Magr_Info = xinXiPiLuDao.get1MonthlyReptManagerInfo(rdsm.getMagr_No(), Const.WAIBAO,rdsm.getDate_No() );
				List<Rept_m_qunt_prfund_run> list = xinXiPiLuDao.getRept_m_qunt_prfund_runByMgrOrMonth(rdsm.getMagr_No(), rdsm.getDate_No(), null, null, null);
				if (!outerQuantDao.upadteQuantJiBeiKe(rdsm)) {return false;}

				if (list==null) {
			        resultMap.put("code",Constants.FUND_CODEERRORCODE);
			        if (resultMap.get("message")==null  )resultMap.put("message","fail, no fund product for manager:"+rdsm.getMagr_No() + " "+dateNo);
			        if (resultMap.get("data")==null  )resultMap.put("data","该产品代码与日期查询不到产品");
			        if (resultMap.get("data")==null  )resultMap.put("data","该产品代码与日期查询不到产品");

			        return false;
				}
			}
			}catch (IOException e) {
			        if (resultMap.get("code")==null  )resultMap.put("code","300");
			        if (resultMap.get("message")==null  )resultMap.put("message","fail," + e.getMessage().toString() );
			        if (resultMap.get("data")==null  )resultMap.put("data" ,e.toString());
					e.printStackTrace();logger.error(e);
					return false;
				}catch (Exception e) {
			        if (resultMap.get("code")==null  )resultMap.put("code","300");
			        if (resultMap.get("message")==null  )resultMap.put("message","fail," + e.getMessage().toString() );
			        if (resultMap.get("data")==null  )resultMap.put("data" ,e.toString());
					e.printStackTrace();logger.error(e);
					return false;
				}
				return true;
	}
	
	/**
	 * 向吉贝克数据库推送数据
	 * @param fundCode		纯数字代码，信息披露系统基金主键
	 * @param reportType	PB0001:月报 PB0002:季报 RS0001: 季度更新产品运行表
	 * @param dateNo		例:20220101/202201/2022/
	 * @param fund			可以为空
	 * @param resultMap		消息推送结果集
	 * @return				1成功 0失败
	 */
	public boolean sendToJiBeiKeDataBase(String fundCode, String reportType, String dateNo,Map<String, Object> fund, Map<String,String>resultMap){
		if (fundCode==null || "".equals(fundCode) ||  reportType==null || "".equals(reportType)  )  return false;
			try {
				switch (reportType){
				case "PB0001":	//月报
					logger.info("处理月报及贝克推送");
					ReptDiscSitu reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("M", dateNo, fundCode);
					if (reptDiscSitu==null) {
				        resultMap.put("code",Constants.FUND_CODEERRORCODE);
				        if (resultMap.get("message")==null  )resultMap.put("message","fail, no fund product:"+fundCode + " "+dateNo);
				        if (resultMap.get("data")==null  )resultMap.put("data","该产品代码与日期查询不到产品");
				        return false;
					}
					ReptMNetVal rmnv = xinXiPiLuDao.get1MNetValByFundCode(fundCode, "wb", dateNo);
					ReptMFundInfo rmfi =xinXiPiLuDao.get1MInfoByFundCode(fundCode, reportType, dateNo);
					if (!outerXinXinPiLuDao.upadteYueBaoJiBeiKe(reptDiscSitu, rmfi,rmnv,resultMap)) {return false;}
					return true;
				case "PB0002":	//季报
					logger.info("处理季报及贝克推送");
					reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("Q", dateNo, fundCode);
					if (reptDiscSitu==null) {
				        resultMap.put("code",Constants.FUND_CODEERRORCODE);
				        if (resultMap.get("message")==null  )resultMap.put("message","fail, no fund product:"+fundCode + " "+dateNo);
				        if (resultMap.get("data")==null  )resultMap.put("data","该产品代码与日期查询不到产品");
				        return false;
					}
					if (!outerJiBaoXinXiPiLuDao.upadteJiBaoJiBeiKe(reptDiscSitu)) {return false;}
					return true;

					//outerXinXinPiLuDao.upadteYueBaoJiBeiKe(reptDiscSitu, rmfi,rmnv);
				case "RS0001":	//季度更新 产品运行表
					logger.info("处理季度更新产品运行表吉贝克推送");
					reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("QU", dateNo, fundCode);
					if (reptDiscSitu==null) {
				        resultMap.put("code",Constants.FUND_CODEERRORCODE);
				        if (resultMap.get("message")==null  )resultMap.put("message","fail, no fund product:"+fundCode + " "+dateNo);
				        if (resultMap.get("data")==null  )resultMap.put("data","该产品代码与日期查询不到产品");
				        return false;
					}
					if (!outerJiDuGengXinXXPLDao.upadteJiDuGengXinJiBeiKe(reptDiscSitu)) {return false;}
					return true;
				case "PB0004":	//半年报
					logger.info("处理半年报及贝克推送");
					reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("HSR", dateNo, fundCode);
					if (reptDiscSitu==null) {
				        resultMap.put("code",Constants.FUND_CODEERRORCODE);
				        if (resultMap.get("message")==null  )resultMap.put("message","fail, no fund product:"+fundCode + " "+dateNo);
				        if (resultMap.get("data")==null  )resultMap.put("data","该产品代码与日期查询不到产品");
				        return false;
					}
					if (!outerhsrDao.upadteHSRJiBeiKe(reptDiscSitu)) {return false;}
					return true;
				case "quaterlyupdate":
					;
				case "year":
					;
				default: break;


			}

		} catch (IOException e) {
	        if (resultMap.get("code")==null  )resultMap.put("code","300");
	        if (resultMap.get("message")==null  )resultMap.put("message","fail," + e.getMessage().toString() );
	        if (resultMap.get("data")==null  )resultMap.put("data" ,e.toString());
			e.printStackTrace();logger.error(e);
			return false;
		}catch (Exception e) {
	        if (resultMap.get("code")==null  )resultMap.put("code","300");
	        if (resultMap.get("message")==null  )resultMap.put("message","fail," + e.getMessage().toString() );
	        if (resultMap.get("data")==null  )resultMap.put("data" ,e.toString());
			e.printStackTrace();logger.error(e);
			return false;
		}
		return true;
	}
	
	public Map<String, String> transferMapObject  (Map<String, Object> target){
		Map newMap =new HashMap();
		for (Map.Entry entry : target.entrySet()) {
			if(entry.getValue() instanceof String){	newMap.put(entry.getKey(), (String) entry.getValue());}
		}
		return newMap;
	}

	
	/**
	 * 调用及贝克接口通知数据推送完毕
	 * @param fundCode		纯数字代码，信息披露系统基金主键,如果是量化运行表等报表则为管理人代码
	 * @param reportType	PB0001:月报 PB0002:季报 RS0001: 季度更新产品运行表 
	 * @param dateNo		例:20220101/202201/2022/
	 * @param resultMap		消息推送结果集
	 * @return 吉贝克返回消息原文
	 */

	public String notifyJiBeKe(String fundCode,String reportType, String dateNo,Map<String,String>resultMap,String mandatory, AtomicInteger success )  {
		//ReptMFundInfo reptMFundInfo= xinXiPiLuDao.get1MInfoByFundCode(fundcode, "wb", dateNo);
		ReptDiscSitu rds =null;
		ReptDiscSitu_MAGR rdsm= new ReptDiscSitu_MAGR();
		String innerReportType = change2MQQUIQUP(reportType);
		String JBKnotifyURL = PropertyUitls.getProperties("config.properties").getProperty("JBKnotifyURL");

		try {
			if (change2MQQUIQUP("M2").equals(reportType)) {		//管理人维度
				rdsm.assembleMapToRept_Disc_Situ_Magr(xinXiPiLuDao.get1MonthlyManagerData("M2", dateNo, "" , null, null, fundCode,"").get(0));
			}else {												//基金产品维度
				rds = xinXiPiLuDao.get1DiscSituByType_Month_FundCode(innerReportType, dateNo, fundCode);
				if (rds==null) {		
			        resultMap.put("code",Constants.FUND_CODEERRORCODE);
			        resultMap.put("message","fail, no fund product:"+fundCode + " "+dateNo);
			        resultMap.put("data","该产品代码与日期查询不到产品");
			        return "Cannot push to JiBeiKe";
				}	
			}

		
		String _sysCode_= "xxplxt";
		String _bizType_ = "XBRL";
		String _userCode_ = "xtyh";
		String _bizOP_ = "create";
		String checkCode = "654321";
		String requestUUID;
		String reportEndDate;	
		String companyCode;
		if ( isManagerBaseType(reportType)) {		//如果是量化运行表//管理人维度
			requestUUID = rdsm.getMagr_No()+"_"+rdsm.getDate_No();
			reportEndDate= rdsm.getGbicc_exp_date();//rds.getRept_date().substring(0, 4)+"-"+rds.getRept_date().substring(4, 6)+"-"+ rds.getRept_date().substring(6);		
			companyCode = rdsm.getMagr_Num();// outerService.getMagrPCodeByMagrNo(rdsm.getMagr_No());
			fundCode=companyCode;
		}else {
			requestUUID = rds.getFund_code()+"_"+rds.getRept_date();//基金产品维度
			reportEndDate= rds.getGbicc_exp_date();//rds.getRept_date().substring(0, 4)+"-"+rds.getRept_date().substring(4, 6)+"-"+ rds.getRept_date().substring(6);		
			companyCode = outerService. getMagrPCode(fundCode);
			fundCode=rds.getFund_num();

		}

		//装配json发送至及贝克
		JSONObject json=new JSONObject();
		JSONObject jsonDataJsonObject = new JSONObject();
		json.put("_sysCode_", _sysCode_);
		json.put("_bizType_", _bizType_);
		json.put("_bizOP_", "create");

		json.put("_userCode_", _userCode_);
		json.put("checkCode", checkCode);

		jsonDataJsonObject.put("requestUUID", requestUUID);
		jsonDataJsonObject.put("fundCode", fundCode);
		jsonDataJsonObject.put("reportType", change2PBRS(reportType) );
		jsonDataJsonObject.put("reportEndDate", reportEndDate);
		jsonDataJsonObject.put("companyCode", companyCode );
		if (mandatory!=null&& "1".equals(mandatory)) {		jsonDataJsonObject.put("export", "2");}
		json.put("data",jsonDataJsonObject.toString());
		logger.info(json);
		
		return HTTPJiBeKeUtil.doJiBeiKePost(null,JBKnotifyURL,"",json.toString());
		} catch (IOException e) {
	        if (resultMap.get("code")==null  )resultMap.put("code","300");
	        if (resultMap.get("message")==null  )resultMap.put("message","fail," + e.getMessage().toString() );
	        if (resultMap.get("data")==null  )resultMap.put("data" ,e.toString());
			e.printStackTrace();
			logger.error(e);
		} catch (Exception e) {
	        if (resultMap.get("code")==null  )resultMap.put("code","300");
	        if (resultMap.get("message")==null  )resultMap.put("message","fail," + e.getMessage().toString() );
	        if (resultMap.get("data")==null  )resultMap.put("data" ,e.toString());
			e.printStackTrace();
			logger.error(e);
			return "";
		}
		return "";
	}
	
	/**
	 * 回写及贝克返回信息至rept_disc_situ, 同时处理返回消息返回结果
	 * @param plaintext	吉贝克返回原始信息
	 * @param fundCode
	 * @param reportType	PB/RS 等吉贝克接口专用代码
	 * @param dateNo
	 * @param resultMap   返回response集合
	 * @param isMandatory 是否强制生成
	 * @return
	 */
	public Boolean updateReptDiscSituJBK(String plaintext, String fundCode ,String reportType, String dateNo, Map<String,String> resultMap, boolean isMandatory, AtomicInteger success, AtomicInteger errorNum ) {
		/*0.1 检查返回报文json，如果无法解析,抛出错误，并将吉贝克返回状态码置为生成错误*/
		logger.info("json object is: \n"+plaintext);
		String memo ="";
		memo= parseJBKJSON(plaintext);
		try {
			if (memo==null||"".equals(memo)) throw new ExcelException("返回json为空或信息格式不正确，无法被解读");
			/*0. 默认吉贝克生成文件失败，如果接下来的逻辑能走通，gbicc_chk_rslt_code会被置为其他状态码*/
			String gbicc_chk_rslt_code = "";// Constants.NOTGENERATED;
			JSONObject js= JSONObject.fromObject(plaintext); 
			if (js.getString("success")==null ) {new ExcelException(memo);}
			/*1. 清单已经生成，生成成功*/
			if (js.getBoolean("success") ) {
				success.incrementAndGet();
				gbicc_chk_rslt_code=Constants.SUCCESSFULLYGENERATED;
			}
			/*2. 清单没有生成，无论吉贝克校验是否成功,此时返回结果一定有财务或非财务类型错*/
			else  {
				errorNum.incrementAndGet();
				gbicc_chk_rslt_code=Constants.FINANCIALERROR;
				//memo="{\"levelGroup\":false,\"errorPages\":{\"SH002\":[\"_GBC_632bbc9ab10e4a879ad51c784c5a56df\"],\"SH001\":[\"_GBC_5e1a69b19e08490ab93b5ebb5044b1d4\",\"_GBC_8744d86865e4437daa1ab085f071daeb\",\"_GBC_3c9f62a1f70b47f89d2b71d1511345a7\"]},\"total\":{\"warningCount\":2,\"infoCount\":0,\"errorCount\":3},\"type\":\"root\",\"children\":[{\"description\":\"业务规则： 3个错误，2个警告，0个提示信息。\",\"type\":\"foler\",\"children\":[{\"type\":\"leaf\",\"description\":\"1、基金的组织形式是“契约型”或是“顾问管理”类型时，基金初始募集面值应不为空\",\"loc\":\"_GBC_3c9f62a1f70b47f89d2b71d1511345a7!8\",\"et\":\"Error\"},{\"type\":\"leaf\",\"description\":\"2、本基金存续期限为 95764 个月，而基金到期日与基金成立日期的差距为239个月，请核实是否填写正确\",\"loc\":\"_GBC_8744d86865e4437daa1ab085f071daeb!3\",\"et\":\"Error\"},{\"type\":\"leaf\",\"description\":\"3、本基金有：  股票投资;  应开立证券账户或金融期货账户，请核实后填写“一码通账户”信息。\",\"loc\":\"_GBC_632bbc9ab10e4a879ad51c784c5a56df!64\",\"et\":\"Error\"},{\"type\":\"leaf\",\"description\":\"4、本基金到期日为2038-07-31，存续期限为95764个月，请管理人核实是否填写正确。\",\"loc\":\"_GBC_5e1a69b19e08490ab93b5ebb5044b1d4!7\",\"et\":\"Warning\"},{\"type\":\"leaf\",\"description\":\"5、私募基金到期日期2038-07-31与基金备案信息中的基金到期日不一致，请管理人核实\",\"loc\":\"_GBC_5e1a69b19e08490ab93b5ebb5044b1d4!7\",\"et\":\"Warning\"}],\"cat\":\"业务规则\",\"et\":\"Debug\"}],\"description\":\"发现：3个错误，2个警告，0个提示信息。\",\"et\":\"Debug\"}";
			}
			/*3, 如果调用吉贝克强制生成接口，gbicc_chk_rslt_code无论如何置为3*/
			if(isMandatory) {gbicc_chk_rslt_code=Constants.MANDATORY;success.incrementAndGet();}
			if(memo.length()>=2000) {memo=memo.substring(0,1999); }
			//真正写入数据库方法
			outerXinXinPiLuDao.updateReptDiscSituMemo(memo, fundCode, change2MQQUIQUP(reportType), dateNo,gbicc_chk_rslt_code );
		} catch (Exception e) {
			e.printStackTrace();logger.error(e);
	        resultMap.put("code","300");
	        resultMap.put("message","fail," + e.getMessage().toString() );
	        resultMap.put("data" ,e.toString());		
			//outerXinXinPiLuDao.updateReptDiscSituMemo(e.getMessage(), fundCode, change2MQQUIQUP(reportType), dateNo,Constants.FAILGENERATED );
	        return false;
	    }
		return true;
	}
	
	/**
	 * 解析吉贝克返回json并返回格式化（列表）的错误和警告信息
	 * @param verifyMessage
	 * @return
	 */
	public String parseJBKJSON(String originalText) throws JSONException {
		if (originalText==null||"".equals(originalText)) {return null;}
		JSONObject rootJson = JSONObject.fromObject(originalText);
		if (rootJson==null||rootJson.isEmpty() ) {return null;}
		
		StringBuilder errorListString = new StringBuilder();
		String messageString = rootJson.getString("message");
		if (messageString==null||messageString.isEmpty() ) {return "吉贝克返回message 为空，无法解析";}
		if (!messageString.contains("[")) {return messageString;}	//可能没有错误，字符串为“检验通过”
		JSONArray message = JSONArray.fromObject(messageString);
		for (int i=0;i<message.size();i++ ) {
			JSONObject problem = message.getJSONObject(i);
			if ("Error".equals(problem.getString("et"))) {
				errorListString.append("错误："+problem.getString("desc")+" \n");
			}else if ("Warning".equals(problem.getString("et"))) {
				errorListString.append("警告："+problem.getString("desc")+" \n");
			}
//			if (jsonObject==null) throw
		}
		logger.info(errorListString.toString());

		return errorListString.toString();
	}

	/**
	 * 检查强制推送生成条件是否成立
	 * @param fundsList
	 * @param reportType
	 * @param resultMap
	 * @return
	 * @throws Exception
	 */
	public Boolean checkFundMandatoryAvailable(List<Map<String, String>> fundsList , String reportType, Map<String, String> resultMap) throws Exception {
		if (fundsList==null || fundsList.size()!=1) {
			resultMap.put("code", Constants.OTHER_ERRORCODE);
			resultMap.put("message", "没有基金被选中或超过1只基金被选中，无法强制推送 ");
			resultMap.put("data", "没有基金被选中或超过1只基金被选中，无法强制推送" );
			return false;
		}
		Map<String,String> funds= fundsList.get(0);
		reportType=change2MQQUIQUP(reportType);
		if (isFundBaseType(reportType)) {
			ReptDiscSitu rds = xinXiPiLuDao.get1DiscSituByType_Month_FundCode(reportType, funds.get("date_no"), funds.get("fund_code"));
			if (!Constants.FINANCIALERROR.equals(rds.getGbicc_chk_rslt_code()) ) {
				resultMap.put("code", Constants.MANDATORY_ERRORCODE);
				resultMap.put("message",   "只有当下列基金生成报告失败存在财务指标错误后才能强制推送： "+rds.getFund_name());
				resultMap.put("data", "请先点击生成报告按钮 ");
				return false;
			}
		}
		if (isManagerBaseType(reportType)) {
			ReptDiscSitu_MAGR manager = new ReptDiscSitu_MAGR();
			manager.assembleMapToRept_Disc_Situ_Magr(xinXiPiLuDao.get1MonthlyManagerData(reportType, funds.get("date_no"), "" , null, null, funds.get("magr_no"),"").get(0));
			if (!Constants.FINANCIALERROR.equals(manager.getGbicc_chk_rslt_code()) ) {
				resultMap.put("code", Constants.MANDATORY_ERRORCODE);
				resultMap.put("message",   "只有当下列管理人生成报告失败存在财务指标错误后才能强制推送： "+manager.getMagr_Name());
				resultMap.put("data", "请先点击生成报告按钮 ");
				return false;
			}
		}

		return true;
	}
	
	/**
	 * 检查一般基金产品是否具备推送条件
	 * 先校验数据核对状态是否一致\不需要核对\人工核对一致 等状态然后校验投监审核是否通过或不需要审核
	 * 满足上述条件后针对强制推送产品情景校验该产品是否已被推送过。
	 * 针对季报产品还会调查该产品季度更新是否已经推送过。
	 * @param fund
	 * @param reportType
	 * @param resultMap
	 * @return
	 * @throws Exception
	 */
	public Boolean checkFundAvailable(Map<String, String> fund , String reportType, Map<String, String> resultMap, JSONArray wrongListArray) throws Exception {
		if (fund==null) {
			outerService.pushWrongJSONObject(wrongListArray, "", "", "找不到基金产品,报告类型："+reportType);
			return false;
		}
		reportType=change2MQQUIQUP(reportType); if ("".equals(reportType)) {return false;}
		ReptDiscSitu rds = xinXiPiLuDao.get1DiscSituByType_Month_FundCode(reportType, fund.get("date_no"), fund.get("fund_code"));
		if (rds==null) {
			outerService.pushWrongJSONObject(wrongListArray, fund.get("fund_code"), fund.get("date_no"), fund.get("fund_code")+"  "+fund.get("date_no")+" 找不到对应产品");
			return false;}
		String dataCheckCode= rds.getData_chk_rslt_code();//数据核对状态码
		String ivsp_chk_rslt_code= rds.getIvsp_chk_rslt_code();//投监核对代码
		switch (reportType) {
		case "M"://月报
				break;
		case "Q"://季报
				ReptDiscSitu rdsQU = get1DiscSituByType_Month_FundCode(change2MQQUIQUP("QU"), fund.get("date_no"), fund.get("fund_code"));
				if (rdsQU==null) {
					outerService.pushWrongJSONObject(wrongListArray, fund.get("fund_code"), fund.get("date_no"), fund.get("fund_code")+"  "+fund.get("date_no")+" 找不到对应的季度更新数据");
					return false;}
				String JBKreturnFlag=rdsQU.getGbicc_chk_rslt_code();
				if (!Constants.SUCCESSFULLYGENERATED.equals(JBKreturnFlag) && !Constants.MANDATORY.equals(JBKreturnFlag)) {
					outerService.pushWrongJSONObject(wrongListArray, rds.getFund_code(), rds.getDate_no(), "请先生成 "+rds.getFund_name()+"的季度更新报表。");
					return false;}
				break;
		case "QU"://季度更新
				break;
		case "HSR" ://半年报
			break;		
		default :
				outerService.pushWrongJSONObject(wrongListArray, rds.getFund_code(), rds.getDate_no(), "基金"+rds.getFund_name()+"异常，请检查报告类型是否正确。");
				return false;	
		}
		if (!Constants.核对一致.equals(dataCheckCode) && !Constants.人工确认一致.equals(dataCheckCode) && 	//数据核对状态检查
				!Constants.不需要核对.equals(dataCheckCode)&& !Constants.不需要核对有修改.equals(dataCheckCode)	
				) {
			outerService.pushWrongJSONObject(wrongListArray, rds.getFund_code(), rds.getDate_no(), ""+rds.getFund_name()+"的核对结果不一致,不能生成报告,请先在明细中确认财务指标。");
			return false;}	
		if (!Constants.投监核对一致.equals(ivsp_chk_rslt_code) && !Constants.投监不需要核对.equals(ivsp_chk_rslt_code)) {			//投监核对状态检查
			outerService.pushWrongJSONObject(wrongListArray, rds.getFund_code(), rds.getDate_no(), ""+rds.getFund_name()+"的投资监督核对结果不符合能生成报告,请联系投资监督人员核对。");
			return false;}
		
		return true;
	}
	
	/**
	 * 发起量化运行表至及贝克 入口
	 * @param jsonArray
	 * @param request
	 * @param response
	 * @param resultMap
	 * @return
	 */
	public Map<String,String> sendManagerToJBKEntrance(JSONArray jsonArray, HttpServletRequest request, HttpServletResponse response, Map<String, String> resultMap){
		List<Map<String, String>> fundsList = new ArrayList<Map<String, String>>();
		AtomicInteger error = new AtomicInteger(0);
		AtomicInteger success = new AtomicInteger(0);
		String mandatory = request.getParameter("mandatory");// 获取通过ajax提交的数据data
		Integer total = jsonArray.size();
		JSONArray wrongListArray = new JSONArray();
		for (Object o : jsonArray) { // 遍历管理人列表
			try {
				Map<String, String> m = new HashMap<String, String>();
				String magr_no = JSONObject.fromObject(o).get("magr_no").toString();
				String date_no = JSONObject.fromObject(o).get("date_no").toString();
				m.put("magr_no", magr_no);
				m.put("date_no", date_no);
				fundsList.add(m);

				ReptDiscSitu_MAGR manager = new ReptDiscSitu_MAGR();
				manager.assembleMapToRept_Disc_Situ_Magr(xinXiPiLuDao.get1MonthlyManagerData("M2", date_no, "" , null, null, magr_no,"").get(0));
				Rept_M_Magr_Info rept_M_Magr_Info = xinXiPiLuDao.get1MonthlyReptManagerInfo(magr_no, Const.WAIBAO,manager.getDate_No() );
				if (manager.getMagr_Name()==null || manager.getMagr_Name().equals("")|| rept_M_Magr_Info==null) {
					resultMap.put("fail", "管理人没有名字或没有信息，继续打印其他管理人");
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, magr_no, manager.getDate_No(),
							"管理人" + manager.getMagr_No() + "没有名字或没有信息，无法推送");
					continue;
				} 
				List<Rept_m_qunt_prfund_run> list = xinXiPiLuDao.getRept_m_qunt_prfund_runByMgrOrMonth(magr_no, date_no, null, null, null);
				if (list == null || list.size() < 1) {
					logger.error("erronues manager is printing! the printing-json function is skipped "+ magr_no + "管理人名下没有基金");
					resultMap.put("fail", "erronues manager is printing!"+ magr_no + " 名下没有量化基金产品，将继续打印其他管理人");
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, magr_no, manager.getDate_No(),
							"管理人" + manager.getMagr_Name() + "名下没有量化基金产品,无法更新至吉贝克数据库");
					continue;
				}

//				// 检查是否具备一般推送条件
//				if (!checkFundAvailable(m, report_type, resultMap, wrongListArray)) {
//					error.incrementAndGet();
//					continue;
//				}
				// 检查并且是否具备强制推送条件
				if ("1".equals(mandatory) && !checkFundMandatoryAvailable(fundsList, change2MQQUIQUP("M2"), resultMap)) {
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, manager.getMagr_No(), date_no,
							"管理人" + manager.getMagr_Name() + "的报告状态不具备强制推送条件");
					continue;
				}

//				// 推送数据前调用存储过程
				if (!outerService.callManagerProcecedure_etl_init_xp_data(manager.getMagr_No(),date_no)){
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, manager.getMagr_No(), date_no,
							"管理人" + manager.getMagr_Name() + "发送吉贝克前前调用存储过程失败");
					continue;
				}

				// 推送数据
				if (!sendMAGRToJiBeiKeDataBase(manager, change2MQQUIQUP("M2"), manager.getDate_No(),	resultMap)) {
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, manager.getMagr_No(), manager.getDate_No(),
							"管理人" + manager.getMagr_Name() + "推送时报错，无法更新至吉贝克数据库");
					error.incrementAndGet();

					continue;
				}
				// 调用接口通知推送信息
				String result = notifyJiBeKe(magr_no, change2MQQUIQUP("M2"), date_no, resultMap,
						mandatory, success);
				if ("1".equals(mandatory)) {
//					yueBaoS.insertHistory(yueBaoS.change2PBRS(report_type), date_no, fund_code, rds.getFund_name(),
//							"强制生成", LoginUtil.getIPAdrress(request),
//							rds.getDisc_type_code() + " " + rds.getFund_code() + " " + rds.getDate_no(), "",
//							rds.getDisc_type_code() + " " + rds.getFund_code() + " " + rds.getDate_no(), mandatory,
//							resultMap);
				}
				if (result == null || "".equals(result)) {
					logger.error("吉贝克返回json结果无法被格式化");
					resultMap.putIfAbsent("code", Constants.OTHER_ERRORCODE);
					resultMap.putIfAbsent("message", "parse json fail, magr_no: " + magr_no + ",dateNo: " + date_no
							+ ", reportType: " + "量化运行表");
					resultMap.putIfAbsent("data", "cannot parse json from JiBeiKe: " + result);
					outerService.pushWrongJSONObject(wrongListArray, magr_no, date_no,
							"管理人" + manager.getMagr_Name() + "发生错误,推送失败");
					resultMap.put("wrongList", wrongListArray.toString());
					continue;
				}

				// 回写reptdiscsitu记录结果
				updateReptDiscSituJBK(result, manager.getMagr_No(), change2MQQUIQUP("M2"), date_no, resultMap,
						"1".equals(mandatory), success, error);
				resultMap.put("returnFromJiBeiKe", result);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
				if (resultMap.get("code") == null)
					resultMap.put("code", Constants.OTHER_ERRORCODE);
				if (resultMap.get("message") == null)
					resultMap.put("message", "fail");
				if (resultMap.get("data") == null) {}
//					resultMap.put("data", "fail to process  magrno: " + magr_no + ",dateNo: " + date_no
//							+ ", reportType: " + report_type);
				resultMap.put("wrongList", wrongListArray.toString());
			}
		}
		resultMap.put("wrongList", wrongListArray.toString());
		resultMap.put("errorNum", String.valueOf(error));
		resultMap.put("totalNum", String.valueOf(total));
		if (resultMap.get("code") == null)
			resultMap.put("code", Constants.SUCCESS);
		if (resultMap.get("message") == null)
			resultMap.put("message", "success");
		if (resultMap.get("data") == null)
			resultMap.put("data", "successfuly pushed "+total+" managers " );

		return resultMap;

	} 

	
	
	/**
	 * 查询某一时段明细
	 * @param pd
	 * @return
	 * @throws InterruptedException
	 * @throws DecoderException 
	 * @throws UnsupportedEncodingException 
	 */
	public List<Map<String, Object>> search1PeriodDisctChkRsltData(PageData pd) throws InterruptedException, DecoderException, UnsupportedEncodingException {
		String reportType = pd.getString("reportType");
		reportType= change2MQQUIQUP(reportType);
		
		String fundName =pd.getString("fundName");
		if (fundName!=null && !Constants.LOCAL.equals(SYSTEMENVIRONMENTMARK) ) { fundName=new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8");}
		return (pd!=null)? xinXiPiLuDao.get1PeriodlyDisctChkRsltData(reportType,
																	pd.getString("dateNO"),
																	pd.getString("heDuiYiZhi"),
																	fundName,
																	//new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8")
																	pd.getString("fundCode")

				 ):null;
	}
	
	/**
	 * 转换report_type 至M/M2/Q/QUI/QUP/SMO
	 * @param report_type 
	 * @return 输出 “M/M2/Q/QUI/QUP”； 
	 */
	public String change2MQQUIQUP(String report_type) {
        if (report_type.toUpperCase().equals("PB0001") 		||report_type.toUpperCase().equals("MONTH") || report_type.toUpperCase().equals("M") ) 	report_type="M";
        else if (report_type.toUpperCase().equals("RS0030") ||report_type.toUpperCase().equals("QUANT")|| report_type.toUpperCase().equals("M2") ) 	report_type="M2";
        else if (report_type.toUpperCase().equals("PB0002") ||report_type.toUpperCase().equals("QUATER")|| report_type.toUpperCase().equals("Q") ) 	report_type="Q";
        else if (report_type.toUpperCase().equals("RS0001") ||report_type.toUpperCase().equals("QUP")) 												report_type="QU";
        else if (report_type.toUpperCase().equals("QUI") 	||report_type.toUpperCase().equals("QUI")) 												report_type="QUI";
        else if (report_type.toUpperCase().equals("QU") 	||report_type.toUpperCase().equals("QUATERLYUPDATE")  ) 								report_type="QU";
        else if (report_type.toUpperCase().equals("PB0004") ||report_type.toUpperCase().equals("HSR") 	||report_type.toUpperCase().equals("HALFYEAR")) 					
        																																			report_type="HSR";
        else if (report_type.toUpperCase().equals("规模以上") 	||report_type.toUpperCase().equals("SMO")) 												report_type="SMO";//以上为合法参数，继续下一步
        else {																																		//错误参数置空
        	report_type="";
        }
        return report_type;
	}
	
	/**
	 * 转换report_type至PB0001/PB0002/RS0030/QU/SMO等
	 * @param report_type 
	 * @return 输出 “PB0001/PB0002/RS0030/QU/SMO等”
	 */
	public String change2PBRS(String report_type) {
        if (report_type.toUpperCase().equals("PB0001") 		||report_type.toUpperCase().equals("MONTH") || report_type.toUpperCase().equals("M") ) 		report_type="PB0001";
        else if (report_type.toUpperCase().equals("RS0030") ||report_type.toUpperCase().equals("QUANT") || report_type.toUpperCase().equals("M2") ) 	report_type="RS0030";
        else if (report_type.toUpperCase().equals("PB0002") ||report_type.toUpperCase().equals("QUATER")|| report_type.toUpperCase().equals("Q") ) 		report_type="PB0002";
        else if (report_type.toUpperCase().equals("RS0001") ||report_type.toUpperCase().equals("QUP") 	|| report_type.toUpperCase().equals("QUATERLYUPDATE")||report_type.toUpperCase().equals("QU")) report_type="RS0001";
        else if (report_type.toUpperCase().equals("QUI")) 																								report_type="QUI";
        else if (report_type.toUpperCase().equals("PB0004") ||report_type.toUpperCase().equals("HALFYEAR")||report_type.toUpperCase().equals("HSR")  ) 										report_type="PB0004";
        else if (report_type.toUpperCase().equals("规模以上") 	||report_type.toUpperCase().equals("SMO")) 												report_type="SMO";//以上为合法参数，继续下一步

        else {																								//错误参数置空
        	report_type="";
        }
        return report_type;
	}
	
	/**
	 * 转换report_type至PB0001/PB0002/RS0030/QU/SMO等
	 * @param report_type 
	 * @return 输出 “PB0001/PB0002/RS0030/QU/SMO等”
	 */
	public String change2ChineseMQQUIQUP(String report_type) {
        if (report_type.toUpperCase().equals("PB0001") 		||report_type.toUpperCase().equals("MONTH") || report_type.toUpperCase().equals("M") ) 		report_type="月报";
        else if (report_type.toUpperCase().equals("RS0030") ||report_type.toUpperCase().equals("QUANT") || report_type.toUpperCase().equals("M2") ) 	report_type="量化运行表";
        else if (report_type.toUpperCase().equals("PB0002") ||report_type.toUpperCase().equals("QUATER")|| report_type.toUpperCase().equals("Q") ) 		report_type="季报";
        else if (report_type.toUpperCase().equals("RS0001") ||report_type.toUpperCase().equals("QUP") 	|| report_type.toUpperCase().equals("QUATERLYUPDATE")||report_type.toUpperCase().equals("QU")) report_type="季度更新_产品运行表";
        else if (report_type.toUpperCase().equals("QUI")) 																								report_type="季度更新_投资者信息表";
        else if (report_type.toUpperCase().equals("PB0004") ||report_type.toUpperCase().equals("HALFYEAR")||report_type.toUpperCase().equals("HSR")  ) 										report_type="半年报";
        else if (report_type.toUpperCase().equals("规模以上") 	||report_type.toUpperCase().equals("SMO")) 												report_type="规模以上运行表";//以上为合法参数，继续下一步
        else {																								//错误参数置空
        	report_type="";
        }
        return report_type;
	}
	
	/**
	 * 基金为单位的产品披露类型
	 * @param report_type 
	 * @return 输出 “M/M2/Q/QUI/QUP”； 
	 */
	public Boolean isFundBaseType(String report_type) {
		String validType =change2MQQUIQUP(report_type);
        if (		validType.equals(change2MQQUIQUP("M")) 		
        	||		validType.equals(change2MQQUIQUP("Q")) 	
        	||		validType.equals(change2MQQUIQUP("QU")) 	
        	||		validType.equals(change2MQQUIQUP("QUI")) 	
        	||		validType.equals(change2MQQUIQUP("HSR"))
        	) {
        	return true;		//以上为基金为单位的产品，继续下一步
        } 	
        	return false;		
	}
	
	/**
	 * 管理人维度为单位的产品披露类型
	 * @param report_type 
	 * @return 输出 “M/M2/Q/QUI/QUP”； 
	 */
	public Boolean isManagerBaseType(String report_type) {
		String validType =change2MQQUIQUP(report_type);
        if (		validType.equals(change2MQQUIQUP("SMO")) 		
        	||		validType.equals(change2MQQUIQUP("M2")) 	
        	) {
        	return true;		//以上为管理人维度的产品，继续下一步
        } 	
        	return false;		
	}
	
	/**
	 * 翻译modify的type
	 * @param modify
	 * @return
	 */
	public String translateModifyType(String modify) {
		if (modify==null|| "".equals(modify)) {return "";}
		String validModifyString = "";
		switch (modify) {
		case Constants.MODIFY: 
			validModifyString="修改操作";
			break;
		case Constants.CONFIRM: 
			validModifyString="指标确认";
			break;
		}
		return validModifyString;
	} 
	

	
	
}
