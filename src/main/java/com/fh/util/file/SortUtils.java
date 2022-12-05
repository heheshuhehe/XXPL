package com.fh.util.file;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.util.HSSFColor;

/**
 * 
 * @author sxycwuxk(wuxiaokai@sinosoft.com.cn)
 * 
 * @project maven-guzhi
 * 
 * @file SortUtils.java
 * 
 * @description 集合排序的公共方法
 * 
 * @time 2017-3-29 下午12:39:00
 */
public class SortUtils {

	/**
	 * 
	 * 将字段按数字进行排序
	 * 
	 * @param data
	 *            list结果集
	 * @param filed
	 *            需要排序的字段
	 * @param orderType
	 *            排序的类型 asc升序 desc降序
	 * 
	 */
	public static void sortIntField(List<Map<String,Object>> data, final String filed, final String orderType) {

		Collections.sort(data, new Comparator<Object>() {

			@SuppressWarnings("rawtypes")
			@Override
			public int compare(Object o1, Object o2) {
				// TODO Auto-generated method stub
				Integer i1 = Integer.valueOf(((Map) o1).get(filed).toString());
				Integer i2 = Integer.valueOf(((Map) o2).get(filed).toString());
				if ("desc".equalsIgnoreCase(orderType)) {
					return i2.compareTo(i1);
				} else if ("asc".equalsIgnoreCase(orderType)) {
					return i1.compareTo(i2);
				} else {
					return 0;
				}
			}
		});
	}
	public static void sortdoubleField(List<Map<String,Object>> data, final String filed, final String orderType) {
		
		Collections.sort(data, new Comparator<Object>() {
			
			@SuppressWarnings("rawtypes")
			@Override
			public int compare(Object o1, Object o2) {
				// TODO Auto-generated method stub
				Double i1 = Double.valueOf(((Map) o1).get(filed).toString());
				Double i2 = Double.valueOf(((Map) o2).get(filed).toString());
				if ("desc".equalsIgnoreCase(orderType)) {
					return i2.compareTo(i1);
				} else if ("asc".equalsIgnoreCase(orderType)) {
					return i1.compareTo(i2);
				} else {
					return 0;
				}
			}
		});
	}
//	public static void main(String[] args) {
//		List<Map<String,Object>> data=new ArrayList<Map<String,Object>>();
//		
//		Map<String,Object> map = new HashMap<String, Object>();
//		map.put("ye", 2.11);
//		map.put("fhye", 2.11);
//		data.add(map);
//
//		Map<String,Object> map1 = new HashMap<String, Object>();
//		map1.put("ye", 0.22);
//		map1.put("fhye", 0.22);
//		data.add(map1);
//
//		Map<String,Object> map2 = new HashMap<String, Object>();
//		map2.put("ye", 1.22);
//		map2.put("fhye", 1.22);
//		data.add(map2);
//
//		Map<String,Object> map3 = new HashMap<String, Object>();
//		map3.put("ye", 1.12);
//		map3.put("fhye", 1.12);
//		data.add(map3);
//		
//		
//		sortdoubleField(data, "fhye", "desc");
//		
//		for (int i = 0; i < data.size(); i++) {
//			Map<String,Object> map_q =data.get(i);
//			System.out.println(map_q +"=====");
//		}
//	}	
	

}
