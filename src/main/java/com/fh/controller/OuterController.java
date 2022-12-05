
package com.fh.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.ObjectUtils.Null;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.system.util.DbserviceController;
import com.fh.controller.system.util.HttpClientUtils;
import com.fh.controller.system.util.JsonArrayUtil;
import com.fh.service.OuterXXPLService;
import com.fh.service.XinXiPiLuJiBaoService;
import com.fh.service.XinXiPiLuJiDuGengXinService;
import com.fh.service.XinXiPiLuQuantService;
import com.fh.service.XinXiPiLuService;
import com.fh.service.XinXiPiLuYueBaoServiceNew;
import com.fh.service.XinxiPiLuNianBaoService;
import com.fh.util.Constants;
import com.fh.util.LoginUtil;
import com.fh.util.NewImageUploadYWB;
import com.fh.util.PageData;
import com.fh.util.PropertyUitls;
import com.fh.util.file.CopyFileTool;
import com.fh.util.file.DeleteFile;
import com.fh.util.file.FileUtil;
import com.swhy.xxpl.model.ReptDiscSitu;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 对外（吉贝克，基金综合管理平台）
 * @since 20221026
 */
@Controller
public class OuterController {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "XinXiPiLuService")
	XinXiPiLuService xinXiPiLu;

	@Resource(name = "XinXiPiLuQuantService")
	XinXiPiLuQuantService xinXiPiLuQuant;

	@Resource(name = "XinXiPiLuJiBaoService")
	XinXiPiLuJiBaoService xinXiPiLuJiBao;

	@Resource(name = "XinXiPiLuJiDuGengXinService")
	XinXiPiLuJiDuGengXinService xinXiPiLuJiDuGengXin;

	@Resource(name = "xinxiPiLuNianBaoService")
	XinxiPiLuNianBaoService xinxiPiLuNianBaoService;

	@Resource(name = "XinXiPiLuYueBaoServiceNew")
	XinXiPiLuYueBaoServiceNew yueBaoS;

	@Resource(name = "OuterXXPLService")
	OuterXXPLService outerService;

	public static final String QUATERLY_UPDATE_TOUZIZHEXINXIBIAO = "quaterly_update_touzizhexinxibiao";
	public static final String QUATERLY_UPDATE_CHANPINYUNXINGBIAO = "quaterly_update_chanpinyunxingbiao";
	static final String SYSTEMENVIRONMENTMARK = PropertyUitls.getSystemEnvironmentMark();

	/**
	 * 调用平台存储过程同步数据，
	 * 向贝克推送数据，
	 * 通知吉贝克数据推送完毕，可以进行下一步数据校验，报表打印等步骤
	 * 
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/notifyJiBeKeRept")
	public Map<String, String> notifyJiBeiKe(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> resultMap = new HashMap<String, String>();
		// 参数校验
		String fund_code = request.getParameter("fund_code");
		String report_type = request.getParameter("report_type");
		String date_no = request.getParameter("date_no");
		String data = request.getParameter("data");// 获取通过ajax提交的数据data
		String mandatory = request.getParameter("mandatory");// 获取通过ajax提交的数据data

		JSONArray jsonArray = JSONArray.fromObject(data); // 将其转化为json对象
		List<Map<String, String>> fundsList = new ArrayList<Map<String, String>>();
		AtomicInteger error = new AtomicInteger(0);
		AtomicInteger success = new AtomicInteger(0);
		Integer total = jsonArray.size();
		if (errorParameter(report_type, Constants.REPORTTYPEERRORCODE, resultMap, "reportType", null, error, total,
				success)) {
			return resultMap;
		}

		String validReport_type = yueBaoS.change2PBRS(report_type);
		JSONArray wrongListArray = new JSONArray();
		if (validReport_type.equals("")) { // 如果不是合法report_type，报错并输出错误到resultmap
			errorParameter("", Constants.REPORTTYPEERRORCODE, resultMap, "reportType", wrongListArray, error, total,
					success); //
			return resultMap;
		}
		// 投资者信息表走专门接口,规模以上运行表入口
		if (yueBaoS.change2MQQUIQUP(report_type).equals("QUI") || "SMO".equals(yueBaoS.change2MQQUIQUP(report_type))) {
			return UpdateTouZiZheXinXiBiao(request, response);
		}
		//量化信息专用接口
		if ("M2".equals(yueBaoS.change2MQQUIQUP(report_type)) ) {
			return yueBaoS.sendManagerToJBKEntrance(jsonArray,request,response,resultMap);
		}
		
		for (Object o : jsonArray) { // 获得基金主键
			try {
				Map<String, String> m = new HashMap<String, String>();
				m.put("date_no", JSONObject.fromObject(o).get("date_no").toString());
				m.put("fund_code", JSONObject.fromObject(o).get("fund_code").toString());

				fundsList.add(m);
				ReptDiscSitu rds = yueBaoS.get1DiscSituByType_Month_FundCode(yueBaoS.change2MQQUIQUP(report_type),
						m.get("date_no"), m.get("fund_code"));
				// 检查是否具备一般推送条件
				if (!yueBaoS.checkFundAvailable(m, report_type, resultMap, wrongListArray)) {
					error.incrementAndGet();
					continue;
				}
				// 检查并且是否具备强制推送条件
				if ("1".equals(mandatory) && !yueBaoS.checkFundMandatoryAvailable(fundsList, report_type, resultMap)) {
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, rds.getFund_code(), date_no,
							"基金" + rds.getFund_name() + "的报告状态不具备强制推送条件");
					continue;
				}
				// 推送数据前调用存储过程
				if (!outerService.callProc_Entrance(m.get("fund_code"), m.get("date_no"),report_type )) {
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, m.get("fund_code"), date_no,
							"基金" + rds.getFund_name() + "发送吉贝克前前调用存储过程失败");
					continue;
				}
				// 推送数据
				if (!yueBaoS.sendToJiBeiKeDataBase(m.get("fund_code"), validReport_type, m.get("date_no"), null,
						resultMap)) {
					error.incrementAndGet();
					outerService.pushWrongJSONObject(wrongListArray, m.get("fund_code"), m.get("date_no"),
							"基金" + rds.getFund_name() + "无法更新至吉贝克数据库");
					continue;
				}
				// 调用接口通知推送信息
				String result = yueBaoS.notifyJiBeKe(m.get("fund_code"), validReport_type, m.get("date_no"), resultMap,
						mandatory, success);
				if ("1".equals(mandatory)) {
					yueBaoS.insertHistory(yueBaoS.change2PBRS(report_type), date_no, fund_code, rds.getFund_name(),
							"强制生成", LoginUtil.getIPAdrress(request),
							rds.getDisc_type_code() + " " + rds.getFund_code() + " " + rds.getDate_no(), "",
							rds.getDisc_type_code() + " " + rds.getFund_code() + " " + rds.getDate_no(), mandatory,
							resultMap);
				}
				if (result == null || "".equals(result)) {
					logger.error("吉贝克返回json结果无法被格式化");
					resultMap.putIfAbsent("code", Constants.OTHER_ERRORCODE);
					resultMap.putIfAbsent("message", "parse json fail, fundcode: " + fund_code + ",dateNo: " + date_no
							+ ", reportType: " + report_type);
					resultMap.putIfAbsent("data", "cannot parse json from JiBeiKe: " + result);
					outerService.pushWrongJSONObject(wrongListArray, m.get("fund_code"), date_no,
							"基金" + rds.getFund_name() + "发生错误,推送失败");
					resultMap.put("wrongList", wrongListArray.toString());
					continue;
				}

				// 回写reptdiscsitu记录结果
				yueBaoS.updateReptDiscSituJBK(result, m.get("fund_code"), validReport_type, m.get("date_no"), resultMap,
						"1".equals(mandatory), success, error);
				resultMap.put("returnFromJiBeiKe", result);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e);
				if (resultMap.get("code") == null)
					resultMap.put("code", Constants.OTHER_ERRORCODE);
				if (resultMap.get("message") == null)
					resultMap.put("message", "fail");
				if (resultMap.get("data") == null)
					resultMap.put("data", "fail to process  fundcode: " + fund_code + ",dateNo: " + date_no
							+ ", reportType: " + report_type);
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
			resultMap.put("data", "successfuly pushed  fund: " + fund_code);

		return resultMap;
	}

	/**
	 * 投资者信息表,规模以上管理人报表，调用存储过程
	 * 
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/updatequaterlyupdate")
	public Map<String, String> UpdateTouZiZheXinXiBiao(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> resultMap = new HashMap<String, String>();
		try {
			logger.info("UpdateTouZiZheXinXiBiao");
			HashMap<String, String> fund = new HashMap<String, String>();
			List<Map<String, String>> fundsList = new ArrayList<Map<String, String>>();
			String report_type = request.getParameter("report_type"); // report_
			String date_no = request.getParameter("date_no");
			String fund_code = request.getParameter("fund_code");
			String magr_p_code = request.getParameter("magr_p_code");
			String data = request.getParameter("data");//
			String realTime = request.getParameter("realTime");//
			String recollect = request.getParameter("recollect");//
			AtomicInteger error = new AtomicInteger(0);
			AtomicInteger success = new AtomicInteger(0);
			String authkey = "";// "403c933f6b9bf16af77233971f5bd295"; //暂时写死了 记得删除
			logger.info("data " + data);
			JSONArray jsonArray = JSONArray.fromObject(data); // 将其转化为json对象
			if (null == data && magr_p_code == null) { // 判断data是否为空, 无p码且无data则返回报错
				errorParameter(data, Constants.DATAERRORCODE, resultMap, "data, missing data or method is not POST",
						null, new AtomicInteger(1), 0, new AtomicInteger(0));
				return resultMap;
			}

			int total = jsonArray == null ? 0 : jsonArray.size();
			if (errorParameter(report_type, Constants.REPORTTYPEERRORCODE, resultMap, "reportType", null,
					new AtomicInteger(total), total, new AtomicInteger(0))
					|| errorParameter(date_no, Constants.DATE_NOERRORCODE, resultMap, "date_no", null,
							new AtomicInteger(total), total, new AtomicInteger(0)) // ||
			) {
				return resultMap;
			}
			System.out.println("data is " + data);
			if ("QUI".equals(yueBaoS.change2MQQUIQUP(report_type))) {
				for (Object o : jsonArray) { // 获得基金主键
					Map<String, String> m = new HashedMap();
					m.put("fund_code", JSONObject.fromObject(o).get("fund_code").toString());
					m.put("date_no", date_no); // JSONObject.fromObject(o).get("date_no").toString());
					fundsList.add(m);
				}
			}
			if ("SMO".equals(yueBaoS.change2MQQUIQUP(report_type)) && magr_p_code == null) { // 规模以上量化运行表批量上传
				realTime = "false";
				for (Object o : jsonArray) { //
					Map<String, String> m = new HashedMap();
					String magr_no = JSONObject.fromObject(o).get("magr_no").toString();
					magr_p_code = outerService.getMagrPCodeByMagrNo(magr_no);
					String magr_name = outerService.getMagrName(magr_p_code, date_no);
					m.put("magr_p_code", magr_p_code);
					m.put("magr_no", magr_no);
					m.put("magr_name", magr_name);
					m.put("date_no", date_no);
					fundsList.add(m);
				}
			} else if ("SMO".equals(yueBaoS.change2MQQUIQUP(report_type)) && magr_p_code != null) { // 规模以上实时传送
				realTime = "true";
				Map<String, String> m = new HashedMap();
				String magr_no = outerService.getMagrNOByPcode(magr_p_code);
				String magr_name = outerService.getMagrName(magr_p_code, date_no);

				m.put("magr_p_code", magr_p_code);
				m.put("magr_name", magr_name);
				m.put("magr_no", magr_no);
				m.put("date_no", date_no);
				fundsList.add(m);
			}

			String validReport_type = yueBaoS.change2MQQUIQUP(report_type);
			if (!validReport_type.equals("QUI") && !validReport_type.equals("SMO")) { // 如果不是合法report_type，报错并输出错误到resultmap
				errorParameter("", Constants.REPORTTYPEERRORCODE, resultMap, "reportType", null, error, total, success); //
				return resultMap;
			}
			// 打印excel文件
			Map<String, String> Printparams = new HashMap<String, String>();
			if (validReport_type.equals("QUI"))
				Printparams = outerService.printQUI(fundsList, resultMap, recollect); // 打印投资者信息表
			if (validReport_type.equals("SMO")) {
				outerService.callManagerProcecedure_etl_init_xp_data(outerService.getMagrNOByPcode(magr_p_code),date_no);
//				outerService.callProcedureProc_SMO_Data(date_no, outerService.getMagrNOByPcode(magr_p_code));
				Printparams = outerService.printSMO(fundsList, resultMap, realTime); // 打印规模以上运行表
			}

			String resultFromFM = "Nothing";
			// 上传zip文件至平台
			if (validReport_type.equals("QUI") || (validReport_type.equals("SMO") && "false".equals(realTime))) { // 参数无p码异步批量上传
				resultFromFM = outerService.uploadBatchExcelZip2FM(yueBaoS.change2MQQUIQUP(validReport_type),
						String.valueOf(Printparams.get("targetDirPath")),
						String.valueOf(Printparams.get("toZipAbsolutePath")), resultMap);
			}
			Map<String, String> spamKeysMap = new HashMap<String, String>();
			putSpamKeySet2(spamKeysMap);
			if (validReport_type.equals("SMO") && "true".equals(realTime)) {
				logger.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!targetDirPath is" + Printparams.get("targetDirPath"));
				authkey = NewImageUploadYWB.imageUp(Printparams.get("targetDirPath"), magr_p_code + "_"
						+ outerService.getMagrName(magr_p_code, date_no) + "-规模以上证券类管理人运行报表_" + date_no + ".xlsx",
						spamKeysMap);
			}
			if (resultMap.get("code") == null)
				resultMap.put("code", Constants.SUCCESS);
			if (resultMap.get("message") == null)
				resultMap.put("message", "success");
			if (resultMap.get("data") == null)
				resultMap.put("data", "successfuly pushed " + report_type + ": " + fund_code + ",dateNo: " + date_no
						+ ", reportType: " + report_type);
			if (resultMap.get("resultFromFM") == null)
				resultMap.put("resultFromFM", resultFromFM);
			resultMap.put("authkey", authkey);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return resultMap;
	}

	/**
	 * 打印pdf，从word转pdf
	 * 
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/word2PDF")
	public Map<String, String> printPDF(HttpServletRequest request, HttpServletResponse response) {
		String returnStr = null;
		Map<String, String> resultMap = new HashMap<String, String>();
		try {
			logger.info("START word2PDF ");
			String authkey = request.getParameter("source_authkey");
			// 参数校验
			String rawfile_name = request.getParameter("file_name");
			logger.info("rawfile_name before is " + rawfile_name);
			if (rawfile_name != null && !Constants.LOCAL.equals(SYSTEMENVIRONMENTMARK)) {
				rawfile_name = request.getParameter("file_name");
			} else {
				rawfile_name = new String(rawfile_name.getBytes("ISO-8859-1"), "utf-8");
			}
			logger.info("rawfile_name after is " + rawfile_name);

			String file_name = rawfile_name;// new String(rawfile_name.getBytes("ISO-8859-1"), "UTF-8");
			String pdf_name = file_name.replaceAll(".docx", ".pdf");
			if (errorParameter(file_name, Constants.FILENAMERRORCODE, resultMap, "file_name", null,
					new AtomicInteger(1), 1, new AtomicInteger(0))
					|| errorParameter(authkey, Constants.AUTHKEYRRORCODE, resultMap, "source_authkey", null,
							new AtomicInteger(1), 1, new AtomicInteger(0))) {
				return resultMap;
			}
			String downloadfilePath = PropertyUitls.getProperties("config.properties")
					.getProperty("WORD2PDFDOWNLOADPATH");
			String uploadDirPath = PropertyUitls.getProperties("config.properties").getProperty("WORD2PDFUPLOADPATH");
			// 文件下载
			String absoluteDocPath = newFileDowload(/* request,response, */ file_name, authkey);
			// word变pdf
			yueBaoS.word2PDF(absoluteDocPath, uploadDirPath + "temp" + pdf_name);
			if (outerService.needSign(file_name)) {
				outerService.addSign2PDF(uploadDirPath + "temp" + pdf_name, uploadDirPath + pdf_name, "D:\\sign.png");
			} else {
				logger.info("pdf路径 " + uploadDirPath + pdf_name);
				com.fh.util.FileUtil.deleteFile(uploadDirPath + pdf_name);
				File tempFile = new File(uploadDirPath + "temp" + pdf_name);
				File uploadFile = new File(uploadDirPath + pdf_name);
				uploadFile.createNewFile();
				CopyFileTool.copyFile(tempFile, uploadFile);
//				CopyFileTool.doMove(uploadDirPath +"temp"+pdf_name, uploadDirPath +pdf_name);
			}
