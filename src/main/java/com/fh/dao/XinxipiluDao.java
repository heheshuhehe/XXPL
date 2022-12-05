package com.fh.dao;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.sql.DataSource;
import javax.sql.rowset.serial.SerialClob;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.stereotype.Repository;

import com.fh.controller.system.util.HttpClientUtils;

import com.fh.service.XinXiPiLuYueBaoServiceNew;

import com.fh.util.Const;
import com.fh.util.Constants;
import com.fh.util.DaoUtil;
import com.fh.util.PageData;
import com.fh.util.PropertyUitls;
import com.fh.util.mail.SendMail;
import com.fh.util.sql.SqlCommonUtil;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptDiscSitu_MAGR;
import com.swhy.xxpl.model.ReptMFundInfo;
import com.swhy.xxpl.model.ReptMNetVal;
import com.swhy.xxpl.model.ReptMNetVal_Cifd;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.Rept_M_Magr_Info;
import com.swhy.xxpl.model.Rept_m_qunt_prfund_run;
import com.swhy.xxpl.model.jibao.Rept_Q_net_val;

@Repository("xinXinPiLuDao")
public class XinxipiluDao {
	protected Logger logger = Logger.getLogger(this.getClass());
	// SQL scripts
	private final String GET1REPTMINFOBYFUNDCODESQL 			= "get1ReptMInfoByFundCode.txt";				//通过fundcode 获取一个 minfo
	private final String GET1REPTMNETVALBYFUNDCODESQL 			= "get1ReptMNetVALByFundCode.txt";				//通过fundcode 获取一个 mnet
	private final String GET1DISCTCHKRSLTBYFUNDCODE_TYPE_MONTHSQL 	= "get1DisctChkRsltByFundCode_Type_MonthSQL.txt";
	private final String GET1DISCSITUBYDISCTYPECODEAND 			= "get1DiscSituByDisctypecodeand.txt";
	private final String GET1MONTHREPTDISCSITU 					= "get1MonthReptDiscSitu.txt";
	private final String GETALLMONTHS							= "getAllMonthsSQL.txt";
	private final String GETALLQUATERS							= "getAllQuatersSQL.txt";
	private final String UPDATEREPTDISCSITUPRINTSTATUS			= "updateReptDiscSituPrintStatus.txt";
	private final String UPDATEREPTDISCSITU_MAGR_PRINTSTATUS	= "updateReptDiscSituMagrPrintStatus.txt";
	private final String GETPATHS								= "getPaths.txt";
	private final String GETALLFUNDNAMES						= "getAllFundNames.txt";
	private final String GET1MONTHLYDISCTCHKRSLT				= "get1MonthlyDisctChkRsltData.txt";
	private final String GETREPT_M_QUNT_PRFUND_RUNBYMGRORMONTH	= "getRept_m_qunt_prfund_runByMgrOrMonth.txt";
	private final String GETALLQUANTMONTHSSQL 					= "getAllQuantMonthsSQL.txt";
	private final String GETALLMANAGERSNAME 					= "getAllManagersName.txt";
	private final String GET1MONTHLYMANAGERS					= "get1MonthlyManagers.txt";			
	private final String GET1LISTOFDISCSITUNETVAL_CIFD			= "get1ListToFDiscSituNetval_Cifd.txt";
	private final String GET1MANAGERINFO						= "get1monthlymanagerinfo.txt";
	private final String PROCRECOLLECTIONMONTHFUNDS				= "procrecollectionmonthfunds.txt";
	private final String GET1QUATERREPTDISCSITU					= "get1QuaterReptDiscSitu.txt";
	private final String GETJIBAOINSTANCEBYFUNDCODE_QUTNO_INFO_SRC_CODE
																= "getjibaoinstancebyfundcode_qutno_info_src_code.txt";
	private final String GET1QUATERUPDATEREPTDISCSITU 			= "get1quater_update_reptdiscsitu.txt";
	private final String GET1MANAGERFUNDCHKRESULT	 			= "getManagerFundCHKresult.txt";
	private final String MONTH = "month";
	private final String QUATER = "quater";
	private final String QUATERUPDATE = "quaterUpdate";
	private final String HSR = "HSR";

	
	 SimpleDateFormat sdf8=new SimpleDateFormat("yyyyMMdd");

	
//	@Resource(name = "datasourceXXPLTG") 		// 恒生托管 数据库
//	DataSource dsXXPLTG;

	@Resource(name = "datasourceXXPLHD") 		// 核对 应用数据库
	DataSource dsXXPLHD;
	
	@Resource(name = "datasourceXXPLHDMDS")
	DataSource datasourceXXPLHDMDS;
	
	@Resource(name = "rept_Disct_Chk_Rslt") 	// 核对结果 模型
	Rept_Disct_Chk_Rslt  rept_Disct_Chk_Rslt;
	
	public XinxipiluDao() {
	}
	
	/**
	 * 按fund Code 获取一个基金的月报的fundinfo,基金属性信息
	 * @param fundCode
	 * @return
	 * @throws IOException 
	 */
	public ReptMFundInfo get1MInfoByFundCode(String fundCode, String WaibaoOrTuoguan, String MonthNO) throws IOException {
		/* 1. 判断合法fundCode */
		if (!ReptMNetVal.isValid(fundCode))
			return null;
		ReptMFundInfo reptMFundInfo = new ReptMFundInfo(WaibaoOrTuoguan);
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1REPTMINFOBYFUNDCODESQL);//
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, fundCode, WaibaoOrTuoguan, MonthNO);
//			//logger.info("sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,
					sqlScript, null);
//			//logger.info(list.toString());
			if (list!=null && list.size()>0)
				reptMFundInfo.assembleMapToReptMFundInfo(list.get(0));
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return reptMFundInfo;
	}

	/**
	 * 按fund Code, 外包/托管, 月份获取一个基金的月报的fundNetVal, 基金核对信息
	 * @param fundCode
	 * @return
	 * @throws IOException 
	 */
	public ReptMNetVal get1MNetValByFundCode(String fundCode, String WaibaoOrTuoguan, String MonthNO) throws Exception {
		
		/* 1. 判断合法fundCode */
		if (!ReptMNetVal.isValid(fundCode)) return null;
			
		ReptMNetVal reptMNetVal = new ReptMNetVal();
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1REPTMNETVALBYFUNDCODESQL);//" SELECT * from tgcbs.TTMP_H_GZB where L_ZTBH = '" + fundCode + "  ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, fundCode, WaibaoOrTuoguan, MonthNO);
//			//logger.info("sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
			if (list==null || list.isEmpty()) throw new Exception("查询该产品的净值表出错:"+fundCode + ", MonthNO:"+MonthNO);

			reptMNetVal.assembleMapToReptMNetVal(list.get(0));
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return reptMNetVal;
	}

	/**
	 * 
	 * @param fundCode
	 * @param serviceType
	 * @param dateNO: MonthNO
	 * @return
	 * @throws IOException
	 */
	public List<Rept_Disct_Chk_Rslt> get1FundListDisctChkRsltByType_Month_FundCode(String serviceType, String dateNO, String fundCode) throws IOException {
		/* 1. 判断合法fundCode, ServiceType, MonthNo */
		if (!Rept_Disct_Chk_Rslt.isValid(fundCode,serviceType, dateNO )) return null; 
		Rept_Disct_Chk_Rslt rept_Disct_Chk_Rslt = new Rept_Disct_Chk_Rslt(fundCode,serviceType, dateNO);
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1DISCTCHKRSLTBYFUNDCODE_TYPE_MONTHSQL);//" SELECT * from tgcbs.TTMP_H_GZB where L_ZTBH = '" + fundCode + "  ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, serviceType, dateNO, fundCode);
//			//logger.info("prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("the record select is: "+list.toString());
			return Rept_Disct_Chk_Rslt.assembleListToRept_Disct_Chk_Rslts(list);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return null;
	}
	
	/**
	 * 获取某个月的reptdiscsitu，若输入月份非法则直接返回空
	 * @param month_no
	 * @return 
	 * @throws DecoderException 
	 */
	public List<Map<String,Object>> get1MonthReptDiscSitu (String dateNo, String heDuiBuYiZhi, String fundName, String data_chk_rslt_code, String gbicc_chk_rslt_code
,String serv_scop, String sort, String order, String gzry,String reportType, String ivsp_chk_rslt_code) throws DecoderException{
		/* 1. MonthNo */
		if (dateNo==null || "".equals(dateNo)) return null;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			if (fundName==null) fundName="";
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MONTHREPTDISCSITU);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,  dateNo,"%"+ fundName +"%", reportType);
			
//			if (heDuiBuYiZhi!=null) sqlScript += " and data_chk_rslt_code = '"+heDuiBuYiZhi+"' ";	//checkbox for 核对不一致
			
			if (ivsp_chk_rslt_code!=null) sqlScript += "and ivsp_chk_rslt_code in (" +ivsp_chk_rslt_code+") ";	//投监核对
			
			if (data_chk_rslt_code!=null) sqlScript += "and data_chk_rslt_code in (" +data_chk_rslt_code+") ";	//核对状态
			
			if (gbicc_chk_rslt_code!=null) sqlScript += "and gbicc_chk_rslt_code = '" +gbicc_chk_rslt_code+"' ";	//吉贝克状态

			if (serv_scop!=null) sqlScript += "and serv_scop = '" +serv_scop+"' ";
			
			if (gzry!=null && !"".equals(gzry)) {gzry = gzry.replace(",", "','");sqlScript += "and WB_VALU_PRSN_NAME in ('"+gzry+"') ";}
			
			if (sort!=null) {sqlScript += " order by "+sort; }
			else 			{sqlScript += " order by fund_code"; }
			
			if (order!=null) sqlScript += " "+order;
			else 			{sqlScript += " "+"DESC"; }

			logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
			return list;
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}		
	}	
	
	public List<Map<String,Object>> get1quaterReptDiscSitu (String quater_NO, String heDuiBuYiZhi, String fundName, String data_chk_rslt_code, String gbicc_chk_rslt_code,
			String serv_scop, String waibaoshuju,String sort, String order, String quaterlyOrUpdate) throws DecoderException{
		/* 1. QuaterNO */
		if (quater_NO==null || "".equals(quater_NO)) return null;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			if (fundName==null) fundName="";
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1QUATERREPTDISCSITU);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, quater_NO,"%"+ fundName +"%", quaterlyOrUpdate);
			
