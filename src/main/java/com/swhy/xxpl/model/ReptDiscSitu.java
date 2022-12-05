package com.swhy.xxpl.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.fh.dao.XinxipiluDao;
import com.fh.util.Const;

/**
 * MDS.ReptDiscSitu
 * @author 230355
 *
 */
@Service("ReptDiscSitu")
public class ReptDiscSitu {

//	protected  Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	private static String HASCFID = "是";

	private String disc_type_code;		//信息披露类型代码		#0
	private String date_no;				//日期编号				#1
	private String serv_scop;			//服务范围				#2
	private String fund_num;			//基金协会编号			#3
	private String fund_code;			//基金编号（综合管理平台）	#4
	private String fund_name;			//基金名称				#5
	private String rept_date;			//报告日期				#6
	private String wb_c_pord_code;		//外包账套号			#7
	private String tg_c_pord_code;		//托管账套号			#8
	private String wb_data_stat_code;	//外包数据状态代码		#9	
	private String tg_data_stat_code;	//托管数据状态代码		#10	
	private String data_chk_rslt_code;	//数据核对结果代码		#11	
	private String excel_rept_stat;		//Excel报告状态		#12	
	private String word_rept_stat;		//Word报告状态			#13
	private String pdf_rept_stat;		//PDF报告状态			#14	
	private String wb_valu_prsn_name;	//外包估值人员名称		#15	
	private String tg_valu_prsn_name;	//托管估值人员名称		#16	
	private String proj_mngr_name;		//项目经理名称			#17
	private String magr_ex_stat;		//管理人异常状态			#18
	private String fund_setp_date;		//基金成立日期			#19
	private String fund_matu_date;		//基金到期日期			#20
	private String fund_stat;			//基金状态				#21
	private String fund_type;			//基金类型				#22
	private String is_cifd;				//是否分级				#23
	private String memo;				//备注				#24
	private String print_stat;			//打印状态				#25
	private String json_file_path;		//json路径			#26
	private String bill_flag;			//清单标志				#27
	private String ivsp_chk_rslt_code;  //投监核对结果代码			#新信息披露添加字段
	private String gbicc_chk_rslt_code;  //吉贝壳核对结果代码（平台返回）	#新信息披露添加字段
	private String last_rept_date;		//上一次报告日期				#新信息披露添加字段
	private String gbicc_exp_date;		//吉贝克截至日期				#新信息披露添加字段

	private transient List<ReptMNetVal_Cifd>	ReptMNetVal_Cifds;	//子基金列表			not in database
	
	public ReptDiscSitu() {ReptMNetVal_Cifds = new ArrayList<ReptMNetVal_Cifd> ();}
	public ReptDiscSitu(String disc_type_code, String date_no, String fund_code) {
		ReptMNetVal_Cifds = new ArrayList<ReptMNetVal_Cifd> ();
		this.setDisc_type_code(disc_type_code);
		this.setDate_no(date_no);
		this.setFund_code(fund_code);
	}
	
