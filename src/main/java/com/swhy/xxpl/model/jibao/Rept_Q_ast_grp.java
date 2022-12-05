package com.swhy.xxpl.model.jibao;

import java.math.BigDecimal;

public class Rept_Q_ast_grp {

    private String       fund_code ;                           //基金编号（综合管理平台）
    private String       info_src_code ;                       //信息来源代码
    private String       qut_no ;                              //季度编号
    private String       c_pord_code ;                         //账套号（外包）
    private BigDecimal   casht_bnk_dpsi ;                      //现金类资产_银行存款
    private BigDecimal   unlist_sivsm ;                        //境内未上市、未挂牌公司股权投资_股权投资
    private BigDecimal   unlist_sivsm_part_prstk ;             //境内未上市、未挂牌公司股权投资_股权投资(其中：优先股)
    private String       unlist_sivsm_part_osivsm ;            //境内未上市、未挂牌公司股权投资_股权投资(其他股权类投资)
    private BigDecimal   lcda_stkivsm ;                        //上市公司定向增发股票投资
    private BigDecimal   nivsm ;                               //新三板挂牌企业投资
    private BigDecimal   secuivsm_drfb ;                       //境内证券投资规模_结算备付金
    private BigDecimal   secuivsm_gdpacb ;                     //境内证券投资规模_存出保证金
    private BigDecimal   secuivsm_stkivsm ;                    //境内证券投资规模_股票投资
    private BigDecimal   secuivsm_binsm ;                      //境内证券投资规模_债券投资
    private BigDecimal   secuivsm_binsm_part_ib ;              //境内证券投资规模_债券投资(其中：银行间市场债券)
    private BigDecimal   secuivsm_binsm_part_intrb ;           //境内证券投资规模_债券投资(其中：利率债)
    private BigDecimal   secuivsm_binsm_part_credb ;           //境内证券投资规模_债券投资(其中：信用债)
    private BigDecimal   secuivsm_abs ;                        //境内证券投资规模_资产支持证券
    private BigDecimal   secuivsm_cfivsm ;                     //境内证券投资规模_基金投资（公募基金）
    private BigDecimal   secuivsm_cfivsm_part_cfund ;          //境内证券投资规模_基金投资（公募基金）(其中：货币基金)
    private BigDecimal   secuivsm_futd_marg ;                  //境内证券投资规模_期货及衍生品交易保证金
    private BigDecimal   secuivsm_bsofa ;                      //境内证券投资规模_买入返售金融资产
    private String       secuivsm_oth_secu ;                   //境内证券投资规模_其他证券类标的
    private String       aivsm_bfpivsm ;                       //资管计划投资_商业银行理财产品投资
    private String       aivsm_tpivsm ;                        //资管计划投资_信托计划投资
    private String       aivsm_famivsm ;                       //资管计划投资_基金公司及其子公司资产管理计划投资
    private String       aivsm_iamivsm ;                       //资管计划投资_保险资产管理计划投资
    private String       aivsm_samivsm ;                       //资管计划投资_证券公司及其子公司资产管理计划投资
    private String       aivsm_futamivsm ;                     //资管计划投资_期货公司及其子公司资产管理计划投资
    private String       aivsm_pfpivsm ;                       //资管计划投资_私募基金产品投资
    private String       aivsm_nfpivsm ;                       //资管计划投资_未在协会备案的合伙企业份额
    private BigDecimal   altnivsm ;                            //另类投资
    private BigDecimal   debtivsm_beloan ;                     //境内债权类投资_银行委托贷款规模
    private BigDecimal   debtivsm_tloan ;                      //境内债权类投资_信托贷款
    private BigDecimal   debtivsm_recAcct ;                    //境内债权类投资_应收账款投资
    private BigDecimal   debtivsm_benf ;                       //境内债权类投资_各类受（收）益权投资
    private BigDecimal   debtivsm_bill ;                       //境内债权类投资_票据（承兑汇票等）投资
    private String       debtivsm_odebtivsm ;                  //境内债权类投资_其他债权投资
    private BigDecimal   overivsm ;                            //境外投资
    private String       oth_ast ;                             //其他资产
    private BigDecimal   liab_rebond ;                         //基金负债情况_债券回购总额
    private BigDecimal   liab_fsborw ;                         //基金负债情况_融资、融券总额
    private BigDecimal   liab_fsborw_part_sborw ;              //基金负债情况_融资、融券总额(其中：融券总额)
    private BigDecimal   liab_bborw ;                          //基金负债情况_银行借款总额
    private String       liab_ofborw ;                         //基金负债情况_其他融资总额

	
	public Rept_Q_ast_grp() {
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


	public BigDecimal getCasht_bnk_dpsi() {
		return casht_bnk_dpsi;
	}


	public void setCasht_bnk_dpsi(BigDecimal casht_bnk_dpsi) {
		this.casht_bnk_dpsi = casht_bnk_dpsi;
	}


	public BigDecimal getUnlist_sivsm() {
		return unlist_sivsm;
	}


	public void setUnlist_sivsm(BigDecimal unlist_sivsm) {
		this.unlist_sivsm = unlist_sivsm;
	}


	public BigDecimal getUnlist_sivsm_part_prstk() {
		return unlist_sivsm_part_prstk;
	}


	public void setUnlist_sivsm_part_prstk(BigDecimal unlist_sivsm_part_prstk) {
		this.unlist_sivsm_part_prstk = unlist_sivsm_part_prstk;
	}


	public String getUnlist_sivsm_part_osivsm() {
		return unlist_sivsm_part_osivsm;
	}


	public void setUnlist_sivsm_part_osivsm(String unlist_sivsm_part_osivsm) {
		this.unlist_sivsm_part_osivsm = unlist_sivsm_part_osivsm;
	}


	public BigDecimal getLcda_stkivsm() {
		return lcda_stkivsm;
	}


	public void setLcda_stkivsm(BigDecimal lcda_stkivsm) {
		this.lcda_stkivsm = lcda_stkivsm;
	}


	public BigDecimal getNivsm() {
		return nivsm;
	}


	public void setNivsm(BigDecimal nivsm) {
		this.nivsm = nivsm;
	}


	public BigDecimal getSecuivsm_drfb() {
		return secuivsm_drfb;
	}


	public void setSecuivsm_drfb(BigDecimal secuivsm_drfb) {
		this.secuivsm_drfb = secuivsm_drfb;
	}


	public BigDecimal getSecuivsm_gdpacb() {
		return secuivsm_gdpacb;
	}


	public void setSecuivsm_gdpacb(BigDecimal secuivsm_gdpacb) {
		this.secuivsm_gdpacb = secuivsm_gdpacb;
	}


	public BigDecimal getSecuivsm_stkivsm() {
		return secuivsm_stkivsm;
	}


	public void setSecuivsm_stkivsm(BigDecimal secuivsm_stkivsm) {
		this.secuivsm_stkivsm = secuivsm_stkivsm;
	}


	public BigDecimal getSecuivsm_binsm() {
		return secuivsm_binsm;
	}


	public void setSecuivsm_binsm(BigDecimal secuivsm_binsm) {
		this.secuivsm_binsm = secuivsm_binsm;
	}


	public BigDecimal getSecuivsm_binsm_part_ib() {
		return secuivsm_binsm_part_ib;
	}


	public void setSecuivsm_binsm_part_ib(BigDecimal secuivsm_binsm_part_ib) {
		this.secuivsm_binsm_part_ib = secuivsm_binsm_part_ib;
	}


	public BigDecimal getSecuivsm_binsm_part_intrb() {
		return secuivsm_binsm_part_intrb;
	}


	public void setSecuivsm_binsm_part_intrb(BigDecimal secuivsm_binsm_part_intrb) {
		this.secuivsm_binsm_part_intrb = secuivsm_binsm_part_intrb;
	}


	public BigDecimal getSecuivsm_binsm_part_credb() {
		return secuivsm_binsm_part_credb;
	}


	public void setSecuivsm_binsm_part_credb(BigDecimal secuivsm_binsm_part_credb) {
		this.secuivsm_binsm_part_credb = secuivsm_binsm_part_credb;
	}


	public BigDecimal getSecuivsm_abs() {
		return secuivsm_abs;
	}


	public void setSecuivsm_abs(BigDecimal secuivsm_abs) {
		this.secuivsm_abs = secuivsm_abs;
	}


	public BigDecimal getSecuivsm_cfivsm() {
		return secuivsm_cfivsm;
	}


	public void setSecuivsm_cfivsm(BigDecimal secuivsm_cfivsm) {
		this.secuivsm_cfivsm = secuivsm_cfivsm;
	}


	public BigDecimal getSecuivsm_cfivsm_part_cfund() {
		return secuivsm_cfivsm_part_cfund;
	}


	public void setSecuivsm_cfivsm_part_cfund(BigDecimal secuivsm_cfivsm_part_cfund) {
		this.secuivsm_cfivsm_part_cfund = secuivsm_cfivsm_part_cfund;
	}


	public BigDecimal getSecuivsm_futd_marg() {
		return secuivsm_futd_marg;
	}


	public void setSecuivsm_futd_marg(BigDecimal secuivsm_futd_marg) {
		this.secuivsm_futd_marg = secuivsm_futd_marg;
	}


	public BigDecimal getSecuivsm_bsofa() {
		return secuivsm_bsofa;
	}


	public void setSecuivsm_bsofa(BigDecimal secuivsm_bsofa) {
		this.secuivsm_bsofa = secuivsm_bsofa;
	}


	public String getSecuivsm_oth_secu() {
		return secuivsm_oth_secu;
	}


	public void setSecuivsm_oth_secu(String secuivsm_oth_secu) {
		this.secuivsm_oth_secu = secuivsm_oth_secu;
	}


	public String getAivsm_bfpivsm() {
		return aivsm_bfpivsm;
	}


	public void setAivsm_bfpivsm(String aivsm_bfpivsm) {
		this.aivsm_bfpivsm = aivsm_bfpivsm;
	}


	public String getAivsm_tpivsm() {
		return aivsm_tpivsm;
	}


	public void setAivsm_tpivsm(String aivsm_tpivsm) {
		this.aivsm_tpivsm = aivsm_tpivsm;
	}


	public String getAivsm_famivsm() {
		return aivsm_famivsm;
	}


	public void setAivsm_famivsm(String aivsm_famivsm) {
		this.aivsm_famivsm = aivsm_famivsm;
	}


	public String getAivsm_iamivsm() {
		return aivsm_iamivsm;
	}


	public void setAivsm_iamivsm(String aivsm_iamivsm) {
		this.aivsm_iamivsm = aivsm_iamivsm;
	}


	public String getAivsm_samivsm() {
		return aivsm_samivsm;
	}


	public void setAivsm_samivsm(String aivsm_samivsm) {
		this.aivsm_samivsm = aivsm_samivsm;
	}


	public String getAivsm_futamivsm() {
		return aivsm_futamivsm;
	}


	public void setAivsm_futamivsm(String aivsm_futamivsm) {
		this.aivsm_futamivsm = aivsm_futamivsm;
	}


	public String getAivsm_pfpivsm() {
		return aivsm_pfpivsm;
	}


	public void setAivsm_pfpivsm(String aivsm_pfpivsm) {
		this.aivsm_pfpivsm = aivsm_pfpivsm;
	}


	public String getAivsm_nfpivsm() {
		return aivsm_nfpivsm;
	}


	public void setAivsm_nfpivsm(String aivsm_nfpivsm) {
		this.aivsm_nfpivsm = aivsm_nfpivsm;
	}


	public BigDecimal getAltnivsm() {
		return altnivsm;
	}


	public void setAltnivsm(BigDecimal altnivsm) {
		this.altnivsm = altnivsm;
	}


	public BigDecimal getDebtivsm_beloan() {
		return debtivsm_beloan;
	}


	public void setDebtivsm_beloan(BigDecimal debtivsm_beloan) {
		this.debtivsm_beloan = debtivsm_beloan;
	}


	public BigDecimal getDebtivsm_tloan() {
		return debtivsm_tloan;
	}


	public void setDebtivsm_tloan(BigDecimal debtivsm_tloan) {
		this.debtivsm_tloan = debtivsm_tloan;
	}


	public BigDecimal getDebtivsm_recAcct() {
		return debtivsm_recAcct;
	}


	public void setDebtivsm_recAcct(BigDecimal debtivsm_recAcct) {
		this.debtivsm_recAcct = debtivsm_recAcct;
	}


	public BigDecimal getDebtivsm_benf() {
		return debtivsm_benf;
	}


	public void setDebtivsm_benf(BigDecimal debtivsm_benf) {
		this.debtivsm_benf = debtivsm_benf;
	}


	public BigDecimal getDebtivsm_bill() {
		return debtivsm_bill;
	}


	public void setDebtivsm_bill(BigDecimal debtivsm_bill) {
		this.debtivsm_bill = debtivsm_bill;
	}


	public String getDebtivsm_odebtivsm() {
		return debtivsm_odebtivsm;
	}


	public void setDebtivsm_odebtivsm(String debtivsm_odebtivsm) {
		this.debtivsm_odebtivsm = debtivsm_odebtivsm;
	}


	public BigDecimal getOverivsm() {
		return overivsm;
	}


	public void setOverivsm(BigDecimal overivsm) {
		this.overivsm = overivsm;
	}


	public String getOth_ast() {
		return oth_ast;
	}


	public void setOth_ast(String oth_ast) {
		this.oth_ast = oth_ast;
	}


	public BigDecimal getLiab_rebond() {
		return liab_rebond;
	}


	public void setLiab_rebond(BigDecimal liab_rebond) {
		this.liab_rebond = liab_rebond;
	}


	public BigDecimal getLiab_fsborw() {
		return liab_fsborw;
	}


	public void setLiab_fsborw(BigDecimal liab_fsborw) {
		this.liab_fsborw = liab_fsborw;
	}


	public BigDecimal getLiab_fsborw_part_sborw() {
		return liab_fsborw_part_sborw;
	}


	public void setLiab_fsborw_part_sborw(BigDecimal liab_fsborw_part_sborw) {
		this.liab_fsborw_part_sborw = liab_fsborw_part_sborw;
	}


	public BigDecimal getLiab_bborw() {
		return liab_bborw;
	}


	public void setLiab_bborw(BigDecimal liab_bborw) {
		this.liab_bborw = liab_bborw;
	}


	public String getLiab_ofborw() {
		return liab_ofborw;
	}


	public void setLiab_ofborw(String liab_ofborw) {
		this.liab_ofborw = liab_ofborw;
	}

	
	
}
