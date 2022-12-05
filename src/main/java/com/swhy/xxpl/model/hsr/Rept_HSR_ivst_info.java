package com.swhy.xxpl.model.hsr;

/**
 * 基金投资者情况(股权半年报)
 * @author 230355
 *
 */
public class Rept_HSR_ivst_info {

	public Rept_HSR_ivst_info() {
		// TODO Auto-generated constructor stub
	}

	String	fund_code		;//基金编号（综合管理平台）
	String	info_src_code	;//信息来源代码
	String	date_no			;//日期编号
	String	c_pord_code		;//账套号（外包）
	String	ivst_no			;//投资者编号
	java.math.BigDecimal	onum			;//序号
	String  ivst_name		;//投资者名称
	String	ivst_type		;//投资者类型
	java.math.BigDecimal	prin_amt		;//认缴出资
	java.math.BigDecimal	pdin_scal		;//实缴出资
	
	
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
	public String getIvst_no() {
		return ivst_no;
	}
	public void setIvst_no(String ivst_no) {
		this.ivst_no = ivst_no;
	}
	public java.math.BigDecimal getOnum() {
		return onum;
	}
	public void setOnum(java.math.BigDecimal onum) {
		this.onum = onum;
	}
	public String getIvst_name() {
		return ivst_name;
	}
	public void setIvst_name(String ivst_name) {
		this.ivst_name = ivst_name;
	}
	public String getIvst_type() {
		return ivst_type;
	}
	public void setIvst_type(String ivst_type) {
		this.ivst_type = ivst_type;
	}
	public java.math.BigDecimal getPrin_amt() {
		return prin_amt;
	}
	public void setPrin_amt(java.math.BigDecimal prin_amt) {
		this.prin_amt = prin_amt;
	}
	public java.math.BigDecimal getPdin_scal() {
		return pdin_scal;
	}
	public void setPdin_scal(java.math.BigDecimal pdin_scal) {
		this.pdin_scal = pdin_scal;
	}

	
	
}
