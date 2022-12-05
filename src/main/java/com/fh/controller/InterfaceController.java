package com.fh.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.service.XinXiPiLuJiBaoService;
import com.fh.service.XinXiPiLuJiDuGengXinService;
import com.fh.service.XinXiPiLuQuantService;
import com.fh.service.XinXiPiLuService;
import com.fh.service.XinXiPiLuYueBaoServiceNew;
import com.fh.service.XinxiPiLuNianBaoService;
import com.fh.util.PageData;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

import ch.qos.logback.classic.spi.LoggerContextAwareBase;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class InterfaceController {
	protected Logger logger = Logger.getLogger(this.getClass());
    @Resource(name="XinXiPiLuService")
    XinXiPiLuService xinXiPiLu;
    
    @Resource(name="XinXiPiLuQuantService")
    XinXiPiLuQuantService xinXiPiLuQuant;
    
    @Resource(name="XinXiPiLuJiBaoService")
    XinXiPiLuJiBaoService xinXiPiLuJiBao;
    
    @Resource(name="XinXiPiLuJiDuGengXinService")
    XinXiPiLuJiDuGengXinService xinXiPiLuJiDuGengXin;

    @Resource(name="xinxiPiLuNianBaoService")
    XinxiPiLuNianBaoService xinxiPiLuNianBaoService;
    
    @Resource(name="XinXiPiLuYueBaoServiceNew")
    XinXiPiLuYueBaoServiceNew yueBaoS;

	public InterfaceController() {
		// TODO Auto-generated constructor stub
	}
	

   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/recollection",produces ="application/json;charsetset=UTF-8")
	public String recollection(HttpServletRequest request,
			HttpServletResponse response) {
    	PageData pd = new PageData(request,response);		
    	String returnStr = "403";
    	Map<String, String> result = new HashedMap();
		try {
			logger.info("!!!!!RECOLLECT!!!!");
			PrintWriter out = response.getWriter();
	        String data =request.getParameter("data");//获取通过ajax提交的数据data
	        String date_no="";
	        String reportType =request.getParameter("reportType");
	        logger.info(request.getParameterNames().toString());
	        if (null==data) result.put("fail","No 'data' of funds found");
	        else {
//	        	System.out.println("data is "+data);
		        JSONArray jsonArray=JSONArray.fromObject(data); //将其转化为json对象
		        List<String> fundMgrList = new ArrayList<String>();
		        for (Object o: jsonArray) {						//获得基金主键
		        	fundMgrList.add(JSONObject.fromObject(o).get("fund_code").toString());
		        	date_no=JSONObject.fromObject(o).get("date_no").toString();
		        }
		        if (xinXiPiLu.recollectFunds(fundMgrList, date_no,  reportType)) return "failed to recollect";
	        }
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return returnStr;
   	}
   	
   	@ResponseBody
   	@RequestMapping(value = "/xinxipilu/push2GBICCDB",produces ="application/json;charsetset=UTF-8")
   	public String push2GBICCDB(HttpServletRequest request,
			HttpServletResponse response) {
   		logger.info("push2GBICCDB is in");
    	PageData pd = new PageData(request,response);		

   		return null;
   	}

}
