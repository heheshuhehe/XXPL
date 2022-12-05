package com.swhy.xxpl.model.hsr;

/**
 * 管理人报告指标(股权半年报)
 * @author 230355
 */
public class Rept_HSR_magr_rept_indx {

	public Rept_HSR_magr_rept_indx() {
		// TODO Auto-generated constructor stub
	}

	String fund_code          ;//基金编号（综合管理平台）
	String info_src_code      ;//信息来源代码
	String date_no            ;//日期编号
	String c_pord_code        ;//账套号（外包）
	String indx_code          ;//指标代码
	String indx_name          ;//指标名称
	String indx_valu          ;//指标值
	
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
	public String getIndx_code() {
		return indx_code;
	}
	public void setIndx_code(String indx_code) {
		this.indx_code = indx_code;
	}
	public String getIndx_name() {
		return indx_name;
	}
	public void setIndx_name(String indx_name) {
		this.indx_name = indx_name;
	}
	public String getIndx_valu() {
		return indx_valu;
	}
	public void setIndx_valu(String indx_valu) {
		this.indx_valu = indx_valu;
	}
	
	
	
	
}
