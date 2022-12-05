-------------------------------------------
-- Export file for user GUZHI            --
-- Created by swhy on 2017/4/9, 17:48:14 --
-------------------------------------------

spool 222.log

prompt
prompt Creating table A001JJHZGZB
prompt ==========================
prompt
create table GUZHI.A001JJHZGZB
(
  FDATE     DATE default TO_DATE('1900-01-01','YYYY-MM-DD') not null,
  FKMBM     VARCHAR2(100) default ' ' not null,
  FKMMC     VARCHAR2(100) default ' ' not null,
  FHQJG     NUMBER(28,10) default 0 not null,
  FHQBZ     CHAR(1) default ' ' not null,
  FZQSL     NUMBER(19,2) default 0 not null,
  FZQCB     NUMBER(18,4) default 0 not null,
  FZQSZ     NUMBER(18,4) default 0 not null,
  FGZ_ZZ    NUMBER(18,4) default 0 not null,
  FCB_JZ_BL VARCHAR2(20) default ' ' not null,
  FSZ_JZ_BL VARCHAR2(20) default ' ' not null,
  FTPXX     VARCHAR2(60) default ' ' not null,
  FQYXX     VARCHAR2(60) default ' ' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A002JJHZGZB
prompt ==========================
prompt
create table GUZHI.A002JJHZGZB
(
  FDATE     DATE not null,
  FKMBM     VARCHAR2(100) not null,
  FKMMC     VARCHAR2(100) not null,
  FHQJG     NUMBER(28,10) not null,
  FHQBZ     CHAR(1) not null,
  FZQSL     NUMBER(19,2) not null,
  FZQCB     NUMBER(18,4) not null,
  FZQSZ     NUMBER(18,4) not null,
  FGZ_ZZ    NUMBER(18,4) not null,
  FCB_JZ_BL VARCHAR2(20) not null,
  FSZ_JZ_BL VARCHAR2(20) not null,
  FTPXX     VARCHAR2(60) not null,
  FQYXX     VARCHAR2(60) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A003JJHZGZB
prompt ==========================
prompt
create table GUZHI.A003JJHZGZB
(
  FDATE     DATE not null,
  FKMBM     VARCHAR2(100) not null,
  FKMMC     VARCHAR2(100) not null,
  FHQJG     NUMBER(28,10) not null,
  FHQBZ     CHAR(1) not null,
  FZQSL     NUMBER(19,2) not null,
  FZQCB     NUMBER(18,4) not null,
  FZQSZ     NUMBER(18,4) not null,
  FGZ_ZZ    NUMBER(18,4) not null,
  FCB_JZ_BL VARCHAR2(20) not null,
  FSZ_JZ_BL VARCHAR2(20) not null,
  FTPXX     VARCHAR2(60) not null,
  FQYXX     VARCHAR2(60) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A004JJHZGZB
prompt ==========================
prompt
create table GUZHI.A004JJHZGZB
(
  FDATE     DATE not null,
  FKMBM     VARCHAR2(100) not null,
  FKMMC     VARCHAR2(100) not null,
  FHQJG     NUMBER(28,10) not null,
  FHQBZ     CHAR(1) not null,
  FZQSL     NUMBER(19,2) not null,
  FZQCB     NUMBER(18,4) not null,
  FZQSZ     NUMBER(18,4) not null,
  FGZ_ZZ    NUMBER(18,4) not null,
  FCB_JZ_BL VARCHAR2(20) not null,
  FSZ_JZ_BL VARCHAR2(20) not null,
  FTPXX     VARCHAR2(60) not null,
  FQYXX     VARCHAR2(60) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A139JJHZGZB
prompt ==========================
prompt
create table GUZHI.A139JJHZGZB
(
  FDATE     DATE default TO_DATE('1900-01-01','YYYY-MM-DD') not null,
  FKMBM     VARCHAR2(100) default ' ' not null,
  FKMMC     VARCHAR2(100) default ' ' not null,
  FHQJG     NUMBER(28,10) default 0 not null,
  FHQBZ     CHAR(1) default ' ' not null,
  FZQSL     NUMBER(19,2) default 0 not null,
  FZQCB     NUMBER(18,4) default 0 not null,
  FZQSZ     NUMBER(18,4) default 0 not null,
  FGZ_ZZ    NUMBER(18,4) default 0 not null,
  FCB_JZ_BL VARCHAR2(20) default ' ' not null,
  FSZ_JZ_BL VARCHAR2(20) default ' ' not null,
  FTPXX     VARCHAR2(60) default ' ' not null,
  FQYXX     VARCHAR2(60) default ' ' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A2016001LACCOUNT
prompt ===============================
prompt
create table GUZHI.A2016001LACCOUNT
(
  FACCTCODE   VARCHAR2(50) default ' ' not null,
  FACCTNAME   VARCHAR2(200) default ' ' not null,
  FACCTLEVEL  NUMBER(3) default 0 not null,
  FACCTPARENT VARCHAR2(50) default ' ' not null,
  FACCTDETAIL NUMBER(3) default 0 not null,
  FACCTCLASS  VARCHAR2(50) default ' ' not null,
  FACCTATTR   VARCHAR2(100) default ' ' not null,
  FACCTATTRID VARCHAR2(20) default ' ' not null,
  FCURCODE    VARCHAR2(3) default ' ' not null,
  FBALDC      NUMBER(5) default 0 not null,
  FAMOUNT     NUMBER(3) default 0 not null,
  FCARRYACC   NUMBER(3) default 0 not null,
  FENAME      VARCHAR2(50) default ' ' not null,
  FBY         VARCHAR2(30) default ' ' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A2016001LBALANCE
prompt ===============================
prompt
create table GUZHI.A2016001LBALANCE
(
  FMONTH      NUMBER(3) default 0 not null,
  FACCTCODE   VARCHAR2(50) default ' ' not null,
  FCURCODE    VARCHAR2(3) default ' ' not null,
  FSTARTBAL   NUMBER(19,4) default 0 not null,
  FDEBIT      NUMBER(19,4) default 0 not null,
  FCREDIT     NUMBER(19,4) default 0 not null,
  FACCDEBIT   NUMBER(19,4) default 0 not null,
  FACCCREDIT  NUMBER(19,4) default 0 not null,
  FENDBAL     NUMBER(19,4) default 0 not null,
  FBSTARTBAL  NUMBER(19,4) default 0 not null,
  FBDEBIT     NUMBER(19,4) default 0 not null,
  FBCREDIT    NUMBER(19,4) default 0 not null,
  FBACCDEBIT  NUMBER(19,4) default 0 not null,
  FBACCCREDIT NUMBER(19,4) default 0 not null,
  FBENDBAL    NUMBER(19,4) default 0 not null,
  FASTARTBAL  NUMBER(19,4) default 0 not null,
  FADEBIT     NUMBER(19,4) default 0 not null,
  FACREDIT    NUMBER(19,4) default 0 not null,
  FAACCDEBIT  NUMBER(19,4) default 0 not null,
  FAACCCREDIT NUMBER(19,4) default 0 not null,
  FAENDBAL    NUMBER(19,4) default 0 not null,
  FISDETAIL   NUMBER(3) default 0 not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AAAA
prompt ===================
prompt
create table GUZHI.AAAA
(
  NAME VARCHAR2(20),
  SEX  VARCHAR2(50),
  AGE  VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACCOUNTMAPPING
prompt =============================
prompt
create table GUZHI.ACCOUNTMAPPING
(
  ID       NUMBER not null,
  RZRQ_GTH VARCHAR2(50),
  GTH      NUMBER,
  TEMP     VARCHAR2(10),
  WB_ZTH   VARCHAR2(50),
  TG_ZTH   VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table A_TMAPPING
prompt =========================
prompt
create table GUZHI.A_TMAPPING
(
  ID       NUMBER not null,
  PROVINCE VARCHAR2(10),
  CITY     VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BANKBALANCE
prompt ==========================
prompt
create table GUZHI.BANKBALANCE
(
  OPENBANK      VARCHAR2(50),
  ACCOUNTNAME   VARCHAR2(50),
  ACCOUNTID     VARCHAR2(100) not null,
  CURRENCY      VARCHAR2(20),
  BALANCE       NUMBER(18,2),
  COLDAMOUNT    NUMBER(18,2),
  AVABALANCE    NUMBER(18,2),
  TODAYIN       NUMBER(18,2),
  TODAYOUT      NUMBER(18,2),
  ACCOUNTSTATUS VARCHAR2(20),
  DATADATE      VARCHAR2(10) not null,
  IMPORTDATE    DATE,
  BANKTYPE      NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 320K
    minextents 1
    maxextents unlimited
  );
comment on column GUZHI.BANKBALANCE.OPENBANK
  is '开户行';
comment on column GUZHI.BANKBALANCE.ACCOUNTNAME
  is '账户名称';
comment on column GUZHI.BANKBALANCE.ACCOUNTID
  is '银行账号';
comment on column GUZHI.BANKBALANCE.CURRENCY
  is '货币';
comment on column GUZHI.BANKBALANCE.BALANCE
  is '余额';
comment on column GUZHI.BANKBALANCE.COLDAMOUNT
  is '冻结金额';
comment on column GUZHI.BANKBALANCE.AVABALANCE
  is '可用余额';
comment on column GUZHI.BANKBALANCE.TODAYIN
  is '今日存入';
comment on column GUZHI.BANKBALANCE.TODAYOUT
  is '今日转出';
comment on column GUZHI.BANKBALANCE.ACCOUNTSTATUS
  is '账户状态';
comment on column GUZHI.BANKBALANCE.DATADATE
  is '日期';
comment on column GUZHI.BANKBALANCE.IMPORTDATE
  is '导入时间';
comment on column GUZHI.BANKBALANCE.BANKTYPE
  is '银行类型';
alter table GUZHI.BANKBALANCE
  add constraint PK_BANKBALANCE_ID primary key (ACCOUNTID, DATADATE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CODEMANAGE
prompt =========================
prompt
create table GUZHI.CODEMANAGE
(
  ID        NUMBER,
  DATATYPE  VARCHAR2(20),
  DATACODE  VARCHAR2(20),
  DATAVALUE VARCHAR2(20),
  TEMP      VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GRADES
prompt =====================
prompt
create table GUZHI.GRADES
(
  GRADES_ID   NUMBER(3) not null,
  GRADES_NAME VARCHAR2(8) not null,
  LOW_SCORE   NUMBER(4,1),
  HIGH_SCORE  NUMBER(4,1),
  GRADE       VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table GUZHI.GRADES
  add constraint GRADES_ID_PK primary key (GRADES_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GUZHIUSERINFO
prompt ============================
prompt
create table GUZHI.GUZHIUSERINFO
(
  ID        NUMBER,
  USERID    VARCHAR2(50),
  USERNAME  VARCHAR2(10),
  IP        VARCHAR2(100),
  PHONE     VARCHAR2(20),
  EMAIL     VARCHAR2(50),
  TEMP      VARCHAR2(20),
  STARTDATE VARCHAR2(10),
  ENDDATE   VARCHAR2(10),
  GROUPTYPE VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GWD_STUDENT
prompt ==========================
prompt
create table GUZHI.GWD_STUDENT
(
  ID     NUMBER not null,
  NAME   VARCHAR2(10),
  AGE    NUMBER,
  SEX    VARCHAR2(10),
  MOBILE VARCHAR2(50),
  ZTH    VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GWD_TEST
prompt =======================
prompt
create table GUZHI.GWD_TEST
(
  GWD_ID   NUMBER(3) not null,
  GWD_NAME VARCHAR2(8) not null,
  ADDRESS  VARCHAR2(40)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table GUZHI.GWD_TEST
  add constraint GWD_ID_PK primary key (GWD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GZB_KMMAPPING
prompt ============================
prompt
create table GUZHI.GZB_KMMAPPING
(
  ID                NUMBER,
  ACCOUNTMAPPING_ID NUMBER,
  TG_KMH            VARCHAR2(100),
  WB_KMH            VARCHAR2(100),
  KMMC              VARCHAR2(100),
  KMCJ              NUMBER,
  TEMP              VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    minextents 1
    maxextents unlimited
  );
comment on column GUZHI.GZB_KMMAPPING.ACCOUNTMAPPING_ID
  is '账套对应表ID';
comment on column GUZHI.GZB_KMMAPPING.TG_KMH
  is '托管科目号';
comment on column GUZHI.GZB_KMMAPPING.WB_KMH
  is '外包科目号';
comment on column GUZHI.GZB_KMMAPPING.KMMC
  is '科目名称';
comment on column GUZHI.GZB_KMMAPPING.KMCJ
  is '科目层级';

prompt
prompt Creating table HEDUIHISTORY
prompt ===========================
prompt
create table GUZHI.HEDUIHISTORY
(
  DATE_YW         VARCHAR2(20),
  DATE_C          VARCHAR2(20),
  WB_ZHANGTAONAME VARCHAR2(50),
  KMDM            VARCHAR2(50),
  WB_KMH          VARCHAR2(100),
  TG_KMH          VARCHAR2(100),
  WB_CB           VARCHAR2(50),
  TG_CB           VARCHAR2(50),
  CB_CHA          VARCHAR2(50),
  WB_SZ           VARCHAR2(50),
  TG_SZ           VARCHAR2(50),
  SZ_CHA          VARCHAR2(50),
  TEMP            VARCHAR2(100),
  ID              NUMBER not null,
  WB_ZTH          VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 512K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG
prompt =======================
prompt
create table GUZHI.INT_D_CG
(
  CONTR_SEQ_NUM    VARCHAR2(20),
  SER_NUM          VARCHAR2(12),
  OCCUR_DT         DATE,
  OCCUR_TIME       TIMESTAMP(6),
  CAP_ARRV_DT      DATE,
  ASSET_ACCT       VARCHAR2(19),
  ACCT_NAME        VARCHAR2(200),
  ACCT_MANG_ORG_ID VARCHAR2(80),
  BIZ_CD           VARCHAR2(10),
  CURR_CD          CHAR(4),
  OCCUR_AMT        NUMBER(26,2),
  CAP_BAL          NUMBER(26,2),
  OCCUR_ORG_ID     VARCHAR2(80),
  OPER_MEMO        VARCHAR2(2000),
  BELONG_ORG_ID    VARCHAR2(80)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_FUND_ACCT
prompt =================================
prompt
create table GUZHI.INT_D_CG_FUND_ACCT
(
  ID         VARCHAR2(20),
  ASSET_ACCT VARCHAR2(50),
  FUND_ACCT  VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_PRIVATE_CAPTL_BAL
prompt =========================================
prompt
create table GUZHI.INT_D_CG_PRIVATE_CAPTL_BAL
(
  NAME      VARCHAR2(80),
  CAPTL_BAL NUMBER(21,4),
  FLAG      VARCHAR2(10),
  BIZ_DT    DATE,
  CUST_NO   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_PRIVATE_CPT_STOCK_CHG
prompt =============================================
prompt
create table GUZHI.INT_D_CG_PRIVATE_CPT_STOCK_CHG
(
  OCCUR_DATE     VARCHAR2(8),
  CURRENCY_TYPE  VARCHAR2(2),
  SEC_TYPE       VARCHAR2(2),
  BUSINESS_CODE  VARCHAR2(4),
  BUSINESS_NAME  VARCHAR2(30),
  SEC_CHG        INTEGER,
  SEC_BAL        INTEGER,
  FUND_CHG       NUMBER(19,4),
  FUND_BAL       NUMBER(19,4),
  DONE_AMT       NUMBER(19,4),
  FLAG           VARCHAR2(10),
  BRANCH_NAME    VARCHAR2(80),
  CURRENCY_NAME  VARCHAR2(10),
  SEC_TYPT_DESC  VARCHAR2(30),
  BIZ_DT         DATE,
  CUST_NO        VARCHAR2(20),
  OCCUR_TIME     VARCHAR2(30),
  SERIAL_NO      VARCHAR2(30),
  BRANCH_CODE_1  VARCHAR2(10),
  CUST_NAME      VARCHAR2(80),
  HOLDER_ACC_NO  VARCHAR2(30),
  SEC_CODE       VARCHAR2(10),
  SEC_SHORT_NAME VARCHAR2(200)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_PRIVATE_CPT_STOCK_CH_
prompt =============================================
prompt
create table GUZHI.INT_D_CG_PRIVATE_CPT_STOCK_CH_
(
  OCCUR_DATE     VARCHAR2(8),
  CURRENCY_TYPE  VARCHAR2(2),
  SEC_TYPE       VARCHAR2(2),
  BUSINESS_CODE  VARCHAR2(4),
  BUSINESS_NAME  VARCHAR2(30),
  SEC_CHG        INTEGER,
  SEC_BAL        INTEGER,
  FUND_CHG       NUMBER(19,4),
  FUND_BAL       NUMBER(19,4),
  DONE_AMT       NUMBER(19,4),
  FLAG           VARCHAR2(10),
  BRANCH_NAME    VARCHAR2(80),
  CURRENCY_NAME  VARCHAR2(10),
  SEC_TYPT_DESC  VARCHAR2(30),
  BIZ_DT         DATE,
  CUST_NO        VARCHAR2(20),
  OCCUR_TIME     VARCHAR2(30),
  SERIAL_NO      VARCHAR2(30),
  BRANCH_CODE_1  VARCHAR2(10),
  CUST_NAME      VARCHAR2(80),
  HOLDER_ACC_NO  VARCHAR2(30),
  SEC_CODE       VARCHAR2(10),
  SEC_SHORT_NAME VARCHAR2(200)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_PRIVATE_FD_CPT_DETAIL
prompt =============================================
prompt
create table GUZHI.INT_D_CG_PRIVATE_FD_CPT_DETAIL
(
  CONTR_SEQ_NUM VARCHAR2(20),
  OCCUR_DT      DATE,
  OCCUR_AMT     VARCHAR2(40),
  SER_NUM       VARCHAR2(40),
  ASSET_ACCT    VARCHAR2(40),
  BIZ_CD        VARCHAR2(40),
  OPER_MEMO     VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_PRIVATE_OFS_FUND_POS
prompt ============================================
prompt
create table GUZHI.INT_D_CG_PRIVATE_OFS_FUND_POS
(
  BIZ_DATE     DATE,
  ASSET_ACCT   VARCHAR2(400),
  BIZ_DATE_CHN VARCHAR2(400),
  FUND_SHARES  VARCHAR2(400)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INT_D_CG_PRIVATE_POS_DETAIL
prompt ==========================================
prompt
create table GUZHI.INT_D_CG_PRIVATE_POS_DETAIL
(
  NAME           VARCHAR2(80),
  MARKET_CODE    CHAR(1),
  POS_QUTTY      NUMBER(21),
  SEC_PRICE      NUMBER(21,4),
  MKT_VALUE      NUMBER(21,4),
  FLAG           VARCHAR2(10),
  BIZ_DT         DATE,
  CUST_NO        VARCHAR2(20),
  MARKET_NAME    VARCHAR2(20),
  SEC_CODE       VARCHAR2(10),
  SEC_SHORT_NAME VARCHAR2(200)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IS_PLATEINFO
prompt ===========================
prompt
create table GUZHI.IS_PLATEINFO
(
  C_PLATE_CODE   VARCHAR2(30) not null,
  C_PLATE_NAME   VARCHAR2(100) not null,
  C_PLATE_CODE_P VARCHAR2(20) not null,
  C_DESC         VARCHAR2(200),
  C_TIMESTAMP    VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IS_PLATEINFO_20161107
prompt ====================================
prompt
create table GUZHI.IS_PLATEINFO_20161107
(
  C_PLATE_CODE   VARCHAR2(30) not null,
  C_PLATE_NAME   VARCHAR2(100) not null,
  C_PLATE_CODE_P VARCHAR2(20) not null,
  C_DESC         VARCHAR2(200),
  C_TIMESTAMP    VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IS_SECPLATE
prompt ==========================
prompt
create table GUZHI.IS_SECPLATE
(
  C_SEC_CODE    VARCHAR2(50) not null,
  N_CAPITAL     NUMBER,
  N_CIR_CAPITAL NUMBER,
  C_PLATE_CODE  VARCHAR2(20) not null,
  D_BEGIN       DATE not null,
  D_END         DATE not null,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table IS_SECPLATE_20161107
prompt ===================================
prompt
create table GUZHI.IS_SECPLATE_20161107
(
  C_SEC_CODE    VARCHAR2(50) not null,
  N_CAPITAL     NUMBER,
  N_CIR_CAPITAL NUMBER,
  C_PLATE_CODE  VARCHAR2(20) not null,
  D_BEGIN       DATE not null,
  D_END         DATE not null,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JHDX_ACCOUNTSET
prompt ==============================
prompt
create table GUZHI.JHDX_ACCOUNTSET
(
  ID           INTEGER not null,
  ACCOUNT_ID   VARCHAR2(100),
  TOP_CLASSIFY VARCHAR2(10),
  SUB_CLASSIFY VARCHAR2(10),
  STATUS       VARCHAR2(10),
  BANK         VARCHAR2(10),
  USER_ID      INTEGER,
  DB           VARCHAR2(20),
  VERSION      VARCHAR2(20) default 2
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column GUZHI.JHDX_ACCOUNTSET.DB
  is '1--->4.5 2--->2.5的第一个库 3-->2.5的第2个库';
comment on column GUZHI.JHDX_ACCOUNTSET.VERSION
  is '资管系统版本，1-->2.5；2-->4.5';
alter table GUZHI.JHDX_ACCOUNTSET
  add constraint PK_JHDX_ACCOUNTSET primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JHDX_CON_CONFIG
prompt ==============================
prompt
create table GUZHI.JHDX_CON_CONFIG
(
  ID   INTEGER not null,
  TYPE VARCHAR2(10),
  CODE VARCHAR2(200),
  ZTMC VARCHAR2(100),
  DB   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table GUZHI.JHDX_CON_CONFIG
  add constraint PK_JHDX_CON_CONFIG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JHDX_GTH_CONFIG
prompt ==============================
prompt
create table GUZHI.JHDX_GTH_CONFIG
(
  ID          NUMBER not null,
  C_TZH_25    VARCHAR2(50),
  C_TZH_45    VARCHAR2(50) not null,
  C_CP_NAME   VARCHAR2(100) not null,
  C_TRADE_JG  VARCHAR2(50),
  GT_ZJ_ZH    NUMBER(18),
  C_VERSION   VARCHAR2(20),
  GT_ZJ_ZH_LX NUMBER,
  RZRQ_GTH    VARCHAR2(18)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JHDX_GTH_CONFIG_20161225
prompt =======================================
prompt
create table GUZHI.JHDX_GTH_CONFIG_20161225
(
  ID          NUMBER not null,
  C_TZH_25    VARCHAR2(50),
  C_TZH_45    VARCHAR2(50) not null,
  C_CP_NAME   VARCHAR2(100) not null,
  C_TRADE_JG  VARCHAR2(50),
  GT_ZJ_ZH    NUMBER(18),
  C_VERSION   VARCHAR2(20),
  GT_ZJ_ZH_LX NUMBER,
  RZRQ_GTH    VARCHAR2(18)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JHDX_GTH_CONFIG_20161230
prompt =======================================
prompt
create table GUZHI.JHDX_GTH_CONFIG_20161230
(
  ID          NUMBER not null,
  C_TZH_25    VARCHAR2(50),
  C_TZH_45    VARCHAR2(50) not null,
  C_CP_NAME   VARCHAR2(100) not null,
  C_TRADE_JG  VARCHAR2(50),
  GT_ZJ_ZH    NUMBER(18),
  C_VERSION   VARCHAR2(20),
  GT_ZJ_ZH_LX NUMBER,
  RZRQ_GTH    VARCHAR2(18)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table JHDX_REMARKS
prompt ===========================
prompt
create table GUZHI.JHDX_REMARKS
(
  ID         NUMBER(6) not null,
  ACCOUNT_ID VARCHAR2(20),
  BZRQ       VARCHAR2(20),
  UPDATETIME VARCHAR2(20),
  REMARK     VARCHAR2(1000),
  UPDATEBY   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column GUZHI.JHDX_REMARKS.ID
  is 'id';
comment on column GUZHI.JHDX_REMARKS.ACCOUNT_ID
  is '账套号';
comment on column GUZHI.JHDX_REMARKS.BZRQ
  is '备注日期';
comment on column GUZHI.JHDX_REMARKS.UPDATETIME
  is '更新时间';
comment on column GUZHI.JHDX_REMARKS.REMARK
  is '备注';
comment on column GUZHI.JHDX_REMARKS.UPDATEBY
  is '更新人/IP';

prompt
prompt Creating table JHDX_TA_GUZHI_COMPARE
prompt ====================================
prompt
create table GUZHI.JHDX_TA_GUZHI_COMPARE
(
  TACODE     VARCHAR2(20) not null,
  FUNDNAME   VARCHAR2(100),
  FUNDSTATUS VARCHAR2(20),
  ENDDATE    VARCHAR2(20),
  ZTH        VARCHAR2(20),
  TA_FE      NUMBER(18,2),
  WB_FE      NUMBER(18,2),
  TA_JZ      NUMBER(18,4),
  WB_JZ      NUMBER(18,4),
  TA_ZRJZ    NUMBER(18,4),
  WB_ZRJZ    NUMBER(18,4),
  TA_LJJZ    NUMBER(18,4),
  WB_LJJZ    NUMBER(18,4),
  JZDATE     VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LSETLIST
prompt =======================
prompt
create table GUZHI.LSETLIST
(
  FYEAR       NUMBER(5) not null,
  FSETID      VARCHAR2(50) not null,
  FSETCODE    NUMBER(5) not null,
  FSETNAME    VARCHAR2(255) not null,
  FMANAGER    VARCHAR2(50) not null,
  FSTARTYEAR  NUMBER(5) not null,
  FSTARTMONTH NUMBER(3) not null,
  FMONTH      NUMBER(3) not null,
  FACCLEN     VARCHAR2(50) not null,
  FSTARTED    NUMBER(3) not null,
  FDJJBZ      NUMBER(3) not null,
  FPSETCODE   NUMBER(3) default 0 not null,
  FCSETLEVEL  NUMBER(3) default 1 not null,
  FTSETCODE   NUMBER(3) default 0 not null,
  FENDDATE    DATE default to_date('1900-01-01','yyyy-MM-dd') not null,
  FJJLX       NUMBER(3) default 0,
  FJJZL       NUMBER(3) default 0,
  FJJLB       NUMBER(3) default 0,
  FGLRJC      VARCHAR2(100),
  FTGRJC      VARCHAR2(100),
  FTAMS       VARCHAR2(5),
  FJJJC       VARCHAR2(255) default 'FSETNAME' not null,
  FQY         NUMBER(2) default 0 not null,
  FTYBZ       VARCHAR2(6) default ' ' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PRODUCT_NAME
prompt ===========================
prompt
create table GUZHI.PRODUCT_NAME
(
  LEIBIE    VARCHAR2(200),
  FSETNAME  VARCHAR2(200),
  FSETID    VARCHAR2(200),
  FSETCODE  VARCHAR2(200),
  COUNTDATE VARCHAR2(20),
  SSZB      VARCHAR2(200),
  JRDWJZ    VARCHAR2(200),
  ZRDWJZ    VARCHAR2(200),
  JZZZL     VARCHAR2(200),
  BRSY      VARCHAR2(200),
  WFSY      VARCHAR2(200),
  QRSY      VARCHAR2(200),
  ISCHILD   VARCHAR2(200),
  PARENTJJ  VARCHAR2(30),
  LJDWJZ    VARCHAR2(200),
  DBNAME    VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SD_BD_ACCSUBJ
prompt ============================
prompt
create table GUZHI.SD_BD_ACCSUBJ
(
  ACCREMOVE           CHAR(1),
  BALANFLAG           CHAR(1),
  BALANORIENT         NUMBER(38),
  BEGINPERIOD         VARCHAR2(2),
  BEGINYEAR           VARCHAR2(4),
  BOTHORIENT          CHAR(1),
  CASHBANKFLAG        NUMBER(38),
  CREATECORP          VARCHAR2(4),
  CREATEPERIOD        VARCHAR2(2),
  CREATEYEAR          VARCHAR2(4),
  CTLSYSTEM           VARCHAR2(80),
  CURRENCY            VARCHAR2(20),
  DISPNAME            VARCHAR2(200),
  DR                  INTEGER,
  ENDFLAG             CHAR(1),
  ENDPERIOD           VARCHAR2(2),
  ENDYEAR             VARCHAR2(4),
  ENGSUBJNAME         VARCHAR2(100),
  FREE1               VARCHAR2(20),
  FREE10              VARCHAR2(20),
  FREE11              VARCHAR2(20),
  FREE12              VARCHAR2(20),
  FREE13              VARCHAR2(20),
  FREE14              VARCHAR2(20),
  FREE15              VARCHAR2(20),
  FREE16              VARCHAR2(20),
  FREE17              VARCHAR2(20),
  FREE18              VARCHAR2(20),
  FREE19              VARCHAR2(20),
  FREE2               VARCHAR2(20),
  FREE20              VARCHAR2(20),
  FREE3               VARCHAR2(20),
  FREE4               VARCHAR2(20),
  FREE5               VARCHAR2(20),
  FREE6               VARCHAR2(20),
  FREE7               VARCHAR2(20),
  FREE8               VARCHAR2(20),
  FREE9               VARCHAR2(20),
  INCURFLAG           CHAR(1),
  INNERINFONULL       CHAR(1),
  INNERSUBJ           CHAR(1),
  OUTFLAG             CHAR(1),
  PK_ACCSUBJ          VARCHAR2(20),
  PK_CORP             VARCHAR2(4),
  PK_CREATE_GLORGBOOK VARCHAR2(20),
  PK_GLORGBOOK        VARCHAR2(20),
  PK_GRPACCSUBJ       VARCHAR2(20),
  PK_SUBJSCHEME       VARCHAR2(20),
  PK_SUBJTYPE         VARCHAR2(20),
  PROPERTY1           VARCHAR2(100),
  PROPERTY2           VARCHAR2(100),
  PROPERTY3           VARCHAR2(100),
  PROPERTY4           VARCHAR2(100),
  PROPERTY5           VARCHAR2(100),
  REMCODE             VARCHAR2(50),
  SEALFLAG            VARCHAR2(10),
  STOPED              CHAR(1),
  SUBJCODE            VARCHAR2(40),
  SUBJLEV             NUMBER(38),
  SUBJNAME            VARCHAR2(200),
  SUMPRINT_LEVEL      NUMBER(38),
  TS                  VARCHAR2(19),
  UNIT                VARCHAR2(10),
  RQ                  VARCHAR2(8)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SD_GL_DETAIL
prompt ===========================
prompt
create table GUZHI.SD_GL_DETAIL
(
  ASSID             VARCHAR2(20),
  BANKACCOUNT       VARCHAR2(40),
  BUSIRECONNO       VARCHAR2(60),
  CHECKDATE         VARCHAR2(10),
  CHECKNO           VARCHAR2(30),
  CHECKSTYLE        VARCHAR2(20),
  CONTRASTFLAG      NUMBER(38),
  CONVERTFLAG       CHAR(1),
  CREDITAMOUNT      NUMBER(20,4),
  CREDITQUANTITY    NUMBER(20,8),
  DEBITAMOUNT       NUMBER(20,4),
  DEBITQUANTITY     NUMBER(20,8),
  DETAILINDEX       NUMBER(38),
  DIRECTION         CHAR(1),
  DISCARDFLAGV      CHAR(1),
  DR                INTEGER,
  ERRMESSAGE        VARCHAR2(90),
  ERRMESSAGE2       VARCHAR2(60),
  ERRMESSAGEH       VARCHAR2(90),
  EXCRATE1          NUMBER(15,8),
  EXCRATE2          NUMBER(15,8),
  EXPLANATION       VARCHAR2(300),
  FRACCREDITAMOUNT  NUMBER(20,4),
  FRACDEBITAMOUNT   NUMBER(20,4),
  FREE1             VARCHAR2(60),
  FREE10            VARCHAR2(60),
  FREE11            VARCHAR2(60),
  FREE2             VARCHAR2(60),
  FREE3             VARCHAR2(60),
  FREE4             VARCHAR2(60),
  FREE5             VARCHAR2(60),
  FREE6             VARCHAR2(60),
  FREE7             VARCHAR2(60),
  FREE8             VARCHAR2(60),
  FREE9             VARCHAR2(60),
  ISDIFFLAG         CHAR(1),
  LOCALCREDITAMOUNT NUMBER(20,4),
  LOCALDEBITAMOUNT  NUMBER(20,4),
  MODIFYFLAG        VARCHAR2(20),
  NOV               NUMBER(38),
  OPPOSITESUBJ      VARCHAR2(200),
  PERIODV           VARCHAR2(2),
  PK_ACCSUBJ        VARCHAR2(20),
  PK_CORP           VARCHAR2(4),
  PK_CURRTYPE       VARCHAR2(20),
  PK_DETAIL         VARCHAR2(20),
  PK_GLBOOK         VARCHAR2(20),
  PK_GLORG          VARCHAR2(20),
  PK_GLORGBOOK      VARCHAR2(20),
  PK_INNERCORP      VARCHAR2(20),
  PK_INNERSOB       VARCHAR2(20),
  PK_MANAGERV       VARCHAR2(20),
  PK_OFFERDETAIL    VARCHAR2(20),
  PK_OTHERCORP      VARCHAR2(4),
  PK_OTHERORGBOOK   VARCHAR2(20),
  PK_SOB            VARCHAR2(20),
  PK_SOURCEPK       VARCHAR2(20),
  PK_SYSTEMV        VARCHAR2(20),
  PK_VOUCHER        VARCHAR2(20),
  PK_VOUCHERTYPEV   VARCHAR2(20),
  PREPAREDDATEV     VARCHAR2(10),
  PRICE             NUMBER(20,8),
  RECIEPTCLASS      VARCHAR2(60),
  SIGNDATEV         VARCHAR2(10),
  TS                VARCHAR2(19),
  VOUCHERKINDV      NUMBER(38),
  YEARV             VARCHAR2(4),
  RQ                VARCHAR2(8)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SERIAL_ID
prompt ========================
prompt
create table GUZHI.SERIAL_ID
(
  SERUAL_NO VARCHAR2(20),
  CUST_ID   VARCHAR2(20),
  AMOUNT    VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TBANKPRODUCT
prompt ===========================
prompt
create table GUZHI.TBANKPRODUCT
(
  C_FUNDCODE              VARCHAR2(30),
  C_SUBFUNDCODE           VARCHAR2(30),
  C_SUBFUNDNAME           VARCHAR2(30),
  D_BEGINDATE             DATE,
  D_ENDDATE               DATE,
  D_ECONTRACTBEGIN        VARCHAR2(30),
  D_ECONTRACTEND          VARCHAR2(30),
  F_MAXBALA               VARCHAR2(30),
  D_UNIFIEDDATE           DATE,
  F_FACTCOLLECT           VARCHAR2(30),
  C_PROFITDATETYPE        VARCHAR2(30),
  C_STATUS                VARCHAR2(30),
  D_TERMINATEDATE         DATE,
  F_TERMINATEASSET        VARCHAR2(30),
  F_TERMINATESHARE        VARCHAR2(30),
  F_REALSHARES            VARCHAR2(30),
  C_ASSIGNBASEMODE        VARCHAR2(30),
  C_ISCALCINTEREST        VARCHAR2(30),
  L_BEGININTERESTDAYS     VARCHAR2(30),
  D_INTERESTENDDATE       VARCHAR2(30),
  C_ISWEIGHTING           VARCHAR2(30),
  C_INTERESTTYPE          VARCHAR2(30),
  C_YEARDAYSTYPE          VARCHAR2(30),
  C_TERMINATEINCOMEMODE   VARCHAR2(30),
  C_INCOMEBONUSTYPE       VARCHAR2(30),
  F_TOTALPROFIT           VARCHAR2(30),
  C_ISTRANSFERBYOTHERCODE VARCHAR2(30),
  C_TRANSFERCODE          VARCHAR2(30),
  C_SUBPRODTYPE           VARCHAR2(30),
  F_INCOMERATIO           VARCHAR2(30),
  F_NEEDPAYMENT           VARCHAR2(30),
  D_INCOMEENDDATE         VARCHAR2(30),
  C_ISBREAKCONTRACT       VARCHAR2(30),
  L_PUNISHDAYSBREAK       VARCHAR2(30),
  C_ISADVANCETERMINATE    VARCHAR2(30),
  L_PUNISHDAYSADVANCE     VARCHAR2(30),
  C_ISSUEFAILURE          VARCHAR2(30),
  C_MEMO                  VARCHAR2(30),
  C_INTERESTBEGTYPE       VARCHAR2(30),
  D_INTERESTBEGDATE       VARCHAR2(30),
  D_PRECHDATE             VARCHAR2(30),
  D_CHDATE                VARCHAR2(30),
  D_PROFITENDDATE         DATE,
  C_HASSTAGEEXIT          VARCHAR2(30),
  L_SUBFUNDKEY            VARCHAR2(30),
  F_TOTALBONUS            VARCHAR2(30),
  C_ACCUMBONUSFLAG        VARCHAR2(30),
  D_PREINCOMEENDDATE      VARCHAR2(30),
  D_NEXTINCOMEENDDATE     VARCHAR2(30),
  C_FUNDACCO              VARCHAR2(30),
  C_ADVANCEPUNISHMODE     VARCHAR2(30),
  F_ADVANCEPUNISHBALANCE  VARCHAR2(30),
  C_ISINTERESTDISTRIBUTED VARCHAR2(30)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TCUSTOMERINFO
prompt ============================
prompt
create table GUZHI.TCUSTOMERINFO
(
  C_CUSTNO            VARCHAR2(30),
  C_CUSTTYPE          VARCHAR2(30),
  C_CUSTNAME          VARCHAR2(30),
  C_SHORTNAME         VARCHAR2(30),
  C_HELPCODE          VARCHAR2(30),
  C_IDENTITYTYPE      VARCHAR2(30),
  C_IDENTITYNO        VARCHAR2(30),
  C_ZIPCODE           VARCHAR2(30),
  C_ADDRESS           VARCHAR2(50),
  C_PHONE             VARCHAR2(30),
  C_FAXNO             VARCHAR2(30),
  C_MOBILENO          VARCHAR2(30),
  C_EMAIL             VARCHAR2(30),
  C_SEX               VARCHAR2(30),
  C_BIRTHDAY          VARCHAR2(30),
  C_VOCATION          VARCHAR2(30),
  C_EDUCATION         VARCHAR2(30),
  C_INCOME            VARCHAR2(30),
  C_CONTACT           VARCHAR2(30),
  C_CONTYPE           VARCHAR2(30),
  C_CONTNO            VARCHAR2(30),
  C_BILLSENDFLAG      VARCHAR2(30),
  C_CALLCENTER        VARCHAR2(30),
  C_INTERNET          VARCHAR2(30),
  C_SECRETCODE        VARCHAR2(30),
  C_NATIONALITY       VARCHAR2(30),
  C_CITYNO            VARCHAR2(30),
  C_LAWNAME           VARCHAR2(30),
  C_SHACCO            VARCHAR2(30),
  C_SZACCO            VARCHAR2(30),
  C_BROKER            VARCHAR2(30),
  F_AGIO              VARCHAR2(30),
  C_MEMO              VARCHAR2(30),
  C_RESERVE           VARCHAR2(30),
  C_CORPNAME          VARCHAR2(30),
  C_CORPTEL           VARCHAR2(30),
  C_SPECIALCODE       VARCHAR2(30),
  C_ACTCODE           VARCHAR2(30),
  C_BILLSENDPASS      VARCHAR2(30),
  C_ADDRESSINVALID    VARCHAR2(30),
  D_APPENDDATE        DATE,
  D_BACKDATE          VARCHAR2(30),
  C_INVALIDADDRESS    VARCHAR2(30),
  C_BACKREASON        VARCHAR2(30),
  C_MODIFYINFO        VARCHAR2(30),
  C_RECOMMENDER       VARCHAR2(30),
  C_RECOMMENDERTYPE   VARCHAR2(30),
  D_IDNOVALIDDATE     VARCHAR2(30),
  C_INSTREPRIDCODE    VARCHAR2(30),
  C_INSTREPRIDTYPE    VARCHAR2(30),
  D_CONTIDNOVALIDDATE VARCHAR2(30),
  D_LAWIDNOVALIDDATE  VARCHAR2(30),
  C_INSTITUTIONTYPE   VARCHAR2(30),
  C_SPECIALFUNDACCO   VARCHAR2(30),
  C_ISGLFACCO         VARCHAR2(30)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TFUNDDAY
prompt =======================
prompt
create table GUZHI.TFUNDDAY
(
  D_DATE                    CHAR(8),
  D_CDATE                   CHAR(8),
  C_FUNDCODE                VARCHAR2(6),
  C_TODAYSTATUS             CHAR(1),
  C_STATUS                  CHAR(1),
  F_NETVALUE                NUMBER(7,4),
  F_LASTSHARES              NUMBER(16,2),
  F_LASTASSET               NUMBER(16,2),
  F_ASUCCEED                NUMBER(16,2),
  F_RSUCCEED                NUMBER(16,2),
  C_VASTFLAG                CHAR(1),
  F_ENCASHRATIO             NUMBER(9,8),
  F_CHANGERATIO             NUMBER(9,8),
  C_EXCESSFLAG              CHAR(1),
  F_SUBSCRIBERATIO          NUMBER(9,8),
  C_INPUTPERSONNEL          VARCHAR2(16),
  C_CHECKPERSONNEL          VARCHAR2(16),
  C_CHECK                   CHAR(1),
  F_INCOME                  NUMBER(16,2),
  F_INCOMEUNIT              NUMBER(10,5),
  F_INCOMERATIO             NUMBER(9,6),
  F_UNASSIGN                NUMBER(16,2),
  F_TOTALNETVALUE           NUMBER(7,4),
  F_SERVICEFARE             NUMBER(16,2),
  F_ASSIGN                  NUMBER(16,2),
  F_GROWTHRATE              NUMBER(9,8),
  F_MANAGEFARE              NUMBER(16,2),
  F_PROTECTBALANCE          NUMBER(16,2),
  C_TODAYPCSSTATUS          CHAR(1),
  C_TODAYCHGSTATUS          CHAR(1),
  C_TODAYTRFSTATUS          CHAR(1),
  C_TODAYSPLITSTATUS        CHAR(1),
  D_EXPORTDATE              CHAR(8),
  F_EXCHANGERATE            NUMBER(7,4),
  F_STRUCTUREDTOTALASSET    NUMBER(16,2),
  C_NETREDEEMORPURCHASEFLAG CHAR(1),
  F_YEBINCOME               NUMBER(16,2),
  F_YEBASSIGN               NUMBER(16,2),
  F_YEBUNASSIGN             NUMBER(16,2),
  F_OFFSETINCOME            NUMBER(16,2),
  F_QINCOMERATIO            NUMBER(9,6),
  C_PERMITDEAL              CHAR(1),
  D_FILEDATE                VARCHAR2(8)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TFUNDINFO
prompt ========================
prompt
create table GUZHI.TFUNDINFO
(
  C_FUNDCODE                VARCHAR2(6),
  C_FUNDNAME                VARCHAR2(40),
  C_FUNDENGLISHNAME         VARCHAR2(40),
  C_MONEYTYPE               CHAR(3),
  C_TRUSTEECODE             CHAR(3),
  F_ISSUEPRICE              NUMBER(11,8),
  D_ISSUEDATE               CHAR(8),
  D_ISSUEENDDATE            CHAR(8),
  D_SETUPDATE               CHAR(8),
  F_MAXBALA                 NUMBER(16,2),
  F_MINBALA                 NUMBER(16,2),
  L_ELIMITDAY               NUMBER(10),
  L_SLIMITDAY               NUMBER(10),
  D_ALIMITENDDATE           CHAR(8),
  L_MINCOUNT                NUMBER(10),
  L_CLIMITDAY               NUMBER(10),
  F_MAXREDEEM               NUMBER(9,8),
  C_FUNDCHARACTER           VARCHAR2(72),
  C_FUNDSTATUS              CHAR(1),
  L_TIMELIMIT               NUMBER(10),
  C_SHARETYPES              VARCHAR2(5),
  C_ISSUETYPE               CHAR(1),
  F_FACTCOLLECT             NUMBER(16,2),
  D_FAILUEDATE              CHAR(8),
  F_ALLOTRATIO              NUMBER(9,8),
  C_FEERATIOTYPE1           CHAR(1),
  C_FEERATIOTYPE2           CHAR(1),
  C_EXCEEDPART              CHAR(1),
  C_BONUSTYPE               CHAR(1),
  C_INTERESTDEALTYPE        CHAR(1),
  F_MANAGERFEE              NUMBER(9,8),
  C_INVESTORIENTATION       CHAR(1),
  D_EVENDATE                CHAR(8),
  C_BACKFARECAL             CHAR(1),
  L_MONEYDATE               NUMBER(10),
  L_NETPRECISION            NUMBER(10),
  C_FARECALTYPE             CHAR(1),
  L_TASPECIALACCO           NUMBER(10),
  C_SHAREDETAIL             CHAR(1),
  C_BOURSETRADEFLAG         CHAR(1),
  C_CLEANFLAG               CHAR(1),
  L_BANKACCONO              NUMBER(10),
  F_MAXALLOTASSET           NUMBER(16,2),
  F_MAXALLOTSHARES          NUMBER(16,2),
  F_MAXADDBALANCE           NUMBER(16,2),
  C_FOREIGNTRUSTEENO        CHAR(3),
  C_GRADETYPE               CHAR(1),
  C_EXCESSALLOT             CHAR(1),
  C_EXTRADEALTYPE           CHAR(1),
  L_MAXCOUNT                NUMBER(10),
  C_ORDERMODE               CHAR(1),
  D_ACCOUTLASTDATE          CHAR(8),
  D_ASSETLASTDATE           CHAR(8),
  C_ASSETTYPE               CHAR(1),
  F_MINASSET                NUMBER(16,2),
  C_INTERESTINCLUDEFARE     CHAR(1),
  L_TNCONFIRM               NUMBER(3),
  C_NAVPUBLISHDAY           VARCHAR2(2),
  C_FUNDTYPE                CHAR(1),
  C_UPGRADEFLAG             CHAR(1),
  C_HOLDTYPE                CHAR(1),
  C_CFMFREQUENCY            CHAR(1),
  C_SYSROLE                 CHAR(1),
  C_DSFIRST                 CHAR(1),
  C_AGENCYCTRL              CHAR(1),
  C_FORCEREDEEM             CHAR(1),
  C_DETAILPRECISION         CHAR(1),
  C_CHANGEFIFO              CHAR(1),
  C_CHECKSHARE              CHAR(1),
  C_SEGMETHOD               CHAR(1),
  C_DISTRIBUTETYPE          CHAR(1),
  C_OPERATETYPE             CHAR(1),
  C_INVESTAREA              CHAR(1),
  C_FUNDSSOURCEAREA         CHAR(1),
  C_RISKLEVEL               CHAR(1),
  C_BREACHTRADEFARE         CHAR(1),
  C_LARGETRADELIMIT         CHAR(1),
  C_LARGECHANGELIMIT        CHAR(1),
  C_MERGECLASS4LARGE        CHAR(1),
  C_LARGEEXCEEDPART         CHAR(1),
  C_RATIONSTATUS            CHAR(1),
  C_NAVEPUBLISHFREQUENCY    CHAR(1),
  C_ISZDPRECALCULATEFEE     CHAR(1),
  C_SHORTCYCLEFINANCE       CHAR(1),
  C_USEINOPENDAY            CHAR(1),
  C_MGRCODE                 VARCHAR2(6),
  L_OPENPOSITIONDAY         NUMBER(5),
  C_ENHANCEDREGULAROPENFUND CHAR(1),
  F_MAXNETALLOTRATIO        NUMBER(9,8),
  F_MAXNETREDEEMRATIO       NUMBER(9,8),
  C_FIXEDDIVIDWAY           CHAR(1),
  C_CONTRACTTYPE            CHAR(1),
  C_PENSIONINVESTTYPE       CHAR(1),
  C_FOREIGNCURRENCYFUNDFLAG CHAR(1),
  C_PENSIONREGISTCODE       VARCHAR2(12),
  C_MINSHAREADDINCOME       CHAR(1),
  L_MINIHOLDDAYS            NUMBER(10),
  C_TAILDECIMAL             CHAR(1),
  C_FIRSTINVESTINCLUDEFEE   CHAR(1),
  F_MAXALLOT                NUMBER(5,4),
  C_OTCNEEDPROFIT           CHAR(1),
  C_ISOTC                   VARCHAR2(1),
  C_OTCFUNDTYPE             VARCHAR2(2),
  C_OUTFUNDCODE             VARCHAR2(8),
  C_ISYUEBAO                CHAR(1),
  C_T0LIQUDIATE             CHAR(1),
  C_INCOMEJOINASSIGN        CHAR(1),
  C_REDEEMCHANGEINCOME      CHAR(1),
  C_INCOMEINTOSHARE         CHAR(1),
  C_EXCEEDFLAG              CHAR(1),
  C_INCOMEINTOSHARETZJY     CHAR(1),
  C_NEWINCOMETOTZJY         CHAR(1),
  L_PERIODS                 NUMBER(4),
  C_FULLCODE                VARCHAR2(8),
  C_ACCOINCOMEDEALTYPE      CHAR(1),
  D_CONTRACTBEGDATE         CHAR(8),
  C_NEWINCOMEISCHANGE       CHAR(1),
  C_NOBONUSINVEST           CHAR(1),
  C_PAYMENTFREQUENCY        CHAR(1),
  C_REINVESTMODE            CHAR(1),
  C_SECMGRCODE              VARCHAR2(9),
  C_REDEEMPOSTPONEMODE      CHAR(1),
  C_STEPINVESTINCLUDEFEE    CHAR(1),
  C_FAREBELONGASSET         CHAR(1),
  F_PARVALUE                NUMBER(7,4),
  C_INCOMETOSHAREDETAIL     CHAR(1),
  C_MFDEDUCTPROFIT          CHAR(1),
  C_CHGBACKFARECAL          CHAR(1),
  C_ALLOWHOLDBREAKREDEEM    CHAR(1),
  C_SMALLSETPPRODUCT        CHAR(1),
  C_TRUSTEEACCO             VARCHAR2(30),
  C_SHRDTLINCOMEDEALTYPE    CHAR(1),
  C_ALLOWTAREDEEMHOLD       CHAR(1),
  C_GRADECONTROLTYPE        CHAR(1),
  C_HOLDRDMPARTCFMTYPE      CHAR(1),
  C_RDMFARECALTYPE          CHAR(1),
  C_OTCFUNDNO               VARCHAR2(12),
  C_RPTISSEND               CHAR(1),
  C_SHAREEXITBYDETAIL       CHAR(1),
  C_TWICEJUDGE              CHAR(1),
  C_SERVICEFARETYPE         CHAR(1),
  C_SPREDEEMDEAL            CHAR(1),
  C_LIQUIDMODE              CHAR(1),
  C_CHECKNETVALUE           CHAR(1),
  C_ISSERVICEFARE           CHAR(1),
  C_MMFCHKSHRINCNEWINCOME   CHAR(1),
  C_ZCBFUNDCODE             VARCHAR2(32),
  C_ISPUBLISHTOTALVALUE     CHAR(1),
  L_HINTENDDAY              NUMBER(4),
  C_EXPTZJYSETUPDATA        CHAR(1),
  C_HMINDEALTYPE            CHAR(1),
  F_PLEDGEDPERCENT          NUMBER(9,8),
  C_NAVPUBLISHMONTH         VARCHAR2(2),
  F_PARDONACCOMINBALA       NUMBER(16,2),
  C_SUBSHAREREDMFREE        CHAR(1),
  C_SVFAREEXCLUSIVECLASS    CHAR(1),
  C_ONLINEINPUTDATE         VARCHAR2(8),
  C_REIMPNAV                CHAR(1),
  C_RDMLIMITISPROFIT        CHAR(1),
  C_INCOMECHANGETYPE        CHAR(1),
  F_LOSSNAV                 NUMBER(7,4),
  C_CALNAVFREQUENCYTYPE     CHAR(1),
  C_SPLITSUPPORTDEDUCT      CHAR(1),
  C_SUBRATIOMODE            CHAR(1),
  C_ALLRDM300WFLAGCLEAR     CHAR(1),
  C_INTERFACECODE           VARCHAR2(6),
  C_DEPARTMENT              VARCHAR2(2),
  C_NOMINALHOLD             CHAR(1),
  C_ISPUBLICMONEYFUND       CHAR(1),
  C_HOLDLIMITBONUSSHARE     CHAR(1),
  C_CHECKINNAV              CHAR(1),
  F_LOWBONUSABSNETVALUE     NUMBER(7,4),
  F_LOWBONUSRELNETVALUE     NUMBER(7,4),
  L_MAXBONUSNUMBER          NUMBER(5),
  C_UPNETVALUETYPE          CHAR(1),
  C_MANAGERNAME             CHAR(40),
  C_FUNDSTATUSTOPAY         VARCHAR2(20),
  C_EXPSALESERVICEFARE      CHAR(1),
  L_FUNDID                  VARCHAR2(20),
  VC_NAME                   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TFUNDINFO_NEW
prompt ============================
prompt
create table GUZHI.TFUNDINFO_NEW
(
  L_FUNDID       NUMBER(6),
  VC_CODE        VARCHAR2(15) not null,
  VC_NAME        VARCHAR2(200),
  VC_FULLNAME    VARCHAR2(200),
  L_CLASS        NUMBER(4) default 1 not null,
  D_CREATE       DATE,
  L_LONG         NUMBER(4) default 0 not null,
  VC_TGR         VARCHAR2(50),
  VC_GLR         VARCHAR2(200),
  VC_FQR         VARCHAR2(60),
  EN_ZFE         NUMBER(21,6) default 1 not null,
  L_JJTZLX       NUMBER(4) not null,
  L_TZFG         NUMBER(4),
  L_KHLX         NUMBER(4),
  L_FHFS         NUMBER(4),
  L_KHLY         NUMBER(4),
  VC_JSBH        VARCHAR2(400),
  EN_MJJE        NUMBER(19,4) default 1 not null,
  C_SYNCHRO_FLAG CHAR(1) default 0,
  D_SYNCHRO_TIME DATE,
  VC_TGZH        VARCHAR2(28),
  L_TZRS         NUMBER(8) default 0 not null,
  D_DQRQ         DATE,
  VC_JBGLF       VARCHAR2(2000),
  VC_JBTGF       VARCHAR2(2000),
  VC_FXZBJ       VARCHAR2(2000),
  VC_DJR         VARCHAR2(2000),
  VC_HTQDRQ      VARCHAR2(2000),
  VC_FGTZBL      VARCHAR2(2000),
  VC_ZCTQSJ      VARCHAR2(2000),
  VC_YJBJJZ      VARCHAR2(2000),
  VC_JXGLF       VARCHAR2(2000),
  VC_DQBG        VARCHAR2(2000),
  VC_QSBG        VARCHAR2(2000),
  VC_BZ          VARCHAR2(2000),
  L_BXCPLX       NUMBER(4),
  L_JHJHLX       NUMBER(1) default 1 not null,
  EN_MBGM        NUMBER(19,4) default 0 not null,
  VC_BFJZH       VARCHAR2(50),
  L_SCLB         NUMBER(4) default 0 not null,
  L_ZXSHDW       NUMBER(10),
  VC_TGHID       VARCHAR2(3),
  EN_CSMZ        NUMBER(19,4) default 1 not null,
  VC_GLRBH       VARCHAR2(8),
  L_JHCPLX       NUMBER(1) default 1 not null,
  L_GLFDZR       NUMBER(10),
  L_TGFDZR       NUMBER(10),
  L_KHBH         NUMBER(8),
  VC_TGHFZH      VARCHAR2(2000),
  VC_GLRBM       VARCHAR2(100),
  VC_WBJG        VARCHAR2(50),
  VC_WBJGBH      VARCHAR2(8),
  L_SFJTYJBC     NUMBER default 0,
  VC_JWTGRDM     VARCHAR2(200),
  VC_JWTGRZWMC   VARCHAR2(500),
  VC_JWTGRYWMC   VARCHAR2(500),
  VC_TZLCCPDM    VARCHAR2(20),
  VC_YXJG        VARCHAR2(100),
  VC_YXTJR       VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TFUNDINFO_OLD
prompt ============================
prompt
create table GUZHI.TFUNDINFO_OLD
(
  L_FUNDID       NUMBER(6),
  VC_CODE        VARCHAR2(15) not null,
  VC_NAME        VARCHAR2(200),
  VC_FULLNAME    VARCHAR2(200),
  L_CLASS        NUMBER(4) default 1 not null,
  D_CREATE       DATE,
  L_LONG         NUMBER(4) default 0 not null,
  VC_TGR         VARCHAR2(50),
  VC_GLR         VARCHAR2(200),
  VC_FQR         VARCHAR2(60),
  EN_ZFE         NUMBER(21,6) default 1 not null,
  L_JJTZLX       NUMBER(4) not null,
  L_TZFG         NUMBER(4),
  L_KHLX         NUMBER(4),
  L_FHFS         NUMBER(4),
  L_KHLY         NUMBER(4),
  VC_JSBH        VARCHAR2(400),
  EN_MJJE        NUMBER(19,4) default 1 not null,
  C_SYNCHRO_FLAG CHAR(1) default 0,
  D_SYNCHRO_TIME DATE,
  VC_TGZH        VARCHAR2(28),
  L_TZRS         NUMBER(8) default 0 not null,
  D_DQRQ         DATE,
  VC_JBGLF       VARCHAR2(2000),
  VC_JBTGF       VARCHAR2(2000),
  VC_FXZBJ       VARCHAR2(2000),
  VC_DJR         VARCHAR2(2000),
  VC_HTQDRQ      VARCHAR2(2000),
  VC_FGTZBL      VARCHAR2(2000),
  VC_ZCTQSJ      VARCHAR2(2000),
  VC_YJBJJZ      VARCHAR2(2000),
  VC_JXGLF       VARCHAR2(2000),
  VC_DQBG        VARCHAR2(2000),
  VC_QSBG        VARCHAR2(2000),
  VC_BZ          VARCHAR2(2000),
  L_BXCPLX       NUMBER(4),
  L_JHJHLX       NUMBER(1) default 1 not null,
  EN_MBGM        NUMBER(19,4) default 0 not null,
  VC_BFJZH       VARCHAR2(50),
  L_SCLB         NUMBER(4) default 0 not null,
  L_ZXSHDW       NUMBER(10),
  VC_TGHID       VARCHAR2(3),
  EN_CSMZ        NUMBER(19,4) default 1 not null,
  VC_GLRBH       VARCHAR2(8),
  L_JHCPLX       NUMBER(1) default 1 not null,
  L_GLFDZR       NUMBER(10),
  L_TGFDZR       NUMBER(10),
  L_KHBH         NUMBER(8),
  VC_TGHFZH      VARCHAR2(2000),
  VC_GLRBM       VARCHAR2(100),
  VC_WBJG        VARCHAR2(50),
  VC_WBJGBH      VARCHAR2(8),
  L_SFJTYJBC     NUMBER default 0,
  VC_JWTGRDM     VARCHAR2(200),
  VC_JWTGRZWMC   VARCHAR2(500),
  VC_JWTGRYWMC   VARCHAR2(500),
  VC_TZLCCPDM    VARCHAR2(20),
  VC_YXJG        VARCHAR2(100),
  VC_YXTJR       VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );
create index GUZHI.INX_TFUNDINFO_CODE on GUZHI.TFUNDINFO_OLD (VC_CODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMANAGERDIVIDEND
prompt ===============================
prompt
create table GUZHI.TMANAGERDIVIDEND
(
  D_CDATE          DATE,
  C_FUNDCODE       VARCHAR2(50),
  F_DIVIDENDAMOUNT VARCHAR2(50),
  C_FUNDACCO       VARCHAR2(50),
  C_CSERIALNO      VARCHAR2(50),
  C_TRADEACCO      VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TSHARECURRENTS
prompt =============================
prompt
create table GUZHI.TSHARECURRENTS
(
  C_TRADEACCO VARCHAR2(50),
  L_SERIALNO  VARCHAR2(50),
  D_CDATE     DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TSHAREDETAIL
prompt ===========================
prompt
create table GUZHI.TSHAREDETAIL
(
  C_FUNDACCO                 VARCHAR2(30),
  C_TRADEACCO                VARCHAR2(30),
  C_FUNDCODE                 VARCHAR2(30),
  C_SHARETYPE                VARCHAR2(30),
  C_AGENCYNO                 VARCHAR2(30),
  C_NETNO                    VARCHAR2(30),
  D_CDATE                    DATE,
  C_CSERIALNO                VARCHAR2(30),
  C_SOURCETYPE               VARCHAR2(30),
  F_REMAINSHARES             VARCHAR2(30),
  D_REGISTDATE               DATE,
  F_ORIBALANCE               VARCHAR2(30),
  F_ORISHARES                VARCHAR2(30),
  F_COSTFARE                 VARCHAR2(30),
  F_ORINETVALUE              VARCHAR2(30),
  F_GAINBALANCE              VARCHAR2(30),
  C_PROMISENO                VARCHAR2(30),
  F_CSHAREFARE               VARCHAR2(30),
  D_LASTMODIFY               DATE,
  C_ORIAGENCY                VARCHAR2(30),
  C_BONUSFLAG                VARCHAR2(30),
  C_ORISOURCE                VARCHAR2(30),
  F_BACKFARERATIO            VARCHAR2(30),
  F_RULEAGIO                 VARCHAR2(30),
  F_ORIAGIO                  VARCHAR2(30),
  F_MAXALLOTRATIO            VARCHAR2(30),
  F_MINREDEEMRATIO           VARCHAR2(30),
  F_MINBACKRATIO             VARCHAR2(30),
  F_EVENNETVALUE             VARCHAR2(30),
  C_HOLDFLAG                 VARCHAR2(30),
  C_ACCEPTMODE               VARCHAR2(30),
  F_TOTALBONUS               VARCHAR2(30),
  C_ACTCODE                  VARCHAR2(30),
  D_APPENDDATE               DATE,
  C_FIRSTCSERIALNO           VARCHAR2(30),
  C_BOURSEFLAG               VARCHAR2(30),
  C_FUNDTYPE                 VARCHAR2(30),
  C_BANKNO                   VARCHAR2(30),
  C_SUBFUNDMETHOD            VARCHAR2(30),
  C_SPECIALTIES              VARCHAR2(30),
  F_SPLITSHARES              VARCHAR2(30),
  F_FLOORSHARES              VARCHAR2(30),
  F_APPORTIONRATIO           VARCHAR2(30),
  F_FARERATIO                VARCHAR2(30),
  F_MANAGEFARE               VARCHAR2(30),
  F_INTERESTSHARE            VARCHAR2(30),
  F_BACKFARE                 VARCHAR2(30),
  F_CHGFILLRATIO             VARCHAR2(30),
  D_LASTDEDUCTDATE           VARCHAR2(30),
  F_ASSIGNEDSHARES           VARCHAR2(30),
  C_PROTECTFLAG              VARCHAR2(30),
  C_ORIBOURSE                VARCHAR2(30),
  F_INCOME                   VARCHAR2(30),
  F_NEWINCOME                VARCHAR2(30),
  F_ASSIGNEDINCOME           VARCHAR2(30),
  D_CYCLEENDDATE             VARCHAR2(30),
  D_CYCLEBEGINDATE           VARCHAR2(30),
  D_CYCLENEXTDATE            VARCHAR2(30),
  F_ACCUMSHARES              VARCHAR2(30),
  F_LASTACCUMSHARES          VARCHAR2(30),
  F_LASTINCOME               VARCHAR2(30),
  F_CYCLEINCOME              VARCHAR2(30),
  F_CYCLEACCUMSHARES         VARCHAR2(30),
  F_DOUBLEINCOME             VARCHAR2(30),
  F_CYCLEDOUBLEINCOME        VARCHAR2(30),
  F_NEWDOUBLEINCOME          VARCHAR2(30),
  F_INTERESTINCOME           VARCHAR2(30),
  F_REALINTERESTSHARE        VARCHAR2(30),
  F_CALINCOME                VARCHAR2(30),
  D_INTERESTDATE             VARCHAR2(30),
  D_LASTINCOMEMAKEUPDATE     VARCHAR2(30),
  F_EXPECTTOTALBONUS         VARCHAR2(30),
  F_ENDBALANCE               VARCHAR2(30),
  F_BEGINBALANCE             VARCHAR2(30),
  C_LOCKFLAG                 VARCHAR2(30),
  C_LOCKCSERIALNO            VARCHAR2(30),
  F_CSERVICEFARE             VARCHAR2(30),
  C_SPECIALACCOFLAG          VARCHAR2(30),
  D_LASTCHARGEMGRFAREDATE    VARCHAR2(30),
  C_PROMOTIONPERIODSHAREFLAG VARCHAR2(30),
  F_DEDUCTEDBALANCE          VARCHAR2(30),
  F_ASSIGNEDDEDUCTEDBALANCE  VARCHAR2(30),
  C_PRODUCTCYCLE             VARCHAR2(30),
  C_UPGRADEFLAG              VARCHAR2(30),
  F_UPGRADENETVALUE          VARCHAR2(30),
  F_UPGRADETOTALBONUS        VARCHAR2(30),
  F_NEXTDCTBGNNETVALUE       VARCHAR2(30),
  F_TOTALCASHUNITBONUS       VARCHAR2(30),
  C_ORIGINALNO               VARCHAR2(30),
  C_FIRSTDEDCUTFLAG          VARCHAR2(30),
  D_LASTPAYINCOMEDATE        VARCHAR2(30),
  C_PROMISESHARESFLAG        VARCHAR2(30),
  F_TOTALUNITBONUS           VARCHAR2(30),
  F_COSTPRICE                VARCHAR2(30),
  C_SUBFUNDCODE              VARCHAR2(30),
  F_NEWCSERVICEFARE          VARCHAR2(30),
  D_SCF02REQDATE             VARCHAR2(30),
  F_SCF02REQBANLANCE         VARCHAR2(30),
  C_INCOMEGRADE              VARCHAR2(30),
  D_LASTBONUSDATE            VARCHAR2(30),
  C_PARTNERID                VARCHAR2(30),
  D_ORI02REQDATE             VARCHAR2(30),
  D_LASTEQUALQUITDATE        VARCHAR2(30),
  F_INCOMERATIO              VARCHAR2(30),
  F_REDEEMEDBASESHR          VARCHAR2(30),
  D_FIRSTINVESTDATE          VARCHAR2(30)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TSTATICSHARES
prompt ============================
prompt
create table GUZHI.TSTATICSHARES
(
  C_FUNDACCO       VARCHAR2(12),
  C_TRADEACCO      VARCHAR2(24),
  C_FUNDCODE       VARCHAR2(6),
  C_SHARETYPE      CHAR(1),
  C_AGENCYNO       VARCHAR2(9),
  C_NETNO          VARCHAR2(9),
  F_REALSHARES     NUMBER(16,2),
  F_FROZENSHARES   NUMBER(16,2),
  C_BONUSTYPE      CHAR(1),
  D_LASTMODIFY     CHAR(8),
  F_INCOME         NUMBER(16,2),
  F_FROZENINCOME   NUMBER(16,2),
  C_CUSTTYPE       CHAR(1),
  C_SHARECLASS     CHAR(1),
  C_BOURSEFLAG     CHAR(1),
  F_PROTECTBALANCE NUMBER(16,2),
  F_NEWEINCOME     NUMBER(16,2),
  C_INVESTED       CHAR(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TTMP_H_GZB
prompt =========================
prompt
create table GUZHI.TTMP_H_GZB
(
  L_BH        NUMBER(8),
  VC_KMDM     VARCHAR2(400),
  VC_KMMC     VARCHAR2(128),
  L_SL        NUMBER(21,6),
  EN_DWCB     NUMBER(30,6),
  EN_CB       NUMBER(38,10),
  EN_CBZJZ    NUMBER(19,4),
  EN_HQJZ     NUMBER(25,12),
  EN_SZ       NUMBER(38,10),
  EN_SZZJZ    NUMBER(19,4),
  EN_GZZZ     NUMBER(19,4),
  VC_TPXX     VARCHAR2(64),
  VC_QYXX     VARCHAR2(32),
  L_TMPID     NUMBER(8),
  VC_JYS      VARCHAR2(128),
  VC_TZPZ     VARCHAR2(128),
  VC_XJL      VARCHAR2(128),
  VC_TS       VARCHAR2(128),
  EN_FDYKBL   NUMBER(19,4),
  L_LEAF      NUMBER(1),
  VC_KMPARENT VARCHAR2(32),
  L_LEVEL     NUMBER(2),
  L_ZTBH      NUMBER(6),
  D_YWRQ      DATE,
  D_SCSJ      DATE,
  L_QUANTITY  NUMBER(1),
  VC_CODE_HS  VARCHAR2(32),
  L_KIND      NUMBER(2,1),
  L_GZKMBZ    NUMBER(1),
  VC_JSBZ     VARCHAR2(3),
  EN_EXCH     NUMBER(34,20) default 0,
  EN_WBCB     NUMBER(19,4) default 0,
  EN_WBHQ     NUMBER(27,12) default 0,
  EN_WBSZ     NUMBER(19,4) default 0,
  L_ZQNM      NUMBER(8),
  L_SFQR      NUMBER(1) not null,
  L_TZLX      NUMBER(4) default 0,
  EN_ZYJ      NUMBER(19,4) default 0,
  EN_WBZYJ    NUMBER(19,4) default 0,
  VC_CHECKER  VARCHAR2(32),
  VC_BZW      VARCHAR2(16),
  VC_LTLX     VARCHAR2(1),
  EN_YBGZZZ   NUMBER(19,4) default 0,
  VC_ZQDM     VARCHAR2(20),
  L_SCLB      NUMBER(4),
  L_ZQLB      NUMBER(4),
  EN_QYXX     NUMBER(19,14) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 8M
    minextents 1
    maxextents unlimited
  );
create index GUZHI.IDX_TTMP_H_GZB_1 on GUZHI.TTMP_H_GZB (L_ZTBH, D_YWRQ, L_BH)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    minextents 1
    maxextents unlimited
  );
create index GUZHI.IDX_TTMP_H_GZB_2 on GUZHI.TTMP_H_GZB (L_ZTBH, VC_KMDM)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    minextents 1
    maxextents unlimited
  );
create index GUZHI.IDX_TTMP_H_GZB_4 on GUZHI.TTMP_H_GZB (D_YWRQ, L_ZTBH, L_SFQR, D_SCSJ)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table T_BANK_PRODUCT
prompt =============================
prompt
create table GUZHI.T_BANK_PRODUCT
(
  C_FUNDCODE              VARCHAR2(30),
  C_SUBFUNDCODE           VARCHAR2(30),
  C_SUBFUNDNAME           VARCHAR2(30),
  D_BEGINDATE             DATE,
  D_ENDDATE               DATE,
  D_ECONTRACTBEGIN        VARCHAR2(30),
  D_ECONTRACTEND          VARCHAR2(30),
  F_MAXBALA               VARCHAR2(30),
  D_UNIFIEDDATE           DATE,
  F_FACTCOLLECT           VARCHAR2(30),
  C_PROFITDATETYPE        VARCHAR2(30),
  C_STATUS                VARCHAR2(30),
  D_TERMINATEDATE         DATE,
  F_TERMINATEASSET        VARCHAR2(30),
  F_TERMINATESHARE        VARCHAR2(30),
  F_REALSHARES            VARCHAR2(30),
  C_ASSIGNBASEMODE        VARCHAR2(30),
  C_ISCALCINTEREST        VARCHAR2(30),
  L_BEGININTERESTDAYS     VARCHAR2(30),
  D_INTERESTENDDATE       VARCHAR2(30),
  C_ISWEIGHTING           VARCHAR2(30),
  C_INTERESTTYPE          VARCHAR2(30),
  C_YEARDAYSTYPE          VARCHAR2(30),
  C_TERMINATEINCOMEMODE   VARCHAR2(30),
  C_INCOMEBONUSTYPE       VARCHAR2(30),
  F_TOTALPROFIT           VARCHAR2(30),
  C_ISTRANSFERBYOTHERCODE VARCHAR2(30),
  C_TRANSFERCODE          VARCHAR2(30),
  C_SUBPRODTYPE           VARCHAR2(30),
  F_INCOMERATIO           VARCHAR2(30),
  F_NEEDPAYMENT           VARCHAR2(30),
  D_INCOMEENDDATE         VARCHAR2(30),
  C_ISBREAKCONTRACT       VARCHAR2(30),
  L_PUNISHDAYSBREAK       VARCHAR2(30),
  C_ISADVANCETERMINATE    VARCHAR2(30),
  L_PUNISHDAYSADVANCE     VARCHAR2(30),
  C_ISSUEFAILURE          VARCHAR2(30),
  C_MEMO                  VARCHAR2(30),
  C_INTERESTBEGTYPE       VARCHAR2(30),
  D_INTERESTBEGDATE       VARCHAR2(30),
  D_PRECHDATE             VARCHAR2(30),
  D_CHDATE                VARCHAR2(30),
  D_PROFITENDDATE         DATE,
  C_HASSTAGEEXIT          VARCHAR2(30),
  L_SUBFUNDKEY            VARCHAR2(30),
  F_TOTALBONUS            VARCHAR2(30),
  C_ACCUMBONUSFLAG        VARCHAR2(30),
  D_PREINCOMEENDDATE      VARCHAR2(30),
  D_NEXTINCOMEENDDATE     VARCHAR2(30),
  C_FUNDACCO              VARCHAR2(30),
  C_ADVANCEPUNISHMODE     VARCHAR2(30),
  F_ADVANCEPUNISHBALANCE  VARCHAR2(30),
  C_ISINTERESTDISTRIBUTED VARCHAR2(30)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table T_B_LIST
prompt =======================
prompt
create table GUZHI.T_B_LIST
(
  ID       NUMBER not null,
  BUTYPE   VARCHAR2(20),
  VALUE    VARCHAR2(100),
  DATETYPE DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table T_B_LIST_GWD
prompt ===========================
prompt
create table GUZHI.T_B_LIST_GWD
(
  ID       NUMBER not null,
  BUTYPE   VARCHAR2(20),
  VALUE    VARCHAR2(100),
  DATETYPE DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table T_IM_DATA_MIGRATION
prompt ==================================
prompt
create table GUZHI.T_IM_DATA_MIGRATION
(
  SOURCE        INTEGER,
  FSETID        VARCHAR2(50) not null,
  FSETCODE      INTEGER,
  FSETNAME      VARCHAR2(200),
  VERSION       VARCHAR2(10),
  OPERATER_ROLE VARCHAR2(10),
  USERNAME      VARCHAR2(20),
  UPDATE_TIME   DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table T_VALU_DATA_MIGRATION
prompt ====================================
prompt
create table GUZHI.T_VALU_DATA_MIGRATION
(
  FSETID        VARCHAR2(50) not null,
  FSETCODE      INTEGER,
  VERSION       VARCHAR2(10),
  OPERATER_ROLE VARCHAR2(10),
  USERNAME      VARCHAR2(20),
  UPDATE_TIME   DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USERACCOUNTMAP
prompt =============================
prompt
create table GUZHI.USERACCOUNTMAP
(
  ID          NUMBER,
  USERINFO_ID NUMBER,
  ZTTYPE      VARCHAR2(10),
  TEMP        VARCHAR2(10),
  ZTSTATUS    VARCHAR2(10),
  ZTGROUP     VARCHAR2(10),
  ZTH         VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    minextents 1
    maxextents unlimited
  );
comment on column GUZHI.USERACCOUNTMAP.ZTTYPE
  is '状套类型';
comment on column GUZHI.USERACCOUNTMAP.ZTSTATUS
  is '账套状态';
comment on column GUZHI.USERACCOUNTMAP.ZTGROUP
  is '账套组 1托管 2外包';

prompt
prompt Creating table USER_ID
prompt ======================
prompt
create table GUZHI.USER_ID
(
  CUST_ID   VARCHAR2(20),
  CERTICATE VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_CASHACCOUNT
prompt =============================
prompt
create table GUZHI.VB_CASHACCOUNT
(
  C_PORT_CODE   VARCHAR2(30),
  C_CA_CODE     VARCHAR2(50) not null,
  C_CA_NAME     VARCHAR2(50) not null,
  C_CA_PAYNO    VARCHAR2(50),
  C_CA_NUMBER   VARCHAR2(100),
  C_CA_OPENADDR VARCHAR2(100),
  C_CA_TYPE     VARCHAR2(20) not null,
  C_CURY_CODE   VARCHAR2(20) not null,
  C_ORG_CODE    CHAR(1),
  C_CA_ATTR     CHAR(2),
  D_OPEN        DATE,
  D_CLOSE       DATE,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_CASHACCOUNT_ZHAO11111
prompt =======================================
prompt
create table GUZHI.VB_CASHACCOUNT_ZHAO11111
(
  C_PORT_CODE   VARCHAR2(30),
  C_CA_CODE     VARCHAR2(50) not null,
  C_CA_NAME     VARCHAR2(50) not null,
  C_CA_PAYNO    VARCHAR2(50),
  C_CA_NUMBER   VARCHAR2(100),
  C_CA_OPENADDR VARCHAR2(100),
  C_CA_TYPE     VARCHAR2(20) not null,
  C_CURY_CODE   VARCHAR2(20) not null,
  C_ORG_CODE    CHAR(1),
  C_CA_ATTR     CHAR(2),
  D_OPEN        DATE,
  D_CLOSE       DATE,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_HOLIDAY
prompt =========================
prompt
create table GUZHI.VB_HOLIDAY
(
  C_HDAY_TYPE CHAR(2),
  C_HDAY_CODE VARCHAR2(20) not null,
  D_DATE      DATE not null,
  C_DAY_TYPE  NUMBER,
  N_YEAR      NUMBER,
  C_TIMESTAMP VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_ORGINFO
prompt =========================
prompt
create table GUZHI.VB_ORGINFO
(
  C_ORG_CODE           VARCHAR2(20) not null,
  C_ORG_NAME           VARCHAR2(200) not null,
  C_ORG_NAME_ST        VARCHAR2(50),
  C_ORG_NAME_EN        VARCHAR2(50),
  C_ORG_TYPE           VARCHAR2(20) not null,
  C_ORG_PARENT         VARCHAR2(20),
  C_CURY_CODE          VARCHAR2(20),
  N_REG_CAPITAL        NUMBER,
  N_CORP_REPR          VARCHAR2(20),
  C_REG_ADDR           VARCHAR2(50),
  C_OFFIC_ADDR         VARCHAR2(200),
  D_FOUND_TIME         DATE,
  C_WWW_ADDR           VARCHAR2(50),
  C_FAX_TEL            VARCHAR2(20),
  C_POST_CODE          VARCHAR2(50),
  C_LINK_MAN           VARCHAR2(50),
  C_LINK_TEL           VARCHAR2(50),
  C_MO_TEL             VARCHAR2(100),
  C_EMAIL              VARCHAR2(100),
  C_ORG_ATTR           VARCHAR2(20),
  C_DV_MANAGER         VARCHAR2(20),
  C_DV_TRUSTEE         VARCHAR2(20),
  C_DV_TRUSTEE_SEC     VARCHAR2(20),
  C_DV_WARRANTOR       VARCHAR2(20),
  C_DV_INVEST_ADVISER  VARCHAR2(20),
  C_DV_TRUSTEE_XT      VARCHAR2(20),
  C_DV_SALES_CHANNELS  VARCHAR2(20),
  C_DV_CLEARING_MEMBER VARCHAR2(20),
  C_DV_CONSIGNER       VARCHAR2(20),
  C_TIMESTAMP          VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_ORGINFO_20161104
prompt ==================================
prompt
create table GUZHI.VB_ORGINFO_20161104
(
  C_ORG_CODE           VARCHAR2(20) not null,
  C_ORG_NAME           VARCHAR2(200) not null,
  C_ORG_NAME_ST        VARCHAR2(50),
  C_ORG_NAME_EN        VARCHAR2(50),
  C_ORG_TYPE           VARCHAR2(20) not null,
  C_ORG_PARENT         VARCHAR2(20),
  C_CURY_CODE          VARCHAR2(20),
  N_REG_CAPITAL        NUMBER,
  N_CORP_REPR          VARCHAR2(20),
  C_REG_ADDR           VARCHAR2(50),
  C_OFFIC_ADDR         VARCHAR2(200),
  D_FOUND_TIME         DATE,
  C_WWW_ADDR           VARCHAR2(50),
  C_FAX_TEL            VARCHAR2(20),
  C_POST_CODE          VARCHAR2(50),
  C_LINK_MAN           VARCHAR2(50),
  C_LINK_TEL           VARCHAR2(50),
  C_MO_TEL             VARCHAR2(100),
  C_EMAIL              VARCHAR2(100),
  C_ORG_ATTR           VARCHAR2(20),
  C_DV_MANAGER         VARCHAR2(20),
  C_DV_TRUSTEE         VARCHAR2(20),
  C_DV_TRUSTEE_SEC     VARCHAR2(20),
  C_DV_WARRANTOR       VARCHAR2(20),
  C_DV_INVEST_ADVISER  VARCHAR2(20),
  C_DV_TRUSTEE_XT      VARCHAR2(20),
  C_DV_SALES_CHANNELS  VARCHAR2(20),
  C_DV_CLEARING_MEMBER VARCHAR2(20),
  C_DV_CONSIGNER       VARCHAR2(20),
  C_TIMESTAMP          VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_PORT_BASEINFO
prompt ===============================
prompt
create table GUZHI.VB_PORT_BASEINFO
(
  C_PORT_CODE       VARCHAR2(20),
  C_PORT_NAME       VARCHAR2(50),
  C_ASSET_CODE      VARCHAR2(50),
  C_PORT_NAME_ST    VARCHAR2(50),
  C_PORT_NAME_EN    VARCHAR2(50),
  C_PORT_TYPE       VARCHAR2(50),
  C_PORT_LEVEL      VARCHAR2(50),
  C_PORT_KIND       VARCHAR2(50),
  C_PORT_SUBKIND    VARCHAR2(50),
  C_INVT_QUS        VARCHAR2(50),
  C_INVT_MKT        VARCHAR2(50),
  C_PORT_STYLE      VARCHAR2(50),
  C_PORT_STYLE_XBRL VARCHAR2(50),
  C_PORT_CURY       VARCHAR2(50),
  N_SALES_FACTOR    NUMBER,
  C_CAPL_SOURCE     VARCHAR2(50),
  N_INITAMT         NUMBER,
  N_INITSHARE       NUMBER,
  C_HDAY_CODE       VARCHAR2(50),
  D_ESTABLISH       DATE,
  D_TOLIST          DATE,
  D_DUE             DATE,
  C_PORT_CODE_P     VARCHAR2(50),
  C_TIMESTAMP       VARCHAR2(50),
  D_ESTABLISH_FACT  VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_PORT_CLS_BASEINFO_20161104
prompt ============================================
prompt
create table GUZHI.VB_PORT_CLS_BASEINFO_20161104
(
  C_PORT_CODE         VARCHAR2(20) not null,
  C_PORT_CLS_CODE     VARCHAR2(20) not null,
  C_PORT_CLS_NAME     VARCHAR2(100) not null,
  C_DV_PORT_CLS       VARCHAR2(20) not null,
  C_PORT_CLS_CODE_P   VARCHAR2(20),
  C_DV_PORT_CLS_TYPE  VARCHAR2(20) not null,
  C_DV_PORT_CLS_LEVEL VARCHAR2(20) not null,
  C_DC_CODE           VARCHAR2(20) not null,
  D_ESTABLISH         DATE not null,
  D_DUE               DATE not null,
  N_YEAR_INCOME       NUMBER(30,15),
  C_ALGO_CODE_I       VARCHAR2(20),
  C_INCOME_TYPE       VARCHAR2(20),
  C_DESC              VARCHAR2(200),
  C_TIMESTAMP         VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_PORT_INVEFEE_20161104
prompt =======================================
prompt
create table GUZHI.VB_PORT_INVEFEE_20161104
(
  N_ID         VARCHAR2(30),
  C_PORT_CODE  VARCHAR2(20) not null,
  C_PORT_CLASS VARCHAR2(20) not null,
  C_FEE_CODE   VARCHAR2(20) not null,
  C_CURY_CODE  VARCHAR2(20) not null,
  N_FEE_RATE   VARCHAR2(200),
  D_BEGIN      DATE not null,
  D_END        DATE not null,
  C_TIMESTAMP  VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_PORT_ORGROLE
prompt ==============================
prompt
create table GUZHI.VB_PORT_ORGROLE
(
  C_PORT_CODE  VARCHAR2(20) not null,
  C_ORG_ROLE   VARCHAR2(20) not null,
  C_ORG_TYPE   VARCHAR2(20) not null,
  C_ORG_CODE   VARCHAR2(20) not null,
  C_MAIN_LEVEL CHAR(1),
  D_BEGIN      DATE,
  D_END        DATE,
  C_TIMESTAMP  VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_PORT_ORGROLE_20161104
prompt =======================================
prompt
create table GUZHI.VB_PORT_ORGROLE_20161104
(
  C_PORT_CODE  VARCHAR2(20) not null,
  C_ORG_ROLE   VARCHAR2(20) not null,
  C_ORG_TYPE   VARCHAR2(20) not null,
  C_ORG_CODE   VARCHAR2(20) not null,
  C_MAIN_LEVEL CHAR(1),
  D_BEGIN      DATE,
  D_END        DATE,
  C_TIMESTAMP  VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_SECURITY_111
prompt ==============================
prompt
create table GUZHI.VB_SECURITY_111
(
  C_CODE_SOURE     CHAR(3),
  C_SEC_CODE       VARCHAR2(50) not null,
  C_SEC_NAME       VARCHAR2(50) not null,
  C_SEC_NAME_CN    VARCHAR2(50),
  C_SEDEL_CODE     CHAR(2),
  C_MKT_CODE       VARCHAR2(20) not null,
  C_ISIN_CODE      VARCHAR2(20),
  C_SECMKT_CODE    VARCHAR2(30) not null,
  C_SEC_VAR        VARCHAR2(40),
  C_SEC_VAR_MX     VARCHAR2(20) not null,
  C_CURY_CODE      VARCHAR2(20) not null,
  N_PRICE_FCR      NUMBER(18,4) not null,
  C_GUARANTEE_LOGO VARCHAR2(50),
  C_BATCH_RELEASE  VARCHAR2(20),
  N_FV_ISSUE       NUMBER(18,4) not null,
  C_DV_QUT_MOD     VARCHAR2(20),
  C_SEC_CODE_TRG   VARCHAR2(50),
  N_FV_IR          NUMBER(15,8),
  N_PRICE_ISSUE    NUMBER(15,8),
  N_SETT_PRICES    NUMBER(30,15),
  N_EXER_PRICES    NUMBER(15,8),
  C_DV_VAR_DUR     VARCHAR2(20),
  C_OI_EXPR        VARCHAR2(20),
  C_PI_EXPR        VARCHAR2(20),
  D_AI_BEGIN       DATE,
  D_AI_END         DATE,
  D_EX_BEGIN       DATE,
  D_EX_END         DATE,
  D_LISTED_DATE    DATE not null,
  D_OM_DATE        DATE not null,
  C_CREDIT_RATING  VARCHAR2(20),
  C_DV_AI_MOD      VARCHAR2(20),
  C_DV_PI_FREQ     VARCHAR2(20),
  C_ORG_CODE       VARCHAR2(20),
  N_AMOUNT_HD      NUMBER(18,4) not null,
  C_TIMESTAMP      VARCHAR2(17)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 512K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VB_TD_MODE
prompt =========================
prompt
create table GUZHI.VB_TD_MODE
(
  C_DT_CODE   VARCHAR2(20) not null,
  C_DT_NAME   VARCHAR2(50) not null,
  C_BUSI_TYPE VARCHAR2(20) not null,
  N_FUND_WAY  NUMBER(3) not null,
  N_CAPI_WAY  NUMBER(3) not null,
  N_ORDER     NUMBER(3) not null,
  C_TIMESTAMP VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VC_CASHACCOUNT_20161107
prompt ======================================
prompt
create table GUZHI.VC_CASHACCOUNT_20161107
(
  D_BIZ       DATE not null,
  C_PORT_CODE VARCHAR2(20) not null,
  C_CA_CODE   VARCHAR2(50) not null,
  C_CURY_CODE VARCHAR2(20),
  N_CPT_DIR   NUMBER(3) not null,
  C_CHG_TYPE  VARCHAR2(20) not null,
  N_CHGMONEY  NUMBER(18,4) not null,
  N_MONEY_L   NUMBER(18,4) not null,
  C_TD_NUMBER CHAR(1),
  C_TIMESTAMP VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VC_EQUITY_20161104
prompt =================================
prompt
create table GUZHI.VC_EQUITY_20161104
(
  C_PORT_CODE     VARCHAR2(20) not null,
  C_PORT_CLASS    VARCHAR2(20),
  D_BIZ           DATE not null,
  C_DS_CODE       VARCHAR2(20) not null,
  N_TD_AMOUNT     NUMBER(18,4) not null,
  N_TD_MONEY      NUMBER(18,4) not null,
  N_UNIT_MONEY_PT NUMBER(30,15) not null,
  N_UNIT_MONEY_AT NUMBER(30,15) not null,
  C_DESC          VARCHAR2(200),
  C_TIMESTAMP     VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VC_FUNDS_20161104
prompt ================================
prompt
create table GUZHI.VC_FUNDS_20161104
(
  N_ID          VARCHAR2(30),
  N_ID_SUB      VARCHAR2(30),
  D_BIZ         DATE,
  C_PORT_CODE   VARCHAR2(20),
  C_SEC_CODE    VARCHAR2(50),
  C_CURY_CODE   VARCHAR2(20),
  D_TRADE_DATE  DATE,
  C_TD_NUMBER   VARCHAR2(50),
  C_OD_NUMBER   VARCHAR2(50),
  C_MKT_CODE    VARCHAR2(20),
  C_TD_PLAT     VARCHAR2(20),
  C_TDCHAN_CODE VARCHAR2(20),
  C_TD_CODE     VARCHAR2(20),
  C_IM_CODE     CHAR(1),
  C_TD_TYPE     VARCHAR2(50),
  C_IVT_CLSS    VARCHAR2(20),
  C_HLD_ATTR    CHAR(1),
  C_TD_ATTR     VARCHAR2(20),
  C_ML_ATTR     VARCHAR2(2),
  N_TD_AMOUNT   NUMBER(18,4),
  N_TD_PRICE    NUMBER(30,15),
  N_TD_MONEY    NUMBER(18,4),
  N_TD_INCOME   NUMBER(18,4),
  N_STTLE_MONEY NUMBER(18,4),
  D_SETTLE      DATE,
  C_CA_CODE     VARCHAR2(50),
  N_TD_YHS      NUMBER,
  N_TD_JSF      NUMBER,
  N_TD_GHF      NUMBER,
  N_TD_ZGF      NUMBER,
  N_TD_JSFWF    NUMBER,
  N_TD_FEE      NUMBER,
  N_STFXJ       NUMBER,
  N_TD_COMM     NUMBER,
  N_BK_HHF      NUMBER,
  N_RGF         NUMBER,
  N_SGF         NUMBER,
  N_SHF         NUMBER,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VF_REPORT_VAL
prompt ============================
prompt
create table GUZHI.VF_REPORT_VAL
(
  N_ID          INTEGER,
  C_SUBJ_CODE   VARCHAR2(50),
  C_SUBJ_NAME   VARCHAR2(50),
  D_BIZ         DATE,
  N_LEVEL       NUMBER(3),
  C_PORT_CODE   VARCHAR2(20),
  N_HLDMKV_LOCL NUMBER(18,4),
  N_HLDCST_LOCL NUMBER(18,4),
  N_HLDAMT      NUMBER(18,4),
  N_HLDVVA_L    NUMBER(18,4),
  C_TIMESTAMP   VARCHAR2(50),
  C_PORT_CLASS  VARCHAR2(50),
  C_KEY_CODE    VARCHAR2(50),
  C_KEY_NAME    VARCHAR2(50),
  C_CURY_CODE   VARCHAR2(50),
  C_PA_CODE     VARCHAR2(50),
  C_MKT_CODE    VARCHAR2(50),
  C_TD_ATTR     VARCHAR2(50),
  C_IVT_CLSS    VARCHAR2(50),
  C_HLD_ATTR    VARCHAR2(50),
  C_ML_ATTR     VARCHAR2(50),
  C_TDCHAN_CODE VARCHAR2(50),
  C_SEC_CODE    VARCHAR2(50),
  C_CA_CODE     VARCHAR2(50),
  C_FEE_CODE    VARCHAR2(50),
  C_DS_CODE     VARCHAR2(50),
  N_HLDCST      NUMBER(18,4),
  N_HLDMKV      NUMBER(18,4),
  N_HLDVVA      NUMBER(18,4),
  C_SUBPEND     VARCHAR2(50),
  C_RIGHTS      VARCHAR2(50),
  N_VALPRICE    NUMBER(18,4),
  N_VALRATE     NUMBER(18,4),
  N_WAY         VARCHAR2(50),
  C_SUBJ_CODE_T VARCHAR2(50),
  C_NAV_TYPE    VARCHAR2(50),
  C_DV_KM_CLS   VARCHAR2(50),
  N_ORDER1      NUMBER(18,4),
  C_SEC_VAR_MX  VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4M
    minextents 1
    maxextents unlimited
  );
comment on column GUZHI.VF_REPORT_VAL.C_SUBJ_CODE
  is '科目代码';
comment on column GUZHI.VF_REPORT_VAL.C_SUBJ_NAME
  is '科目名称';
comment on column GUZHI.VF_REPORT_VAL.D_BIZ
  is '业务日期';
comment on column GUZHI.VF_REPORT_VAL.N_LEVEL
  is '科目层级';
comment on column GUZHI.VF_REPORT_VAL.C_PORT_CODE
  is '帐套号--基金代码';
comment on column GUZHI.VF_REPORT_VAL.N_HLDMKV_LOCL
  is '本币持仓市值';
comment on column GUZHI.VF_REPORT_VAL.N_HLDCST_LOCL
  is '本币持仓成本';
comment on column GUZHI.VF_REPORT_VAL.N_HLDAMT
  is '持仓数量';
comment on column GUZHI.VF_REPORT_VAL.N_HLDVVA_L
  is '本币证券估值';

prompt
prompt Creating table VF_SUBJECTBALANCE
prompt ================================
prompt
create table GUZHI.VF_SUBJECTBALANCE
(
  N_ID          VARCHAR2(20),
  D_HOLD        DATE,
  C_PORT_CODE   VARCHAR2(40),
  C_PORT_CLASS  VARCHAR2(40),
  C_SUBJ_CODE   VARCHAR2(40),
  C_CURY_CODE   VARCHAR2(40),
  C_PA_CODE     VARCHAR2(20),
  C_TDCHAN_CODE VARCHAR2(40),
  C_IVT_CLSS    VARCHAR2(40),
  C_HLD_ATTR    VARCHAR2(20),
  C_TD_ATTR     VARCHAR2(20),
  C_ML_ATTR     VARCHAR2(20),
  C_SEC_CODE    VARCHAR2(20),
  C_CA_CODE     VARCHAR2(20),
  C_PI_CODE     VARCHAR2(20),
  C_DS_CODE     VARCHAR2(20),
  N_HLDAMT      NUMBER,
  N_HLDMNY      NUMBER,
  N_HLDMNY_L    NUMBER,
  N_WAY         INTEGER,
  C_SUBJ_CODE_T VARCHAR2(40),
  C_TIMESTAMP   VARCHAR2(40)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VF_SUBJECTINFO
prompt =============================
prompt
create table GUZHI.VF_SUBJECTINFO
(
  N_YEAR            VARCHAR2(4),
  C_PORT_CODE       VARCHAR2(20) not null,
  C_SUBJ_CODE       VARCHAR2(200) not null,
  C_SUBJ_NAME       VARCHAR2(200) not null,
  C_SUBJ_TYPE       VARCHAR2(20) not null,
  C_PA_CODE         VARCHAR2(20) not null,
  C_CURY_CODE       VARCHAR2(20) not null,
  C_SUBJ_CODE_P     VARCHAR2(200) not null,
  C_MKT_CODE        VARCHAR2(20) not null,
  C_SEC_VAR         VARCHAR2(40),
  C_SEC_VAR_MX      VARCHAR2(20) not null,
  C_IVT_CLSS        VARCHAR2(20) not null,
  C_HLD_ATTR        CHAR(1),
  C_TD_ATTR         VARCHAR2(20) not null,
  C_ML_ATTR         VARCHAR2(20) not null,
  C_SEC_CODE        VARCHAR2(50) not null,
  C_CA_CODE         VARCHAR2(50) not null,
  C_PI_CODE         VARCHAR2(20) not null,
  N_SUBJ_DETAIL     NUMBER(3) not null,
  C_DV_BOOL_TYPE_AM VARCHAR2(20) not null,
  C_DV_JD_WAY       VARCHAR2(20) not null,
  C_DS_CODE         VARCHAR2(20) not null,
  C_TIMESTAMP       VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VF_VOUCHERDETAIL
prompt ===============================
prompt
create table GUZHI.VF_VOUCHERDETAIL
(
  N_ID            VARCHAR2(20) not null,
  D_BIZ           DATE not null,
  C_PORT_CODE     VARCHAR2(20) not null,
  C_PORT_CLASS    VARCHAR2(20) not null,
  C_SUBJ_CODE     VARCHAR2(200),
  C_CURY_CODE     VARCHAR2(20) not null,
  C_VCH_NUM       NUMBER(10) not null,
  C_VCH_NUM_SUN   NUMBER(5) not null,
  C_PA_CODE       VARCHAR2(20) not null,
  C_TDCHAN_CODE   VARCHAR2(20) not null,
  C_DV_KM_CLS     VARCHAR2(20),
  N_WAY           NUMBER(3) not null,
  C_IVT_CLSS      VARCHAR2(20) not null,
  C_HLD_ATTR      CHAR(1),
  C_TD_ATTR       VARCHAR2(20) not null,
  C_ML_ATTR       VARCHAR2(20) not null,
  C_SEC_CODE      VARCHAR2(50) not null,
  C_CA_CODE       VARCHAR2(50) not null,
  C_PI_CODE       VARCHAR2(20) not null,
  N_TD_AMOUNT     NUMBER(18,4) not null,
  N_MONEY         NUMBER(18,4) not null,
  N_MONEY_L       NUMBER(18,4) not null,
  C_VCH_DESC      VARCHAR2(200),
  C_DVA_ITEM_CODE VARCHAR2(20) not null,
  C_DT_CODE       VARCHAR2(20) not null,
  C_TD_RELA       CHAR(1),
  C_SUBJ_CODE_T   VARCHAR2(200),
  C_DATA_IDF      VARCHAR2(10) not null,
  D_TRADE         DATE not null,
  C_CREATE_BY     VARCHAR2(20) not null,
  C_CREATE_TIME   VARCHAR2(20) not null,
  C_CHECK_BY      VARCHAR2(20),
  C_UPDATE_BY     VARCHAR2(20),
  C_UPDATE_TIME   VARCHAR2(20),
  C_SEC_VAR_MX    VARCHAR2(20) not null,
  C_MKT_CODE      VARCHAR2(20) not null,
  C_DS_CODE       VARCHAR2(20) not null,
  C_TIMESTAMP     VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VH_ARAPBALANCE_20161104
prompt ======================================
prompt
create table GUZHI.VH_ARAPBALANCE_20161104
(
  C_PORT_CODE VARCHAR2(20) not null,
  D_HOLD      DATE,
  C_PA_CODE   VARCHAR2(20) not null,
  C_CURY_CODE VARCHAR2(20) not null,
  N_HLDMNY    NUMBER(18,4) not null,
  N_HLDMNY_L  NUMBER(18,4) not null,
  N_VALRATE   NUMBER,
  C_TIMESTAMP VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VN_FINANCIAL_VAL
prompt ===============================
prompt
create table GUZHI.VN_FINANCIAL_VAL
(
  N_ID          VARCHAR2(20) not null,
  D_BIZ         DATE not null,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(400),
  C_SUBJ_CODE   VARCHAR2(200),
  C_SUBJ_NAME   VARCHAR2(200) not null,
  C_CURY_CODE   VARCHAR2(20) not null,
  C_PA_CODE     VARCHAR2(20) not null,
  C_MKT_CODE    VARCHAR2(20) not null,
  C_TD_ATTR     VARCHAR2(20) not null,
  C_IVT_CLSS    VARCHAR2(20) not null,
  C_HLD_ATTR    CHAR(1),
  C_ML_ATTR     VARCHAR2(20) not null,
  C_TDCHAN_CODE VARCHAR2(20) not null,
  C_SEC_CODE    VARCHAR2(50) not null,
  C_CA_CODE     VARCHAR2(50) not null,
  C_FEE_CODE    VARCHAR2(20) not null,
  N_HLDAMT      NUMBER(18,4) not null,
  N_HLDCST      NUMBER,
  N_HLDCST_LOCL NUMBER,
  N_HLDMKV      NUMBER,
  N_HLDMKV_LOCL NUMBER,
  N_HLDVVA      NUMBER(18,4) not null,
  N_HLDVVA_L    NUMBER(18,4) not null,
  C_SEC_VAR_MX  VARCHAR2(20) not null,
  N_CB_JZ_BL    NUMBER,
  N_SZ_JZ_BL    NUMBER,
  C_SUBPEND     VARCHAR2(200),
  C_RIGHTS      VARCHAR2(200),
  N_VALPRICE    NUMBER(30,15) not null,
  N_VALRATE     NUMBER(30,15) not null,
  N_WAY         NUMBER(3) not null,
  C_SUBJ_CODE_T VARCHAR2(200),
  C_DV_KM_CLS   VARCHAR2(20) not null,
  C_UPDATE_TIME VARCHAR2(200),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VN_FINANCIAL_VAL_BF_20161104
prompt ===========================================
prompt
create table GUZHI.VN_FINANCIAL_VAL_BF_20161104
(
  N_ID          NUMBER,
  D_BIZ         DATE,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_NAME   VARCHAR2(200) not null,
  N_ZR_NAVA     VARCHAR2(200),
  N_JR_NAVA     VARCHAR2(200),
  N_JR_SXSY_KFP VARCHAR2(200),
  N_JR_SSZB     NUMBER(18,4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VN_PORT_INDEX
prompt ============================
prompt
create table GUZHI.VN_PORT_INDEX
(
  N_ID          VARCHAR2(20) not null,
  D_BIZ         DATE not null,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(400),
  C_IDX_CODE    VARCHAR2(50) not null,
  C_CURY_CODE   VARCHAR2(20),
  N_HLDAMT      NUMBER(18,4) not null,
  N_HLDCST      NUMBER,
  N_HLDCST_LOCL NUMBER,
  N_HLDMKV      NUMBER,
  N_HLDMKV_LOCL NUMBER,
  N_HLDVVA      NUMBER,
  N_HLDVVA_L    NUMBER,
  FCB_JZ_BL     NUMBER,
  FSZ_JZ_BL     NUMBER,
  C_KM_NAME     VARCHAR2(200) not null,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VN_PORT_INDEX_20161104
prompt =====================================
prompt
create table GUZHI.VN_PORT_INDEX_20161104
(
  N_ID          VARCHAR2(20) not null,
  D_BIZ         DATE not null,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(400),
  C_IDX_CODE    VARCHAR2(50) not null,
  C_CURY_CODE   VARCHAR2(20),
  N_HLDAMT      NUMBER(18,4) not null,
  N_HLDCST      NUMBER,
  N_HLDCST_LOCL NUMBER,
  N_HLDMKV      NUMBER,
  N_HLDMKV_LOCL NUMBER,
  N_HLDVVA      NUMBER,
  N_HLDVVA_L    NUMBER,
  FCB_JZ_BL     NUMBER,
  FSZ_JZ_BL     NUMBER,
  C_KM_NAME     VARCHAR2(200) not null,
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VS_PORT_SELL
prompt ===========================
prompt
create table GUZHI.VS_PORT_SELL
(
  D_BIZ         DATE not null,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(20),
  C_TD_NUMBER   VARCHAR2(50),
  C_OD_NUMBER   VARCHAR2(50),
  C_DS_CODE     VARCHAR2(20) not null,
  C_SEC_CODE    CHAR(1),
  N_TD_AMOUNT   NUMBER(18,4) not null,
  C_CURY_CODE   VARCHAR2(20) not null,
  D_TRADE_DATE  DATE not null,
  N_ST_MONEY    NUMBER(18,4) not null,
  D_SETTLE      DATE not null,
  C_CA_CODE     VARCHAR2(50) not null,
  N_TD_MONEY    NUMBER(18,4) not null,
  N_TD_INCOME   NUMBER,
  N_TD_FEE      NUMBER,
  N_TD_GZC_FEE  NUMBER,
  N_TD_HD_FEE   NUMBER,
  C_SEC_CODE_OT CHAR(1),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_20161108_VF_SUBJECTBALANCE
prompt ============================================
prompt
create table GUZHI.WU_20161108_VF_SUBJECTBALANCE
(
  N_ID          VARCHAR2(20) not null,
  D_HOLD        DATE,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(20) not null,
  C_SUBJ_CODE   VARCHAR2(200),
  C_CURY_CODE   VARCHAR2(20),
  C_PA_CODE     VARCHAR2(20) not null,
  C_TDCHAN_CODE VARCHAR2(20) not null,
  C_IVT_CLSS    VARCHAR2(20) not null,
  C_HLD_ATTR    CHAR(1),
  C_TD_ATTR     VARCHAR2(20) not null,
  C_ML_ATTR     VARCHAR2(20) not null,
  C_SEC_CODE    VARCHAR2(50) not null,
  C_CA_CODE     VARCHAR2(50) not null,
  C_PI_CODE     VARCHAR2(20) not null,
  C_DS_CODE     VARCHAR2(20) not null,
  N_HLDAMT      NUMBER(18,4) not null,
  N_HLDMNY      NUMBER,
  N_HLDMNY_L    NUMBER,
  N_WAY         NUMBER(3),
  C_SUBJ_CODE_T VARCHAR2(200),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_20161108_VF_SUBJECTINFO
prompt =========================================
prompt
create table GUZHI.WU_20161108_VF_SUBJECTINFO
(
  N_YEAR            VARCHAR2(4),
  C_PORT_CODE       VARCHAR2(20) not null,
  C_SUBJ_CODE       VARCHAR2(200) not null,
  C_SUBJ_NAME       VARCHAR2(200) not null,
  C_SUBJ_TYPE       VARCHAR2(20) not null,
  C_PA_CODE         VARCHAR2(20) not null,
  C_CURY_CODE       VARCHAR2(20) not null,
  C_SUBJ_CODE_P     VARCHAR2(200) not null,
  C_MKT_CODE        VARCHAR2(20) not null,
  C_SEC_VAR         VARCHAR2(40),
  C_SEC_VAR_MX      VARCHAR2(20) not null,
  C_IVT_CLSS        VARCHAR2(20) not null,
  C_HLD_ATTR        CHAR(1),
  C_TD_ATTR         VARCHAR2(20) not null,
  C_ML_ATTR         VARCHAR2(20) not null,
  C_SEC_CODE        VARCHAR2(50) not null,
  C_CA_CODE         VARCHAR2(50) not null,
  C_PI_CODE         VARCHAR2(20) not null,
  N_SUBJ_DETAIL     NUMBER(3) not null,
  C_DV_BOOL_TYPE_AM VARCHAR2(20) not null,
  C_DV_JD_WAY       VARCHAR2(20) not null,
  C_DS_CODE         VARCHAR2(20) not null,
  C_TIMESTAMP       VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_20161108_VN_FINANCIAL_VAL
prompt ===========================================
prompt
create table GUZHI.WU_20161108_VN_FINANCIAL_VAL
(
  N_ID          VARCHAR2(20) not null,
  D_BIZ         DATE not null,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(400),
  C_SUBJ_CODE   VARCHAR2(200),
  C_SUBJ_NAME   VARCHAR2(200) not null,
  C_CURY_CODE   VARCHAR2(20) not null,
  C_PA_CODE     VARCHAR2(20) not null,
  C_MKT_CODE    VARCHAR2(20) not null,
  C_TD_ATTR     VARCHAR2(20) not null,
  C_IVT_CLSS    VARCHAR2(20) not null,
  C_HLD_ATTR    CHAR(1),
  C_ML_ATTR     VARCHAR2(20) not null,
  C_TDCHAN_CODE VARCHAR2(20) not null,
  C_SEC_CODE    VARCHAR2(50) not null,
  C_CA_CODE     VARCHAR2(50) not null,
  C_FEE_CODE    VARCHAR2(20) not null,
  N_HLDAMT      NUMBER(18,4) not null,
  N_HLDCST      NUMBER,
  N_HLDCST_LOCL NUMBER,
  N_HLDMKV      NUMBER,
  N_HLDMKV_LOCL NUMBER,
  N_HLDVVA      NUMBER(18,4) not null,
  N_HLDVVA_L    NUMBER(18,4) not null,
  C_SEC_VAR_MX  VARCHAR2(20) not null,
  N_CB_JZ_BL    NUMBER,
  N_SZ_JZ_BL    NUMBER,
  C_SUBPEND     VARCHAR2(200),
  C_RIGHTS      VARCHAR2(200),
  N_VALPRICE    NUMBER(30,15) not null,
  N_VALRATE     NUMBER(30,15) not null,
  N_WAY         NUMBER(3) not null,
  C_SUBJ_CODE_T VARCHAR2(200),
  C_DV_KM_CLS   VARCHAR2(20) not null,
  C_UPDATE_TIME VARCHAR2(200),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_T_S_DA_SEC_VAR
prompt ================================
prompt
create table GUZHI.WU_T_S_DA_SEC_VAR
(
  C_IDEN         VARCHAR2(30) not null,
  C_SEC_VAR_CODE VARCHAR2(20) not null,
  C_SEC_VAR_NAME VARCHAR2(50) not null,
  C_DA_CODE      VARCHAR2(20) not null,
  C_DA_CODE_P    VARCHAR2(20) not null,
  N_ORDER        NUMBER(5),
  C_DV_STATE     VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_VB_CASHACCOUNTMAIN
prompt ====================================
prompt
create table GUZHI.WU_VB_CASHACCOUNTMAIN
(
  N_ID        VARCHAR2(30) not null,
  C_CA_CODE   VARCHAR2(50) not null,
  C_CA_NAME   VARCHAR2(50) not null,
  C_CA_TYPE   VARCHAR2(20) not null,
  C_CURY_CODE VARCHAR2(20) not null,
  C_CA_ATTR   CHAR(2),
  C_TIMESTAMP VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_VB_CASHACCOUNTMAIN_20161111
prompt =============================================
prompt
create table GUZHI.WU_VB_CASHACCOUNTMAIN_20161111
(
  N_ID        VARCHAR2(30) not null,
  C_CA_CODE   VARCHAR2(50) not null,
  C_CA_NAME   VARCHAR2(50) not null,
  C_CA_TYPE   VARCHAR2(20) not null,
  C_CURY_CODE VARCHAR2(20) not null,
  C_CA_ATTR   CHAR(2),
  C_TIMESTAMP VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_VF_REPORT_VAL
prompt ===============================
prompt
create table GUZHI.WU_VF_REPORT_VAL
(
  N_ID          VARCHAR2(20),
  D_BIZ         DATE,
  C_PORT_CODE   VARCHAR2(20),
  C_PORT_CLASS  VARCHAR2(400),
  C_SUBJ_CODE   VARCHAR2(200),
  C_SUBJ_NAME   VARCHAR2(200),
  C_KEY_CODE    VARCHAR2(50),
  C_KEY_NAME    VARCHAR2(200),
  C_CURY_CODE   VARCHAR2(20),
  C_PA_CODE     VARCHAR2(20),
  C_MKT_CODE    VARCHAR2(20),
  C_TD_ATTR     VARCHAR2(20),
  C_IVT_CLSS    VARCHAR2(20),
  C_HLD_ATTR    CHAR(1),
  C_ML_ATTR     VARCHAR2(20),
  C_TDCHAN_CODE VARCHAR2(20),
  C_SEC_CODE    VARCHAR2(50),
  C_CA_CODE     VARCHAR2(50),
  C_FEE_CODE    VARCHAR2(20),
  C_DS_CODE     VARCHAR2(20),
  N_HLDAMT      NUMBER(18,4),
  N_HLDCST      NUMBER,
  N_HLDCST_LOCL NUMBER,
  N_HLDMKV      NUMBER,
  N_HLDMKV_LOCL NUMBER,
  N_HLDVVA      NUMBER(18,4),
  N_HLDVVA_L    NUMBER(18,4),
  C_SUBPEND     VARCHAR2(200),
  C_RIGHTS      VARCHAR2(200),
  N_VALPRICE    NUMBER(30,15),
  N_VALRATE     NUMBER(30,15),
  N_WAY         NUMBER,
  C_SUBJ_CODE_T VARCHAR2(200),
  C_NAV_TYPE    VARCHAR2(20),
  C_DV_KM_CLS   VARCHAR2(20),
  N_LEVEL       NUMBER,
  N_ORDER1      NUMBER,
  C_SEC_VAR_MX  VARCHAR2(20),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_VF_REPORT_VAL_20161111
prompt ========================================
prompt
create table GUZHI.WU_VF_REPORT_VAL_20161111
(
  N_ID          VARCHAR2(20),
  D_BIZ         DATE,
  C_PORT_CODE   VARCHAR2(20),
  C_PORT_CLASS  VARCHAR2(400),
  C_SUBJ_CODE   VARCHAR2(200),
  C_SUBJ_NAME   VARCHAR2(200),
  C_KEY_CODE    VARCHAR2(50),
  C_KEY_NAME    VARCHAR2(200),
  C_CURY_CODE   VARCHAR2(20),
  C_PA_CODE     VARCHAR2(20),
  C_MKT_CODE    VARCHAR2(20),
  C_TD_ATTR     VARCHAR2(20),
  C_IVT_CLSS    VARCHAR2(20),
  C_HLD_ATTR    CHAR(1),
  C_ML_ATTR     VARCHAR2(20),
  C_TDCHAN_CODE VARCHAR2(20),
  C_SEC_CODE    VARCHAR2(50),
  C_CA_CODE     VARCHAR2(50),
  C_FEE_CODE    VARCHAR2(20),
  C_DS_CODE     VARCHAR2(20),
  N_HLDAMT      NUMBER(18,4),
  N_HLDCST      NUMBER,
  N_HLDCST_LOCL NUMBER,
  N_HLDMKV      NUMBER,
  N_HLDMKV_LOCL NUMBER,
  N_HLDVVA      NUMBER(18,4),
  N_HLDVVA_L    NUMBER(18,4),
  C_SUBPEND     VARCHAR2(200),
  C_RIGHTS      VARCHAR2(200),
  N_VALPRICE    NUMBER(30,15),
  N_VALRATE     NUMBER(30,15),
  N_WAY         NUMBER,
  C_SUBJ_CODE_T VARCHAR2(200),
  C_NAV_TYPE    VARCHAR2(20),
  C_DV_KM_CLS   VARCHAR2(20),
  N_LEVEL       NUMBER,
  N_ORDER1      NUMBER,
  C_SEC_VAR_MX  VARCHAR2(20),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WU_VS_PORT_SELL_20161111
prompt =======================================
prompt
create table GUZHI.WU_VS_PORT_SELL_20161111
(
  D_BIZ         DATE not null,
  C_PORT_CODE   VARCHAR2(20) not null,
  C_PORT_CLASS  VARCHAR2(20),
  C_TD_NUMBER   VARCHAR2(50),
  C_OD_NUMBER   VARCHAR2(50),
  C_DS_CODE     VARCHAR2(20) not null,
  C_SEC_CODE    CHAR(1),
  N_TD_AMOUNT   NUMBER(18,4) not null,
  C_CURY_CODE   VARCHAR2(20) not null,
  D_TRADE_DATE  DATE not null,
  N_ST_MONEY    NUMBER(18,4) not null,
  D_SETTLE      DATE not null,
  C_CA_CODE     VARCHAR2(50) not null,
  N_TD_MONEY    NUMBER(18,4) not null,
  N_TD_INCOME   NUMBER,
  N_TD_FEE      NUMBER,
  N_TD_GZC_FEE  NUMBER,
  N_TD_HD_FEE   NUMBER,
  C_SEC_CODE_OT CHAR(1),
  C_TIMESTAMP   VARCHAR2(17)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence SEQ_A_TEST_ID
prompt ===============================
prompt
create sequence GUZHI.SEQ_A_TEST_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_JHDX_REMARKS_ID
prompt =====================================
prompt
create sequence GUZHI.SEQ_JHDX_REMARKS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 31
increment by 1
cache 10;

prompt
prompt Creating procedure OUTPUT_DATE
prompt ==============================
prompt
create or replace procedure guzhi.output_date is
begin
dbms_output.put_line(sysdate);
end output_date;
/


spool off
