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

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.fh.util.DaoUtil;
import com.fh.util.sql.SqlCommonUtil;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptCifdFundCodeMap;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.jibao.Rept_Q_fin_indx;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_info;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_shr_chg;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_hkcsivsm_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_hkcsivsm_grp_dtl;
import com.swhy.xxpl.model.jibao.Rept_Q_iclas_stkivsm_grp;
import com.swhy.xxpl.model.jibao.Rept_Q_net_val;

import net.sf.json.JSONArray;

@Repository("outerJiBaoXinXiPiLuDao")
public class OuterJiBaoXinXiPiLuDao {
	protected Logger logger = Logger.getLogger(this.getClass());

//	@Resource(name = "datasourceXXPLTG") 		// 恒生托管 数据库
//	DataSource dsXXPLTG;

	@Resource(name = "datasourceXXPLHD") 		// 核对 应用数据库
	DataSource dsXXPLHD;
	
	@Resource(name = "datasourceXXPLHDMDS")
	DataSource datasourceXXPLHDMDS;
	
	@Resource(name = "dataSourceJBK")			//吉贝克数据库
	DataSource datasourceXXPLJBK;

	@Resource(name = "xinXinPiLuDao")
	XinxipiluDao xinXiPiLuDao;
	
	@Resource(name = "outerXinXinPiLuDao")
	OuterXinXiPiLuDao outerXinXiPiLuDao;
	
	@Resource(name = "rept_Disct_Chk_Rslt") 	// 核对结果 模型
	Rept_Disct_Chk_Rslt  rept_Disct_Chk_Rslt;
		
