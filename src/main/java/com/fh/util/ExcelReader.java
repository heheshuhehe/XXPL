package com.fh.util;

import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ExcelReader implements CommonExcelReader {

	private POIFSFileSystem fs;
	private HSSFWorkbook wb;
	private HSSFSheet sheet;
	private HSSFRow row;
	public HSSFCellStyle cellstyle;

	String excelPath = "";

	public ExcelReader(String excelPath) {
		// TODO Auto-generated constructor stub
		this.excelPath = excelPath;
		try {
			InputStream is = new FileInputStream(excelPath);
			fs = new POIFSFileSystem(is);
			wb = new HSSFWorkbook(fs);
		} catch (IOException e) {
			e.printStackTrace();
		}
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
		  int numsMerge =sheet.getNumMergedRegions();
		  int mergeCol=0;
		  if(numsMerge>0)
			  mergeCol=sheet.getMergedRegion(0).getLastColumn();
	
		int colNum = row.getPhysicalNumberOfCells();
		if(colNum<mergeCol)
			colNum=mergeCol;
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
	public Map<Integer, String> readExcelContent(int sheetnum,int rowfrom) {

 		Map<Integer, String> content = new HashMap<Integer, String>();
		String str = "";

		sheet = wb.getSheetAt(sheetnum);
		// 得到总行数
		int rowNum = sheet.getLastRowNum();
		row = sheet.getRow(rowfrom);
		  int numsMerge =sheet.getNumMergedRegions();
		  int mergeCol=0;
		  if(numsMerge>0)
			  mergeCol=sheet.getMergedRegion(0).getLastColumn();
	
		int colNum = row.getPhysicalNumberOfCells();
		if(colNum<mergeCol)
			colNum=mergeCol;
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
	public List<String> readExcelForCode() {
		String str = "";

		sheet = wb.getSheetAt(0);
		// 得到总行数
		int rowNum = sheet.getLastRowNum();
		row = sheet.getRow(0);
		int colNum = row.getLastCellNum();
		//colNum=11;
		// 正文内容应该从第二行开始,第一行为表头的标题
		List<String> list = new ArrayList<String>();
		for (int i = 1; i <= rowNum; i++) {
			row = sheet.getRow(i);
			if(row==null)
				continue;
			str = getCellFormatValue(row.getCell((short) 2)).trim();
			if(!"".equals(str)&&str !=null)
				list.add(str);
		}
		return list;
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
		List<String> list = new ArrayList<String>();
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
				
				contentrcc.put(getCellFormatValue(row.getCell((short) j)).trim(), i+","+j);
			}
			content.put(i, str);
			str = "";
		}
		return contentrcc;
	}
	
	/**
	 * 获取单元格数据内容为字符串类型的数据
	 * 
	 * @param cell
	 *            Excel单元格
	 * @return String 单元格数据内容
	 */
	private String getStringCellValue(HSSFCell cell) {
		String strCell = "";
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_STRING:
			strCell = cell.getStringCellValue();
			break;
		case HSSFCell.CELL_TYPE_NUMERIC:
			strCell = String.valueOf(cell.getNumericCellValue());
			break;
		case HSSFCell.CELL_TYPE_BOOLEAN:
			strCell = String.valueOf(cell.getBooleanCellValue());
			break;
		case HSSFCell.CELL_TYPE_BLANK:
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
	private String getDateCellValue(HSSFCell cell) {
		String result = "";
		try {
			int cellType = cell.getCellType();
			if (cellType == HSSFCell.CELL_TYPE_NUMERIC) {
				Date date = cell.getDateCellValue();
				result = (date.getYear() + 1900) + "-" + (date.getMonth() + 1) + "-" + date.getDate();
			} else if (cellType == HSSFCell.CELL_TYPE_STRING) {
				String date = getStringCellValue(cell);
				result = date.replaceAll("[年月]", "-").replace("日", "").trim();
			} else if (cellType == HSSFCell.CELL_TYPE_BLANK) {
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
	 * @param cell
	 * @return
	 */
	private String getCellFormatValue(HSSFCell cell) {
		String cellvalue = "";
		if (cell != null) {
			// 判断当前Cell的Type
			switch (cell.getCellType()) {
			// 如果当前Cell的Type为NUMERIC
			case HSSFCell.CELL_TYPE_NUMERIC:
			case HSSFCell.CELL_TYPE_FORMULA: {
				// 判断当前的cell是否为Date
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					// 如果是Date类型则，转化为Data格式

					// 方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
					// cellvalue = cell.getDateCellValue().toLocaleString();

					// 方法2：这样子的data格式是不带带时分秒的：2011-10-12
					Date date = cell.getDateCellValue();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					cellvalue = sdf.format(date);

				}
				// 如果是纯数字
				else {
					// 取得当前Cell的数值
					cellvalue = String.valueOf(cell.getNumericCellValue());
				}
				break;
			}
			// 如果当前Cell的Type为STRIN
			case HSSFCell.CELL_TYPE_STRING:
				// 取得当前的Cell字符串
				cellvalue = cell.getRichStringCellValue().getString();
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
		HSSFRow row=sheet.getRow(x);
		HSSFCell cell=row.getCell(y);
		cell.setCellValue(value);
	}
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value,String istext) {
		DecimalFormat df=new DecimalFormat("#,##0.00");
		DecimalFormat df2=new DecimalFormat("#,##0.0000");
		HSSFCellStyle c_style=wb.createCellStyle();
		HSSFDataFormat d_format=wb.createDataFormat();
		c_style.setDataFormat(d_format.getFormat("@"));
		HSSFSheet sheet =wb.getSheetAt(sheetnum);
		HSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		HSSFCell cell=row.getCell(columnnum);
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
				 if("1".equals(istext)){
					cell.setCellStyle(c_style);
						cell.setCellValue(value);
				}else
				{
					 newvalue=Double.parseDouble(value);
						cell.setCellValue(newvalue);
				}
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
				 if("1".equals(istext))
					 cell.setCellStyle(c_style);
				cell.setCellValue(value);
			 }
				
		 
			
	}
	
	public void setCellValue(int sheetnum,int rownum ,int columnnum,String  value) {
		DecimalFormat df=new DecimalFormat("#,##0.00");
		DecimalFormat df2=new DecimalFormat("#,##0.0000");
		HSSFCellStyle c_style=wb.createCellStyle();
		HSSFDataFormat d_format=wb.createDataFormat();
		c_style.setDataFormat(d_format.getFormat("@"));
		HSSFSheet sheet =wb.getSheetAt(sheetnum);
		HSSFRow row=sheet.getRow(rownum);
		if(row==null)
			row=sheet.createRow(rownum);
		HSSFCell cell=row.getCell(columnnum);
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
		 else  if(type==3 && value.length()<8){
			 try {
				 newvalue=Double.parseDouble(value);
					
					
				 cell.setCellType(0);   
				 cell.setCellValue(newvalue);
				 
				 //cell.setCellValue(df.format(newvalue));
			} catch (Exception e) {
				cell.setCellValue(value);
			}
		 }
			 else
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
	 * 创建要出入的行中单元格
	 * 
	 * @param row
	 * @return
	 */
	public void createCell(HSSFRow row, Map<Integer, String> data,int lastrow) {
		
		HSSFSheet sheet0= wb.getSheetAt(0);
		HSSFRow row0=sheet0.getRow(lastrow-1);
		int colnum=row0.getPhysicalNumberOfCells();
		
		//CellStyle style =row.getCell(0).getCellStyle();
		//style.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
		//style.setFillPattern(CellStyle.SOLID_FOREGROUND);

	
		
		for(int i=0;i<colnum;i++){
			HSSFCell cell=row.createCell(i);
			
			CellStyle style =row0.getCell(i).getCellStyle();
			CellStyle clonedStyle = wb.createCellStyle();
			clonedStyle.cloneStyleFrom(style);
			
			//clonedStyle.setFillBackgroundColor(IndexedColors.WHITE.index);
			clonedStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
			clonedStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);

			cell.setCellStyle(clonedStyle);
			
			
				}
	
		
		for (int i : data.keySet()) {

			row.getCell(i).setCellValue(data.get(i));
			

		}
		

	}

	public void insertRows(int insertStartPointer, Map<Integer, String> data) {

		HSSFSheet sheet1 = wb.getSheetAt(0);
		HSSFRow row = createRow(sheet1, insertStartPointer);
		createCell(row, data,insertStartPointer);
		
		

	}

	/**
	 * 找到需要插入的行数，并新建一个POI的row对象
	 * 
	 * @param sheet
	 * @param rowIndex
	 * @return
	 */
	private HSSFRow createRow(HSSFSheet sheet, Integer rowIndex) {
		HSSFRow row = null;
		if (sheet.getRow(rowIndex) != null) {
			int lastRowNo = sheet.getLastRowNum();
			sheet.shiftRows(rowIndex, lastRowNo, 1);
		}
		row = sheet.createRow(rowIndex);
		return row;
	}

	public  void setCellStyle(HSSFCellStyle fromStyle, HSSFCellStyle toStyle) {
		
		
		HSSFSheet sheet= wb.getSheetAt(0);
		HSSFRow row=sheet.getRow(0);
		HSSFCell cell=row.getCell(0);
		cellstyle=cell.getCellStyle();

	}

	public static void main(String[] args) {

		String path = "F:/123/20171224/334中建投信托-神州牧1号证券投资私募基金委托资产资产估值表20171226.xls";
		ExcelReader excelReader = new ExcelReader(path);
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
