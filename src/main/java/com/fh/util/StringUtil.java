package com.fh.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.regex.Pattern;

/**
 * 字符串相关方法
 *
 */
public class StringUtil {
	
	static String regx = "^((-?\\d+.?\\d*)[Ee]{1}(-?\\d+))$";//科学计数法正则表达式

    static Pattern pattern = Pattern.compile(regx);
    
	static String numberRegx="^(\\-|\\+)?\\d+(\\.\\d+)?$";
	
	static Pattern numberpattern=Pattern.compile(numberRegx);
	
	

	/**
	 * 将以逗号分隔的字符串转换成字符串数组
	 * @param valStr
	 * @return String[]
	 */
	public static String[] StrList(String valStr){
	    int i = 0;
	    String TempStr = valStr;
	    String[] returnStr = new String[valStr.length() + 1 - TempStr.replace(",", "").length()];
	    valStr = valStr + ",";
	    while (valStr.indexOf(',') > 0)
	    {
	        returnStr[i] = valStr.substring(0, valStr.indexOf(','));
	        valStr = valStr.substring(valStr.indexOf(',')+1 , valStr.length());
	        
	        i++;
	    }
	    return returnStr;
	}

	   public static boolean isENum(String input){//判断输入字符串是否为科学计数法
	        return pattern.matcher(input).matches();
	    }
	   public static boolean isnumber(String input) {
		return numberpattern.matcher(input).matches();
		
	}
	   public static String str4qute(String input,String split) {
			 String inpu [] =input.split(split);
			 String newstr="";
			 for (String str:inpu){
				 newstr=newstr+"'"+str+"',";
			 }
		return	 newstr.substring(0,newstr.length()-1);
		}
	   /**
	    * 2019-01
	    * */
	   public static String getLastDayOfMonth(String yearMonth) {
           int year = Integer.parseInt(yearMonth.split("-")[0]);  //年
           int month = Integer.parseInt(yearMonth.split("-")[1]); //月
           Calendar cal = Calendar.getInstance();
           // 设置年份
           cal.set(Calendar.YEAR, year);
           // 设置月份
           cal.set(Calendar.MONTH, month - 1);
           // 获取某月最大天数
           int lastDay = cal.getActualMaximum(Calendar.DATE);
           // 设置日历中月份的最大天数
           cal.set(Calendar.DAY_OF_MONTH, lastDay);
           // 格式化日期
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
           return sdf.format(cal.getTime());
	   }
		public  static String  date8Todate10(String yyyyMMdd) {
			return yyyyMMdd.substring(0,4)+"-"+ yyyyMMdd.substring(4,6)+"-"+ yyyyMMdd.substring(6,8);
		}
		public static void runbat(String path,String filename){
			String cmd = "cmd /c start "+path+"/"+filename; 
			//String cmd = "cmd /c start B:/虚拟估值表/start.bat"; 
			try { 
				Runtime.getRuntime().exec(cmd); 
				System.out.println(cmd);
			} catch(IOException ioe) { 
				ioe.printStackTrace(); 
				} 
			}

}
