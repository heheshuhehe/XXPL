package com.fh.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.fh.util.DaoUtil;
import com.fh.util.sql.SqlCommonUtil;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.swhy.xxpl.model.ReptDiscSitu;
import com.swhy.xxpl.model.Rept_Disct_Chk_Rslt;
import com.swhy.xxpl.model.jibao.Rept_Q_fund_info;
import com.swhy.xxpl.model.jibao.Rept_qu_acc_info;
import com.swhy.xxpl.model.jibao.Rept_qu_ast_fee_info;
import com.swhy.xxpl.model.jibao.Rept_qu_binsm_info;
import com.swhy.xxpl.model.jibao.Rept_qu_brek_bond_info;
import com.swhy.xxpl.model.jibao.Rept_qu_brek_risk_bond_info;
import com.swhy.xxpl.model.jibao.Rept_qu_fund_info;
import com.swhy.xxpl.model.jibao.Rept_qu_ivsm_info;
import com.swhy.xxpl.model.jibao.Rept_qu_risk_bond_info;

@Repository("outerJiDuGengXinXXPLDao")
public class OuterJiDuGengXinXXPLDao {

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
	
	public OuterJiDuGengXinXXPLDao() {
		// TODO Auto-generated constructor stub
	}

	/*
	 * 向及贝克推送数据季度更新，产品运行表
	 */
	public Boolean upadteJiDuGengXinJiBeiKe(ReptDiscSitu rds) {
		List<Map<String, Object>> result = null;
		Connection con = null;
		
		try {
			con = datasourceXXPLJBK.getConnection();
			PreparedStatement ps = null;
			Statement stat          = con.createStatement();
			String fundCode         = rds.getFund_code();
			String fundNum          = rds.getFund_num();
			String qut_NO           = rds.getDate_no();
			String rept_date        = rds.getRept_date() ;  
			logger.info(rds.getGbicc_exp_date());
			String mark_date  		= rds.getGbicc_exp_date().replace("-", "");	//报告截止日期
			String report_year      = rept_date.substring(0,4);
			String report_type      = "RS0001" ;  
			String data_source_name = "定期报告" ;  
			
//			Rept_Q_fund_info          rept_Q_fund_info    = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_Q_fund_info", null,fundCode, qut_NO,"wb",Rept_Q_fund_info.class).get(0); 
//			Rept_qu_fund_info rept_qu_fund_info = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_fund_info", null, fundCode, qut_NO,"wb",Rept_qu_fund_info.class).get(0);
//			Rept_qu_acc_info rept_qu_acc_info =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_acc_info", null, fundCode, qut_NO,"wb", Rept_qu_acc_info.class).get(0);
//			Rept_qu_prjivst rept_qu_prjivst =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_prjivst", null, fundCode, qut_NO,"wb", Rept_qu_prjivst.class).get(0);
			Rept_qu_ivsm_info rept_qu_ivsm_info = xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_ivsm_info", null, fundCode, qut_NO,"wb", Rept_qu_ivsm_info.class).get(0);
			Rept_qu_binsm_info rept_qu_binsm_info =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_binsm_info", null, fundCode, qut_NO,"wb", Rept_qu_binsm_info.class).get(0);
			Rept_qu_brek_risk_bond_info rept_qu_brek_risk_bond_info =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_brek_risk_bond_info", null, fundCode, qut_NO,"wb", Rept_qu_brek_risk_bond_info.class).get(0);
			Rept_qu_ast_fee_info rept_qu_ast_fee_info =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_ast_fee_info", null, fundCode, qut_NO,"wb", Rept_qu_ast_fee_info.class).get(0);
			List<Rept_qu_brek_bond_info> list_rept_qu_brek_bond_info =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_brek_bond_info", null, fundCode, qut_NO,"wb", Rept_qu_brek_bond_info.class);
			List<Rept_qu_risk_bond_info> list_rept_qu_risk_bond_info =xinXiPiLuDao.getJiBaoInstanceByFundCode_QutNO_INFO_SRC_CODE("MDS.Rept_qu_risk_bond_info", null, fundCode, qut_NO,"wb", Rept_qu_risk_bond_info.class);

			//INTER_PFYX_1020 产品运行监测报表
			//删除数据
			String sql =   "delete from INTER_PFYX_1020 "
              	  + "where STOCK_ID = '"+ fundNum +"' "
              	  + "and REPORT_TYPE = '"+report_type+"' "
              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
            stat.execute(sql);   
            con.commit();
            //插入新数据
            sql =  "insert into INTER_PFYX_1020(\r\n"
            		+"ID#                 , STOCK_ID          ,REPORT_YEAR    ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
            		+"P1020_0010          ,P1020_0020         ,P1020_0030     ,P1020_0040     ,P1020_0041     ,\r\n"
            		+"P1020_0042          ,P1020_0043         ,P1020_0050     ,P1020_0051     ,P1020_0060     ,\r\n"
            		+"P1020_0061          ,P1020_0070         ,P1020_0071     ,P1020_0080     ,P1020_0090     ,\r\n"
            		+"P1020_0100          ,P1020_0110         ,P1020_0120     ,P1020_0130     ,\r\n"
            		+"P1020_0140          ,P1020_0150         ,P1020_0160     ,P1020_0180     ,P1020_0190     ,\r\n"
            		+"P1020_0200          ,P1020_0210         ,P1020_0220     ,P1020_0230     ,P1020_0240     ,\r\n"
            		+"P1020_0250          ,P1020_0251         ,P1020_0252     ,P1020_0260     ,P1020_0270     ,\r\n"
            		+"P1020_0280          ,P1020_0290         ,P1020_0300     ,P1020_0310     ,P1020_0320     ,\r\n"
            		+"P1020_0330          ,P1020_0331         ,P1020_0332     ,P1020_0340     ,P1020_0350     ,\r\n"
            		+"P1020_0360          ,P1020_0370         ,P1020_0380     ,P1020_0390     ,P1020_0400     ,\r\n"
            		+"P1020_0410          ,P1020_0420         ,P1020_0430     ,P1020_0440     ,P1020_0450     ,\r\n"
            		+"P1020_0460          ,P1020_0470         ,P1020_0480     ,P1020_0490     ,P1020_0500     ,\r\n"
            		+"P1020_0510          ,P1020_0520         ,P1020_0530     ,P1020_0531     ,P1020_0540     ,\r\n"
            		+"P1020_0550		  ,P1020_0570\r\n"
            		+")\r\n"
            		+"values \r\n"
              		+"( ( select nvl( max (ID#), 0) from INTER_PFYX_1020 ) + 1 \r\n" 		// ID#   
            		+" , '"+fundNum+"'  \r\n"              								// STOCK_ID 
            		+" , '"+report_year+"'  \r\n"          								// REPORT_YEAR  
            		+" , '"+report_type+"'  \r\n"          								// REPORT_TYPE  
            		+" , '"+data_source_name+"' \r\n"      								// DATA_SOURCE_NAME 
            		+" , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            		// REPORT_MARK_DATE 
            		+" , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            		// ANNOUNCEMENT_DATE 
            		+" , sysdate            \r\n"            // MODIFY_DATE 
            		+" , to_date('"+rept_qu_ast_fee_info.getValu_basi_date()+"', 'yyyy-mm-dd')"	//估值基准日期
            		+" , "+ rept_qu_ast_fee_info.getEnd_tot_ast()+ ""   						//期末总资产
            		+" , "+ rept_qu_ast_fee_info.getEnd_net_ast()+ ""   						//期末净资产
            		+" , "+ rept_qu_ast_fee_info.getAggr_aep()+ ""    						//产品成立以来累计管理费
            		+" , "+ rept_qu_ast_fee_info.getAggr_has_aep()+ ""     					//产品成立以来累计支付管理费 
            		+" , "+ rept_qu_ast_fee_info.getAggr_ivsm_advr_fee()+ ""    				//产品成立以来累计投资顾问费
            		+" , "+ rept_qu_ast_fee_info.getAggr_has_ivsm_advr_fee()+ ""   			//产品成立以来累计已付投资顾问费
            		+" , "+ rept_qu_ast_fee_info.getAggr_cstd_fee()+ ""			   			//产品成立以来累计托管费
            		+" , "+ rept_qu_ast_fee_info.getAggr_has_cstd_fee()+ ""	   		//产品成立以来累计支付托管费
            		+" , "+ rept_qu_ast_fee_info.getAggr_oper_serv_fee()+ ""			//产品成立以来累计运营服务费
            		+" , "+ rept_qu_ast_fee_info.getAggr_has_oper_serv_fee()+ ""		//产品成立以来累计支付运营服务费
            		+" , "+ rept_qu_ast_fee_info.getAggr_perf_remu()+ ""				//产品成立以来累计业绩报酬
            		+" , "+ rept_qu_ast_fee_info.getAggr_has_perf_remu()+ ""	   		//产品成立以来累计支付业绩报酬
            		+" , '"+ turnNull2Empty(rept_qu_ast_fee_info.getAggr_oth_fee())+ "'"				//产品成立以来累计其他费用
            		+" , "+ rept_qu_ast_fee_info.getAggr_bons()+ ""			   		//产品成立以来累计分红
            		+" , "+ rept_qu_ast_fee_info.getAggr_prin_payf_assn()+ ""			//产品成立以来累计本金、收益分配
            		+" , "+ rept_qu_ast_fee_info.getEnd_unit_net_val()+ ""			//报告期期末单位净值
            		+" , "+ rept_qu_ast_fee_info.getRpd_end_aggr_unit_net_val()+ ""	//报告期期末单位累计净值
            		+" , "+ rept_qu_ast_fee_info.getRpd_end_aft_unit_net_val()+ ""	//报告期末劣后级单位净值
            		+" , "+ rept_qu_ivsm_info.getCasht_bnk_dpsi()+ ""					//银行存款
            		+" , "+ rept_qu_ivsm_info.getUnlist_sivsm()+ ""								//股权投资
            		+" , "+ rept_qu_ivsm_info.getUnlist_sivsm_part_prstk()+ ""					//其中：优先股
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getUnlist_sivsm_part_osivsm())+ "'"				//其他股权类投资
            		+" , "+ rept_qu_ivsm_info.getLcda_stkivsm()+ ""						//上市公司定向增发股票投资
            		+" , "+ rept_qu_ivsm_info.getNivsm()+ ""								//新三板挂牌企业投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_drfb()+ ""						//结算备付金
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_gdpacb()+ ""					//存出保证金
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_stkivsm()+ ""					//股票投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_binsm()+ ""						//债券投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_binsm_part_ib()+ ""				//其中：银行间市场债券
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_binsm_part_intrb()+ ""			//其中：利率债
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_binsm_part_credb()+ ""			//其中：信用债
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_abs()+ ""							//资产支持证券
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_cfivsm()+ ""						//基金投资（公募基金）
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_cfivsm_part_cfund()+ ""				//其中：货币基金
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_futdivsm()+ ""						//期货、期权及其他衍生品投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_futdivsm_part_sifutd()+ ""	//其中：股指期货投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_futdivsm_part_bfutd()+ ""	//其中：国债期货投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_futdivsm_part_mfutd()+ ""	//其中：商品期货投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_futdivsm_part_opt()+ ""		//其中：个股期权投资
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_futd_marg()+ ""		//期货及衍生品交易保证金
            		+" , "+ rept_qu_ivsm_info.getSecuivsm_bsofa()+ ""			//买入返售金融资产
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getSecuivsm_oth_secu())+ "'"		//其他证券类标的
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_bfpivsm())+ "'"			//商业银行理财产品投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_tpivsm())+ "'"			//信托计划投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_famivsm())+ "'"			//基金公司及其子公司资产管理计划投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_iamivsm())+ "'"			//保险资产管理计划投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_samivsm())+ "'"			//证券公司及其子公司资产管理计划投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_futamivsm())+ "'"		//期货公司及其子公司资产管理计划投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_pfpivsm())+ "'"			//私募基金产品投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getAivsm_nfpivsm())+ "'"			//未在协会备案的有限合伙企业份额
            		+" , "+ rept_qu_ivsm_info.getAltnivsm()+ ""				//另类投资
            		+" , "+ rept_qu_ivsm_info.getDebtivsm_beloan()+ ""		//银行委托贷款规模
            		+" , "+ rept_qu_ivsm_info.getDebtivsm_tloan()+ ""			//信托贷款
            		+" , "+ rept_qu_ivsm_info.getDebtivsm_recAcct()+ ""		//应收账款投资
            		+" , "+ rept_qu_ivsm_info.getDebtivsm_benf()+ ""			//各类受（收）益权投资
            		+" , "+ rept_qu_ivsm_info.getDebtivsm_bill()+ ""			//票据（承兑汇票等）投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getDebtivsm_odebtivsm())+ "'"		//其他债权投资
            		+" , "+ rept_qu_ivsm_info.getOverivsm()+ ""				//境外投资
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getOth_ast())+ "'"				//其他资产
            		+" , "+ rept_qu_ivsm_info.getLiab_rebond()+ ""			//债券回购规模
            		+" , "+ rept_qu_ivsm_info.getLiab_fsborw()+ ""			//融资、融券总额
            		+" , "+ rept_qu_ivsm_info.getLiab_fsborw_part_sborw()+ ""	//其中：融券总额
            		+" , "+ rept_qu_ivsm_info.getLiab_bborw()+ ""				//银行借款总额
            		+" , '"+ turnNull2Empty(rept_qu_ivsm_info.getLiab_ofborw())+ "'"			//其他融资规模
            		+" , '"+ turnNull2Empty(rept_qu_ast_fee_info.getFund_Init_coll_parv())+ "'" //基金初始募集面值
            		+ ") " 
    				+ " " ; 
            
            logger.info("INTER_PFYX_1020 产品运行监测报表 sql：\n" + sql);
            stat.execute(sql);   
            con.commit();
            
            //INTER_PFYX_1080 债券投资监测报表  
			 sql =   "delete from INTER_PFYX_1080 "
	              	  + "where STOCK_ID = '"+ fundNum +"' "
	              	  + "and REPORT_TYPE = '"+report_type+"' "
	              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
	            stat.execute(sql);   
	            con.commit();
            
	            sql =  "insert into INTER_PFYX_1080(\r\n"
	            		+" STOCK_ID          ,REPORT_YEAR    ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
	            		+"P1080_0010          ,P1080_0020         ,P1080_0030     ,P1080_0040     ,P1080_0050     ,\r\n"
	            		+"P1080_0060          ,P1080_0070         ,P1080_0080     ,P1080_0081     ,P1080_0090     ,\r\n"
	            		+"P1080_0100          ,P1080_0110         ,P1080_0120     ,P1080_0130     ,P1080_0160     ,\r\n"
	            		+"P1080_0170          ,P1080_0180         ,P1080_0190     \r\n"
	            		+")\r\n"
	            		+"values \r\n"
	              		+"( "
	            		+" '"+fundNum+"'  \r\n"              								// STOCK_ID 
	            		+" , '"+report_year+"'  \r\n"          								// REPORT_YEAR  
	            		+" , '"+report_type+"'  \r\n"          								// REPORT_TYPE  
	            		+" , '"+data_source_name+"' \r\n"      								// DATA_SOURCE_NAME 
	            		+" , to_date('"+mark_date+"' , 'yyyymmdd')  \r\n"            		// REPORT_MARK_DATE 
	            		+" , to_date('"+rept_date+"' , 'yyyymmdd')  \r\n"            		// ANNOUNCEMENT_DATE 
	            		+" , sysdate            \r\n"            // MODIFY_DATE 
	            		
						+" , "+ rept_qu_binsm_info.getBinsm_cost()+ "" 			            		//债券投资规模（成本价值）
						+" , "+ rept_qu_binsm_info.getBinsm_parv()+ "" 									            		//债券投资规模（面值）
						+" , "+ rept_qu_binsm_info.getBinsm_scal()+ "" 									            		//债券投资规模（市值）
						+" , "+ rept_qu_binsm_info.getBinsm_scal_part_credb()+ "" 									        //债券投资规模（市值）:信用债规模
						+" , "+ rept_qu_binsm_info.getBinsm_scal_part_credb_aaa()+ "" 									    //债券投资规模（市值）:信用债规模:AAA信用债规模
						+" , "+ rept_qu_binsm_info.getBinsm_scal_part_credb_aap()+ "" 									    //债券投资规模（市值）:信用债规模:AA+信用债规模
						+" , "+ rept_qu_binsm_info.getBinsm_scal_part_credb_aa()+ "" 									    //债券投资规模（市值）:信用债规模:AA信用债规模
						+" , "+ rept_qu_binsm_info.getBinsm_scal_part_credb_aar()+ "" 									    //债券投资规模（市值）:信用债规模:AA以下（不含）信用债规模
						+" , "+ rept_qu_binsm_info.getBinsm_scal_part_credb_no()+ "" 									    //无评级信用债规模
						+" , "+ rept_qu_binsm_info.getBond_repo()+ "" 									            		//债券回购总额
						+" , "+ rept_qu_binsm_info.getBond_repo_part_plg_repo()+ "" 									    //债券回购总额:债券质押式回购金额
						+" , "+ rept_qu_binsm_info.getBond_repo_part_buyt_repo()+ "" 									    //债券回购总额:债券买断式回购金额
						+" , "+ rept_qu_binsm_info.getBond_revrepo()+ "" 									            	//债券逆回购总额
						+" ,  nvl("+colFormat( rept_qu_binsm_info.getBond_repo_levg_rate() ) +",0)/100 "	 				//产品回购杠杆比率
						+" , "+ rept_qu_brek_risk_bond_info.getHold_brek_bond_num()+ "" 									//持有违约债券只数
						+" , "+ rept_qu_brek_risk_bond_info.getHold_risk_bond_num()+ ""  									//持有风险债券只数
						+" , '"+ turnNull2Empty(rept_qu_brek_risk_bond_info.getBrek_risk_bond_afct())+ "'" 									//违约或风险债券对产品产生的影响
						+" , '"+ turnNull2Empty(rept_qu_brek_risk_bond_info.getBrek_risk_bond_disp())+ "'" 									//违约或风险债券处置进展情况
	            		+ ") " 
	    				+ " " ;     
	   
	            logger.info("INTER_PFYX_1080  持有违约债券信息表 sql：\n" + sql);
	            stat.execute(sql);   
	            con.commit();
	            
	            
	            //INTER_PFYX_1081 
				 sql =   "delete from INTER_PFYX_1081 "
		              	  + "where STOCK_ID = '"+ fundNum +"' "
		              	  + "and REPORT_TYPE = '"+report_type+"' "
		              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
		            stat.execute(sql);   
		            con.commit();
	            
		        for (Rept_qu_brek_bond_info rqbbi: list_rept_qu_brek_bond_info)   {
		            sql =  "insert into INTER_PFYX_1081(\r\n"
		            		+"STOCK_ID          ,REPORT_YEAR    ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
		            		+"P1081_0010          ,P1081_0020         ,P1081_0030     ,P1081_0040     ,P1081_0041     ,\r\n"
		            		+"P1081_0050          ,P1081_0080         ,P1081_0090     ,P1081_0100     ,P1081_0110     ,\r\n"
		            		+"P1081_0120          ,P1081_0130         ,P1081_0140     ,P1081_0150     ,P1081_0160     ,\r\n"
		            		+"P1081_0170          ,P1081_0180         ,P1081_0190	  ,P1081_0200	  ,P1081_0210	  ,\r\n"
		            		+"P1081_0220		  ,P1081_0230		  ,P1081_0240 	  ,P1081_0250	  ,P1081_0260	  ,\r\n"
		            		+"P1081_0270\r\n"
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
		            		+" , "+ rqbbi.getOnum()+ "" 								//序号
		            		+" , '"+ turnNull2Empty(rqbbi.getBrek_bond_name())+ "'" 					//违约债券名称								
							+" , '"+ turnNull2Empty(rqbbi.getBrek_bond_num())+ "'"						//				违约债券编码
							+" , "+ rqbbi.getBrek_bond_mval()+ ""						//				违约债券市值
							+" , '"+ turnNull2Empty(rqbbi.getBrek_bond_valu_basis())+ "'"				//						违约债券估值依据
							+" , "+ rqbbi.getBrek_bond_cost()+ ""						//				违约债券成本
							+" , '"+ turnNull2Empty(rqbbi.getBrek_bond_nginfo_clas())+ "'"				//					违约债券负面情况类别
							+" , to_date('"+rqbbi.getBrek_bond_iss_date()+"' , 'yyyy-mm-dd') \r\n" //				违约债券发行日期
							+" , to_date('"+rqbbi.getBrek_bond_matu_time()+"' , 'yyyy-mm-dd') \r\n" //			违约债券到期时间
							+" , to_date('"+rqbbi.getBond_fst_occu_brek_time()+"' , 'yyyy-mm-dd') \r\n" //		债券首次发生违约时间
							+" , "+ rqbbi.getBrek_bond_parv()+ ""						//				违约债券面值
							+" , "+ rqbbi.getBrek_bond_drepy_prin()+ ""					//						违约债券延期偿还的本金
							+" , "+ rqbbi.getBrek_bond_drepy_intr()+ ""					//						违约债券延期偿还的利息
							+" , '"+ turnNull2Empty(rqbbi.getBrek_bond_clas())+ "'"						//				违约债券类别
							+" , '"+ turnNull2Empty(rqbbi.getBrek_bef_debt_rat())+ "'"					//					违约前债项评级
							+" , '"+ turnNull2Empty(rqbbi.getLast_debt_rat	())+ "'"						//			最新债项评级
							+" , '"+ turnNull2Empty(rqbbi.getBond_guar_situ_expl())+ "'"				//	债券担保情况说明
							+" , '"+ turnNull2Empty(rqbbi.getIs_cbond())+ "'"							//	是否为城投债
							+" , '"+ turnNull2Empty(rqbbi.getBond_issr_name())+ "'"						//	债券发行主体名称
							+" , '"+ turnNull2Empty(rqbbi.getBond_issr_icrn())+ "'"						//	债券发行主体统一社会信用代码
							+" , '"+ turnNull2Empty(rqbbi.getBond_issr_type_1())+ "'"					//	发债企业类型1
							+" , '"+ turnNull2Empty(rqbbi.getBond_issr_type_2())+ "'"					//	发债企业类型2
							+" , '"+ turnNull2Empty(rqbbi.getBond_issr_belt_regi())+ "'"				//	发债企业所属地区
							+" , '"+ turnNull2Empty(rqbbi.getBond_issr_belt_indt())+ "'"				//	发债企业所属行业
							+" , '"+ turnNull2Empty(rqbbi.getBrek_bef_pty_rat())+ "'"					//	违约前主体评级
							+" , '"+ turnNull2Empty(rqbbi.getMemo())+ "'"								//	备注
		            		+ ") " 
		    				+ " " ;     
		   
		            logger.info("INTER_PFYX_1081  持有违约债券信息表 sql：\n" + sql);
		            stat.execute(sql);   
		            con.commit();
		        } 

	            //INTER_PFYX_1082 
				 sql =   "delete from INTER_PFYX_1082 "
		              	  + "where STOCK_ID = '"+ fundNum +"' "
		              	  + "and REPORT_TYPE = '"+report_type+"' "
		              	  + "and REPORT_MARK_DATE = to_date('"+mark_date+"' , 'yyyymmdd') " ; 
		            stat.execute(sql);   
		            con.commit();
	            
		        for (Rept_qu_risk_bond_info rqrbi: list_rept_qu_risk_bond_info)   {
		            sql =  "insert into INTER_PFYX_1082(\r\n"
		            		+"STOCK_ID          ,REPORT_YEAR    ,REPORT_TYPE    ,DATA_SOURCE_NAME,REPORT_MARK_DATE	,ANNOUNCEMENT_DATE  ,MODIFY_DATE,\r\n"
		            		+"P1082_0010          ,P1082_0020         ,P1082_0030     ,P1082_0040     ,P1082_0041     ,\r\n"
		            		+"P1082_0050          ,P1082_0080         ,P1082_0090     ,P1082_0100     ,P1082_0110     ,\r\n"
		            		+"P1082_0120          ,P1082_0130         ,P1082_0140     ,P1082_0150     ,P1082_0160     ,\r\n"
		            		+"P1082_0170          ,P1082_0180         ,P1082_0190	  ,P1082_0200	  ,P1082_0210	  ,\r\n"
		            		+"P1082_0220		  ,P1082_0230		  ,P1082_0240 	  \r\n"
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
		            		+" , "+ rqrbi.getOnum()+ "" 										//序号					P1082_0010
		            		+" , '"+ turnNull2Empty(rqrbi.getRisk_bond_name())+ "'" 							//违约债券名称				P1082_0020		
				            +" , '"+ turnNull2Empty(rqrbi.getRisk_bond_num())+ "'"                           	//风险债券编码                    P1082_0030
				            +" , "+ rqrbi.getRisk_bond_mval()+ ""                           	//风险债券市值                    P1082_0040
				            +" , '"+ turnNull2Empty(rqrbi.getRisk_bond_valu_basis())+ "'"                           //风险债券估值依据                P1082_0041
				            +" , "+ rqrbi.getRisk_bond_cost()+ ""                           	//风险债券成本                    P1082_0050
				            +" , '"+ turnNull2Empty(rqrbi.getRisk_bond_nginfo_clas())+ "'"                           //风险债券负面情况类别            P1082_0080
				            +" , to_date('"+rqrbi.getRisk_bond_iss_date()+"' , 'yyyy-mm-dd')  \r\n"//风险债券发行日期                P1082_0090         
				            +" , to_date('"+rqrbi.getRisk_bond_matu_time()+"' , 'yyyy-mm-dd')  \r\n"//风险债券到期时间                P1082_0100
				            +" , "+ rqrbi.getRisk_bond_parv()+ ""                         		//风险债券面值                    P1082_0110
				            +" , '"+ turnNull2Empty(rqrbi.getRisk_bond_clas())+ "'"                         		//风险债券类别                    P1082_0120
				            +" , '"+ turnNull2Empty(rqrbi.getOccu_risk_bef_debt_rat())+ "'"                           //发生风险前债项评级              P1082_0130
				            +" , '"+ turnNull2Empty(rqrbi.getLast_debt_rat())+ "'"                          		//最新债项评级                    P1082_0140
				            +" , '"+ turnNull2Empty(rqrbi.getBond_guar_situ_expl())+ "'"                    		//债券担保情况说明                P1082_0150
				            +" , '"+ turnNull2Empty(rqrbi.getIs_cbond())+ "'"                           			//是否为城投债                    P1082_0160
				            +" , '"+ turnNull2Empty(rqrbi.getBond_issr_name())+ "'"                           		//债券发行主体名称                P1082_0170
				            +" , '"+ turnNull2Empty(rqrbi.getBond_issr_icrn())+ "'"                           		//债券发行主体统一社会信用代码    	P1082_0180
				            +" , '"+ turnNull2Empty(rqrbi.getBond_issr_type_1())+ "'"                           	//发债企业类型1                   P1082_0190
				            +" , '"+ turnNull2Empty(rqrbi.getBond_issr_type_2())+ "'"                           	//发债企业类型2                   P1082_0200
				            +" , '"+ turnNull2Empty(rqrbi.getBond_issr_belt_regi())+ "'"                           //发债企业所属地区                P1082_0210
				            +" , '"+ turnNull2Empty(rqrbi.getBond_issr_belt_indt())+ "'"                           //发债企业所属行业                P1082_0220
				            +" , '"+ turnNull2Empty(rqrbi.getOccu_bef_issr_risk_rat())+ "'"                           //发生风险前主体评级              P1082_0230
		            		+" , '"+ turnNull2Empty(rqrbi.getMemo())+ "'"                           //备注                            P1082_0240
		            		+ ") " 
		    				+ " " ;     
		   
		            logger.info("INTER_PFYX_1081  持有违约债券信息表 sql：\n" + sql);
		            stat.execute(sql);   
		            con.commit();
		        } 		        
		            	            
	            
	            
