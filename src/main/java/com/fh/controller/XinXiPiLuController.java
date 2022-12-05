/**
 * 
 */
package com.fh.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.Month;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.bcel.classfile.ConstantNameAndType;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.service.OuterSMOService;
import com.fh.service.OuterXXPLService;
import com.fh.service.UtilityService;
import com.fh.service.XinXiPiLuJiBaoService;
import com.fh.service.XinXiPiLuJiDuGengXinService;
import com.fh.service.XinXiPiLuQuantService;
import com.fh.service.XinXiPiLuService;
import com.fh.service.XinXiPiLuYueBaoServiceNew;
import com.fh.service.XinxiPiLuNianBaoService;
import com.fh.util.Constants;
import com.fh.util.ExcelReaderFor2007;
import com.fh.util.LoginUtil;
import com.fh.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author 230355
 * 
 * The router of 1-信息披露， 
 * @since 202204
 */
@Controller
public class XinXiPiLuController {
	protected Logger logger = Logger.getLogger(this.getClass());
    @Resource(name="XinXiPiLuService")
    XinXiPiLuService xinXiPiLu;
    
    @Resource(name="XinXiPiLuQuantService")
    XinXiPiLuQuantService xinXiPiLuQuant;
    
    @Resource(name="xinxiPiLuSMOService")
    OuterSMOService SMOService;
    
    @Resource(name="XinXiPiLuJiBaoService")
    XinXiPiLuJiBaoService xinXiPiLuJiBao;
    
    @Resource(name="XinXiPiLuJiDuGengXinService")
    XinXiPiLuJiDuGengXinService xinXiPiLuJiDuGengXin;

    @Resource(name="xinxiPiLuNianBaoService")
    XinxiPiLuNianBaoService xinxiPiLuNianBaoService;
    
    @Resource(name="XinXiPiLuYueBaoServiceNew")
    XinXiPiLuYueBaoServiceNew yueBaoS;
    
    @Resource(name="OuterXXPLService")
    OuterXXPLService outerService;
    
