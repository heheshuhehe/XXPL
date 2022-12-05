/**
 * 
 */
package com.swhy.xxpl.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

/**
 * 量化私募基金运行表(月报）
 * 	@author 230355
 */
/**
 * @author Ge Shucheng
 *
 */
public class  Rept_m_qunt_prfund_run {

	private String  magr_no;        		//管理人编号			#0
	private String  fund_code;        		//基金编号（综合管理平台）	#1
	private String  info_src_code;       	//信息来源代码			#2
	private String  mth_no;        			//月编号				#3
	private String  c_pord_code;        	//账套号				#4
	private String busi_date	;			//业务日期(用于获取时点指标的日期）#5
	private Integer  onum;        			//序号				#6
	private String  fund_name;        		//基金名称				#7
	private String  fund_num;        		//基金编码				#8
	private String  sdc_corp_unif_acc;      //中登公司一码通账户		#9
	private String  futr_marg_mcent_acc;    //期货保证金监控中心账户	#10
	private String  qunt_main_stra;        	//量化主策略			#11
	private String  qunt_asit_stra;        	//量化辅策略			#12
	private String  qunt_main_stra_adj_flag;//当期量化主策略是否发生调整 #13
	private String  warn_line;				//预警线				#14
	private String  covr_line;				//止损线/平仓线			#15

	private java.math.BigDecimal fund_scal;        			//基金规模				#16	
	private java.math.BigDecimal  fund_tot_ast;        		//基金总资产			#17
	private java.math.BigDecimal  fund_unit_net_val;      	//基金单位净值			#18
	private java.math.BigDecimal  fund_unit_aggr_net_val; 	//基金单位累计净值		#19
	private java.math.BigDecimal  net_val_max_pback;      	//当期净值最大回撤		#20
	private java.math.BigDecimal fund_prate;				//					#21
	private java.math.BigDecimal cyear_fund_prate;			//					#22
	private java.math.BigDecimal aggr_fund_prate;			//					#23

	private java.math.BigDecimal  stkivsm_amt;        		//股票投资金额			#24
	private java.math.BigDecimal  aday_hold_stk_vol;      	//日均持有股票数量		#25
	private java.math.BigDecimal  aday_stk_mtch_amt;      	//日均股票成交金额（单边）	#26
	private java.math.BigDecimal  aday_stk_turn_rate;     	//日均股票换手率（单边）	#27
	private java.math.BigDecimal  casht				;		//现金类资产			#28

	private java.math.BigDecimal	futd_marg;        		//期货及衍生品交易保证金	#29
	private java.math.BigDecimal  part_stk_futr_trd_marg; 	//其中:股指期货交易保证金	#30
	private java.math.BigDecimal  part_otc_deri_trd_marg; 	//其中:场外衍生品交易保证金 #31
	private java.math.BigDecimal  otc_deri_cont_val;      	//场外衍生品合约价值		#32
	private java.math.BigDecimal  part_payf_swap_marg;		//其中：收益互换保证金		#33
	private java.math.BigDecimal  otc_deri_nmpr;			//场外衍生品名义本金		#34
	private java.math.BigDecimal  payf_swap_nmpr;			//收益互换名义本金		#35
	private java.math.BigDecimal  payf_swap_cont_val;		//收益互换合约价值		#36

	private java.math.BigDecimal  fin_bal;        			//融资余额				#37
	private java.math.BigDecimal  shts_bal;       	 		//融券余额				#38
	private String  				acc_high_rep_rate;      //账户最高申报速率		#39
	private java.math.BigDecimal   	purs_tot_amt;        	//当期申购总金额			#40
	private java.math.BigDecimal  	redp_tot_amt;        	//当期赎回总金额			#41
	private java.math.BigDecimal 	occu_huge_redp_tims;    //当期发生巨额赎回次数		#42
	private String  				huge_redp_situ_expl;   	//巨额赎回情况说明		#43
	private String  				is_clear;				//是否处于清算过程中		#44	
	private String					is_scr_futr_trd;		//基金是否直接从事证券期货交易#45	
	private String					memo;					//备注				#46

	private String  data_stat_code;							//勾稽状态				#47
	
	/*
	 * Default Constructor
	 * */
	public Rept_m_qunt_prfund_run() {
		super();
	}

