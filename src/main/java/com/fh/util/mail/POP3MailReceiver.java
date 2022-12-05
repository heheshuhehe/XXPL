package com.fh.util.mail;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.Logger;

import com.fh.util.file.FileUtil;
import com.fh.util.sql.QueryOprater_oracle;

/**
 * 邮件接受测试
 * 
 */
public class POP3MailReceiver {
	private static Logger logger = Logger.getLogger(POP3MailReceiver.class);

	public POP3MailReceiver(String mailaddress, String mailpassword,
			String mailserver, String downloadfilepath, List<String> list) throws Exception {

			logger.info("downloadfilepath————————————————>" + downloadfilepath);

			Properties props = new Properties();
			props.setProperty("mail.store.protocol", "pop3"); // 协议
			props.setProperty("mail.pop3.port", "110"); // 端口
			props.setProperty("mail.pop3.host", mailserver); // pop3服务器
			// props.setProperty("mail.pop3.host", "mail.sinosoft.com.cn"); //
			// pop3服务器
			Session session = Session.getInstance(props);// 创建Session实例对象
			Store store = session.getStore("pop3");
			store.connect(mailaddress, mailpassword);

			Folder folder = store.getDefaultFolder();// 默认父目录
			if (folder == null) {
				logger.info("服务器不可用");
				System.out.println("服务器不可用");
				return;
			}
			Folder popFolder = folder.getFolder("INBOX");// 获取收件箱
			popFolder.open(Folder.READ_WRITE);// 可读邮件,可以删邮件的模式打开目录
			// 4. 列出来收件箱 下所有邮件
			Message[] messages = popFolder.getMessages();
			System.out.println(messages.toString());
			// 取出来邮件数
			int msgCount = popFolder.getMessageCount();
			int ccount = 0;
			for (int i = 1; i < msgCount; i++) {
				// 单个邮件
				// System.out.println("第" + i + "邮件开始");
				Date sendtime = messages[i].getSentDate();// 获取邮件的发送时间

				if (sendtime == null) {
					logger.info("......*****获取不到该邮件的时间*****.....");
					System.out.println(messages[i].toString());
					System.out.println(messages[i].getSubject());
					continue;
				}

				long mailtime = sendtime.getTime();
				// Date d = new Date();
				// DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				// String day = format.format(d);
				// String todayz = day + " 12:00:00";
				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				// Date ssDate = format1.parse(todayz);

				String edate = list.get(list.size() - 2);

				edate = edate.substring(5, edate.length()) + ":00";

				String sdate = list.get(list.size() - 3);

				sdate = sdate.substring(5, sdate.length()) + ":00";

				Date edatetime = format1.parse(edate);

				Date sdatetime = format1.parse(sdate);

				long stodaymillions = edatetime.getTime();

				long syesdaymillions = sdatetime.getTime();

				// 将发送时间限定在昨天中午十二点到今天中午十二点
				if(mailtime<syesdaymillions){
					logger.info("======小于最小时间时移除掉"+sendtime);
					return;
				}else{
					if (mailtime > syesdaymillions && mailtime < stodaymillions) {
						logger.info("*---------第" + i + "邮件开始----------*");
						mailReceiver(messages[i], list, downloadfilepath);
						logger.info("*---------第" + i + "邮件结----------*");
						ccount = ccount + 1;
					}
				}
			}
			logger.info("*---------昨天中午到今天中的邮件数：" + ccount + "-------------*");

			// 7. 关闭 Folder 会真正删除邮件, false 不删除
			popFolder.close(true);
			// 8. 关闭 store, 断开网络连接
			store.close();
	}

	/**
	 * 解析邮件
	 * 
	 * @param messages
	 *            邮件对象
	 * @param i
	 * @return
	 * @throws IOException
	 * @throws MessagingException
	 * @throws FileNotFoundException
	 * @throws UnsupportedEncodingException
	 */
	private void mailReceiver(Message msg, List<String> list,
			String downloadfilepath) throws Exception {
		// 发件人信息
		Address[] froms = msg.getFrom();
		if (froms != null) {
			// System.out.println("发件人信息:" + froms[0]);
			InternetAddress addr = (InternetAddress) froms[0];
			logger.info("*--------发件人地址:" + addr.getAddress()
					+ "---------------*");
			logger.info("*--------发件人显示名:" + addr.getPersonal()
					+ "------------*");
		}
		logger.info("*---------邮件主题:" + msg.getSubject() + "---------------*");
		// getContent() 是获取包裹内容, Part相当于外包装
		Object o = msg.getContent();
		if (o instanceof Multipart) {
			Multipart multipart = (Multipart) o;
			reMultipart(multipart, list, downloadfilepath);
		} else if (o instanceof Part) {
			Part part = (Part) o;
			rePart(part, list, downloadfilepath);
		} else {
			// System.out.println("类型" + msg.getContentType());
			// System.out.println("内容" + msg.getContent());
		}
	}

