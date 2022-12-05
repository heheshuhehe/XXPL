package com.fh.util;


public class Constants {
	
	public static String PICTURE_VISIT_FILE_PATH = "";//图片访问的路径
	
	public static String PICTURE_SAVE_FILE_PATH = "";//图片存放的路径

	/**/
    public static final String SUCCESS = "200"; //成功
    public static final String NOTREADY = "201"; //成功，但数据尚未完成。


    public static final String FILEETRANSFERRRORCODE = "300"; 	//文件传输有误
    public static final String FUND_CODEERRORCODE = "301"; 		//fund_code有误
    public static final String DATE_NOERRORCODE = "302";		//date_no有误
    public static final String REPORTTYPEERRORCODE = "303";		//date_no有误
    public static final String DATAERRORCODE = "304";			//date_no有误
    public static final String FILENAMERRORCODE = "305"; 		//文件名
    public static final String AUTHKEYRRORCODE = "306"; 		//authkey名错误

    public static final String FILEEPATHRRORCODE = "307"; 		//本地文件路径有误
    public static final String PRINTER_ERRORCODE = "308"; 		//打印时出错误
    
    public static final String OTHER_ERRORCODE = "500"; 		//其他错误
    public static final String MANDATORY_ERRORCODE = "501"; 		//强制生成错误

    //---吉贝克返回状态归档
    public static final String NOTGENERATED = "0";				//未生成
    public static final String SUCCESSFULLYGENERATED = "1";		//已成报告(xbrl校验已通过)
    public static final String FINANCIALERROR = "2";			//财务指标有错误
    public static final String MANDATORY = "3";					//强制生成报告(xbrl校验不通过)
//    public static final String FAILGENERATED = "9";				//生成失败(其他原因失败)
    
    //基金核对状态
    public static final String 未核对 = "0";						//未核对
    public static final String 核对一致 = "1";						//核对一致
    public static final String 核对不一致 = "2";					//核对不一致 
    public static final String 有修改不一致 = "3";					//有修改不一致
    public static final String 人工确认一致 = "4";					//人工确认一致
    public static final String 人工确认不一致 = "5";				//人工确认不一致
    public static final String 不需要核对 = "9";					//不需要核对 
    public static final String 不需要核对有修改 = "A";				//不需要核对有修改
    
    public static final String MODIFY 	= "3";					//明细页面人工修改确认
    public static final String CONFIRM 	= "4";					//明细页面指标确认

    public static final String 投监未核对 = "0";					//投监未核对
    public static final String 投监核对一致 = "1";					//投监核对一致
    public static final String 投监核对不一致 = "2";				//投监核对不一致
    public static final String 投监不需要核对 = "9";				//投监不需要核对

    
    public static final String PROD 	= "PROD";				//生产
    public static final String TOUCHAN 	= "TOUCHAN";			//投产环境
    public static final String UAT 		= "UAT";				//uat环境
    public static final String LOCAL 	= "LOCAL";				//local开发环境

    public static final String LIQUIDATION = "LIQUIDATION";		//清盘报告
    public static final String MONTHLY = "M";					//月报
    public static final String QUANT = "M2";					//量化运行表
    public static final String SMO = "SMO";						//规模以上报告
    public static final String QUATERLY = "Q";					//季报
    public static final String QUATERLYUPDATE = "QU";			//季度更新
    public static final String QUATERLYUPDATEIN = "QUI";		//投资者信息表
    public static final String HALFYEAR = "HSR";				//半年报




	
	public static String getPICTURE_VISIT_FILE_PATH() {
		return PICTURE_VISIT_FILE_PATH;
	}

	public static void setPICTURE_VISIT_FILE_PATH(String pICTURE_VISIT_FILE_PATH) {
		PICTURE_VISIT_FILE_PATH = pICTURE_VISIT_FILE_PATH;
	}

	public static String getPICTURE_SAVE_FILE_PATH() {
		return PICTURE_SAVE_FILE_PATH;
	}

	public static void setPICTURE_SAVE_FILE_PATH(String pICTURE_SAVE_FILE_PATH) {
		PICTURE_SAVE_FILE_PATH = pICTURE_SAVE_FILE_PATH;
	}

	/**
	 * 将核对状态码翻译成数字编号
	 * @param source
	 * @return
	 */
	public static String getTranslatedCheckStatus(String source) {
		if (source==null || "".equals(source))return "";
		String[] sourceStrings= source.split(",");
		String resultString = "";
		for (String s: sourceStrings) {
			if ("未核对".equals(s)) {
				resultString= resultString+"'"+未核对+"',";
				continue;
			}
			if ("核对一致".equals(s)) {
				resultString= resultString+"'"+核对一致+"',";
				continue;
			}	
			if ("核对不一致".equals(s)) {
				resultString= resultString+"'"+核对不一致+"',";
				continue;
			}	
			if ("有修改不一致".equals(s)) {
				resultString= resultString+"'"+有修改不一致+"',";
				continue;
			}	
			if ("人工确认一致".equals(s)) {
				resultString= resultString+"'"+人工确认一致+"',";
				continue;
			}	
			if ("人工确认不一致".equals(s)) {
				resultString= resultString+"'"+人工确认不一致+"',";
				continue;
			}	
			if ("不需要核对".equals(s)) {
				resultString= resultString+"'"+不需要核对+"',";
				continue;
			}	
			if ("不需要核对有修改".equals(s)) {
				resultString= resultString+"'"+不需要核对有修改+"',";
				continue;
			}	
		}
		if (resultString.length()>1) {resultString=resultString.substring(0, resultString.length()-1);}
		return resultString;
	}
	
	
	public static void main(String[] args) {
		Constants.setPICTURE_SAVE_FILE_PATH("D:/Tomcat 6.0/webapps/FH/topic/");
		Constants.setPICTURE_VISIT_FILE_PATH("http://192.168.1.225:8888/FH/topic/");
	}
	
}
