package com.fh.dao;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.bcel.generic.NEW;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.fh.service.OuterXXPLService;
import com.fh.service.XinXiPiLuYueBaoServiceNew;
import com.fh.util.Const;
import com.fh.util.DaoUtil;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.ReptDiscSitu_MAGR;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.Rept_M_Magr_Info;
import com.swhy.xxpl.model.Rept_m_qunt_prfund_run;
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

@Repository("outerQuantXXPLDao")
public class OuterQuantXXPLDao {
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
	
	@Resource(name = "XinXiPiLuYueBaoServiceNew")
	XinXiPiLuYueBaoServiceNew yueBaoS;
	
	@Resource(name = "OuterXXPLService")
	OuterXXPLService outerService;
	
	public OuterQuantXXPLDao() {
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
	public Boolean upadteQuantJiBeiKe(ReptDiscSitu_MAGR rdsm) {
		List<Map<String, Object>> result = null;
		Connection con = null;
		try {
			con = datasourceXXPLJBK.getConnection();
			Statement stat          = con.createStatement();
			String magr_no			= rdsm.getMagr_No();
			String Pcode = outerService.getMagrPCodeByMagrNo(magr_no);

			String Date_no           = rdsm.getDate_No();
			String rept_date        = rdsm.getRept_date() ;  
			String mark_date  		= rdsm.getGbicc_exp_date().replace("-", "");	//报告截止日期
			String report_year      = rept_date.substring(0,4);
			String report_type      = yueBaoS.change2PBRS(rdsm.getDisc_Type_Code()) ;  
			String data_source_name = "定期报告" ;
			String manager_name		= rdsm.getMagr_Name();
			Rept_M_Magr_Info rept_M_Magr_Info = xinXiPiLuDao.get1MonthlyReptManagerInfo(magr_no, Const.WAIBAO,rdsm.getDate_No() );

			//INTER_PFYX_4060	管理人信息表
			String sql="merge into  INTER_PFYX_4060   targer\r\n"
					 + "using (   select \r\n"
					 + "           '"+Pcode+"'                             	STOCK_ID\r\n"
					 + "         , '"+report_year+"'                         	REPORT_YEAR\r\n"
					 + "         , '"+report_type+"'                         	REPORT_TYPE\r\n"
					 + "         , '"+data_source_name+"'                    	DATA_SOURCE_NAME\r\n"
					 + "         , to_date('"+mark_date+"' , 'yyyymmdd')     	REPORT_MARK_DATE\r\n"
					 + "         , to_date('"+rept_date+"' , 'yyyymmdd')     	ANNOUNCEMENT_DATE\r\n"
					 + "         , sysdate                                   	MODIFY_DATE\r\n"
					 + "         , "+rept_M_Magr_Info.getMang_Fund_Vol()+" 					P4060_0030\r\n"	//管理基金数量
					 + "         , "+rept_M_Magr_Info.getPart_Mang_Qunt_Fund_Vol()+" 			P4060_0040\r\n"	//其中：管理量化基金数量
					 + "         , "+rept_M_Magr_Info.getMang_Fund_Scal()+" 					P4060_0050\r\n"	//管理基金规模
					 + "         , "+rept_M_Magr_Info.getPart_Mang_Qunt_Fund_Scal()+" 		P4060_0060\r\n"	//其中：管理量化基金规模
					 + "         , "+turnNull2Zero (rept_M_Magr_Info.getPd_elmt_nest_aft_purs_tot_amt())+" 	P4060_0140\r\n"	//当期剔除嵌套后的认购/申购总金额
					 + "         , "+turnNull2Zero (rept_M_Magr_Info.getPd_elmt_nest_aft_redp_tot_amt())+" 	P4060_0150\r\n"	//当期剔除嵌套后的赎回总金额
					 + "    from dual  \r\n"
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
					 + "         , P4060_0030          = source.P4060_0030          \r\n" 
					 + "         , P4060_0040          = source.P4060_0040          \r\n" 
					 + "         , P4060_0050          = source.P4060_0050          \r\n" 
					 + "         , P4060_0060          = source.P4060_0060          \r\n" 
					 + "         , P4060_0140          = source.P4060_0140          \r\n" 
					 + "         , P4060_0150          = source.P4060_0150          \r\n" 
					 + "when not matched then  \r\n"
					 + "    insert (    				  STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
					 + "            , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P4060_0030   		, P4060_0040      \r\n"
					 + "            , P4060_0050		 , P4060_0060		  ,	P4060_0140		   , P4060_0150	 	     \r\n"
					 + "		   ) \r\n"
					 + "	values (   					  source.STOCK_ID     , source.REPORT_YEAR, source.REPORT_TYPE , source.DATA_SOURCE_NAME   \r\n"
					 + "            , source.REPORT_MARK_DATE ,source.ANNOUNCEMENT_DATE,source.MODIFY_DATE, source.P4060_0030, source.P4060_0040  \r\n"
					 + "            , source.P4060_0050	 , source.P4060_0060  , source.P4060_0140  , source.P4060_0150 \r\n"
					 + "	       ) \r\n";
					    
			logger.info("插入及贝克量化月报 INTER_PFYX_4060:" +sql);
			con.createStatement().execute(sql); 
            con.commit();
            
            
            //INTER_PFYX_4061 量化基金统计表

			List<Rept_m_qunt_prfund_run> list = xinXiPiLuDao.getRept_m_qunt_prfund_runByMgrOrMonth(magr_no,
						Date_no, null, null, null);
            sql =   "delete from INTER_PFYX_4061 "
	              	  + "where STOCK_ID = '"+ Pcode +"' "
	              	  + "and REPORT_TYPE = '"+report_type+"' "
	              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
	            stat.execute(sql);   
	            con.commit();
	        for (Rept_m_qunt_prfund_run quant: list ) {   

	            sql =  "insert into INTER_PFYX_4061(\r\n"
	            		+"STOCK_ID            ,REPORT_YEAR    	  ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE\r\n"
	            		+",P4061_0071		,P4061_0072         ,P4061_0080     ,P4061_0090     ,P4061_0100\r\n"	            		
	            		+",P4061_0110		,P4061_0111         ,P4061_0112     ,P4061_0113     ,P4061_0120\r\n"	            		
	            		+",P4061_0130		,P4061_0140         ,P4061_0150     ,P4061_0160     ,P4061_0161\r\n"	            		
	            		+",P4061_0170		,P4061_0180         ,P4061_0190     ,P4061_0191     ,P4061_0195\r\n"	            		
	            		+",P4061_0196		,P4061_0200         ,P4061_0201     ,P4061_0210     ,P4061_0220\r\n"	            		
	            		+",P4061_0240		,P4061_0250         ,P4061_0260     ,P4061_0270     ,P4061_0280\r\n"	            		
	            		+",P4061_0290		,P4061_0020\r\n"	            		

	            		+")\r\n"
	            		+"values \r\n"
	              		+"( "
		            	+" '"+Pcode+"'  \r\n"              									// STOCK_ID 
		            	+" , '"+report_year+"'  \r\n"          									// REPORT_YEAR  
		            	+" , '"+report_type+"'  \r\n"          									// REPORT_TYPE  
		            	+" , '"+data_source_name+"' \r\n"      									// DATA_SOURCE_NAME 
		            	+" , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            			// REPORT_MARK_DATE 
		            	+" , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            			// ANNOUNCEMENT_DATE 
		            	+" , sysdate            \r\n"            								// MODIFY_DATE 
		            	+" , \n '"+ quant.getWarn_line()+ "'" 										//1 P4061_0071	预警线,未设定预警线，则直接填写“无”
		            	+" , '"+ quant.getCovr_line()+ "'" 										//P4061_0072	止损线,未设定预警线，则直接填写“无”
						+" , "+ quant.getFund_scal()+ ""										//P4061_0080	基金规模
						+" , "+ quant.getFund_tot_ast()+ ""										//P4061_0090	基金总资产
						+" , "+ quant.getFund_unit_net_val()+ ""								//P4061_0100	基金单位净值
						+" , \n"+ quant.getFund_unit_aggr_net_val()+ ""							//2 P4061_0110	基金单位累计净值
						+" , "+ quant.getFund_prate()+ ""										//P4061_0111	当期基金收益率
						+" , "+ quant.getCyear_fund_prate()+ ""									//P4061_0112	本年基金收益率
						+" , "+ quant.getAggr_fund_prate()+ ""									//P4061_0113	成立以来基金收益率
						+" , "+ quant.getNet_val_max_pback()+ ""								//P4061_0120	当期净值最大回撤
						+" , \n"+ quant.getStkivsm_amt()+ ""										//3 P4061_0130	股票投资金额
						+" , "+ quant.getAday_hold_stk_vol()+ ""								//P4061_0140	日均持有股票数量
						+" , "+ quant.getAday_stk_mtch_amt()+ ""								//P4061_0150	日均股票成交金额（单边）
						+" , "+ quant.getAday_stk_turn_rate()+ ""								//P4061_0160	日均股票换手率（单边）
						+" , "+ quant.getCasht()+ ""											//P4061_0161	现金类资产
						+" , \n"+ quant.getFutd_marg()+ ""										//4 P4061_0170	期货及衍生品交易保证金
						+" , "+ quant.getPart_stk_futr_trd_marg()+ ""							//P4061_0180	其中：股指期货交易保证金
						+" , "+ quant.getPart_otc_deri_trd_marg()+ ""							//P4061_0190	其中：场外衍生品交易保证金
						+" , "+ quant.getPart_payf_swap_marg()+ ""								//P4061_0191	其中：收益互换保证金
						+" , "+ quant.getOtc_deri_nmpr()+ ""									//P4061_0195	场外衍生品名义本金
						+" , \n"+ quant.getPayf_swap_nmpr()+ ""									//5 P4061_0196	收益互换名义本金
						+" , "+ quant.getOtc_deri_cont_val()+ ""								//P4061_0200	场外衍生品合约价值
						+" , "+ quant.getPayf_swap_cont_val()+ ""								//P4061_0201	收益互换合约价值
						+" , "+ quant.getFin_bal()+ ""											//P4061_0210	融资余额
						+" , "+ quant.getShts_bal()+ ""											//P4061_0220	融券余额
																								//
						+" , \n"+ quant.getPurs_tot_amt()+ ""										//6 P4061_0240	当期申购总金额
						+" , "+ quant.getRedp_tot_amt()+ ""										//P4061_0250	当期赎回总金额
						+" , "+ quant.getOccu_huge_redp_tims()+ ""								//P4061_0260	当期发生巨额赎回次数
						+" , '"+ quant.getHuge_redp_situ_expl()+ "'"								//P4061_0270	巨额赎回情况说明
						+" , '"+ quant.getIs_clear()+ "'"										//P4061_0280	基金是否处于清算过程中(1-是，0-否)
						+" , \n'"+ quant.getIs_scr_futr_trd()+ "'"								//7 P4061_0290	是否直接从事证券期货交易:1是;0否
						+" , '"+ quant.getFund_num()+ "'"										//P4061_0020 基金编码	

	            		+ ") " ;
	            logger.info("INTER_PFYX_4061 量化基金统计表 sql：\n" + sql);
	            stat.execute(sql);   
	            con.commit();
	        }
       
            

		} catch (SQLException e) {
			logger.error(e);
			e.printStackTrace();
			DaoUtil.release(con);
			return false;  
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
			DaoUtil.release(con);
			return false;  
		}finally {
			DaoUtil.release(con);
	}
		return true;  
	}
	
	/**
	 * 把null转“”
	 * @param source
	 * @return
	 */
	public String turnNull2Empty(Object source) {
		return source==null?"":String.valueOf(source) ;
	}
	
	/**
	 * 把null转0.00000000
	 * @param source
	 * @return
	 */
	public BigDecimal turnNull2Zero(Object source) {
		return source==null?new BigDecimal(0):BigDecimal.valueOf(Double.parseDouble(source.toString())) ;
	}
	
}
