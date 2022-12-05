package com.swhy.xxpl.model.jibao;

import java.io.*;
import java.sql.Clob;
import java.sql.SQLException;

/**
 * 管理人报告(季报)
 * 
 * @author 230355
 *
 */
public class Rept_Q_magr_rept {

	public String fund_code; // 基金编号（综合管理平台）
	public String info_src_code; // 信息来源代码
	public String qut_no; // 季度编号
	public String c_pord_code; // 账套号（外包）
	public Object magr_rept; // 管理人报告
	public String is_cstd_chk; // 信息披露报告是否经托管机构复核

	public Rept_Q_magr_rept() {
		// TODO Auto-generated constructor stub
	}

	public void dealWithMagr_Rept() throws SQLException, IOException {
		String temp = this.ClobToString((Clob) magr_rept);
		this.setMagr_rept(temp);
	}
	

	public  String ClobToString(Clob clob) throws SQLException, IOException {
 
		String reString = "";
		Reader is = clob.getCharacterStream();// 得到流
		BufferedReader br = new BufferedReader(is);
		String s = br.readLine();
		StringBuffer sb = new StringBuffer();
		while (s != null) {// 执行循环将字符串全部取出付值给StringBuffer由StringBuffer转成STRING
			sb.append(s + "\n");
			s = br.readLine();
		}
		reString = sb.toString();
		return reString;
	}
	
	/* Getters and Setters */
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

	public Object getMagr_rept() {
		return magr_rept;
	}

	public void setMagr_rept(Object magr_rept) {
		this.magr_rept = magr_rept;
	}

	public String getIs_cstd_chk() {
		return is_cstd_chk;
	}

	public void setIs_cstd_chk(String is_cstd_chk) {
		this.is_cstd_chk = is_cstd_chk;
	}
	
	

}
