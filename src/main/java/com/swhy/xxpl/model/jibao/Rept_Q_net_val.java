/**
 * 
 */
package com.swhy.xxpl.model.jibao;

import java.math.BigDecimal;
import java.util.Map;

/**
 * @author 230355
 * 季报，基金净值表现(季报)
 */
public class Rept_Q_net_val {

    private String       fund_code ;                      //基金编号（综合管理平台）		#0 
    private String       info_src_code ;                  //信息来源代码				#1		  
    private String       qut_no ;                         //季度编号		            #2	  
    private String       c_pord_code ;                    //账套号（外包）               #3	  
    private BigDecimal   onum ;                           //序号                     #4 
    private String       cifd_fund_flag ;                 //分级基金标志                #5	  
    private String       cifd_fund_no ;                   //分级基金编号                #6	  
    private String       cifd_fund_name ;                 //分级基金名称                #7 
    private BigDecimal   qut_net_val_irate ;              //当季净值增长率（%）           #8 
    private BigDecimal   qut_net_val_irate_stdev ;        //当季净值增长率标准差（%）       #9	
    private BigDecimal   qut_pcb_prate ;                  //当季业绩比较基准收益率（%）      #10
    private BigDecimal   qut_pcb_prate_stdev ;            //当季业绩比较基准收益率标准差（%）  #11
    private BigDecimal   net_val_irate ;                  //净值增长率（%）              #12
    private BigDecimal   net_val_irate_stdev ;            //净值增长率标准差（%）          #13
    private BigDecimal   pcb_prate ;                      //业绩比较基准收益率（%）         #14
    private BigDecimal   pcb_prate_stdev ;                //业绩比较基准收益率标准差（%）     #15
    private Object       memo;                            //备注                      #16

    
    public boolean assembleMapToRept_Q_net_val(Map<String, Object> map) {
		// set primary values	//
		this.setInfo_src_code(String.valueOf(map.get("info_src_code"))); 		//信息披露类型代码		#1
		this.setQut_no(String.valueOf(map.get("qut_no"))); 						//季度编号				#2
		this.setFund_code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#0
		if (info_src_code==null 	|| "".equals(info_src_code)		||			//invalid list or not enough list's elements
			qut_no==null 			|| "".equals(qut_no)			||
			fund_code==null 		|| "".equals(fund_code)			) return false;	
		
		// set optional values	//		
		this.setC_pord_code(String.valueOf(map.get("c_Pord_Code"))); 			//账套号（外包）         #3
		if ("".equals (map.get("onum")) ||map.get("onum")==null)   this.setOnum(BigDecimal.valueOf(0f));//序号 				#4
		else this.setOnum((java.math.BigDecimal) map.get("onum"));	
		this.setCifd_fund_flag(String.valueOf(map.get("cifd_Fund_Flag")));		//分级基金标志			#5
		this.setCifd_fund_no(String.valueOf(map.get("cifd_Fund_No")));			//分级基金编号			#6
		this.setCifd_fund_name(String.valueOf(map.get("cifd_Fund_Name")));		//分级基金名称          #7 
		if ("".equals (map.get("qut_Net_Val_Irate")) ||map.get("qut_Net_Val_Irate")==null)  this.setQut_net_val_irate(BigDecimal.valueOf(0f)); 
		else this.setQut_net_val_irate((java.math.BigDecimal) map.get("qut_Net_Val_Irate")); //当季净值增长率（%） 		#8
		if ("".equals (map.get("qut_Net_Val_Irate_Stdev")) ||map.get("qut_Net_Val_Irate_Stdev")==null)  this.setNet_val_irate_stdev(BigDecimal.valueOf(0f));	
		else this.setQut_net_val_irate_stdev((java.math.BigDecimal) map.get("qut_Net_Val_Irate_Stdev"));//当季净值增长率标准差（%）  #9	
		if ("".equals (map.get("qut_pcb_Prate")) ||map.get("qut_pcb_Prate")==null)  this.setQut_pcb_prate(BigDecimal.valueOf(0f));
		else this.setQut_pcb_prate((java.math.BigDecimal) map.get("qut_pcb_Prate"));			//当季业绩比较基准收益率（%）  #10	
		if ("".equals (map.get("qut_pcb_Prate_Stdev")) ||map.get("qut_pcb_Prate_Stdev")==null)  this.setQut_pcb_prate_stdev(BigDecimal.valueOf(0f));
		else this.setQut_pcb_prate_stdev((java.math.BigDecimal) map.get("qut_pcb_Prate_Stdev"));//当季业绩比较基准收益率（%）  #11	
		if ("".equals (map.get("net_val_Irate")) ||map.get("net_val_Irate")==null)  this.setNet_val_irate(BigDecimal.valueOf(0f));
		else this.setNet_val_irate((java.math.BigDecimal) map.get("net_val_Irate"));			//净值增长率（%）		  #12
		if ("".equals (map.get("net_val_Irate_Stdev")) ||map.get("net_val_Irate_Stdev")==null)  this.setNet_val_irate_stdev(BigDecimal.valueOf(0f));
		else this.setNet_val_irate_stdev((java.math.BigDecimal) map.get("net_val_Irate_Stdev"));//净值增长率标准差（%）	  #13
		if ("".equals (map.get("pcb_Prate")) ||map.get("pcb_Prate")==null)  this.setPcb_prate(BigDecimal.valueOf(0f));
		else this.setPcb_prate((java.math.BigDecimal) map.get("pcb_Prate"));					//业绩比较基准收益率（%）     #14
		if ("".equals (map.get("pcb_Prate_Stdev")) ||map.get("pcb_Prate_Stdev")==null)  this.setPcb_prate_stdev(BigDecimal.valueOf(0f));
		else this.setPcb_prate_stdev((java.math.BigDecimal) map.get("pcb_Prate_Stdev"));		//业绩比较基准收益率（%）     #15
		this.setMemo(String.valueOf(map.get("memo")));											//备注                  #16 
               
		return true;
    }
    
