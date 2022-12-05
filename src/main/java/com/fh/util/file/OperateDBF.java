package com.fh.util.file;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.linuxense.javadbf.DBFField;
import com.linuxense.javadbf.DBFWriter;

/**
 * 
 * @author Administrator
 * 
 *         DBF公共方法
 * 
 */
public class OperateDBF {

	private static Logger logger = Logger.getLogger(OperateDBF.class);

	/**
	 * @param key
	 *            key
	 * @param value
	 *            DBF字段配置 格式：文件名称 ： 字段名称、字段类型、字段长度，字段名称、字段类型、字段长度，字段名称、字段类型、字段长度
	 * @return
	 */
	public static DBFField[] getDBFfields(String value) {

		String[] f = null;

		DBFField[] fields = null;

		if (value == null || "".equals(value)) {

			return null;
		} else {
			f = value.split(",");
			logger.info(f.toString());
		}

		fields = new DBFField[f.length];

		for (int i = 0; i < f.length; i++) {

			fields[i] = new DBFField();

			String[] s = f[i].split("\\.");

			// 获取字段类型
			String type = s[1];
			logger.info("字段类型：" + type);
			// 字符类型
			fields[i].setName(s[0]);
			if ("char".equalsIgnoreCase(type)
					|| "varchar".equalsIgnoreCase(type)
					|| "varchar2".equalsIgnoreCase(type)) {
				fields[i].setDataType(DBFField.FIELD_TYPE_C);
				fields[i].setFieldLength(Integer.parseInt(s[2]));
			} else if ("date".equalsIgnoreCase(type)) {
				fields[i].setDataType(DBFField.FIELD_TYPE_D);
			} else if ("number".equalsIgnoreCase(type)) {
				fields[i].setDataType(DBFField.FIELD_TYPE_N);
				fields[i].setFieldLength(Integer.parseInt(s[2]));
				if (s.length >3){
					fields[i].setDecimalCount(Integer.parseInt(s[3]));
				}
			}
		}

		return fields;
	}

	/**
	 * 获取字段的名称
	 * 
	 * @param value
	 * @return
	 */
	public static List<String> getDBFfieldsName(String value) {

		List<String> list = new ArrayList<String>();

		String[] f = null;

		if (value == null || "".equals(value)) {
			return null;
		} else {
			f = value.split(",");
		}

		for (int i = 0; i < f.length; i++) {

			logger.info("字段的名称为：" + f[i].split("\\.")[0]);

			list.add(f[i].split("\\.")[0]);
		}

		return list;
	}

	public static Map<String, String> getDBFfieldsType(String value) {

		Map<String, String> map = new HashMap<String, String>();

		String[] f = null;

		if (value == null || "".equals(value)) {
			return null;
		} else {
			f = value.split(",");
		}

		for (int i = 0; i < f.length; i++) {

			logger.info("字段的类型为：" + f[i].split("\\.")[1]);
			
			map.put(f[i].split("\\.")[0], f[i].split("\\.")[1]);

		}

		return map;
	}

