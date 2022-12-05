package com.fh.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.codec.DecoderException;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.sql.visitor.functions.If;
import com.fh.service.XinXiPiLuYueBaoServiceNew;
import com.fh.util.Const;
import com.fh.util.Constants;
import com.fh.util.DaoUtil;
import com.fh.util.sql.SqlCommonUtil;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptCifdFundCodeMap;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptMFundInfo;
import com.swhy.xxpl.model.ReptMNetVal;
import com.swhy.xxpl.model.ReptMNetVal_Cifd;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_info;
import com.swhy.xxpl.model.jibao.Rept_Q_net_val;
import com.swhy.xxpl.model.jibao.Rept_qu_acc_info;
import com.swhy.xxpl.model.jibao.Rept_qu_ast_fee_info;
import com.swhy.xxpl.model.jibao.Rept_qu_binsm_info;
import com.swhy.xxpl.model.jibao.Rept_qu_brek_risk_bond_info;
import com.swhy.xxpl.model.jibao.Rept_qu_fund_info;
import com.swhy.xxpl.model.jibao.Rept_qu_ivsm_info;

import net.sf.ehcache.search.expression.And;


@Repository("outerXinXinPiLuDao")
public class OuterXinXiPiLuDao {

		protected Logger logger = Logger.getLogger(this.getClass());
//		@Resource(name = "datasourceXXPLTG") 		// 恒生托管 数据库
//		DataSource dsXXPLTG;

//		@Resource(name = "datasourceXXPLHD") 		// 核对 应用数据库
//		DataSource dsXXPLHD;
		
		@Resource(name = "datasourceXXPLHDMDS")
		DataSource datasourceXXPLHDMDS;
		
		@Resource(name = "dataSourceJBK")
		DataSource datasourceXXPLJBK;

		@Resource(name = "xinXinPiLuDao")
		XinxipiluDao xinXiPiLuDao;
		
		@Resource(name = "rept_Disct_Chk_Rslt") 	// 核对结果 模型
		Rept_Disct_Chk_Rslt  rept_Disct_Chk_Rslt;

		@Resource(name = "XinXiPiLuYueBaoServiceNew")
		XinXiPiLuYueBaoServiceNew yueBaoS;
		private final String GET1MONTHREPTDISCSITU 					= "get1MonthReptDiscSitu.txt";
		private final String GET1MONTHLYMANAGERS					= "get1MonthlyManagers.txt";			


		/**
		 * 按fund Num 获取一个基金的月报的fundinfo,基金属性信息
		 * @param fundNum
		 * @return
		 * @throws IOException 
		 */
		public ReptMFundInfo get1MInfoByFundNum(String fundNum, String WaibaoOrTuoguan, String MonthNO) throws IOException {

			ReptMFundInfo reptMFundInfo = new ReptMFundInfo(WaibaoOrTuoguan);
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = "SELECT * from REPT_M_FUND_INFO WHERE FUND_NUM = ? AND INFO_SRC_CODE = ?  AND MTH_NO= ?  and 1=1";//
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript, fundNum, WaibaoOrTuoguan, MonthNO);
//				//logger.info("sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,
						sqlScript, null);