//			/com.fh.util.FileUtil.deleteFile(uploadDirPath+"temp"+pdf_name);

			// 文件上传
			Map<String, String> spamKeysMap = new HashMap<String, String>();
			putSpamKeySet2(spamKeysMap);
			String FMResult = NewImageUploadYWB.imageUp(uploadDirPath, pdf_name, spamKeysMap);
			if ("99".equals(FMResult)) {
				throw new Exception("无法向综合管理平台上传" + file_name);
			}
			logger.info("pdf上传key，FMResult is " + FMResult);
			resultMap.put("data", FMResult);

			if (resultMap.get("code") == null)
				resultMap.put("code", "200");
			if (resultMap.get("message") == null)
				resultMap.put("message", "success");
			if (resultMap.get("data") == null) {
				resultMap.put("data", "succesfuly printing pdf, cannot transfer to next node");
			}
		} catch (Exception e) {
			resultMap.put("code", "500");
			resultMap.put("message", "fail," + e.getMessage());
			resultMap.put("data", "error printing pdf, cannot transfer to next node. " + e); //
			logger.error(e.toString(), e);
			return resultMap;
		}
		return resultMap;

	}

	/**
	 * 更新特定基金列表
	 * 
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/searchFunds")
	public void searchFunds(HttpServletRequest request, HttpServletResponse response) {
		PageData pd = new PageData(request, response);
		String fundCodes = "";
		String returnStr = "";
		try {
			fundCodes = request.getParameter("data");// 获取通过ajax提交的数据data
//	        JSONArray jsonArray=JSONArray.fromObject(data); //将其转化为json对象
//	        for (Object o: jsonArray) {						//获得基金主键
//	        	fundCodes= fundCodes+"'"+JSONObject.fromObject(o).get("fund_code").toString()+"',";
//	        }
			// if (fundCodes.length()>1) {fundCodes=fundCodes.substring(0,
			// fundCodes.length()-1);}
			List<Map<String, Object>> result = outerService.getSpecificFunds(pd, request.getParameter("sort"),
					request.getParameter("order"), request.getParameter("reportType"), fundCodes);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 投资者信息表,规模以上管理人报表，调用存储过程
	 * 
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/liquidation")
	public Map<String, String> liquidationReport(HttpServletRequest request, HttpServletResponse response ){
		Map<String, String> resultMap = new HashMap<String, String>();
		try {
			logger.info("liquidation");
			HashMap<String, String> fund = new HashMap<String, String>();
			List<Map<String, String>> fundsList = new ArrayList<Map<String, String>>();
			
			String date_no = request.getParameter("date_no");
			String fund_code = request.getParameter("fund_code");
			String wb_c_pord_code = request.getParameter("wb_c_pord_code");
			String recollect = Constants.LIQUIDATION;//
			AtomicInteger error = new AtomicInteger(0);
			AtomicInteger success = new AtomicInteger(0);
			int total = 1;
			if (errorParameter(wb_c_pord_code, Constants.FUND_CODEERRORCODE, resultMap, "wb_c_pord_code", null, new AtomicInteger(total), total, new AtomicInteger(0))
				|| errorParameter(date_no, Constants.DATE_NOERRORCODE, resultMap, "date_no", null,
							new AtomicInteger(total), total, new AtomicInteger(0)) // ||
			) {
				return resultMap;
			}
			fund_code = outerService.getFund_codeByC_Pord_Code("QUI", date_no, wb_c_pord_code);
			if (!outerService.callProcedureRept_QUI_Main(fund_code, date_no, resultMap)) {
				logger.error(" 获取投资者信息失败,fundcode "+ fund_code+ " date_no:"+date_no );
				resultMap.put("code", Constants.OTHER_ERRORCODE);
				resultMap.put("message", "获取投资者信息失败");
				resultMap.put("file_path", "");
				return resultMap;
			}
			Map<String, String> m = new HashedMap();
			m.put("fund_code", fund_code);
			m.put("date_no", date_no); // JSONObject.fromObject(o).get("date_no").toString());
			fundsList.add(m);

			// 打印excel文件
			Map<String, String> Printparams = new HashMap<String, String>();
			Printparams.put("file_path", "");
			Printparams = outerService.printLiquidation(fundsList, resultMap, recollect); // 打印投资者信息表
			String resultFromFM = "Nothing";

			if (resultMap.get("code") == null)
				resultMap.put("code", Constants.SUCCESS);
			if (resultMap.get("message") == null)
				resultMap.put("message", "success");
			if (resultMap.get("data") == null)
				resultMap.put("data", "successfuly printed "  + fund_code + ",dateNo: " + date_no);
			if (resultMap.get("resultFromFM") == null)
				resultMap.put("resultFromFM", resultFromFM);
			resultMap.put("file_path", String.valueOf(Printparams.get("file_path")) );
		} catch (Exception e) {
			logger.error(e.toString(), e);
			resultMap.put("code", Constants.OTHER_ERRORCODE);
			resultMap.put("message", "打印投资者信息失败");
			resultMap.put("data", e.getMessage());
			resultMap.put("file_path", "");
			return resultMap;
		}
		return resultMap;
	}

	
	/**
	 * 打印pdf，从word转pdf
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/testPDFWater")
	public void test() throws Exception {

		yueBaoS.word2PDF("D:\\CN_S81243_PB0001_2022-06-30.docx", "D:\\CN_S81243_PB0001_2022-06-30.pdf");

	}

	/**
	 * 检查参数是否有误
	 * 
	 * @param parameter
	 * @param errorCode
	 * @param resultMap
	 * @param varName
	 * @param wrongList
	 * @param error
	 * @param total
	 * @param success
	 * @return
	 */
	public boolean errorParameter(String parameter, String errorCode, Map<String, String> resultMap, String varName,
			JSONArray wrongList, AtomicInteger error, Integer total, AtomicInteger success) {
		if (parameter == null || "".equals(parameter) || parameter.contains("?")) {
			resultMap.put("code", errorCode);
			resultMap.put("message", "wrong " + varName);
			resultMap.put("wrongList", wrongList == null ? "未知" : wrongList.toString());
			resultMap.put("errorNum", String.valueOf(error));
			resultMap.put("totalNum", String.valueOf(total));
			resultMap.put("successNum", String.valueOf(success));

			logger.error(resultMap.get("message"));
			return true;
		}
		return false;
	}

	/**
	 * 填充fm平台上传需要的，并无实际业务意义，但是不填写会报错的信息
	 * 
	 * @param map 传给fm平台的map
	 * @return
	 */
	boolean putSpamKeySet2(Map<String, String> map) {
		if (map == null)
			return false;
		final String RONGDAFILEUPLOAD = "rongDaFileUpload";

		String operId = " ";// String.valueOf(employee.getOPER_ID());
		String ip = "18.8.32.22";
		map.put("matchedCloumn", operId);
		map.put("operatorRole", "1");
		map.put("ip", ip);
		map.put("clientType", "");
		String ipAdress = map.get("ipAdress");
		map.put("operator_role", "operator_roleTest");
		map.put("matchedCloumn", "matchedCloumnTest");
		map.put("userName", "userNameTest");
		map.put("funcId", RONGDAFILEUPLOAD);
		map.put("isOptionsQuery", "");
		map.put("func_biz", RONGDAFILEUPLOAD);
		// map.put("func_biz", func_biz);
		map.put("versionId", "V1.0");
		map.put("operatorRole", "3");
		map.put("sortColumn", "jjzhglpt2");
		return true;
	}

	/**
	 * 文件下载
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void fileDowload(HttpServletRequest request, HttpServletResponse response, String fileName, String auth_key)
			throws Exception {
		DbserviceController dbservice = new DbserviceController();

//		String fileName = request.getParameter("fileName");
//		String auth_key = request.getParameter("auth_key");//

		Map<String, String> map = new HashMap<String, String>();
		map.put("auth_key", auth_key);

		// 查询数据库将获取的json格式的文件路径转换成String类型的文件全路径

		String pathOfFile = dbservice.downloadParamMaps(map, request);
		JsonArrayUtil jsontostring = new JsonArrayUtil();
		String filePath = jsontostring.jsonArray(pathOfFile);

		// 校正文件路径格式，替换乱码文件名
		File filepath = new File(filePath);
		String pa = filepath.getPath().replace("\\\\", "/");
		String path = pa.substring(0, pa.lastIndexOf("\\"));
		File newfile = new File(path + "\\" + fileName);
		filepath.renameTo(newfile);
		String filePathAll = newfile.getPath().replaceAll("\\\\", "/");

		// 获取服务器文件路径生成文件流
		File file = new File(filePathAll);
		String filename = file.getName();
		String fileName1 = java.net.URLDecoder.decode(filename, "UTF-8");
		if (fileName1.length() > 150) {

			String guessCharset = request.getCharacterEncoding();
			// 根据request的locale 得出可能的编码，中文操作系统通常是gb2312
			fileName1 = new String(filename.getBytes(guessCharset), "ISO8859-1");
		}

		FileInputStream fis = new FileInputStream(file);
//		response.addHeader("Content-Disposition", "attachment; filename=" + filename);
		response.setHeader("Content-Type", "application/octet-stream");
		response.setContentType("multipart/form-data");

		String agent = request.getHeader("USER-AGENT");
		// 兼容火狐浏览器下载
		if (null != agent && -1 != agent.indexOf("Firefox")) {
			response.addHeader("Content-Disposition",
					"attachment; filename=" + new String(filename.getBytes("UTF-8"), "ISO-8859-1"));
		} else {
			response.addHeader("Content-Disposition",
					"attachment; filename=" + java.net.URLEncoder.encode(filename, "UTF-8"));
		}
		ServletOutputStream out = response.getOutputStream();
		response.setBufferSize(32768);
		int bufSize = response.getBufferSize();
		byte[] buffer = new byte[bufSize];
		BufferedInputStream bis = new BufferedInputStream(fis, bufSize);

		int bytes;
		while ((bytes = bis.read(buffer, 0, bufSize)) >= 0)
			out.write(buffer, 0, bytes);
		bis.close();
		fis.close();
		out.flush();
		out.close();
		try {
			Thread.sleep(30000);
			file.delete();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 新
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/downloadFile")
	public String newFileDowload(/* HttpServletRequest request, HttpServletResponse response, */ String fileName,
			String auth_key) throws Exception {

//		FileInputStream fis = null;
//		ServletOutputStream out = null;
//		BufferedInputStream bis = null;
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
//					HttpServletResponse response = hcu.

					// 获取服务器文件路径生成文件流
					File file = new File(downloadFileAbsolutePath);
					String filename = file.getName();

					/*
					 * fis = new FileInputStream(file);
					 * response.setHeader("Content-Type","application/octet-stream");
					 * response.setContentType("multipart/form-data");
					 * 
					 * String agent =request.getHeader("USER-AGENT"); //兼容火狐浏览器下载 if (null != agent
					 * && -1 != agent.indexOf("Firefox")) {
					 * filename=filename.replaceAll(" ","");//空格变加号 filename = new String(
					 * filename.getBytes("UTF-8"), "ISO-8859-1" );
					 * response.addHeader("Content-Disposition", "attachment; filename=" +filename);
					 * }else{ filename = java.net.URLEncoder.encode(filename,"UTF-8");
					 * filename=filename.replaceAll("\\+","%20");
					 * 
					 * response.addHeader("Content-Disposition", "attachment; filename="+filename);
					 * } out = response.getOutputStream(); int bufSize = response.getBufferSize();
					 * byte[] buffer = new byte[bufSize]; bis = new BufferedInputStream(fis,
					 * bufSize); int bytes; while ((bytes = bis.read(buffer, 0, bufSize)) >= 0){
					 * out.write(buffer, 0, bytes); }
					 */
				} catch (Exception e) {
//						logger.error(request, e.toString(),e);
				} finally {
					/*
					 * if(bis!=null){ try { bis.close(); } catch (IOException e) { //
					 * logger.error(request, e.toString(),e); } } if(fis!=null){ try { fis.close();
					 * } catch (IOException e) { // logger.error(request, e.toString(),e); } }
					 * if(out!=null){ try { out.flush(); out.close(); } catch (IOException e) { //
					 * logger.error(request, e.toString(),e); } }
					 */
				}

			}
		}
		return downloadFileAbsolutePath;

	}

	@ResponseBody
	@RequestMapping(value = "/xinxipilu/testDownloadFile")
	public String testFileDownload(HttpServletRequest request, HttpServletResponse response, String fileName,
			String auth_key) throws Exception {

		return null;

//		}

	}

}