	/**
	 * 获取字段的个数
	 * 
	 * @param value
	 * @return
	 */
	public static int getDBFfieldsLength(String value) {

		String[] f = null;

		if (value == null || "".equals(value)) {
			return 0;
		} else {
			f = value.split(",");
			logger.info("DBF字段个数：" + f.length);
		}
		return f.length;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @param list
	 * @param downloadName
	 * @return
	 */
	public static void WriteDBF(HttpServletRequest request,
			HttpServletResponse response, List<Map<String, Object>> list,
			String downloadName) {

		OutputStream fos = null;

		response.setContentType("applicationnd.ms-excel");

		response.setHeader("Content-disposition", "attachment; filename="
				+ downloadName + ".dbf");

		try {
			fos = response.getOutputStream();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		try {

			DBFField[] fields = null;
			DBFWriter writer = null;
			
			Map<String,String> map = OperateDBF.getDBFfieldsType(FileUtil.pros.get(downloadName)
					.toString());

			fields = OperateDBF.getDBFfields(FileUtil.pros.get(downloadName)
					.toString());
			
			// 根据输入流初始化一个DBFReader实例，用来读取DBF文件信息
			writer = new DBFWriter();

			writer.setFields(fields);

			int dbflength = OperateDBF.getDBFfieldsLength(FileUtil.pros.get(
					downloadName).toString());

			List<String> list1 = OperateDBF.getDBFfieldsName(FileUtil.pros.get(
					downloadName).toString());

			logger.info("字段：" + list1.toString());

			for (int i = 0; i < list.size(); i++) {

				Object[] rowValues = new Object[dbflength];

				for (int j = 0; j < dbflength; j++) {
					if (list.get(i).get(list1.get(j).toString()) == null) {
						rowValues[j] = null;
					} else {
						String type = map.get(list1.get(j).toString());
						if ("char".equalsIgnoreCase(type) || "varchar".equalsIgnoreCase(type) || "varchar2".equalsIgnoreCase(type)){
							rowValues[j] = new String(list.get(i)
									.get(list1.get(j).toString()).toString()
									.getBytes(), "8859_1");
						} else if ("date".equalsIgnoreCase(type)){
							Date d = null;
							SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
							SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
							SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
							if (list.get(i).get(list1.get(j).toString()).toString().contains("/")){
								
								d = sdf1.parse(list.get(i).get(list1.get(j).toString()).toString());
							} else if (list.get(i).get(list1.get(j).toString()).toString().contains("-")){
								
								d = sdf2.parse(list.get(i).get(list1.get(j).toString()).toString());
							}else{
								d = sdf.parse(list.get(i).get(list1.get(j).toString()).toString());
							}
							rowValues[j] = d;
						} else if ("number".equalsIgnoreCase(type)){
							rowValues[j] = new Double(list.get(i)
									.get(list1.get(j).toString()).toString());
						} else {
							rowValues[j] = null;
						}
					}
				}
				writer.addRecord(rowValues);
			}

			writer.write(fos);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			try {
				fos.close();
			} catch (Exception e) {
			}
		}
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param list
	 * @param downloadName
	 * @param filepath
	 */
	public static void WriteDBF(HttpServletRequest request,
			HttpServletResponse response, List<Map<String, Object>> list,
			String downloadName,String filepath) {

		OutputStream fos = null;

		response.setContentType("applicationnd.ms-excel");

		response.setHeader("Content-disposition", "attachment; filename="
				+ downloadName + ".dbf");

		try {
			fos = response.getOutputStream();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		try {

			DBFField[] fields = null;
			DBFWriter writer = null;
			
			Map<String,String> map = OperateDBF.getDBFfieldsType(FileUtil.pros.get(filepath)
					.toString());

			fields = OperateDBF.getDBFfields(FileUtil.pros.get(filepath)
					.toString());
			
			// 根据输入流初始化一个DBFReader实例，用来读取DBF文件信息
			writer = new DBFWriter();

			writer.setFields(fields);

			int dbflength = OperateDBF.getDBFfieldsLength(FileUtil.pros.get(
					filepath).toString());

			List<String> list1 = OperateDBF.getDBFfieldsName(FileUtil.pros.get(
					filepath).toString());

			logger.info("字段：" + list1.toString());

			for (int i = 0; i < list.size(); i++) {

				Object[] rowValues = new Object[dbflength];

				for (int j = 0; j < dbflength; j++) {
					if (list.get(i).get(list1.get(j).toString()) == null) {
						rowValues[j] = null;
					} else {
						String type = map.get(list1.get(j).toString());
						if ("char".equalsIgnoreCase(type) || "varchar".equalsIgnoreCase(type) || "varchar2".equalsIgnoreCase(type)){
							rowValues[j] = new String(list.get(i).get(list1.get(j).toString()).toString().getBytes(), "8859_1");
						} else if ("date".equalsIgnoreCase(type)){
							Date d = null;
							SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
							SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
							SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
							if (list.get(i).get(list1.get(j).toString()).toString().contains("/")){
								
								d = sdf1.parse(list.get(i).get(list1.get(j).toString()).toString());
							} else if (list.get(i).get(list1.get(j).toString()).toString().contains("-")){
								d = sdf2.parse(list.get(i).get(list1.get(j).toString()).toString());
							}else {
								d = sdf.parse(list.get(i).get(list1.get(j).toString()).toString());
							}
							rowValues[j] = d;
						} else if ("number".equalsIgnoreCase(type)){
							rowValues[j] = new Double(list.get(i)
									.get(list1.get(j).toString()).toString());
						} else {
							rowValues[j] = null;
						}
					}
				}
				writer.addRecord(rowValues);
			}

			writer.write(fos);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
		} finally {
			try {
				fos.close();
			} catch (Exception e) {
			}
		}
	}

}
