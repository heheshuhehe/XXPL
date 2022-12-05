package com.fh.dao;

import java.sql.Connection;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.fh.util.DaoUtil;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.hsr.Rept_HSR_aivsm_situ;
import com.swhy.xxpl.model.hsr.Rept_HSR_fund_fee;
import com.swhy.xxpl.model.hsr.Rept_HSR_fund_info;
import com.swhy.xxpl.model.hsr.Rept_HSR_fund_magr;
import com.swhy.xxpl.model.hsr.Rept_HSR_fund_trus;
import com.swhy.xxpl.model.hsr.Rept_HSR_ivst_info;
import com.swhy.xxpl.model.hsr.Rept_HSR_magr_rept;
import com.swhy.xxpl.model.hsr.Rept_HSR_magr_rept_indx;
import com.swhy.xxpl.model.hsr.Rept_HSR_oth_fee_dtl;
import com.swhy.xxpl.model.hsr.Rept_HSR_prjivst;

@Repository("outerHSRXXPLDao")
public class OuterHSRXXPLDao {
	protected Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name = "datasourceXXPLHDMDS")		//估值核对数据库
	DataSource datasourceXXPLHDMDS;
	
	@Resource(name = "dataSourceJBK")			//吉贝克数据库
	DataSource datasourceXXPLJBK;

	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	@Resource(name = "outerXinXinPiLuDao")
	OuterXinXiPiLuDao outerXinXiPiLuDao;
	
	@Resource(name = "rept_Disct_Chk_Rslt") 	// 核对结果 模型
	Rept_Disct_Chk_Rslt  rept_Disct_Chk_Rslt;
	
	public OuterHSRXXPLDao() {
		// TODO Auto-generated constructor stub
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
	
	/**
	 * 更新及贝克半年报
	 * @param rds ReptDiscSitu
	 * @return
	 */
	public Boolean upadteHSRJiBeiKe(ReptDiscSitu rds) {
		List<Map<String, Object>> result = null;
		Connection con = null;
		try {
			con = datasourceXXPLJBK.getConnection();
			Statement stat          = con.createStatement();
			String fundCode         = rds.getFund_code();
			String fundNum          = rds.getFund_num();
			String HSR_NO           = rds.getDate_no();
			String rept_date        = rds.getRept_date() ;  
			String mark_date  		= rds.getGbicc_exp_date().replace("-", "");	//报告截止日期
			String report_year      = rept_date.substring(0,4);
			String report_type      = "PB0004" ;  
			String data_source_name = "定期报告" ;
			Rept_HSR_fund_info  	rept_HSR_fund_info    	= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_fund_info", null,fundCode, HSR_NO,"wb",Rept_HSR_fund_info.class).get(0); 
			Rept_HSR_fund_fee		rept_HSR_fund_fee	  	= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_fund_fee", null,fundCode, HSR_NO,"wb",Rept_HSR_fund_fee.class).get(0); 
//			Rept_HSR_aivsm_situ 	rept_HSR_aivsm_situ		= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_aivsm_situ", null,fundCode, HSR_NO,"wb",Rept_HSR_aivsm_situ.class).get(0); 
//			Rept_HSR_fund_magr 		rept_HSR_fund_magr		= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_fund_magr", null,fundCode, HSR_NO,"wb",Rept_HSR_fund_magr.class).get(0); 
//			Rept_HSR_fund_trus 		rept_HSR_fund_trus		= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_fund_trus", null,fundCode, HSR_NO,"wb",Rept_HSR_fund_trus.class).get(0); 
			List<Rept_HSR_ivst_info> rept_HSR_ivst_infos		= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_ivst_info", null,fundCode, HSR_NO,"wb",Rept_HSR_ivst_info.class); 
//			Rept_HSR_magr_rept_indx rept_HSR_magr_rept_indx	= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_magr_rept_indx", null,fundCode, HSR_NO,"wb",Rept_HSR_magr_rept_indx.class).get(0); 
//			Rept_HSR_magr_rept		rept_HSR_magr_rept		= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_magr_rept", null,fundCode, HSR_NO,"wb",Rept_HSR_magr_rept.class).get(0); 
//			Rept_HSR_oth_fee_dtl	rept_HSR_oth_fee_dtl	= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_oth_fee_dtl", null,fundCode, HSR_NO,"wb",Rept_HSR_oth_fee_dtl.class).get(0); 
//			Rept_HSR_prjivst		rept_HSR_prjivst		= xinXiPiLuDao.getHSRInstanceByFundCode_HSRNO_INFO_SRC_CODE("Rept_HSR_prjivst", null,fundCode, HSR_NO,"wb",Rept_HSR_prjivst.class).get(0); 
			
			//INTER_PF_1010	基金基本情况表   
			String sql="merge into  INTER_PF_1010   targer\r\n"
					 + "using (   \r\n"
					 + "    select nvl( max( ID# ) , 0 ) + 1                 ID#  \r\n"
					 + "         , '"+fundNum+"'                             STOCK_ID\r\n"
					 + "         , '"+report_year+"'                         REPORT_YEAR\r\n"
					 + "         , '"+report_type+"'                         REPORT_TYPE\r\n"
					 + "         , '"+data_source_name+"'                    DATA_SOURCE_NAME\r\n"
					 + "         , to_date('"+mark_date+"' , 'yyyymmdd')     REPORT_MARK_DATE\r\n"
					 + "         , to_date('"+rept_date+"' , 'yyyymmdd')     ANNOUNCEMENT_DATE\r\n"
					 + "         , sysdate                                   MODIFY_DATE\r\n"
					 + "         , nvl("+ this.colFormat(rept_HSR_fund_info.getEnd_fund_shr())  +",0)*10000 P1010_0070\r\n"
					 + "         , nvl("+ this.colFormat(rept_HSR_fund_info.getIvst_vol())  +",0)    P1010_0230  \r\n"					 
					 + "         , '"+ (rds.getServ_scop().equals("外包")?"1":"0") + "'    P1010_0250  \r\n"
					 + "         , nvl("+ this.colFormat(rept_HSR_fund_info.getEnd_fund_shr())  +",0)*10000     P1010_0180  \r\n"					 
					 + "    from INTER_PF_1010  \r\n"
					 + ") source \r\n"
					 + "on (    targer.STOCK_ID            = source.STOCK_ID    \r\n"
		  			 + "    and targer.REPORT_TYPE         = source.REPORT_TYPE\r\n"
		 			 + "    and targer.REPORT_MARK_DATE    = source.REPORT_MARK_DATE      \r\n"
		 			 + "   )     \r\n"
					 + "when matched then  \r\n"
					 + "    update  \r\n"
					 + "    set    REPORT_YEAR         = source.REPORT_YEAR         \r\n"
					 + "	     , DATA_SOURCE_NAME    = source.DATA_SOURCE_NAME 	\r\n"
					 + "         , ANNOUNCEMENT_DATE   = source.ANNOUNCEMENT_DATE   \r\n"
					 + "         , MODIFY_DATE         = source.MODIFY_DATE         \r\n"
					 + "         , P1010_0070          = source.P1010_0070          \r\n" 
					 + "         , P1010_0230          = source.P1010_0230          \r\n" 
					 + "         , P1010_0250          = source.P1010_0250          \r\n" 
					 + "         , P1010_0180          = source.P1010_0180          \r\n" 
					 + "when not matched then  \r\n"
					 + "    insert (  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
					 + "            , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1010_0070          \r\n"
					 + "            , P1010_0250		 , P1010_0180 	     \r\n"
					 + "		   ) \r\n"
					 + "	values (  source.ID#                , source.STOCK_ID           , source.REPORT_YEAR        , source.REPORT_TYPE        , source.DATA_SOURCE_NAME   \r\n"
					 + "            , source.REPORT_MARK_DATE   , source.ANNOUNCEMENT_DATE  , source.MODIFY_DATE        , source.P1010_0070  \r\n"
					 + "            , source.P1010_0250			, source.P1010_0180  \r\n"
					 + "	       ) \r\n";
					    
			logger.info("插入及贝克半年报INTER_PF_1010:" +sql);
			con.createStatement().execute(sql); 
            con.commit();
            
            
            //INTER_PF_1190 基金投资者情况
            sql =   "delete from INTER_PF_1190 "
	              	  + "where STOCK_ID = '"+ fundNum +"' "
	              	  + "and REPORT_TYPE = '"+report_type+"' "
	              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
	            stat.execute(sql);   
	            con.commit();
	        for (Rept_HSR_ivst_info rhii: rept_HSR_ivst_infos ) {   
	        	String investType = rhii.getIvst_type(); if (investType == null) investType= "";
	            sql =  "insert into INTER_PF_1190(\r\n"
	            		+"STOCK_ID            ,REPORT_YEAR    	  ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
	            		+"P1190_0010          ,P1190_0020         ,P1190_0030     ,P1190_0050      ,P1190_0060 \r\n"
	            		+")\r\n"
	            		+"values \r\n"
	              		+"( "
		            	+" '"+fundNum+"'  \r\n"              									// STOCK_ID 
		            	+" , '"+report_year+"'  \r\n"          									// REPORT_YEAR  
		            	+" , '"+report_type+"'  \r\n"          									// REPORT_TYPE  
		            	+" , '"+data_source_name+"' \r\n"      									// DATA_SOURCE_NAME 
		            	+" , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            			// REPORT_MARK_DATE 
		            	+" , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            			// ANNOUNCEMENT_DATE 
		            	+" , sysdate            \r\n"            								// MODIFY_DATE 
		            	+" , "+ rhii.getOnum()+ "" 												// P1190_0010 序号
		            	+" , '"+ rhii.getIvst_name()+ "'" 										// P1190_0020 投资者名称	            		
			            +" , '"+ investType+ "'"              							// P1190_0030 投资者类型
			            +" , " + rhii.getPrin_amt()+ "*10000"                						// P1190_0050 认缴出资
			            +" , "+ rhii.getPdin_scal() + "*10000"       								// P1190_0060 实缴出资
	            		+ ") " ;
	            logger.info("INTER_PF_1190  基金费用 sql：\n" + sql);
	            stat.execute(sql);   
	            con.commit();
	        }
            //INTER_PF_1210 基金费用
            sql =   "delete from INTER_PF_1210 "
	              	  + "where STOCK_ID = '"+ fundNum +"' "
	              	  + "and REPORT_TYPE = '"+report_type+"' "
	              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
	            stat.execute(sql);   
	            con.commit();
	            
            sql =  "insert into INTER_PF_1210(\r\n"
            		+"STOCK_ID          ,REPORT_YEAR    ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
            		+"P1210_0010		,P1210_0020         ,P1210_0030     ,P1210_0040     ,P1210_0050     ,\r\n"
            		+"P1210_0060        ,P1210_0120         ,P1210_0130 "
            		+")\r\n"
            		+"values \r\n"
              		+"( "
            		+" '"+fundNum+"'  \r\n"              								// STOCK_ID 
            		+" , '"+report_year+"'  \r\n"          								// REPORT_YEAR  
            		+" , '"+report_type+"'  \r\n"          								// REPORT_TYPE  
            		+" , '"+data_source_name+"' \r\n"      								// DATA_SOURCE_NAME 
            		+" , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            		// REPORT_MARK_DATE 
            		+" , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            		// ANNOUNCEMENT_DATE 
            		+" , sysdate            \r\n"            							// MODIFY_DATE 
            		+" , "+ this.colFormat( rept_HSR_fund_fee.getPd_aep())+ " *10000" 							// P1210_0010 当期管理费
            		+" , "+ this.colFormat( rept_HSR_fund_fee.getPd_cstd_fee())+ " *10000" 					// P1210_0020 当期托管费
		            +" , "+ this.colFormat( rept_HSR_fund_fee.getPd_perf_remu())+ " *10000"              		// P1210_0030 当期业绩报酬
		            +" , "+ this.colFormat( rept_HSR_fund_fee.getPd_oper_serv_fee())+ " *10000"                // P1210_0040 当期外包服务费
		            +" , "+ this.colFormat( rept_HSR_fund_fee.getPd_oth_fee()) + " *10000"       				// P1210_0050 当期其他费用
		            +" , "+ this.colFormat( rept_HSR_fund_fee.getPd_fee_sum())      + " *10000"				// P1210_0060 当期费用合计
		            +" , "+ this.colFormat( rept_HSR_fund_fee.getAggr_fee_sum())      + " *10000"				// P1210_0120 设立以来当期费用合计
		            +" , "+ this.colFormat( rept_HSR_fund_fee.getPd_ivsm_advr_fee())      + " *10000"			// P1210_0130 当期投资顾问费
            		+ ") " 
    				+ " " ;                 
            logger.info("INTER_PF_1210  基金费用 sql：\n" + sql);
            stat.execute(sql);   
            con.commit();
            
            
            //INTER_PF_1211 基金其他费用明细
            sql =   "delete from INTER_PF_1211 "
	              	  + "where STOCK_ID = '"+ fundNum +"' "
	              	  + "and REPORT_TYPE = '"+report_type+"' "
	              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
	            stat.execute(sql);   
	            con.commit();
//            sql =  "insert into INTER_PF_1211(\r\n"
//            		+"STOCK_ID          ,REPORT_YEAR    ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
//            		+"P1211_0010          ,P1211_0020         ,P1211_0030     \r\n"
//            		+")\r\n"
//            		+"values \r\n"
//              		+"( "
//            		+" '"+fundNum+"'  \r\n"              								// STOCK_ID 
//            		+" , '"+report_year+"'  \r\n"          								// REPORT_YEAR  
//            		+" , '"+report_type+"'  \r\n"          								// REPORT_TYPE  
//            		+" , '"+data_source_name+"' \r\n"      								// DATA_SOURCE_NAME 
//            		+" , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            		// REPORT_MARK_DATE 
//            		+" , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            		// ANNOUNCEMENT_DATE 
//            		+" , sysdate            \r\n"        								// MODIFY_DATE
//            		+" ,'"+rept_HSR_oth_fee_dtl.getOth_fee_name()+"'  \r\n"				//其他费用名称
//            		+" ,"+rept_HSR_oth_fee_dtl.getPd_fee()+"  \r\n"					//当期费用
//            		+" ,"+rept_HSR_oth_fee_dtl.getAggr_fee()+"  \r\n"					//其他费用名称
////            		+" ,'"+rept_HSR_oth_fee_dtl.getOth_fee_name()+"'  \r\n"				//产品成立以来累计费用	
//				
//            		+ ") " 
//    				+ " " ;                 
//            logger.info("INTER_PF_1211  基金其他费用明细 sql：\n" + sql);
//            stat.execute(sql);   
//            con.commit();
            
		} catch (SQLException e) {
			logger.error(e);
			e.printStackTrace();
			DaoUtil.release(con);
			return false;  
		}finally {
			DaoUtil.release(con);
	}
		return true;  
	}
	
}
