package sinosoft;
 
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import sinosoft.utils.LogoBean;
import sinosoft.utils.PDFUtil;
import sinosoft.utils.PropertyUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.sinosoft.scs.core.HttpClientCall;
import com.sinosoft.scs.core.Param;
  
public class CreateGZBCrontab {  
	private  static  Logger logger = Logger.getLogger(CreateGZBCrontab.class);
	static HttpClientCall hcc = new HttpClientCall();
	static String user_name = "";
	static String operator_id="";
	static String clientType = "pc";
	static String operator_role = "2";
	static String version_id = "V1.0";
	static String ipAdress="";
	static String head=PropertyUtils.getSysConfigSet("head");
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
	static String fileEncode = PropertyUtils.getSysConfigSet("fileEncode");
	static String realpath= PropertyUtils.getSysConfigSet("realpath");
	
	/**
	 * 查询数据库，获取要发送的邮件数据
	 * @param args
	 */
	public static  List<HashMap<String,String>> getDBMailInfoGz(){
	    String func_id="YWB_employeeService.getDBMailInfoGz"; 
	    Param param = new Param(clientType,ipAdress,operator_role,operator_id, user_name, func_id, version_id,null);
		logger.info("^_^调用接口方法：【"+func_id+"】");
		String result = hcc.call(param);
		JSONObject obj  =  JSONObject.fromObject(result);
		List<HashMap<String,String>>	 mailList  = new ArrayList<HashMap<String,String>>();
		if(obj.get("data")!=null){
			JSONArray jsonArray = JSONArray.fromObject(obj.get("data"));
			 mailList  = (List<HashMap<String,String>>) JSONArray.toList(jsonArray,HashMap.class);
		}
		return mailList;
	}
    /**
     * 生成估值表-pdf 
     * @param gz_filename 
     * @param fund_code 
     */ 
	public static  void getFileConnection(String fid,String fund_code, String gz_filename,String opertor) {
	       try {
		   		String productName =gz_filename;//格式基金名称@@日期
			    String str  = sdf1.format(sdf.parse(gz_filename.split("@@")[1]));//估值日期
		   		//查询单位净值 如无，则日期没有数据 不需在查询估值表信息
		   		String unitNet = "1.002";
		   				//getUnitNet(fund_code,str);//单位净值（查询出）
		   		 if(StringUtils.isNotEmpty(unitNet)){
					String[] headorder = head.split(",");//英文名称（表头写入顺序/map的key）
					String dataParaString = "@@p1_@_@@p2_@_"+fund_code+"@@p3_@_@@p4_@_@@p5_@_"+str;
					String[] dataPara = dataParaString.toString().replaceFirst("_@_","").trim().split("_@_");
					int size = dataPara.length;
					String time = dataPara[size-1];//估值日期
					String funcId = "fundvaluation";//功能号
					Map<String,String> map = new HashMap<String,String>();
					for( String param :  dataParaString.replaceFirst("@@","").trim().split("@@")){
			   			String[] paramDetail = param.split("_@_");
			   			String key = paramDetail[0].trim();
			   			String value = "";
			   			if(paramDetail.length>1){
			   				value = paramDetail[1];
			   			}
			   			map.put(key, value);
			   		}
				    Param param = new Param(clientType,ipAdress,operator_role,operator_id, user_name, funcId, version_id,map);
				    logger.info("^_^调用接口方法：【"+funcId+"】... ... ");
					String result = hcc.call(param);
					JSONArray jsonArray = JSONArray.fromObject(result); 
					
					 //20180105查询制表人
			        map.put("funcId", "getGZBCreateUser");
			        map.put("d_biz", time);
			        map.put("fund_code", map.get("p2"));
			        Param param1 = new Param(clientType,ipAdress,operator_role,operator_id, user_name, "getGZBCreateUser", version_id,map);
			        String result2 = hcc.call(param1);
			        
			        JSONObject object = JSONObject.fromObject(result2);
			        String create_operator="";
			        if(object!=null){
			        	if(object.get("err_code")!=null && "".equals(object.getString("err_code"))){
			        		if(object.get("create_operator")!=null){
			        			create_operator = object.getString("create_operator");
			        		}
			        	}
			        }
					
					
					//生成估值表
					 if(jsonArray.size()>1){
						 String downloadBase = PropertyUtils.getSysConfigSet("downloadPath");
						 logger.info("^_^估值表生成服务器，下载路径根目录downloadPath:【"+downloadBase+"】 ... ... ");
						 String filePath = downloadBase+productName.split("@@")[0];
					     File dir=new File(new String(filePath));
						 if(!dir.exists()){//如果不存在，则生成文件夹
						     dir.mkdirs();
						 }
						 String filePathAll = downloadBase+productName.split("@@")[0]+File.separator+productName+"_nomark.pdf";//文件全路径
						 logger.info("^_^估值表生成服务器，估值表全路径为:【"+filePathAll+"】 ... ... ");
				          PDFUtil pdfUtil = new PDFUtil();
				          List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
				      	  List<Map<String,Object>> mapListJson = (List)jsonArray;//数据由jsonArray转换为List
				      	 for (int i = 1; i < mapListJson.size(); i++) {  
		    				Map<String,Object> obj= mapListJson.get(i);  
		    				LinkedHashMap<String,String> result_map = new LinkedHashMap<String,String>();
		    				for(Entry<String,Object> entry : obj.entrySet()){  
		    					String strkey1 = entry.getKey();  
		    					Object strval1 = entry.getValue();  
		    					String value = "";
		    					if(strval1!=null){
		    						value = strval1.toString();
		    					}else{
		    						logger.info("^_^ 第【"+i+"】条记录,key为【"+strkey1+"】的值为空，从记录中删除  ... ... ");
		    					}
		    					result_map.put(strkey1, value);
		    				}  
		    				list.add(result_map);
		    			}  
				      	//表头写入顺序、数据list（Map）、文件路径、产品名称、估值日期、单位净值、操作员
				     	pdfUtil.CreatValuationTables(headorder, list, filePathAll, productName,time,unitNet,opertor,create_operator);
				     	
				     	//添加水印
						String logopath=realpath+"logo_pdf.png";
						String sealpath=realpath+"seal.png";
						LogoBean logoBean = new LogoBean(logopath,sealpath);
				     	logger.info("【"+gz_filename+"】估值表开始加水印！... ... ");
						BufferedOutputStream bos =
					       new BufferedOutputStream(new FileOutputStream(new File(downloadBase+productName.split("@@")[0]+File.separator+productName+".pdf")));
						pdfUtil.addPdfMark("CreatValuationTable",filePathAll,bos,logoBean);
						logger.info("【"+gz_filename+"】估值表加水印end！... ... ");
						
						
				     	updateGztable(fid,"02","");//02 上传成功 01 未发送
					 }else{//估值表不存在
						updateGztable(fid,"03","");
					 }
		   		 }else{
		   			   updateGztable(fid,"03","");
		   		 }
	   			} catch (Exception e) {
	   			    logger.error("【"+gz_filename+"】估值表生成失败！:"+e.toString());
	   				String str = e.toString();
	   				if(str.length()>400){
	   					str = str.substring(0, 400);
	   				}
	   				updateGztable(fid,"03","估值表生成失败："+str);
	   			}
 	}
    //查询指定日期的单位净值
	private static String getUnitNet(String fund_code, String gzdate) throws ParseException {
		    String unitNet="";
		    Map<String, String> map4 = new HashMap<String, String>();
		    String func_id = "fundnetvalueAndcompany";
			map4.put("p1", "");
			map4.put("p2", fund_code);
			map4.put("p3", gzdate);
			Param param = new Param(clientType,ipAdress,operator_role,operator_id, user_name, func_id, version_id ,map4);
		   String result2 = hcc.call(param);
		   JSONArray obj2  =  JSONArray.fromObject(result2);
		   if(obj2!=null && obj2.size()>1){
			   JSONObject pd =  (JSONObject)obj2.get(1);
			   unitNet = (String) pd.get("fkmmc");
		   }
		return unitNet;
	}
    //更新估值表附件上传状态
	public static void  updateGztable(String fid,String upload_status,String errInfo) {
		String func_id = "updateUploadStatus";
		Map<String, String> map4 = new HashMap<String, String>();
		map4.put("p1", fid);
		map4.put("p2", upload_status);
		map4.put("p4", errInfo);
		Param param = new Param(clientType,ipAdress,operator_role,operator_id, user_name, func_id, version_id ,map4);
	    String result2 = hcc.call(param);
	    if(StringUtils.isEmpty(result2)){
	    	 logger.info("更新估值表附件fid=【"+fid+"】的上传状态【"+upload_status+"】成功");
	    }else{
	         logger.info("更新估值表附件fid=【"+fid+"】的上传状态【"+upload_status+"】，返回错误信息【"+result2+"】... ...");
	    }
	}
	public static void main2(String[] args) {
	    	  try {
    			  System.out.println(System.getProperty("file.encoding"));
				  System.out.println(System.getProperty("sun.jnu.encoding"));
				  System.setProperty("sun.jnu.encoding",fileEncode);
	    		  List<HashMap<String,String>> list2  = getDBMailInfoGz();
	    		  SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    		  if(list2!=null && !list2.isEmpty()){
	    			  logger.info("邮件list不为空，长度为："+list2.size()+"... ...");
	    			  for (HashMap<String, String> mailMap : list2) {
	    				   String fund_code = mailMap.get("FUND_CODE");//基金代码
	    				   String gz_filename = mailMap.get("GZ_FILENAME");//估值表名称
	    				   String upload_status = mailMap.get("UPLOAD_STATUS");//是否上传估值表
	    				   String upload_date_string = mailMap.get("FORMAT_UPLOAD_DATE");//上传时间
	    				   String opertorName =  mailMap.get("YGNAME");//操作员姓名
	    				   String fid = mailMap.get("FID");//唯一标识
	    				   Date  upload_date=  sdf.parse(upload_date_string);
	    				   Date  now_date = new Date();
	    				   //上传状态为01 未上传 和03上传失败
	    				   if("01".equals(upload_status) ||"03".equals(upload_status)){
    					      //当前日期大于上传日期
    					      if(now_date.getTime()>upload_date.getTime()){
    					    	  //生成估值表
    					    	  if(StringUtils.isNotEmpty(fund_code) && StringUtils.isNotEmpty(gz_filename)&&
    					    			  StringUtils.isNotEmpty(opertorName) ){
    					    	       getFileConnection(fid,fund_code,gz_filename,opertorName);
    					    	  }
    					      }  
	    				   }
	    			  }
	    		  }
			} catch (Exception e) {
			     logger.error("定时生成估值表任务失败:"+e.toString()+"... ...");
			}
    }
	public static void main(String[] args) {
		getFileConnection("90900","152","ceshi@@20180510","lhj");
	}
	
}  
