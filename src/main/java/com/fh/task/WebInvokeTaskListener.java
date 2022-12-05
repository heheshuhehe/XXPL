package com.fh.task;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class WebInvokeTaskListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		ServletContext servlet=arg0.getServletContext();
		
		WebApplicationContext ctx= WebApplicationContextUtils.getWebApplicationContext(servlet);
		
//		DataSource ds= (DataSource)ctx.getBean("dataSource");
		DataSource ds= (DataSource)ctx.getBean("datasourceXXPLHD");
		
		WebTaskManage webtaskmanage=new WebTaskManage(ds);
	//	webtaskmanage.doTask();
		
		
	}

}
