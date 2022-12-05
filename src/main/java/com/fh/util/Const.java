package com.fh.util;

import org.springframework.context.ApplicationContext;

/**
 * 项目名称：
 * @author:fh
 * 
*/
public class Const {
	public static final String SESSION_USER = "abcd";
	public static final String SESSION_USER_FM = "FM_ID";
	public static final String SESSION_USER_FM_NAME= "FUNDNAME";
	public static final String SESSION_allmenuList = "allmenuList";		//全部菜单
	public static final String SESSION_QX = "QX";//权限信息
	public static final String LOGIN = "/login_toLogin.do";				//登录地址
	public static final String LOGIN_FM = "/login_toLogin_fm.do";				//登录地址
	public static final String PAGE	= "admin/config/PAGE.txt";			//分页条数配置路径
	
	public static final String CHA	= "cha";			 
	public static final String EDIT = "edi";			 
	public static final String DEL	= "del";			 
	public static final String ADD	= "add";
	public static final String EXP	= "exp";			 

	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(static)|(plugins)|(mainPage)).*";	//不对匹配该值的访问路径拦截（正则）
	
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化
	
	/* for Xinxi Pilu hedui monthly report and quartely report 信息披露,月报 季报*/
	public final static String WAIBAO = "wb";		//外包, waibao
	public final static String TUOGUAN = "tg";		//托管, tuoguan
	public final static String MONTHLYREPORT = "M";		//月报标志位, 用于REPT_DISCT_CHK_RSLT查询
	
}
