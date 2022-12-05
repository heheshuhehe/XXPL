package xxpl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.fh.service.XinXiPiLuYueBaoServiceNew;
import com.fh.util.Logger;
import com.fh.util.reportService.com.swhy.report.ReportApp;
import com.fh.util.reportService.com.swhy.report.ReportHelper;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptCreateJson4Xml;
import com.swhy.xxpl.model.ReptSqlConfig;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ExportFileThread implements Runnable{
	protected Logger loger = Logger.getLogger(this.getClass());

	private Map<String, Object> tParamsMap;
	private int	ix;
	HashMap<String , ReptSqlConfig>  readXml;
	private String jsonFilePath;
	private String[] exportFileName1;
	private String[] exportPortCode1;
	private String[] exportDate1;
	private String[] exportDate21;
	private HashMap<String,String> fundVariables;
	private String pageNumber;
	private String dataParaString;
	private String HeaderNames_en;
	private String HeaderNames_zh;
	private String modelname;
	private String modeFileBase;
	private String pathRar;
	private String sheetNumber;
	private HttpServletRequest request;
	Connection conn;

	/**
	 *  Accept the parameters from main stream and give values to all the attributes.
	 * @param map		the big map holds all parameters except the smallMap
	 * @param smallMap
	 */
	public ExportFileThread(Map<String, Object> map, Map<String, String> fundVariableMap, HttpServletRequest request, int ix, AtomicLong threadTimeConsumer, Connection conn) {
		
		if (map != null) this.setTParamsMap(map);
		else return;
		this.ix = ix;
		setConn(conn);
		setFundVariables		(fundVariableMap );
		setReadXml((HashMap<String, ReptSqlConfig>) map.get("readXml"));

		this.request = 		request;//(HttpServletRequest)tParamsMap.get("request");

	}
	
	/**
	 * triggers  
	 */
	@Override
	public void run () {
		long now = System.currentTimeMillis();
		System.out.println(Thread.currentThread().getName()+"%%%%%%%%%%%startThreadExport%%%%%%%%%%%%%%%");
		try {
			exportFile();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		long time = System.currentTimeMillis()-now;
		System.out.println(Thread.currentThread().getName()+"___________EndThreadExport_________________"+time);
				
//		if ( time>threadTimeConsumer.get()) threadTimeConsumer.set(time) ;
	}
	
	public void exportFile() throws Exception{
		ReptCreateJson4Xml reptCreateJson4Xml = new ReptCreateJson4Xml();
	    boolean flag = reptCreateJson4Xml.create(readXml , this.getFundVariables(), null,this.getConn()); 
	    String JSONPath = fundVariables.get("folderPath")+ XinXiPiLuYueBaoServiceNew.JSONFOLDER+ fundVariables.get("fund_code")+".json";
		createReportsByJSON(JSONPath);
	}
	
	/**
	 * 转换word成pdf
	 * @param docxFilePath
	 * @param pdfFilePath
	 * @return
	 */
	public Boolean word2PDF(String docxFilePath, String pdfFilePath)  {
		ReptCreateJson4Xml reptCreateJson4Xml = new ReptCreateJson4Xml();
		try {
			ReportHelper.createPdf(docxFilePath, pdfFilePath);
		} catch (Exception e) {
			loger.error(e);
			e.printStackTrace();
			return false;
		}
		return true;

	}
	
	public void createReportsByJSON(String JSONFilePath) {
		String[] argument = {JSONFilePath};
		ReportApp.start(argument);
		//logger.info("开始打印了");
	}
	
	
	
	
	

	/*Getters and Setters*/
	public void setTParamsMap (Map<String, Object> map) {
		this.tParamsMap = map;
	}

	public Integer getIx() {
		return ix;
	}

	public void setIx(Integer ix) {
		this.ix = ix;
	}

	public String[] getExportFileName1() {
		return exportFileName1;
	}

	public void setExportFileName1(String[] exportFileName1) {
		this.exportFileName1 = exportFileName1;
	}

	public String[] getExportPortCode1() {
		return exportPortCode1;
	}

	public void setExportPortCode1(String[] exportPortCode1) {
		this.exportPortCode1 = exportPortCode1;
	}

	public String[] getExportDate1() {
		return exportDate1;
	}

	public void setExportDate1(String[] exportDate1) {
		this.exportDate1 = exportDate1;
	}

	public String[] getExportDate21() {
		return exportDate21;
	}

	public void setExportDate21(String[] exportDate21) {
		this.exportDate21 = exportDate21;
	}

	public Map<String, String> geFundVariables() {
		return fundVariables;
	}

	public void setFundVariables(Map<String, String> map2) {
		
		this.fundVariables = new HashMap(map2);
	}

	public String getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(String pageNumber) {
		this.pageNumber = pageNumber;
	}

	public String getDataParaString() {
		return dataParaString;
	}

	public void setDataParaString(String dataParaString) {
		this.dataParaString = dataParaString;
	}

	public String getHeaderNames_en() {
		return HeaderNames_en;
	}

	public void setHeaderNames_en(String headerNames_en) {
		HeaderNames_en = headerNames_en;
	}

	public String getHeaderNames_zh() {
		return HeaderNames_zh;
	}

	public void setHeaderNames_zh(String headerNames_zh) {
		HeaderNames_zh = headerNames_zh;
	}

	public String getModelname() {
		return modelname;
	}

	public void setModelname(String modelname) {
		this.modelname = modelname;
	}

	public String getModeFileBase() {
		return modeFileBase;
	}

	public void setModeFileBase(String modeFileBase) {
		this.modeFileBase = modeFileBase;
	}

	public String getPathRar() {
		return pathRar;
	}

	public void setPathRar(String pathRar) {
		this.pathRar = pathRar;
	}

	public String getSheetNumber() {
		return sheetNumber;
	}

	public void setSheetNumber(String sheetNumber) {
		this.sheetNumber = sheetNumber;
	}

	public HashMap<String, ReptSqlConfig> getReadXml() {
		return readXml;
	}

	public void setReadXml(HashMap<String, ReptSqlConfig> readXml) {
		this.readXml = readXml;
	}

	public String getJsonFilePath() {
		return jsonFilePath;
	}

	public void setJsonFilePath(String jsonFilePath) {
		this.jsonFilePath = jsonFilePath;
	}

	public HashMap<String, String> getFundVariables() {
		return fundVariables;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}
	
	
	
}