//			if (heDuiBuYiZhi!=null) sqlScript += " and data_chk_rslt_code = '"+heDuiBuYiZhi+"' ";	//checkbox for 核对不一致
			
			if (data_chk_rslt_code!=null) sqlScript += "and data_chk_rslt_code = '" +data_chk_rslt_code+"' ";	//核对状态
			
			if (gbicc_chk_rslt_code!=null) sqlScript += "and gbicc_chk_rslt_code = '" +gbicc_chk_rslt_code+"' ";	//吉贝克状态
			
			if (serv_scop!=null) sqlScript += "and serv_scop = '" +serv_scop+"' ";
			
			if (waibaoshuju!=null && !"".equals(waibaoshuju)) sqlScript += "and WB_DATA_STAT_CODE = '" +waibaoshuju+"' ";
			
			if (sort!=null) sqlScript += " order by "+sort;
			
			if (order!=null) sqlScript += " "+order;

			//logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+quater_NO);
			return list;
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}	
	}
	
	public List<Map<String,Object>> get1quaterUpdateReptDiscSitu (String quater_NO, String heDuiBuYiZhi, String fundName, String sort, String order) throws DecoderException{
		/* 1. QuaterNO */
		if (quater_NO==null || "".equals(quater_NO)) return null;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			if (fundName==null) fundName="";
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1QUATERUPDATEREPTDISCSITU);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, quater_NO,"%"+ fundName +"%");
			
			if (heDuiBuYiZhi!=null) sqlScript += " and data_chk_rslt_code = '"+heDuiBuYiZhi+"' ";	//checkbox for 核对不一致
			
			if (sort!=null) sqlScript += " order by "+sort;
			
			if (order!=null) sqlScript += " "+order;

			//logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+quater_NO);
			return list;
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}	
	}	
	
		
	
	/**
	 * 为携带子基金的discsitu获取一个list的子基金
	 * @param fund_Code
	 * @param info_src_code
	 * @param mth_NO
	 * @param subf_Code
	 * @return
	 */
	public List<ReptMNetVal_Cifd> get1ListOfDiscSituNetVal_Cifd (String fund_Code, String info_src_code, String mth_NO, String subf_Code){
		List<ReptMNetVal_Cifd> reptMNetVal_Cifds = new LinkedList<ReptMNetVal_Cifd> () ;
		/* 1. MonthNo */
		if ( (mth_NO==null || "".equals(mth_NO)) && fund_Code == null) return null;
		if (info_src_code==null) info_src_code = Const.WAIBAO;
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1LISTOFDISCSITUNETVAL_CIFD);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, info_src_code);
			
			if (fund_Code!=null) sqlScript += " and fund_Code = "+fund_Code+" ";	//
			
			if (mth_NO!=null) sqlScript += " and mth_NO = "+mth_NO+" ";	//checkbox for 核对不一致

			sqlScript= sqlScript + "  order by SHR_CLAS  ";
			//logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("There are _"+list.size()+"_ NetVal_Cifd  records for " + fund_Code);
			
			for (Map<String,Object> map : list) {
				ReptMNetVal_Cifd reptMNetVal_Cifd = new ReptMNetVal_Cifd();
				reptMNetVal_Cifd.assembleMapToReptMNetVal(map);
				reptMNetVal_Cifds.add(reptMNetVal_Cifd);
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}		
		
		return reptMNetVal_Cifds;
	}
	
	/**
	 * 获取某个月的DisctChkRslt，若月份非法则直接返回空
	 * @param month_no		比如202109
	 * @param heDuiYiZhi 	CHK_RSLT_CODE=0 THEN '未核对' 
							CHK_RSLT_CODE=1 THEN '核对一致' 
							CHK_RSLT_CODE=2 THEN '核对不一致' 
							CHK_RSLT_CODE=9 THEN '不需要核对' 
	 * @param disc_type_code 披露类型		
	 * @param fundCode		基金编号或管理人编号magr_no	。	
	 * @return list
	 * @throws DecoderException 
	 */
	public List<Map<String,Object>> get1PeriodlyDisctChkRsltData(String report_type, String month_no, String heDuiYiZhi, String fundName, String fundCode) throws DecoderException{

		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MONTHLYDISCTCHKRSLT);
			if ("M2".equals(report_type) || "SMO".equals(report_type)) {
				sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MANAGERFUNDCHKRESULT);
			}
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,report_type, month_no);
			if (fundName!=null && !"".equals(fundName))sqlScript=sqlScript+"AND t2.FUND_NAME like  '%"+fundName+"%'  ";
			if (heDuiYiZhi==null) sqlScript=sqlScript+" AND CHK_RSLT_CODE <> 1 ";		//查询核对一致的结果
			if (fundCode!=null && !"".equals(fundCode)) {
				if ("M2".equals(report_type) || "SMO".equals(report_type)) {
					sqlScript=sqlScript+" and t1.MAGR_NO =  '"+fundCode+"'  ";
				}else {
					sqlScript=sqlScript+"AND t2.fund_code =  '"+fundCode+"'  ";
				}
			}
			sqlScript+="order by fund_code, src_tab_onum ,indx_dim , src_fld_onum";
			logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("There are _"+list.size()+"_ ReptDisctChk records in "+month_no);
			return list;
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}		
	}	
	

	
	/**
	 * 获取某一个的DisctChkRslt，若月份非法则直接返回空
	 * @param report_type
	 * @param date_no
	 * @param fund_code
	 * @param indx_src_tab
	 * @param indx_src_fld
	 * @param indx_dim
	 * @return
	 * @throws DecoderException
	 */
	public Rept_Disct_Chk_Rslt get1DisctChkRsltData(String report_type, String date_no, String fund_code, String indx_src_tab, String indx_src_fld, String indx_dim, String magr_no) throws DecoderException{
		/* 1. MonthNo */
		//if (month_no==null || "".equals(month_no)) return null;
		String magr_noString = "";
		if (magr_no!=null) magr_noString = " and magr_no = "+magr_no+" ";
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = 
				  "select * from "
				+ "rept_disc_chk_rslt "
				+ "where DISC_TYPE_CODE = ? and date_no = ? and fund_code = ? and "
				+ "indx_src_tab =  ? and indx_src_fld= ? and indx_dim = ? "
				+ magr_noString;
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,report_type, date_no,fund_code, indx_src_tab,indx_src_fld,indx_dim);
			logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
			Rept_Disct_Chk_Rslt rdcr = new Rept_Disct_Chk_Rslt();
			rdcr.assembleMapToRept_Disct_Chk_Rslt(list.get(0));
//			logger.info("There are _"+list.size()+"_ ReptDisctChk records in "+month_no);
			return rdcr;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}		
	}	
	
	/**
	 * 获取某个月的DisctChkRslt，若月份非法则直接返回空
	 * @param month_no		比如202109
	 * @param heDuiYiZhi 	CHK_RSLT_CODE=0 THEN '未核对' 
							CHK_RSLT_CODE=1 THEN '核对一致' 
							CHK_RSLT_CODE=2 THEN '核对不一致' 
							CHK_RSLT_CODE=9 THEN '不需要核对' 
	 * @return list
	 * @throws DecoderException 
	 */
	public List<Map<String,Object>> get1QuaterlyDisctChkRsltData(String month_no, String heDuiYiZhi, String fundName) throws DecoderException{
		/* 1. MonthNo */
		//if (month_no==null || "".equals(month_no)) return null;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = "\r\n"
					+ "\r\n"
					+ "SELECT \r\n"
					+ "	DISC_TYPE_CODE,\r\n"
					+ "	DATE_NO,\r\n"
					+ "	FUND_CODE,\r\n"
					+ "	FUND_NAME,\r\n"
					+ "	substr(REPT_DATE,1,4)||'/'||substr(REPT_DATE,5,2)||'/'||substr(REPT_DATE,7) as REPT_DATE,	\r\n"
					+ "	INDX_NAME,\r\n"
					+ "	INDX_DIM,\r\n"
					+ "	WB_DATA,\r\n"
					+ "	TG_DATA,\r\n"
					+ "	UPD_AFT_DATA,\r\n"
					+ "	UPDER_IP,\r\n"
					+ "	(CASE WHEN CHK_RSLT_CODE=0 THEN '未核对' \r\n"
					+ "		  WHEN CHK_RSLT_CODE=1 THEN '核对一致' \r\n"
					+ "		  WHEN CHK_RSLT_CODE=2 THEN '核对不一致' \r\n"
					+ "		  WHEN CHK_RSLT_CODE=9 THEN '不需要核对' \r\n"
					+ "		  ELSE '' end)  \r\n"
					+ "	AS CHK_RSLT_CODE \r\n"
					+ "\r\n"
					+ "FROM	\r\n"
					+ "	mds.REPT_DISC_CHK_RSLT  \r\n"
					+ "Where\r\n"
					+ "	DATE_NO = ? \r\n"
					+ "	AND FUND_NAME like ?  \r\n"
					+ "	AND 1=1\r\n"
					+ "	AND	DISC_TYPE_CODE = 'Q' ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, month_no,"%"+ fundName +"%");

			if (heDuiYiZhi==null) sqlScript=sqlScript+" AND CHK_RSLT_CODE <> 1 ";		//查询核对一致的结果
			//logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("There are _"+list.size()+"_ ReptDisctChk records in "+month_no);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}		
	}	
	
	/**
	 * 通过主键选取某一个DISCSITU
	 * @param serviceType
	 * @param dateNO
	 * @param fundCode
	 * @return
	 * @throws Exception 
	 */
	public ReptDiscSitu get1DiscSituByType_Month_FundCode(String serviceType, String dateNO,String fundCode) throws Exception {
		
		/* 1. 判断合法fundCode， ServiceType, MonthNo */
		ReptDiscSitu reptDiscSitu = new ReptDiscSitu(fundCode,serviceType, dateNO);
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		String sqlScript = "";
		try {
			con = datasourceXXPLHDMDS.getConnection();
			sqlScript = SqlCommonUtil.getSQLTXT(this.GET1DISCSITUBYDISCTYPECODEAND);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, serviceType, dateNO, fundCode);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("the record select is: "+list.toString());
			if (list==null || list.isEmpty()) throw new SQLException("cannot find product by fundcode:"+fundCode + ", dateNO:"+dateNO);
			reptDiscSitu.assembleMapToRept_Disc_Situ(list.get(0));
			if (reptDiscSitu.hasCFID())reptDiscSitu.setReptMNetVal_Cifds(get1ListOfDiscSituNetVal_Cifd(
					reptDiscSitu.getFund_code(), 
					Const.WAIBAO, 
					reptDiscSitu.getDate_no(), null));
		} catch (SQLException e) {
			logger.info("prepared sql is "+sqlScript);
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}
		return reptDiscSitu;
	}
	
	
	/**
	 * 通过主键选取某一个manager
	 * @param disc_Type_Code
	 * @param dateNO
	 * @param managerName
	 * @param order
	 * @param sort
	 * @return
	 * @throws IOException
	 */
	public List<Map<String, Object>> get1MonthlyManagerData(String disc_Type_Code, String dateNO, String managerName, String order, String sort, String managerNO, String isPrinted) throws IOException {
		
		/* 1. 判断合法fundCode， ServiceType, MonthNo */
		if (disc_Type_Code==null || dateNO==null || managerName==null) return null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>> ();
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MONTHLYMANAGERS);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, "%"+managerName+"%", disc_Type_Code, dateNO);
			if (managerNO!=null) sqlScript= sqlScript + " and MAGR_NO = "+ managerNO + "  ";
			if (isPrinted!=null && !"".equals(isPrinted)) sqlScript= sqlScript + " and GBICC_CHK_RSLT_CODE = "+ isPrinted + "  ";

			logger.info("get1MonthlyManagerDatasql is "+sqlScript);
			list = DaoUtil.getResultToList(con,sqlScript);
