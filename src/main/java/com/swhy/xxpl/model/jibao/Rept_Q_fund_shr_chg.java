package com.swhy.xxpl.model.jibao;

import java.math.BigDecimal;

/**
 * 基金份额变动情况(季报)
 * @author 230355
 *
 */
public class Rept_Q_fund_shr_chg {

    private String       fund_code ;                                //基金编号（综合管理平台）                             	#0     
    private String       info_src_code ;                            //信息来源代码                                      #1 
    private String       qut_no ;                                   //季度编号                                        	#2 
    private String       c_pord_code ;                              //账套号（外包）                                    	#3 
    private BigDecimal   onum ;                                     //序号                                           	#4     
    private String       cifd_fund_flag ;                           //分级基金标志                                      #5 
    private String       cifd_fund_no ;                             //分级基金编号                                      #6 
    private String       cifd_fund_name ;                           //分级基金名称                                      #7     
    private BigDecimal   bgng_fund_shr_gamt ;                       //报告期期初基金份额总额(万份/万元)                      	#8 
    private BigDecimal   pd_fund_tot_purs_shr ;                     //报告期期间基金总申购份额(万份/万元)                     	#9	   
    private BigDecimal   pd_fund_tot_redp_shr ;                     //减：报告期期间基金总赎回份额(万份/万元)                   #10	   
    private BigDecimal   pd_fund_spli_chg_sh ;                      //报告期期间基金拆分变动份额（份额减少以“-”填列）(万份/万元)		#11	   
    private BigDecimal   fund_tot_shr_pdin_rate ;                   //期末基金总份额/期末基金实缴总额(万份/万元)                	#12	   
    private Object       memo ;                                     //备注                                          	#13

	
	public Rept_Q_fund_shr_chg() {
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


	public String getCifd_fund_name() {
		return cifd_fund_name;
	}


	public void setCifd_fund_name(String cifd_fund_name) {
		this.cifd_fund_name = cifd_fund_name;
	}


	public BigDecimal getBgng_fund_shr_gamt() {
		return bgng_fund_shr_gamt;
	}


	public void setBgng_fund_shr_gamt(BigDecimal bgng_fund_shr_gamt) {
		this.bgng_fund_shr_gamt = bgng_fund_shr_gamt;
	}


	public BigDecimal getPd_fund_tot_purs_shr() {
		return pd_fund_tot_purs_shr;
	}


	public void setPd_fund_tot_purs_shr(BigDecimal pd_fund_tot_purs_shr) {
		this.pd_fund_tot_purs_shr = pd_fund_tot_purs_shr;
	}


	public BigDecimal getPd_fund_tot_redp_shr() {
		return pd_fund_tot_redp_shr;
	}


	public void setPd_fund_tot_redp_shr(BigDecimal pd_fund_tot_redp_shr) {
		this.pd_fund_tot_redp_shr = pd_fund_tot_redp_shr;
	}


	public BigDecimal getPd_fund_spli_chg_sh() {
		return pd_fund_spli_chg_sh;
	}


	public void setPd_fund_spli_chg_sh(BigDecimal pd_fund_spli_chg_sh) {
		this.pd_fund_spli_chg_sh = pd_fund_spli_chg_sh;
	}


	public BigDecimal getFund_tot_shr_pdin_rate() {
		return fund_tot_shr_pdin_rate;
	}


	public void setFund_tot_shr_pdin_rate(BigDecimal fund_tot_shr_pdin_rate) {
		this.fund_tot_shr_pdin_rate = fund_tot_shr_pdin_rate;
	}


	public Object getMemo() {
		return memo;
	}


	public void setMemo(Object memo) {
		this.memo = memo;
	}
	
	

}
