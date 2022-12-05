package com.swhy.xxpl.model;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

/**
 * the check result table for XinxiPilu, tuoguan and waibao
 * @author 230355
 *
 */
@Repository("rept_Disct_Chk_Rslt")
public class Rept_Disct_Chk_Rslt {

	protected Logger logger = Logger.getLogger(this.getClass());
	public final int ColumnNO = 10;
	
	private String disc_type_code;		//信息披露类型代码		#0
	private String date_no;				//日期编号				#1
	private String fund_code;			//基金编号（综合管理平台）	#2
	private String fund_name;			//基金名称				#3
	private String rept_date;			//报告日期				#4
	private String indx_src_tab;		//指标来源表名
	private String indx_src_fld;			//指标来源字段
	private String indx_name;			//指标名称				#5
	private String indx_dim;			//指标维度				#6
	private String wb_data;				//外包数据				#7
	private String tg_data;				//托管数据				#8
	private String chk_rslt_code;		//核对结果代码			#9
	private String upd_aft_data;    
	private String src_tab_date_no; 
	private String magr_no;
	
	private Object upd_sql;         
	private String upder_ip;        
	private Object MEMO;           
	public Rept_Disct_Chk_Rslt() {
		// TODO Auto-generated constructor stub
	}

	public Rept_Disct_Chk_Rslt(String fundCode, String serviceType, String dateNO) {
		this.setFund_code(fundCode);
		this.setDisc_type_code(serviceType);
		this.setDate_no(dateNO);
	}

	/**
	 * assign a map of value into a ReptDisctChkRslt. 单条数据装配
	 * @param list
	 * @return true if all the values are correctly loaded otherwise false
	 */
	public boolean assembleMapToRept_Disct_Chk_Rslt(Map<String, Object> map) {
		if ( null == map || map.size()<1) return false;							

		// get and only get the first record //
//		Map <String, Object> resultM = list.get(0);
		if(map == null) return false;
		
		// set primary values	//
		this.setDisc_type_code(String.valueOf(map.get("disc_type_code"))); 		//信息披露类型代码		#0
		this.setDate_no(String.valueOf(map.get("date_no"))); 					//日期编号				#1
		this.setFund_code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#2
		if (disc_type_code==null 	|| "".equals(disc_type_code)||				//invalid list or not enough list's elements
			date_no==null 			|| "".equals(date_no)		||
			fund_code==null 		|| "".equals(fund_code)		) return false;		
		
		// set optional values	//		
		this.setFund_name(String.valueOf(map.get("fund_name"))); 				//基金名称				#3
		this.setRept_date(String.valueOf(map.get("rept_date"))); 				//报告日期				#4
		this.setIndx_src_tab(String.valueOf(map.get("indx_src_tab"))); 			//指标来源表名
		this.setIndx_src_fld(String.valueOf(map.get("indx_src_fld"))); 			//指标来源字段
		this.setIndx_name(String.valueOf(map.get("indx_name"))); 				//指标名称				#5
		this.setIndx_dim(String.valueOf(map.get("indx_dim"))); 					//指标维度				#6
		this.setWb_data(String.valueOf(map.get("wb_data"))); 					//外包数据				#7
		this.setTg_data(String.valueOf(map.get("tg_data"))); 					//托管数据				#8
		this.setChk_rslt_code(String.valueOf(map.get("chk_rslt_code"))); 		//核对结果代码			#9		 			
		this.setUpd_aft_data(String.valueOf(map.get("upd_aft_data"))); 			//				#10		 			
		this.setSrc_tab_date_no(String.valueOf(map.get("src_tab_date_no"))); 	//				#11		 			
		this.setUpd_sql(String.valueOf(map.get("upd_sql"))); 					//				#12		 			
		this.setUpder_ip(String.valueOf(map.get("upder_ip"))); 					//				#13		 			
		this.setMEMO(String.valueOf(map.get("MEMO"))); 							//				#14		 			
		this.setMagr_no(String.valueOf(map.get("magr_no"))); 							//				#15		 			

		return true;
	}
	
