package com.fh.util.ftp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.log4j.Logger;

import com.fh.util.sql.QueryOprater_oracle;

/**
 * 从ftp上下载文件
 * 
 * @author Administrator
 * 
 */
public class FtpUtil {

	private static Logger logger = Logger.getLogger(FtpUtil.class);

	private static FTPClient ftp;

	/**
	 * 获取FTP连接
	 * 
	 * @param f
	 * @return
	 * @throws Exception
	 */
	public static boolean connectFtp(Ftp f) throws Exception {

		logger.info("开始从" + f.getIpAddr() + "服务器上下载文件.");

		ftp = new FTPClient();

		boolean flag = false;

		int reply;

		if (f.getPort() == null) {
			ftp.connect(f.getIpAddr(), 21);
		} else {
			ftp.connect(f.getIpAddr(), f.getPort());
		}

		ftp.login(f.getUserName(), f.getPwd());
		
		 //设置被动模式   
		ftp.enterLocalPassiveMode();   

		ftp.setFileType(FTPClient.BINARY_FILE_TYPE);

		reply = ftp.getReplyCode();

		if (!FTPReply.isPositiveCompletion(reply)) {
			ftp.disconnect();
			return flag;
		}

		ftp.changeWorkingDirectory(f.getPath());

		flag = true;

		return flag;
	}