//			//logger.info("the record select is: "+list.toString());
			//managerNo.assembleMapToRept_Disc_Situ(list.get(0));
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}
		return list;
	}
	

	/**
	 * 输出json时填写量化基金excel模板所用的信息
	 * @param magr_no
	 * @param info_src_code
	 * @param mth_no
	 * @return
	 * @throws IOException
	 */
	public Rept_M_Magr_Info get1MonthlyReptManagerInfo(String magr_no, String info_src_code, String mth_no) throws IOException {
		
		/* 1. 判断合法fundCode， ServiceType, MonthNo */
		if (magr_no==null || info_src_code==null || mth_no==null) return null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>> ();
		
		Rept_M_Magr_Info rept_M_Magr_Info=new Rept_M_Magr_Info();
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MANAGERINFO);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, magr_no, info_src_code, mth_no);
			
			logger.info("prepared sql is "+sqlScript);
			list = DaoUtil.getResultToList(con,sqlScript);
			rept_M_Magr_Info.assembleMapToRept_Disc_Situ_Magr(list.get(0));
//			//logger.info("the record select is: "+list.toString());
			//managerNo.assembleMapToRept_Disc_Situ(list.get(0));
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}
		return rept_M_Magr_Info;
	}	
	/**
	 * 按managerNo,monthNO,fund_Code,info_Src_code 找多个量化基金月报
	 * @param managerNO
	 * @param monthNo
	 * @param fund_Code
	 * @param info_Src_Code
	 * @return
	 * @throws IOException
	 */
	public List<Rept_m_qunt_prfund_run> getRept_m_qunt_prfund_runByMgrOrMonth(String managerNO, String monthNo, String fund_Code, String info_Src_Code,String fundName ) throws IOException {
		/* 1. 判断参数合法 */
		if (/* managerNO==null && */monthNo==null) return null;
		List<Rept_m_qunt_prfund_run> resultlist = new ArrayList<Rept_m_qunt_prfund_run> ();
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETREPT_M_QUNT_PRFUND_RUNBYMGRORMONTH);//
			if (managerNO!=null) sqlScript = sqlScript + " AND MAGR_NO = "+ managerNO + " ";
			if (monthNo!=null) sqlScript = sqlScript + " AND MTH_NO = "+ monthNo + " ";
			if (fundName!=null) sqlScript = sqlScript + "AND FUND_NAME LIKE %"+fundName+"% ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
			//logger.info("sql is "+sqlScript);
			List<Map<String, Object>> list = DaoUtil.getResultToList(con,
					sqlScript, null);