	public OuterJiBaoXinXiPiLuDao() {
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
	 * 更新及贝克季报
	 * @param rds ReptDiscSitu
	 * @return
	 */
	public Boolean upadteJiBaoJiBeiKe(ReptDiscSitu rds) {
		List<Map<String, Object>> result = null;
		Connection con = null;
		try {
			con = datasourceXXPLJBK.getConnection();
			Statement stat          = con.createStatement();
			String fundCode         = rds.getFund_code();
			String fundNum          = rds.getFund_num();
			String qut_NO           = rds.getDate_no();
			String rept_date        = rds.getRept_date() ;  
			String mark_date  		= rds.getGbicc_exp_date().replace("-", "");	//报告截止日期
			String report_year      = rept_date.substring(0,4);
			String report_type      = "PB0002" ;  
			String data_source_name = "定期报告" ;  
			
			Rept_Q_fund_info          rept_Q_fund_info    = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fund_info", null,fundCode, qut_NO,"wb",Rept_Q_fund_info.class).get(0); 
			List<Rept_Q_net_val>      rept_Q_net_val_list = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_net_val", null, fundCode, qut_NO,"wb", Rept_Q_net_val.class);
			List<Rept_Q_fin_indx>     rept_Q_fin_indx_list= xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fin_indx", null,fundCode, qut_NO,"wb",Rept_Q_fin_indx.class); 
			Rept_Q_iclas_stkivsm_grp  rept_Q_iclas_stkivsm_grp
			                                              = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_iclas_stkivsm_grp", null, fundCode, qut_NO,"wb", Rept_Q_iclas_stkivsm_grp.class).get(0);
			List<Rept_Q_iclas_hkcsivsm_grp_dtl> rqisg_dtl_list 
			                                              = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_iclas_hkcsivsm_grp_dtl", null, fundCode, qut_NO,"wb", Rept_Q_iclas_hkcsivsm_grp_dtl.class);
			Rept_Q_iclas_hkcsivsm_grp           rqisg     = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_iclas_hkcsivsm_grp", null, fundCode, qut_NO,"wb", Rept_Q_iclas_hkcsivsm_grp.class).get(0);
			
			List<Rept_Q_fund_shr_chg>  rept_Q_fund_shr_chg_list
			                                              = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fund_shr_chg", null, fundCode, qut_NO,"wb", Rept_Q_fund_shr_chg.class);
            // Rept_Q_magr_rept rept_Q_magr_rept = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_magr_rept", null, fundCode, qut_NO,"wb", Rept_Q_magr_rept.class).get(0);
			// rept_Q_magr_rept.setMagr_rept(rept_Q_magr_rept.getMagr_rept().toString().replaceAll("\\n", "\n"));
			
			HashMap< String ,ReptCifdFundCodeMap> rcfcm_map = outerXinXiPiLuDao.getReptCifdFundCodeMap(fundCode);
			
			
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
					 + "         , nvl("+ this.colFormat(rept_Q_fund_info.getFund_tot_shr_pdin_rate())  +",0)*10000 P1010_0070\r\n"
					 + "         , '"+ (rds.getServ_scop().equals("外包")?"1":"0") + "'    P1010_0250  \r\n"
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
					 + "         , P1010_0250          = source.P1010_0250          \r\n"  
					 + "when not matched then  \r\n"
					 + "    insert (  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
					 + "            , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1010_0070          \r\n"
					 + "            , P1010_0250     \r\n"
					 + "		   ) \r\n"
					 + "	values (  source.ID#                , source.STOCK_ID           , source.REPORT_YEAR        , source.REPORT_TYPE        , source.DATA_SOURCE_NAME   \r\n"
					 + "            , source.REPORT_MARK_DATE   , source.ANNOUNCEMENT_DATE  , source.MODIFY_DATE        , source.P1010_0070  \r\n"
					 + "            , source.P1010_0250  \r\n"
					 + "	       ) \r\n"
					  ;  
			logger.info("插入及贝克季报INTER_PF_1010:" +sql);
			con.createStatement().execute(sql); 
            con.commit();
			//INTER_PF_1030	基金净值表现
			//写入前删除数据 
            sql =   "delete from INTER_PF_1030 "
            	  + "where STOCK_ID = '"+ fundNum +"' "
            	  + "and REPORT_TYPE = '"+report_type+"' "
            	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);   
            con.commit();
        	String key = null;
        	String jbk_cifd_no = "0"; 
            for ( Rept_Q_net_val rqnv : rept_Q_net_val_list) { 
            	key = fundCode + "#" + rqnv.getCifd_fund_flag() + "#" + rqnv.getCifd_fund_no() ;  
            	logger.info("key is "+key);
            	jbk_cifd_no = rcfcm_map.get( key ).getJbk_cifd_no() ; 
                sql =   " insert into INTER_PF_1030  \r\n"
                		+ "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME  \r\n"
                		+ " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1030_0010         , P1030_0020        \r\n"
                		+ " , P1030_0030         , P1030_0040         , P1030_0050         , P1030_0060        \r\n"
                		+ " ) \r\n"
                		+ "values \r\n"
                		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1030 ) + 1 \r\n" // ID#   
                		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                		+ " , sysdate            \r\n"            // MODIFY_DATE 
                		+ " , '当季'              \r\n"            // 阶段
                		+ " , nvl("+this.colFormat( rqnv.getQut_net_val_irate()  ) +",0)/100          \r\n"// 净值增长率, 专为吉贝克除以100
                		+ " , nvl("+this.colFormat( rqnv.getQut_net_val_irate_stdev() ) +",0)/100     \r\n"// 净值增长率标准差， 专为吉贝克除以100
                		+ " , null         \r\n "            // 业绩比较基准收益率
                		+ " , null         \r\n "            // 业绩比较基准收益率标准差
                		+ " , '"+ jbk_cifd_no +"'   \r\n "            // 分级基金标识 
                		+ ") " ; 
                stat.execute(sql);  
                con.commit();
                sql =   " insert into INTER_PF_1030  \r\n"
                		+ "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME  \r\n"
                		+ " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1030_0010         , P1030_0020        \r\n"
                		+ " , P1030_0030         , P1030_0040         , P1030_0050         , P1030_0060        \r\n"
                		+ " ) \r\n"
                		+ "values \r\n"
                		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1030 ) + 2 \r\n" // ID#   
                		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                		+ " , sysdate            \r\n"            // MODIFY_DATE 
                		+ " , '自基金合同生效起至今'      \r\n"            // 阶段
                		+ " , nvl("+this.colFormat( rqnv.getNet_val_irate()  ) +",0)/100          \r\n"// 净值增长率, 专为吉贝克除以100
                		+ " , nvl("+this.colFormat( rqnv.getNet_val_irate_stdev() ) +",0)/100     \r\n"// 净值增长率标准差， 专为吉贝克除以100
                		+ " , null         \r\n "            // 业绩比较基准收益率
                		+ " , null         \r\n "            // 业绩比较基准收益率标准差
                		+ " , '"+ jbk_cifd_no +"'   \r\n "            // 分级基金标识 
                		+ ") " ; 
    			logger.info("插入及贝克季报INTER_PF_1030:" +sql);
                stat.execute(sql);     
                con.commit();
            }
			// INTER_PF_1040	主要会计数据和财务指标
			//写入前删除数据 
            sql =   "delete from INTER_PF_1040 "
            	  + "where STOCK_ID = '"+ fundNum +"' "
            	  + "and REPORT_TYPE = '"+report_type+"' "
            	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);   
            con.commit();
            key = null;
        	jbk_cifd_no = "0"; 
            for ( Rept_Q_fin_indx rqfi : rept_Q_fin_indx_list) { 
            	key = fundCode + "#" + rqfi.getCifd_fund_flag() + "#" + rqfi.getCifd_fund_no() ;  
            	jbk_cifd_no = rcfcm_map.get( key ).getJbk_cifd_no() ; 
                sql =   " insert into INTER_PF_1040  \r\n"
                		+ "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_MARK_DATE   , REPORT_TYPE        \r\n"
                		+ " , DATA_SOURCE_NAME   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1040_0000N        , P1040_0010         \r\n"
                		+ " , P1040_0020         , P1040_0030         , P1040_0040         , P1040_0080         , P1040_0100         \r\n"
                		+ " , P1040_0110       ) \r\n"
                		+ "values \r\n"
                		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1040 ) + 1 \r\n" // ID#    
                		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                		+ " , sysdate            \r\n"            // MODIFY_DATE 
                		 
                		+ " , '本期'               \r\n"     // 期间 
                		+ " , '"+this.colFormat( rqfi.getCpd_payf() )+"'            \r\n"     // 本期已实现收益 
                		+ " , '"+this.colFormat( rqfi.getCpd_prof() )+"'            \r\n"     // 本期利润 
                		+ " , '"+this.colFormat( rqfi.getEnd_net_ast() )+"'         \r\n"     // 期末基金资产净值 
                		+ " , '"+this.colFormat( rqfi.getEnd_unit_net_val() )+"'    \r\n"     // 期末基金份额净值  
                		+ " , '"+jbk_cifd_no+"'                                     \r\n"     // 分级基金标识 
                		+ " , to_date('"+this.colFormat( rqfi.getBegn_date() )+"', 'yyyy/mm/dd' )   \r\n"     // 数据起始日期(中信定制,3的表头) 
                		+ " , to_date('"+this.colFormat( rqfi.getExp_date() )+"' , 'yyyy/mm/dd' )   \r\n"     // 数据截止日期(中信定制,3的表头)
                		+ ") " ;  
    			logger.info("插入及贝克季报INTER_PF_1040:" +sql);
                stat.execute(sql);     
            }
            
            // INTER_PF_1070	期末按行业分类的股票投资组合
			//写入前删除数据 
            sql =   "delete from INTER_PF_1070 "
            	  + "where STOCK_ID = '"+ fundNum +"' "
            	  + "and REPORT_TYPE = '"+report_type+"' "
            	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);     
            sql =   " insert into INTER_PF_1070  \r\n"
                  + "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
                  + " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1070_0000N        , P1070_0010         \r\n"
                  + " , P1070_0020         , P1070_0030         , P1070_0040         , P1070_0050         , P1070_0060         \r\n"
                  + " , P1070_0070         , P1070_0080         , P1070_0090         , P1070_0100         , P1070_0110         \r\n"
                  + " , P1070_0120         , P1070_0130         , P1070_0140         , P1070_0150         , P1070_0160         \r\n"
                  + " , P1070_0170         , P1070_0180         , P1070_0190         , P1070_0200        "
                  + " ) \r\n"
                  + "values \r\n"
                  + "( ( select nvl( max (ID#), 0) from INTER_PF_1070 ) + 1 \r\n" // ID#    
                  + " , '"+fundNum+"'  \r\n"              // STOCK_ID 
               	  + " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
               	  + " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
               	  + " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
               	  + " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
               	  + " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
               	  + " , sysdate            \r\n"            // MODIFY_DATE 
                		 
               	  + " , '公允价值'               \r\n"     // 数据类型  
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_a_far_val() )+"    \r\n"     // 农、林、牧、渔业 
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_b_far_val() )+"    \r\n"     // 采矿业  
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_c_far_val() )+"    \r\n"     // 制造业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_d_far_val() )+"    \r\n"     // 电力、热力、燃气及水生产和供应业   
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_e_far_val() )+"    \r\n"     // 建筑业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_f_far_val() )+"    \r\n"     // 批发和零售业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_g_far_val() )+"    \r\n"     // 交通运输、仓储和邮政业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_h_far_val() )+"    \r\n"     // 住宿和餐饮业 
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_i_far_val() )+"    \r\n"     // 信息传输、软件和信息技术服务业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_j_far_val() )+"    \r\n"     // 金融业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_k_far_val() )+"    \r\n"     // 房地产业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_l_far_val() )+"    \r\n"     // 租赁和商务服务业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_m_far_val() )+"    \r\n"     // 科学研究和技术服务业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_n_far_val() )+"    \r\n"     // 水利、环境和公共设施管理业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_o_far_val() )+"    \r\n"     // 居民服务、修理和其他服务业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_p_far_val() )+"    \r\n"     // 教育 
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_q_far_val() )+"    \r\n"     // 卫生和社会工作
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_r_far_val() )+"    \r\n"     // 文化、体育和娱乐业
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_s_far_val() )+"    \r\n"     // 综合
               	  + " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getSum_far_val() )+"       \r\n"     // 合计 
               	  + ") " ;  
            stat.execute(sql);        
            sql =   " insert into INTER_PF_1070  \r\n"
                  + "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
                  + " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1070_0000N        , P1070_0010         \r\n"
                    	+ " , P1070_0020         , P1070_0030         , P1070_0040         , P1070_0050         , P1070_0060         \r\n"
                    	+ " , P1070_0070         , P1070_0080         , P1070_0090         , P1070_0100         , P1070_0110         \r\n"
                    	+ " , P1070_0120         , P1070_0130         , P1070_0140         , P1070_0150         , P1070_0160         \r\n"
                    	+ " , P1070_0170         , P1070_0180         , P1070_0190         , P1070_0200        "
                    	+ " ) \r\n"
                   		+ "values \r\n"
                   		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1070 ) + 1 \r\n" // ID#    
                   		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                   		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                   		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                   		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                   		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                   		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                   		+ " , sysdate            \r\n"            // MODIFY_DATE 
                    		 
                   		+ " , '占基金资产净值比例'               \r\n"     // 数据类型  
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_a_nav_rati() )+"/100    \r\n"     // 农、林、牧、渔业 
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_b_nav_rati() )+"/100    \r\n"     // 采矿业  
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_c_nav_rati() )+"/100    \r\n"     // 制造业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_d_nav_rati() )+"/100    \r\n"     // 电力、热力、燃气及水生产和供应业   
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_e_nav_rati() )+"/100    \r\n"     // 建筑业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_f_nav_rati() )+"/100    \r\n"     // 批发和零售业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_g_nav_rati() )+"/100    \r\n"     // 交通运输、仓储和邮政业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_h_nav_rati() )+"/100    \r\n"     // 住宿和餐饮业 
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_i_nav_rati() )+"/100    \r\n"     // 信息传输、软件和信息技术服务业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_j_nav_rati() )+"/100    \r\n"     // 金融业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_k_nav_rati() )+"/100    \r\n"     // 房地产业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_l_nav_rati() )+"/100    \r\n"     // 租赁和商务服务业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_m_nav_rati() )+"/100    \r\n"     // 科学研究和技术服务业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_n_nav_rati() )+"/100    \r\n"     // 水利、环境和公共设施管理业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_o_nav_rati() )+"/100    \r\n"     // 居民服务、修理和其他服务业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_p_nav_rati() )+"/100    \r\n"     // 教育 
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_q_nav_rati() )+"/100    \r\n"     // 卫生和社会工作
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_r_nav_rati() )+"/100    \r\n"     // 文化、体育和娱乐业
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getCsrc_s_nav_rati() )+"/100    \r\n"     // 综合
                   		+ " , "+this.colFormat( rept_Q_iclas_stkivsm_grp.getSum_nav_rati() )+"/100       \r\n"     // 合计 
                   		+ ") " ;  
			logger.info("插入及贝克季报INTER_PF_1070:" +sql);
            stat.execute(sql);       
                    
            // INTER_PF_1071	沪港通投资股票投资组合明细
            //写入前删除数据 
            sql =   "delete from INTER_PF_1071 "
                	  + "where STOCK_ID = '"+ fundNum +"' "
                	  + "and REPORT_TYPE = '"+report_type+"' "
                	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);    
            for ( Rept_Q_iclas_hkcsivsm_grp_dtl rqisg_dtl : rqisg_dtl_list) {   
                 sql =   " insert into INTER_PF_1071  \r\n"
                    		+ "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
                    		+ " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1071_0010         , P1071_0020         \r\n"
                    		+ " , P1071_0030       ) \r\n"
                    		+ "values \r\n"
                    		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1071 ) + 1 \r\n" // ID#    
                    		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                    		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                    		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                    		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                    		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                    		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                    		+ " , sysdate            \r\n"            // MODIFY_DATE 
                    		 
                    		+ " , '"+this.colFormat( rqisg_dtl.getIclas() )+"'            \r\n"     // 行业类别
                    		+ " , "+this.colFormat( rqisg_dtl.getFar_val() )+"              \r\n"     // 公允价值
                    		+ " , "+this.colFormat( rqisg_dtl.getNav_rati() )+"/100           \r\n"     // 占净值比例（%）    
                    		+ ") " ;  
     			logger.info("插入及贝克季报INTER_PF_1071:" +sql);
                 stat.execute(sql);     
            }   

            // INTER_PF_1072	期末按行业分类的沪港通投资股票投资组合合计 
            // 写入前删除数据 
            sql =   "delete from INTER_PF_1072 "
                	  + "where STOCK_ID = '"+ fundNum +"' "
                	  + "and REPORT_TYPE = '"+report_type+"' "
                	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);     
            sql =   " insert into INTER_PF_1072  \r\n"
                    	+ "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
                    	+ " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1072_0010         , P1072_0020         \r\n"
                    	+ " ) \r\n"
                   		+ "values \r\n"
                   		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1072 ) + 1 \r\n" // ID#    
                   		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                   		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                   		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                   		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                   		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                   		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                   		+ " , sysdate            \r\n"            // MODIFY_DATE 
                    		  
                   		+ " , "+this.colFormat( rqisg.getFar_val()  )+"    \r\n"     // 公允价值合计 
                   		+ " , "+this.colFormat( rqisg.getNav_rati() )+"/100    \r\n"     // 占净值比例合计（%） 
                   	//	+ " , "+this.colFormat( rqisg.getMemo() )+"    \r\n"     // 备注 
                   		+ ") " ;  
 			logger.info("插入及贝克季报INTER_PF_1072:" +sql);
            stat.execute(sql);     
                     
            // INTER_PF_1080	基金份额变动情况
            //写入前删除数据 
            sql =   "delete from INTER_PF_1080 "
                  + "where STOCK_ID = '"+ fundNum +"' "
                  + "and REPORT_TYPE = '"+report_type+"' "
                  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);    
            key = null;
        	jbk_cifd_no = "0"; 
            for ( Rept_Q_fund_shr_chg rqfsc : rept_Q_fund_shr_chg_list) {   
            	key = fundCode + "#" + rqfsc.getCifd_fund_flag() + "#" + rqfsc.getCifd_fund_no() ;  
            	jbk_cifd_no = rcfcm_map.get( key ).getJbk_cifd_no() ; 
                 sql =   " insert into INTER_PF_1080  \r\n"
                       + "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
                       + " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1080_0010         , P1080_0020         \r\n"
                       + " , P1080_0030         , P1080_0040         , P1080_0050         , P1080_0060         \r\n"
                       + " ) \r\n"
                    		+ "values \r\n"
                    		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1080 ) + 1 \r\n" // ID#    
                    		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                    		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                    		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                    		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                    		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                    		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                    		+ " , sysdate            \r\n"            // MODIFY_DATE 
                    		 
