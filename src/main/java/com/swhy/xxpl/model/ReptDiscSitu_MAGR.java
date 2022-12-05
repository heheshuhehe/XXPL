package com.swhy.xxpl.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.fh.dao.XinxipiluDao;

public class ReptDiscSitu_MAGR {
	protected Logger logger = Logger.getLogger(this.getClass());
	// primary key
	private String disc_Type_Code;		//信息披露类型代码	#0
	private String date_No;				//日期编号			#1
	private String magr_No;				//管理人编号		#2
	private String magr_Num;             //管理人P码

	// nullable key
	private String magr_Name;			//管理人名称		#3
	private String wb_Data_Stat_Code;	//外包数据状态代码	#4
	private String tg_Data_Stat_Code;	//托管数据状态代码	#5
	private String data_Chk_Rslt_Code;	//数据核对结果代码	#6
	private String excel_Rept_Stat;		//excel报告状态	#7
	private String word_Rept_Stat;		//word报告状态		#8
	private String pdf_Rept_Stat;		//pdf报告状态		#9
	private String bill_Flag;			//清单标志			#10
	private String print_Stat;			//打印状态			#11
	private String json_File_Path;		//json文件路径		#12
	private String magr_Stat;			//管理人状态		#13
	private String rept_begn_date     ; //报告起始日期		#14
	private String rept_exp_date      ; //报告截至日期		#15
	private String rept_date          ; //报告日期			#16
	private String gbicc_exp_date     ; //
	private String ivsp_chk_rslt_code ; //
	private String gbicc_chk_rslt_code; //
	private String memo               ; //
	private String last_rept_date     ; //
	private String wb_data_stat_desc  ; //
	private Date   rect_crt_time      ; //
	private Date   snd_time           ; //
	private String   snd_flag_code    ; //
	private String   snd_bath_num     ; //
	private List<Rept_m_qunt_prfund_run> funds;
	
	public ReptDiscSitu_MAGR() {
		funds = new ArrayList<Rept_m_qunt_prfund_run>();
	}
	public ReptDiscSitu_MAGR(String disc_type_code, String date_no, String magr_No) {
		funds = new ArrayList<Rept_m_qunt_prfund_run>();
		this.setDisc_Type_Code(disc_type_code);
		this.setDate_No(date_no);
		this.setMagr_No(magr_No);
	}
	
	/**
	 * Assign a list of value into a Rept_Disc_Situ.
	 * @param list
	 * @return true if all the values are correctly loaded otherwise false
	 */
	public boolean assembleMapToRept_Disc_Situ_Magr(Map<String, Object> map) {
		if ( null == map || map.size()<1) return false;							
		
		// set primary values	//
		this.setDisc_Type_Code(String.valueOf(map.get("disc_type_code"))); 		//信息披露类型代码		#0
		this.setDate_No(String.valueOf(map.get("date_no"))); 					//日期编号				#1
		this.setMagr_No(String.valueOf(map.get("magr_no"))); 					//管理人编号			#2
		if (disc_Type_Code==null 	|| "".equals(disc_Type_Code)		||					//invalid list or not enough list's elements
			date_No==null 			|| "".equals(date_No)				||
			magr_No==null 			|| "".equals(magr_No)			) return false;		
		
		// set optional values	//		
		this.setMagr_Num(String.valueOf(map.get("magr_num"))); 					//管理人P码			#2

		this.setMagr_Name(String.valueOf(map.get("magr_name"))); 				//管理人名称			#3
		this.setWb_Data_Stat_Code(String.valueOf(map.get("wb_data_stat_code")));//外包数据状态代码		#4
		this.setTg_Data_Stat_Code(String.valueOf(map.get("tg_data_stat_code")));//托管数据状态代码		#5
		this.setData_Chk_Rslt_Code(String.valueOf(map.get("data_chk_rslt_code")));//数据核对结果代码		#6
		this.setExcel_Rept_Stat(String.valueOf(map.get("excel_rept_stat")));	//excel报告状态		#7
		this.setWord_Rept_Stat(String.valueOf(map.get("word_rept_stat")));		//word报告状态			#8
		this.setPdf_Rept_Stat(String.valueOf(map.get("pdf_rept_stat")));		//pdf报告状态			#9
		this.setBill_Flag(String.valueOf(map.get("bill_flag")));				//清单标志				#10
		this.setPrint_Stat(String.valueOf(map.get("print_stat")));				//打印状态				#11
		this.setJson_File_Path(String.valueOf(map.get("json_file_path")));		//json文件路径			#12
		this.setMagr_Stat(String.valueOf(map.get("magr_stat")));				//管理人状态			#13
		this.setRept_begn_date(String.valueOf(map.get("rept_begn_date")));		//管理人状态			#14
		this.setRept_exp_date(String.valueOf(map.get("rept_exp_date")));				//管理人状态		#13
		this.setRept_date(String.valueOf(map.get("rept_date")));				//管理人状态			#13
		this.setGbicc_exp_date(String.valueOf(map.get("gbicc_exp_date")));				//管理人状态			#13
		this.setIvsp_chk_rslt_code(String.valueOf(map.get("ivsp_chk_rslt_code")));				//管理人状态			#13
		this.setGbicc_chk_rslt_code(String.valueOf(map.get("gbicc_chk_rslt_code")));				//管理人状态			#13
		this.setMemo(String.valueOf(map.get("memo")));				//管理人状态			#13
		this.setLast_rept_date(String.valueOf(map.get("last_rept_date")));				//管理人状态			#13
		this.setWb_data_stat_desc(String.valueOf(map.get("wb_data_stat_desc")));				//管理人状态			#13
		if (map.get("rect_crt_time")==null || "".equals(map.get("rect_crt_time"))) {this.setRect_crt_time(null);}
		else {this.setRect_crt_time(Date.valueOf((String) (map.get("rect_crt_time"))));}
						//管理人状态			#13
		if (map.get("snd_time")==null || "".equals(map.get("snd_time"))) {this.setSnd_time(null);}
		else {this.setSnd_time(Date.valueOf((String) (map.get("snd_time"))));}				//管理人状态			#13
		
		this.setSnd_flag_code(String.valueOf(map.get("snd_flag_code")));				//管理人状态			#13
		this.setSnd_bath_num(String.valueOf(map.get("snd_bath_num")));				//管理人状态			#13
		
		return true;
	}	
	
