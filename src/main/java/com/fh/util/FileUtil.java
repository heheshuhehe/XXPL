package com.fh.util;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.channels.FileChannel.MapMode;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.log4j.Logger;

public class FileUtil {

	protected static Logger logger = Logger.getLogger(FileUtil.class);

	public static void main(String[] args) {
		String dirName = "d:/FH/topic/";// 创建目录
		FileUtil.createDir(dirName);
	}

	/**
	 * 创建目录
	 * 
	 * @param destDirName
	 *            目标目录名
	 * @return 目录创建成功返回true，否则返回false
	 */
	public static boolean createDir(String destDirName) {
		File dir = new File(destDirName);
		if (dir.exists()) {
			return false;
		}
		if (!destDirName.endsWith(File.separator)) {
			destDirName = destDirName + File.separator;
		}
		// 创建单个目录
		if (dir.mkdirs()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 删除文件
	 * 
	 * @param filePathAndName
	 *            String 文件路径及名称 如c:/fqf.txt
	 * @param fileContent
	 *            String
	 * @return boolean
	 */
	public static void delFile(String filePathAndName) {
		try {
			String filePath = filePathAndName;
			filePath = filePath.toString();
			java.io.File myDelFile = new java.io.File(filePath);
			myDelFile.delete();

		} catch (Exception e) {
			logger.info("删除文件操作出错");
			e.printStackTrace();

		}

	}

	/**
	 * 读取到字节数组0
	 * 
	 * @param filePath
	 *            //路径
	 * @throws IOException
	 */
	@SuppressWarnings("resource")
	public static byte[] getContent(String filePath) throws IOException {
		File file = new File(filePath);
		long fileSize = file.length();
		if (fileSize > Integer.MAX_VALUE) {
			logger.info("file too big...");
			return null;
		}
		FileInputStream fi = new FileInputStream(file);
		byte[] buffer = new byte[(int) fileSize];
		int offset = 0;
		int numRead = 0;
		while (offset < buffer.length && (numRead = fi.read(buffer, offset, buffer.length - offset)) >= 0) {
			offset += numRead;
		}
		// 确保所有数据均被读取
		if (offset != buffer.length) {
			throw new IOException("Could not completely read file " + file.getName());
		}
		fi.close();
		return buffer;
	}

	/**
	 * 读取到字节数组1
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public static byte[] toByteArray(String filePath) throws IOException {

		File f = new File(filePath);
		if (!f.exists()) {
			throw new FileNotFoundException(filePath);
		}
		ByteArrayOutputStream bos = new ByteArrayOutputStream((int) f.length());
		BufferedInputStream in = null;
		try {
			in = new BufferedInputStream(new FileInputStream(f));
			int buf_size = 1024;
			byte[] buffer = new byte[buf_size];
			int len = 0;
			while (-1 != (len = in.read(buffer, 0, buf_size))) {
				bos.write(buffer, 0, len);
			}
			return bos.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			bos.close();
		}
	}

	/**
	 * 读取到字节数组2
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public static byte[] toByteArray2(String filePath) throws IOException {

		File f = new File(filePath);
		if (!f.exists()) {
			throw new FileNotFoundException(filePath);
		}

		FileChannel channel = null;
		FileInputStream fs = null;
		try {
			fs = new FileInputStream(f);
			channel = fs.getChannel();
			ByteBuffer byteBuffer = ByteBuffer.allocate((int) channel.size());
			while ((channel.read(byteBuffer)) > 0) {
				// do nothing
				// logger.info("reading");
			}
			return byteBuffer.array();
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				channel.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				fs.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * Mapped File way MappedByteBuffer 可以在处理大文件时，提升性能
	 * 
	 * @param filename
	 * @return
	 * @throws IOException
	 */
	public static byte[] toByteArray3(String filePath) throws IOException {

		FileChannel fc = null;
		RandomAccessFile rf = null;
		try {
			rf = new RandomAccessFile(filePath, "r");
			fc = rf.getChannel();
			MappedByteBuffer byteBuffer = fc.map(MapMode.READ_ONLY, 0, fc.size()).load();
			// logger.info(byteBuffer.isLoaded());
			byte[] result = new byte[(int) fc.size()];
			if (byteBuffer.remaining() > 0) {
				// logger.info("remain");
				byteBuffer.get(result, 0, byteBuffer.remaining());
			}
			return result;
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				rf.close();
				fc.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static boolean deleteDir(String dirName) {

		if (dirName.endsWith(File.separator))// dirName不以分隔符结尾则自动添加分隔符
			dirName = dirName + File.separator;

		File file = new File(dirName);// 根据指定的文件名创建File对象

		if (!file.exists() || (!file.isDirectory())) { // 目录不存在或者
			System.out.println("目录删除失败" + dirName + "目录不存在！");
			return false;
		}

		File[] fileArrays = file.listFiles();// 列出源文件下所有文件，包括子目录

		for (int i = 0; i < fileArrays.length; i++) {// 将源文件下的所有文件逐个删除

			FileUtil.deleteAnyone(fileArrays[i].getAbsolutePath());

		}

		if (file.delete())// 删除当前目录
			System.out.println("目录" + dirName + "删除成功！");

		return true;

	}

	public static boolean deleteAnyone(String FileName) {

		File file = new File(FileName);// 根据指定的文件名创建File对象

		if (!file.exists()) { // 要删除的文件不存在
			System.out.println("文件" + FileName + "不存在，删除失败！");
			return false;
		} else { // 要删除的文件存在

			if (file.isFile()) { // 如果目标文件是文件

				return deleteFile(FileName);

			} else { // 如果目标文件是目录
				return deleteDir(FileName);
			}
		}
	}

	public static boolean deleteFile(String fileName) {

		File file = new File(fileName);// 根据指定的文件名创建File对象

		if (file.exists() && file.isFile()) { // 要删除的文件存在且是文件

			if (file.delete()) {
				System.out.println("文件" + fileName + "删除成功！");
				return true;
			} else {
				System.out.println("文件" + fileName + "删除失败！");
				return false;
			}
		} else {

			System.out.println("文件" + fileName + "不存在，删除失败！");
			return false;
		}

	}
	public  static void Str2Text(String filepath ,String Text) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		String dateste=sdf.format(Calendar.getInstance().getTime());
	    try{
	 
	    if(new File(filepath).isDirectory()){
	    	return;
	    }else{
	    	if(!new File(filepath).exists()){
	    		new File(filepath).getParentFile().mkdirs();
	    	}
	    		
	    }
	    
	    File file = new File(filepath);
	    //如果文件不存在，则自动生成文件；
	    if(!file.exists()){
	        file.createNewFile();
	    }else{
	    	
	    	 file.createNewFile();
	    }

	    //引入输出流
	    OutputStream outPutStream;

	        outPutStream = new FileOutputStream(file,true);
	       /* StringBuilder stringBuilder = new StringBuilder();//使用长度可变的字符串对象；
	        stringBuilder.append(Text+"\n");//追加文件内容
	        //TODO 这里写你的代码逻辑;


	        String context = stringBuilder.toString();//将可变字符串变为固定长度的字符串，方便下面的转码；
*/	        byte[]  bytes = (Text+"\r\n").getBytes("UTF-8");//因为中文可能会乱码，这里使用了转码，转成UTF-8；
	        outPutStream.write(bytes);//开始写入内容到文件；
	        outPutStream.close();//一定要关闭输出流；
	    }catch(Exception e){
	        e.printStackTrace();//获取异常
	    }

	}
}