package com.fh.controller.system.util;

import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;

import com.fh.util.Const;
import com.fh.util.Logger;
import com.fh.util.entity.system.Employee;
import com.sinosoft.scs.core.Param;


public class DbserviceController {
	protected Logger logger = Logger.getLogger(this.getClass());
	/**
	 * @param request ，必须包含funcId
	 * @return
	 */
	HttpClientCall hcc = new HttpClientCall();
	public String dearRequest(HttpServletRequest request){
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		//日志唯一标识
		if(request!=null){
        	map.put("logToken", request.getAttribute("logToken")==null?"":(String)request.getAttribute("logToken")); 
        }
		/* 遍历所有参数 */
		Enumeration<String> paraNames=request.getParameterNames();
		StringBuffer sb = new StringBuffer("请求参数：【");
		for(Enumeration<String> e=paraNames;e.hasMoreElements();){
		       String paramName=e.nextElement().toString();
		       String paramValue=request.getParameter(paramName);
		       sb.append(paramName+":"+paramValue+",");
		       if(!map.containsKey(paramName)){
					map.put(paramName, paramValue);
				}
		       
		}
		if(request.getSession().getAttribute(Const.SESSION_USER_FM)!=null){
	 	   map.put("fmid",request.getSession().getAttribute(Const.SESSION_USER_FM).toString());
	    }
		sb.append("】");
	    //logger.info(request,sb.toString());
		return dearParamMaps(map,request);
	}
	/**
	 * 返回结果
	 * @param map 必须包含funcId . 其他业务参数可选
	 * @return
	 */
	public String dearParamMaps(Map<String, String> map ,HttpServletRequest request){
		Employee employee = (Employee)request.getSession().getAttribute(Const.SESSION_USER);
		String ipAdress = getIpAddress(request);
		String func_id = map.get("funcId");
		String user_name ="";
		String operator_id ="";
		if("checkUserIsFF".equals(func_id)||"saveUserIsFF".equals(func_id)||
				"updateUserIsFFKey".equals(func_id)||"saveUserIsFF".equals(func_id)||"findUserIsFFKey".equals(func_id)||
				"saveYZMToTbVerifi".equals(func_id)||"insertOnlineAssetKey".equals(func_id)||"knowledgebaseQueryByFm".equals(func_id)){//验证发短信非法
			user_name="";
		}else if("etl_tableinfo".equals(func_id)){
			user_name="";
		}else if("listSysUser_Score".equals(func_id)||"Save_SysUserScore".equals(func_id)||"listSysDictionaries".equals(func_id)||"list_isexp_fm".equals(func_id)){
			user_name="";
		}else{
			if(employee==null){
				 if("xxpl_info_queryFm".equals(func_id) && StringUtils.isNotEmpty(map.get("name")) ){
					user_name = map.get("name");
					operator_id = "1" ;
				 }else{
					 return "";
				 }
			}else{
			 user_name = employee.getEMP_NAME();
			 operator_id =String.valueOf(employee.getOPER_ID());
			}
		}
	 
		String clientType = "pc";
		String operator_role = "1";
		String version_id = "V1.0";
		Param param = new Param(clientType,ipAdress,operator_role,operator_id, user_name, func_id, version_id , map);
		String result = hcc.call(param,request,func_id);
		return result;
	}
	
	/**
	 * 返回结果
	 * @param map 必须包含funcId . 其他业务参数可选
	 * @return
	 */
	public String downloadParamMaps(Map<String, String> map ,HttpServletRequest request){
		String clientType = "pc";
		String operator_role = "1";
		String ipAdress = request.getParameter("ip");
		if (ipAdress==null)ipAdress="50.2.62.213";
		String operator_id ="opr-0001";
		String userName = request.getParameter("userName");
		if (userName==null)userName="信息披露";
		String func_id = "filedownload";
		String version_id = "V1.0";
		Param param = new Param(clientType,ipAdress,operator_role,operator_id, userName, func_id, version_id , map);
		String result = hcc.call(param,request,func_id);
		return result;
	}	
	

	public   String getIpAddress(HttpServletRequest request)  {
		// 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址

		String ip = request.getHeader("X-Forwarded-For");
		 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_CLIENT_IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
		} else if (ip.length() > 15) {
			String[] ips = ip.split(",");
			for (int index = 0; index < ips.length; index++) {
				String strIp = (String) ips[index];
				if (!("unknown".equalsIgnoreCase(strIp))) {
					ip = strIp;
					break;
				}
			}
		}
		//logger.info("客户端访问ip地址为：【"+ip+"】");
		return ip;
	}
	
	
	

	 
//	public String downloadParamMaps2(Map<String, String> map ,HttpServletRequest request){
//		HttpClientCall hcc = new HttpClientCall();
//		String clientType = "pc";
//		String operator_role = "1";
//		String ipAdress = "IP";
//		String operator_id ="opr-0001";
//		String userName = "admin";
//		String func_id = "filedownload";
//		String version_id = "V1.0";
//		//日志唯一标识
//		if(request!=null && map!=null){
//        	map.put("logToken", request.getAttribute("logToken")==null?"":(String)request.getAttribute("logToken")); 
//        }
//		Param param = new Param(clientType,ipAdress,operator_role,operator_id, userName, func_id, version_id , map);
//		String result = hcc.call(param,request);
//		return result;
//	}
}
	