	/**
	 * Assign a list of value into a Rept_Disc_Situ.
	 * @param list
	 * @return true if all the values are correctly loaded otherwise false
	 */
	public boolean assembleMapToRept_Disc_Situ(Map<String, Object> map) {
		if ( null == map || map.size()<1) return false;							
		
		// set primary values	//
		this.setDisc_type_code(String.valueOf(map.get("disc_type_code"))); 		//信息披露类型代码		#0
		this.setDate_no(String.valueOf(map.get("date_no"))); 					//日期编号				#1
		this.setFund_code(String.valueOf(map.get("fund_code"))); 				//基金编号（综合管理平台）	#4
		if (disc_type_code==null 	|| "".equals(disc_type_code)		||					//invalid list or not enough list's elements
			date_no==null 			|| "".equals(date_no)				||
			fund_code==null 		|| "".equals(fund_code)			) return false;		
		
		// set optional values	//		
		this.setServ_scop(String.valueOf(map.get("serv_scop"))); 				//服务范围				#2
		this.setFund_num(String.valueOf(map.get("fund_num"))); 					//基金协会编号			#3
		this.setFund_name(String.valueOf(map.get("fund_name"))); 				//基金名称				#5
		this.setRept_date(String.valueOf(map.get("rept_date"))); 				//报告日期				#6
		this.setWb_c_pord_code(String.valueOf(map.get("wb_c_pord_code"))); 		//外包账套号			#7
		this.setTg_c_pord_code(String.valueOf(map.get("tg_c_pord_code"))); 		//托管账套号			#8		 			
		this.setWb_data_stat_code(String.valueOf(map.get("wb_data_stat_code")));//外包数据状态代码		#9		 			
		this.setTg_data_stat_code(String.valueOf(map.get("tg_data_stat_code")));//托管数据状态代码		#10		 			
		this.setData_chk_rslt_code(String.valueOf(map.get("data_chk_rslt_code"))); //数据核对结果代码		#11		 			
		this.setExcel_rept_stat(String.valueOf(map.get("excel_rept_stat"))); 	//Excel报告状态		#12		 			
		this.setWord_rept_stat(String.valueOf(map.get("word_rept_stat"))); 		//Word报告状态			#13		 			
		this.setPdf_rept_stat(String.valueOf(map.get("pdf_rept_stat"))); 		//PDF报告状态			#14		 			
		this.setWb_valu_prsn_name(String.valueOf(map.get("wb_valu_prsn_name")));//外包估值人员名称		#15		 			
		this.setTg_valu_prsn_name(String.valueOf(map.get("tg_valu_prsn_name")));//托管估值人员名称		#16		 			
		this.setProj_mngr_name(String.valueOf(map.get("proj_mngr_name"))); 		//项目经理名称			#17		 			
		this.setMagr_ex_stat(String.valueOf(map.get("magr_ex_stat"))); 			//管理人异常状态			#18	 			
		this.setFund_setp_date( (new StringBuilder (String.valueOf(map.get("fund_setp_date"))).insert(4, "/")).toString()
				); 		//基金成立日期			#19		 			
		this.setFund_matu_date(String.valueOf(map.get("fund_matu_date"))); 		//基金到期日期			#20		 			
		this.setFund_stat(String.valueOf(map.get("fund_stat"))); 				//基金状态				#21		 			
		this.setFund_type(String.valueOf(map.get("fund_type"))); 				//基金类型				#22		
		this.setIs_cifd(String.valueOf(map.get("is_cifd"))); 					//是否分级				#23		
		this.setMemo(String.valueOf(map.get("memo"))); 							//备注				#24		 	
		this.setPrint_stat(String.valueOf(map.get("print_stat"))); 				//打印状态				#25	 			
		this.setJson_File_Path(String.valueOf(map.get("json_file_path"))); 		//json路径			#26		 			
		this.setBill_flag(String.valueOf(map.get("bill_flag"))); 				//清单标志				#27
		this.setGbicc_chk_rslt_code(String.valueOf(map.get("gbicc_chk_rslt_code"))); 				
		this.setGbicc_exp_date(String.valueOf(map.get("gbicc_exp_date"))); 	
		this.setData_chk_rslt_code(String.valueOf(map.get("data_chk_rslt_code"))); 	
		this.setIvsp_chk_rslt_code(String.valueOf(map.get("ivsp_chk_rslt_code"))); 	

		
		

		
//		if (hasCFID()) setReptMNetVal_Cifds( 	);
		return true;
	}	
	
	/**
	 * 装配一个list的原始数据进入 List<ReptDiscSitu>
	 * @param list
	 * @return
	 */
	public static List<ReptDiscSitu> assembleListToRept_Disc_Situ (List <Map<String, Object>> list){
		List<ReptDiscSitu> resultList = new ArrayList <ReptDiscSitu> ();
		ReptDiscSitu rds;
		for (Map<String, Object> m : list) {
			rds = new ReptDiscSitu();
			rds.assembleMapToRept_Disc_Situ(m);
			resultList.add(rds);
		}
		return resultList;
	}
	
	public boolean hasCFID() {
		return this.getIs_cifd()!=null && this.getIs_cifd().equals(HASCFID);
	}
	
	/* getters and setters */
	public String getDisc_type_code() {
		return disc_type_code;
	}

	public void setDisc_type_code(String disc_type_code) {
		this.disc_type_code = disc_type_code;
	}

	public String getDate_no() {
		return date_no;
	}

	public void setDate_no(String date_no) {
		this.date_no = date_no;
	}

	public String getServ_scop() {
		return serv_scop;
	}

	public void setServ_scop(String serv_scop) {
		this.serv_scop = serv_scop;
	}

	public String getFund_num() {
		return fund_num;
	}

	public void setFund_num(String fund_num) {
		this.fund_num = fund_num;
	}

	public String getFund_code() {
		return fund_code;
	}

	public void setFund_code(String fund_code) {
		this.fund_code = fund_code;
	}

	public String getFund_name() {
		return fund_name;
	}

	public void setFund_name(String fund_name) {
		this.fund_name = fund_name;
	}

	public String getRept_date() {
		return rept_date;
	}

	public void setRept_date(String rept_date) {
		this.rept_date = rept_date;
	}

	public String getWb_c_pord_code() {
		return wb_c_pord_code;
	}

