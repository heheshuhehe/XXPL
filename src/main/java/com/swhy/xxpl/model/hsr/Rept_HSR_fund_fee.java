package com.swhy.xxpl.model.hsr;

import java.math.BigDecimal;
import java.sql.Clob;

/**
 * 基金费用(股权半年报)
 * @author 230355
 */
public class Rept_HSR_fund_fee {

	public Rept_HSR_fund_fee() {
		// TODO Auto-generated constructor stub
	}

	String fund_code             	;//基金编号（综合管理平台）
	String info_src_code         	;//信息来源代码
	String date_no               	;//日期编号
	String c_pord_code           	;//账套号
	BigDecimal pd_aep                ;//当期管理费
	BigDecimal pd_cstd_fee           ;//当期托管费/保管费
	BigDecimal pd_perf_remu          ;//当期业绩报酬
	BigDecimal pd_oper_serv_fee      ;//当期运营服务费/外包服务费
	BigDecimal pd_ivsm_advr_fee      ;//当期投资顾问费
	BigDecimal pd_oth_fee		 ;//当期其他费用
	String pd_oth_fee_expl       ;//当期其他费用说明（指产品运作期间累计支付给律师事务所、会计师事务所等其他中介机构的费用和截至本时点已计提但未支付的其他费用的总和。不包含股票、期货及其他投资品种的交易费用。）
	BigDecimal pd_fee_sum            ;//当期费用合计
	BigDecimal aggr_aep              ;//产品成立以来累计管理费
	BigDecimal aggr_cstd_fee         ;//产品成立以来累计托管费/保管费
	BigDecimal aggr_perf_remu        ;//产品成立以来累计业绩报酬
	BigDecimal aggr_oper_serv_fee    ;//产品成立以来累计运营服务费/外包服务费
	BigDecimal aggr_ivsm_advr_fee    ;//产品成立以来累计投资顾问费
	String aggr_oth_fee_expl     	 ;//产品成立以来累计其他费用说明（指产品运作期间累计支付给律师事务所、会计师事务所等其他中介机构的费用和截至本时点已计提但未支付的其他费用的总和。不包含股票、期货及其他投资品种的交易费用。）
	BigDecimal aggr_fee_sum          ;//产品成立以来累计费用合计
	
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
	public BigDecimal getPd_aep() {
		return pd_aep;
	}
	public void setPd_aep(BigDecimal pd_aep) {
		this.pd_aep = pd_aep;
	}
	public BigDecimal getPd_cstd_fee() {
		return pd_cstd_fee;
	}
	public void setPd_cstd_fee(BigDecimal pd_cstd_fee) {
		this.pd_cstd_fee = pd_cstd_fee;
	}
	public BigDecimal getPd_perf_remu() {
		return pd_perf_remu;
	}
	public void setPd_perf_remu(BigDecimal pd_perf_remu) {
		this.pd_perf_remu = pd_perf_remu;
	}
	public BigDecimal getPd_oper_serv_fee() {
		return pd_oper_serv_fee;
	}
	public void setPd_oper_serv_fee(BigDecimal pd_oper_serv_fee) {
		this.pd_oper_serv_fee = pd_oper_serv_fee;
	}
	public BigDecimal getPd_ivsm_advr_fee() {
		return pd_ivsm_advr_fee;
	}
	public void setPd_ivsm_advr_fee(BigDecimal pd_ivsm_advr_fee) {
		this.pd_ivsm_advr_fee = pd_ivsm_advr_fee;
	}
	public String getPd_oth_fee_expl() {
		return pd_oth_fee_expl;
	}
	public void setPd_oth_fee_expl(String pd_oth_fee_expl) {
		this.pd_oth_fee_expl = pd_oth_fee_expl;
	}
	public BigDecimal getPd_fee_sum() {
		return pd_fee_sum;
	}
	public void setPd_fee_sum(BigDecimal pd_fee_sum) {
		this.pd_fee_sum = pd_fee_sum;
	}
	public BigDecimal getAggr_aep() {
		return aggr_aep;
	}
	public void setAggr_aep(BigDecimal aggr_aep) {
		this.aggr_aep = aggr_aep;
	}
	public BigDecimal getAggr_cstd_fee() {
		return aggr_cstd_fee;
	}
	public void setAggr_cstd_fee(BigDecimal aggr_cstd_fee) {
		this.aggr_cstd_fee = aggr_cstd_fee;
	}
	public BigDecimal getAggr_perf_remu() {
		return aggr_perf_remu;
	}
	public void setAggr_perf_remu(BigDecimal aggr_perf_remu) {
		this.aggr_perf_remu = aggr_perf_remu;
	}
	public BigDecimal getAggr_oper_serv_fee() {
		return aggr_oper_serv_fee;
	}
	public void setAggr_oper_serv_fee(BigDecimal aggr_oper_serv_fee) {
		this.aggr_oper_serv_fee = aggr_oper_serv_fee;
	}
	public BigDecimal getAggr_ivsm_advr_fee() {
		return aggr_ivsm_advr_fee;
	}
	public void setAggr_ivsm_advr_fee(BigDecimal aggr_ivsm_advr_fee) {
		this.aggr_ivsm_advr_fee = aggr_ivsm_advr_fee;
	}
	public String getAggr_oth_fee_expl() {
		return aggr_oth_fee_expl;
	}
	public void setAggr_oth_fee_expl(String aggr_oth_fee_expl) {
		this.aggr_oth_fee_expl = aggr_oth_fee_expl;
	}
	public BigDecimal getAggr_fee_sum() {
		return aggr_fee_sum;
	}
	public void setAggr_fee_sum(BigDecimal aggr_fee_sum) {
		this.aggr_fee_sum = aggr_fee_sum;
	}
	public BigDecimal getPd_oth_fee() {
		return pd_oth_fee;
	}
	public void setPd_oth_fee(BigDecimal pd_oth_fee) {
		this.pd_oth_fee = pd_oth_fee;
	}

	
	
	
	
}
