package com.fh.controller.system.util;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 金额 小写转大写
 * @author wangxiaoli
 *
 */
public class AmountConversionController {
	private static final String UNIT = "万千佰拾亿千佰拾万千佰拾元角分";    
    private static final String DIGIT = "零壹贰叁肆伍陆柒捌玖";    
    private static final double MAX_VALUE = 9999999999999.99D;    
    public static String change(double v) {    
     if (v < 0 || v > MAX_VALUE){    
         return "参数非法!";    
     }    
     long l = Math.round(v * 100);    
     if (l == 0){    
         return "零元整";    
     }    
     String strValue = l + "";    
     // i用来控制数    
     int i = 0;    
     // j用来控制单位    
     int j = UNIT.length() - strValue.length();    
     String rs = "";    
     boolean isZero = false;    
     for (; i < strValue.length(); i++, j++) {    
      char ch = strValue.charAt(i);    
      if (ch == '0') {    
       isZero = true;    
       if (UNIT.charAt(j) == '亿' || UNIT.charAt(j) == '万' || UNIT.charAt(j) == '元') {    
        rs = rs + UNIT.charAt(j);    
        isZero = false;    
       }    
      } else {    
       if (isZero) {    
        rs = rs + "零";    
        isZero = false;    
       }    
       rs = rs + DIGIT.charAt(ch - '0') + UNIT.charAt(j);    
      }    
     }    
     if (!rs.endsWith("分")) {    
      rs = rs + "整";    
     }    
     rs = rs.replaceAll("亿万", "亿");    
     return rs;    
    }  
    
    /**
     * 读取文件名称
     * @param path 文件夹路径
     * @return 文件名称数组
     */
    public static String [] getFileName(String path)
    {
        File file = new File(path);
        String [] fileName = file.list();
        return fileName;
    }
    
    
	  /**
	   * Java文件操作 获取不带扩展名的文件名 
	   * @param filename 文件名称
	   * @return 文件名称（不带后缀）
	   */
    public static String getFileNameNoEx(String filename) {   
        if ((filename != null) && (filename.length() > 0)) {   
            int dot = filename.lastIndexOf('.');   
            if ((dot >-1) && (dot < (filename.length()))) {   
                return filename.substring(0, dot);   
            }   
        }   
        return filename;   
    }
        
    public static void main(String[] args){    
       // System.out.println(AmountConversionController.change(72356789.9845)); 
    	
        //读取文件中的文件名称
        String [] fileName = getFileName("C:\\Users\\王小利\\Desktop\\PB\\二期\\证明模板");
        int i=0;
        int j=0;
        for(String name:fileName)
        { 
        		//利用正则表达式来判断文件名称是否标准            2016年10月01日_余额表_银国达策略精三号_月报
        	    
        		//String regexp ="^\\d{4}年\\d{0,2}月\\d{0,2}日_[a-zA-Z0-9\u4e00-\u9fa5]+_[月|季|年]报$";
        	String regexp ="^[Y|J|N]_[0-9]*_[\\d{4}\\d{0,2}|\\d{4}|\\d{4}_\\d{1}]+_[a-zA-Z0-9\u4e00-\u9fa5]+$";
        	Pattern p =Pattern.compile(regexp);
        		Matcher m = p.matcher(name); 
        		if (m.find()){
        			String splNameList[]= name.split("_");
            		for(int h=0;h<splNameList.length;h++){
            			String jjname=splNameList[1].toString();//基金名称
            			String jjtype=getFileNameNoEx(splNameList[2].toString());//文件类型	
            		}
        			System.out.println(name);
        			j++;
        		}else{
        			//将文件名称直接入库     基金名称和文件类型为空
        			
        		}
        	
        	i++;
        }
        System.out.println("一共有："+i+"个文件");
        System.out.println("文件名称匹配正确的有"+j+"个文件");
        System.out.println("文件名称匹配错误的有"+(i-j)+"个文件");
    }


}