	/**
	 * 装配一整个list的Rept_Disct_Chk_Rslt，
	 * @param list
	 * @return
	 */
	public static List<Rept_Disct_Chk_Rslt> assembleListToRept_Disct_Chk_Rslts (List <Map <String, Object>> list ) {
		List<Rept_Disct_Chk_Rslt> resultList = new LinkedList<Rept_Disct_Chk_Rslt>();
		for (Map <String, Object> m : list) {
			Rept_Disct_Chk_Rslt r = new Rept_Disct_Chk_Rslt();
			r.assembleMapToRept_Disct_Chk_Rslt(m);
			resultList.add(r);
		}
		return resultList;
	}
	
	/**
	 * judge if the Rept_Disct_Chk_Rslt itself valid to write into database
	 * 
	 * @return {@value: true} valid {@value: false} not valid
	 */
	public static boolean isValid(String fundCode, String serviceType, String dateNO) {
		return (	fundCode!=null 		&& 	!"".equals(fundCode) 	&& 
					serviceType!=null	&&	!"".equals(serviceType) &&
					dateNO!=null		&&	!"".equals(dateNO)		  );
	}
	
	
	/*	getters and setters */
	public String getDisc_type_code() {
		return disc_type_code;
	}

	public void setDisc_type_code(String disc_type_code) {
		this.disc_type_code = disc_type_code;
	}

	public String getDate_no() {
		return date_no;
	}

	public void setDate_no(String date_no) {
		this.date_no = date_no;
	}

	public String getFund_code() {
		return fund_code;
	}

	public void setFund_code(String fund_code) {
		this.fund_code = fund_code;
	}

	public String getFund_name() {
		return fund_name;
	}

	public void setFund_name(String fund_name) {
		this.fund_name = fund_name;
	}

	public String getRept_date() {
		return rept_date;
	}

	public void setRept_date(String rept_date) {
		this.rept_date = rept_date;
	}

	public String getIndx_name() {
		return indx_name;
	}

	public void setIndx_name(String indx_name) {
		this.indx_name = indx_name;
	}

	public String getIndx_dim() {
		return indx_dim;
	}

	public void setIndx_dim(String indx_dim) {
		this.indx_dim = indx_dim;
	}

	public String getWb_data() {
		return wb_data;
	}

	public void setWb_data(String wb_data) {
		this.wb_data = wb_data;
	}

	public String getTg_data() {
		return tg_data;
	}

	public void setTg_data(String tg_data) {
		this.tg_data = tg_data;
	}

	public String getChk_rslt_code() {
		return chk_rslt_code;
	}

	public void setChk_rslt_code(String chk_rslt_code) {
		this.chk_rslt_code = chk_rslt_code;
	}

	public String getUpd_aft_data() {
		return upd_aft_data;
	}

	public void setUpd_aft_data(String upd_aft_data) {
		this.upd_aft_data = upd_aft_data;
	}

	public String getSrc_tab_date_no() {
		return src_tab_date_no;
	}

	public void setSrc_tab_date_no(String src_tab_date_no) {
		this.src_tab_date_no = src_tab_date_no;
	}

	public Object getUpd_sql() {
		return upd_sql;
	}

	public void setUpd_sql(Object upd_sql) {
		this.upd_sql = upd_sql;
	}

	public String getUpder_ip() {
		return upder_ip;
	}

	public void setUpder_ip(String upder_ip) {
		this.upder_ip = upder_ip;
	}

	public Object getMEMO() {
		return MEMO;
	}

	public void setMEMO(Object mEMO) {
		MEMO = mEMO;
	}

	public int getColumnNO() {
		return ColumnNO;
	}

	public String getIndx_src_tab() {
		return indx_src_tab;
	}

	public void setIndx_src_tab(String indx_src_tab) {
		this.indx_src_tab = indx_src_tab;
	}

	public String getIndx_src_fld() {
		return indx_src_fld;
	}

	public void setIndx_src_fld(String indx_src_fld) {
		this.indx_src_fld = indx_src_fld;
	}

	public String getMagr_no() {
		return magr_no;
	}

	public void setMagr_no(String magr_no) {
		this.magr_no = magr_no;
	}
	
	
	
	
	
	
}
