package com.fh.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegCheckUtils {
	/** 
     * 手机号验证 
     *  
     * @param  str 
     * @return 验证通过返回true 
     */  
    public static boolean isMobile(String str) {   
        Pattern p = null;  
        Matcher m = null;  
        boolean b = false;   
        p = Pattern.compile("^[1][34578][0-9]{9}$"); // 验证手机号  
        m = p.matcher(str);  
        b = m.matches();   
        return b;  
    }  
    /** 
     * 电话号码验证 
     *  
     * @param  str 
     * @return 验证通过返回true 
     */  
    public static boolean isPhone(String str) {   
        Pattern p1 = null;  
        Matcher m = null;  
        boolean b = false;    
        p1 = Pattern.compile("^[0][0-9]{2,3}-[0-9]{7,8}$");  // 验证带区号的  
        //p2 = Pattern.compile("^[1-9]{1}[0-9]{5,8}$");         // 验证没有区号的  
        if(str.length() >9){
        	m = p1.matcher(str);  
            b = m.matches();    
        } 
        return b;  
    } 
    
    public static boolean isMail(String str) {   
        Matcher m = null;  
        boolean b = false;    
        Pattern pattern = Pattern.compile("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");
        m  = pattern.matcher(str);
        b = m.matches();   
        return b;  
    } 
   
    
    public static boolean isEmpName(String str){
    	  Matcher m = null;  
          boolean b = false;    
          Pattern pattern = Pattern.compile("^([a-zA-Z0-9]){1,12}$");
          m  = pattern.matcher(str);
          b = m.matches();   
          return b;  
    }
    
    public static boolean isEmpRealName(String str){
  	  Matcher m = null;  
        boolean b = false;    
        Pattern pattern = Pattern.compile("^([\\u4E00-\\uFA29]|[\\uE7C7-\\uE7F3]){1,6}$");
        m  = pattern.matcher(str);
        b = m.matches();   
        return b;  
   }
    public static boolean isID(String str){
    	  Matcher m = null;  
          boolean b = false;    
          Pattern pattern = Pattern.compile("^[1-9]{1}\\d*$");
          m  = pattern.matcher(str);
          b = m.matches();   
          return b;  
    }
    
    public static boolean isSex(String str){
        boolean b = false;    
        if("01".equals(str)||"02".equals(str)){
        	b=true;
        }
        return b;  
  }
    public static boolean isName(String str){
  	  Matcher m = null;  
        boolean b = false;    
        Pattern pattern = Pattern.compile("^([\\u4E00-\\uFA29]|[\\uE7C7-\\uE7F3]|[a-zA-Z0-9]){1,24}$");
        m  = pattern.matcher(str);
        b = m.matches();   
        return b;  
  }
    public static boolean isBZ(String str){
    	  Matcher m = null;  
          boolean b = false;    
          Pattern pattern = Pattern.compile("^([\\u4E00-\\uFA29]|[\\uE7C7-\\uE7F3]|[a-zA-Z0-9]|[,.，。]){1,255}$");
          m  = pattern.matcher(str);
          b = m.matches();   
          return b;  
    }
	public static boolean isAddr(String param5) {
		 Matcher m = null;  
         boolean b = false;    
         Pattern pattern = Pattern.compile("^([\\u4E00-\\uFA29]|[\\uE7C7-\\uE7F3]|[a-zA-Z0-9]|[()（）#-]){1,50}$");
         m  = pattern.matcher(param5);
         b = m.matches();   
         return b;  
	}
    public static boolean isFax(String str){
  	  Matcher m = null;  
        boolean b = false;    
        Pattern pattern = Pattern.compile("^[0-9]{3,4}-[0-9]{5,10}$");
        m  = pattern.matcher(str);
        b = m.matches();   
        return b;  
  }
   public static boolean isURL(String str){
    	  Matcher m = null;  
          boolean b = false;    
          Pattern pattern = Pattern.compile("^([a-zA-Z0-9]*/[a-zA-Z0-9]*){1,4}.do$");
          m  = pattern.matcher(str);
          b = m.matches();   
          return b;  
    }
    
    public static void main(String[] args) {
    	if(isMobile("12234528824")){
    		System.out.println("true");
    	}
    }
}
