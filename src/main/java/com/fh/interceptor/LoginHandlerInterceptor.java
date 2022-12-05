package com.fh.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.ezmorph.MorpherRegistry;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.util.JSONUtils;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fh.util.Const;
import com.fh.util.LoginUtil;


/**
 * 
* 类名称：LoginHandlerInterceptor.java
* 类描述：登录拦截器
* @author Administrator
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter{
	protected Logger logger = Logger.getLogger(this.getClass());
   /** 
    * 设置日期转换格式 
    */  
   static {  
       //注册器  
       MorpherRegistry mr = JSONUtils.getMorpherRegistry();  
       //可转换的日期格式，即Json串转实体时，可以出现以下格式的日期与时间 
       DateMorpher dm = new DateMorpher(new String[]{"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd"});  //json中支持的日期类型格式  
       mr.registerMorpher(dm);  
   }  
   
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//权限逻辑，是否有访问的权限。
		String path = request.getServletPath();
		logger.info("^_^=================进入拦截器LoginHandlerInterceptor================="+LoginUtil.getIPAdrress(request)+"访问URL【"+path+"】");
		Enumeration<String> paraNames2 = request.getParameterNames();
		StringBuilder sb= new StringBuilder();
		for(Enumeration e=paraNames2;e.hasMoreElements();){		//打印parameter
		    String thisName=e.nextElement().toString();
		    String thisValue=request.getParameter(thisName);
		    sb.append(thisName+"="+thisValue+"&");
		}
		if (sb.length()>1) {logger.info(sb);}
		//不进行验证登录path
		if(path.matches(Const.NO_INTERCEPTOR_PATH)){
			logger.info("^_^此访问URL不需进行验证... ... ");
			return true;
		}else{
		     	logger.info("^_^此访问URL开始进行验证... ... ");
//				  //登陆过滤
//				  response.sendRedirect(request.getContextPath() + Const.LOGIN_FM);
//				  logger.info("(⊙o⊙)用户为未登录状态，或登录已过期,页面将跳转至URL=====>"+request.getContextPath() + Const.LOGIN_FM);
//				  return false;		
		     	return true;	  
		}
  }
	
}
