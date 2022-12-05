package com.swhy.xxpl.model.hsr;

import java.math.BigDecimal;
import java.sql.Clob;

/**
 * 项目情况(股权半年报)
 * @author 230355
 */
public class Rept_HSR_prjivst {

	public Rept_HSR_prjivst() {
		// TODO Auto-generated constructor stub
	}
	String fund_code                     ;//基金编号（综合管理平台）
	String info_src_code                 ;//信息来源代码
	String date_no                       ;//日期编号
	String c_pord_code                   ;//账套号
	Integer proj_onum                     ;//项目序号
	String proj_corp_name                ;//项目企业名称
	String is_overivsm                   ;//是否境外投资
	String proj_corp_usc_code            ;//项目企业统一社会信用编码
	String proj_corp_setp_date           ;//项目企业成立日期
	String proj_corp_reg                 ;//项目企业注册地
	String proj_corp_stk_code            ;//项目企业股票代码
	String ivsm_indt                     ;//投资行业
	String estt_type                     ;//地产类型
	BigDecimal prjivsm_bookval               ;//项目投资账面价值
	BigDecimal prjivsm_bookval_part_sivsm    ;//项目投资账面价值(其中：股权投资账面价值)
	String sivsm_valu_way                ;//股权投资估值方法
	BigDecimal sivsm_stor_rate               ;//股权投资占被投资单位股权比重（%）
	BigDecimal prjivsm_bookval_part_debtivsm ;//项目投资账面价值(其中：债权投资账面价值)
	String clam_ivsm_valu_way            ;//债权投资估值方法
	BigDecimal prjivsm_date_prin             ;//项目投资日期及投资本金
	BigDecimal prjivsm_date_prin_part_sivsm  ;//项目投资日期及投资本金(其中：股权投资日期、投资本金及标的来源)
	BigDecimal prjivsm_date_prin_part_debt   ;//项目投资日期及投资本金(其中：债权投资日期、投资本金、标的来源及债权类别)
	String out_situ                      ;//退出情况
	Clob   out_info                      ;//退出信息
	String is_belt_mse                   ;//是否属于中小企业
	String is_belt_hnte                  ;//是否属于高新技术企业
	String is_belt_shtf                  ;//是否属于初创科技型企业
	String is_enftp                      ;//是否享受国家财税政策
	Clob riskcntl_basc_situ            ;//投资风控基本情况
	
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
	public Integer getProj_onum() {
		return proj_onum;
	}
	public void setProj_onum(Integer proj_onum) {
		this.proj_onum = proj_onum;
	}
	public String getProj_corp_name() {
		return proj_corp_name;
	}
	public void setProj_corp_name(String proj_corp_name) {
		this.proj_corp_name = proj_corp_name;
	}
	public String getIs_overivsm() {
		return is_overivsm;
	}
	public void setIs_overivsm(String is_overivsm) {
		this.is_overivsm = is_overivsm;
	}
	public String getProj_corp_usc_code() {
		return proj_corp_usc_code;
	}
	public void setProj_corp_usc_code(String proj_corp_usc_code) {
		this.proj_corp_usc_code = proj_corp_usc_code;
	}
	public String getProj_corp_setp_date() {
		return proj_corp_setp_date;
	}
	public void setProj_corp_setp_date(String proj_corp_setp_date) {
		this.proj_corp_setp_date = proj_corp_setp_date;
	}
	public String getProj_corp_reg() {
		return proj_corp_reg;
	}
	public void setProj_corp_reg(String proj_corp_reg) {
		this.proj_corp_reg = proj_corp_reg;
	}
	public String getProj_corp_stk_code() {
		return proj_corp_stk_code;
	}
	public void setProj_corp_stk_code(String proj_corp_stk_code) {
		this.proj_corp_stk_code = proj_corp_stk_code;
	}
	public String getIvsm_indt() {
		return ivsm_indt;
	}
	public void setIvsm_indt(String ivsm_indt) {
		this.ivsm_indt = ivsm_indt;
	}
	public String getEstt_type() {
		return estt_type;
	}
	public void setEstt_type(String estt_type) {
		this.estt_type = estt_type;
	}
	public BigDecimal getPrjivsm_bookval() {
		return prjivsm_bookval;
	}
	public void setPrjivsm_bookval(BigDecimal prjivsm_bookval) {
		this.prjivsm_bookval = prjivsm_bookval;
	}
	public BigDecimal getPrjivsm_bookval_part_sivsm() {
		return prjivsm_bookval_part_sivsm;
	}
	public void setPrjivsm_bookval_part_sivsm(BigDecimal prjivsm_bookval_part_sivsm) {
		this.prjivsm_bookval_part_sivsm = prjivsm_bookval_part_sivsm;
	}
	public String getSivsm_valu_way() {
		return sivsm_valu_way;
	}
	public void setSivsm_valu_way(String sivsm_valu_way) {
		this.sivsm_valu_way = sivsm_valu_way;
	}
	public BigDecimal getSivsm_stor_rate() {
		return sivsm_stor_rate;
	}
	public void setSivsm_stor_rate(BigDecimal sivsm_stor_rate) {
		this.sivsm_stor_rate = sivsm_stor_rate;
	}
	public BigDecimal getPrjivsm_bookval_part_debtivsm() {
		return prjivsm_bookval_part_debtivsm;
	}
	public void setPrjivsm_bookval_part_debtivsm(BigDecimal prjivsm_bookval_part_debtivsm) {
		this.prjivsm_bookval_part_debtivsm = prjivsm_bookval_part_debtivsm;
	}
	public String getClam_ivsm_valu_way() {
		return clam_ivsm_valu_way;
	}
	public void setClam_ivsm_valu_way(String clam_ivsm_valu_way) {
		this.clam_ivsm_valu_way = clam_ivsm_valu_way;
	}
	public BigDecimal getPrjivsm_date_prin() {
		return prjivsm_date_prin;
	}
	public void setPrjivsm_date_prin(BigDecimal prjivsm_date_prin) {
		this.prjivsm_date_prin = prjivsm_date_prin;
	}
	public BigDecimal getPrjivsm_date_prin_part_sivsm() {
		return prjivsm_date_prin_part_sivsm;
	}
	public void setPrjivsm_date_prin_part_sivsm(BigDecimal prjivsm_date_prin_part_sivsm) {
		this.prjivsm_date_prin_part_sivsm = prjivsm_date_prin_part_sivsm;
	}
	public BigDecimal getPrjivsm_date_prin_part_debt() {
		return prjivsm_date_prin_part_debt;
	}
	public void setPrjivsm_date_prin_part_debt(BigDecimal prjivsm_date_prin_part_debt) {
		this.prjivsm_date_prin_part_debt = prjivsm_date_prin_part_debt;
	}
	public String getOut_situ() {
		return out_situ;
	}
	public void setOut_situ(String out_situ) {
		this.out_situ = out_situ;
	}
	public Clob getOut_info() {
		return out_info;
	}
	public void setOut_info(Clob out_info) {
		this.out_info = out_info;
	}
	public String getIs_belt_mse() {
		return is_belt_mse;
	}
	public void setIs_belt_mse(String is_belt_mse) {
		this.is_belt_mse = is_belt_mse;
	}
	public String getIs_belt_hnte() {
		return is_belt_hnte;
	}
	public void setIs_belt_hnte(String is_belt_hnte) {
		this.is_belt_hnte = is_belt_hnte;
	}
	public String getIs_belt_shtf() {
		return is_belt_shtf;
	}
	public void setIs_belt_shtf(String is_belt_shtf) {
		this.is_belt_shtf = is_belt_shtf;
	}
	public String getIs_enftp() {
		return is_enftp;
	}
	public void setIs_enftp(String is_enftp) {
		this.is_enftp = is_enftp;
	}
	public Clob getRiskcntl_basc_situ() {
		return riskcntl_basc_situ;
	}
	public void setRiskcntl_basc_situ(Clob riskcntl_basc_situ) {
		this.riskcntl_basc_situ = riskcntl_basc_situ;
	}
	
	
	
	

	
	
}
