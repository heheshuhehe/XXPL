package com.fh.util.file;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

/**
 * CSV格式导入导出公共方法
 * 
 */
public class CSVUtil {

	/**
	 * 生成为CVS文件
	 * 
	 * @param returnStr
	 *            源数据List
	 * @param map
	 *            csv文件的列表头map
	 * @param outPutPath
	 *            文件路径
	 * @param fileName
	 *            文件名称
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static File createCSVFile(List result, LinkedHashMap map,
			String outPutPath, String fileName) {
		File csvFile = null;
		BufferedWriter csvFileOutputStream = null;
		try {
			File file = new File(outPutPath);

			if (!file.exists()) {
				file.mkdirs();
			}

			// 定义文件名格式并创建
			csvFile = File.createTempFile(fileName, "",
					new File(outPutPath));
			System.out.println("csvFile----"+csvFile);
			System.out.println("fileName----"+fileName);
			// gbk使正确读取分隔符","
			csvFileOutputStream = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(csvFile), "gbk"), 1024);
			System.out.println("csvFileOutputStream----"+csvFileOutputStream);
			// 写入文件头部
			for (Iterator propertyIterator = map.entrySet().iterator(); propertyIterator
					.hasNext();) {
				java.util.Map.Entry propertyEntry = (java.util.Map.Entry) propertyIterator
						.next();
				csvFileOutputStream
						.write(" '" + (String) propertyEntry.getValue() != null ? (String) propertyEntry
								.getValue() : "" + "'");
				if (propertyIterator.hasNext()) {
					csvFileOutputStream.write(",");
				}
			}
			csvFileOutputStream.newLine();

			// 写入文件内容
			for (Iterator iterator = result.iterator(); iterator.hasNext();) {

				Object row = (Object) iterator.next();

				for (Iterator propertyIterator = map.entrySet().iterator(); propertyIterator
						.hasNext();) {
					// 获取头部
					java.util.Map.Entry propertyEntry = (java.util.Map.Entry) propertyIterator
							.next();

					csvFileOutputStream.write((String) BeanUtils.getProperty(
							row, (String) propertyEntry.getKey()));

					if (propertyIterator.hasNext()) {
						csvFileOutputStream.write(",");
					}
				}
				if (iterator.hasNext()) {
					csvFileOutputStream.newLine();
				}
			}
			csvFileOutputStream.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				csvFileOutputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return csvFile;
	}

}
