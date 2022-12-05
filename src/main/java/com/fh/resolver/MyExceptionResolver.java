package com.fh.resolver;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
/**
 * 
* 类名称：MyExceptionResolver.java
* 类描述： 
 */
public class MyExceptionResolver implements HandlerExceptionResolver{
	protected Logger logger = Logger.getLogger(this.getClass());
	
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		logger.error("进入异常统一处理方法：MyExceptionResolver,异常信息为："+ex.toString());
		if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request.getHeader("X-Requested-With")!= null && request  
                .getHeader("X-Requested-With").indexOf("XMLHttpRequest") > -1))) { 
			ModelAndView mv = new ModelAndView("error");
			mv.addObject("exception", ex.toString().replaceAll("\n", "<br/>"));
			return mv;
		}else{
			 try {  
                 response.setStatus(500); //设置状态码  
                 response.setContentType("application/json;charset=UTF-8");
                 response.setCharacterEncoding("UTF-8"); //避免乱码
                 response.setHeader("Cache-Control", "no-cache, must-revalidate");  
                 PrintWriter writer = response.getWriter(); 
                  
                 writer.write("系统出现异常，请联系管理员处理!");
                 // writer.write("{\"success\":false,\"msg\":\"" + ex.getMessage() + "\"}");  
                 writer.flush();  
             } catch (IOException e) {  
            	 logger.error("Ajax异常统一处理出错，未找到 response.getWriter()");
             }  
             return new ModelAndView();  
		}
	}

}
