 package com.fh.task;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.fh.util.DaoUtil;

public class WebTaskManage implements Runnable {


	SimpleDateFormat df=new SimpleDateFormat("yyyyMMdd"); 
	SimpleDateFormat df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd"); 
	Date nowDate=Calendar.getInstance().getTime();
	List<Map<String, Object>>   tasks=null;
	protected Logger logger = Logger.getLogger(this.getClass());
	
	


	public WebTaskManage(DataSource ds) {
	
		Connection con=null;
		String sql="select * from SMGZ_WEB_TASK where isused='TT' ";
		try {
			 con=ds.getConnection();
			tasks=DaoUtil.getListFromProcedure(con, sql);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			DaoUtil.release(con);
		}
		
		
		
	}
	
	ScheduledExecutorService ses=Executors.newScheduledThreadPool(10);
	
	

	public void doTask() {
		try {
		for(Map<String,Object> task:tasks){
			
			Date nowDate=Calendar.getInstance().getTime();
	    	
	    	Date schedule=nowDate;
			
			String url=task.get("taskurl").toString();
			String downpath=task.get("downpath").toString();
			String tasktime=task.get("tasktime").toString();
			String taskname=task.get("taskname").toString();
			String change=task.get("datechange").toString();
			
			
			
				schedule = df2.parse(df3.format(nowDate)+" "+tasktime+":00:00");
			
			long oneDay=24*60*60*1000+60*1000;		
			long initDelay =schedule.getTime()-nowDate.getTime();
			
			if(initDelay<0) 			initDelay+=oneDay;
			
			WebInvokeTask needTask=new WebInvokeTask(url, downpath,change);
			needTask.taskname=taskname;
			ses.scheduleAtFixedRate(needTask, initDelay, oneDay, TimeUnit.MILLISECONDS);
			logger.info(taskname+"--添加定时任务成功");
			
			
		}
		} catch (ParseException e) {
			logger.info("定时任务启动失败");
			e.printStackTrace();
		}
		
	}

	
	
	
	

	@Override
	public void run() {
		// TODO Auto-generated method stub
		
	}

}
