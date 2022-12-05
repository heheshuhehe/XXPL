/**
 * 
 */
package com.fh.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Path;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.fh.util.reportService.com.swhy.report.ReportApp;
import com.fh.util.reportService.com.swhy.report.ReportHelper;
import javax.annotation.Resource;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.junit.Test;
import org.springframework.stereotype.Service;

import com.fh.dao.XinxipiluDao;
import com.fh.util.Const;
import com.fh.util.DaoUtil;
import com.fh.util.PageData;
import com.fh.util.StringUtil;
import com.fh.util.file.FileUtil;
import com.google.gson.JsonObject;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptMFundInfo;
import com.swhy.xxpl.model.ReptMNetVal;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.Rept_m_qunt_prfund_run;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import sinosoft.utils.PropertyUtils;

/**
 * @author 230355
 * 信息披露生成月报季报的service
 *
 */

@Service("XinXiPiLuService")
public class XinXiPiLuService {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	private  final Boolean SIGN_PDF 	= true;
	private  final Integer SIGN_X		= 440;
	private  final Integer SIGN_Y		= 630;
	private  final String TOBEPRINTED	= "1";
	private  final String INTHELIST		= "1";			//清单内
	private  final String OUTOFLIST		= "0";			//清单外
	private  final String MANULADD		= "2";			//人工新增
	public final String ALLSELECT 		= "全选";
	static final String EXCELFOLDER 	= "excel\\";
	static final String WORDFOLDER 		= "word\\";
	static final String PDFFOLDER 		= "PDF\\";
	private static final String JSONFOLDER 	= "json\\";
	
