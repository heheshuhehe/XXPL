package com.fh.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class WeekdayListUtil {
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	// 1 根据当前日期获得所在周的日期区间（周一和周日日期）
	public static String getTimeInterval(String date0) throws ParseException {
		Date date=null;
		if("".equals(date0)){
			date=new Date();
		}else{
			date=sdf.parse(date0);
		}
			
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// 判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天
		if (1 == dayWeek) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		// System.out.println("要计算日期为:" + sdf.format(cal.getTime())); // 输出要计算日期
		// 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		// 获得当前日期是一个星期的第几天
		int day = cal.get(Calendar.DAY_OF_WEEK);
		// 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值
		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
		String imptimeBegin = sdf.format(cal.getTime());
		// System.out.println("所在周星期一的日期：" + imptimeBegin);
		cal.add(Calendar.DATE, 6);
		String imptimeEnd = sdf.format(cal.getTime());
		// System.out.println("所在周星期日的日期：" + imptimeEnd);
		return imptimeBegin + "," + imptimeEnd;
	}

	// 2 根据当前日期获得上周的日期区间（上周周一和周日日期）
	public static String getLastTimeInterval() {
		Calendar calendar1 = Calendar.getInstance();
		Calendar calendar2 = Calendar.getInstance();
		int dayOfWeek = calendar1.get(Calendar.DAY_OF_WEEK) - 1;
		int offset1 = 1 - dayOfWeek;
		int offset2 = 7 - dayOfWeek;
		calendar1.add(Calendar.DATE, offset1 - 7);
		calendar2.add(Calendar.DATE, offset2 - 7);
		// System.out.println(sdf.format(calendar1.getTime()));// last Monday
		String lastBeginDate = sdf.format(calendar1.getTime());
		// System.out.println(sdf.format(calendar2.getTime()));// last Sunday
		String lastEndDate = sdf.format(calendar2.getTime());
		return lastBeginDate + "," + lastEndDate;
	}

	// 3 获取一周开始到结束的list集合

	public static List<Date> findDates(Date dBegin, Date dEnd) {
		List lDate = new ArrayList();
		lDate.add(dBegin);
		Calendar calBegin = Calendar.getInstance();
		// 使用给定的 Date 设置此 Calendar 的时间
		calBegin.setTime(dBegin);
		Calendar calEnd = Calendar.getInstance();
		// 使用给定的 Date 设置此 Calendar 的时间
		calEnd.setTime(dEnd);
		// 测试此日期是否在指定日期之后
		while (dEnd.after(calBegin.getTime())) {
			// 根据日历的规则，为给定的日历字段添加或减去指定的时间量
			calBegin.add(Calendar.DAY_OF_MONTH, 1);
			lDate.add(calBegin.getTime());
		}
		return lDate;
	}

	public static String  getCurrentWeekDays() throws ParseException	{
		String result="";
		String yz_time = getTimeInterval("");// 获取本周时间
		yz_time = getLastTimeInterval();// 获取本周时间
		String array[] = yz_time.split(",");
		String start_time = array[0];// 本周第一天
		String end_time = array[1]; // 本周最后一天 //格式化日期

		Date dBegin = sdf.parse(start_time);
		Date dEnd = sdf.parse(end_time);
		List<Date> lDate = findDates(dBegin, dEnd);// 获取这周所有date
		for (Date date : lDate) {
			result+=	sdf.format(date)+",";
		}
		if(result.length()>1){
			result=result.substring(0,result.length()-1);
		}
		return result;
	}
	public static String  getLastWeekDays() throws ParseException	{
		String result="";
		String yz_time = getTimeInterval("");// 获取本周时间
		yz_time = getLastTimeInterval();// 获取本周时间
		String array[] = yz_time.split(",");
		String start_time = array[0];// 本周第一天
		String end_time = array[1]; // 本周最后一天 //格式化日期

		Date dBegin = sdf.parse(start_time);
		Date dEnd = sdf.parse(end_time);
		List<Date> lDate = findDates(dBegin, dEnd);// 获取这周所有date
		for (Date date : lDate) {
			result+=	sdf.format(date)+",";
		}
		if(result.length()>1){
			result=result.substring(0,result.length()-1);
		}
		return result;
	}

	public static String getCustomWeekDays(String date) throws ParseException {
		String result="";
		String yz_time = getTimeInterval(date);// 获取本周时间
		String array[] = yz_time.split(",");
		String start_time = array[0];// 本周第一天
		String end_time = array[1]; // 本周最后一天 //格式化日期

		Date dBegin = sdf.parse(start_time);
		Date dEnd = sdf.parse(end_time);
		List<Date> lDate = findDates(dBegin, dEnd);// 获取这周所有date
		for (Date mdate : lDate) {
			result+=	sdf.format(mdate)+",";
		}
		if(result.length()>1){
			result=result.substring(0,result.length()-1);
		}
		return result;
	}
	/**
     * 判断一年的第几周
     * @param datetime
     * @return
     * @throws java.text.ParseException
     */
    public static Integer whatWeek(String date10) throws java.text.ParseException {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date date = format.parse(date10);
            Calendar calendar = Calendar.getInstance();
            calendar.setFirstDayOfWeek(Calendar.MONDAY);
            calendar.setTime(date);
            Integer weekNumbe = calendar.get(Calendar.WEEK_OF_YEAR);
            return weekNumbe;
    }

    public static void main(String[] args) {
		try {
			System.out.println(getCustomWeekDays("2019-12-30"));
			//System.out.println(whatWeek("2019-12-30"));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