	/**
	 * 装配一个list的原始数据进入 List<ReptDiscSitu>
	 * @param list
	 * @return
	 */
	public static List<ReptDiscSitu_MAGR> assembleListToRept_Disc_Situ_Magr (List <Map<String, Object>> list){
		List<ReptDiscSitu_MAGR> resultList = new ArrayList <ReptDiscSitu_MAGR> ();
		ReptDiscSitu_MAGR rds;
		for (Map<String, Object> m : list) {
			rds = new ReptDiscSitu_MAGR();
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
	public Boolean addFund(Rept_m_qunt_prfund_run r) {
		return r==null?false:(getFunds().add(r));
	}
	
	/**
	 * adding a list of Rept_m_qunt_prfund_run
	 * @param lr list of Rept_m_qunt_prfund_run
	 * @return true when success, false when failed or invalid lr
	 */
	public Boolean addFunds(List<Rept_m_qunt_prfund_run> lr) {
		return (lr==null||lr.size()<1)?false:(getFunds().addAll(lr));
	}
	
	/*
	 * public Boolean addMapsOfRawFunds() {
	 * 
	 * }
	 */
	
	/* getters and setters */
	public String getDisc_Type_Code() {
		return disc_Type_Code;
	}
	public void setDisc_Type_Code(String disc_Type_Code) {
		this.disc_Type_Code = disc_Type_Code;
	}
	public String getDate_No() {
		return date_No;
	}
	public void setDate_No(String date_No) {
		this.date_No = date_No;
	}
	public String getMagr_No() {
		return magr_No;
	}
	public void setMagr_No(String magr_No) {
		this.magr_No = magr_No;
	}
	public String getMagr_Name() {
		return magr_Name;
	}
	public void setMagr_Name(String magr_Name) {
		this.magr_Name = magr_Name;
	}
	public String getWb_Data_Stat_Code() {
		return wb_Data_Stat_Code;
	}
	public void setWb_Data_Stat_Code(String wb_Data_Stat_Code) {
		this.wb_Data_Stat_Code = wb_Data_Stat_Code;
	}
	public String getTg_Data_Stat_Code() {
		return tg_Data_Stat_Code;
	}
	public void setTg_Data_Stat_Code(String tg_Data_Stat_Code) {
		this.tg_Data_Stat_Code = tg_Data_Stat_Code;
	}
	public String getData_Chk_Rslt_Code() {
		return data_Chk_Rslt_Code;
	}
	public void setData_Chk_Rslt_Code(String data_Chk_Rslt_Code) {
		this.data_Chk_Rslt_Code = data_Chk_Rslt_Code;
	}
	public String getExcel_Rept_Stat() {
		return excel_Rept_Stat;
	}
	public void setExcel_Rept_Stat(String excel_Rept_Stat) {
		this.excel_Rept_Stat = excel_Rept_Stat;
	}
	public String getWord_Rept_Stat() {
		return word_Rept_Stat;
	}
	public void setWord_Rept_Stat(String word_Rept_Stat) {
		this.word_Rept_Stat = word_Rept_Stat;
	}
	public String getPdf_Rept_Stat() {
		return pdf_Rept_Stat;
	}
	public void setPdf_Rept_Stat(String pdf_Rept_Stat) {
		this.pdf_Rept_Stat = pdf_Rept_Stat;
	}
	public String getBill_Flag() {
		return bill_Flag;
	}
	public void setBill_Flag(String bill_Flag) {
		this.bill_Flag = bill_Flag;
	}
	public String getPrint_Stat() {
		return print_Stat;
	}
	public void setPrint_Stat(String print_Stat) {
		this.print_Stat = print_Stat;
	}
	public String getJson_File_Path() {
		return json_File_Path;
	}
	public void setJson_File_Path(String json_File_Path) {
		this.json_File_Path = json_File_Path;
	}
	public String getMagr_Stat() {
		return magr_Stat;
	}
	public void setMagr_Stat(String magr_Stat) {
		this.magr_Stat = magr_Stat;
	}
	public List<Rept_m_qunt_prfund_run> getFunds() {
		return funds;
	}
	public void setFunds(List<Rept_m_qunt_prfund_run> funds) {
		this.funds = funds;
	}
	public String getRept_begn_date() {
		return rept_begn_date;
	}
	public void setRept_begn_date(String rept_begn_date) {
		this.rept_begn_date = rept_begn_date;
	}
	public String getRept_exp_date() {
		return rept_exp_date;
	}
	public void setRept_exp_date(String rept_exp_date) {
		this.rept_exp_date = rept_exp_date;
	}
	public String getRept_date() {
		return rept_date;
	}
	public void setRept_date(String rept_date) {
		this.rept_date = rept_date;
	}
	public String getGbicc_exp_date() {
		return gbicc_exp_date;
	}
	public void setGbicc_exp_date(String gbicc_exp_date) {
		this.gbicc_exp_date = gbicc_exp_date;
	}
	public String getIvsp_chk_rslt_code() {
		return ivsp_chk_rslt_code;
	}
	public void setIvsp_chk_rslt_code(String ivsp_chk_rslt_code) {
		this.ivsp_chk_rslt_code = ivsp_chk_rslt_code;
	}
	public String getGbicc_chk_rslt_code() {
		return gbicc_chk_rslt_code;
	}
	public void setGbicc_chk_rslt_code(String gbicc_chk_rslt_code) {
		this.gbicc_chk_rslt_code = gbicc_chk_rslt_code;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getLast_rept_date() {
		return last_rept_date;
	}
	public void setLast_rept_date(String last_rept_date) {
		this.last_rept_date = last_rept_date;
	}
	public String getWb_data_stat_desc() {
		return wb_data_stat_desc;
	}
	public void setWb_data_stat_desc(String wb_data_stat_desc) {
		this.wb_data_stat_desc = wb_data_stat_desc;
	}
	public Date getRect_crt_time() {
		return rect_crt_time;
	}
	public void setRect_crt_time(Date rect_crt_time) {
		this.rect_crt_time = rect_crt_time;
	}
	public Date getSnd_time() {
		return snd_time;
	}
	public void setSnd_time(Date snd_time) {
		this.snd_time = snd_time;
	}
	public String getSnd_flag_code() {
		return snd_flag_code;
	}
	public void setSnd_flag_code(String snd_flag_code) {
		this.snd_flag_code = snd_flag_code;
	}
	public String getSnd_bath_num() {
		return snd_bath_num;
	}
	public void setSnd_bath_num(String snd_bath_num) {
		this.snd_bath_num = snd_bath_num;
	}
	public String getMagr_Num() {
		return magr_Num;
	}
	public void setMagr_Num(String magr_Num) {
		this.magr_Num = magr_Num;
	}

		
	
}
