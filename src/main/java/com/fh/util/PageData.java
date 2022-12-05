package com.fh.util;

import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.fh.util.DaoUtil.LogType;

public class PageData extends HashMap implements Map{
	protected Logger logger = Logger.getLogger(this.getClass());
	
	private static final long serialVersionUID = 1L;
	
	Map map = null;
	HttpServletRequest request;
	
	public PageData(HttpServletRequest request) {
		logger.info("Action 请求URL：【" +request.getServletPath() + "】");
		this.request = request;
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
		    logger.error(e);
		}
		Map properties = request.getParameterMap();
		Map returnMap = new HashMap(); 
		Iterator entries = properties.entrySet().iterator(); 
		Map.Entry entry; 
		String name = "";  
		String value = "";  
		StringBuffer sb = new StringBuffer("访问成功:请求参数【");
		while (entries.hasNext()) {
			entry = (Map.Entry) entries.next(); 
			name = (String) entry.getKey(); 
			Object valueObj = entry.getValue(); 
			if(null == valueObj){ 
				value = ""; 
			}else if(valueObj instanceof String[]){ 
				String[] values = (String[])valueObj;
				for(int i=0;i<values.length;i++){ 
					 value = values[i] + ",";
				}
				value = value.substring(0, value.length()-1); 
			}else{
				value = valueObj.toString(); 
			}
			value=StringUtils.trim(value);
			sb.append(name+":"+value+",");
			returnMap.put(name, value); 
		}
		returnMap.put("#reip#", request.getRemoteAddr());
		map = returnMap;
		logger.info(sb.toString()+"】");
		
		String requrl=request.getRequestURL().toString();
		 
		 StringBuffer mysb=new StringBuffer(requrl);
		 for(Object key:map.keySet()){
			 mysb.append(key).append("=").append(map.get(key)).append(";");
		 }
		 
		 
		 DaoUtil.test(LogType.REQandPARAM, mysb.toString());
	}
	 
	
	public PageData(HttpServletRequest request,HttpServletResponse response) {
		this.request = request;
		Map returnMap = new HashMap(); 
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
	        response.setContentType("text/html;charset=UTF-8");
	        
			Map properties = request.getParameterMap();
			Iterator entries = properties.entrySet().iterator(); 
			Map.Entry entry; 
			String name = "";  
			String value = "";  
			while (entries.hasNext()) {
				entry = (Map.Entry) entries.next(); 
				name = (String) entry.getKey(); 
				Object valueObj = entry.getValue(); 
				value = ""; 
				if(null == valueObj){ 
					value = ""; 
				}else if(valueObj instanceof String[]){ 
					String[] values = (String[])valueObj;
					for(int i=0;i<values.length;i++){ 
						 value += values[i] + ",";
					}
					value = value.substring(0, value.length()-1); 
				}else{
					value = valueObj.toString(); 
				}
				if("GET".equals(request.getMethod())){
				  value=new String(value.getBytes("ISO-8859-1"),"UTF-8"); 
				}
				value = value.trim();
				returnMap.put(name, value); 
			  }
			returnMap.put("#reip#", request.getRemoteAddr());
			} catch (UnsupportedEncodingException e) {
			    logger.error(e);
		 }
		 map = returnMap;
		 
		 String requrl=request.getRequestURL().toString();
		 
		 StringBuffer mysb=new StringBuffer(requrl);
		 for(Object key:map.keySet()){
			 mysb.append(key).append("=").append(map.get(key)).append(";");
		 }
		 
		 
		 DaoUtil.test(LogType.REQandPARAM, mysb.toString());
	}
	 
	
	
	
	public PageData() {
		map = new HashMap();
	}
	
	@Override
	public Object get(Object key) {
		Object obj = null;
		if(map.get(key) instanceof Object[]) {
			Object[] arr = (Object[])map.get(key);
			obj = request == null ? arr:(request.getParameter((String)key) == null ? arr:arr[0]);
		} else {
			obj = map.get(key);
		}
		return obj;
	}
	
	public String getString(Object key) {
		return (String)get(key);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object put(Object key, Object value) {
		return map.put(key, value);
	}
	
	@Override
	public Object remove(Object key) {
		return map.remove(key);
	}

	public void clear() {
		map.clear();
	}

	public boolean containsKey(Object key) {
		// TODO Auto-generated method stub
		return map.containsKey(key);
	}

	public boolean containsValue(Object value) {
		// TODO Auto-generated method stub
		return map.containsValue(value);
	}

	public Set entrySet() {
		// TODO Auto-generated method stub
		return map.entrySet();
	}

	public boolean isEmpty() {
		// TODO Auto-generated method stub
		return map.isEmpty();
	}

	public Set keySet() {
		// TODO Auto-generated method stub
		return map.keySet();
	}

	@SuppressWarnings("unchecked")
	public void putAll(Map t) {
		// TODO Auto-generated method stub
		map.putAll(t);
	}

	public int size() {
		// TODO Auto-generated method stub
		return map.size();
	}

	public Collection values() {
		// TODO Auto-generated method stub
		return map.values();
	}

}
