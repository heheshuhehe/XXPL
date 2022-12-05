package com.swhy.xxpl.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import com.fh.dao.XinxipiluDao;
import com.fh.util.Const;
import com.fh.util.DaoUtil;
import com.fh.util.sql.SqlCommonUtil;

@Repository("reptMNetVal_Cifd")
public class ReptMNetVal_Cifd {
	protected Logger logger = Logger.getLogger(this.getClass());


	
//	@Resource(name = "datasourceXXPLTG") 	// 恒生托管 数据库
//	DataSource dsXXPLTG;

	@Resource(name = "datasourceXXPLHD") 	// 核对 应用数据库
	DataSource dsXXPLHD;
	
	private transient String fund_code;		//基金编号（综合管理平台）	#0
	private transient String info_src_code;	//信息来源代码			#1
	private String mth_no;					//月编号				#2
	private String c_port_code;				//账套号				#3
	private String subf_code;				//子基金代码			#4
	private String shr_clas;				//份额类别				#5
	private String subf_name;				//子基金名称			#6
	private String valu_date; 				//估值日期				#7
	private java.math.BigDecimal shr_net_val;//份额净值			#8
	private java.math.BigDecimal shr_aggr_net_val;//份额累计净值	#9
	private java.math.BigDecimal fund_shr_gamt;//基金份额总额(份)	#10
	private java.math.BigDecimal fund_nav;	//基金资产净值			#11

	/**
	 * constructor that if waibao or tuoguan is not decided
	 * 
	 */
	public ReptMNetVal_Cifd() {
//		this.waiBaoOrTuoGuan = null;
	}

	/**
	 * constructor that if waibao or tuoguan is decided for this model
	 * 
	 * @param isWaiBao true: WaiBao, false: TuanGuan
	 */
	public ReptMNetVal_Cifd(String WOrT) {
//		this.waiBaoOrTuoGuan = WOrT;
	}

	public static boolean isValid(String s) {
		return (null != s && "" != s);
	}

	/**
	 * judge if the reptMNetVal itself valid to write into database
	 * 
	 * @return {@value: true} valid {@value: false} not valid
	 */
	public boolean isValid() {
		return  ReptMNetVal_Cifd.isValid(this.fund_code);

	}


	/**
	 * 将读取原始数据库中的一行record（map） 装配进ReptMNetVal的所有属性
	 * @param map
	 */
	public void assembleMapToReptMNetVal (Map<String, Object> map) {
		
		// set primary values	//
		this.setFund_code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#0
		this.setInfo_src_code(String.valueOf(map.get("info_src_code"))); 		//信息来源代码			#1
		this.setMth_no(String.valueOf(map.get("mth_no"))); 						//月编号				#2
		
		// set optional values	//
		this.setC_port_code(String.valueOf(map.get("c_port_code"))); 			//账套号				#3
		this.setSubf_code(String.valueOf(map.get("subf_code"))); 				//估值日期				#4
		this.setShr_clas(String.valueOf(map.get("shr_clas"))); 					//份额类别 			#5
		this.setSubf_name(String.valueOf(map.get("subf_name")));				//子基金名称			#6
		this.setValu_date(String.valueOf(map.get("valu_date")) ); 				//估值日期				#7
		this.setShr_net_val((java.math.BigDecimal)map.get("shr_net_val")); 		//份额净值				#8
		this.setShr_aggr_net_val((java.math.BigDecimal)map.get("shr_aggr_net_val"));//份额累计净值		#9
		this.setFund_shr_gamt((java.math.BigDecimal)map.get("fund_shr_gamt"));	//基金份额总额(份)		#10
		this.setFund_nav((java.math.BigDecimal)map.get("fund_nav"));			//基金资产净值			#11
	}
	
	@Test
	public void testing() throws IOException, Exception {}

	/* Getters and Setters */	
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

	public String getSubf_code() {
		return subf_code;
	}

	public void setSubf_code(String subf_code) {
		this.subf_code = subf_code;
	}

	public String getShr_clas() {
		return shr_clas;
	}

	public void setShr_clas(String shr_clas) {
		this.shr_clas = shr_clas;
	}

	public String getSubf_name () {
		return subf_name;
	}
	
	public void setSubf_name(String subf_name) {
		this.subf_name = subf_name;
	}
	
	public String getValu_date() {
		return valu_date;
	}

	public void setValu_date(String valu_date) {
		this.valu_date = valu_date;
	}

	public java.math.BigDecimal getShr_net_val() {
		return shr_net_val;
	}

	public void setShr_net_val(java.math.BigDecimal shr_net_val) {
		this.shr_net_val = shr_net_val;
	}

	public java.math.BigDecimal getShr_aggr_net_val() {
		return shr_aggr_net_val;
	}

	public void setShr_aggr_net_val(java.math.BigDecimal shr_aggr_net_val) {
		this.shr_aggr_net_val = shr_aggr_net_val;
	}

	public java.math.BigDecimal getFund_shr_gamt() {
		return fund_shr_gamt;
	}

	public void setFund_shr_gamt(java.math.BigDecimal fund_shr_gamt) {
		this.fund_shr_gamt = fund_shr_gamt;
	}

	public java.math.BigDecimal getFund_nav() {
		return fund_nav;
	}

	public void setFund_nav(java.math.BigDecimal fund_nav) {
		this.fund_nav = fund_nav;
	}

	
	
	

}