//                    		+ " , '本期'               \r\n"     // 期间 
                    		+ " , nvl("+this.colFormat( rqfsc.getBgng_fund_shr_gamt() )+",0) *10000             \r\n"     // 报告期期初基金份额总额 
                    		+ " , nvl("+this.colFormat( rqfsc.getPd_fund_tot_purs_shr() )+",0) *10000            \r\n"     // 报告期期间基金总申购份额  
                    		+ " , nvl("+this.colFormat( rqfsc.getPd_fund_tot_redp_shr() )+",0) *10000            \r\n"     // 减：报告期期间基金总赎回份额 
                    		+ " , nvl("+this.colFormat( rqfsc.getPd_fund_spli_chg_sh() )+",0) *10000            \r\n"     // 报告期期间基金拆分变动份额 
                    		+ " , nvl("+this.colFormat( rqfsc.getFund_tot_shr_pdin_rate() )+",0) *10000            \r\n"     // 报告期期末基金份额总额
                    		+ " , '"+jbk_cifd_no+"'        \r\n"  // 分级基金标识    
                    		+ ") " ;  
      			logger.info("插入及贝克季报INTER_PF_1080:" +sql);
                 stat.execute(sql);     
            }   
            // INTER_PF_1181	季报备注信息 
            // 写入前删除数据 
            sql =   "delete from INTER_PF_1181 "
                	  + "where STOCK_ID = '"+ fundNum +"' "
                	  + "and REPORT_TYPE = '"+report_type+"' "
                	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);    
            // HashMap< String ,ReptCifdFundCodeMap> 
            String P1181_0060 = "" ;
            String P1181_0070 = "" ;
            String P1181_0080 = "" ;
            if (  rds.hasCFID()) { 
                for ( String _key : rcfcm_map.keySet() ) {
                	ReptCifdFundCodeMap rcfcm = rcfcm_map.get(_key);
                	if ( rcfcm.getJbk_cifd_no().equals("1")) {
                		P1181_0060 = rcfcm.getCifd_fund_name(); 
                	} else if ( rcfcm.getJbk_cifd_no().equals("2")) {
                		P1181_0070 = rcfcm.getCifd_fund_name(); 
                	} else if ( rcfcm.getJbk_cifd_no().equals("3")) {
                		P1181_0080 = rcfcm.getCifd_fund_name(); 
                	}  ; 
                } 
            }  

            sql =   " insert into INTER_PF_1181  \r\n"
                    	+ "(  ID#                , STOCK_ID           , REPORT_YEAR        , REPORT_TYPE        , DATA_SOURCE_NAME   \r\n"
                    	+ " , REPORT_MARK_DATE   , ANNOUNCEMENT_DATE  , MODIFY_DATE        , P1181_0010         , P1181_0020         \r\n"
                    	+ " , P1181_0030         , P1181_0040         , P1181_0050         , P1181_0060         , P1181_0070         \r\n"
                    	+ " , P1181_0080         "
                    	+ " ) \r\n"
                   		+ "values \r\n"
                   		+ "( ( select nvl( max (ID#), 0) from INTER_PF_1181 ) + 1 \r\n" // ID#    
                   		+ " , '"+fundNum+"'  \r\n"              // STOCK_ID 
                   		+ " , '"+report_year+"'  \r\n"          // REPORT_YEAR  
                   		+ " , '"+report_type+"'  \r\n"          // REPORT_TYPE  
                   		+ " , '"+data_source_name+"' \r\n"      // DATA_SOURCE_NAME 
                   		+ " , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            // REPORT_MARK_DATE 
                   		+ " , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            // ANNOUNCEMENT_DATE 
                   		+ " , sysdate            \r\n"            // MODIFY_DATE 
                    		  
                   		+ " , ''     \r\n"     // 基金净值表现备注 
                   		+ " , ''     \r\n"     // 主要财务指标备注
                   		+ " , ''     \r\n"     // 期末基金资产组合情况备注
                   		+ " , ''     \r\n"     // 报告期末按行业分类的股票投资组合备注
                   		+ " , ''     \r\n"     // 基金份额变动情况备注
                   		+ " , '"+P1181_0060+"'    \r\n"     // 分级基金类型名称1 
                   		+ " , '"+P1181_0070+"'    \r\n"     // 分级基金类型名称2
                   		+ " , '"+P1181_0080+"'    \r\n"     // 分级基金类型名称3 
                   		+ ") " ;  
            
  			logger.info("插入及贝克季报INTER_PF_1181:" +sql);
            stat.execute(sql);    
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
				DaoUtil.release(con);
		}
		return true;
	} 
	
}
