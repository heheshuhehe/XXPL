 package com.fh.util.mail;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.activation.MailcapCommandMap;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.Logger;

import com.linuxense.javadbf.DBFField;
import com.linuxense.javadbf.DBFReader;

public class SendMail {
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	Map<String,String> ztMap=new HashMap<String,String>();
	protected Logger logger = Logger.getLogger(this.getClass());
	List<String> infos=new ArrayList<>();
	String yyyyMMdd="";
	 //Date moto=sdf.parse("20171022");
	String mailHost="172.17.180.11";
	//String mailHost="172.16.130.88";
	
 
	

	public static int  interDay(Date d1,Date d2) {
		
		long intermilli=d1.getTime()-d2.getTime();
		
		return (int)(intermilli/(1000*60*60*24));
		
	}
	
	public boolean sendMail(String address,String subject ,String content,String attment) {
		
		String myaccount="wbfwyx_dz@swhysc.com";
		String mypassword="Swhy2016";
		Session session=null;

		MimeMessage message=null;
		try{


		String mailPort="25";
		String receiveMail="lihaijie@swhysc.com;liguangyun@swhysc.com;lishengnan@swhysc.com;liushangwen@swhysc.com;yanghanda@swhysc.com;xululu@swhysc.com";
		receiveMail=address;
		InternetAddress [] addresses=new InternetAddress [receiveMail.split(";").length];
		
		String []  hh=receiveMail.split(";");
		int jj=0;
		for(String s:hh){
			
			try {
				addresses[jj]=new InternetAddress(s);
			} catch (AddressException e) {
				
				e.printStackTrace();
				return false;
			}
			jj++;
			
			
		}
		
		Properties props=new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.host", mailHost);
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.port", mailPort);
		
		
		
		
		 session=Session.getInstance(props);
		if(attment==null||"".equals(attment))
			 message=creatMimeMessageAttachment(session, myaccount, addresses, subject, content);
		else
			message=creatMimeMessageAttachment(session, myaccount, addresses, subject, content,attment);
	
		Transport transport = null;
		
			transport = session.getTransport();

			transport.connect(myaccount,mypassword);
			transport.sendMessage(message,addresses);
			transport.close();
		
		return true;
		
	}catch(SendFailedException ex){
		
		ex.printStackTrace();
		logger.info(ex);
		try {

			   
			 Address [] valid= ex.getValidUnsentAddresses();
			 if(valid!=null){
				 Transport transport = null;
					transport = session.getTransport();
					transport.connect(myaccount,mypassword);
					transport.sendMessage(message,valid);
					transport.close();
			 }
			 
			 return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
		
	}catch(Exception ex){
		ex.printStackTrace();
		return false;
	}
		
		
	}
public boolean sendMail(String mailfrom, String pwd, String address,String subject ,String content,String attment) {
		
	Session session=null;
	String myaccount=mailfrom;
	String mypassword=pwd;
	MimeMessage message=null;
		try{


		String mailPort="25";
		String receiveMail="lihaijie@swhysc.com;liguangyun999@swhysc.com;";
		receiveMail=address;
		InternetAddress [] addresses=new InternetAddress [receiveMail.split(";").length];
		
		String []  hh=receiveMail.split(";");
		int jj=0;
		for(String s:hh){
			
			try {
				addresses[jj]=new InternetAddress(s);
			} catch (AddressException e) {
				
				e.printStackTrace();
				return false;
			}
			jj++;
			
			
		}
		
		Properties props=new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.host", mailHost);
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.port", mailPort);
		
		
		
		
		 session=Session.getInstance(props);
		if(attment==null||"".equals(attment))
			 message=creatMimeMessageAttachment(session, myaccount, addresses, subject, content);
		else
			message=creatMimeMessageAttachment(session, myaccount, addresses, subject, content,attment);
	
		Transport transport = null;
		
			transport = session.getTransport();

			transport.connect(myaccount,mypassword);
			transport.sendMessage(message,addresses);
			transport.close();
		
		return true;
		
	}catch(SendFailedException ex){
		
		ex.printStackTrace();
		logger.info(ex);
		try {

			   
			 Address [] valid= ex.getValidUnsentAddresses();
			 if(valid!=null){
				 Transport transport = null;
					transport = session.getTransport();
					transport.connect(myaccount,mypassword);
					transport.sendMessage(message,valid);
					transport.close();
			 }
			 
			 return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
		
	}catch(Exception ex){
		ex.printStackTrace();
		return false;
	}
		
		
	}
/**
 * 0 成功   1 部分成功  2失败
 * */
public String sendMailex(String mailfrom, String pwd, String address,String subject ,String content,String attment) {
	
	Session session=null;
	String myaccount=mailfrom;
	String mypassword=pwd;
	MimeMessage message=null;
		try{

		

		String mailPort="25";
		String receiveMail="lihaijie@swhysc.com;liguangyun999@swhysc.com;";
		receiveMail=address;
		receiveMail=receiveMail.replace(",", ";");
		receiveMail=receiveMail.replace("，", ";");
		receiveMail=receiveMail.replace("；", ";");
		receiveMail=receiveMail.replace(";;", ";");
		receiveMail=receiveMail.replace(" ", "");
		if(address.length()<5)
			return "2";
		InternetAddress [] addresses=new InternetAddress [receiveMail.split(";").length];
		
		String []  hh=receiveMail.split(";");
		int jj=0;
		for(String s:hh){
			
			try {
				addresses[jj]=new InternetAddress(s);
			} catch (AddressException e) {
				
				e.printStackTrace();
				return "2";
			}
			jj++;
			
			
		}
		
		Properties props=new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.host", mailHost);
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.port", mailPort);
		
		
		
		
		 session=Session.getInstance(props);
		if(attment==null||"".equals(attment))
			 message=creatMimeMessageAttachment(session, myaccount, addresses, subject, content);
		else
			message=creatMimeMessageAttachment(session, myaccount, addresses, subject, content,attment);
	
		Transport transport = null;
		
			transport = session.getTransport();

			transport.connect(myaccount,mypassword);
			transport.sendMessage(message,addresses);
			transport.close();
		
		return "0";
		
	}catch(SendFailedException ex){
		
		ex.printStackTrace();
		logger.info(ex);
		Address []invalid= ex.getInvalidAddresses(); 
		try {

			 
			 Address [] valid= ex.getValidUnsentAddresses();
			 if(valid!=null){
				 Transport transport = null;
					transport = session.getTransport();
					transport.connect(myaccount,mypassword);
					transport.sendMessage(message,valid);
					transport.close();
			 }
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
		if(invalid==null)
			return "fail";
		 return "1"+"mail:"+Arrays.toString(invalid);
		
	}catch(Exception ex){
		if(address.length()<5)
			return "2";
		ex.printStackTrace();
		return "fail";
	}
		
		
	}
	public MimeMessage creatMimeMessageNoAttachment(Session session,String sandMailAdd,Address [] receiveMail,String subject,String content) throws Exception {
		MimeMessage message=new MimeMessage(session);
		message.setFrom(new InternetAddress(sandMailAdd));
		message.setRecipients(MimeMessage.RecipientType.TO, receiveMail);
		message.setSubject(subject);
		message.setContent(content,"text/html;charset=UTF-8");
		message.setSentDate(new Date());
		message.saveChanges();
		
		return message;
		
	}
	public MimeMessage creatMimeMessageAttachment(Session session,String sandMailAdd,Address [] receiveMail,String subject,String content,String attach) throws Exception {
		MimeMessage message=new MimeMessage(session);
		message.setFrom(new InternetAddress(sandMailAdd));
		message.setRecipients(MimeMessage.RecipientType.TO, receiveMail);
		message.setSubject(subject);
		
			Multipart multipart = new MimeMultipart();  
			                BodyPart contentPart = new MimeBodyPart();  
			                contentPart.setText(content);  
			  
			                contentPart.setHeader("Content-Type", "text/html; charset=GBK");  
			                multipart.addBodyPart(contentPart);  
			                  
			                String [] attaches =attach.split(";");
			                /*添加附件*/  
			                for (String file : attaches) {  
			                    File usFile = new File(file);  
			                    MimeBodyPart fileBody = new MimeBodyPart();  
			                    DataSource source = new FileDataSource(file);  
			                    fileBody.setDataHandler(new DataHandler(source));  			                  
			                    fileBody.setFileName(MimeUtility.encodeText(usFile.getName()
			                    
			                    ));  
		                    multipart.addBodyPart(fileBody);  
			                }  
		  
		                message.setContent(multipart);  

	
		message.setSentDate(new Date());
		message.saveChanges();
		
		return message;
		
	}
	public MimeMessage creatMimeMessageAttachment(Session session,String sandMailAdd,Address [] receiveMail,String subject,String content) throws Exception {
		MimeMessage message=new MimeMessage(session);
		message.setFrom(new InternetAddress(sandMailAdd));
		message.setRecipients(MimeMessage.RecipientType.TO, receiveMail);
		message.setSubject(subject);
		
			Multipart multipart = new MimeMultipart();  
			                BodyPart contentPart = new MimeBodyPart();  
			                contentPart.setText(content);  
			  
			                contentPart.setHeader("Content-Type", "text/html; charset=GBK");  
			                multipart.addBodyPart(contentPart);  
			                  
			          
			       
		  
		                message.setContent(multipart);  

	
		message.setSentDate(new Date());
		message.saveChanges();
		
		return message;
		
	}
	public  String  dateFormater0(String yyyyMMdd) {
		return yyyyMMdd.substring(0,4)+"-"+ yyyyMMdd.substring(4,6)+"-"+ yyyyMMdd.substring(6,8);
	}
	
	public static void main(String[] args) {
		SendMail sd=new SendMail();
		try {
			//sd.sendMailex("xxpl@swhysc.com","swhy@1234","lihaijie@swhysc.com;liguangyun999@swhysc.com;", "1", "", null);
			String receiveMail="	cwjz@tg.gtja.com；chenmh@998fund.com；qiuwl@998fund.com；songyr@998fund.com；hangxing@998fund.com；liangz@998fund.com；yiguzichan@163.com； ";
			receiveMail=receiveMail.replace(",", ";");
			receiveMail=receiveMail.replace("，", ";");
			receiveMail=receiveMail.replace("；", ";");
			receiveMail=receiveMail.replace(" ", "");
			
			if(receiveMail.length()<5)
				System.out.println(2);
			InternetAddress [] addresses=new InternetAddress [receiveMail.split(";").length];
			
			String []  hh=receiveMail.split(";");
			int jj=0;
			for(String s:hh){
				
				try {
					addresses[jj]=new InternetAddress(s);
				} catch (AddressException e) {
					
					e.printStackTrace();
					System.out.println(2);
				}
				jj++;
				
				
			}


			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
