package com.fh.util.entity.system;

import java.io.Serializable;
import java.util.Date;

/**
 * 员工表
 * @author ywb
 *
 */
public class SysUser implements Serializable{
 
	private static final long serialVersionUID = 1L;
    private String USER_ID;//员工编号
    private String USER_NAME;//员工姓名
    private String PASSWORD;//密码
    
    private String PHONE;//员工手机
    private String TELEPHONE;//座机
    private String EMAIL;//邮箱
    private Date LAST_LOGIN_TIME;
	private Integer LOGIN_FAIL_NUM;
    private String OPERAT_ID;
    private String ISEXP;
    private String STATUS;
    
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}
	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}
	public void setTELEPHONE(String tELEPHONE) {
		TELEPHONE = tELEPHONE;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public void setLAST_LOGIN_TIME(Date lAST_LOGIN_TIME) {
		LAST_LOGIN_TIME = lAST_LOGIN_TIME;
	}
	public void setLOGIN_FAIL_NUM(Integer lOGIN_FAIL_NUM) {
		LOGIN_FAIL_NUM = lOGIN_FAIL_NUM;
	}
	public void setOPERAT_ID(String oPERAT_ID) {
		OPERAT_ID = oPERAT_ID;
	}
	public void setISEXP(String iSEXP) {
		ISEXP = iSEXP;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public String getPASSWORD() {
		return PASSWORD;
	}
	public String getPHONE() {
		return PHONE;
	}
	public String getTELEPHONE() {
		return TELEPHONE;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public Date getLAST_LOGIN_TIME() {
		return LAST_LOGIN_TIME;
	}
	public Integer getLOGIN_FAIL_NUM() {
		return LOGIN_FAIL_NUM;
	}
	public String getOPERAT_ID() {
		return OPERAT_ID;
	}
	public String getISEXP() {
		return ISEXP;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	public String getSTATUS() {
		return STATUS;
	}
	
}
