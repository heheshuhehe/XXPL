/**
 * 
 */
package com.swhy.xxpl.model.jibao;

import java.math.BigDecimal;
import java.util.Map;

/**
 * @author 230355
 *	季报表,基金基本情况sheet页
 */
public class Rept_Q_fund_info {

    private String       fund_code;                  //基金编号（综合管理平台）				#0	
    private String       info_src_code;              //信息来源代码						#1
    private String       qut_no;                     //季度编号						#2
    private String       c_pord_code;                //账套号（外包）					#3
    private String       fund_name;                  //基金名称						#4
    private String       fund_num;                   //基金编码(协会编码）缴总额（万元）		#5
    private String       fund_magr;                  //基金管理人						#6
    private String       fund_trus;                  //基金托管人（如有）					#7
    private String       ivsm_advr;                  //投资顾问（如有）					#8
    private String       fund_oper_mode;             //基金运作方式						#9
    private String       fund_setp_date;             //基金成立日期						#10
    private BigDecimal   fund_tot_shr_pdin_rate;	 //期末基金总份额（万份）/期末基金实缴总额（万元）#11
    private Object       ivsm_tgt;                   //投资目标						#12
    private Object       ivsm_stra;                  //投资策略						#13
    private Object       pcb;                        //业绩比较基准（如有）				#14
    private Object       risk_payf_fetr;             //风险收益特征						#15

	
	/**
	 * 
	 */
	public Rept_Q_fund_info() {
		// TODO Auto-generated constructor stub
	}


//    public boolean assembleMapToRept_Q_Fund_Info(Map<String, Object> map) {
//		this.setInfo_Src_Code(String.valueOf(map.get("info_src_code"))); 		//信息披露类型代码		#1
//		this.setQut_No(String.valueOf(map.get("qut_no"))); 						//季度编号				#2
//		this.setFund_Code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#0
//		if (info_Src_Code==null 	|| "".equals(info_Src_Code)		||			//invalid list or not enough list's elements
//			qut_No==null 			|| "".equals(qut_No)			||
//			fund_Code==null 		|| "".equals(fund_Code)			) return false;	
//		
//		return true;
//    }


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


	public String getFund_magr() {
		return fund_magr;
	}


	public void setFund_magr(String fund_magr) {
		this.fund_magr = fund_magr;
	}


	public String getFund_trus() {
		return fund_trus;
	}


	public void setFund_trus(String fund_trus) {
		this.fund_trus = fund_trus;
	}


	public String getIvsm_advr() {
		return ivsm_advr;
	}


	public void setIvsm_advr(String ivsm_advr) {
		this.ivsm_advr = ivsm_advr;
	}


	public String getFund_oper_mode() {
		return fund_oper_mode;
	}


	public void setFund_oper_mode(String fund_oper_mode) {
		this.fund_oper_mode = fund_oper_mode;
	}


	public String getFund_setp_date() {
		return fund_setp_date;
	}


	public void setFund_setp_date(String fund_setp_date) {
		this.fund_setp_date = fund_setp_date;
	}


	public BigDecimal getFund_tot_shr_pdin_rate() {
		return fund_tot_shr_pdin_rate;
	}


	public void setFund_tot_shr_pdin_rate(BigDecimal fund_tot_shr_pdin_rate) {
		this.fund_tot_shr_pdin_rate = fund_tot_shr_pdin_rate;
	}


	public Object getIvsm_tgt() {
		return ivsm_tgt;
	}


	public void setIvsm_tgt(Object ivsm_tgt) {
		this.ivsm_tgt = ivsm_tgt;
	}


	public Object getIvsm_stra() {
		return ivsm_stra;
	}


	public void setIvsm_stra(Object ivsm_stra) {
		this.ivsm_stra = ivsm_stra;
	}


	public Object getPcb() {
		return pcb;
	}


	public void setPcb(Object pcb) {
		this.pcb = pcb;
	}


	public Object getRisk_payf_fetr() {
		return risk_payf_fetr;
	}


	public void setRisk_payf_fetr(Object risk_payf_fetr) {
		this.risk_payf_fetr = risk_payf_fetr;
	}

	
	
	
}
