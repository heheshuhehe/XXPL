package com.fh.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
 
/*
 * 总入口
 */
@Controller
public class LoginController  {
	protected Logger logger = Logger.getLogger(this.getClass());
	/**
	 * 访问系统index页面,跳转到此方法,
	 * 通过此方法访问登录页
	 * @return
	 */
	@RequestMapping(value="/test")
	public ModelAndView toLogin() throws Exception{
		ModelAndView mv = new ModelAndView();
        mv.setViewName("login/listMenu");
		return mv;
	}
	 
}