//			//logger.info(list.toString());
			if (list!=null && list.size()>0) 
				resultlist=Rept_m_qunt_prfund_run.assembleListToRept_m_qunt_prfund_run(list);
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return null;
		} finally {
			DaoUtil.release(con);
		}
		return resultlist;
	}
	
	/**
	 * return all the distinct Date( month, quarter) that already exist in database
	 * @param dateType
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public  List<Map<String,String>> getAllDateOptions ( String dateType ) throws IOException,Exception{
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		String sQLpath="";

		sQLpath = dateType.equals(MONTH)?dateType:QUATER;
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETALLMONTHS);
			if (QUATER.equals(sQLpath))sqlScript=SqlCommonUtil.getSQLTXT(this.GETALLQUATERS);
			if (HSR.equals(dateType.toUpperCase())) {
				sqlScript ="select distinct  date_no   as value from MDS.REPT_DISC_SITU where DISC_TYPE_CODE ='HSR' order BY date_no DESC ";
			}
			if (Constants.SMO.equals(dateType.toUpperCase())) {
				sqlScript ="select distinct  date_no   as value from MDS.REPT_DISC_SITU_MAGR where DISC_TYPE_CODE ='SMO' order BY date_no DESC ";
			}
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
			//logger.info("prepared sql is " + sqlScript);
			List<Map<String,Object>> list= DaoUtil.getResultToList(con,sqlScript);
			Integer i=0;
			for (Map<String, Object> map: list){
				map.put("id", String.valueOf(i++));
				Map<String,String> newMap = map.entrySet().stream()
					     .collect(Collectors.toMap(Map.Entry::getKey, e -> (String)e.getValue()));
				resultList.add(newMap);
			}
//			//logger.info("the record select is: "+resultList.toString());
			
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return resultList;
	}

	
	/**
	 * return all the distinct Date( month, quarter) that already exist in database
	 * @param dateType
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public  List<Map<String,String>> getGuZhiRenYuanOptions ( String reportType ) throws IOException,Exception{
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = "select distinct WB_VALU_PRSN_NAME as value from MDS.REPT_DISC_SITU where DISC_TYPE_CODE = '"+reportType+"' ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
			logger.info("prepared sql is " + sqlScript);
			List<Map<String,Object>> list= DaoUtil.getResultToList(con,sqlScript);
			Integer i=0;
			for (Map<String, Object> map: list){
				map.put("id", String.valueOf(i++));
				Map<String,String> newMap = map.entrySet().stream()
					     .collect(Collectors.toMap(Map.Entry::getKey, e -> (String)e.getValue()));
				resultList.add(newMap);
			}
			logger.info("the record select is: "+resultList.toString());
			
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return resultList;
	}	
	
	/**
	 * return all the distinct Date( month, quarter) that already exist in database
	 * @param dateType
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public  List<Map<String,String>> getAllQuantDateOptions ( String dateType ) throws IOException,Exception{
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		//String sQLpath = dateType.equals(MONTH)?dateType:QUATER;
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();
		try {
			con = dsXXPLHD.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETALLQUANTMONTHSSQL);
			sqlScript= sqlScript + " and DISC_TYPE_CODE = '"+dateType+"' ";

			sqlScript= sqlScript + " order by date_no DESC ";;
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
			logger.info("getAllQuantDateOptions sql is " + sqlScript);
			List<Map<String,Object>> list= DaoUtil.getResultToList(con,sqlScript);
			
			Integer i=0;
			for (Map<String, Object> map: list){
				map.put("id", String.valueOf(i++));
				Map<String,String> newMap = map.entrySet().stream()
					     .collect(Collectors.toMap(Map.Entry::getKey, e -> (String)e.getValue()));
				resultList.add(newMap);
			}
//			//logger.info("the record select is: "+resultList.toString());
			return resultList;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return resultList;
	}
	
	/**
	 * return all the distinct Date( month, quarter) that already exist in database
	 * @param dateType
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public  List<Map<String,String>> getAllFundNames ( String dateType ) throws IOException,Exception{
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		String sQLpath = dateType.equals(MONTH)?dateType:QUATER;
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETALLFUNDNAMES);
			if (HSR.equals(dateType.toUpperCase() )) {
				sqlScript=" SELECT DISTINCT FUND_NAME as value from mds.REPT_HSR_FUND_INFO ";
			}
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
//			//logger.info("prepared sql is " + sqlScript);
			List<Map<String,Object>> list= DaoUtil.getResultToList(con,sqlScript);
			Integer i=0;
			for (Map<String, Object> map: list){
				map.put("id", String.valueOf(i++));
				Map<String,String> newMap = map.entrySet().stream()
					     .collect(Collectors.toMap(Map.Entry::getKey, e -> (String)e.getValue()));
				resultList.add(newMap);
			}
//			//logger.info("the record select is: "+resultList.toString());
			return resultList;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return resultList;
	}	
	
	
	/**
	 * return all the distinct Date( month, quarter) that already exist in database
	 * @param dateType
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public  List<Map<String,String>> getAllQuanManagersOptions ( String dateType ) throws IOException,Exception{
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETALLMANAGERSNAME);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
			//logger.info("prepared sql is " + sqlScript);
			List<Map<String,Object>> list = DaoUtil.getResultToList(con,sqlScript);
			Integer i=0;
			for (Map<String, Object> map: list){
				map.put("id", String.valueOf(i++));
				Map<String,String> newMap = map.entrySet().stream()
					     .collect(Collectors.toMap(Map.Entry::getKey, e -> (String)e.getValue()));
				resultList.add(newMap);
			}
//			//logger.info("the record select is: "+resultList.toString());
			return resultList;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return resultList;
	}	
	
	/**
	 * update printstat and jsonpath of a discsitu
	 * @param rept
	 * @param printStat
	 * @param jSONPath
	 * @return true 更新成功， false 更新失败
	 * @throws IOException
	 */
	public Boolean updateReptDiscSituPrintStatus (ReptDiscSitu rept, String printStat, String jSONPath) throws IOException {
		/* 1. 检查数据完整性 */
		if (rept==null || jSONPath==null) return false;
		String dateNO	= rept.getDate_no(); 
		String fundCode	= rept.getFund_code();
		String discType = rept.getDisc_type_code();
		String bill_Flag= rept.getBill_flag()!=null?(rept.getBill_flag().equals("0")?"2":rept.getBill_flag()):"2";	//0：清单外，1:清单内, 2:人工新增 
		if (discType==null||dateNO==null||dateNO==null) return false;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			PreparedStatement ps;
			String sqlScript = SqlCommonUtil.getSQLTXT(this.UPDATEREPTDISCSITUPRINTSTATUS);	
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,jSONPath, printStat, bill_Flag, discType, dateNO, fundCode);
			ps = con.prepareStatement(sqlScript);
			logger.info("更新打印状态 sql is "+sqlScript);
			//int i =ps.getUpdateCount();
			ps.execute();
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return false;
	}
	

	/**
	 * 	update printstat and jsonpath of a DiscSituMAGR, in quant fund
	 * @param manager
	 * @param mth_no
	 * @param printStat
	 * @param disc_type_code
	 * @param jSONPath
	 * @return
	 * @throws IOException
	 */
	public Boolean updateReptDiscSituMAGRPrintStatus ( ReptDiscSitu_MAGR manager, String mth_no, String printStat, String jSONPath) throws IOException {
		/* 1. 检查数据完整性 */
		if (manager==null || jSONPath==null) return false;
		String managerNo 	= manager.getMagr_No();
		String discTypeCode = manager.getDisc_Type_Code();
		String dateNO		= manager.getDate_No(); 
		if (discTypeCode == null||dateNO == null||dateNO == null) return false;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			PreparedStatement ps;
			String sqlScript = SqlCommonUtil.getSQLTXT(this.UPDATEREPTDISCSITU_MAGR_PRINTSTATUS);	
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,jSONPath, printStat, manager.getDisc_Type_Code(), dateNO, manager.getMagr_No() );
			//logger.info("prepared sql is "+sqlScript);
			ps = con.prepareStatement(sqlScript);
			//int i =ps.getUpdateCount();
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return false;
	}
	
	/**
	 * 财务人员在明细页面修改/确认财务数据
	 * @param upd_aft_data
	 * @param upder_ip
	 * @param disc_type_code
	 * @param date_no
	 * @param fund_code
	 * @param indx_name
	 * @param result
	 * @param chk_rslt_code
	 * @param modifyType	3：人工修改，4：指标确认
	 * @return
	 * @throws IOException
	 */
	public Boolean updateReptDiscChkRslt (  String upd_aft_data, String upder_ip , String disc_type_code, String date_no, String fund_code, String indx_name,Map<String, String> result, String chk_rslt_code, String modifyType, Rept_Disct_Chk_Rslt rdcr) throws IOException {
		/* 1. 检查数据完整性 */
		if (upder_ip==null || "".equals(upder_ip) || disc_type_code==null || "".equals(disc_type_code) 
			||date_no==null || "".equals(date_no) || fund_code==null || "".equals(fund_code)) {
			result.put("fail", "fail");
			result.put("message", "必要信息为空，无法修改");
			return false;
		}
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String modifyDataString =Constants.MODIFY.equals(modifyType)?",rdsm.upd_aft_data = '"+upd_aft_data+"'\r\n":""  ;
			PreparedStatement ps;
			String sqlScript =	//修改这段
				  "Update mds.REPT_DISC_CHK_RSLT rdsm    \r\n"
				+ "		SET rdsm.upder_ip = ?, rdsm.chk_rslt_code = ?   		\r\n"
				+ modifyDataString
				+ "		where 	rdsm.DISC_TYPE_CODE = ?       AND rdsm.DATE_NO = ? 	AND rdsm.fund_code = ? and rdsm.indx_name=?"
				+ "  and indx_src_tab = ?\r\n"
				+ "  and indx_src_fld = ?\r\n"
				+ "  and indx_dim= ?"
				+ " and 1=1";
			sqlScript = SqlCommonUtil.getPreparedSQL (sqlScript, upder_ip, modifyType,disc_type_code, date_no, fund_code,indx_name, rdcr.getIndx_src_tab(),rdcr.getIndx_src_fld(),rdcr.getIndx_dim()); 
			logger.info("修改或确认update REPT_DISC_CHK_RSLT 语句\n："+sqlScript);
			ps = con.prepareStatement(sqlScript);
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		}catch ( Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		DaoUtil.release(con);
		return false;
	}

	/**
	 * 执行修改SQL
	 * @param SQL
	 * @param upd_data
	 * @return
	 */
	public boolean executeModify(String SQL, String upd_data) {
		if (SQL==null||"".equals(SQL))return false;
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			SQL = SqlCommonUtil.getPreparedSQL (SQL,upd_data);
			logger.info("更新修改数据SQL：\n" +SQL);
			PreparedStatement ps;
			ps = con.prepareStatement(SQL);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
			return false;
		}catch ( Exception e) {
			e.printStackTrace();
			logger.error(e);
			return false;
		} finally {
			DaoUtil.release(con);
		}
		DaoUtil.release(con);
		return true;

	}
	
	/**
	 * 调用存储过程在保存修改/指标确认之后 更新清单表
	 * @param disc_type_code
	 * @param date_no
	 * @param fund_code
	 * @return
	 */
	public Boolean callRept_data_chk_rslt (String disc_type_code,String date_no  ,String fund_code ) {
		final int i_force = 1; //传参常量，目前强制给1
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String SQL = " 		call Rept_data_chk_rslt ('"+disc_type_code+"','"+date_no+"','"+fund_code+"','"+i_force+"' ) \r\n";
			logger.info("callRept_data_chk_rslt SQL is "+SQL);
			PreparedStatement ps = con.prepareStatement(SQL);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace(); 
			logger.error(e);
			return false;
		} finally {
			DaoUtil.release(con); 
		}
		return true;

	}
	
	public Boolean callProcedure2PushQUI2FMDB( String fundCode, String dateNo ){
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			// 套头账号查询 ds1库
			String SQL = " 		call rept_qu_ivst_info_etl ('"+dateNo+"','"+fundCode+"' ) \r\n";
			logger.info("SQL is "+SQL);
			PreparedStatement ps = con.prepareStatement(SQL);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace(); 
			logger.error(e);
			return false;
		} finally {
			DaoUtil.release(con); 
		}
		return true;
	}
	
	
	
	/**
	 * 添加操作历史
	 * @param disc_type_code
	 * @param date_no
	 * @param fund_code
	 * @param fund_name
	 * @param modyType
	 * @param upder_ip
	 * @param updt_data
	 * @param upder_name
	 * @param opt_desc
	 * @param opt_sql
	 * @param result
	 * @return
	 * @throws IOException
	 */
	public Boolean insertHistory (  String disc_type_code, String date_no, String fund_code, String fund_name, String modyType, 
									String upder_ip, String updt_data, String upder_name,  String opt_desc, String opt_sql	,Map<String, String> result) throws IOException {
		/* 1. 检查数据完整性 */
		if (upder_ip==null || "".equals(upder_ip)) {
			result.put("fail", "fail");
			result.put("message", "必要信息为空，无法修改");
			return false;
		}
		if (opt_sql.contains("'")) opt_sql=opt_sql.replaceAll("'", "''");
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			PreparedStatement ps;
			String sqlScript =	
					"INSERT INTO REPT_CHK_RSLT_MDFY_HSTY "
					+ "(DISC_TYPE_CODE, DATE_NO, FUND_CODE, FUND_NAME, MODY_TYPE, "
					+ "UPDER_IP, MDFY_TIME,UPDT_DATA, UPDER_NAME, OPT_DESC, OPT_SQL) \r\n"                                      
					+ "VALUES "
					+ "(?, ?, ?, ?, ?, "
					+ "?, SYSDATE, ?, ?, ?, ?)";
			
			sqlScript = SqlCommonUtil.getPreparedSQL (sqlScript,
					disc_type_code, date_no, fund_code, fund_name,modyType,
					upder_ip,          updt_data , upder_name, opt_desc, opt_sql); 
			logger.info("添加操作历史：\n" +sqlScript);
			ps = con.prepareStatement(sqlScript);
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		}catch ( Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return false;
	}
	
	/**
	 * 获取共享盘，导出3种文件的路径。
	 * @return
	 */
	public  Map<String,Object> getPaths(){
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		List<Map<String,String>> resultList = new ArrayList<Map<String,String>>();
		Map<String, Object> resultMap = new HashedMap(); 
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETPATHS);
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
			//logger.info("prepared sql is " + sqlScript);
			List<Map<String,Object>> list= DaoUtil.getResultToList(con,sqlScript);
			for (Map<String, Object> map: list)
				resultMap.put(map.get("para_code").toString(), map.get("para_val").toString());
		} catch (SQLException e ) {
			e.printStackTrace();
			logger.error(e);
		} catch ( IOException e) {
			e.printStackTrace();
			logger.error(e);
		} catch ( Exception e) {
			e.printStackTrace();
			logger.error(e);
		}finally {
			DaoUtil.release(con);
		}
		return resultMap;
	}
	
	/**
	 * 重新导出
	 * @param funds
	 * @param date_no
	 * @return
	 * @throws IOException
	 */
	public Boolean recollectFunds(String funds, String date_no, String reportType) throws IOException {
		if(funds==null|| date_no==null) return false;
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			PreparedStatement ps;
			String sqlScript = SqlCommonUtil.getSQLTXT(this.PROCRECOLLECTIONMONTHFUNDS);				//月报			
			if ("Q".equals(reportType)) sqlScript= "SELECT mds.rept_q_main( ? , ?, ?) FROM dual ";
			if ("QU".equals(reportType)) sqlScript =  "SELECT mds.rept_qu_main( ? , ?, ?) FROM dual ";
			if (HSR.equals(reportType))sqlScript =  "SELECT mds.rept_hsr_main( ? , ?, ?) FROM dual ";

			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,date_no, funds, "1" );
			logger.info("重新采集prepared sql is "+sqlScript);
			ps = con.prepareStatement(sqlScript);
			//int i =ps.getUpdateCount();
