package com.fh.util.file;

import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;

public class SortUtil implements Comparator<String>{

	@Override
	public int compare(String str1, String str2) {
		return str1.compareTo(str2);
	}
	
	/**
	 * 使用 Map按key进行排序
	 * @param map
	 * @return
	 */
	public static Map<String, Object> sortMapByKey(Map<String, Object> map) {
		if (map == null || map.isEmpty()) {
			return null;
		}

		Map<String, Object> sortMap = new TreeMap<String, Object>(
				new SortUtil());

		sortMap.putAll(map);

		return sortMap;
	}

}
