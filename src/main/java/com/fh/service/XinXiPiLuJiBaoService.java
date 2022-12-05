/**
 * 
 */
package com.fh.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.dao.XinxipiluDao;
import com.fh.util.PageData;
import com.fh.util.file.FileUtil;
import com.google.gson.JsonArray;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptMFundInfo;
import com.swhy.xxpl.model.ReptMNetVal;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_info;
import com.swhy.xxpl.model.jibao.Rept_Q_ast_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_fin_indx;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_shr_chg;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_hkcsivsm_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_hkcsivsm_grp_dtl;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_stkivsm_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_magr_rept;
import com.swhy.xxpl.model.jibao.Rept_Q_net_val;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.DefaultDefaultValueProcessor;
import net.sf.json.util.CycleDetectionStrategy;

/**
 * @author 230355 信息披露季度更新service层
 *
 */
@Service("XinXiPiLuJiBaoService")
public class XinXiPiLuJiBaoService {
	protected Logger logger = Logger.getLogger(this.getClass());

	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	@Resource(name = "XinXiPiLuService")
	XinXiPiLuService xinXiPiLuService;

	private  final Boolean SIGN_PDF 	= true;
	private  final Integer SIGN_X		= 440;
	private  final Integer SIGN_Y		= 630;
	/**
	 * 
	 */
	public XinXiPiLuJiBaoService() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 搜寻某1个季度的ReptDiscSitu数据，调用get1quaterReptDiscSitu方法实现
	 * @param pd pagedata
	 * @return 如果pagedata(从controller的request中获取)为空则直接返回空，否则执行get1MonthReptDiscSitu
	 * @throws IOException
	 * @throws Exception
	 */
	public List<Map<String,Object>> search1QuaterlyData(PageData pd, String bill_Flag,String serv_scop,String waibaoshuju,String sort, String order) throws IOException, Exception {
		return null;
		//		if (bill_Flag!=null)  {
//			//bill_Flag  = new String( bill_Flag.getBytes("ISO-8859-1"),"utf-8");
//			if (xinXiPiLuService.ALLSELECT.equals(bill_Flag)) bill_Flag=null;
//		}
//		if (serv_scop!=null) {
//			//serv_scop = new String( serv_scop.getBytes("ISO-8859-1"),"utf-8");
//			if( xinXiPiLuService.ALLSELECT.equals(serv_scop)) serv_scop=null;
//		}
//		if (waibaoshuju!=null) {
//			//waibaoshuju = new String( waibaoshuju.getBytes("ISO-8859-1"),"utf-8");
//			if( xinXiPiLuService.ALLSELECT.equals(waibaoshuju)) waibaoshuju=null;
//		}
//		return (pd!=null)? xinXiPiLuDao.get1quaterReptDiscSitu(	pd.getString("quaterNO"),//"202103",
//																pd.getString("heDuiBuYiZhi"),//"heDuiBuYiZhi",
//																new String( pd.getString("fundName").getBytes("ISO-8859-1"),"utf-8"),//"测试",
//																bill_Flag, 												//清单内 清单外
//																serv_scop,	
//																waibaoshuju,
//																sort, order,"Q"//null,null
//															 ):null;
	}
	
	
	/**
	 * 最终装配成JSON，生成JSON的底层方法
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return	Map<String,String> json_monthlyReport
	 */
	public  JSONObject generateQuaterlyReportJSON(ReptDiscSitu reptDiscSitu,Rept_Q_fund_info rept_Q_Fund_Info, Map<String, Object> features) {
		try {
		String fundCode = reptDiscSitu.getFund_code();
		String qut_NO = reptDiscSitu.getDate_no();
		String info_Src_Code = "wb"; 
		JSONObject json_QuaterlyReport = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT); 
		jsonConfig.registerDefaultValueProcessor(BigDecimal.class, new DefaultDefaultValueProcessor() {
			public Object getDefaultValue(Class type) {
				return  null;
			}
		});
		/* 获取表单sheet页数据 */
		Rept_Q_fin_indx rept_Q_fin_indx = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fin_indx", null,fundCode, qut_NO,"wb",Rept_Q_fin_indx.class).get(0);
		Rept_Q_ast_grp rept_Q_ast_grp = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_ast_grp", null, fundCode, qut_NO,"wb", Rept_Q_ast_grp.class).get(0);
		Rept_Q_fund_shr_chg rept_Q_fund_shr_chg = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fund_shr_chg", null, fundCode, qut_NO,"wb", Rept_Q_fund_shr_chg.class).get(0);
		Rept_Q_iclas_hkcsivsm_grp rept_Q_iclas_hkcsivsm_grp 
									= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_iclas_hkcsivsm_grp", null, fundCode, qut_NO,"wb", Rept_Q_iclas_hkcsivsm_grp.class).get(0);
		Rept_Q_iclas_stkivsm_grp rept_Q_iclas_stkivsm_grp
									= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_iclas_stkivsm_grp", null, fundCode, qut_NO,"wb", Rept_Q_iclas_stkivsm_grp.class).get(0);
		Rept_Q_magr_rept rept_Q_magr_rept	
									= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_magr_rept", null, fundCode, qut_NO,"wb", Rept_Q_magr_rept.class).get(0);
		rept_Q_magr_rept.setMagr_rept(rept_Q_magr_rept.getMagr_rept().toString().replaceAll("\\n", "\n"));
		Rept_Q_net_val rept_Q_net_val 
									= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_net_val", null, fundCode, qut_NO,"wb", Rept_Q_net_val.class).get(0);
		if (reptDiscSitu.hasCFID()) { insertCFIDdata(json_QuaterlyReport, reptDiscSitu, rept_Q_Fund_Info); } 	//分级数据
		List<Rept_Q_iclas_hkcsivsm_grp_dtl> list = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_iclas_hkcsivsm_grp_dtl", null, fundCode, qut_NO, info_Src_Code, Rept_Q_iclas_hkcsivsm_grp_dtl.class);
		
		/* 插入json */
		json_QuaterlyReport.put("rept_q_fund_info", JSONObject.fromObject(rept_Q_Fund_Info, jsonConfig));
		json_QuaterlyReport.put("rept_q_fin_indx", JSONObject.fromObject(rept_Q_fin_indx, jsonConfig));
		json_QuaterlyReport.put("rept_q_ast_grp", JSONObject.fromObject(rept_Q_ast_grp, jsonConfig));
		json_QuaterlyReport.put("rept_q_fund_shr_chg", JSONObject.fromObject(rept_Q_fund_shr_chg, jsonConfig));
		json_QuaterlyReport.put("rept_q_iclas_hkcsivsm_grp_dtl", JSONArray.fromObject(list, jsonConfig) );
		json_QuaterlyReport.put("rept_q_iclas_hkcsivsm_grp", JSONObject.fromObject(rept_Q_iclas_hkcsivsm_grp, jsonConfig));
		json_QuaterlyReport.put("rept_q_iclas_stkivsm_grp", JSONObject.fromObject(rept_Q_iclas_stkivsm_grp, jsonConfig));
		json_QuaterlyReport.put("rept_q_magr_rept", JSONObject.fromObject(rept_Q_magr_rept, jsonConfig));
		json_QuaterlyReport.put("rept_q_net_val", JSONObject.fromObject(rept_Q_net_val, jsonConfig));

		//json_QuaterlyReport.put("rept_m_fund_info", JSONObject.fromObject(fundInfo));
		//if (reptDiscSitu.hasCFID()) json_monthlyReport.put("ReptMNetVal_Cifds", JSONArray.fromObject(reptDiscSitu.getReptMNetVal_Cifds()));
		// fix cycle hierarchy in JSON

		//json_QuaterlyReport.put("rept_m_net_val", JSONObject.fromObject(netVal,jsonConfig));
		json_QuaterlyReport.put("features", JSONObject.fromObject(features));
		logger.info("generating JSON: "+json_QuaterlyReport.toString());
		return json_QuaterlyReport;
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 创建文件夹，生成并打印fund的json，再通过json打印3个文件(docs,excel and PDF)
	 * @param funds
	 * @param reportType // month, quater, year
	 * @return resultMSG, 包含生成月报的结果，比如更新失败的原因
	 * @throws InterruptedException 
	 */
	public Map<String,String> prepareAndPrint3Files4FundsQuater (List<Map<String,String>> funds) throws InterruptedException{
		Map<String,String> resultMSG = new HashedMap();
		if (funds==null || funds.size()<1) {	
			resultMSG.put("fail","没有基金产品");
			return resultMSG;
		}
		for (Map<String,String> fund: funds) {		//遍历每只基金并打印
			try {
				ReptDiscSitu  reptDiscSitu = //xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Disc_Situ", null, fund.get("fund_code"),  fund.get("date_no"),"wb", ReptDiscSitu.class).get(0);
							xinXiPiLuDao.get1DiscSituByType_Month_FundCode("Q",fund.get("date_no"),fund.get("fund_code"))	;
				Rept_Q_fund_info rept_Q_Fund_Info = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.rept_Q_Fund_Info", null, fund.get("fund_code"), fund.get("date_no"),"wb",Rept_Q_fund_info.class).get(0);

				if (rept_Q_Fund_Info==null || reptDiscSitu==null) {
					logger.error("erronues fund is printing! the printing-json function is skipped 基金基本信息有错");
					continue;
				}
				//获取路径
				Map<String, Object> features = xinXiPiLuDao.getPaths();
				//创建文件夹
				String folderPath = features.get("tgzx_disk_drive").toString()+
						features.get("quaterly_report_path").toString()
						+"\\"+rept_Q_Fund_Info.getQut_no()
						+"\\"+reptDiscSitu.getServ_scop()+"\\";
				FileUtil.createDir(folderPath+"json\\");
				String JSONPath = folderPath+ "json\\"+rept_Q_Fund_Info.getFund_name()+".json";
				//生成并打印json
				JSONObject quaterlyJson = generateQuaterlyReportJSON(reptDiscSitu, rept_Q_Fund_Info, fillQuaterlyFeatures(rept_Q_Fund_Info, reptDiscSitu, null,folderPath));//生成月报json并生成json文件到指定目录
				if (quaterlyJson!=null && xinXiPiLuService.printingJSONtoFolder(quaterlyJson, JSONPath )) 
					if(xinXiPiLuService.updatePrinting3FilesfromJSON( reptDiscSitu, JSONPath))	//更新数据库相应字段
						resultMSG.put("sucess", "success");
					else {
						if (resultMSG.get("fail")==null) 
							resultMSG.put("fail", "更新以下基金数据库时发生错误，不能打印3个文件(word, excel和pdf),包括 " +rept_Q_Fund_Info.getFund_name()); 
						else 
							resultMSG.put("fail", resultMSG.get("fail")+", "+rept_Q_Fund_Info.getFund_name());
					}
				else logger.error("Printing JSON for "+ rept_Q_Fund_Info.getFund_code()+ " "+ rept_Q_Fund_Info.getFund_name()+" failed");
			} catch (IOException e) {
				e.printStackTrace();
				resultMSG.put("fail", e.getMessage());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				resultMSG.put("fail", e.getMessage());
			}
		}
		return resultMSG;
	}	
	
	/**
	 * Either build a new feature or finish a feature for Monthly Report
	 * @param fundInfo
	 * @param netVal
	 * @param features
	 * @return
	 */
	public Map<String, Object> fillQuaterlyFeatures (Rept_Q_fund_info rept_Q_Fund_Info, ReptDiscSitu reptDiscSitu, Map<String, Object> features,String folderPath ) {
		features= features==null?new HashMap<String, Object>():features;
		String fundName = rept_Q_Fund_Info.getFund_name();
		String quaterNoString = rept_Q_Fund_Info.getQut_no();
		Map<String, Object>pathsMap = xinXiPiLuDao.getPaths();
		String fileName = rept_Q_Fund_Info.getFund_num()+"_"+fundName+"_季报(证券投资类)_"+quaterNoString+"_"+reptDiscSitu.getRept_date(); 
		fileName=fileName.replaceAll("/", "");
		String modelFilePath = pathsMap.get("tgzx_disk_drive").toString()+pathsMap.get("quaterly_report_model_path").toString()+"\\";
//		features.putIfAbsent("excel_tpl_path", modelFilePath+pathsMap.get(reptDiscSitu.hasCFID()? 
//				"monthly_report_cfid_model_excel":"monthly_report_model_excel"));		//分级基金使用特殊模板
		features.putIfAbsent("excel_tpl_path", modelFilePath+pathsMap.get("quaterly_report_model_excel"));
		features.putIfAbsent("docx_tpl_path", modelFilePath+pathsMap.get("quaterly_report_model_word"));
		features.putIfAbsent("excel_path", folderPath+xinXiPiLuService.EXCELFOLDER+fileName+".xlsx");
		features.putIfAbsent("docx_path", folderPath+xinXiPiLuService.WORDFOLDER+fileName+".docx");
		features.putIfAbsent("pdf_path", folderPath+xinXiPiLuService.PDFFOLDER+fileName+".pdf");
		features.putIfAbsent("watermark", rept_Q_Fund_Info.getFund_name());
		
		features.putIfAbsent("sign_pdf", "true".equals(pathsMap.get("quaterly_report_sign_pdf"))?true:false);
		features.putIfAbsent("sign_x", (Integer.valueOf(pathsMap.get("quaterly_report_sign_X").toString()) ));
		features.putIfAbsent("sign_y", (Integer.valueOf(pathsMap.get("quaterly_report_sign_Y").toString()) ));
		features.putIfAbsent("sign_page", (Integer.valueOf(pathsMap.get("quaterly_report_sign_page").toString()) ));

		FileUtil.createDir(folderPath+xinXiPiLuService.WORDFOLDER);FileUtil.createDir(folderPath+xinXiPiLuService.EXCELFOLDER);FileUtil.createDir(folderPath+xinXiPiLuService.PDFFOLDER);
		return features;
	}	
	
	/**
	 * 如果是分级基金，插入分级基金页面使用的list
	 * @param json_QuaterlyReport
	 * @param reptDiscSitu
	 * @param rept_Q_Fund_Info
	 */
	public void insertCFIDdata(JSONObject json_QuaterlyReport , ReptDiscSitu reptDiscSitu, Rept_Q_fund_info rept_Q_Fund_Info) {
		String fundCode = reptDiscSitu.getFund_code();
		String qut_NO = reptDiscSitu.getDate_no();
		String info_Src_Code = "wb"; 
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT); 
		jsonConfig.registerDefaultValueProcessor(BigDecimal.class, new DefaultDefaultValueProcessor() {
			public Object getDefaultValue(Class type) {
				return  null;
			}
		});		
		List <Rept_Q_net_val>  vals	= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_net_val", null, fundCode, qut_NO,"wb", Rept_Q_net_val.class);
		if (vals.size()>1) vals.remove(0);
		json_QuaterlyReport.put("rept_q_net_val_cifd", JSONArray.fromObject(vals,jsonConfig) );
		List <Rept_Q_fin_indx>  indxs	= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fin_indx", null, fundCode, qut_NO,"wb", Rept_Q_fin_indx.class);
		if (indxs.size()>1) indxs.remove(0);
		json_QuaterlyReport.put("rept_q_fin_indx_cifd",JSONArray.fromObject(indxs,jsonConfig) );
		List <Rept_Q_fund_shr_chg>  chgs	= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fund_shr_chg", null, fundCode, qut_NO,"wb", Rept_Q_fund_shr_chg.class);
		if (chgs.size()>1) chgs.remove(0);
		json_QuaterlyReport.put("rept_q_fund_shr_chg_cifd", JSONArray.fromObject(chgs,jsonConfig));	
	}
	

	
	@Test
	public void testFunction(/* PageData pd, String sort, String order */) throws IOException, Exception {
		xinXiPiLuDao.test();
	}
}