//			//result = DaoUtil.getResultToList(con, sql);
//			DaoUtil.insert(con, sql);
//
//			//INTER_PF_1021
//			 sql="insert into xbrl_uat.INTER_PFYX_1030 t1\r\n"
//					+ "	(ID#,STOCK_ID, REPORT_YEAR,REPORT_MARK_DATE, REPORT_TYPE,MODIFY_DATE,P1021_0010,P1021_0020,P1021_0030)\r\n"
//					+ "		values\r\n"
//					+ "	((select max (ID#) from xbrl_uat.INTER_PF_1020 )+1,?, ?, to_date(?,'YYYYMMdd'), 'PB0001', to_date(?,'YYYYMMdd'), to_date('20220119','YYYYMMdd'), ? ,?) "
//					+ " ";
//			
//			sql = SqlCommonUtil.getPreparedSQL(sql, rds.getFund_num(), rds.getDate_no().substring(0, 3), rds.getRept_date(), rds.getRept_date(), rept_qu_brek_risk_bond_info.getBrek_risk_bond_disp(), rept_qu_binsm_info.getBinsm_scal_part_credb_aa()  );
//			result = DaoUtil.getResultToList(con, sql);
////			ps=con.prepareStatement(sql);
////			ps.executeUpdate();
//			con.commit();
		} catch (Exception e) {
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
	
	
	public String turnNull2Empty(Object source) {
		return source==null?"":String.valueOf(source) ;
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
