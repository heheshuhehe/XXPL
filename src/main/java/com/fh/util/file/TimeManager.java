package com.fh.util.file;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *  时间的管理.
 * @author jiangshan
 *
 */
public class TimeManager
{

	private static long begin = 0;
	private static long end = 0;

	public static long beginTime()
	{
		System.out.println("开始时间:" + getCurrentTimeString());
		return begin();
	}

	public static long begin()
	{
		begin = new Date().getTime();
		return begin;
	}

	/***
	 * 统计开始到现在的毫秒数，并分别用毫秒，秒，分钟显示.
	 * @return 结束时候的毫秒数.
	 */
	public static long endTime()
	{
		return castTime(0);
	}

	/**
	 * @param min 预计额外多用的分钟数
	 * @return 实际计时的时间
	 */
	public static long castTime(int min)
	{
		System.out.println("结束时间：" + getCurrentTimeString());

		end = new Date().getTime();
		long millis = (end - begin) +min*60*1000;
		long hours = millis / 1000 / 60 / 60;
		long minutes = millis / 1000 / 60 % 60;
		long seconds = millis / 1000 % 60;
		long mils = millis % 1000;
		if (hours >= 1)
		{
			System.out.println("用时: " + hours + "小时" + minutes + "分" + seconds + "秒" + mils + "毫秒");
		}
		else if (minutes >= 1)
		{
			System.out.println("用时: " + minutes + "分" + seconds + "秒" + mils + "毫秒");
		}
		else if (seconds >= 1)
		{
			System.out.println("用时: " + seconds + "秒" + mils + "毫秒");
		}
		else
		{
			System.out.println("用时: " + mils + "毫秒");
		}
		return end;
	}
	
	/**
	 * @param min 预计额外多用的分钟数
	 * @return 实际计时的时间
	 */
	public static long castTime(int min,String otherInfo)
	{
		System.out.println("结束时间：" + getCurrentTimeString());

		end = new Date().getTime();
		long millis = (end - begin) +min*60*1000;
		long hours = millis / 1000 / 60 / 60;
		long minutes = millis / 1000 / 60 % 60;
		long seconds = millis / 1000 % 60;
		long mils = millis % 1000;
		if (hours >= 1)
		{
			System.out.println(otherInfo+"用时: " + hours + "小时" + minutes + "分" + seconds + "秒" + mils + "毫秒");
		}
		else if (minutes >= 1)
		{
			System.out.println(otherInfo+"用时: " + minutes + "分" + seconds + "秒" + mils + "毫秒");
		}
		else if (seconds >= 1)
		{
			System.out.println(otherInfo+"用时: " + seconds + "秒" + mils + "毫秒");
		}
		else
		{
			System.out.println(otherInfo+"用时: " + mils + "毫秒");
		}
		return end;
	}

	/***
	 * 用于计算所有时间，具体到毫秒.
	 * @param begin 开始时间.
	 * @param end 结束时间.
	 * @return 从开始时间到现在的毫秒数.
	 */
	public static Long castMillis()
	{
		Long millis = end - begin;
		System.out.println("总共用时: " + millis + " 毫秒！");
		return millis;
	}

	public static String getCurrentTimeString()
	{
		Date date = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return fmt.format(date) + " --- ";
	}

	public static void main(String[] args) throws InterruptedException
	{
		System.out.println(getLastMonth()+"");
	}

	public static int getLastMonth()
	{
		Date date = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		String timeString = fmt.format(date);
		String year = timeString.substring(0, 4);
		String month = timeString.substring(4, 6);
		int yyyy = Integer.parseInt(year);
		int mm = Integer.parseInt(month);
		String lastMonth = null;
		if (mm == 1)
		{
			lastMonth = (yyyy - 1) + "12";
		}
		else
		{
			lastMonth = year + ((mm - 1) < 10 ? "0" + (mm - 1) : (mm - 1));
		}
		return Integer.parseInt(lastMonth);
	}
	
	/**
	 * 
	 * @return 当前时间-1月的yyyyMM格式的时间
	 */
	public static String getCheckMonth() {
		Calendar ca = Calendar.getInstance();
		ca.add(Calendar.MONTH, -1);
		Date date = ca.getTime();

		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMM");
		String str = fmt.format(date);
		return str;
	}
	
	/**
	 * 当前日期具体到月份
	 * @return
	 */
	public static String getMonth()
	{
		Calendar ca = Calendar.getInstance();
		ca.add(Calendar.MONTH, 0);
		Date date = ca.getTime();
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMM");
		String str = fmt.format(date);
		return str;
	}
	
	public static String getDay()
	{
		SimpleDateFormat fmt = new SimpleDateFormat("dd");
		String str = fmt.format(new Date());
		return str;
	}
	
	public static String getHour()
	{
		SimpleDateFormat fmt = new SimpleDateFormat("HH");
		String str = fmt.format(new Date());
		return str;
	}
	
	/**
	 * 
	 * @return yyyyMMddHHmm 格式的时间
	 */
	public static String proETLstamp()
	{
		Date date = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmm"); 
		String str = fmt.format(date);
		return str;
	}
	
	/**
	 * 
	 * @return yyyy-MM-dd HH:mm:ss 格式的时间
	 */
	public static String proCalcstamp()
	{
		Date date = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String str = fmt.format(date);
		return str;
	}
	
	/**
	 * 将long时间串，转化为规定格式的时间字符。
	 * @param timeMills  long时间串
	 * @param fmt  时间格式，如：yyyyMMddHHmmss
	 * @return
	 */
	public static String getTimeString(long timeMills,String fmt){
		Date date = new Date(timeMills);
		SimpleDateFormat fmt1 = new SimpleDateFormat(fmt); 
		return fmt1.format(date);
	}
}