//			Thread  thread = new Thread();  				//recollection is quite slow, so thread it to increase user-experience.
//			thread.run();
			ps.execute();
			logger.info("执行完毕:"+sqlScript);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}			
		return false;
	}
	

	/**
	 * 季报查询通用模板
	 * @param <T>
	 * @param tableName	<<>> -> tablename
	 * @param fundName
	 * @param fundCode
	 * @param qut_NO
	 * @param info_Src_Code
	 * @param targetClass
	 * @return
	 */
	public <T> List<T> getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE(String tableName, String fundName, String fundCode,String qut_NO,String info_Src_Code ,  Class<T> targetClass ){
		/* 1. 检查数据完整性 */
		
		List <T> instanceList = new ArrayList<T>();
		if (tableName==null || fundCode==null || qut_NO==null) return null;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			PreparedStatement ps;

			String sqlScript = SqlCommonUtil.getSQLTXT(this.GETJIBAOINSTANCEBYFUNDCODE_QUTNO_INFO_SRC_CODE);
			sqlScript=sqlScript.replace("___", tableName);
			if (fundName != null && !"".equals(fundName) ) sqlScript = sqlScript + "fundName like '%fundName%' ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, fundCode, qut_NO, info_Src_Code );
//			//logger.info("prepared sql is "+sqlScript);
			instanceList= DaoUtil.resultSetToList(con,sqlScript, targetClass);
			return instanceList;
			//ps = con.prepareStatement(sqlScript);
			//ps.execute();
		} catch (SQLException | IOException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return null;
	}
	
	
	/**
	 * 季报查询通用模板
	 * @param <T>
	 * @param tableName	<<>> -> tablename
	 * @param fundName
	 * @param fundCode
	 * @param qut_NO
	 * @param info_Src_Code
	 * @param targetClass
	 * @return
	 */
	public <T> List<T> getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE(String tableName, String fundName, String fundCode,String qut_NO,String info_Src_Code ,  Class<T> targetClass ){
		/* 1. 检查数据完整性 */
		
		List <T> instanceList = new ArrayList<T>();
		if (tableName==null || fundCode==null || qut_NO==null) return null;
		
		/* 2. 打开数据库并执行sql */
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			PreparedStatement ps;

			String sqlScript = " SELECT  "
					+ " * from ___  \r\n"
					+ " WHERE fund_code = ? and  date_no = ? AND info_Src_Code = ? AND 1=1 "
					+ "";
			sqlScript=sqlScript.replace("___", tableName);
			if (fundName != null && !"".equals(fundName) ) sqlScript = sqlScript + "fundName like '%fundName%' ";
			sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, fundCode, qut_NO, info_Src_Code );