    @Resource(name="utilityService")
    UtilityService utilityService;

    
	private final String MONTH = "month";
	private final String QUATER = "quater";
	private final String QUATERUPDATE = "quaterlyUpdate";

	 
	/**
	 * 查询某一个月的月报
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/printNianBao")
	public void printNianBao(HttpServletRequest request,
			HttpServletResponse response) { 		
    	String returnStr = null;
		try {
			logger.info("create json files " ); 
			List<Map<String,String>> funds = new ArrayList<Map<String,String>>();  
			HashMap<String, String> fund =  new HashMap<String, String>();   
			String date_no = request.getParameter("date_no"); 
			System.out.println("date_no=" + date_no );
			fund.put("date_no", date_no);   
			String fund_code = request.getParameter("fund_code"); 
			System.out.println("fund_code=" + fund_code );
			fund.put("fund_code",fund_code);  
			funds.add(fund);
			String msg = xinxiPiLuNianBaoService.createJson(funds);
//			result = xinXiPiLu.StatusBox(pd);
			PrintWriter out = response.getWriter();
			// out.print(returnStr); 
			out.print(msg); 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
	
	/**
	 * 查询某一个月的月报
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/searchYueBao")
	public void searchYueBao(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			String data_chk_rslt_code = request.getParameter("data_chk_rslt_code");
			String ivsp_chk_rslt_code =pd.getString("ivsp_chk_rslt_code");
			if (ivsp_chk_rslt_code!=null && !Constants.LOCAL.equals(yueBaoS.SYSTEMENVIRONMENTMARK) ) { ivsp_chk_rslt_code=new String( pd.getString("ivsp_chk_rslt_code").getBytes("ISO-8859-1"),"utf-8");}
			if (data_chk_rslt_code!=null && !Constants.LOCAL.equals(yueBaoS.SYSTEMENVIRONMENTMARK) ) { data_chk_rslt_code=new String( pd.getString("data_chk_rslt_code").getBytes("ISO-8859-1"),"utf-8");}
			data_chk_rslt_code= Constants.getTranslatedCheckStatus(data_chk_rslt_code);
			ivsp_chk_rslt_code= Constants.getTranslatedCheckStatus(ivsp_chk_rslt_code);	
			logger.info("data_chk_rslt_code  "+data_chk_rslt_code);
			logger.info("ivsp_chk_rslt_code is "+ivsp_chk_rslt_code);
			List<Map<String, Object>> result = yueBaoS.search1MonthlyData(pd,data_chk_rslt_code,ivsp_chk_rslt_code,request.getParameter("serv_scop"),request.getParameter("isPrinted"), request.getParameter("sort"), request.getParameter("order"),request.getParameter("gzry"),request.getParameter("reportType"));
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
	
	@RequestMapping(value = "/xinxipilu/searchJiBao")
	public void searchJiBao(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			List<Map<String, Object>> result = xinXiPiLuJiBao.search1QuaterlyData(pd,request.getParameter("thelist"),request.getParameter("serv_scop"),request.getParameter("waibaoshuju"),request.getParameter("sort"), request.getParameter("order"));
//			result = xinXiPiLu.StatusBox(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}	
     
	@RequestMapping(value = "/xinxipilu/searchJiDuGengXin")
	public void searchJiDuGengXin(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			List<Map<String, Object>> result = xinXiPiLuJiDuGengXin.search1QuaterlyUpdateData(pd,request.getParameter("data_chk_rslt_code"),request.getParameter("serv_scop"),request.getParameter("isPrinted"), request.getParameter("sort"), request.getParameter("order"),request.getParameter("gzry"),request.getParameter("reportType"));
//			result = xinXiPiLu.StatusBox(pd);
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
     * @param request
     * @param response
     */
   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/getDateOptions")	
    public void getDateOptions(HttpServletRequest request,    
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
		try {
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			result = xinXiPiLu.getAllDateOptions(pd);
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
     * @param request
     * @param response
     */
   	@RequestMapping(value = "/xinxipilujibao/getDateOptions")   	
    public void getQuaterDateOptions(HttpServletRequest request,    
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
		try {
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			result = xinXiPiLu.getAllDateOptions(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
    }
   	
   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/getFundNameOptions")
    /**
     * @param request
     * @param response
     */
    public void getFundNameOptions(HttpServletRequest request,    
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
		try {
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			result = xinXiPiLu.getAllFundNames(pd);
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
     * 生成3种文件文档
     * @param request
     * @param response
     */
    @Test
   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/generate3Files",produces ="application/json;charsetset=UTF-8")
	public void generate3Files(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
    	Map<String, String> result = new HashedMap();
        String isRecollect =pd.getString("isRecollect");
    	//if (null!= isRecollect && "1".equals(isRecollect )) recollection(request,response);
		try {
			PrintWriter out = response.getWriter();
	        String reportType =pd.getString("reportType");
	        String data =request.getParameter("data");//获取通过ajax提交的数据data
	        String recollect= request.getParameter("recollect");
	        logger.info(request.getParameterNames().toString());
	        if (null==data) result.put("fail","No 'data' of funds found");
	        else {
//	        	System.out.println("data is "+data);
		        JSONArray jsonArray=JSONArray.fromObject(data); //将其转化为json对象
		        List<Map<String,String>> fundsList = new ArrayList<Map<String,String>>();
		        for (Object o: jsonArray) {						//获得基金主键
		        	Map<String,String> m = new HashedMap();
		        	m.put("fund_code",JSONObject.fromObject(o).get("fund_code").toString()); 
		        	m.put("date_no",JSONObject.fromObject(o).get("date_no").toString());
		        	m.put("serv_scop",JSONObject.fromObject(o).get("serv_scop").toString());
		        	fundsList.add(m);
		        }
				if(MONTH.equals(reportType))result = xinXiPiLu.prepareAndPrint3Files4FundsMonth(fundsList);
				if(QUATER.equals(reportType))result = xinXiPiLuJiBao.prepareAndPrint3Files4FundsQuater(fundsList);
				if(QUATERUPDATE.equals(reportType)) {
					 xinXiPiLuJiDuGengXin.prepareAndPrint3Files4FundsQuaterUpdate(fundsList);
//						Map<String, String> QUIparams=outerService.printQUI(fundsList, result, recollect);
//						//上传zip文件至平台
//						String resultFromFM = outerService.uploadBatchExcelZip2FM(String.valueOf(QUIparams.get("targetDirPath")) ,String.valueOf(QUIparams.get("toZipAbsolutePath")), result);
				}

					//result.put("fail","reportType is not found, please contact developers for debuging");
				 
				if (result.get("fail")==null) result.put("fail","success");
				out.print(result);
				out.close();
	        }
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
    
    /**
     * 重新采集
     * @param request
     * @param response
     * @return
     */
   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/recollection",produces ="application/json;charsetset=UTF-8")
	public String recollection(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
    	Map<String, String> result = new HashedMap();
		try {
	        String data =request.getParameter("data");//获取通过ajax提交的数据data
	        String date_no="";
	        String reportType =request.getParameter("reportType");
	        reportType=yueBaoS.change2MQQUIQUP(reportType);
	        if (null==data) result.put("fail","No 'data' of funds found");
	        else {
//	        	System.out.println("data is "+data);
		        JSONArray jsonArray=JSONArray.fromObject(data); //将其转化为json对象
		        List<String> fundMgrList = new ArrayList<String>();
		        String fundsCodes=""; String fundName="";
		        for (Object o: jsonArray) {						//获得基金主键
		        	fundName=JSONObject.fromObject(o).get("fund_code").toString();
		        	fundMgrList.add(fundName);
		        	date_no=JSONObject.fromObject(o).get("date_no").toString();
		        	fundsCodes=fundsCodes + fundName+",";
		        }
				yueBaoS.insertHistory(reportType, date_no, jsonArray.size()+"个产品", 
						"", "重新采集", 
						LoginUtil.getIPAdrress(request), "", "", fundsCodes, "", result);
		        if (!xinXiPiLu.recollectFunds(fundMgrList, date_no,  reportType)) return "failed to recollect";



	        }
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return returnStr;
   	}
    /**
     * 生成1种excel 量化基金文档
     * @param request
     * @param response
     */
    @ResponseBody
   	@RequestMapping(value = "/xinxipiluQuant/generateQuantExcel",produces ="application/json;charsetset=UTF-8")
	public void generateQuantExcel(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
    	Map<String, String> result = new HashedMap();
        String isRecollect =pd.getString("isRecollect");
    	if (null!= isRecollect && "1".equals(isRecollect )) recollection(request,response);
		try {
			PrintWriter out = response.getWriter();
	        String data =request.getParameter("data");//获取通过ajax提交的数据data
	        String date_no="";
	        logger.info(request.getParameterNames().toString());
	        if (null==data) result.put("fail","No 'data' of funds found");
	        else {
//	        	System.out.println("data is "+data);
		        JSONArray jsonArray=JSONArray.fromObject(data); //将其转化为json对象
		        List<String> fundMgrList = new ArrayList<String>();
		        for (Object o: jsonArray) {						//获得基金主键
		        	fundMgrList.add(JSONObject.fromObject(o).get("magr_no").toString());
		        	date_no=JSONObject.fromObject(o).get("date_no").toString();
		        }
		        result = xinXiPiLuQuant.prepareAndPrintQuantExcelMonth(fundMgrList, date_no);

	        }
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}    
    
    /**
     * 
     * @param request
     * @param response
     */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/searchMingXi")
	public void searchMingXi(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
    	List<Map<String, Object>> result =new ArrayList<Map<String, Object>>();
    	String reportType = pd.getString("reportType");
    	
		try {
			if (""!=yueBaoS.change2MQQUIQUP(reportType)) {
				result=yueBaoS.search1PeriodDisctChkRsltData(pd);
			}
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
     * 
     * @param request
     * @param response
     */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/search1FundDataChkRslt")
	public void search1FundDataChkRslt(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
    	List<Map<String, Object>> result =new ArrayList<Map<String, Object>>();
		try {
			String reportType =yueBaoS.change2MQQUIQUP(pd.getString("reportType"));
			if (null==reportType||"".equals(reportType)) return;
//			if (pd.getString("dateType").equals(MONTH)) {
				result=yueBaoS.search1PeriodDisctChkRsltData(pd);
//			}
//			if (pd.getString("dateType").equals(QUATER)) {
//				result=yueBaoS.search1QuaterlyDisctChkRsltData(pd);
//			}//			result = xinXiPiLu.StatusBox(pd);
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
     * 
     * @param request
     * @param response
     */
	@ResponseBody
	@RequestMapping(value = "/xinxipiluQuant/getAllFundDate")
	public void getAllQuantDate(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			List<Map<String, String>> result = xinXiPiLuQuant.getAllQuantDateOptions(pd);
//			result = xinXiPiLu.StatusBox(pd);
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
     * 
     * @param request
     * @param response
     */
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/getGuzhiRenYuanOptions")
	public void getGuzhirenyuanOptions(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
		try {
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			result = yueBaoS.getGuZhiRenYuanOptions(pd);
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
     * 
     * @param request
     * @param response
     */
	@ResponseBody
	@RequestMapping(value = "/xinxipiluQuant/getAllQuantMangerOptions")
	public void getAllQuantManagersOptions(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			List<Map<String, String>> result = xinXiPiLuQuant.getAllQuanManagersOptions(pd);
//			result = xinXiPiLu.StatusBox(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/xinxipiluQuant/searchQuantYueBao")
	public void searchQuantYueBao(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			String managerName = request.getParameter("managerName");
			if (managerName!=null && !Constants.LOCAL.equals(yueBaoS.SYSTEMENVIRONMENTMARK) ) { managerName=new String( pd.getString("managerName").getBytes("ISO-8859-1"),"utf-8");}
			String isPrinted = request.getParameter("isPrinted");
			logger.info(isPrinted);
			logger.info("managerName is "+managerName);
			List<Map<String, Object>> result = xinXiPiLuQuant.search1QuantMonthlyData(pd,request.getParameter("sort"), request.getParameter("order"),request.getParameter("reportType"),managerName,isPrinted);
//			result = xinXiPiLu.StatusBox(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}	
	
	@ResponseBody
	@RequestMapping(value = "/xinxipiluQuant/searchSmo")
	public void searchSMO(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
			String isPrinted = request.getParameter("isPrinted");
			List<Map<String, Object>> result = xinXiPiLuQuant.search1SMOMonthlyData(pd,request.getParameter("sort"), request.getParameter("order"),isPrinted);
//			result = xinXiPiLu.StatusBox(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}		
	
	@ResponseBody
	@RequestMapping(value = "/xinxipilu/modifyData")
	public void modifyData(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = null;
		try {
	        String data =request.getParameter("data");//获取通过ajax提交的数据data
	        String modifyType = request.getParameter("modifyType");
	        JSONArray jsonArray=JSONArray.fromObject(data); //将其转化为json对象
	        List<Map<String, String>> modifyElementList = new ArrayList<Map<String, String>>();
	        logger.info("!!!!!!!!!!!!!!!!!!!!!!!!IP is "+LoginUtil.getIPAdrress(request));
	        logger.info("data is "+jsonArray);
	        for (Object o: jsonArray) {						//获得基金主键
	        	Map<String,String> element = new HashedMap();
	        	element.put("disc_type_code", JSONObject.fromObject(o).get("disc_type_code").toString());
	        	element.put("date_no", JSONObject.fromObject(o).get("date_no").toString());
	        	element.put("fund_code", JSONObject.fromObject(o).get("fund_code").toString());
	        	element.put("indx_name", JSONObject.fromObject(o).get("indx_name").toString());
	        	String upd_aft_data =JSONObject.fromObject(o).get("upd_aft_data").toString();
	        	if (null!=upd_aft_data && upd_aft_data.equals("null"))upd_aft_data="";
	        	element.put("upd_aft_data", JSONObject.fromObject(o).get("upd_aft_data").toString());
	        	element.put("indx_src_tab", JSONObject.fromObject(o).get("indx_src_tab").toString());
	        	element.put("indx_src_fld", JSONObject.fromObject(o).get("indx_src_fld").toString());
	        	element.put("indx_src_dim", JSONObject.fromObject(o).get("indx_src_dim").toString());
	        	element.put("indx_dim", JSONObject.fromObject(o).get("indx_dim").toString());
	        	
	        	element.put("upder_ip", LoginUtil.getIPAdrress(request));
	        	String magr_no =null;
	        	if (JSONObject.fromObject(o).get("magr_no")!=null) element.put("magr_no", JSONObject.fromObject(o).get("magr_no").toString());
	        	
	        	modifyElementList.add(element);
	        }
			Map<String, String> result = new HashedMap();
			yueBaoS.modifyData(modifyElementList,result,modifyType);
			PrintWriter out = response.getWriter();
			out.print(result);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}		
	
    /**
     * 
     * @param request
     * @param response
     */
    @Test
   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/test")
	public void testLink(HttpServletRequest request,
			HttpServletResponse response) {
    	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!TESTING!!!!!!/xinxipilu/test!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
		try {
			//xinXiPiLuJiBao.search1QuaterlyData(pd, returnStr, returnStr);
			//xinXiPiLuJiBao.testFunction();

			//xinXiPiLu.search1MonthlyData(pd);
			List<Map<String, Object>> result = null;
//			result = xinXiPiLu.StatusBox(pd);
//			if (result != null) {
//				returnStr = JSONArray.fromObject(result).toString();
//			}
			PrintWriter out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
    
    @ResponseBody
	@RequestMapping(value = "/xinxipilu/getComboBoxSource")
	public void getComboBoxSource(HttpServletRequest request,HttpServletResponse response) {
		PageData pd = new PageData(request, response);
		String returnStr = "";
		PrintWriter out = null;
		List<Map<String, Object>> result = null;
		try {
			result = xinXiPiLu.getComboBoxSource(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e);
		}
	}
    @ResponseBody
	@RequestMapping(value = "/xinxipilu/getCommonSQLSearch")
	public void getCommonSQLSearch(HttpServletRequest request,HttpServletResponse response) {
		PageData pd = new PageData(request, response);
		String returnStr = "";
		PrintWriter out = null;
		List<Map<String, Object>> result = null;
		try {
			result = xinXiPiLu.getCommonSQLSearch(pd);
			if (result != null) {
				returnStr = JSONArray.fromObject(result).toString();
			}
			out = response.getWriter();
			out.print(returnStr);
		} catch (Exception e) {
			logger.error(e);
		}
	}
    @ResponseBody
  	@RequestMapping(value = "/xinxipilu/updateBBinfo")
  	public void updateBBinfo(HttpServletRequest request,HttpServletResponse response) {
  		PageData pd = new PageData(request, response);
  		String returnStr = "";
  		PrintWriter out = null;
  		List<Map<String, Object>> result = null;
  		try {
  			result = xinXiPiLu.updateBBinfo(pd);
  			if (result != null) {
  				returnStr = JSONArray.fromObject(result).toString();
  			}
  			out = response.getWriter();
  			out.print(returnStr);
  		} catch (Exception e) {
  			logger.error(e);
  		}
  	}  
    
    @ResponseBody
	  	@RequestMapping(value = "/xinxipilu/searchMailLog")
	  	public void searchMailLog(HttpServletRequest request,HttpServletResponse response) {
	  		PageData pd = new PageData(request, response);
	  		String returnStr = "";
	  		PrintWriter out = null;
	  		List<Map<String, Object>> result = null;
	  		try {
	  			result = xinXiPiLu.searchMailLog(pd);
	  			if (result != null) {
	  				returnStr = JSONArray.fromObject(result).toString();
	  			}
	  			out = response.getWriter();
	  			out.print(returnStr);
	  		} catch (Exception e) {
	  			logger.error(e);
	  		}
	  	}
  		@ResponseBody
  	  	@RequestMapping(value = "/xinxipilu/updateMailData")
  	  	public void updateMailData(HttpServletRequest request,HttpServletResponse response) {
  	  		PageData pd = new PageData(request, response);
  	  		String returnStr = "";
  	  		PrintWriter out = null;
  	  		List<Map<String, Object>> result = null;
  	  		try {
  	  			result = xinXiPiLu.updateMailData(pd);
  	  			if (result != null) {
  	  				returnStr = JSONArray.fromObject(result).toString();
  	  			}
  	  			out = response.getWriter();
  	  			out.print(returnStr);
  	  		} catch (Exception e) {
  	  			logger.error(e);
  	  		}
  	  	}
  	@ResponseBody
  	@RequestMapping(value = "/xinxipilu/updateCheckBBinfo")
  	public void updateCheckBBinfo(HttpServletRequest request,HttpServletResponse response) {
  		PageData pd = new PageData(request, response);
  		String returnStr = "";
  		PrintWriter out = null;
  		List<Map<String, Object>> result = null;
  		try {
  			result = xinXiPiLu.updateCheckBBinfo(pd);
  			if (result != null) {
  				returnStr = JSONArray.fromObject(result).toString();
  			}
  			out = response.getWriter();
  			out.print(returnStr);
  		} catch (Exception e) {
  			logger.error(e);
  		}
  	}
    @ResponseBody
   	@RequestMapping(value = "/xinxipilu/updateCheckinfo")
   	public void updateCheckinfo(HttpServletRequest request,HttpServletResponse response) {
   		PageData pd = new PageData(request, response);
   		String returnStr = "";
   		PrintWriter out = null;
   		List<Map<String, Object>> result = null;
   		try {
   			result = xinXiPiLu.updateCheckinfo(pd);
   			if (result != null) {
   				returnStr = JSONArray.fromObject(result).toString();
   			}
   			out = response.getWriter();
   			out.print(returnStr);
   		} catch (Exception e) {
   			logger.error(e);
   		}
   	}
    
	@ResponseBody
	@RequestMapping(value = "/utility/exportDiscSitu")
	public void exportDiscSituExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
        try {
        	
//        	ExcelReaderFor2007 reader=new ExcelReaderFor2007("L:/系统专用/信息披露/模板/rept_disc_situ.xlsx");
        	
        	PageData pd = new PageData(request, response);
//			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			String data_chk_rslt_code = request.getParameter("data_chk_rslt_code");
			String ivsp_chk_rslt_code =pd.getString("ivsp_chk_rslt_code");
        	if (ivsp_chk_rslt_code!=null && !Constants.LOCAL.equals(yueBaoS.SYSTEMENVIRONMENTMARK) ) { ivsp_chk_rslt_code=new String( pd.getString("ivsp_chk_rslt_code").getBytes("ISO-8859-1"),"utf-8");}
			if (data_chk_rslt_code!=null && !Constants.LOCAL.equals(yueBaoS.SYSTEMENVIRONMENTMARK) ) { data_chk_rslt_code=new String( pd.getString("data_chk_rslt_code").getBytes("ISO-8859-1"),"utf-8");}
			data_chk_rslt_code= Constants.getTranslatedCheckStatus(data_chk_rslt_code);
			ivsp_chk_rslt_code= Constants.getTranslatedCheckStatus(ivsp_chk_rslt_code);	

			List<Map<String, Object>> result = yueBaoS.search1MonthlyData(pd,data_chk_rslt_code,ivsp_chk_rslt_code,request.getParameter("serv_scop"),request.getParameter("isPrinted"), request.getParameter("sort"), request.getParameter("order"),request.getParameter("gzry"),request.getParameter("reportType"));
//			result = yueb.searchYueBao(pd,request.getParameter("thelist"),request.getParameter("serv_scop"),request.getParameter("waibaoshuju"),request.getParameter("sort"), request.getParameter("order"));
			String excelPath =  utilityService.printReptDiscSitu(result);

			String fileName=new String((yueBaoS.change2ChineseMQQUIQUP(request.getParameter("reportType"))+"_excel.xlsx").getBytes("gb2312"), "iso8859-1")+ "";
		    // 读到流中
          
	  		 response.setContentType("application/vnd.ms-excel;charset=UTF-8");
             response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
             response.setCharacterEncoding("utf-8");
             ServletOutputStream outputStream = response.getOutputStream();
             InputStream inStream = new FileInputStream(excelPath);// 文件的存放路径
             // 循环取出流中的数据
             byte[] b = new byte[100];
             int len;
             try {
                 while ((len = inStream.read(b)) > 0)
                     response.getOutputStream().write(b, 0, len);
                 inStream.close();
             } catch (IOException e) {
                 e.printStackTrace();
             }
            outputStream.flush();
            outputStream.close();
            logger.info("flush ovber"+excelPath);

		} catch (IOException e) {
			logger.error(e);
			e.printStackTrace();
		}
	}
}
