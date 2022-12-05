package com.fh.util;

import java.security.MessageDigest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;

public class MD5 {
	
	protected static Logger logger = Logger.getLogger(MD5.class);
	
	/**
	 * 老方法，不敢用
	 * @param str
	 * @return
	 */
	public static String md5(String str) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			str = buf.toString();
		} catch (Exception e) {
			e.printStackTrace();

		}
		return str.toUpperCase();
	}
	
	 static MessageDigest MD5 = null;


	    static {
	        try {
	            MD5 = MessageDigest.getInstance("MD5");
	        } catch (NoSuchAlgorithmException ne) {
	            ne.printStackTrace();
	        }
	    }


	    /**
	     * 对一个文件获取md5值，用这个方法
	     * @return md5串
	     */
	    public static String getMD5(File file) {
	        FileInputStream fileInputStream = null;
	        try {
	            fileInputStream = new FileInputStream(file);
	            byte[] buffer = new byte[8192];
	            int length;
	            while ((length = fileInputStream.read(buffer)) != -1) {
	                MD5.update(buffer, 0, length);
	            }


	            return new String(Hex.encodeHex(MD5.digest()));
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	            return null;
	        } catch (IOException e) {
	            e.printStackTrace();
	            return null;
	        } finally {
	            try {
	                if (fileInputStream != null)
	                    fileInputStream.close();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	    }


	    /**
	     * 求一个字符串的md5值
	     * @param target 字符串
	     * @return md5 value
	     */
	    public static String MD5(String target) {
	        return DigestUtils.md5Hex(target);
	    }
	
	
	public static void main(String[] args) {
		//68CF63C62BC68D71FC41C028375E2F6E
		//68CF63C62BC68D71FC41C028375E2F6E
		System.out.println(md5("1234qwer.."));
	}
}
