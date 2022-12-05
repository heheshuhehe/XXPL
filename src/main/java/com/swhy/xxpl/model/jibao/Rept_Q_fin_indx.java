package com.swhy.xxpl.model.jibao;

import java.math.BigDecimal;

/**
 * 主要财务指标(季报)
 * @author 230355
 *
 */
public class Rept_Q_fin_indx {

	private String fund_code      ;        		//基金编号（综合管理平台）
	private String info_src_code  ;             //信息来源代码
	private String qut_no         ;             //季度编号
	private String c_pord_code    ;             //账套号（外包）
	private BigDecimal onum       ;             //序号
	private String cifd_fund_flag ;             //分级基金标志
	private String cifd_fund_no   ;             //分级基金编号
	private String cifd_fund_name   ;             //分级基金名称
	private String begn_date      ;             //起始日期
	private String exp_date       ;             //截至日期
	private BigDecimal cpd_payf       ;             //本期已实现收益
	private BigDecimal cpd_prof       ;             //本期利润
	private BigDecimal end_net_ast    ;             //期末基金净资产
	private BigDecimal end_unit_net_val;             //报告期期末单位净值
	private Object memo           ;             //备注
	
	public Rept_Q_fin_indx() {
		// TODO Auto-generated constructor stub
	}
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

	public String getQut_no() {
		return qut_no;
	}

	public void setQut_no(String qut_no) {
		this.qut_no = qut_no;
	}

	public String getC_pord_code() {
		return c_pord_code;
	}

	public void setC_pord_code(String c_pord_code) {
		this.c_pord_code = c_pord_code;
	}

	public BigDecimal getOnum() {
		return onum;
	}

	public void setOnum(BigDecimal onum) {
		this.onum = onum;
	}

	public String getCifd_fund_flag() {
		return cifd_fund_flag;
	}

	public void setCifd_fund_flag(String cifd_fund_flag) {
		this.cifd_fund_flag = cifd_fund_flag;
	}

	public String getCifd_fund_no() {
		return cifd_fund_no;
	}

	public void setCifd_fund_no(String cifd_fund_no) {
		this.cifd_fund_no = cifd_fund_no;
	}

	public String getBegn_date() {
		return begn_date;
	}

	public void setBegn_date(String begn_date) {
		this.begn_date = begn_date;
	}

	public String getExp_date() {
		return exp_date;
	}

	public void setExp_date(String exp_date) {
		this.exp_date = exp_date;
	}

	public BigDecimal getCpd_payf() {
		return cpd_payf;
	}

	public void setCpd_payf(BigDecimal cpd_payf) {
		this.cpd_payf = cpd_payf;
	}

	public BigDecimal getCpd_prof() {
		return cpd_prof;
	}

	public void setCpd_prof(BigDecimal cpd_prof) {
		this.cpd_prof = cpd_prof;
	}

	public BigDecimal getEnd_net_ast() {
		return end_net_ast;
	}

	public void setEnd_net_ast(BigDecimal end_net_ast) {
		this.end_net_ast = end_net_ast;
	}

	public BigDecimal getEnd_unit_net_val() {
		return end_unit_net_val;
	}

	public void setEnd_unit_net_val(BigDecimal end_unit_net_val) {
		this.end_unit_net_val = end_unit_net_val;
	}

	public Object getMemo() {
		return memo;
	}

	public void setMemo(Object memo) {
		this.memo = memo;
	}
	public String getCifd_fund_name() {
		return cifd_fund_name;
	}
	public void setCifd_fund_name(String cifd_fund_name) {
		this.cifd_fund_name = cifd_fund_name;
	}




}
