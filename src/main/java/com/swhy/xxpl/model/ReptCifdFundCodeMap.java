package com.swhy.xxpl.model;
/**
 * @author chenlin
 * 分级基金代码映射关系 
 *
 */
public class ReptCifdFundCodeMap {
    private String       fund_code ;                      // 基金编号（综合管理平台）		 
    private String       c_pord_code ;                    // 账套号（外包）
    private String       cifd_fund_flag ;                 // 分级基金标志  
    private String       cifd_fund_no ;                   // 分级分级基金编号标志 
    private String       cifd_fund_name ;                 // 分级基金名称  
    private String       cstd_cifd_no ;                   // 托管分级序号 
    private String       jbk_cifd_no ;                    // 吉贝克分级序号 
    
	public String getFund_code() {
		return fund_code;
	}
	public void setFund_code(String fund_code) {
		this.fund_code = fund_code;
	}
	public String getC_pord_code() {
		return c_pord_code;
	}
	public void setC_pord_code(String c_pord_code) {
		this.c_pord_code = c_pord_code;
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
	public String getCstd_cifd_no() {
		return cstd_cifd_no;
	}
	public void setCstd_cifd_no(String cstd_cifd_no) {
		this.cstd_cifd_no = cstd_cifd_no;
	}
	public String getJbk_cifd_no() {
		return jbk_cifd_no;
	}
	public void setJbk_cifd_no(String jbk_cifd_no) {
		this.jbk_cifd_no = jbk_cifd_no;
	} 
}