	public static final String REPORTINGSERVICEJARPATH 		= PropertyUtils.getSysConfigSet("reportservicejarPath");
	public static final String MONTHLYREPORTEXCELTEMPLATE	="信息披露月报模板.xls";
	public static final String MONTHLYREPORTDOCSTEMPLATE	="基金月报模板.docx";
	public static final String QUARTERLYREPORTEXCELTEMPLATE	="信息披露季报模板.xls";
	public static final String QUARTERLYREPORTDOCSTEMPLATE	="基金季报模板.xls";
	
	
	/**
	 * 生成JSON传参入口, 用于测试, 生产环境并未使用该方法
	 * @param fund_code			基金编号
	 * @param waiboOrTuoguan	wb/tg
	 * @param monthNO			*202108*
	 * @param features			月报本身的属性
	 * @return 
	 * @throws IOException
	 */
	public  JSONObject buildElementsForMonthlyReport(String fund_code, String waiboOrTuoguan, String monthNO, Map<String, Object> features) throws Exception {
		ReptMFundInfo fundInfo = xinXiPiLuDao.get1MInfoByFundCode(fund_code, waiboOrTuoguan, monthNO);
		ReptMNetVal netVal = xinXiPiLuDao.get1MNetValByFundCode(fund_code, waiboOrTuoguan, monthNO);
		ReptDiscSitu reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("M", monthNO, fund_code);
		return generateMonthlyReportJSON (reptDiscSitu, fundInfo, netVal,fillMonthFeatures(fundInfo, reptDiscSitu,features, ""));
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
	 * 获取数据库中mds.Rpt的已存在的不同的月份
	 * @param pg
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,String>> getAllDateOptions(PageData pg) throws IOException, Exception{
		return null!=pg.getString("date_Type")?xinXiPiLuDao.getAllDateOptions(pg.getString("date_Type")):null;
	}
	
	/**
	 * 获取数据库中mds.Rpt的已存在的不同的产品名称
	 * @param pg
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,String>> getAllFundNames(PageData pg) throws IOException, Exception{
		return null!=pg.getString("date_Type")?xinXiPiLuDao.getAllFundNames(pg.getString("date_Type")):null;
	}
	
	/**
	 * 执行 reportservice.jar脚本，最终并未采用此方法。而是使用python调用 reportservice.jar
	 * @param path
	 * @param filename
	 * @throws InterruptedException 
	 */
	public static Boolean runCMD(String reportServiceJarPath,String JSONPath/* String path, String filename */) throws InterruptedException{
		String cmd = "cmd /c java -jar "+reportServiceJarPath/*REPORTINGSERVICEJARPATH*/+" "+JSONPath;//"cmd /c start "+path+"/"+filename; 
		try { 
//			File file = new File ("D:\\Codes\\guzhi\\reportservice\\");
//			System.out.println(System.getProperty("java.library.path"));
			
//			StringUtil.runbat("D:\\", "test.bat");.
			Process p = Runtime.getRuntime().exec("cmd /c start D:\\test.bat "+JSONPath); //D:\\xinXiPiLuReports\\月报\\202109\\泓湖泓源宏观策略私募证券投资基金\\泓湖泓源宏观策略私募证券投资基金.json");
			System.out.println("executed "+cmd);
		} catch(IOException ioe) { 
			ioe.printStackTrace(); 
			return false;
			} return true;
		}
	
	
	
	   public List<Map<String, Object>> updateMailData(PageData pd) {
		   return xinXiPiLuDao.updateMailData(pd);
	   }
	   public List<Map<String, Object>> searchMailLog(PageData pd) {
		   return xinXiPiLuDao.searchMailLog(pd);
	   }
	
	/**
	 * 搜寻某1个月的ReptDiscSitu数据，调用get1MonthReptDiscSitu方法实现
	 * @param pd pagedata
	 * @return 如果pagedata(从controller的request中获取)为空则直接返回空，否则执行get1MonthReptDiscSitu
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,Object>> search1MonthlyData(PageData pd, String bill_Flag,String serv_scop, String sort, String order,String gzry) throws IOException, Exception {
		return null;
		//		if (bill_Flag!=null)  {
//			bill_Flag  = new String( bill_Flag.getBytes("ISO-8859-1"),"utf-8");
//			if (ALLSELECT.equals(bill_Flag)) bill_Flag=null;
//		}
//		if (serv_scop!=null) {
//			serv_scop = new String( serv_scop.getBytes("ISO-8859-1"),"utf-8");
//			if( ALLSELECT.equals(serv_scop)) serv_scop=null;
//		}

//		return (pd!=null)? xinXiPiLuDao.get1MonthReptDiscSitu(pd.getString("monthNO"),
//															  pd.getString("heDuiBuYiZhi"),
//															  new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8"),
//															  bill_Flag, 												//清单内 清单外
//															  serv_scop,												//服务范围
//															  sort, order,gzry
//															 ):null;
	}
	
	/**
	 * 创建文件夹，生成并打印fund的json，再通过json打印3个文件(docs,excel and PDF)
	 * @param funds
	 * @param reportType // month, querter, year
	 * @return resultMSG, 包含生成月报的结果，比如更新失败的原因
	 * @throws InterruptedException 
	 */
	public Map<String,String> prepareAndPrint3Files4FundsMonth (List<Map<String,String>> funds) throws Exception{
		Map<String,String> resultMSG = new HashedMap();
		if (funds==null || funds.size()<1) {	
			resultMSG.put("fail","没有基金产品");
			return resultMSG;
		}
		for (Map<String,String> fund: funds) {		//遍历每只基金并打印
			try {
				ReptMFundInfo rptMInfo = xinXiPiLuDao.get1MInfoByFundCode(fund.get("fund_code"), "wb", fund.get("date_no"));
				ReptMNetVal reptMNetVal = xinXiPiLuDao.get1MNetValByFundCode(fund.get("fund_code"), "wb", fund.get("date_no"));
				ReptDiscSitu  reptDiscSitu = xinXiPiLuDao.get1DiscSituByType_Month_FundCode("M", fund.get("date_no"), fund.get("fund_code"));
				if (rptMInfo==null || reptDiscSitu==null) {
					logger.error("erronues fund is printing! the printing-json function is skipped 基金基本信息有错");
					continue;
				}
				//获取路径
				Map<String, Object> features = xinXiPiLuDao.getPaths();
				//创建文件夹
				String folderPath = features.get("tgzx_disk_drive").toString()+
						features.get("monthly_report_path").toString()
						+"\\"+rptMInfo.getMth_no()
						+"\\"+reptDiscSitu.getServ_scop()+"\\";
				FileUtil.createDir(folderPath+"json\\");
				String JSONPath = folderPath+ JSONFOLDER+rptMInfo.getFund_name()+".json";
				//生成并打印json
				JSONObject monthJson = generateMonthlyReportJSON(reptDiscSitu, rptMInfo, reptMNetVal, fillMonthFeatures(rptMInfo, reptDiscSitu, null,folderPath));//生成月报json并生成json文件到指定目录
				if (monthJson!=null && printingJSONtoFolder(monthJson, JSONPath )) 
					if(updatePrinting3FilesfromJSON(reptDiscSitu, JSONPath))	//更新数据库相应字段
						resultMSG.put("sucess", "success");
					else {
						if (resultMSG.get("fail")==null) 
							resultMSG.put("fail", "更新以下基金数据库时发生错误，不能打印3个文件(word, excel和pdf),包括 " +rptMInfo.getFund_name()); 
						else 
							resultMSG.put("fail", resultMSG.get("fail")+", "+rptMInfo.getFund_name());
					}
				else logger.error("Printing JSON for "+ rptMInfo.getFund_code()+ " "+ rptMInfo.getFund_name()+" failed");
			} catch (IOException e) {
				e.printStackTrace();
				resultMSG.put("fail", e.getMessage());
			}
		}
		return resultMSG;
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
	 * 重新采集
	 * @param fundNOs 
	 * @param date_no
	 * @return
	 * @throws InterruptedException
	 * @throws DecoderException
	 * @throws IOException
	 */
	public Boolean recollectFunds(List<String> fundNOs, String date_no,String reportType) throws InterruptedException, DecoderException, IOException {
		if(fundNOs==null|| date_no==null || reportType==null) return false;
		String funds = "";
		for (String s: fundNOs) { funds=funds+s+",";}	//把fundNOs拼接成存储过程可接受的形制
		funds = funds.substring(0, funds.length() - 1);
		return 	xinXiPiLuDao.recollectFunds(funds,date_no,reportType);
	}
	
	
	public List<Map<String, Object>> getComboBoxSource(PageData pd) {
		return xinXiPiLuDao.getComboBoxSource( pd);
	}
	public List<Map<String, Object>> getCommonSQLSearch(PageData pd) {
		return xinXiPiLuDao.getCommonSQLSearch( pd);
	}
	public List<Map<String, Object>> updateCheckBBinfo(PageData pd) {
		return xinXiPiLuDao.updateCheckBBinfo( pd);
	}
	public List<Map<String, Object>> updateBBinfo(PageData pd) {
		return xinXiPiLuDao.updateBBinfo( pd);
	}
	public List<Map<String, Object>> updateCheckinfo(PageData pd) {
		return xinXiPiLuDao.updateCheckinfo( pd);
	}
	/**
	 * @author 230355
	 * 仅为测试数据库使用
	 * just testing whether the target database is accessible.
	 * @throws Exception 
	 * @throws IOException 
	 */
	@Test
	public void test() throws IOException, Exception {
		//runCMD();
		String cmd = "java -jar "+"reportservice.jar"/*REPORTINGSERVICEJARPATH*/+" "+"D:\\xinXiPiLuReports\\月报\\202109\\泓湖泓源宏观策略私募证券投资基金\\泓湖泓源宏观策略私募证券投资基金.json";//"cmd /c start "+path+"/"+filename; 
			//String cmd = "cmd /c start B:/虚拟估值表/start.bat"; 
			try { 
				String[] test= {};
				Runtime.getRuntime().exec(cmd); 
				File file = new File ("D:\\Codes\\guzhi\\reportservice\\");
				Runtime.getRuntime().exec(cmd, test , file);
				System.out.println("executed "+cmd);
			} catch(IOException ioe) { 
				ioe.printStackTrace(); 
				
				} 
	}
	
	
}
