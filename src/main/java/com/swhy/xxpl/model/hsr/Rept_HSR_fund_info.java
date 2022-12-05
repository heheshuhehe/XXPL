package com.swhy.xxpl.model.hsr;

import java.math.BigDecimal;

import com.mysql.jdbc.Clob;

//基金基本情况(股权半年报)
public class Rept_HSR_fund_info {

	public Rept_HSR_fund_info() {
		// TODO Auto-generated constructor stub
	}

	String fund_code;			//基金编号（综合管理平台）
	String info_src_code;		//信息来源代码
	String date_no;				//日期编号
	String c_pord_code;			//账套号（外包）
	String fund_name;			//基金名称
	String fund_num;			//基金编码
	String fund_type;			//基金类型
	String fund_reg;			//基金注册地
	String fund_setp_date;		//基金成立日期
	String fund_matu_date;		//基金到期日期
	BigDecimal prin_amt;		//认缴金额（如有）
	BigDecimal end_fund_shr;	//期末基金实缴总额（万元）/期末基金总份额（万份）
	Clob 	valu_way;			//估值方法
	BigDecimal 		end_tot_ast;	//期末总资产
	BigDecimal 		end_net_ast;	//期末净资产
	String 	ivsm_mngr;			//投资经理或投资决策人
	BigDecimal		ivst_vol;		//投资者数量
	String	is_cstd_chk;		//信息披露报告是否经托管机构复核
	
	
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
	public String getFund_type() {
		return fund_type;
	}
	public void setFund_type(String fund_type) {
		this.fund_type = fund_type;
	}
	public String getFund_reg() {
		return fund_reg;
	}
	public void setFund_reg(String fund_reg) {
		this.fund_reg = fund_reg;
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
	public BigDecimal getPrin_amt() {
		return prin_amt;
	}
	public void setPrin_amt(BigDecimal prin_amt) {
		this.prin_amt = prin_amt;
	}
	public BigDecimal getEnd_fund_shr() {
		return end_fund_shr;
	}
	public void setEnd_fund_shr(BigDecimal end_fund_shr) {
		this.end_fund_shr = end_fund_shr;
	}
	public Clob getValu_way() {
		return valu_way;
	}
	public void setValu_way(Clob valu_way) {
		this.valu_way = valu_way;
	}
	public BigDecimal getEnd_tot_ast() {
		return end_tot_ast;
	}
	public void setEnd_tot_ast(BigDecimal end_tot_ast) {
		this.end_tot_ast = end_tot_ast;
	}
	public BigDecimal getEnd_net_ast() {
		return end_net_ast;
	}
	public void setEnd_net_ast(BigDecimal end_net_ast) {
		this.end_net_ast = end_net_ast;
	}
	public String getIvsm_mngr() {
		return ivsm_mngr;
	}
	public void setIvsm_mngr(String ivsm_mngr) {
		this.ivsm_mngr = ivsm_mngr;
	}
	public BigDecimal getIvst_vol() {
		return ivst_vol;
	}
	public void setIvst_vol(BigDecimal ivst_vol) {
		this.ivst_vol = ivst_vol;
	}
	public String getIs_cstd_chk() {
		return is_cstd_chk;
	}
	public void setIs_cstd_chk(String is_cstd_chk) {
		this.is_cstd_chk = is_cstd_chk;
	}

	
	
	
	
}
