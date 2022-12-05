package com.swhy.xxpl.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.fh.dao.XinxipiluDao;

public class Rept_M_Magr_Info {

	// primary key
	private String magr_No;						//管理人编号						#0
	private String info_Src_Code;				//信息来源代码						#1	
	private String mth_No;						//月编号							#2
	// nullable key
	private String magr_Name;					//管理人名称						#3
	private String magr_Num;					//管理人编码（p码）					#4
	private BigDecimal magr_self_scal;			//管理人自营规模						#5

	private BigDecimal mang_Fund_Vol;			//管理基金数量						#6
	private BigDecimal part_Mang_Qunt_Fund_Vol;	//其中：管理量化基金数量				#7
	private BigDecimal mang_Fund_Scal;			//管理基金规模						#8
	private BigDecimal part_Mang_Qunt_Fund_Scal;//其中：管理量化基金规模				#9
	private String is_Over_Relp;				//是否存在境外关联方或子公司				#10
	private String over_Relp_Name;				//境外关联方和子公司名称				#11
	private BigDecimal over_Relp_Mang_fund_Tot_Ast;//境外关联方和子公司管理基金总资产		#12
	private BigDecimal over_Relp_Mang_fund_Net_Ast;//境外关联方和子公司管理基金净资产		#13
	private BigDecimal part_Pass_Lgt_Stk_Mval;	//其中：通过陆股通投资境内股票市值			#14
	private BigDecimal part_pass_qfii_stk_mval; //其中：通过QFII投资境内股票市值			#15
	private String over_Relp_Serv_Name;			//境外关联方和子公司投资境内股票交易服务商名称 #16
	private String oth_Qust;					//管理人需要说明的其他问题				#17
	private BigDecimal pd_elmt_nest_aft_purs_tot_amt;//当期剔除嵌套后的认购/申购总金额	#18
	private BigDecimal pd_elmt_nest_aft_redp_tot_amt;//当期剔除嵌套后的赎回总金额		#19

	               
	
	public Rept_M_Magr_Info() {
//		funds = new ArrayList<Rept_m_qunt_prfund_run>();
	}
	public Rept_M_Magr_Info(String magr_No, String info_Src_Code, String mth_No) {
//		funds = new ArrayList<Rept_m_qunt_prfund_run>();
		this.setMagr_No(magr_No);
		this.setInfo_Src_Code(info_Src_Code);
		this.setMth_No(mth_No);
	}
	
