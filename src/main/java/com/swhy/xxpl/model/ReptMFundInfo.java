package com.swhy.xxpl.model;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.fh.dao.XinxipiluDao;
import com.fh.util.DaoUtil;
/** 
 * @author chenlin
 * 
 */
@Repository("reptMFundInfo")
public class ReptMFundInfo {
	protected Logger logger = Logger.getLogger(this.getClass());
	
//	@Resource(name = "datasourceXXPLTG")	//恒生托管 数据库
//	DataSource dsXXPLTG; 
	
	@Resource(name = "datasourceXXPLHD")	//核对 应用数据库
	DataSource dsXXPLHD; 
	
	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXinPiLuDao;
	
	// 基金编号（综合管理平台） 
	private String fund_code; 

	// 信息来源代码
	private String info_src_code; 

	// 月编号
	private String mth_no; 

	// 账套号
	private String c_port_code; 
    
	// 基金名称
	private String fund_name; 

	// 基金编码(协会编码） 
	private String fund_num; 

	// 基金运作方式 
	private String fund_oper_mode; 

	// 基金类别
	private String fund_clas; 

	// 基金管理人 
	private String fund_magr; 

	// 投资顾问（如有）
	private String ivsm_advr; 

	// 基金托管人 
	private String fund_trus; 

	// 基金成立日期 
	private String fund_setp_date; 

	// 基金到期日期 
	private String fund_matu_date; 

	// 信息披露报告是否经托管机构复核
	private String is_cstd_chk; 

	// 备注 
	private String memo;
	public ReptMFundInfo(){}
	public ReptMFundInfo(String waibaoOrTuoguan) {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 将读取原始数据库中的一行record（map） 装配进所有属性
	 * @param map
	 */
	public void assembleMapToReptMFundInfo (Map<String, Object> map) {
		
		// set primary values	//
		this.setFund_code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#0
		this.setInfo_src_code(String.valueOf(map.get("info_src_code"))); 		//信息来源代码			#1
		this.setMth_no(String.valueOf(map.get("mth_no"))); 						//月编号				#2
		// set optional values
		this.setC_port_code(String.valueOf(map.get("c_port_code"))); 			//账套号				#3
		this.setFund_name(String.valueOf(map.get("fund_name"))); 				//基金名称				#4
		this.setFund_num(String.valueOf(map.get("fund_num"))); 					//基金编码(协会编码) 		#5
		this.setFund_oper_mode(String.valueOf(map.get("fund_oper_mode"))); 		//基金运作方式 			#6
		this.setFund_clas(String.valueOf(map.get("fund_clas"))); 				//基金类别				#7
		this.setFund_magr(String.valueOf(map.get("fund_magr"))); 				//基金管理人			#8
		this.setIvsm_advr(String.valueOf(map.get("ivsm_advr"))); 				//投资顾问（如有）		#9
		this.setFund_trus(String.valueOf(map.get("fund_trus"))); 				//基金托管人 			#10
		this.setFund_setp_date(String.valueOf(map.get("fund_setp_date"))); 		//基金成立日期 			#11
		this.setFund_matu_date(String.valueOf(map.get("fund_matu_date"))); 		//基金到期日期  		#12
		this.setIs_cstd_chk(String.valueOf(map.get("is_cstd_chk"))); 			//信息披露报告是否经托管机构复核  #13
	}
	
	/**
	 * 生成一套帐的数据
	 * @param  fund_code 综合平台的基金编码 
	 * @return 生成的数据记录数 
	 */
	public int generateData(String fund_code) {
		//TODO 
		return 0 ; 
	} 
	
	/**
	 * @param  fund_code 综合平台的基金编码   
	 * @return 返回一个基金信息对象 
	 */
	public ReptMFundInfo selectOne(String  fund_code) {
		//TODO 
		return null;
	}
	
	// /*** get and set  */ 
	public String getFund_code() {
		return fund_code;
	}

	public void setFund_code(String fund_code) {
		this.fund_code = fund_code;
	}

	public String getInfo_src_code() {
		return info_src_code;
	}

	public void setInfo_src_code(String info_src_code) {
		this.info_src_code = info_src_code;
	}

	public String getMth_no() {
		return mth_no;
	}

	public void setMth_no(String mth_no) {
		this.mth_no = mth_no;
	}

	public String getC_port_code() {
		return c_port_code;
	}

	public void setC_port_code(String c_port_code) {
		this.c_port_code = c_port_code;
	}

	public String getFund_name() {
		return fund_name;
	}

	public void setFund_name(String fund_name) {
		this.fund_name = fund_name;
	}

	public String getFund_num() {
		return fund_num;
	}

	public void setFund_num(String fund_num) {
		this.fund_num = fund_num;
	}

	public String getFund_oper_mode() {
		return fund_oper_mode;
	}

	public void setFund_oper_mode(String fund_oper_mode) {
		this.fund_oper_mode = fund_oper_mode;
	}

	public String getFund_clas() {
		return fund_clas;
	}

	public void setFund_clas(String fund_clas) {
		this.fund_clas = fund_clas;
	}

	public String getFund_magr() {
		return fund_magr;
	}

	public void setFund_magr(String fund_magr) {
		this.fund_magr = fund_magr;
	}

	public String getIvsm_advr() {
		return ivsm_advr;
	}

	public void setIvsm_advr(String ivsm_advr) {
		this.ivsm_advr = ivsm_advr;
	}

	public String getFund_trus() {
		return fund_trus;
	}

	public void setFund_trus(String fund_trus) {
		this.fund_trus = fund_trus;
	}

	public String getFund_setp_date() {
		return fund_setp_date;
	}

	public void setFund_setp_date(String fund_setp_date) {
		this.fund_setp_date = fund_setp_date;
	}

	public String getFund_matu_date() {
		return fund_matu_date;
	}

	public void setFund_matu_date(String fund_matu_date) {
		this.fund_matu_date = fund_matu_date;
	}

	public String getIs_cstd_chk() {
		return is_cstd_chk;
	}

	public void setIs_cstd_chk(String is_cstd_chk) {
		this.is_cstd_chk = is_cstd_chk;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	} 
	
	public void testing () {
		/*
		 * Connection con1 = null; try { con1 = da.getConnection(); List<Map<String,
		 * Object>> list = DaoUtil.getResultToList(con1,
		 * "select * from TGCBS.TFXFJJJDZGX", null); logger.info(list.toString()); }
		 * catch (SQLException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); logger.error(e); } finally { DaoUtil.release(con1); }
		 */
	}
     
}
