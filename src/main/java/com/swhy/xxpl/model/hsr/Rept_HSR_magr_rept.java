package com.swhy.xxpl.model.hsr;

import oracle.sql.CLOB;
import oracle.sql.DATE;

//管理人报告(股权半年报)
public class Rept_HSR_magr_rept {

	public Rept_HSR_magr_rept() {
		// TODO Auto-generated constructor stub
	}

	String fund_code                         ;//基金编号（综合管理平台）
	String info_src_code                     ;//信息来源代码
	String date_no                           ;//日期编号
	String c_pord_code                       ;//账套号
	CLOB magr_rept                         ;//管理人报告
	CLOB rpd_pers_expr                     ;//报告期内高管、基金经理及其关联基金经验
	CLOB fund_oper_comp_trus_situ          ;//高管人员变动情况
	CLOB fivsm_stra                        ;//基金运作遵规守信情况
	CLOB fund_perf_perf                    ;//基金投资策略
	CLOB mkt_indt_pros                     ;//基金业绩表现
	CLOB inr_supr_audt_work                ;//对宏观经济、证券市场及其行业走势展望
	CLOB fund_valu_proc                    ;//内部基金监察稽核工作
	CLOB fund_oper_levg_situ               ;//基金估值程序
	CLOB ivsm_payf_loss_assu_situ          ;//基金运作情况和运用杠杆情况
	CLOB cpa_firm_audt_rept                ;//投资收益分配和损失承担情况
	CLOB fund_hold_num_warn                ;//项目上市进展情况
	CLOB fund_nav_warn                     ;//可能存在的利益冲突
	CLOB posb_confl_intr                   ;//关于基金负债以及潜在负债或担保的简要说明
	CLOB fund_oper_comp_trus_situ_first    ;//基金运作遵规守信情况（最初的）
	DATE upd_date                          ;//修改时间
	String chk_prsn                          ;//核对人
	String vilt_type_code                    ;//违规类型代码
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
	public CLOB getMagr_rept() {
		return magr_rept;
	}
	public void setMagr_rept(CLOB magr_rept) {
		this.magr_rept = magr_rept;
	}
	public CLOB getRpd_pers_expr() {
		return rpd_pers_expr;
	}
	public void setRpd_pers_expr(CLOB rpd_pers_expr) {
		this.rpd_pers_expr = rpd_pers_expr;
	}
	public CLOB getFund_oper_comp_trus_situ() {
		return fund_oper_comp_trus_situ;
	}
	public void setFund_oper_comp_trus_situ(CLOB fund_oper_comp_trus_situ) {
		this.fund_oper_comp_trus_situ = fund_oper_comp_trus_situ;
	}
	public CLOB getFivsm_stra() {
		return fivsm_stra;
	}
	public void setFivsm_stra(CLOB fivsm_stra) {
		this.fivsm_stra = fivsm_stra;
	}
	public CLOB getFund_perf_perf() {
		return fund_perf_perf;
	}
	public void setFund_perf_perf(CLOB fund_perf_perf) {
		this.fund_perf_perf = fund_perf_perf;
	}
	public CLOB getMkt_indt_pros() {
		return mkt_indt_pros;
	}
	public void setMkt_indt_pros(CLOB mkt_indt_pros) {
		this.mkt_indt_pros = mkt_indt_pros;
	}
	public CLOB getInr_supr_audt_work() {
		return inr_supr_audt_work;
	}
	public void setInr_supr_audt_work(CLOB inr_supr_audt_work) {
		this.inr_supr_audt_work = inr_supr_audt_work;
	}
	public CLOB getFund_valu_proc() {
		return fund_valu_proc;
	}
	public void setFund_valu_proc(CLOB fund_valu_proc) {
		this.fund_valu_proc = fund_valu_proc;
	}
	public CLOB getFund_oper_levg_situ() {
		return fund_oper_levg_situ;
	}
	public void setFund_oper_levg_situ(CLOB fund_oper_levg_situ) {
		this.fund_oper_levg_situ = fund_oper_levg_situ;
	}
	public CLOB getIvsm_payf_loss_assu_situ() {
		return ivsm_payf_loss_assu_situ;
	}
	public void setIvsm_payf_loss_assu_situ(CLOB ivsm_payf_loss_assu_situ) {
		this.ivsm_payf_loss_assu_situ = ivsm_payf_loss_assu_situ;
	}
	public CLOB getCpa_firm_audt_rept() {
		return cpa_firm_audt_rept;
	}
	public void setCpa_firm_audt_rept(CLOB cpa_firm_audt_rept) {
		this.cpa_firm_audt_rept = cpa_firm_audt_rept;
	}
	public CLOB getFund_hold_num_warn() {
		return fund_hold_num_warn;
	}
	public void setFund_hold_num_warn(CLOB fund_hold_num_warn) {
		this.fund_hold_num_warn = fund_hold_num_warn;
	}
	public CLOB getFund_nav_warn() {
		return fund_nav_warn;
	}
	public void setFund_nav_warn(CLOB fund_nav_warn) {
		this.fund_nav_warn = fund_nav_warn;
	}
	public CLOB getPosb_confl_intr() {
		return posb_confl_intr;
	}
	public void setPosb_confl_intr(CLOB posb_confl_intr) {
		this.posb_confl_intr = posb_confl_intr;
	}
	public CLOB getFund_oper_comp_trus_situ_first() {
		return fund_oper_comp_trus_situ_first;
	}
	public void setFund_oper_comp_trus_situ_first(CLOB fund_oper_comp_trus_situ_first) {
		this.fund_oper_comp_trus_situ_first = fund_oper_comp_trus_situ_first;
	}
	public DATE getUpd_date() {
		return upd_date;
	}
	public void setUpd_date(DATE upd_date) {
		this.upd_date = upd_date;
	}
	public String getChk_prsn() {
		return chk_prsn;
	}
	public void setChk_prsn(String chk_prsn) {
		this.chk_prsn = chk_prsn;
	}
	public String getVilt_type_code() {
		return vilt_type_code;
	}
	public void setVilt_type_code(String vilt_type_code) {
		this.vilt_type_code = vilt_type_code;
	}

	
	
}
