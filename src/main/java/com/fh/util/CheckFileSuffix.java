package com.fh.util;

public class CheckFileSuffix {
    public  static boolean checkFile(String fileName){
        boolean flag=false;
        String suffixList="xls,xlsx,jpg,gif,png,ico,bmp,jpeg,zip,rar,pdf,docx,doc";
        //获取文件后缀
        String suffix=fileName.substring(fileName.lastIndexOf(".")+1, fileName.length());

        if(suffixList.contains(suffix.trim().toLowerCase())){
            flag=true;
        }
        return flag;
    }
}