	/**
	 * 关闭FTP连接
	 */
	public static void closeFtp() {
		if (ftp != null && ftp.isConnected()) {
			try {
				logger.info("关闭连接......");
				ftp.logout();
				ftp.disconnect();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 下载连接配置
	 * 
	 * @param f
	 * @param localBaseDir
	 *            本地目录
	 * @param remoteBaseDir
	 *            远程目录
	 * @throws Exception
	 */
	public static void startDown(Ftp f, String localBaseDir,
			String remoteBaseDir, List<String> list) throws Exception {
		
		Boolean b = false;

//		remoteBaseDir = new String(remoteBaseDir.getBytes("utf-8"),
//				"iso-8859-1");
		
		
		
		// 如果本地文件不存在，则创建文件夹
		File folder = new File(localBaseDir);

		if (!folder.exists()) {
			folder.mkdirs();
		}
		if (FtpUtil.connectFtp(f)) {
			
			logger.info("~~~~~~~~~~~~~~FTP连接成功~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~·");

			try {
				FTPFile[] files = null;
//				boolean changedir = ftp.changeWorkingDirectory(remoteBaseDir);
				boolean changedir = ftp.changeWorkingDirectory(new String(remoteBaseDir.getBytes(),FTP.DEFAULT_CONTROL_ENCODING));
				logger.info("remoteBaseDir:"+remoteBaseDir+"********"+changedir);
				if (changedir) {
//					ftp.setControlEncoding("iso-8859-1");// 注意编码格式
					ftp.setControlEncoding("GBK");// 注意编码格式
					FTPClientConfig conf = new FTPClientConfig(
							FTPClientConfig.SYST_UNIX);
					conf.setServerLanguageCode("zh");// 中文
					logger.info("查看文件信息：");
					files = ftp.listFiles();
					logger.info("###########文件"+files.toString()+"文件个数"+files.length);
					for (int i = 0; i < files.length; i++) {
						logger.info("下载文件files"+i+":"+files[i] +"文件名："+files[i].getName());
						}
					for (int i = 0; i < files.length; i++) {
						logger.info("下载文件files"+i+":"+files[i].getName()+"@@@@@@@@@@@@@@@@@@@@@@");
						try {
							if (".".equals(files[i].getName()) || "..".equals(files[i].getName())){
								continue;
							}
							downloadFile(files[i], localBaseDir, remoteBaseDir);
							b = true;
						} catch (Exception e) {
							logger.error(e);
							logger.error("<" + files[i].getName() + "下载失败");
						}
					}
				}

				QueryOprater_oracle o = new QueryOprater_oracle();

//				String strFileNmae = f.getIpAddr()
//						+ new String(remoteBaseDir.getBytes("iso-8859-1"),
//								"utf-8");
				String strFileNmae = f.getIpAddr() + remoteBaseDir;
				
				logger.info("strFileName------------------------->"+strFileNmae);

				String newdate = list.get(list.size() - 1);

				newdate = newdate.substring(7, newdate.length());

				if (strFileNmae.contains(newdate)) {
					strFileNmae = strFileNmae.replace(newdate, "YYYYMMDD");
				}

				String sql = " INSERT INTO T_DOWNLOADEDFILE(ID, FILENAME, REMARK, STATE, CURRENTTIME, UPDATETIME) VALUES(SEQ_GUZHI_SERVICE_SYSTEM.NEXTVAL,'"
						+ strFileNmae + "/','02',1,to_date('"+newdate+"','YYYY-mm-dd'),SYSDATE)";

				logger.info("sql" + sql);
				
				logger.info("下载是否成功："+b);
				
				if (b){
					logger.info("执行插入......");
					o.addTest(sql);
				}

			} catch (Exception e) {
				logger.error(e);
				logger.error("下载过程中出现异常");
			}
		} else {
			logger.error("连接失败!");
		}

	}

	/**
	 * 
	 * 下载FTP文件 当你需要下载FTP文件的时候，调用此方法 根据--获取的文件名，本地地址，远程地址--进行下载
	 * 
	 * @param ftpFile
	 * @param relativeLocalPath
	 * @param relativeRemotePath
	 * @throws Exception
	 */
	private static void downloadFile(FTPFile ftpFile, String relativeLocalPath,
			String relativeRemotePath) throws Exception {

		relativeRemotePath = new String(relativeRemotePath.getBytes("utf-8"),
				"iso-8859-1");
		
		logger.info("本地目录relativeLocalPath——————————————————————————————————>"+relativeLocalPath);
		logger.info("远程目录relativeRemotePath——————————————————————————————————>"+relativeRemotePath);
		
		if (ftpFile.isFile()) {
			logger.info("是文件.......");

			String filename = new String(ftpFile.getName().getBytes(
					"iso-8859-1"), "utf-8");// 涉及到中文文件

			logger.info("文件名：" + filename);

			if (ftpFile.getName().indexOf("?") == -1) {

				OutputStream outputStream = null;
				try {
					File localFile = new File(relativeLocalPath + filename);

					logger.info("文件下载地址为:" + localFile.getAbsolutePath());

					if (localFile.exists()) {
						logger.info("目标文件存在，已覆盖...");
					}

					// 若文件已存在则返回
					// if (locaFile.exists()) {
					// System.out.println("提示：目标文件已存在！！！！");
					// return;
					// } else {
					outputStream = new FileOutputStream(relativeLocalPath
							+ filename);

					ftp.retrieveFile(ftpFile.getName(), outputStream);
					outputStream.flush();
					outputStream.close();
					// }
				} catch (Exception e) {
					logger.error(e);
				} finally {
					try {
						if (outputStream != null) {
							outputStream.close();
						}
					} catch (IOException e) {
						logger.error("输出文件流异常");
					}
				}
			}
		} else {
			logger.info("是文件夹......");
//			String filename = new String(ftpFile.getName().getBytes(
//					"iso-8859-1"), "utf-8");// 涉及到中文文件
			String newlocalRelatePath = relativeLocalPath + ftpFile.getName();
			logger.info("本地目录newlocalRelatePath——————————————————————————————————>"+newlocalRelatePath);
			String newRemote = new String(relativeRemotePath
					+ ftpFile.getName().toString());
			logger.info("远程目录newRemote————————————————————————————————————>"+newRemote);
			File fl = new File(newlocalRelatePath);

			if (!fl.exists()) {

				fl.mkdirs();
			}
			try {
				newlocalRelatePath = newlocalRelatePath + '/';
				newRemote = newRemote + "/";
				String currentWorkDir = ftpFile.getName().toString();
				logger.info("当前工作目录currentWorkDir————————————————————————————————————>："+currentWorkDir);
//				boolean changedir = ftp.changeWorkingDirectory(currentWorkDir);
				boolean changedir = ftp.changeWorkingDirectory(new String(currentWorkDir.getBytes(),FTP.DEFAULT_CONTROL_ENCODING));
				logger.info("切换当前工作目录："+currentWorkDir+":切换"+changedir);
				if (changedir) {
					FTPFile[] files = null;
					files = ftp.listFiles();
					for (int i = 0; i < files.length; i++) {
						logger.info("文件列表："+files[i].getName());
						if (".".equals(files[i].getName()) || "..".equals(files[i].getName())){
							continue;
						}
						downloadFile(files[i], newlocalRelatePath, newRemote);
					}
				}
				if (changedir) {
					ftp.changeToParentDirectory();
				}
			} catch (Exception e) {
				logger.error(e);
			}
		}
	}

	public static void main(String[] args) throws Exception {
//		// 定义参数ip 端口号 等的方法；
//		Ftp f = new Ftp();
//		f.setIpAddr("50.2.66.37");
//		// ftp用户名
//		f.setUserName("anonymous");
//		// ftp密码
//		f.setPwd("1");
//		// 端口号
//		f.setPort(21);
//		List<String> list = new ArrayList<String>();
//		FtpUtil.connectFtp(f);
//		FtpUtil.startDown(f, "F:/ftp/20160929/原宏源数据/", "/pub/20160931/原宏源数据/",
//				list);
//		// FtpUtil.startDown(f, "F:/ftp/20160930/AAAA/", "/pub/20160930/AAAA/");
		// 定义参数ip 端口号 等的方法；
		Ftp f = new Ftp();
		f.setIpAddr("218.247.142.200");
		// ftp用户名
		f.setUserName("tarenacode");
		// ftp密码
		f.setPwd("code_2013");
		// 端口号
		f.setPort(21);
		List<String> list = new ArrayList<String>();
		FtpUtil.connectFtp(f);
		FtpUtil.startDown(f, "F:/ftp/20161020/", "/JSDCode/jsd1606/",
				list);
		// FtpUtil.startDown(f, "F:/ftp/20160930/AAAA/", "/pub/20160930/AAAA/");
	}

}
