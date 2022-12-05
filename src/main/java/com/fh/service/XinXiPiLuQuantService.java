/**
 * 
 */
package com.fh.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.stereotype.Service;

import com.fh.dao.XinxipiluDao;
import com.fh.util.Const;
import com.fh.util.Constants;
import com.fh.util.PageData;
import com.fh.util.file.FileUtil;
import com.swhy.xxpl.model.ReptDiscSitu_MAGR;
import com.swhy.xxpl.model.Rept_M_Magr_Info;
import com.swhy.xxpl.model.Rept_m_qunt_prfund_run;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import sinosoft.utils.PropertyUtils;

/**
 * @author 230355 信息披露生成月报季报的service
 *
 */

@Service("XinXiPiLuQuantService")
public class XinXiPiLuQuantService {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;

	@Resource(name = "XinXiPiLuService")
	XinXiPiLuService xinXiPiLuService;
	
    @Resource(name="XinXiPiLuYueBaoServiceNew")
    XinXiPiLuYueBaoServiceNew yueBaoS;
	private static final Boolean SIGN_PDF = true;
	private static final Integer SIGN_X = 240;
	private static final Integer SIGN_Y = 120;
	private static final String TOPRINT = "1";
	private static final String EXCELFOLDER = "excel\\";
	private static final String WORDFOLDER = "word\\";
	private static final String PDFFOLDER = "PDF\\";
	private static final String JSONFOLDER = "json\\";

	public static final String REPORTINGSERVICEJARPATH = PropertyUtils.getSysConfigSet("reportservicejarPath");
	public static final String MONTHLYREPORTEXCELTEMPLATE = "信息披露月报模板.xls";
	public static final String MONTHLYREPORTDOCSTEMPLATE = "基金月报模板.docx";
	public static final String QUARTERLYREPORTEXCELTEMPLATE = "信息披露季报模板.xls";
	public static final String QUARTERLYREPORTDOCSTEMPLATE = "基金季报模板.xls";

	/**
	 * 最终装配成JSON，生成JSON的底层方法
	 * 
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return Map<String,String> json_monthlyReport
	 */
	public JSONObject generateQuantMonthlyReportJSON(List<Rept_m_qunt_prfund_run> list, Rept_M_Magr_Info rept_M_Magr_Info,Map<String, Object> features) {
		if (list == null)
			return null;
		JSONObject resultJson = new JSONObject();
		JSONArray json_QuantMonthlyReport  = JSONArray.fromObject(list);
		resultJson.put("Rept_M_Magr_Info", JSONObject.fromObject(rept_M_Magr_Info));
		resultJson.put("Rept_m_qunt_prfund_runs", json_QuantMonthlyReport);
		// fix cycle hierarchy in JSON
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		resultJson.put("features", JSONObject.fromObject(features));
		logger.info("generating Quant JSON: " + resultJson.toString());
		return resultJson;
	}

	/**
	 * Either build a new feature or finish a feature for Monthly Report
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return
	 */
	public Map<String, Object> fillQuantFeatures(Rept_m_qunt_prfund_run quant, Map<String, Object> features,
			String folderPath, ReptDiscSitu_MAGR manager) {
		features = features == null ? new HashMap<String, Object>() : features;
		String managerName = quant.getMagr_no();
		String fundName = quant.getFund_name();
		String monthNoString = quant.getMth_no();
		Map<String, Object> pathsMap = xinXiPiLuDao.getPaths();
		String fileName = manager.getMagr_Name() + "_量化私募基金运行报表_" + quant.getMth_no();
		String modelFilePath = pathsMap.get("tgzx_disk_drive").toString()
				+ pathsMap.get("monthly_report_model_path").toString() + "\\";
		features.putIfAbsent("excel_tpl_path", modelFilePath + pathsMap.get("quant_monthly_model_excel"));
		features.putIfAbsent("excel_path", folderPath + EXCELFOLDER + fileName + ".xlsx");
		FileUtil.createDir(folderPath + EXCELFOLDER);
		return features;
	}

	/**
	 * 获取数据库中mds.discsitu_magr的已存在的不同的月份
	 * 
	 * @param pg
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String, String>> getAllQuantDateOptions(PageData pg) throws IOException, Exception {
		String date_type= pg.getString("date_Type");
		if (date_type == null) return null;
		date_type = yueBaoS.change2MQQUIQUP(date_type);
		return xinXiPiLuDao.getAllQuantDateOptions(date_type);
	}

	/**
	 * 获取数据库中mds.discsitu_magr的已存在的不同的月份
	 * @param pg
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String, String>> getAllQuanManagersOptions(PageData pg) throws IOException, Exception {
		return xinXiPiLuDao.getAllQuanManagersOptions(pg.getString("date_Type"));
	}

	/**
	 * 
	 * @param pd
	 * @return
	 * @throws InterruptedException
	 * @throws DecoderException
	 * @throws IOException 
	 */
	public List<Map<String, Object>> search1QuantMonthlyData(PageData pd, String sort, String order,String reportType, String managerName, String isPrinted) throws InterruptedException, DecoderException, IOException {
		return (pd!=null)? xinXiPiLuDao.get1MonthlyManagerData(		yueBaoS.change2MQQUIQUP(reportType) ,
																	pd.getString("quantMonthNO"),
																	managerName,
																	sort,order,
																	null,isPrinted
//																	
				 ):null;
	}
	