	/**
	 * Assign a list of value into a Rept_Disc_Situ.
	 * @param list
	 * @return true if all the values are correctly loaded otherwise false
	 */
	public boolean assembleMapToRept_Disc_Situ_Magr(Map<String, Object> map) {
		if ( null == map || map.size()<1) return false;							
		
		// set primary values	//
		this.setMagr_No(String.valueOf(map.get("magr_no"))); 										//管理人编号						#0
		this.setInfo_Src_Code(String.valueOf(map.get("info_src_code"))); 							//信息来源代码						#1
		this.setMth_No(String.valueOf(map.get("mth_no"))); 											//月编号							#2
		if (magr_No==null 			|| "".equals(magr_No)					||						//invalid list or not enough list's elements
			info_Src_Code==null 	|| "".equals(info_Src_Code)				||
			mth_No==null 			|| "".equals(mth_No)			) return false;		
		
		// set optional values	//		
		this.setMagr_Name					(String.valueOf(map.get("magr_name"))); 				//管理人名称						#3  
		this.setMagr_Num					(String.valueOf(map.get("magr_num")));					//管理人编码（p码）					#4  
		this.setMang_Fund_Vol				((BigDecimal)map.get("mang_fund_vol"));					//管理基金数量						#5
		this.setPart_Mang_Qunt_Fund_Vol		((BigDecimal)map.get("part_mang_qunt_fund_vol"));		//其中：管理量化基金数量				#6  
		this.setMang_Fund_Scal				((BigDecimal)map.get("mang_fund_scal"));				//管理基金规模						#7
		this.setPart_Mang_Qunt_Fund_Scal	((BigDecimal)map.get("part_mang_qunt_fund_scal"));		//其中：管理量化基金规模				#8  
		this.setIs_Over_Relp				(String.valueOf(map.get("is_over_relp")));				//是否存在境外关联方或子公司				#9  
		this.setOver_Relp_Name				(String.valueOf(map.get("over_relp_name")));			//境外关联方和子公司名称				#10 
			//境外关联方和子公司管理基金总资产			#11 
		
		String temp = String.valueOf (map.get("over_relp_mang_fund_tot_ast"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setOver_Relp_Mang_fund_Tot_Ast(java.math.BigDecimal.valueOf(0f));
		else this.setOver_Relp_Mang_fund_Tot_Ast((java.math.BigDecimal) map.get("over_relp_mang_fund_tot_ast"));		
		
			//境外关联方和子公司管理基金净资产			#12 
		temp = String.valueOf (map.get("over_relp_mang_fund_net_ast"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setOver_Relp_Mang_fund_Net_Ast(java.math.BigDecimal.valueOf(0f));
		else this.setOver_Relp_Mang_fund_Net_Ast((java.math.BigDecimal) map.get("over_relp_mang_fund_net_ast"));
		
			//其中：通过陆股通投资境内股票市值			#13
		temp = String.valueOf (map.get("part_pass_lgt_stk_mval"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_Pass_Lgt_Stk_Mval(java.math.BigDecimal.valueOf(0f));
		else this.setPart_Pass_Lgt_Stk_Mval((java.math.BigDecimal) map.get("part_pass_lgt_stk_mval"));
		
		this.setOver_Relp_Serv_Name			(String.valueOf(map.get("over_relp_serv_name")));	//境外关联方和子公司投资境内股票交易服务商名称 #14    
		this.setOth_Qust					(String.valueOf(map.get("oth_qust")));				//管理人需要说明的其他问题				#15 

		 temp = String.valueOf (map.get("magr_self_scal"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setMagr_self_scal(java.math.BigDecimal.valueOf(0f));
		else this.setMagr_self_scal ((java.math.BigDecimal) map.get("magr_self_scal"));		
		
		 temp = String.valueOf (map.get("part_pass_qfii_stk_mval"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_pass_qfii_stk_mval(java.math.BigDecimal.valueOf(0f));
		else this.setPart_pass_qfii_stk_mval ((java.math.BigDecimal) map.get("part_pass_qfii_stk_mval"));		
		
		//当期剔除嵌套后的认购/申购总金额	#18
		temp = String.valueOf (map.get("pd_elmt_nest_aft_purs_tot_amt"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_Pass_Lgt_Stk_Mval(java.math.BigDecimal.valueOf(0f));
		else this.setPd_elmt_nest_aft_purs_tot_amt((java.math.BigDecimal) map.get("pd_elmt_nest_aft_purs_tot_amt"));
		
		//当期剔除嵌套后的赎回总金额		#19
		temp = String.valueOf (map.get("pd_elmt_nest_aft_redp_tot_amt"));
		if (null==temp && "".equals(temp) || temp.equals("0"))this.setPart_Pass_Lgt_Stk_Mval(java.math.BigDecimal.valueOf(0f));
		else this.setPd_elmt_nest_aft_redp_tot_amt((java.math.BigDecimal) map.get("pd_elmt_nest_aft_redp_tot_amt"));		
		
		return true;
	}	
	
	/**
	 * 装配一个list的原始数据进入 List<ReptDiscSitu>
	 * @param list
	 * @return
	 */
	public static List<Rept_M_Magr_Info> assembleListToRept_Disc_Situ_Magr (List <Map<String, Object>> list){
		List<Rept_M_Magr_Info> resultList = new ArrayList <Rept_M_Magr_Info> ();
		Rept_M_Magr_Info rds;
		for (Map<String, Object> m : list) {
			rds = new Rept_M_Magr_Info();
			rds.assembleMapToRept_Disc_Situ_Magr(m);
			resultList.add(rds);
		}
		return resultList;
	}
	
	/**
	 * adding 1 Rept_m_qunt_prfund_run
	 * @param r Rept_m_qunt_prfund_run or invalid r
	 * @return true when success, false when failed
	 */
//	public Boolean addFund(Rept_m_qunt_prfund_run r) {
//		return r==null?false:(getFunds().add(r));
//	}
	
	/**
	 * adding a list of Rept_m_qunt_prfund_run
	 * @param lr list of Rept_m_qunt_prfund_run
	 * @return true when success, false when failed or invalid lr
	 */
//	public Boolean addFunds(List<Rept_m_qunt_prfund_run> lr) {
//		return (lr==null||lr.size()<1)?false:(getFunds().addAll(lr));
//	}
	
	/* getters and setters */
	public String getMagr_No() {
		return magr_No;
	}
	public void setMagr_No(String magr_No) {
		this.magr_No = magr_No;
	}
	public String getInfo_Src_Code() {
		return info_Src_Code;
	}
	public void setInfo_Src_Code(String info_Src_Code) {
		this.info_Src_Code = info_Src_Code;
	}
	public String getMth_No() {
		return mth_No;
	}
	public void setMth_No(String mth_No) {
		this.mth_No = mth_No;
	}
	public String getMagr_Name() {
		return magr_Name;
	}
	public void setMagr_Name(String magr_Name) {
		this.magr_Name = magr_Name;
	}
	public String getMagr_Num() {
		return magr_Num;
	}
	public void setMagr_Num(String magr_Num) {
		this.magr_Num = magr_Num;
	}
	public BigDecimal getMang_Fund_Vol() {
		return mang_Fund_Vol;
	}
	public void setMang_Fund_Vol(BigDecimal mang_Fund_Vol) {
		this.mang_Fund_Vol = mang_Fund_Vol;
	}
	public BigDecimal getPart_Mang_Qunt_Fund_Vol() {
		return part_Mang_Qunt_Fund_Vol;
	}
	public void setPart_Mang_Qunt_Fund_Vol(BigDecimal part_Mang_Qunt_Fund_Vol) {
		this.part_Mang_Qunt_Fund_Vol = part_Mang_Qunt_Fund_Vol;
	}
	public BigDecimal getMang_Fund_Scal() {
		return mang_Fund_Scal;
	}
	public void setMang_Fund_Scal(BigDecimal mang_Fund_Scal) {
		this.mang_Fund_Scal = mang_Fund_Scal;
	}
	public BigDecimal getPart_Mang_Qunt_Fund_Scal() {
		return part_Mang_Qunt_Fund_Scal;
	}
	public void setPart_Mang_Qunt_Fund_Scal(BigDecimal part_Mang_Qunt_Fund_Scal) {
		this.part_Mang_Qunt_Fund_Scal = part_Mang_Qunt_Fund_Scal;
	}
	public String getIs_Over_Relp() {
		return is_Over_Relp;
	}
	public void setIs_Over_Relp(String is_Over_Relp) {
		this.is_Over_Relp = is_Over_Relp;
	}
	public String getOver_Relp_Name() {
		return over_Relp_Name;
	}
	public void setOver_Relp_Name(String over_Relp_Name) {
		this.over_Relp_Name = over_Relp_Name;
	}
	public BigDecimal getOver_Relp_Mang_fund_Tot_Ast() {
		return over_Relp_Mang_fund_Tot_Ast;
	}
	public void setOver_Relp_Mang_fund_Tot_Ast(BigDecimal over_Relp_Mang_fund_Tot_Ast) {
		this.over_Relp_Mang_fund_Tot_Ast = over_Relp_Mang_fund_Tot_Ast;
	}
	public BigDecimal getOver_Relp_Mang_fund_Net_Ast() {
		return over_Relp_Mang_fund_Net_Ast;
	}
	public void setOver_Relp_Mang_fund_Net_Ast(BigDecimal over_Relp_Mang_fund_Net_Ast) {
		this.over_Relp_Mang_fund_Net_Ast = over_Relp_Mang_fund_Net_Ast;
	}
	public BigDecimal getPart_Pass_Lgt_Stk_Mval() {
		return part_Pass_Lgt_Stk_Mval;
	}
	public void setPart_Pass_Lgt_Stk_Mval(BigDecimal part_Pass_Lgt_Stk_Mval) {
		this.part_Pass_Lgt_Stk_Mval = part_Pass_Lgt_Stk_Mval;
	}
	public String getOver_Relp_Serv_Name() {
		return over_Relp_Serv_Name;
	}
	public void setOver_Relp_Serv_Name(String over_Relp_Serv_Name) {
		this.over_Relp_Serv_Name = over_Relp_Serv_Name;
	}
	public String getOth_Qust() {
		return oth_Qust;
	}
	public void setOth_Qust(String oth_Qust) {
		this.oth_Qust = oth_Qust;
	}
	public BigDecimal getMagr_self_scal() {
		return magr_self_scal;
	}
	public void setMagr_self_scal(BigDecimal magr_self_scal) {
		this.magr_self_scal = magr_self_scal;
	}
	public BigDecimal getPart_pass_qfii_stk_mval() {
		return part_pass_qfii_stk_mval;
	}
	public void setPart_pass_qfii_stk_mval(BigDecimal part_pass_qfii_stk_mval) {
		this.part_pass_qfii_stk_mval = part_pass_qfii_stk_mval;
	}
	public BigDecimal getPd_elmt_nest_aft_purs_tot_amt() {
		return pd_elmt_nest_aft_purs_tot_amt;
	}
	public void setPd_elmt_nest_aft_purs_tot_amt(BigDecimal pd_elmt_nest_aft_purs_tot_amt) {
		this.pd_elmt_nest_aft_purs_tot_amt = pd_elmt_nest_aft_purs_tot_amt;
	}
	public BigDecimal getPd_elmt_nest_aft_redp_tot_amt() {
		return pd_elmt_nest_aft_redp_tot_amt;
	}
	public void setPd_elmt_nest_aft_redp_tot_amt(BigDecimal pd_elmt_nest_aft_redp_tot_amt) {
		this.pd_elmt_nest_aft_redp_tot_amt = pd_elmt_nest_aft_redp_tot_amt;
	}
	
	

	
	
		

}
