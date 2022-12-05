package com.fh.util.file;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/*****
 * 选取时间为后一天的时间
 * @param specifiedDay
 * @return
 * @throws java.text.ParseException
 */
public class wDateafter {
 
	public static void main(String[] args) {
		String specifiedDay="20160930";
		try {
			System.out.println(getSpecifiedDayAfter(specifiedDay));
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 public static String getSpecifiedDayAfter(String specifiedDay) throws java.text.ParseException{ 


		 Calendar c = Calendar.getInstance(); 

		 Date date=null; 

		 try { 

		 date = new SimpleDateFormat("yyyyMMdd").parse(specifiedDay);

		  } catch (Exception e) {

		  e.printStackTrace(); 
		 }

		  c.setTime(date); int day=c.get(Calendar.DATE); 

		 c.set(Calendar.DATE,day+1); 

		 String dayBefore=new SimpleDateFormat("yyyyMMdd").format(c.getTime()); 

		 return dayBefore; 

		 }
}