//			//logger.info("prepared sql is "+sqlScript);
			instanceList= DaoUtil.resultSetToList(con,sqlScript, targetClass);
			return instanceList;
			//ps = con.prepareStatement(sqlScript);
			//ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			DaoUtil.release(con);
		}
		return null;
	}
	
	

	/**
	 * 
	 */
    public void run() {  
        //3):在run方法中编写需要执行的操作  
        for(int i = 0; i < 10; i ++){  
            System.out.println("播放音乐"+i);  
        }  
    } 
    public List<Map<String, Object>> updateCheckinfo(PageData pd) {


  		List<Map<String, Object>> result = new ArrayList<>();
  		
  		String tablename= pd.getString("tablename"); 
  		String cpname= pd.getString("cpname"); 
  		String bbnum=pd.getString("bbnum"); 
  		String op=pd.getString("op"); 
  		String hduser=pd.getString("hduser"); 
  		String hdstatus=pd.getString("hdstatus"); 
  		String hdcpname=pd.getString("hdcpname"); 
  		if(!"".equals(hdcpname)){
  			try {
				hdcpname=new String(hdcpname.getBytes("iso8859-1"),"utf-8");
			} catch (UnsupportedEncodingException e) {
				
				e.printStackTrace();
			}
  		}
  		String wgLevel=pd.getString("wgLevel"); 
  		
  		String discode="";
		/*
		 * AFM  年度监测报告；
M  月报；
M2 量化运行表；
Q 季报；
QU 季度更新-运行表；
QUI 季度更新-投资者表；
YSE 证券类年报；
YSR 股权类年报；
		 * 
		 * */
		if("mds.rept_q_magr_rept".equals(tablename)){
			discode="Q";
		}else if("mds.rept_yse_trus_rept".equals(tablename)){
			discode="YSE";
		}
		else if("mds.rept_hsr_magr_rept".equals(tablename)){
			discode="HSR";
		}
  		
  		Connection con = null;
  		try {
  			con = dsXXPLHD.getConnection();
  			
  			if("s".equals(op)){
  				String SQL= " select columnname,p_field,needsearch from smgz_xxpl_item_cfg where tablename='"+tablename+"' ";
  				List<Map<String, Object>> columninfolist=DaoUtil.getResultToList(con, SQL);
  				String columnStr="";
  		
  				if(columninfolist.size()==0)
  					return result;
  				for(Map<String, Object> onedata:columninfolist){
  					if("1".equals(onedata.get("needsearch")))
  						columnStr+= " a."+onedata.get("columnname")+" "+onedata.get("p_field")+",";
 
  				}
  				
  				String innerjoinsql=" inner join guzhi.accountmappinginfo  c on a.fund_code=c.fund_code  left join mds. rept_disc_situ  b on b.disc_type_code= '"+discode+"' and b.date_no='"+bbnum+"' and a.fund_code=b.fund_code ";
  				String DataSQL=" select  c.fund_name,  "
  						+ " decode(a.vilt_type_code,'00','无违规','01','特别提示','10','轻度违规','11','轻度违规且特别提示','20','重度违规','21','重度违规且特别提示','状态未知' ) vilt_type_code_name ,  "
  						+ "decode(b.ivsp_chk_rslt_code,'0','未核对','1','核对一致','2','核对不一致','9','不需要核对','状态未知' ) hdstatus ,  "+ columnStr.substring(0, columnStr.length()-1)+ " from "+tablename +" a "+innerjoinsql+" where 1=1 and b.serv_scop<>'外包' ";
  				
  				if(StringUtils.isNotEmpty(cpname)){
  					DataSQL += "  and fund_code='"+cpname+"' " ;
  				}
  				if(StringUtils.isNotEmpty(bbnum)){
  					if(tablename.toLowerCase().equals("mds.rept_q_magr_rept")){
  						DataSQL += " and a.qut_no='"+bbnum+"' " ;
  					}else if(tablename.toLowerCase().equals("mds.rept_yse_trus_rept")){
  						DataSQL += " and a.year_no='"+bbnum+"' " ;
  					}
  					
  				}
  				
  				if(StringUtils.isNotEmpty(wgLevel)){
  					DataSQL += " and a.vilt_type_code='"+wgLevel+"' " ;
  				} 
  				if(StringUtils.isNotEmpty(hduser)){
  					DataSQL += " and a.chk_prsn='"+hduser+"' " ;
  				} 
  				/*if(StringUtils.isNotEmpty(hdcpname)){
  					DataSQL += " and a.fund_code='"+hdcpname+"' " ;
  				} */
  				
  				if(StringUtils.isNotEmpty(hdcpname)){
  					DataSQL += " and c.fund_name like '%"+hdcpname+"%'  " ;
  				}
  				
  				if(StringUtils.isNotEmpty(hdstatus)&&!("-1").equals(hdstatus)){
  					DataSQL += " and b.ivsp_chk_rslt_code='"+hdstatus+"' " ;
  				}
  				result=DaoUtil.getResultToList(con, DataSQL+"  ");
  			}else if("a".equals(op)){
  				
  			}else if("u".equals(op)){
  				
  			}
  			
  		

  		} catch (Exception e) {
  			Map<String, Object> one=new HashMap<>();
  			one.put("msg", "fail");
  			result.add(one);
  			e.printStackTrace();
  			logger.error(e);
  		} finally {
  				DaoUtil.release(con);
  		
  		}
  		return result;

      	
      
      }
    public List<Map<String, Object>> updateBBinfo(PageData pd) {


		List<Map<String, Object>> result = new ArrayList<>();
		
		String cpname= pd.getString("cpname"); 
		String wgtype=pd.getString("wgtype"); 
		String bbtype=pd.getString("bbtype"); 
		String edate=pd.getString("edate");
		String sdate =pd.getString("sdate");
		String ord=pd.getString("ord");
		String jbr=pd.getString("jbr");
		String fhr= pd.getString("fhr");
		String content= pd.getString("content");
		String op=pd.getString("op");
		String shzt=pd.getString("shzt");
		String ider= pd.getString("ider");
		
		Connection con = null;
		try {
			con = dsXXPLHD.getConnection();
			
			if("s".equals(op)){
				String SQL = "  select a.ider,a.fundcode,b.fund_name fundname,a.wg_type wgtypecode,c.datavalue wgtypename,a.bbtype bbtypecode,d.datavalue bbtypename,a.sdate,a.edate,a.llr jbrcode,e.username jbrname, "+
							"	a.ssr ssrcode,f.username ssrname,a.wg_info wginfo,a.ordernum ord,a.ischeck ischeckcode,g.datavalue ischeckname "+
							"	 from bb_grlbg_data a inner join accountmappinginfo b on a.fundcode=b.fund_code  "+
							"	inner join codemanage c on a.wg_type=c.datacode and c.datatype='BB_WGLX'  inner join codemanage d on a.bbtype=d.datacode and d.datatype='BB_BBTYPE' "+
							"	inner join guzhiuserinfo e on a.llr=e.id  inner join guzhiuserinfo f on a.ssr=f.id    "+
							"	inner join codemanage g on a.ischeck=g.datacode and g.datatype='BB_SHZT' where 1=1    ";
				if(StringUtils.isNotEmpty(cpname)){
					 SQL+=" and a.fundcode='"+cpname+"' ";
				}
				if(StringUtils.isNotEmpty(jbr)){
					 SQL+=" and a.llr='"+jbr+"' ";
				}
				if(StringUtils.isNotEmpty(wgtype)){
					 SQL+=" and a.wg_type='"+wgtype+"' ";
				}
				result=DaoUtil.getResultToList(con, SQL);
				
			}else if("a".equals(op)){
				

				
				String SQL = "  insert into bb_grlbg_data(IDER,FUNDCODE,WG_TYPE,bbtype,SDATE,EDATE,LLR,CTIME,SSR,HTIME,WG_INFO,ORDERNUM,ISCHECK) values "+
							"  (pk_id_public.nextval,'"+cpname+"','"+wgtype+"','"+bbtype+"','"+sdate+"','"+edate+"','"+jbr+"',sysdate,'"+fhr+"',sysdate,'"+content+"','"+ord+"','"+shzt+"' )";
					DaoUtil.insert(con, SQL);	
					
					
					Map<String, Object> one=new HashMap<>();
					one.put("msg", "success");
					result.add(one);
					
			}else if("u".equals(op)){
				
				String SQL = "  update bb_grlbg_data  set (FUNDCODE,WG_TYPE,bbtype,SDATE,EDATE,LLR,SSR,HTIME,WG_INFO,ORDERNUM,ISCHECK) = "+
						" ( select  '"+cpname+"','"+wgtype+"','"+bbtype+"','"+sdate+"','"+edate+"','"+jbr+"','"+fhr+"',sysdate,'"+content+"',"+ord+",'"+shzt+"' from dual ) "
								+ " where ider="+ider;
			
				DaoUtil.insert(con, SQL);	
				
				Map<String, Object> one=new HashMap<>();
				one.put("msg", "success");
				result.add(one);	
			}
			
		

		} catch (Exception e) {
			Map<String, Object> one=new HashMap<>();
			one.put("msg", "fail");
			result.add(one);
			e.printStackTrace();
			logger.error(e);
		} finally {
				DaoUtil.release(con);
		
		}
		return result;

    	
    
    }
    
    
    public List<Map<String, Object>> searchMailLog(PageData pd) {


  		List<Map<String, Object>> result = new ArrayList<>();
  		
  		String disc_type_code=pd.getString("disc_type_code");
  		String date_no=pd.getString("date_no");
  		String fund_code=pd.getString("fund_code");
  		String pkinfo= pd.getString("pkinfo"); 
  		Connection con = null;
		try {
			con = dsXXPLHD.getConnection();
			String sql="select a.fund_code,b.fund_name,decode(a.disc_type_code,'M','月报','Q','季报','QU','季度更新','YSE','证券类年报','YSR','股权类年报') disc_type_code, "
				+	" a.date_no,a.batch_no,to_char(a.sendtime,'yyyy-mm-dd HH24:mi:ss') sendtime,decode(a.status ,'0','成功','1','成功','2','失败')status, "
				+	" a.mail_to,a.mail_subj,a.mail_content,a.mail_attach "
				+	" from bb_xpmail_log a left join accountmappinginfo b on a.fund_code=b.fund_code where 1=1 ";
			
			if(StringUtils.isNotEmpty(disc_type_code)){
				sql+=" and  a.disc_type_code= '"+disc_type_code+"' ";
			}
			if(StringUtils.isNotEmpty(date_no)){
				sql+=" and a.date_no= '"+date_no+"' ";
			}
			if(StringUtils.isNotEmpty(fund_code)){
				sql+=" and  a.fund_code= '"+fund_code+"' ";
			}
			
			
			result=DaoUtil.getResultToList(con, sql);
		} catch (Exception e) {
			Map<String, Object> one=new HashMap<>();
			one.put("msg", "fail");
			result.add(one);
			e.printStackTrace();
			logger.error(e);
		
		} finally {
				DaoUtil.release(con);
		
		}
		return result;
    }
			
			
			
    public List<Map<String, Object>> updateMailData(PageData pd) {


  		List<Map<String, Object>> result = new ArrayList<>();
  		
  		String disc_type_code=pd.getString("disc_type_code");
  		String date_no=pd.getString("date_no");
  		String fund_code=pd.getString("fund_code");
  		String pkinfo= pd.getString("pkinfo"); 
  		Connection con = null;
		try {
			
			
			
			
			con = dsXXPLHD.getConnection();
			
			// snd_flag_code  00 未发送   01 已发送   02 再次发送   04 一次发送失败   05 多次发送失败
			
			//查询首次发送的 邮件
			String SQL1=" select a.disc_type_code,a.date_no,a.fund_code,a.fund_num,a.rect_crt_time,a.snd_time,a.snd_flag_code,a.snd_bath_num from mds.rept_disc_situ  a "+
						" where a.disc_type_code='"+disc_type_code+"' and date_no='"+date_no+"' and a.rect_crt_time is not null and (a.snd_flag_code='00' or a.snd_flag_code is null or a.snd_flag_code='04' )  ";
			
			if(StringUtils.isNotEmpty(fund_code)){
				
				SQL1+=" and a.fund_code='"+fund_code+"'";
			}
			List<Map<String, Object>> firstmailList=DaoUtil.getResultToList(con, SQL1);
			//获取邮件模板
			
			String sql_temp="delete from BB_TEMPLETE_CONTENT ";
			DaoUtil.insert(con, sql_temp);
			sql_temp=" insert into BB_TEMPLETE_CONTENT (MAIL_ID,MAIL_TITLE,mail_RECEIVE_ROLE,MAIL_TEXT) select MAIL_ID,MAIL_TITLE,mail_RECEIVE_ROLE,MAIL_TEXT from  t_mail_info@zhglpt ";
			DaoUtil.insert(con, sql_temp);
	
			
			
			String sql_muban =" select b.* from bb_mail_templete_id  a inner join  bb_templete_content b on a.bb_templete_id=b.mail_id where a.bb_type='"+disc_type_code+"' "; 
			
			List<Map<String, Object>> mubanList=DaoUtil.getResultToList(con, sql_muban);
			if(mubanList.size()==0){
				
				System.out.println("未配置该类型邮件模板");
				Map<String, Object> one=new HashMap<>();
				one.put("msg", "未配置该类型邮件模板");
				result.add(one);
				return result;
			}
			Map<String, Object> mail_muban=mubanList.get(0);
			
			String mail_subject=mail_muban.get("mail_title").toString(); 
			
			String mail_content=mail_muban.get("mail_text").toString(); 
			
			String mail_to=mail_muban.get("mail_receive_role").toString(); 
			
			//解析收件人
			HashMap<String, String> mailto_map=new HashMap<>();
			
			HashMap<String, String> mailto_map_gtja=new HashMap<>();
			HashMap<String, String> fundname_map=new HashMap<>();
			HashMap<String, String> grlname_map=new HashMap<>();
			HashMap<String, String> grl_pcode_map=new HashMap<>();
			 String sql_mailto=" select distinct  c.fund_code,       c.fund_name,   fm_name  , c.fundno, record_number,  a.user_name,        a.email "+
					 "  from t_users@zhglpt a, T_USERS_JIAOSE@zhglpt b, t_fund_info@zhglpt c  inner join t_fm@zhglpt d on c.fm_id=d.fm_id "+
					 "  where a.fund_id = c.fund_code   and mod(a.jiaose_code, b.jiaose_code) = 0   and b.jiaose_code in ("+mail_to+ "'') ";
			 
				if(StringUtils.isNotEmpty(fund_code)){
					
					sql_mailto+=" and a.fund_id='"+fund_code+"'";
				}
				List<Map<String, Object>> mailtoList=DaoUtil.getResultToList(con, sql_mailto);
				
				for(Map<String, Object> data:mailtoList){
					String fundcode=data.get("fund_code").toString();
					String email=data.get("email").toString();
					String fund_name=data.get("fund_name").toString();
					String grl_name=data.get("fm_name").toString();
					String record_number=data.get("record_number").toString();
					String fundno=data.get("fundno").toString();
					
					if(email.contains("tg.gtja.com")){
						mailto_map_gtja.put(fundno, fundno);
						
					}
					
					if(mailto_map.containsKey(fundcode)){
						
						mailto_map.put(fundcode, mailto_map.get(fundcode)+";"+email);
					}else{
						mailto_map.put(fundcode, email);
						fundname_map.put(fundcode, fund_name);
						grlname_map.put(fundcode, grl_name);
						grl_pcode_map.put(fundcode, record_number);
							
					}
					
					
				}
				
			//替换主题和内容模板
					
				
				SimpleDateFormat sdf=new SimpleDateFormat("YYYY年MM月dd日");
				
				String todaystr=sdf.format(Calendar.getInstance().getTime());
				String YYYY_content=date_no.substring(0,4);
				String YYYY_QUR_content="";
				String YYYY_month_content="";
				if(date_no.length()>5){
					YYYY_QUR_content=date_no.substring(0,4)+"年"+date_no.substring(4,6)+"季度";
					YYYY_month_content=date_no.substring(0,4)+"年"+date_no.substring(4,6)+"月";
				}
				
				
				mail_subject=mail_subject.replace("#YYYY年X季度#", YYYY_QUR_content);
				mail_subject=mail_subject.replace("#YYYY年MM月#", YYYY_month_content);
				mail_subject=mail_subject.replace("#YYYY#", YYYY_content);
				mail_subject=mail_subject.replace("#YYYY年MM月DD日#", todaystr);
				
				
				mail_content=mail_content.replace("#YYYY年X季度#", YYYY_QUR_content);
				mail_content=mail_content.replace("#YYYY年MM月#", YYYY_month_content);
				mail_content=mail_content.replace("#YYYY#", YYYY_content);
				mail_content=mail_content.replace("#YYYY年MM月DD日#", todaystr);
				//获取邮件附件
				String attach_sql=" select a.fund_code,a.fundno,a.date_no ,a.report_type  ,a.disc_type_code,a.xlsx_auth_key,a.xbrl_auth_key,a.pdf_auth_key,a.docx_auth_key from tb_xp_disclosure@zhglpt a where a.release_status=1 "
						//+ " and a.xlsx_auth_key is not null and a.xbrl_auth_key is not null and a.pdf_auth_key is not null and a.docx_auth_key is not null  ";
						+" and date_no='"+date_no;
				if("M".equals(disc_type_code)||"Q".equals(disc_type_code)){
					attach_sql+= "' and disc_type_code = '"+disc_type_code+"' ";
				}else if ("QU".equals(disc_type_code)){
					attach_sql+= "' and disc_type_code  in ('QU','QUI') ";
				}
				if(StringUtils.isNotEmpty(fund_code)){
					
					attach_sql+=" and a.fund_code='"+fund_code+"'";
				}
				List<Map<String, Object>> attachlist=DaoUtil.getResultToList(con, attach_sql);
				HashMap<String, String> attach_map=new HashMap<>();
				
				for(Map<String, Object> oneattach:attachlist){

					String tdisc_type_code=oneattach.get("disc_type_code").toString();
					String tfundcode=oneattach.get("fund_code").toString();
					String excel_file=oneattach.get("xlsx_auth_key").toString();
					String xbrl_file=oneattach.get("xbrl_auth_key").toString();
					String pdf_file=oneattach.get("pdf_auth_key").toString();
					String word_file=oneattach.get("docx_auth_key").toString();
					if("M".equals(tdisc_type_code)||"Q".equals(tdisc_type_code)){
						if("".equals(excel_file)||"".equals(xbrl_file)||"".equals(pdf_file)||"".equals(word_file)){
							
						}else{
							attach_map.put(tfundcode,excel_file+";" +xbrl_file+";"+pdf_file+";"+word_file);
						}
					}else if ("QU".equals(tdisc_type_code)||"QUI".equals(tdisc_type_code)){
						if("".equals(excel_file)){
							
						}else{
							if(attach_map.containsKey(tfundcode)){
								attach_map.put(tfundcode,attach_map.get(tfundcode)+";"+excel_file);
							}else{
								attach_map.put(tfundcode,excel_file);
							}
						}
					}
				
				}
				if("QU".equals(disc_type_code))
					for(String key:attach_map.keySet()){
						if(attach_map.get(key).split(";").length<2)
							attach_map.remove(key);
					}
				
				
				
			/*	mail_title_pairs.append("#fundname#"+":"+fund_name).append("||");
	              mail_title_pairs.append("#YYYY年X季度#"+":"+dataStr).append("||");
	              mail_title_pairs.append("#YYYY年MM月#"+":"+dataStr).append("||");
	              mail_title_pairs.append("#company_name#"+":"+fm_name).append("||");
	              mail_title_pairs.append("#YYYY#"+":"+file_year+"");*/
				
				SendMail smail=new SendMail();
				String url = PropertyUitls.getProperties("config.properties").getProperty("FMFileDownloadUrl_test");
				long batch_no=Calendar.getInstance().getTime().getTime();
				String downloadFileAbsolutePath =   "L:/系统专用/信披报表邮件发送/"+sdf8.format(Calendar.getInstance().getTime())+"/"+disc_type_code+"/"+date_no+"/"+batch_no+"/";  // PropertyUitls.getProperties("config.properties").getProperty("WORD2PDFDOWNLOADPATH") + "/" + fileName;
				
				if(!new File(downloadFileAbsolutePath).exists()){
					new File(downloadFileAbsolutePath).mkdirs();
				}
				for(Map<String, Object> onemail:firstmailList){
					String mfundcode=onemail.get("fund_code").toString();
					String mfundname=fundname_map.get(mfundcode);
					String mfundnum=onemail.get("fund_num").toString();
					String mglrname=grlname_map.get(mfundcode);
					String mmailto=mailto_map.get(mfundcode);
					String msubject=mail_subject.replace("#fundname#", mfundname);
					msubject=msubject.replace("#company_name#", mglrname);
					String mcontent=mail_content.replace("#fundname#", mfundname);
					mcontent=mcontent.replace("#company_name#", mglrname);
					
					String mattach="";
					
				//	attach_map.put("1307", "0");
					if(attach_map.containsKey(mfundcode)){
						//下载附件并存档
						
						for(String authkey:attach_map.get(mfundcode).split(";")){
							
							String filepath=HttpClientUtils.download(url+"&auth_key="+authkey, downloadFileAbsolutePath,"CN_"+grl_pcode_map.get(mfundcode)+"_"+mfundnum+"_"+mfundname+"_"+date_no+"_"+disc_type_code);
							
							
							mattach+=filepath+";";
						}
						

						
					}else{
						System.out.println("附件还未准备好");
						continue;
					}
				
				//	mmailto="lihaijie@swhysc.com";
					String flag=	smail.sendMailex("xxpl@swhysc.com", "swhy@1234", mmailto, msubject, mcontent, mattach);
						//记录日志
						String i_sql=" insert into BB_XPMAIL_LOG(DISC_TYPE_CODE,DATE_NO,FUND_CODE,BATCH_NO,STATUS,MAIL_TO,MAIL_SUBJ,MAIL_CONTENT,MAIL_ATTACH) values( "+
								"'"+disc_type_code+"','"+date_no+"','"+mfundcode+"','"+batch_no+"','"+flag+"'"
								+ ",'"+mmailto+"','"+msubject+"',?,? )";
						
						PreparedStatement ps=con.prepareStatement(i_sql);
						Reader clobreader=new StringReader(mcontent);
						ps.setCharacterStream(1, clobreader,mcontent.length());
						clobreader.close();
						Reader clobreader2=new StringReader(mattach);
						ps.setCharacterStream(2, clobreader2,mattach.length());
						clobreader2.close();
					//	DaoUtil.insert(con, sql);
						ps.execute();
						
						String snd_flag_code="01";
						if("2".equals(flag)){
							snd_flag_code="04";
						}
						String mds_sql=" update  mds.rept_disc_situ t  set  t.snd_time=sysdate, t.snd_flag_code='"+snd_flag_code+"' ,t.snd_bath_num='"+batch_no+"'   where t.disc_type_code='"+disc_type_code+"' and t.date_no='"+date_no+"' and t.fund_code='"+mfundcode+"' ";
						DaoUtil.insert(con, mds_sql);
						
				}

				
				
			
			
			
			//查询重发批次邮件
			String SQL2=" select a.disc_type_code,a.date_no,a.fund_code,a.fund_num,a.rect_crt_time,a.snd_time,a.snd_flag_code,a.snd_bath_num from mds.rept_disc_situ  a where a.disc_type_code='"+disc_type_code+"' and date_no='"+date_no+"'   and  ( a.snd_time<a.rect_crt_time or a.snd_flag_code='05' ) ";
			
			if(StringUtils.isNotEmpty(fund_code)){
				
				SQL2+=" and a.fund_code='"+fund_code+"'";
			}
			List<Map<String, Object>> secondMailList=DaoUtil.getResultToList(con, SQL2);
			
			for(Map<String, Object> onemail:secondMailList){
				String mfundcode=onemail.get("fund_code").toString();
				String mfundname=fundname_map.get(mfundcode);
				String mfundnum=onemail.get("fund_num").toString();
				String mglrname=grlname_map.get(mfundcode);
				String mmailto=mailto_map.get(mfundcode);
				String msubject=mail_subject.replace("#fundname#", mfundname);
				msubject=msubject.replace("#company_name#", mglrname);
				msubject="(以此为准)"+msubject;
				String mcontent=mail_content.replace("#fundname#", mfundname);
				mcontent=mcontent.replace("#company_name#", mglrname);
				
				String mattach="";
				
				//attach_map.put("1307", "0");
				if(attach_map.containsKey(mfundcode)){
					//下载附件并存档
					
					for(String authkey:attach_map.get(mfundcode).split(";")){
						
						String filepath=HttpClientUtils.download(url+"&auth_key="+authkey, downloadFileAbsolutePath,"CN_"+grl_pcode_map.get(mfundcode)+"_"+mfundnum+"_"+mfundname+"_"+date_no+"_"+disc_type_code);
						
						if("".equals(filepath))
							filepath=HttpClientUtils.download(url+"&auth_key="+authkey, downloadFileAbsolutePath,"CN_"+grl_pcode_map.get(mfundcode)+"_"+mfundnum+"_"+mfundname+"_"+date_no+"_"+disc_type_code);
						
						if("".equals(filepath))
							filepath="error";
						mattach+=filepath+";";
					}
					

					
				}else{
					System.out.println("附件还未准备好");
					continue;
				}
				if(mattach.contains("error")){
					System.out.println("有附件下载失败，无法发送");
					continue;
				}
				
				//mmailto="lihaijie@swhysc.com";
				String flag=smail.sendMailex("xxpl@swhysc.com", "swhy@1234", mmailto, msubject, mcontent, mattach);
				//记录日志
				String i_sql=" insert into BB_XPMAIL_LOG(DISC_TYPE_CODE,DATE_NO,FUND_CODE,BATCH_NO,STATUS,MAIL_TO,MAIL_SUBJ,MAIL_CONTENT,MAIL_ATTACH) values( "+
						"'"+disc_type_code+"','"+date_no+"','"+mfundcode+"','"+batch_no+"','"+flag+"'"
						+ ",'"+mmailto+"','"+msubject+"',?,?)";
				
				PreparedStatement ps=con.prepareStatement(i_sql);
				Reader clobreader=new StringReader(mcontent);
				ps.setCharacterStream(1, clobreader,mcontent.length());
				clobreader.close();
				Reader clobreader2=new StringReader(mattach);
				ps.setCharacterStream(2, clobreader2,mattach.length());
				clobreader2.close();
				ps.execute();
				
				String snd_flag_code="02";
				if("2".equals(flag)){
					snd_flag_code="05";
				}
				
				String mds_sql=" update  mds.rept_disc_situ t  set  t.snd_time=sysdate, t.snd_flag_code='"+snd_flag_code+"' ,t.snd_bath_num='"+batch_no+"'   where t.disc_type_code='"+disc_type_code+"' and t.date_no='"+date_no+"' and t.fund_code='"+mfundcode+"' ";
				DaoUtil.insert(con, mds_sql);
			}
			
			//特殊处理国泰君安邮件
			
			String gtja_attach="";
			File  downloadFileAbsolutePath_dir=new File(downloadFileAbsolutePath);
			File [] allfilename=downloadFileAbsolutePath_dir.listFiles();
			HashMap<String, String> filenameMap=new HashMap<>();
			for(File name:allfilename){
				String onename=name.getName().split("_")[2];
				if(onename.length()>1)
					filenameMap.put(onename, name.getAbsolutePath());
			}
			
		
		for(String onecode:filenameMap.keySet()){
		   
			if(mailto_map_gtja.containsKey(onecode)){
				gtja_attach+=filenameMap.get(onecode);
			}
	
			
		}
		//type:月报，季报，年报，季度更新，半年报 
		String nyy="";
		String type="";
		if(disc_type_code.equals("M")){
			type="月报";
		}else if(disc_type_code.equals("Q")){
			type="季报";
		}else if(disc_type_code.equals("QU")){
			type="季度更新";
		}
		else if(disc_type_code.equals("YSE")||disc_type_code.equals("YSR")){
			type="年报"; 
		}
		if(date_no.length()>5){
			nyy=date_no.substring(4,6);
		}
		if(gtja_attach.length()>10){
			String mmailto="zctgfa@tg.gtja.com";
			//mmailto="lihaijie@swhysc.com";
			String gtja_subj=type + "_" + YYYY_content + "_" + nyy.replace("0", "") + "_信批对账_" + "需核对";
			String flag=smail.sendMailex("xxpl@swhysc.com", "swhy@1234", mmailto, gtja_subj, "信披", gtja_attach);	
			String i_sql=" insert into BB_XPMAIL_LOG(DISC_TYPE_CODE,DATE_NO,FUND_CODE,BATCH_NO,STATUS,MAIL_TO,MAIL_SUBJ,MAIL_CONTENT,MAIL_ATTACH) values( "+
					"'"+disc_type_code+"','"+date_no+"','国君产品','"+batch_no+"','"+flag+"'"
					+ ",'"+mmailto+"','"+gtja_subj+"','"+"信披"+"',? )";
			PreparedStatement ps=con.prepareStatement(i_sql);
			Reader clobreader=new StringReader(gtja_attach);
			ps.setCharacterStream(1, clobreader,gtja_attach.length());
			clobreader.close();
			
		//	DaoUtil.insert(con, sql);
			ps.execute();	 
			
		}
		
		Map<String, Object> one=new HashMap<>();
		one.put("msg", "success");
		result.add(one);
			
		} catch (Exception e) {
			Map<String, Object> one=new HashMap<>();
			one.put("msg", "fail");
			result.add(one);
			e.printStackTrace();
			logger.error(e);
		
		} finally {
				DaoUtil.release(con);
		
		}
		return result;
	
    
    }
			
    public List<Map<String, Object>> updateCheckBBinfo(PageData pd) {


		List<Map<String, Object>> result = new ArrayList<>();
		
		String pkinfo= pd.getString("pkinfo"); 
		String modyinfo=pd.getString("modyinfo"); 
		String tablename=pd.getString("tablename"); 
		String bbnum=pd.getString("bbnum");
		String reportdate=pd.getString("reportdate");
		String fund_code=pd.getString("fundcode");
		String op=pd.getString("op");
		String hduser=pd.getString("hduser");
		String discode=""; 
		String wgLevel=pd.getString("wgLevel"); 
		/*
		 * AFM  年度监测报告；
M  月报；
M2 量化运行表；
Q 季报；
QU 季度更新；
YSE 证券类年报；
YSR 股权类年报；
		 * 
		 * */
		if("mds.rept_q_magr_rept".equals(tablename)){
			discode="Q";
		}else if("mds.rept_yse_trus_rept".equals(tablename)){
			discode="YSE";
		}
		else if("mds.rept_hsr_magr_rept".equals(tablename)){
			discode="HSR";
		}
		Connection con = null;
		Connection con_mds = null;
		try {
			con = dsXXPLHD.getConnection();
			con_mds=datasourceXXPLHDMDS.getConnection();
			if("recalc".equals(op)){
				
				if("HSR".equals(discode)){
					DaoUtil.getcallProcedure(con_mds, " call rept_hsr_magr_rept_etl ( '"+reportdate+"' , '"+fund_code+"'  ,1 ) ");
				}else if("Q".equals(discode)){
					DaoUtil.getcallProcedure(con_mds, " call rept_q_magr_rept_etl ( '"+reportdate+"' , '"+fund_code+"'  ,1 ) ");
				}
				
				Map<String, Object> one=new HashMap<>();
	  			one.put("msg", "success");
	  			result.add(one);
				
			}else if("all".equals(op)){
				con.setAutoCommit(false);
				String conditon=""; 
				if(StringUtils.isNotEmpty(wgLevel)){
					conditon =" and vilt_type_code='"+wgLevel+"' ";
				}
				
				String sql2="";
				if("HSR".equals(discode)){
					 sql2=" update mds.rept_hsr_magr_rept  a set a.chk_prsn='"+hduser+"' where    a.date_no='"+bbnum+"'   and  fund_code in ( select fund_code from  mds. rept_disc_situ  where ivsp_chk_rslt_code ='0'  and serv_scop<>'外包' and   DISC_TYPE_CODE='"+discode+"' and DATE_NO ='"+bbnum+"'    ) "+conditon+" ";
						
				}else if("Q".equals(discode)){
					 sql2=" update mds.rept_q_magr_rept  a set a.chk_prsn='"+hduser+"' where    a.qut_no='"+bbnum+"'   and  fund_code in ( select fund_code from  mds. rept_disc_situ  where ivsp_chk_rslt_code ='0'  and serv_scop<>'外包' and   DISC_TYPE_CODE='"+discode+"' and DATE_NO ='"+bbnum+"'    ) "+conditon+" ";
						
				}
				
				
				//sql2=" update mds.rept_q_magr_rept  a set a.chk_prsn='"+hduser+"' where fund_code in ( select fund_code from  mds. rept_disc_situ  where ivsp_chk_rslt_code ='0'  and serv_scop<>'外包' and   DISC_TYPE_CODE='"+discode+"' and DATE_NO ='"+bbnum+"'    ) "+conditon+" ";
				
				
				DaoUtil.insertWithErrorPrompt(con, sql2);
				String sql=null;
				if("HSR".equals(discode)){
					sql=" update mds. rept_disc_situ  set ivsp_chk_rslt_code ='1' where  ivsp_chk_rslt_code ='0'  and serv_scop<>'外包' and   DISC_TYPE_CODE='"+discode+"' and DATE_NO ='"+bbnum+"' and  fund_code in ("
							+ "  select fund_code from mds.rept_hsr_magr_rept  where   date_no='"+bbnum+"'  "+conditon+"  )   ";
					
				}else if("Q".equals(discode)){
					sql=" update mds. rept_disc_situ  set ivsp_chk_rslt_code ='1' where  ivsp_chk_rslt_code ='0'  and serv_scop<>'外包' and   DISC_TYPE_CODE='"+discode+"' and DATE_NO ='"+bbnum+"' and  fund_code in ("
							+ "  select fund_code from mds.rept_q_magr_rept  where   qut_no='"+bbnum+"'  "+conditon+"  )   ";
						
				}
			
				
				
				
				
				DaoUtil.insertWithErrorPrompt(con, sql);
				con.commit();
				Map<String, Object> one=new HashMap<>();
	  			one.put("msg", "success");
	  			result.add(one);
				
			}else if("u".equals(op)){
				con.setAutoCommit(false);
				String wheresql=" where 1=1 ";
				if(StringUtils.isNotEmpty(pkinfo)){
					for(String onepk:pkinfo.split("#"))
					wheresql+= " and " +onepk.split(":")[0]+" = '"+onepk.split(":")[1]+"'";
				}
				String updatesql="";
				if(StringUtils.isNotEmpty(modyinfo)){
					for(String onepk:modyinfo.split("@@\\$\\$"))
						updatesql+= "  " +onepk.split("@#",-1)[0]+" = '"+onepk.split("@#",-1)[1]+"',";
				}
				updatesql+="upd_date =sysdate ";
				//updatesql=updatesql.substring(0,updatesql.length()-1);
				String sql="update "+tablename+" set chk_prsn='"+hduser+"' ,"+updatesql+wheresql;
				
				DaoUtil.insertWithErrorPrompt(con, sql);
				
				
				String status_sql=" update mds. rept_disc_situ  set ivsp_chk_rslt_code ='1' where DISC_TYPE_CODE='"+discode+"' and DATE_NO ='"+bbnum+"'  and fund_code='"+fund_code+"'  ";
				//System.out.println(status_sql);
				DaoUtil.insertWithErrorPrompt(con, status_sql);
				con.commit();
				Map<String, Object> one=new HashMap<>();
	  			one.put("msg", "success");
	  			result.add(one);
			}
			 
		

		} catch (Exception e) {
			Map<String, Object> one=new HashMap<>();
			one.put("msg", "fail");
			result.add(one);
			e.printStackTrace();
			logger.error(e);
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
				DaoUtil.release(con,con_mds);
		
		}
		return result;
	
    
    }
    public List<Map<String, Object>> getCommonSQLSearch(PageData pd) {
		List<Map<String, Object>> result = null;
		
		String sql=pd.getString("sql");
		
		Connection con = null;
		try {
			con = dsXXPLHD.getConnection();
			
			result = DaoUtil.getResultToList(con, sql);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
				DaoUtil.release(con);
		
		}
		return result;
}
    
	public List<Map<String, Object>> getComboBoxSource(PageData pd) {
		List<Map<String, Object>> result = null;
		
		String tbname=pd.getString("tbname");
		String code=pd.getString("code");
		String name=pd.getString("name");
		String option=pd.getString("option");
		Connection con = null;
		try {
			con = dsXXPLHD.getConnection();
			// 套头账号查询 ds1库
			String SQL = "     select "+code+" value,  "+name+" text from "+tbname+" "+option;
			result = DaoUtil.getResultToList(con, SQL);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
				DaoUtil.release(con);
		
		}
		return result;
}
	
	public  void test () {
		Connection con = null;
		try {
			con = datasourceXXPLHDMDS.getConnection();
			String sqlScript = " select * from MDS.REPT_Q_NET_VAL where C_PORD_CODE = 1336 ";
			List<Rept_Q_net_val> list = DaoUtil.resultSetToList(con,sqlScript, Rept_Q_net_val.class);
//			//logger.info(list);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DaoUtil.release(con);
		}

	}
    
    
    
}
