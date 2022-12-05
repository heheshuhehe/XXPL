package com.swhy.xxpl.model.jibao;

import java.math.BigDecimal;

/**
 * 
 * @author 230355
 *
 */
public class Rept_qu_brek_risk_bond_info {

private String	fund_code                      ;
private String	info_src_code                  ;
private String qut_no                          ;
private String c_pord_code                     ;
private BigDecimal	hold_brek_bond_num         ;
private BigDecimal	hold_risk_bond_num         ;
private Object	brek_risk_bond_afct            ;
private Object	brek_risk_bond_disp            ;

	
	public Rept_qu_brek_risk_bond_info() {
		// TODO Auto-generated constructor stub
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


	public BigDecimal getHold_brek_bond_num() {
		return hold_brek_bond_num;
	}


	public void setHold_brek_bond_num(BigDecimal hold_brek_bond_num) {
		this.hold_brek_bond_num = hold_brek_bond_num;
	}


	public BigDecimal getHold_risk_bond_num() {
		return hold_risk_bond_num;
	}


	public void setHold_risk_bond_num(BigDecimal hold_risk_bond_num) {
		this.hold_risk_bond_num = hold_risk_bond_num;
	}


	public Object getBrek_risk_bond_afct() {
		return brek_risk_bond_afct;
	}


	public void setBrek_risk_bond_afct(Object brek_risk_bond_afct) {
		this.brek_risk_bond_afct = brek_risk_bond_afct;
	}


	public Object getBrek_risk_bond_disp() {
		return brek_risk_bond_disp;
	}


	public void setBrek_risk_bond_disp(Object brek_risk_bond_disp) {
		this.brek_risk_bond_disp = brek_risk_bond_disp;
	}
	
	
	

}