//				//logger.info(list.toString());
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
		 * 向及贝克推送数据		 
		 * @param rds 	ReptDiscSitu
		 * @param rmfi	ReptMFundInfo		//基本信息
		 * @param rmnv	ReptMNetVal			//净值
		 * @param resultMap Map<String,String> resultMap	//结果表
		 * @return
		 */
		public Boolean upadteYueBaoJiBeiKe(ReptDiscSitu rds,ReptMFundInfo rmfi, ReptMNetVal rmnv, Map<String,String> resultMap) {
			List<Map<String, Object>> result = null;
			Connection con = null;
			try {
				con = datasourceXXPLJBK.getConnection();
				PreparedStatement ps = null;
	            String P1021_0030 = "" ;
	            String P1021_0040 = "" ;
	            String P1021_0050 = "" ;
	            if (rds.hasCFID()) { 
	    			rds.setReptMNetVal_Cifds(xinXiPiLuDao.get1ListOfDiscSituNetVal_Cifd(
	    					rds.getFund_code(), 
	    					Const.WAIBAO, 
	    					rds.getDate_no(), null));

	            } 
				//INTER_PF_1020
				String deleteSQL1020 = "delete from INTER_PF_1020 i1 where i1.STOCK_ID=? and i1.P1020_0010 = to_date(?,'YYYYMMdd') ";
				deleteSQL1020= SqlCommonUtil.getPreparedSQL(deleteSQL1020,rds.getFund_num(), rds.getRept_date());
				ps = con.prepareStatement(deleteSQL1020);
				ps.execute();		
				String sql="";
					sql="insert into INTER_PF_1020 t1\r\n"
							+ "	(STOCK_ID, REPORT_YEAR,REPORT_MARK_DATE, REPORT_TYPE,MODIFY_DATE,P1020_0010,P1020_0020,P1020_0030,P1020_0040,P1020_0050,DATA_SOURCE_NAME,P1020_0060)\r\n"
							+ "		values\r\n"
							+ "	(?, ?, to_date(?,'YYYYMMdd'), 'PB0001', (SELECT SYSDATE FROM DUAL) , to_date(?,'YYYYMMdd'), ?,?,?,? , '定期报告',0) "
							+ " ";
					sql = SqlCommonUtil.getPreparedSQL(sql, rds.getFund_num(), rds.getDate_no().substring(0, 4), rds.getGbicc_exp_date().replace("-", ""),rds.getRept_date(), rmnv.getShr_net_val(), rmnv.getShr_aggr_net_val(),rmnv.getFund_nav(), rmnv.getFund_shr_gamt() );
					logger.info("sql1 "+sql);
					DaoUtil.insert(con, sql);
				if (rds.hasCFID()) {
	    			HashMap< String ,ReptCifdFundCodeMap> rcfcm_map = getReptCifdFundCodeMap(rds.getFund_code());
	                for ( String _key : rcfcm_map.keySet() ) {
	                	ReptCifdFundCodeMap rcfcm = rcfcm_map.get(_key);
	                	if ( rcfcm.getJbk_cifd_no().equals("1")) {
	                		P1021_0030 = rcfcm.getCifd_fund_name(); 
	                	} else if ( rcfcm.getJbk_cifd_no().equals("2")) {
	                		P1021_0040 = rcfcm.getCifd_fund_name(); 
	                	} else if ( rcfcm.getJbk_cifd_no().equals("3")) {
	                		P1021_0050 = rcfcm.getCifd_fund_name(); 
	                	}  
	                } 
					for (ReptMNetVal_Cifd cifd: rds.getReptMNetVal_Cifds()) {
		            	String key = rds.getFund_code() + "#" + "1" + "#" + cifd.getSubf_code() ;  
		            	String jbk_cifd_no = rcfcm_map.get( key ).getJbk_cifd_no() ; 
						sql="insert into INTER_PF_1020 t1\r\n"
								+ "	(STOCK_ID, REPORT_YEAR,REPORT_MARK_DATE, REPORT_TYPE,MODIFY_DATE,P1020_0010,P1020_0020,P1020_0030,P1020_0040,P1020_0050,DATA_SOURCE_NAME,P1020_0060)\r\n"
								+ "		values\r\n"
								+ "	(?, ?, to_date(?,'YYYYMMdd'), 'PB0001', (SELECT SYSDATE FROM DUAL) , to_date(?,'YYYYMMdd'), ?,?,?,? , '定期报告',?) "
								+ " ";
						sql = SqlCommonUtil.getPreparedSQL(sql, rds.getFund_num(), rds.getDate_no().substring(0, 4), rds.getGbicc_exp_date().replace("-", ""),rds.getRept_date(), cifd.getShr_net_val(), cifd.getShr_aggr_net_val(),cifd.getFund_nav(), cifd.getFund_shr_gamt(),
								jbk_cifd_no);
						logger.info("sql1 "+sql);
						DaoUtil.insert(con, sql);
					}
				}
				
				//INTER_PF_1021
				String deleteSQL1021 = "delete from INTER_PF_1021 i1 where i1.STOCK_ID=? and i1.REPORT_MARK_DATE= to_date(?,'YYYYMMdd') ";
				deleteSQL1021= SqlCommonUtil.getPreparedSQL(deleteSQL1021,rds.getFund_num(), rds.getRept_date());
				ps = con.prepareStatement(deleteSQL1021);
				ps.execute();				
 
				String sql2="insert into INTER_PF_1021 t1\r\n"
						+ "	(STOCK_ID, REPORT_YEAR,REPORT_MARK_DATE, REPORT_TYPE,MODIFY_DATE,DATA_SOURCE_NAME"
						+ ",P1021_0030,P1021_0040,P1021_0050"
						+ ")\r\n"
						+ "	values\r\n"
						+ "	(?, ?, to_date(?,'YYYYMMdd'), 'PB0001', (SELECT SYSDATE FROM DUAL) , '定期报告',"
						+ " ?, ?, ?) "
						+ " ";
				sql2 = SqlCommonUtil.getPreparedSQL(sql2, rds.getFund_num(), rds.getDate_no().substring(0, 4), rds.getGbicc_exp_date().replace("-", ""),
						P1021_0030, P1021_0040, P1021_0050);
	            logger.info("分级"+P1021_0030+" "+P1021_0040+" "+P1021_0050);
				logger.info("sql2 "+sql2);
				DaoUtil.insert(con, sql2);
//				ps=con.prepareStatement(sql);
//				ps.executeUpdate();
				con.commit();
			} catch (Exception e) {
				resultMap.put("code","501");
		        resultMap.put("message",e.getMessage());
		        resultMap.put("data",e.toString());
				e.printStackTrace();
				logger.error(e);
				DaoUtil.release(con);
				return false;
			} finally {
				DaoUtil.release(con);
			}
			DaoUtil.release(con);
			return true;
		}
		
		
		/**
		 * 更新及贝克返回结果给reptdiscsitu的备注栏,并更新gbicc_chk_rslt_code
		 * @param memo				详细返回信息
		 * @param fundCode
		 * @param reportType
		 * @param dateNo
		 * @param gbicc_chk_rslt_code	
		 * @return
		 */
		public Boolean updateReptDiscSituMemo(String memo, String fundCode ,String reportType, String dateNo, String gbicc_chk_rslt_code) {
			Connection con = null;
			reportType=yueBaoS.change2MQQUIQUP(reportType);
			try {
				con =  datasourceXXPLHDMDS.getConnection();
				String rect_crt_timeString=  (Constants.SUCCESSFULLYGENERATED.equals(gbicc_chk_rslt_code) || Constants.MANDATORY.equals(gbicc_chk_rslt_code)
							)? ", rect_crt_time = sysdate  ":"";
				String tableName=""; 
				String fundOrManager="";
				if (yueBaoS.isManagerBaseType(reportType) )
				{tableName="REPT_DISC_SITU_MAGR";fundOrManager=" r.MAGR_NO = ? ";}
				else {tableName="REPT_DISC_SITU ";fundOrManager=" r.FUND_CODE = ? ";}
				String sql="update "
						+ tableName
						+ "  r set  r.MEMO = ? , gbicc_chk_rslt_code = ?  "
						+ rect_crt_timeString
						+ "where r.DISC_TYPE_CODE= ?  and r.DATE_NO = ?  and "+fundOrManager 
						+ " \r\n"
						+ "";
				sql = SqlCommonUtil.getPreparedSQL(sql, memo, gbicc_chk_rslt_code, reportType, dateNo, fundCode);
				logger.info("SQL is "+sql);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.execute();	
				logger.info("SQL 处理结束 ");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				logger.error(e);
				DaoUtil.release(con);
			} finally {
				DaoUtil.release(con);
			}
			DaoUtil.release(con);

			return true;
		}
		
		/**
		 * 更新及贝克返回结果给reptdiscsitu的备注栏,并更新gbicc_chk_rslt_code, ##待完善##
		 * @param memo				详细返回信息
		 * @param fundCode
		 * @param reportType
		 * @param dateNo
		 * @param gbicc_chk_rslt_code	
		 * @return
		 */
		public Boolean updateRept_Disc_Pdf_File_Info(String memo, String fundCode ,String reportType, String dateNo, String gbicc_chk_rslt_code) {
			Connection con = null;
			reportType=yueBaoS.change2MQQUIQUP(reportType);
			try {
				con =  datasourceXXPLHDMDS.getConnection();
				String rect_crt_timeString=  (Constants.SUCCESSFULLYGENERATED.equals(gbicc_chk_rslt_code) || Constants.MANDATORY.equals(gbicc_chk_rslt_code)
							)? ", rect_crt_time = sysdate  ":"";
				String sql="update REPT_DISC_SITU r set  r.MEMO = ? , gbicc_chk_rslt_code = ?  "
						+ rect_crt_timeString
						+ "where r.DISC_TYPE_CODE= ?  and r.DATE_NO = ?  and r.FUND_CODE= ? "
						+ " \r\n"
						+ "";
				sql = SqlCommonUtil.getPreparedSQL(sql, memo, gbicc_chk_rslt_code, reportType, dateNo, fundCode);
				logger.info("SQL is "+sql);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.execute();	
				logger.info("SQL 处理结束 ");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				logger.error(e);
				DaoUtil.release(con);
			} finally {
				DaoUtil.release(con);
			}
			DaoUtil.release(con);

			return true;
		}
		
		/**
		 * 查询分级产品及贝克序号
		 * chenlin add 20220608 
		 * @param fund_code
		 * @return HashMap< String  "fund_code#cifd_fund_flag#cifd_fund_no" ,ReptCifdFundCodeMap>
		 */
		public HashMap< String ,ReptCifdFundCodeMap> getReptCifdFundCodeMap( String fund_code ){
			HashMap< String ,ReptCifdFundCodeMap> cfcp_map = new HashMap< String ,ReptCifdFundCodeMap>();  
			List<Map<String, Object>> result = null; 
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				// 套头账号查询 ds1库
				String SQL = " select fund_code "
						   + "      , c_pord_code "
						   + "      , cifd_fund_flag "
						   + "      , cifd_fund_no "
						   + "      , cifd_fund_name "
						   + "      , cstd_cifd_no "
						   + "      , jbk_cifd_no " 
						   + "from  rept_cifd_fund_code_map "
						   + "where fund_code = '"+fund_code+"' ";
				logger.info("分级查询SQL is "+ SQL);
				result = DaoUtil.getResultToList(con, SQL);
				
	            for( Map<String, Object> row : result) {
	            	ReptCifdFundCodeMap cfcp = new ReptCifdFundCodeMap(); 
	            	String _fund_code      = row.get("fund_code").toString(); 
	            	String cifd_fund_flag = row.get("cifd_fund_flag").toString(); 
	            	String cifd_fund_no   = row.get("cifd_fund_no").toString(); 
	            	cfcp.setFund_code( _fund_code );
	            	cfcp.setC_pord_code( row.get("c_pord_code").toString());
	            	cfcp.setCifd_fund_flag( cifd_fund_flag );
	            	cfcp.setCifd_fund_no( cifd_fund_no);
	            	cfcp.setCifd_fund_name( row.get("cifd_fund_name").toString());
	            	cfcp.setCstd_cifd_no( row.get("cstd_cifd_no").toString());
	            	cfcp.setJbk_cifd_no( row.get("jbk_cifd_no").toString());
	            	String key = _fund_code +"#"+ cifd_fund_flag +"#"+ cifd_fund_no;
	            	cfcp_map.put( key , cfcp) ;
	            }  
			} catch (Exception e) {
				e.printStackTrace(); 
				logger.error(e);
			} finally {
				DaoUtil.release(con); 
			}
			return cfcp_map; 
		}
		
		/**
		 * 获取某个月/季度/半年的reptdiscsitu，若输入月份非法则直接返回空
		 * @param month_no
		 * @return 
		 * @throws DecoderException 
		 */
		public List<Map<String,Object>> getSpecificFunds (String dateNo, String serv_scop, String sort, String order, String reportType, String fundCodes) 
				throws DecoderException{
			/* 1. MonthNo */
			if (dateNo==null || "".equals(dateNo)) return null;
			
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MONTHREPTDISCSITU);

				if (yueBaoS.isFundBaseType(reportType)) {
					sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,  dateNo,"%%", reportType);					
				}

				if (yueBaoS.isManagerBaseType(reportType)) {
					sqlScript = SqlCommonUtil.getSQLTXT(this.GET1MONTHLYMANAGERS);
					sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript,"%%", reportType,  dateNo);					
				}

				if (serv_scop!=null) sqlScript += "and serv_scop = '" +serv_scop+"' ";
				if (fundCodes!=null && !"".equals(fundCodes)) {
					fundCodes = fundCodes.replace(",", "','");
					if (yueBaoS.isFundBaseType(reportType)) {
						sqlScript += "and FUND_CODE in ('"+fundCodes+"') ";
					}
					if (yueBaoS.isManagerBaseType(reportType)) {
						sqlScript += "and magr_no in ('"+fundCodes+"') ";
					}
				}
				if (sort!=null) {sqlScript += " order by "+sort; }
				else 			{sqlScript += " order by fund_code"; }
				
				if (order!=null) sqlScript += " "+order;
				else 			{sqlScript += " "+"DESC"; }

				
				logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//				//logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
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
		 * 
		 * @param dateNo
		 * @param reportType
		 * @param fundCodes
		 * @return
		 * @throws DecoderException
		 */
		public List<Map<String,Object>> getFundsMagr (String dateNo,  String reportType, String fundCodes) 
				throws DecoderException{
			
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = "select distinct magr_num from MDS_PTY_MAGR_INFO where MAGR_NO in (\r\n"
						+ "select  MAGR_NO from rept_disc_situ where FUND_CODE in ("+ fundCodes +") \r\n"
						+ "                                                            ) ";
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
				logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//				logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
				return list;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			}finally {
				DaoUtil.release(con);
			}		
		}				
		
		/**
		 * 通过p码找MDS_PTY_MAGR_INFO 中的magr_no
		 * @param dateNo
		 * @param reportType
		 * @param fundCodes
		 * @return
		 * @throws DecoderException
		 */
		public List<Map<String,Object>> getMagrNOByPcode (String magr_p_code) 
				throws DecoderException{
			
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = "\r\n"
						+ "select distinct  MAGR_NO from MDS_PTY_MAGR_INFO where magr_num = ('"+magr_p_code+"') \r\n"
						+ ""
						+ " \r\n";
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
				logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//				logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
				return list;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			}finally {
				DaoUtil.release(con);
			}		
		}	
		
		public List<Map<String,Object>> getMagrName (String magr_p_code, String date_no) 
				throws DecoderException{
			
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = "\r\n"
						+ "select distinct  MAGR_NAME from REPT_DISC_SITU_MAGR where magr_num = '"+magr_p_code+"' and date_no = '"+date_no+"' \r\n"
						+ ""
						+ " \r\n";
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
				logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//				logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
				return list;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			}finally {
				DaoUtil.release(con);
			}		
		}			
		
		
		public List<Map<String,Object>> getFund_codeByC_Pord_Code (String reportType, String date_no, String c_pord_code) 
				throws DecoderException{
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = "select distinct fund_code from MDS_PTY_FUND_INFO where wb_c_pord_code = '"+c_pord_code+"'";
				
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
				logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//				logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
				return list;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			}finally {
				DaoUtil.release(con);
			}		
		}
		
		/**
		 * 根据fundcode去到MDS_PTY_FUND_INFO表查询信息
		 * @param date_no
		 * @param fund_code
		 * @return
		 * @throws DecoderException
		 */
		public List<Map<String,Object>> getfundNumByfund_code(  String fund_code) 
				throws DecoderException{
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			String sqlScript ="";
			try {
				con = datasourceXXPLHDMDS.getConnection();
				sqlScript = "select fund_num  from MDS_PTY_FUND_INFO where fund_code = '"+fund_code+"' and STRT_DATE<= to_char(sysdate,'yyyymmdd') and END_DATE>= to_char(sysdate,'yyyymmdd')  ";
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
				
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
				if (list==null || list.size()<1) {throw new SQLException("cannot find fundNum by "+fund_code);}

//				logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
				return list;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				logger.info(Thread.currentThread().getName()+" getfundNumByfund_code sql is \n"+sqlScript);
				return null;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				logger.info(Thread.currentThread().getName()+" getfundNumByfund_code sql is \n"+sqlScript);
				return null;
			}finally {
				DaoUtil.release(con);
			}		
		}
		
		public List<Map<String,Object>> getMagrPCodeByMagrNo (String magr_no) 
				throws DecoderException{
			
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String sqlScript = "\r\n"
						+ "select distinct  MAGR_NUM from MDS_PTY_MAGR_INFO where magr_no = '"+magr_no+"' \r\n"
						+ ""
						+ " \r\n";
				sqlScript = SqlCommonUtil.getPreparedSQL(sqlScript);
				logger.info(Thread.currentThread().getName()+" prepared sql is "+sqlScript);
				List<Map<String, Object>> list = DaoUtil.getResultToList(con,sqlScript);
//				logger.info("There are _"+list.size()+"_ ReptDiscSitu records in "+month_no);
				return list;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return null;
			}finally {
				DaoUtil.release(con);
			}		
		}		
		
		public Boolean procSMOData (String data_no, String magr_no) 
				throws DecoderException{
			
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String SQL = "\r\n"
						+ " call rept_smo_fm('"+data_no+"28"+"' , '"+magr_no+"' ) \r\n"
						+ ""
						+ " \r\n";
				logger.info("SQL is "+SQL);
				PreparedStatement ps = con.prepareStatement(SQL);
				ps.execute();
				return true;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return false;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return false;
			}finally {
				DaoUtil.release(con);
			}		
		}	
		
		/**
		 * 同步管理人信息，smo与quant使用
		 * @param magr_no	管理人编号
		 * @param report_date 披露周期
		 * @return
		 * @throws DecoderException
		 */
		public Boolean procEtl_init_xp_data (String magr_no, String report_date) 
				throws DecoderException{
			/* 2. 打开数据库并执行sql */
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				String SQL = "\r\n"
						+ " call pro_etl_init_xp_data@db_fm('"+magr_no+"' , '"+report_date+"' ) \r\n"
						+ ""
						+ " \r\n";
				logger.info("SQL is "+SQL);
				PreparedStatement ps = con.prepareStatement(SQL);
				ps.execute();
				return true;
			} catch (SQLException e ) {
				e.printStackTrace();
				logger.error(e);
				return false;
			} catch (Exception e ) {
				e.printStackTrace();
				logger.error(e);
				return false;
			}finally {
				DaoUtil.release(con);
			}		
		}			
		
		
		/**
		 * 
		 * --  * 参    数: biz_date    
		 * --  *  fund_code  
		 * @param fundCode 基金编号 
		 * @param dateNo 数据日期 为当季某一天
		 * @return
		 */
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
		 * 向吉贝克发送报告前调用
		 * @param fund_code
		 * @param date_no
		 * @return
		 */
		public Boolean callPro_Update_Report (String fund_code, String date_no ) {
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				// 套头账号查询 ds1库
			    String sql = "call pro_update_report@db_fm( '"+fund_code+"' , '"+date_no+"' ) " ;
				logger.info("发送吉贝克前调用存储过程"+sql);
				PreparedStatement ps = con.prepareStatement(sql);
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
		 * 向吉贝克发送半年报报告前调用
		 * @param fund_code
		 * @param date_no
		 * @return
		 */
		public Boolean callPro_half_update_Report (String fund_code, String date_no ) {
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				// 套头账号查询 ds1库
			    String sql = "call pro_update_half_report@db_fm( '"+fund_code+"' , '"+date_no+"' ) " ;
				logger.info("发送吉贝克前调用存储过程"+sql);
				PreparedStatement ps = con.prepareStatement(sql);
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
		 * 为清盘报告更新清盘日投资者信息表
		 * @param dateNo
		 * @param fundCode
		 * @return
		 */
		public Boolean callProcedureRept_QUI_Main(  String fundCode , String dateNo, Map<String, String> resultMap ){
			Connection con = null;
			try {
				con = datasourceXXPLHDMDS.getConnection();
				// 套头账号查询 ds1库
				String SQL = "  SELECT mds.rept_qui_main( '"+dateNo+"' , '"+fundCode+"', 1) FROM dual  ";
				logger.info("SQL is "+SQL);
				PreparedStatement ps = con.prepareStatement(SQL);
				ps.execute();
			} catch (Exception e) {
				resultMap.put("message", e.getLocalizedMessage());
				resultMap.put("data", "失败原因：" +e.getMessage());
				e.printStackTrace(); 
				logger.error(e);
				return false;
			} finally {
				DaoUtil.release(con); 
			}
			return true;
		}
		
		
		/**
		 * null值转string "null"
		 * @param col
		 * @return
		 */
		public String colFormat(Object col ) {
			if(col == null) {
				return "null";  
			} else {
				return col.toString(); 
			}
			
		}

		
}
