package com.fh.util;


import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;

import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ExcelReaderFor2007  implements CommonExcelReader{

	private POIFSFileSystem fs;
	private XSSFWorkbook wb;
	public XSSFWorkbook getWb() {
		return wb;
	}

	public void setWb(XSSFWorkbook wb) {
		this.wb = wb;
	}

	private XSSFSheet sheet;
	private XSSFRow row;
	public XSSFCellStyle cellstyle;
	private XSSFCellStyle defaultcellstyle;

	String excelPath = "";

	public ExcelReaderFor2007(String excelPath) {
		// TODO Auto-generated constructor stub
		this.excelPath = excelPath;
		try {
			InputStream is = new FileInputStream(excelPath);
			//fs = new POIFSFileSystem(is);
			wb = new XSSFWorkbook(is);
			defaultcellstyle=wb.createCellStyle();
			XSSFDataFormat d_format=wb.createDataFormat();
			defaultcellstyle.setDataFormat(d_format.getFormat("@"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * type=1  两位小数 负数红色  无千分符号    
	 * type=2 两位小数 负数红色  有千分符号    
	 * 
	 * */
	public XSSFCellStyle getmystyle1(XSSFCellStyle mstyle,int type) {
		
		XSSFCellStyle mystyle= (XSSFCellStyle) wb.createCellStyle();
		mystyle.cloneStyleFrom(mstyle);
		
		mystyle.setDataFormat((short) 165);
		String formatStr="#,##0.00_ ;[Red]\\-#,##0.00\\ ";
		if(type==2)
			mystyle.setDataFormat(wb.createDataFormat().getFormat(formatStr));
		
		return mystyle;
	}

	/**
	 * 读取Excel表格表头的内容
	 * 
	 * @param InputStream
	 * @return String 表头内容的数组
	 */
	public String[] readExcelTitle() {

		sheet = wb.getSheetAt(0);
		row = sheet.getRow(0);
		// 标题总列数
		int colNum = row.getPhysicalNumberOfCells();
		System.out.println("colNum:" + colNum);
		String[] title = new String[colNum];
		for (int i = 0; i < colNum; i++) {
			// title[i] = getStringCellValue(row.getCell((short) i));
			title[i] = getCellFormatValue(row.getCell((short) i));
		}
		return title;
	}

	/**
	 * 读取Excel数据内容
	 * 
	 * @param InputStream
	 * @return Map 包含单元格数据内容的Map对象
	 */
	public Map<Integer, String> readExcelContent() {

 		Map<Integer, String> content = new HashMap<Integer, String>();
		String str = "";

		sheet = wb.getSheetAt(0);
		// 得到总行数
		int rowNum = sheet.getLastRowNum();
		row = sheet.getRow(0);
		int colNum = row.getPhysicalNumberOfCells();
	
		//colNum=11;
		// 正文内容应该从第二行开始,第一行为表头的标题
		for (int i = 1; i <= rowNum; i++) {
			row = sheet.getRow(i);
			
			if(row==null)
				continue;
			int j = 0;
			str = "excel 行号：" + (i + 1) + "	^";
			while (j < colNum) {

				// 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
				// 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
				// str += getStringCellValue(row.getCell((short) j)).trim() +
				// "-";
				str += getCellFormatValue(row.getCell((short) j)).trim() + "^";
				j++;
			}
			content.put(i, str);
			str = "";
		}
		return content;
	}
	public Map<Integer, String> readExcelContent(int shhetnum,int rowfrom) {

 		Map<Integer, String> content = new HashMap<Integer, String>();
		String str = "";

		sheet = wb.getSheetAt(shhetnum);
		// 得到总行数
		int rowNum = sheet.getLastRowNum();
		row = sheet.getRow(rowfrom);
		int colNum = row.getLastCellNum();
	
		//colNum=11;
		// 正文内容应该从第二行开始,第一行为表头的标题
		for (int i = rowfrom; i <= rowNum; i++) {
			row = sheet.getRow(i);
			
			if(row==null)
				continue;
			int j = 0;
			str = "excel 行号：" + (i + 1) + "	^";
			while (j < colNum) {

				// 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
				// 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
				// str += getStringCellValue(row.getCell((short) j)).trim() +
				// "-";
				str += getCellFormatValue(row.getCell((short) j)).trim() + "^";
				j++;
			}
			content.put(i, str);
			str = "";
		}
		return content;
	}
	/**
	 * 读取Excel数据内容
	 * 
	 * @param InputStream
	 * @return Map 包含单元格数据内容的Map对象
	 */
	public Map<Integer, String> readExcelContent(int sheetnum) {

 		Map<Integer, String> content = new HashMap<Integer, String>();
		String str = "";

		sheet = wb.getSheetAt(sheetnum);
		// 得到总行数
		int rowNum = sheet.getLastRowNum();
		row = sheet.getRow(0);
		int colNum = row.getPhysicalNumberOfCells();
		//colNum=11;
		// 正文内容应该从第二行开始,第一行为表头的标题
		for (int i = 1; i <= rowNum; i++) {
			row = sheet.getRow(i);
			
			if(row==null)
				continue;
			int j = 0;
			str = "excel 行号：" + (i + 1) + "	^";
			while (j < colNum) {

				// 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
				// 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
				// str += getStringCellValue(row.getCell((short) j)).trim() +
				// "-";
				str += getCellFormatValue(row.getCell((short) j)).trim() + "^";
				j++;
			}
			content.put(i, str);
			str = "";
		}
		return content;
	}
	public Map<String, String> readExcelContentforRCC(int sheetnum) {

 		Map<Integer, String> content = new HashMap<Integer, String>();
 		Map<String, String> contentrcc = new HashMap<String, String>();
		String str = "";

		sheet = wb.getSheetAt(sheetnum);
		// 得到总行数
		int rowNum = sheet.getLastRowNum();
		row = sheet.getRow(0);
		int colNum = row.getPhysicalNumberOfCells();
		//colNum=11;
		// 正文内容应该从第二行开始,第一行为表头的标题
		for (int i = 0; i <= rowNum; i++) {
			row = sheet.getRow(i);
			
			if(row==null)
				continue;
			int j = 0;
			str = "excel 行号：" + (i + 1) + "	^";
		//	System.out.println(i);
			while (j < colNum) {
//				if(i==5&&j==3)
//					System.out.println("行"+i+"列"+j);
				// 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
				// 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
				// str += getStringCellValue(row.getCell((short) j)).trim() +
				// "-";
				str += getCellFormatValue(row.getCell((short) j)).trim() + "^";
				contentrcc.put(getCellFormatValue(row.getCell((short) j)).trim(), i+","+j);
				j++;
				
				
			}
			content.put(i, str);
			str = "";
		}
		return contentrcc;
	}
	/**
	 * istext  1 是  
	 * 
	 * */
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value,String isText) {
		DecimalFormat df=new DecimalFormat("#,##0.00");
		DecimalFormat df2=new DecimalFormat("#,##0.0000");
		XSSFCellStyle c_style=defaultcellstyle;
		
		XSSFSheet sheet =wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		XSSFCell cell=row.getCell(columnnum);
		if(cell==null){
			cell=row.createCell(columnnum);
			 //cell.setCellValue(0);
			cell.setCellType(0);
			// cell.setCellValue(0);
		}
		int type=cell.getCellType();
		double newvalue=0;
		 if(type==0){
			 try {
				 newvalue=Double.parseDouble(value);
					cell.setCellValue(newvalue);
			} catch (Exception e) {
				cell.setCellValue(value);
				cell.setCellStyle(c_style);
			}
			 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.0000")){
			 try {
				 newvalue=Double.parseDouble(value);
				// cell.setCellType(0);
				 cell.setCellValue(newvalue);
				//	cell.setCellValue(df2.format(newvalue));
					
				
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.00")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 && value.length()<8&&!value.startsWith("0")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);   
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			}
		 }
			 else{
				 if("1".equals(isText))
					 cell.setCellStyle(c_style);
				 cell.setCellValue(value);
			 }
		 
			
	}
	
	/**
	 * istext  1 是  
	 * 
	 * */
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value,String isText,XSSFCellStyle cellStyle) {
		DecimalFormat df=new DecimalFormat("#,##0.00");
		DecimalFormat df2=new DecimalFormat("#,##0.0000");
		XSSFCellStyle c_style=defaultcellstyle;
		
		XSSFSheet sheet =wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		XSSFCell cell=row.getCell(columnnum);
		if(cell==null){
			cell=row.createCell(columnnum);
			 //cell.setCellValue(0);
			cell.setCellType(0);
			// cell.setCellValue(0);
		}
		int type=cell.getCellType();
		double newvalue=0;
		 if(type==0){
			 try {
				 newvalue=Double.parseDouble(value);
					cell.setCellValue(newvalue);
			} catch (Exception e) {
				cell.setCellValue(value);
				cell.setCellStyle(c_style);
			}
			 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.0000")){
			 try {
				 newvalue=Double.parseDouble(value);
				// cell.setCellType(0);
				 cell.setCellValue(newvalue);
				//	cell.setCellValue(df2.format(newvalue));
					
				
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.00")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 && value.length()<8&&!value.startsWith("0")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);   
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			}
		 }
			 else{
				 if("1".equals(isText))
					 cell.setCellStyle(c_style);
				 cell.setCellValue(value);
			 }
		 
			
	}
	/**
	 * isnum   0 是  
	 * 
	 * */
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value, int isNUm) {
		DecimalFormat df=new DecimalFormat("#,##0.00");
		DecimalFormat df2=new DecimalFormat("#,##0.0000");
		XSSFCellStyle c_style=defaultcellstyle;
		
		XSSFSheet sheet =wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		XSSFCell cell=row.getCell(columnnum);
		if(cell==null){
			cell=row.createCell(columnnum);
			 //cell.setCellValue(0);
			cell.setCellType(0);
			// cell.setCellValue(0);
		}
		int type=cell.getCellType();
		double newvalue=0;
		 if(isNUm==0){
			 try {
				 newvalue=Double.parseDouble(value);
					cell.setCellValue(newvalue);
			} catch (Exception e) {
				cell.setCellValue(value);
				cell.setCellStyle(c_style);
			}
			 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.0000")){
			 try {
				 newvalue=Double.parseDouble(value);
				// cell.setCellType(0);
				 cell.setCellValue(newvalue);
				//	cell.setCellValue(df2.format(newvalue));
					
				
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.00")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 ){
			 
				
				cell.setCellValue(value);
			
		 }
			 else{
				 
				 cell.setCellValue(value);
			 }
		 
			
	}
	/**
	 * datatype    0默认    1 数字   2字符    3强制字符    
	 * 
	 * 
	 * StringFormat 字符格式   null 或者 ""   （#,##0.00          #,##0.0000   ）
	 * 
	 * celldataformat  常规 0                 【0】1                 【0.00】2                     【#，##0】3                【#，##0.00】 4                           【red￥#，##0】25                        【red$#，##0.00】26                                   【red#，##0.00】179   
	 * 
	 * */
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value, int datatype, String stringFormat, CellStyle theadStyle,short celldataformat) {
		DecimalFormat df=null;
		if(StringUtils.isNotEmpty(stringFormat))
			df=new DecimalFormat(stringFormat);

		
		/*XSSFCellStyle  thiscellStyle=wb.createCellStyle();
		if(theadStyle!=null)
			thiscellStyle.cloneStyleFrom(theadStyle);*/
		
		XSSFSheet sheet =wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		XSSFCell cell=row.getCell(columnnum);
		if(cell==null){
			cell=row.createCell(columnnum);
		 
		}
		cell.setCellStyle(theadStyle);
		
		int type=cell.getCellType();
		double newvalue=0;
		if(datatype==0){
			 cell.setCellValue(value);
			
		}else if(datatype==1 ){
			 try {
				 
				 newvalue=Double.parseDouble(value);
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);

			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(datatype==2 ){
			 try {
				 if(df!=null){
					 newvalue=Double.parseDouble(value);
					 cell.setCellType(1);
					 cell.setCellValue(df.format(newvalue));
				 }else{
					 cell.setCellValue(value);
				 }
				 

			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 ){
			 XSSFDataFormat d_format=wb.createDataFormat();
				if(datatype==3)
					theadStyle.setDataFormat(d_format.getFormat("@"));
			 cell.setCellValue(value);
			
		 }
			 else{
				 
				 cell.setCellValue(value);
			 }
		 
			
	}
	
	
	/**
	 * datatype    0默认    1 数字   2字符    3强制字符    
	 * 
	 * 
	 * StringFormat 字符格式   null 或者 ""   （#,##0.00          #,##0.0000   ）
	 * 
	 * celldataformat  常规 0                 【0】1                 【0.00】2                     【#，##0】3                【#，##0.00】 4                           【red￥#，##0】25                        【red$#，##0.00】26                                   【red#，##0.00】179     "#,##0.00_ ;[Red]\\-#,##0.00\\ ";//165
	 * 
	 * */
	public void setCellValue( XSSFCell  cell, String  value, int datatype, String stringFormat, XSSFCellStyle mcellStyle,short celldataformat) {
		DecimalFormat df=null;
		if(StringUtils.isNotEmpty(stringFormat))
			df=new DecimalFormat(stringFormat);

		
		XSSFCellStyle  thiscellStyle=cell.getCellStyle();
		


		
		int type=cell.getCellType();
		double newvalue=0;
		if(datatype==0){
			 cell.setCellValue(value);
			
		}else if(datatype==1 ){
			 try {
				 thiscellStyle.setDataFormat(celldataformat);
					String formatStr="#,##0.00_ ;[Red]\\-#,##0.00\\ ";//165
					if(celldataformat==179)
						thiscellStyle.setDataFormat(wb.createDataFormat().getFormat(formatStr));
					cell.setCellStyle(thiscellStyle);
				 newvalue=Double.parseDouble(value);
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);

			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(datatype==2 ){
			 try {
				 if(df!=null){
					 newvalue=Double.parseDouble(value);
					 cell.setCellType(1);
					 cell.setCellValue(df.format(newvalue));
				 }else{
					 cell.setCellValue(value);
				 }
				 

			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 ){
			 XSSFDataFormat d_format=wb.createDataFormat();
				if(datatype==3)
					mcellStyle.setDataFormat(d_format.getFormat("@"));
			 cell.setCellValue(value);
			
		 }
			 else{
				 
				 cell.setCellValue(value);
			 }
		 
			
	}
	
	/**
	
	*defaultstyle    1=字符  左对齐      2=数字 右对齐
	*
	*/
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value, XSSFCellStyle mcellStyle,int defaultstyle) {
		DecimalFormat df=null;
		short celldataformat=0;
		int  datatype=0;
		if(defaultstyle==1){
			
		}
		if(defaultstyle==2){
			datatype=1;
			celldataformat=179;
		}

		
/*		XSSFCellStyle  thiscellStyle=wb.createCellStyle();
		if(mcellStyle!=null)
			thiscellStyle.cloneStyleFrom(mcellStyle);*/
		
		XSSFSheet sheet =wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		XSSFCell cell=row.getCell(columnnum);
		if(cell==null){
			cell=row.createCell(columnnum);
		 
		}
		

		cell.setCellStyle(mcellStyle);
		int type=cell.getCellType();
		double newvalue=0;
		if(datatype==0){
			 cell.setCellValue(value);
			
		}else if(datatype==1 ){
			 try {
				 
				 newvalue=Double.parseDouble(value);
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);

			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(datatype==2 ){
			 try {
				 if(df!=null){
					 newvalue=Double.parseDouble(value);
					 cell.setCellType(1);
					 cell.setCellValue(df.format(newvalue));
				 }else{
					 cell.setCellValue(value);
				 }
				 

			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 ){
			 XSSFDataFormat d_format=wb.createDataFormat();
				if(datatype==3)
					mcellStyle.setDataFormat(d_format.getFormat("@"));
			 cell.setCellValue(value);
			
		 }
			 else{
				 
				 cell.setCellValue(value);
			 }
		 
			
	}
	public void addregion(int sheetnum, int startrow,int endrow,int startcol,int endcol,XSSFCellStyle c_style) {
		CellRangeAddress reAddress=new CellRangeAddress(startrow, endrow, startcol, endcol);
		XSSFSheet mysheet=wb.getSheetAt(sheetnum);
		mysheet.addMergedRegion(reAddress);
	}
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value) {
		DecimalFormat df=new DecimalFormat("#,##0.00");
		DecimalFormat df2=new DecimalFormat("#,##0.0000");
		
		 XSSFCellStyle  c_style=defaultcellstyle;
		XSSFSheet sheet =wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		XSSFCell cell=row.getCell(columnnum);
		if(cell==null){
			cell=row.createCell(columnnum);
			 //cell.setCellValue(0);
			cell.setCellType(0);
			// cell.setCellValue(0);
		}
		int type=cell.getCellType();
		double newvalue=0;
		 if(type==0){
			 try {
				 newvalue=Double.parseDouble(value);
					cell.setCellValue(newvalue);
			} catch (Exception e) {
				cell.setCellValue(value);
				cell.setCellStyle(c_style);
			}
			 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.0000")){
			 try {
				 newvalue=Double.parseDouble(value);
				// cell.setCellType(0);
				 cell.setCellValue(newvalue);
				//	cell.setCellValue(df2.format(newvalue));
					
				
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }else if(type==1 && cell.getCellStyle().getDataFormatString().contains("0.00")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			} 
		 }
		 else  if(type==3 && value.length()<8&& !value.startsWith("0")){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);   
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			}
		 }
			 else{
			//	cell.setCellStyle(c_style);
				 cell.setCellValue(value);
			 }
		 
			
	}
	
	/**
	 * 获取单元格数据内容为字符串类型的数据
	 * 
	 * @param cell
	 *            Excel单元格
	 * @return String 单元格数据内容
	 */
	private String getStringCellValue(XSSFCell cell) {
		String strCell = "";
		switch (cell.getCellType()) {
		case XSSFCell.CELL_TYPE_STRING:
			strCell = cell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_NUMERIC:
			strCell = String.valueOf(cell.getNumericCellValue());
			break;
		case XSSFCell.CELL_TYPE_BOOLEAN:
			strCell = String.valueOf(cell.getBooleanCellValue());
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			strCell = "";
			break;
		default:
			strCell = "";
			break;
		}
		if (strCell.equals("") || strCell == null) {
			return "";
		}
		if (cell == null) {
			return "";
		}
		return strCell;
	}

	/**
	 * 获取单元格数据内容为日期类型的数据
	 * 
	 * @param cell
	 *            Excel单元格
	 * @return String 单元格数据内容
	 */
	private String getDateCellValue(XSSFCell cell) {
		String result = "";
		try {
			int cellType = cell.getCellType();
			if (cellType == XSSFCell.CELL_TYPE_NUMERIC) {
				Date date = cell.getDateCellValue();
				result = (date.getYear() + 1900) + "-" + (date.getMonth() + 1) + "-" + date.getDate();
			} else if (cellType == XSSFCell.CELL_TYPE_STRING) {
				String date = getStringCellValue(cell);
				result = date.replaceAll("[年月]", "-").replace("日", "").trim();
			} else if (cellType == XSSFCell.CELL_TYPE_BLANK) {
				result = "";
			}
		} catch (Exception e) {
			System.out.println("日期格式不正确!");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 根据HSSFCell类型设置数据
	 * 
	 * @param xssfCell
	 * @return
	 */
	private String getCellFormatValue(XSSFCell xssfCell) {
		String cellvalue = "";
		if (xssfCell != null) {
			// 判断当前Cell的Type
			switch (xssfCell.getCellType()) {
			// 如果当前Cell的Type为NUMERIC
			case HSSFCell.CELL_TYPE_NUMERIC:
			 {
				// 判断当前的cell是否为Date
				if (HSSFDateUtil.isCellDateFormatted(xssfCell)) {
					// 如果是Date类型则，转化为Data格式
					
					// 方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
					// cellvalue = cell.getDateCellValue().toLocaleString();

					// 方法2：这样子的data格式是不带带时分秒的：2011-10-12
					Date date = xssfCell.getDateCellValue();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					cellvalue = sdf.format(date);

				}
				// 如果是纯数字
				else {
					NumberFormat nf=NumberFormat.getInstance();
					// 取得当前Cell的数值
					cellvalue = String.valueOf(nf.format(xssfCell.getNumericCellValue()).replace(",", ""));
				}
				break;
			}
			case HSSFCell.CELL_TYPE_FORMULA: 
				cellvalue =xssfCell.getCTCell().getV();
				break;
			// 如果当前Cell的Type为STRIN
			case HSSFCell.CELL_TYPE_STRING:
				// 取得当前的Cell字符串
				cellvalue = xssfCell.getRichStringCellValue().getString();
				break;
			// 默认的Cell值
			default:
				cellvalue = " ";
			}
		} else {
			cellvalue = "";
		}
		return cellvalue;

	}
	
	public void setCellvalue(int x,int y,String value) {
		sheet = wb.getSheetAt(0);
		XSSFRow row=sheet.getRow(x);
		XSSFCell cell=row.getCell(y);
		cell.setCellValue(value);
	}

	/**
	 * 保存工作薄
	 * 
	 * @param wb
	 */
	public void saveExcelOther(String path) {
		FileOutputStream fileOut;
		try {
			fileOut = new FileOutputStream(path);
			wb.write(fileOut);
			fileOut.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 保存工作薄
	 * 
	 * @param wb
	 */
	public void saveExcel() {

		try {
			FileOutputStream fileOut = new FileOutputStream(excelPath);
			wb.write(fileOut);

			fileOut.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	/**
	 * 保存工作薄
	 * 
	 * @param wb
	 */
	public void saveExcel(String newpath) {

		try {
			FileOutputStream fileOut = new FileOutputStream(newpath);
			wb.write(fileOut);

			fileOut.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	/**
	 * 保存工作薄
	 * 
	 * @param wb
	 */
	public void saveExcelsuper(String newpath) {

		try {
			
			FileOutputStream fileOut = new FileOutputStream(newpath);
			BufferedOutputStream bout=new BufferedOutputStream(fileOut);
			SXSSFWorkbook wbsuper=new SXSSFWorkbook(wb,100);
			wbsuper.write(bout);
			bout.flush();
			fileOut.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	/**
	 * 创建要出入的行中单元格
	 * 
	 * @param row2
	 * @return
	 */
	public void createCell(XSSFRow row2, Map<Integer, String> data,int lastrow) {
		
		XSSFSheet sheet0= wb.getSheetAt(0);
		XSSFRow row0=sheet0.getRow(lastrow-1);
		int colnum=row0.getPhysicalNumberOfCells();
		
		//CellStyle style =row.getCell(0).getCellStyle();
		//style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
		//style.setFillPattern(CellStyle.SOLID_FOREGROUND);

	
		
		for(int i=0;i<colnum;i++){
			XSSFCell cell=row2.createCell(i);
			
			CellStyle style =row0.getCell(i).getCellStyle();
			CellStyle clonedStyle =defaultcellstyle;
			clonedStyle.cloneStyleFrom(style);
			
			//clonedStyle.setFillBackgroundColor(IndexedColors.WHITE.index);
			clonedStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
			clonedStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);

			cell.setCellStyle(clonedStyle);
			
			
				}
	
		
		for (int i : data.keySet()) {

			row2.getCell(i).setCellValue(data.get(i));
			

		}
		

	}
	public void createCell(XSSFRow row2, Map<Integer, String> data,int rowNum,CellStyle style ) {

		//CellStyle style =row.getCell(0).getCellStyle();
		//style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
		//style.setFillPattern(CellStyle.SOLID_FOREGROUND);

		for(int i=0;i<rowNum;i++){
			XSSFCell cell=row2.createCell(i);
					
		//	CellStyle clonedStyle = wb.createCellStyle();
		//	clonedStyle.
		//	clonedStyle.cloneStyleFrom(style);
			
			//clonedStyle.setFillBackgroundColor(IndexedColors.WHITE.index);
			//clonedStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
			//clonedStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);

			cell.setCellStyle(style);

				}
	
		
		for (int i : data.keySet()) {

			row2.getCell(i).setCellValue(data.get(i));
			

		}
		

	}
	
	public void createCellData(XSSFRow row2, Map<Integer, Object> data,int rowNum,CellStyle style ) {

		//CellStyle style =row.getCell(0).getCellStyle();
		//style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
		//style.setFillPattern(CellStyle.SOLID_FOREGROUND);

		for(int i=0;i<rowNum;i++){
			XSSFCell cell=row2.createCell(i);
					
		//	CellStyle clonedStyle = wb.createCellStyle();
		//	clonedStyle.
		//	clonedStyle.cloneStyleFrom(style);
			
			//clonedStyle.setFillBackgroundColor(IndexedColors.WHITE.index);
			//clonedStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
			//clonedStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);

			cell.setCellStyle(style);

				}
	
		int datatype=0;
		short celldataformat=0;
		for (int i : data.keySet()) {
			
		
			if(data.get(i)  instanceof Double || data.get(i)  instanceof Integer || data.get(i)  instanceof Float){
				
				celldataformat=179;
				datatype=1;
			}
				
			else{
				celldataformat=0;
				datatype=0;
			}
				
				
			setCellValue(row2.getCell(i), data.get(i).toString(), datatype, "", null, celldataformat);
		
		}
		

	}
	public void insertRows(int insertStartPointer, Map<Integer, String> data) {

		XSSFSheet sheet1 = wb.getSheetAt(0);
		XSSFRow row = createRow(sheet1, insertStartPointer);
		createCell(row, data,insertStartPointer);
		
		

	}
	
	public void insertRows(int  sheetnum,int insertStartPointer,int rowNum, Map<Integer, String> data,CellStyle mcellstyle ) {

		XSSFSheet sheet1 = wb.getSheetAt(sheetnum);
		XSSFRow row = createRow(sheet1, insertStartPointer);
		createCell(row, data,rowNum,mcellstyle);

	}

	/**
	 * 
	 * rowNum 新增的行的总列数
	 * */
	public void insertRowData(int sheetnum,int insertStartPointer,int rowNum, Map<Integer, Object> data,CellStyle mcellstyle ) {

		XSSFSheet sheet1 = wb.getSheetAt(sheetnum);
		XSSFRow row = createRow(sheet1, insertStartPointer);
		createCellData(row, data,rowNum,mcellstyle);

	}
	/**
	 * 找到需要插入的行数，并新建一个POI的row对象
	 * 
	 * @param sheet1
	 * @param rowIndex
	 * @return
	 */
	private XSSFRow createRow(XSSFSheet sheet1, Integer rowIndex) {
		XSSFRow row = null;
		if (sheet1.getRow(rowIndex) != null) {
			int lastRowNo = sheet1.getLastRowNum();
			sheet1.shiftRows(rowIndex, lastRowNo, 1);
		}
		row = sheet1.createRow(rowIndex);
		return row;
	}

	public  void setCellStyle(HSSFCellStyle fromStyle, HSSFCellStyle toStyle) {
		
		
		XSSFSheet sheet= wb.getSheetAt(0);
		XSSFRow row=sheet.getRow(0);
		XSSFCell cell=row.getCell(0);
		cellstyle=cell.getCellStyle();

	}
	
	public  XSSFCellStyle getCellStyle(int sheetnum, int col, int rownum) {
		
		
		XSSFSheet sheet= wb.getSheetAt(sheetnum);
		XSSFRow row=sheet.getRow(rownum);
		XSSFCell cell=row.getCell(col);
		 return  cell.getCellStyle();

	}
	public void insertRow(XSSFWorkbook wb , int sheetnum, int startrow, int rows) {
		
		XSSFSheet sheet=wb.getSheetAt(sheetnum);
		
		sheet.shiftRows(startrow+1, sheet.getLastRowNum(), sheetnum,true,false);
		for(int i=0;i<rows;i++){
			XSSFRow srcRow=null;
			XSSFRow destRow=null;
			srcRow=sheet.getRow(startrow);
			destRow=sheet.createRow(++startrow);
			
		}
		
	}
	public void setDropListValue(int sheetnum, int row,int col, String value) {
		
		
		XSSFSheet tsheet=wb.getSheetAt(sheetnum);
		List<XSSFDataValidation>  validtions= tsheet.getDataValidations();
		String newvalue="";
		for(XSSFDataValidation valid:validtions){
			CellRangeAddressList cral=valid.getRegions();
			if(cral==null||cral.getSize()==0){
				continue;
			}
			int trow =cral.getCellRangeAddress(0).getFirstRow();
			int tcol =cral.getCellRangeAddress(0).getFirstColumn();
			
			if(row==trow&& col==tcol){
				
				DataValidationConstraint constraint=valid.getValidationConstraint();
				String [] strs=constraint.getExplicitListValues();
				for(String str:strs){
					if(str.contains(value)){
						newvalue=str;
						setCellValue(sheetnum, row, col, str);
						break;
					}
				}
			}
		}
		if(value.equals(newvalue)){
			setCellValue(sheetnum, row, col, value);
		}
	}

	public static void main(String[] args) {

		String path = "L:/系统专用/季度更新/202103/SSG131_石锋资产重剑9号私募证券投资基金_季度更新（私募产品运行表）_202103_20210930.xlsx";
		ExcelReaderFor2007 excelReader = new ExcelReaderFor2007(path);
		
		
		excelReader.setDropListValue(4, 3, 6, "B");
		excelReader.saveExcel();
		
		excelReader.readExcelContentforRCC(3);
		
		XSSFCellStyle  ce =excelReader.getCellStyle(1, 0, 0);
		
		ce.getDataFormat();
		ce.getDataFormatString();
		
		String[] title = excelReader.readExcelTitle();
		System.out.println("获得Excel表格的标题:");
		for (String s : title) {
			System.out.println(s + " ");
		}

		// 对读取Excel表格内容测试

		Map<Integer, String> map = excelReader.readExcelContent();
		System.out.println("获得Excel表格的内容:");
		for (int i = 1; i <= map.size(); i++) {
			System.out.println(map.get(i));
		}
	}

}
