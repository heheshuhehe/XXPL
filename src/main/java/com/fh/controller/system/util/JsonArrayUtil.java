package com.fh.controller.system.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.fh.util.Logger;


import net.sf.json.JSONArray;

public class JsonArrayUtil {
	protected Logger logger = Logger.getLogger(this.getClass());
	public String jsonArray(String param){
		
		JSONArray jsonArray = JSONArray.fromObject(param);
		
		List<Map<String,Object>> mapListJson = (List)jsonArray;
//		List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
		String value = "";
		for (int i = 1; i < mapListJson.size(); i++) {  
			Map<String,Object> obj= mapListJson.get(i);  
			for(Entry<String,Object> entry : obj.entrySet()){ 
				Object strval1 = entry.getValue();  
				
				if(strval1!=null){
					value = strval1.toString();
				}
			}
		}
		return value;
	}
	public List<LinkedHashMap<Integer, String>> getNeedListResults(String jsonArrayString,String[] keys){
		
		JSONArray jsonArray = JSONArray.fromObject(jsonArrayString);
		List<LinkedHashMap<Integer, String>> list = new ArrayList<LinkedHashMap<Integer, String>>();
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<Map<String,Object>> mapListJson = (List)jsonArray;  
		for (int i = 1; i < mapListJson.size(); i++) {  
			Map<String,Object> obj= mapListJson.get(i);  
			LinkedHashMap<Integer,String> result_map = new LinkedHashMap<Integer,String>();
			
			for(int k=0;k<keys.length;k++){
				String en = keys[k].trim();
				Object o = obj.get(en);
				String value = "";
				if(o!=null){
					value = o.toString();
					if("null".equals(value)||value==null){
						value = "";
					}
				}
				result_map.put(k, value);
			}
			list.add(result_map);
		}  
		return list;
	}
	
	public static List<LinkedHashMap<Integer, String>> getNeedListResults1(String jsonArrayString,String[] keys){
		
		JSONArray jsonArray = JSONArray.fromObject(jsonArrayString);
		List<LinkedHashMap<Integer, String>> list = new ArrayList<LinkedHashMap<Integer, String>>();
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<Map<String,Object>> mapListJson = (List)jsonArray;  
		for (int i = 1; i < mapListJson.size(); i++) {  
			Map<String,Object> obj= mapListJson.get(i);  
			LinkedHashMap<Integer,String> result_map = new LinkedHashMap<Integer,String>();
			
			for(int k=0;k<keys.length;k++){
				String en = keys[k].trim();
				Object o = obj.get(en);
				String value = "";
				if(o!=null){
					value = o.toString();
					if("null".equals(value)||value==null){
						value = "";
					}
				}
				result_map.put(k, value);
			}
			list.add(result_map);
		}  
		return list;
	}
}
