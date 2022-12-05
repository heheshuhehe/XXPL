package com.swhy.xxpl.model.hsr;

import java.math.BigDecimal;

/**
 * 其他费用明细(股权半年报)
 * @author 230355
 */
public class Rept_HSR_oth_fee_dtl {

	public Rept_HSR_oth_fee_dtl() {
		// TODO Auto-generated constructor stub
	}
	String fund_code             ;//基金编号（综合管理平台）
	String info_src_code         ;//信息来源代码
	String date_no               ;//日期编号
	String c_pord_code           ;//账套号
	String oth_fee_name          ;//其他费用名称
	BigDecimal pd_fee                ;//当期费用
	BigDecimal aggr_fee              ;//产品成立以来累计费用
	
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
	public String getDate_no() {
		return date_no;
	}
	public void setDate_no(String date_no) {
		this.date_no = date_no;
	}
	public String getC_pord_code() {
		return c_pord_code;
	}
	public void setC_pord_code(String c_pord_code) {
		this.c_pord_code = c_pord_code;
	}
	public String getOth_fee_name() {
		return oth_fee_name;
	}
	public void setOth_fee_name(String oth_fee_name) {
		this.oth_fee_name = oth_fee_name;
	}
	public BigDecimal getPd_fee() {
		return pd_fee;
	}
	public void setPd_fee(BigDecimal pd_fee) {
		this.pd_fee = pd_fee;
	}
	public BigDecimal getAggr_fee() {
		return aggr_fee;
	}
	public void setAggr_fee(BigDecimal aggr_fee) {
		this.aggr_fee = aggr_fee;
	}


}
