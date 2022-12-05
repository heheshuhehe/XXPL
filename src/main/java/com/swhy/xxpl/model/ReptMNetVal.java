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

import com.fh.util.Const;
import com.fh.util.DaoUtil;
import com.fh.util.sql.SqlCommonUtil;

@Repository("reptMNetVal")
public class ReptMNetVal {
	public final int ColumnNO = 9;
	
	protected transient Logger logger = Logger.getLogger(this.getClass());
	
//	@Resource(name = "datasourceXXPLTG") // 恒生托管 数据库
//	DataSource dsXXPLTG;

	@Resource(name = "datasourceXXPLHD") // 核对 应用数据库
	DataSource dsXXPLHD;

	// 外包或托管
	//private transient String waiBaoOrTuoGuan;

	// 基金编号（综合管理平台）
	private transient String fund_code;
	// 信息来源代码
	private transient String info_src_code;
	// 月编号
	private String mth_no;
	// 账套号
	private String c_port_code;
	// 估值日期
	private String valu_date;
	// 份额净值
	private java.math.BigDecimal shr_net_val;
	// 份额累计净值
	private java.math.BigDecimal shr_aggr_net_val;
	// 基金份额总额(份)
	private java.math.BigDecimal fund_shr_gamt;
	// 基金资产净值
	private java.math.BigDecimal fund_nav;


	/* Getters and Setters */
//	public Logger getLogger() {
//		return logger;
//	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}



	public DataSource getDsXXPLHD() {
		return dsXXPLHD;
	}

	public void setDsXXPLHD(DataSource dsXXPLHD) {
		this.dsXXPLHD = dsXXPLHD;
	}

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

	/**
	 * constructor that if waibao or tuoguan is not decided
	 * 
	 */
	public ReptMNetVal() {
//		this.waiBaoOrTuoGuan = null;
	}

	/**
	 * constructor that if waibao or tuoguan is decided for this model
	 * 
	 * @param isWaiBao true: WaiBao, false: TuanGuan
	 */
	public ReptMNetVal(String WOrT) {
//		this.waiBaoOrTuoGuan = WOrT;
	}

//	public boolean isWaiBao() {
//		return com.fh.util.Const.WAIBAO == this.waiBaoOrTuoGuan;
//	}
//
//	public boolean isTuoGuan() {
//		return com.fh.util.Const.TUOGUAN == this.waiBaoOrTuoGuan;
//	}

	public static boolean isValid(String s) {
		return (null != s && "" != s);
	}

	/**
	 * judge if the reptMNetVal itself valid to write into database
	 * 
	 * @return {@value: true} valid {@value: false} not valid
	 */
	public boolean isValid() {
		return  ReptMNetVal.isValid(this.fund_code);

	}

	/**
	 * ##Not Finished 在数据库中更新月报的信息
	 * 
	 * @return true: 更新成功， false: 更新失败
	 */
	public boolean updateToDatabase() {
		/* 1. 判断该基金是否具备条件写入数据库 */
		if (!this.isValid())
			return false;

		/* 2. 打开数据库链接 */
		Connection con = null;
		try {
			con = dsXXPLHD.getConnection();
			List<Map<String, Object>> list = DaoUtil.getResultToList(con, "update * from TGCBS.TFXFJJJDZGX", null);
			logger.info(list.toString());
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return false;
		} finally {
			DaoUtil.release(con);
		}
		return true;
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
		// set optional values
		this.setC_port_code(String.valueOf(map.get("c_port_code"))); 			//账套号				#3
		this.setValu_date(String.valueOf(map.get("valu_date"))); 				//估值日期				#4
		this.setShr_net_val((java.math.BigDecimal)map.get("shr_net_val")); 		//份额净值 			#5
		this.setShr_aggr_net_val((java.math.BigDecimal)map.get("shr_aggr_net_val")); //份额累计净值			#6
		this.setFund_shr_gamt((java.math.BigDecimal)map.get("fund_shr_gamt")); 	//基金份额总额(份)		#7
		this.setFund_nav((java.math.BigDecimal)map.get("fund_nav")); 			//基金资产净值			#8
	}

	@Test
	public void testing() throws IOException, Exception {
		
	}
}