	/**
	 * Assign a list of value into a Rept_m_qunt_prfund_run.
	 * @param list
	 * @return true if all the values are correctly loaded otherwise false
	 */
	public boolean assembleMapToRept_m_qunt_prfund_run(Map<String, Object> map) {
		if ( null == map || map.size()<1) return false;							
		String temp;
		// set primary values	//
		this.setFund_code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#1
		this.setInfo_src_code(String.valueOf(map.get("info_src_code"))); 		//信息来源代码			#2
		this.setMth_no(String.valueOf(map.get("mth_no"))); 						//月编号				#3
		if (fund_code==null 	|| "".equals(fund_code)		||					//invalid list or not enough list's elements
			info_src_code==null || "".equals(info_src_code)	||
			mth_no==null 		|| "".equals(mth_no)		) return false;		
		
		// set optional values	//		
		this.setMagr_no(String.valueOf(map.get("magr_no"))); 					//管理人编号			#0
		this.setC_pord_code(String.valueOf(map.get("c_pord_code"))); 			//账套号				#4
		this.setOnum(Integer.parseInt(map.get("onum").toString())); 			//序号				#5
		this.setFund_name(String.valueOf(map.get("fund_name"))); 				//基金名称				#6	 			
		this.setFund_num(String.valueOf(map.get("fund_num")));					//基金编码				#7		 			
		this.setSdc_corp_unif_acc(String.valueOf(map.get("sdc_corp_unif_acc")));//中登公司一码通账户		#8 			
		this.setFutr_marg_mcent_acc(String.valueOf(map.get("futr_marg_mcent_acc"))); //期货保证金监控中心账户	#9	 			
		this.setQunt_main_stra(String.valueOf(map.get("qunt_main_stra"))); 		//量化主策略			#10	 			
		this.setQunt_asit_stra(String.valueOf(map.get("qunt_asit_stra"))); 		//量化辅策略			#11	 			
		this.setQunt_main_stra_adj_flag(String.valueOf(map.get("qunt_main_stra_adj_flag")));//当期量化主策略是否发生调整 #12	 	
		this.setFund_scal			((java.math.BigDecimal)map.get("fund_scal"));			//基金规模				#13	 			
		this.setFund_tot_ast		((java.math.BigDecimal)map.get("fund_tot_ast"));	//基金总资产			#14	 			
		this.setFund_unit_net_val	((java.math.BigDecimal)map.get("fund_unit_net_val"));//基金单位净值			#15	 			
		this.setFund_unit_aggr_net_val((java.math.BigDecimal)map.get("fund_unit_aggr_net_val"));//基金单位累计净值		#16
		temp = String.valueOf (map.get("net_val_max_pback"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_stk_futr_trd_marg(java.math.BigDecimal.valueOf(0f));//当期净值最大回撤		#17	 	
		else this.setNet_val_max_pback((java.math.BigDecimal) map.get("net_val_max_pback"));		
		this.setFund_prate			((java.math.BigDecimal)map.get("fund_prate"));				//					#18	 			
		this.setCyear_fund_prate			((java.math.BigDecimal)map.get("cyear_fund_prate"));//					#19	 			
		this.setAggr_fund_prate			((java.math.BigDecimal)map.get("aggr_fund_prate"));		//					#20	 			
		this.setStkivsm_amt			((java.math.BigDecimal)map.get("stkivsm_amt"));				//股票投资金额			#18	 			
		this.setAday_hold_stk_vol	((java.math.BigDecimal)map.get("aday_hold_stk_vol"));		//日均持有股票数量		#19 			
		this.setAday_stk_mtch_amt	((java.math.BigDecimal)map.get("aday_stk_mtch_amt"));		//日均股票成交金额（单边）	#20			
		this.setAday_stk_turn_rate	((java.math.BigDecimal)map.get("aday_stk_turn_rate"));		//日均股票换手率（单边）	#21			
		this.setFutd_marg			((java.math.BigDecimal)map.get("futd_marg"));				//期货及衍生品交易保证金	#22	
		temp = String.valueOf (map.get("part_stk_futr_trd_marg"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_stk_futr_trd_marg(java.math.BigDecimal.valueOf(0f));
		else this.setPart_stk_futr_trd_marg((java.math.BigDecimal) map.get("part_stk_futr_trd_marg"));
		//((temp==null||"".equals(temp) ?0:(map.get("part_stk_futr_trd_marg")));				//其中:股指期货交易保证金	#23	
		this.setPart_otc_deri_trd_marg((java.math.BigDecimal)map.get("part_otc_deri_trd_marg"));//其中:场外衍生品交易保证金 #24	
		this.setOtc_deri_cont_val	((java.math.BigDecimal)map.get("otc_deri_cont_val"));		//场外衍生品合约价值		#25	
		this.setFin_bal				((java.math.BigDecimal)map.get("fin_bal"));					//融资余额				#26	
		this.setShts_bal			((java.math.BigDecimal)map.get("shts_bal"));				//融券余额				#27	
		this.setAcc_high_rep_rate(String.valueOf(map.get("acc_high_rep_rate")));				//账户最高申报速率		#28
		this.setPurs_tot_amt		((java.math.BigDecimal)map.get("purs_tot_amt"));			//当期申购总金额			#29
		this.setRedp_tot_amt		((java.math.BigDecimal)map.get("redp_tot_amt"));			//当期赎回总金额			#30	
		this.setOccu_huge_redp_tims((java.math.BigDecimal)map.get("occu_huge_redp_tims"));		//当期发生巨额赎回次数		#31	
		this.setHuge_redp_situ_expl(String.valueOf(map.get("huge_redp_situ_expl")));			//巨额赎回情况说明		#32
		this.setIs_clear		(String.valueOf(map.get("is_clear")));							//是否处于清算过程中		#34
		this.setData_stat_code	(String.valueOf(map.get("data_stat_code")));					//勾稽状态				#35
		this.setWarn_line		(String.valueOf(map.get("warn_line")));		
		this.setCovr_line		(String.valueOf(map.get("covr_line")));	
		this.setIs_scr_futr_trd		(String.valueOf(map.get("is_scr_futr_trd")));	
		this.setMemo		(String.valueOf(map.get("memo")));	
		
		

		this.setCasht		((java.math.BigDecimal)map.get("casht"));			//

		temp = String.valueOf (map.get("casht"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setCasht(java.math.BigDecimal.valueOf(0f));
		else this.setCasht ((java.math.BigDecimal) map.get("casht"));
		
		temp = String.valueOf (map.get("part_payf_swap_marg"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_payf_swap_marg(java.math.BigDecimal.valueOf(0f));
		else this.setPart_payf_swap_marg ((java.math.BigDecimal) map.get("part_payf_swap_marg"));

		temp = String.valueOf (map.get("otc_deri_nmpr"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setOtc_deri_nmpr(java.math.BigDecimal.valueOf(0f));
		else this.setOtc_deri_nmpr ((java.math.BigDecimal) map.get("otc_deri_nmpr"));

		temp = String.valueOf (map.get("payf_swap_nmpr"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPayf_swap_nmpr(java.math.BigDecimal.valueOf(0f));
		else this.setPayf_swap_nmpr ((java.math.BigDecimal) map.get("payf_swap_nmpr"));	
		
		temp = String.valueOf (map.get("payf_swap_cont_val"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPayf_swap_cont_val(java.math.BigDecimal.valueOf(0f));
		else this.setPayf_swap_cont_val ((java.math.BigDecimal) map.get("payf_swap_cont_val"));					
		
		return true;
	}	
	
	/**
	 * 装配一个list的原始数据进入 List<Rept_m_qunt_prfund_run>
	 * @param list
	 * @return
	 */
	public static List<Rept_m_qunt_prfund_run> assembleListToRept_m_qunt_prfund_run (List <Map<String, Object>> list){
		List<Rept_m_qunt_prfund_run> resultList = new ArrayList <Rept_m_qunt_prfund_run> ();
		Rept_m_qunt_prfund_run rds;
		for (Map<String, Object> m : list) {
			rds = new Rept_m_qunt_prfund_run();
			rds.assembleMapToRept_m_qunt_prfund_run(m);
			resultList.add(rds);
		}
		return resultList;
	}

	
	/*getters and setters*/
	public String getMagr_no() {
		return magr_no;
	}

	public void setMagr_no(String magr_no) {
		this.magr_no = magr_no;
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

	public String getMth_no() {
		return mth_no;
	}

	public void setMth_no(String mth_no) {
		this.mth_no = mth_no;
	}

	public String getC_pord_code() {
		return c_pord_code;
	}

	public void setC_pord_code(String c_pord_code) {
		this.c_pord_code = c_pord_code;
	}

	public Integer getOnum() {
		return onum;
	}

	public void setOnum(Integer onum) {
		this.onum = onum;
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

	public String getSdc_corp_unif_acc() {
		return sdc_corp_unif_acc;
	}

	public void setSdc_corp_unif_acc(String sdc_corp_unif_acc) {
		this.sdc_corp_unif_acc = sdc_corp_unif_acc;
	}

	public String getFutr_marg_mcent_acc() {
		return futr_marg_mcent_acc;
	}

	public void setFutr_marg_mcent_acc(String futr_marg_mcent_acc) {
		this.futr_marg_mcent_acc = futr_marg_mcent_acc;
	}

	public String getQunt_main_stra() {
		return qunt_main_stra;
	}

	public void setQunt_main_stra(String qunt_main_stra) {
		this.qunt_main_stra = qunt_main_stra;
	}

	public String getQunt_asit_stra() {
		return qunt_asit_stra;
	}

	public void setQunt_asit_stra(String qunt_asit_stra) {
		this.qunt_asit_stra = qunt_asit_stra;
	}

	public String getQunt_main_stra_adj_flag() {
		return qunt_main_stra_adj_flag;
	}

	public void setQunt_main_stra_adj_flag(String qunt_main_stra_adj_flag) {
		this.qunt_main_stra_adj_flag = qunt_main_stra_adj_flag;
	}

	public java.math.BigDecimal getFund_scal() {
		return fund_scal;
	}

	public void setFund_scal(java.math.BigDecimal fund_scal) {
		this.fund_scal = fund_scal;
	}

	public java.math.BigDecimal getFund_tot_ast() {
		return fund_tot_ast;
	}

	public void setFund_tot_ast(java.math.BigDecimal fund_tot_ast) {
		this.fund_tot_ast = fund_tot_ast;
	}

	public java.math.BigDecimal getFund_unit_net_val() {
		return fund_unit_net_val;
	}

	public void setFund_unit_net_val(java.math.BigDecimal fund_unit_net_val) {
		this.fund_unit_net_val = fund_unit_net_val;
	}

	public java.math.BigDecimal getFund_unit_aggr_net_val() {
		return fund_unit_aggr_net_val;
	}

	public void setFund_unit_aggr_net_val(java.math.BigDecimal fund_unit_aggr_net_val) {
		this.fund_unit_aggr_net_val = fund_unit_aggr_net_val;
	}

	public java.math.BigDecimal getNet_val_max_pback() {
		return net_val_max_pback;
	}

	public void setNet_val_max_pback(java.math.BigDecimal net_val_max_pback) {
		this.net_val_max_pback = net_val_max_pback;
	}

	public java.math.BigDecimal getStkivsm_amt() {
		return stkivsm_amt;
	}

	public void setStkivsm_amt(java.math.BigDecimal stkivsm_amt) {
		this.stkivsm_amt = stkivsm_amt;
	}

	public java.math.BigDecimal getAday_hold_stk_vol() {
		return aday_hold_stk_vol;
	}

	public void setAday_hold_stk_vol(java.math.BigDecimal aday_hold_stk_vol) {
		this.aday_hold_stk_vol = aday_hold_stk_vol;
	}

	public java.math.BigDecimal getAday_stk_mtch_amt() {
		return aday_stk_mtch_amt;
	}

	public void setAday_stk_mtch_amt(java.math.BigDecimal aday_stk_mtch_amt) {
		this.aday_stk_mtch_amt = aday_stk_mtch_amt;
	}

	public java.math.BigDecimal getAday_stk_turn_rate() {
		return aday_stk_turn_rate;
	}

	public void setAday_stk_turn_rate(java.math.BigDecimal aday_stk_turn_rate) {
		this.aday_stk_turn_rate = aday_stk_turn_rate;
	}

	public java.math.BigDecimal getFutd_marg() {
		return futd_marg;
	}

	public void setFutd_marg(java.math.BigDecimal futd_marg) {
		this.futd_marg = futd_marg;
	}

	public java.math.BigDecimal getPart_stk_futr_trd_marg() {
		return part_stk_futr_trd_marg;
	}

	public void setPart_stk_futr_trd_marg(java.math.BigDecimal part_stk_futr_trd_marg) {
		this.part_stk_futr_trd_marg = part_stk_futr_trd_marg;
	}
	public void setPart_stk_futr_trd_marg(Object part_stk_futr_trd_marg) {
		this.part_stk_futr_trd_marg = (java.math.BigDecimal)part_stk_futr_trd_marg;
	}

	public java.math.BigDecimal getPart_otc_deri_trd_marg() {
		return part_otc_deri_trd_marg;
	}

	public void setPart_otc_deri_trd_marg(java.math.BigDecimal part_otc_deri_trd_marg) {
		this.part_otc_deri_trd_marg = part_otc_deri_trd_marg;
	}

	public java.math.BigDecimal getOtc_deri_cont_val() {
		return otc_deri_cont_val;
	}

	public void setOtc_deri_cont_val(java.math.BigDecimal otc_deri_cont_val) {
		this.otc_deri_cont_val = otc_deri_cont_val;
	}

	public java.math.BigDecimal getFin_bal() {
		return fin_bal;
	}

	public void setFin_bal(java.math.BigDecimal fin_bal) {
		this.fin_bal = fin_bal;
	}

	public java.math.BigDecimal getShts_bal() {
		return shts_bal;
	}

	public void setShts_bal(java.math.BigDecimal shts_bal) {
		this.shts_bal = shts_bal;
	}

	public String getAcc_high_rep_rate() {
		return acc_high_rep_rate;
	}

	public void setAcc_high_rep_rate(String acc_high_rep_rate) {
		this.acc_high_rep_rate = acc_high_rep_rate;
	}

	public java.math.BigDecimal getPurs_tot_amt() {
		return purs_tot_amt;
	}

	public void setPurs_tot_amt(java.math.BigDecimal purs_tot_amt) {
		this.purs_tot_amt = purs_tot_amt;
	}

	public java.math.BigDecimal getRedp_tot_amt() {
		return redp_tot_amt;
	}

	public void setRedp_tot_amt(java.math.BigDecimal redp_tot_amt) {
		this.redp_tot_amt = redp_tot_amt;
	}

	public java.math.BigDecimal getOccu_huge_redp_tims() {
		return occu_huge_redp_tims;
	}

	public void setOccu_huge_redp_tims(java.math.BigDecimal occu_huge_redp_tims) {
		this.occu_huge_redp_tims = occu_huge_redp_tims;
	}

	public String getHuge_redp_situ_expl() {
		return huge_redp_situ_expl;
	}

	public void setHuge_redp_situ_expl(String huge_redp_situ_expl) {
		this.huge_redp_situ_expl = huge_redp_situ_expl;
	}

	public String getIs_clear() {
		return is_clear;
	}

	public void setIs_clear(String is_clear) {
		this.is_clear = is_clear;
	}

	public String getData_stat_code() {
		return data_stat_code;
	}

	public void setData_stat_code(String data_stat_code) {
		this.data_stat_code = data_stat_code;
	}

	public java.math.BigDecimal getFund_prate() {
		return fund_prate;
	}

	public void setFund_prate(java.math.BigDecimal fund_prate) {
		this.fund_prate = fund_prate;
	}

	public java.math.BigDecimal getCyear_fund_prate() {
		return cyear_fund_prate;
	}

	public void setCyear_fund_prate(java.math.BigDecimal cyear_fund_prate) {
		this.cyear_fund_prate = cyear_fund_prate;
	}

	public java.math.BigDecimal getAggr_fund_prate() {
		return aggr_fund_prate;
	}

	public void setAggr_fund_prate(java.math.BigDecimal aggr_fund_prate) {
		this.aggr_fund_prate = aggr_fund_prate;
	}

	public String getBusi_date() {
		return busi_date;
	}

	public void setBusi_date(String busi_date) {
		this.busi_date = busi_date;
	}

	public String getWarn_line() {
		return warn_line;
	}

	public void setWarn_line(String warn_line) {
		this.warn_line = warn_line;
	}

	public String getCovr_line() {
		return covr_line;
	}

	public void setCovr_line(String covr_line) {
		this.covr_line = covr_line;
	}

	public java.math.BigDecimal  getCasht() {
		return casht;
	}

	public void setCasht(java.math.BigDecimal  casht) {
		this.casht = casht;
	}

	public java.math.BigDecimal getPart_payf_swap_marg() {
		return part_payf_swap_marg;
	}

	public void setPart_payf_swap_marg(java.math.BigDecimal part_payf_swap_marg) {
		this.part_payf_swap_marg = part_payf_swap_marg;
	}

	public java.math.BigDecimal getOtc_deri_nmpr() {
		return otc_deri_nmpr;
	}

	public void setOtc_deri_nmpr(java.math.BigDecimal otc_deri_nmpr) {
		this.otc_deri_nmpr = otc_deri_nmpr;
	}

	public java.math.BigDecimal getPayf_swap_nmpr() {
		return payf_swap_nmpr;
	}

	public void setPayf_swap_nmpr(java.math.BigDecimal payf_swap_nmpr) {
		this.payf_swap_nmpr = payf_swap_nmpr;
	}

	public java.math.BigDecimal getPayf_swap_cont_val() {
		return payf_swap_cont_val;
	}

	public void setPayf_swap_cont_val(java.math.BigDecimal payf_swap_cont_val) {
		this.payf_swap_cont_val = payf_swap_cont_val;
	}

	public String getIs_scr_futr_trd() {
		return is_scr_futr_trd;
	}

	public void setIs_scr_futr_trd(String is_scr_futr_trd) {
		this.is_scr_futr_trd = is_scr_futr_trd;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}


	
}
