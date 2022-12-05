package com.fh.util.entity.system;

import java.io.Serializable;
import java.util.Date;

/**
 * 员工表
 * @author ywb
 *
 */
public class Employee implements Serializable{
 
	private static final long serialVersionUID = 1L;
    private Integer EMP_ID;//员工编号
    private String EMP_REAL_NAME;//员工姓名
    private String EMP_NAME;//员工用户名
    private String PASSWORD;//密码
    private String EMP_MANA_ID;//所属机构
    
    private String PHONE;//员工手机
    private String TELEPHONE;//座机
    private String EMAIL;//邮箱
    private String  RIGHTS_TYPE;//权限类型
    private Date RIGHTS_BEGIN_DATE;//权限有效期起
    private Date RIGHTS_END_DATE;//权限有效期至
    
    private String  PRO_RIGHTS_TYPE;//产品权限类型
    private Date PRO_BEGIN_DATE;//产品权限有效期起
    private Date PRO_END_DATE;//产品权限有效期至
    
    
	private Date   CREATE_DATE;//创建日期
	private Date   UPDATE_DATE;//创建日期
	private String EMP_STATUS;//员工状态
	private String STATUS;
    private Integer LOGIN_NUM;
    private Date LAST_LOGIN_TIME;
    private String SEX;
	private Integer OPER_ID;
	private Operator operator;//所属操作员
	
	private Integer FM_ID;
    private String FM_NAME;
    private String CHECK_STATUS;//管理人审核状态
    private String ACTIVE_STATUS;//员工是否激活密码 01-激活 02-未激活
    private String ONLINE_CLIENT;//登录账户客户端标识
    private Date LAST_ONLINE_TIME;//最新在线时间
    public Integer getEMP_ID() {
		return EMP_ID;
	}

 
 

	public String getCHECK_STATUS() {
		return CHECK_STATUS;
	}




	public void setCHECK_STATUS(String cHECK_STATUS) {
		CHECK_STATUS = cHECK_STATUS;
	}




	public void setEMP_ID(Integer eMP_ID) {
		EMP_ID = eMP_ID;
	}
 

	public String getEMP_REAL_NAME() {
		return EMP_REAL_NAME;
	}

	public void setEMP_REAL_NAME(String eMP_REAL_NAME) {
		EMP_REAL_NAME = eMP_REAL_NAME;
	}

	public String getEMP_NAME() {
		return EMP_NAME;
	}

	public void setEMP_NAME(String eMP_NAME) {
		EMP_NAME = eMP_NAME;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}
 
	public String getEMP_MANA_ID() {
		return EMP_MANA_ID;
	}

	public void setEMP_MANA_ID(String eMP_MANA_ID) {
		EMP_MANA_ID = eMP_MANA_ID;
	}

	public Integer getOPER_ID() {
		return OPER_ID;
	}

	public void setOPER_ID(Integer oPER_ID) {
		OPER_ID = oPER_ID;
	}

	public String getPHONE() {
		return PHONE;
	}

	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}

	public String getTELEPHONE() {
		return TELEPHONE;
	}

	public void setTELEPHONE(String tELEPHONE) {
		TELEPHONE = tELEPHONE;
	}

	public String getEMAIL() {
		return EMAIL;
	}

	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}

	public String getRIGHTS_TYPE() {
		return RIGHTS_TYPE;
	}

	public void setRIGHTS_TYPE(String rIGHTS_TYPE) {
		RIGHTS_TYPE = rIGHTS_TYPE;
	}
	 
 
	 

	public Date getRIGHTS_BEGIN_DATE() {
		return RIGHTS_BEGIN_DATE;
	}

	public void setRIGHTS_BEGIN_DATE(Date rIGHTS_BEGIN_DATE) {
		RIGHTS_BEGIN_DATE = rIGHTS_BEGIN_DATE;
	}

	public Date getRIGHTS_END_DATE() {
		return RIGHTS_END_DATE;
	}

	public void setRIGHTS_END_DATE(Date rIGHTS_END_DATE) {
		RIGHTS_END_DATE = rIGHTS_END_DATE;
	}

	public Date getCREATE_DATE() {
		return CREATE_DATE;
	}

	public void setCREATE_DATE(Date cREATE_DATE) {
		CREATE_DATE = cREATE_DATE;
	}

	public Date getUPDATE_DATE() {
		return UPDATE_DATE;
	}

	public void setUPDATE_DATE(Date uPDATE_DATE) {
		UPDATE_DATE = uPDATE_DATE;
	}

	public String getEMP_STATUS() {
		return EMP_STATUS;
	}

	public void setEMP_STATUS(String eMP_STATUS) {
		EMP_STATUS = eMP_STATUS;
	}

	public String getSTATUS() {
		return STATUS;
	}

	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public Integer getFM_ID() {
		return FM_ID;
	}

	public void setFM_ID(Integer fM_ID) {
		FM_ID = fM_ID;
	}

	public String getPRO_RIGHTS_TYPE() {
		return PRO_RIGHTS_TYPE;
	}

	public void setPRO_RIGHTS_TYPE(String pRO_RIGHTS_TYPE) {
		PRO_RIGHTS_TYPE = pRO_RIGHTS_TYPE;
	}

	public Date getPRO_BEGIN_DATE() {
		return PRO_BEGIN_DATE;
	}

	public void setPRO_BEGIN_DATE(Date pRO_BEGIN_DATE) {
		PRO_BEGIN_DATE = pRO_BEGIN_DATE;
	}

	public Date getPRO_END_DATE() {
		return PRO_END_DATE;
	}

	public void setPRO_END_DATE(Date pRO_END_DATE) {
		PRO_END_DATE = pRO_END_DATE;
	}

	public String getFM_NAME() {
		return FM_NAME;
	}

	public void setFM_NAME(String fM_NAME) {
		FM_NAME = fM_NAME;
	}

	public Integer getLOGIN_NUM() {
		return LOGIN_NUM;
	}

	public void setLOGIN_NUM(Integer lOGIN_NUM) {
		LOGIN_NUM = lOGIN_NUM;
	}

	public Date getLAST_LOGIN_TIME() {
		return LAST_LOGIN_TIME;
	}

	public void setLAST_LOGIN_TIME(Date lAST_LOGIN_TIME) {
		LAST_LOGIN_TIME = lAST_LOGIN_TIME;
	}

	public String getSEX() {
		return SEX;
	}

	public void setSEX(String sEX) {
		SEX = sEX;
	}

	public String getACTIVE_STATUS() {
		return ACTIVE_STATUS;
	}
	public void setACTIVE_STATUS(String aCTIVE_STATUS) {
		ACTIVE_STATUS = aCTIVE_STATUS;
	}
	public String getONLINE_CLIENT() {
		return ONLINE_CLIENT;
	}
	public void setONLINE_CLIENT(String oNLINE_CLIENT) {
		ONLINE_CLIENT = oNLINE_CLIENT;
	}




	public Date getLAST_ONLINE_TIME() {
		return LAST_ONLINE_TIME;
	}




	public void setLAST_ONLINE_TIME(Date lAST_ONLINE_TIME) {
		LAST_ONLINE_TIME = lAST_ONLINE_TIME;
	}




	 
}