	/**
	 * 
	 * @param pd
	 * @return
	 * @throws InterruptedException
	 * @throws DecoderException
	 * @throws IOException 
	 */
	public List<Map<String, Object>> search1SMOMonthlyData(PageData pd, String sort, String order, String isPrinted) throws InterruptedException, DecoderException, IOException {
		return (pd!=null)? xinXiPiLuDao.get1MonthlyManagerData(		Constants.SMO/*pd.getString("serviceType")*/,
																	pd.getString("quantMonthNO"),
																	pd.getString("managerName")==null?"":new String( pd.getString("managerName").getBytes("ISO-8859-1"),"utf-8"),
																	sort,order,
																	null,isPrinted
//																	
				 ):null;
	}
	/**
	 * 接受打印某个fund的请求，调用更新该fund打印状态字段的数据库的方法
	 * @param fund，        从核对应用数据库中提取综合管理平台中的基金属性信息
	 * @param reptDiscSitu
	 * @param JSONPath
	 * @return 如果原料JSON文件不存在, 返回false;反之为 true
	 * @throws InterruptedException
	 */
	  public Boolean executePrintingQuantExcelFilesfromJSON( ReptDiscSitu_MAGR manager, String mth_no, String JSONPath) throws InterruptedException {
		  //prepare printing if(new File(JSONPath)==null) return false;//如果文件不存在, 返回失败
		  try { 
			  return xinXiPiLuDao.updateReptDiscSituMAGRPrintStatus(manager, mth_no,TOPRINT, JSONPath) ; 
		  } catch (IOException e) { 
			  logger.error(e);
			  e.printStackTrace(); 
		  } return false; 
	  }
	 


	  /**
	   * 准备并打印量化基金产品，打印至json文件当中
	   * @param managerNOs
	   * @param monthNo
	   * @return
	   * @throws InterruptedException
	   */
	@SuppressWarnings("static-access")
	public Map<String, String> prepareAndPrintQuantExcelMonth(List<String> managerNOs, String monthNo)
			throws InterruptedException {
		Map<String, String> resultMSG = new HashedMap();
		if (managerNOs == null || managerNOs.size() < 1) {
			resultMSG.put("fail", "没有管理人");
			return resultMSG;
		}
		for (String managerNO : managerNOs) {
			try {
				List<Rept_m_qunt_prfund_run> list = xinXiPiLuDao.getRept_m_qunt_prfund_runByMgrOrMonth(managerNO,
						monthNo, null, null, null);
				ReptDiscSitu_MAGR manager = new ReptDiscSitu_MAGR();
				manager.assembleMapToRept_Disc_Situ_Magr(xinXiPiLuDao.get1MonthlyManagerData("M2", monthNo, "" , null, null, managerNO,"").get(0));
				manager.assembleMapToRept_Disc_Situ_Magr(xinXiPiLuDao.get1MonthlyManagerData("M2", monthNo, "" , null, null, managerNO,"").get(0));

				Rept_M_Magr_Info rept_M_Magr_Info = xinXiPiLuDao.get1MonthlyReptManagerInfo(managerNO, Const.WAIBAO,manager.getDate_No() );
				if (manager.getMagr_Name()==null || manager.getMagr_Name().equals("")|| rept_M_Magr_Info==null) {
					resultMSG.put("fail", "管理人没有名字或没有信息");
					continue;
				} 
				
				if (list == null || list.size() < 1) {
					logger.error("erronues manager is printing! the printing-json function is skipped "+ managerNO + "管理人名下没有基金");
					resultMSG.put("fail", "erronues manager is printing!"+ managerNO + " 名下没有量化基金产品，将继续打印其他管理人");
					continue;
				}

				// 获取路径
				Map<String, Object> features = xinXiPiLuDao.getPaths();
				// 创建文件夹
				String folderPath = features.get("tgzx_disk_drive").toString()
						+ features.get("quant_monthly_report_path").toString() + "\\" + monthNo + "\\";
				FileUtil.createDir(folderPath + "json\\");
				String JSONPath = folderPath + JSONFOLDER + "量化基金月报_"+managerNO + ".json";
				// 生成并打印json
				JSONObject monthJson = generateQuantMonthlyReportJSON(list, rept_M_Magr_Info,
						fillQuantFeatures(list.get(0), null, folderPath, manager));
				if (monthJson != null && xinXiPiLuService.printingJSONtoFolder(monthJson, JSONPath)) {
					if (executePrintingQuantExcelFilesfromJSON(manager,monthNo,JSONPath)) resultMSG.put("sucess", "success");
					else resultMSG.put("fail", "更新以下基金数据库时发生错误，不能打印excel文件,包括 " + manager.getMagr_Name());
				}
				else
					logger.error(
							"Printing JSON for " + managerNO + " failed");
			} catch (IOException e) {
				e.printStackTrace();
				resultMSG.put("fail", e.getMessage());
			}
		}
		resultMSG.put("success", "success");
		return resultMSG;
	}

	/**
	 * @author 230355 仅为测试数据库使用 just testing whether the target database is
	 *         accessible.
	 * @throws Exception
	 * @throws IOException
	 */
	@Test
	public void test() throws IOException, Exception {
		// runCMD();
		String cmd = "java -jar " + "reportservice.jar"/* REPORTINGSERVICEJARPATH */ + " "
				+ "D:\\xinXiPiLuReports\\月报\\202109\\泓湖泓源宏观策略私募证券投资基金\\泓湖泓源宏观策略私募证券投资基金.json";// "cmd /c start
																								// "+path+"/"+filename;
		// String cmd = "cmd /c start B:/虚拟估值表/start.bat";
		try {
			String[] test = {};
			Runtime.getRuntime().exec(cmd);
			File file = new File("D:\\Codes\\guzhi\\reportservice\\");
			Runtime.getRuntime().exec(cmd, test, file);
			System.out.println("executed " + cmd);
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}

	}
}