	/**
	 * 
	 */
	public Rept_Q_net_val() {
		// TODO Auto-generated constructor stub
	}

	/* getters and setters */
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

	public BigDecimal getQut_net_val_irate() {
		return qut_net_val_irate;
	}

	public void setQut_net_val_irate(BigDecimal qut_net_val_irate) {
		this.qut_net_val_irate = qut_net_val_irate;
	}

	public BigDecimal getQut_net_val_irate_stdev() {
		return qut_net_val_irate_stdev;
	}

	public void setQut_net_val_irate_stdev(BigDecimal qut_net_val_irate_stdev) {
		this.qut_net_val_irate_stdev = qut_net_val_irate_stdev;
	}

	public BigDecimal getQut_pcb_prate() {
		return qut_pcb_prate;
	}

	public void setQut_pcb_prate(BigDecimal qut_pcb_prate) {
		this.qut_pcb_prate = qut_pcb_prate;
	}

	public BigDecimal getQut_pcb_prate_stdev() {
		return qut_pcb_prate_stdev;
	}

	public void setQut_pcb_prate_stdev(BigDecimal qut_pcb_prate_stdev) {
		this.qut_pcb_prate_stdev = qut_pcb_prate_stdev;
	}

	public BigDecimal getNet_val_irate() {
		return net_val_irate;
	}

	public void setNet_val_irate(BigDecimal net_val_irate) {
		this.net_val_irate = net_val_irate;
	}

	public BigDecimal getNet_val_irate_stdev() {
		return net_val_irate_stdev;
	}

	public void setNet_val_irate_stdev(BigDecimal net_val_irate_stdev) {
		this.net_val_irate_stdev = net_val_irate_stdev;
	}

	public BigDecimal getPcb_prate() {
		return pcb_prate;
	}

	public void setPcb_prate(BigDecimal pcb_prate) {
		this.pcb_prate = pcb_prate;
	}

	public BigDecimal getPcb_prate_stdev() {
		return pcb_prate_stdev;
	}

	public void setPcb_prate_stdev(BigDecimal pcb_prate_stdev) {
		this.pcb_prate_stdev = pcb_prate_stdev;
	}

	public Object getMemo() {
		return memo;
	}

	public void setMemo(Object memo) {
		this.memo = memo;
	}

}