	public void setWb_c_pord_code(String wb_c_pord_code) {
		this.wb_c_pord_code = wb_c_pord_code;
	}

	public String getTg_c_pord_code() {
		return tg_c_pord_code;
	}

	public void setTg_c_pord_code(String tg_c_pord_code) {
		this.tg_c_pord_code = tg_c_pord_code;
	}

	public String getWb_data_stat_code() {
		return wb_data_stat_code;
	}

	public void setWb_data_stat_code(String wb_data_stat_code) {
		this.wb_data_stat_code = wb_data_stat_code;
	}

	public String getTg_data_stat_code() {
		return tg_data_stat_code;
	}

	public void setTg_data_stat_code(String tg_data_stat_code) {
		this.tg_data_stat_code = tg_data_stat_code;
	}

	public String getData_chk_rslt_code() {
		return data_chk_rslt_code;
	}

	public void setData_chk_rslt_code(String data_chk_rslt_code) {
		this.data_chk_rslt_code = data_chk_rslt_code;
	}

	public String getExcel_rept_stat() {
		return excel_rept_stat;
	}

	public void setExcel_rept_stat(String excel_rept_stat) {
		this.excel_rept_stat = excel_rept_stat;
	}

	public String getWord_rept_stat() {
		return word_rept_stat;
	}

	public void setWord_rept_stat(String word_rept_stat) {
		this.word_rept_stat = word_rept_stat;
	}

	public String getPdf_rept_stat() {
		return pdf_rept_stat;
	}

	public void setPdf_rept_stat(String pdf_rept_stat) {
		this.pdf_rept_stat = pdf_rept_stat;
	}

	public String getWb_valu_prsn_name() {
		return wb_valu_prsn_name;
	}

	public void setWb_valu_prsn_name(String wb_valu_prsn_name) {
		this.wb_valu_prsn_name = wb_valu_prsn_name;
	}

	public String getTg_valu_prsn_name() {
		return tg_valu_prsn_name;
	}

	public void setTg_valu_prsn_name(String tg_valu_prsn_name) {
		this.tg_valu_prsn_name = tg_valu_prsn_name;
	}

	public String getProj_mngr_name() {
		return proj_mngr_name;
	}

	public void setProj_mngr_name(String proj_mngr_name) {
		this.proj_mngr_name = proj_mngr_name;
	}

	public String getMagr_ex_stat() {
		return magr_ex_stat;
	}

	public void setMagr_ex_stat(String magr_ex_stat) {
		this.magr_ex_stat = magr_ex_stat;
	}

	public String getFund_setp_date() {
		return fund_setp_date;
	}

	public void setFund_setp_date(String fund_setp_date) {
		this.fund_setp_date = fund_setp_date;
	}

	public String getFund_matu_date() {
		return fund_matu_date;
	}

	public void setFund_matu_date(String fund_matu_date) {
		this.fund_matu_date = fund_matu_date;
	}

	public String getFund_stat() {
		return fund_stat;
	}

	public void setFund_stat(String fund_stat) {
		this.fund_stat = fund_stat;
	}

	public String getFund_type() {
		return fund_type;
	}

	public void setFund_type(String fund_type) {
		this.fund_type = fund_type;
	}

	public String getIs_cifd() {
		return is_cifd;
	}

	public void setIs_cifd(String is_cifd) {
		this.is_cifd = is_cifd;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getPrint_stat() {
		return print_stat;
	}
	public void setPrint_stat(String print_stat) {
		this.print_stat = print_stat;
	}
	public String getJson_File_Path() {
		return json_file_path;
	}
	public void setJson_File_Path(String json_File_Path) {
		this.json_file_path = json_File_Path;
	}
	public String getBill_flag() {
		return bill_flag;
	}
	public void setBill_flag(String bill_flag) {
		this.bill_flag = bill_flag;
	}
	public String getJson_file_path() {
		return json_file_path;
	}
	public void setJson_file_path(String json_file_path) {
		this.json_file_path = json_file_path;
	}
	public List<ReptMNetVal_Cifd> getReptMNetVal_Cifds() {
		return ReptMNetVal_Cifds;
	}
	public void setReptMNetVal_Cifds(List<ReptMNetVal_Cifd> reptMNetVal_Cifds) {
		ReptMNetVal_Cifds = reptMNetVal_Cifds;
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
	public String getLast_rept_date() {
		return last_rept_date;
	}
	public void setLast_rept_date(String last_rept_date) {
		this.last_rept_date = last_rept_date;
	}
	public String getGbicc_exp_date() {
		return gbicc_exp_date;
	}
	public void setGbicc_exp_date(String gbicc_exp_date) {
		this.gbicc_exp_date = gbicc_exp_date;
	}
	
	

}
