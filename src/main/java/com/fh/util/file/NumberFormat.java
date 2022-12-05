package com.fh.util.file;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class NumberFormat {

	/**
	 * 格式化数字为千分位显示；
	 * 
	 * @param 要格式化的数字
	 *            ；
	 * @return
	 */
	public static String fmtMicrometer(String text) {
		DecimalFormat df = null;
		if (text.indexOf(".") > 0) {
			if (text.length() - text.indexOf(".") - 1 == 0) {
				df = new DecimalFormat("###,##0.");
			} else if (text.length() - text.indexOf(".") - 1 == 1) {
				df = new DecimalFormat("###,##0.0");
			} else {
				df = new DecimalFormat("###,##0.00");
			}
		} else {
			df = new DecimalFormat("###,##0");
		}
		double number = 0.0;
		try {
			number = Double.parseDouble(text);
		} catch (Exception e) {
			number = 0.0;
		}
		return df.format(number);
	}
	
	
	/**
	 * 格式化数字为千分位显示；并且保留两位小数
	 * 
	 * @param 要格式化的数字
	 *            ；
	 * @return
	 */
	public static Object fmtMicrometer_1(Object text,int num) {
		Object result = "";
		DecimalFormat df = null;
		if (num <=0){
			df = new DecimalFormat("###,##0");
		} else {
			String temp = "###,##0.";
			for (int i = 0 ; i < num ; i++){
				temp = temp +"0";
			}
			df = new DecimalFormat(temp);
		}
		double number = 0.0;
		try {
			if (text instanceof Double){
				number = (double) text;
			} else if (text instanceof Integer){
				number = Double.parseDouble(String.valueOf(text));
			} else {
				number = Double.parseDouble(text.toString());
			}
			result = df.format(number);
		} catch (Exception e) {
			result = text;
		}
		return result;
	}
	
	/**
	 * 将Map中的数字格式化 ###,###.00
	 * @param values
	 * @return
	 */
	public static Map<String, Object> numberchn(Map<String, Object> values) {
		if (values == null) {
			return values;
		}
		Set<String> set = values.keySet();
		for (Iterator<String> iter = set.iterator(); iter.hasNext();) {
			String key = (String) iter.next();
			Object value = values.get(key);
			if (value != null){
				values.put(key, fmtMicrometer_1(value,2));
			}
		}
		return values;
	}
	
	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("AAA1", "AAAAAA");
		map.put("AAA2", "1234");
		map.put("AAA3", "0.1");
		map.put("AAA4", "0");
		map.put("AAA5", "9931351.58");
		map.put("AAA6", "2016-09-09");
		map.put("AAA7", 0.100);
		map.put("AAA8", "100000000000");
		map.put("AAA9", 9931351.580);
		map.put("AAA10", null);
		map.put("AAA11", "");
		map.put("AAA12", 0);
		System.out.println(numberchn(map).toString());
	}

}