	/**
	 * @param part
	 *            下载附件
	 * @throws Exception
	 */
	private void rePart(Part part, List<String> list, String downloadfilepath)
			throws MessagingException, UnsupportedEncodingException,
			IOException, FileNotFoundException {
		if (part.getDisposition() != null && !part.getContentType().startsWith("text")) {

			String strFileNmae = part.getFileName();

			logger.info("发现附件strFileName:" + strFileNmae);

			// 解决部分中文字乱码
//			if (strFileNmae.length() >= 8
//					&& strFileNmae.substring(2, 8).equals("GB2312")) {
//				strFileNmae = strFileNmae.substring(11,
//						strFileNmae.length() - 2);
//				strFileNmae = new String(Base64.decodeBase64(strFileNmae),
//						"GBK");
//			} else {
//				// MimeUtility.decodeText解决附件名乱码问题
//				strFileNmae = MimeUtility.decodeText(strFileNmae);
//			}
			 if (strFileNmae == null){
				 
				 return;
				 
			 }
			
			 strFileNmae = MimeUtility.decodeText(part.getFileName());
			// // MimeUtility.decodeText解决附件名乱码问题

			logger.info("*----------发现附件: " + strFileNmae + "----------------*");

			// 如果list不为null

			if (list != null) {
				if (!list.contains(strFileNmae)) {
					return;
				}
			}
			

			
			//logger.info("*---------开始下载附件，下载路径为--------------*");
			logger.info("附件strFileName:" + strFileNmae+"下载开始！");
			InputStream in = part.getInputStream();// 打开附件的输入流

			// 创建文件夹

			// FileUtil.createDir(FileUtil.pros.getProperty("downloadfilepath")+DateUtil.getDays()+"/");
			// FileUtil.createDir(downloadfilepath + DateUtil.getDays() + "/");
			FileUtil.createDir(downloadfilepath);

			// 读取附件字节并存储到文件中
			java.io.FileOutputStream out = new FileOutputStream(
					downloadfilepath + strFileNmae);
			int data;
			while ((data = in.read()) != -1) {
				out.write(data);
			}
			in.close();
			out.close();
			logger.info("*---------完成下载------------------*");

			QueryOprater_oracle o = new QueryOprater_oracle();

			String newdate = list.get(list.size() - 1);

			newdate = newdate.substring(7, newdate.length());

			if (strFileNmae.contains(newdate)) {
				strFileNmae = strFileNmae.replace(newdate, "YYYYMMDD");
			}
			
			String sql = " INSERT INTO T_DOWNLOADEDFILE(ID, FILENAME, REMARK, STATE, CURRENTTIME, UPDATETIME) VALUES(SEQ_GUZHI_SERVICE_SYSTEM.NEXTVAL,'"
					+ strFileNmae + "','01',1,to_date('"+newdate+"','YYYY-mm-dd'),SYSDATE)";

			logger.info("sql" + sql);

			o.addTest(sql);

		} else {
			if (part.getContentType().startsWith("text/plain")) {
				// System.out.println("文本内容：" + part.getContent());
			} else {
				// System.out.println("HTML内容：" + part.getContent());
			}
		}
	}

	/**
	 * @param multipart
	 *            // 接卸包裹（含所有邮件内容(包裹+正文+附件)
	 * @throws Exception
	 */
	private void reMultipart(Multipart multipart, List<String> list,
			String downloadfilepath) throws Exception {

		// 依次处理各个部分
		for (int j = 0, n = multipart.getCount(); j < n; j++) {
			Part part = multipart.getBodyPart(j);// 解包, 取出 MultiPart的各个部分,
			if (part.getContent() instanceof Multipart) {
				Multipart p = (Multipart) part.getContent();// 转成小包裹
				// 递归迭代
				reMultipart(p, list, downloadfilepath);
			} else {
				rePart(part, list, downloadfilepath);
			}
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		List<String> list = new ArrayList<String>();
		list.add("20161010.rar");
		String mailaddress = FileUtil.pros.getProperty("mailaddress");
		String mailpassword = FileUtil.pros.getProperty("mailpassword");
		String mailserver = FileUtil.pros.getProperty("mailserver");
		String downloadfilepath = FileUtil.pros.getProperty("downloadfilepath");

		try {
			new POP3MailReceiver(mailaddress, mailpassword, mailserver,
					downloadfilepath, list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}