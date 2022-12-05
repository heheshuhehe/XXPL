package sinosoft.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


import org.apache.log4j.Logger;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;




public class PDFUtilNew {
	private  static  Logger logger = Logger.getLogger(PDFUtilNew.class);
	Document document = new Document();// 建立一个Document对象
	int maxWidth = 520; 

	/*标题----微软雅黑  小二
	正文---微软雅黑  四号
	列表----微软雅黑   五号*/

	 private static Font headfont;// 设置字体大小
	 private static Font keyfont;// 设置字体大小
	 private static Font keyfont1;// 设置字体大小
	 private static Font textfont;// 设置字体大小
	 private static Font otherfont;// 设置字体大小
	 private static Font textfont1;//设置字体大小
	 private static Font textfont00;// 设置字体大小
	 private static Font textfont22;//设置字体大小
	 private static Font headfont_jj;
	 private static Font textfont_jj03;
	 private static Font textfont_jj01;
	 private static Font textfont_jj02;
	
	static{
		//中文格式
		BaseFont bfChinese;
		//BaseFont bfChinese1;
		try{
			
			// 设置中文显示
			bfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
			//bfChinese1 = BaseFont.createFont("C:/WINDOWS/Fonts/微软雅黑/msyh.ttc",BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			headfont = new Font(bfChinese, 15, Font.BOLD);// 设置字体大小---加粗
			keyfont = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小---加粗
			keyfont1 = new Font(bfChinese, 7, Font.BOLD);// 设置字体大小---加粗
			otherfont = new Font(bfChinese, 8, Font.NORMAL);// 设置字体大小
			textfont = new Font(bfChinese, 7, Font.NORMAL);// 设置字体大小
			textfont1 = new Font(bfChinese, 6, Font.NORMAL);// 设置字体大小
			textfont00 = new Font(bfChinese, 7, Font.BOLD);// 设置字体大小---加粗
			textfont22 = new Font(bfChinese, 6, Font.BOLD);// 设置字体大小---加粗
			headfont_jj = new Font(bfChinese, 20, Font.NORMAL);// 设置字体大小---加粗
			textfont_jj01 = new Font(bfChinese, 15, Font.NORMAL);// 设置字体大小---加粗 4号
			textfont_jj02 = new Font(bfChinese, 13, Font.NORMAL);// 设置字体大小---加粗 5号
			textfont_jj03 = new Font(bfChinese, 15, Font.NORMAL);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTable(String [] cols){
		PdfPTable table = new PdfPTable(cols.length);
	//	float[] columnWidth = {74,65,44,42,54,40,54,54,44,44,64};
		//float[] columnWidth = {124,85,44,22,52,40,34,52,44,48,34};
		
		float[] columnWidth =new float [cols.length];
		int avgWidth=555/cols.length;
		int i=0;
		for(String col:cols){
			if(col.contains("c01"))
				columnWidth[i]=avgWidth+20;
			else if(col.contains("c04"))
				columnWidth[i]=avgWidth-10;
			else if(col.contains("c06"))
				columnWidth[i]=avgWidth-5;
			else if(col.contains("c09"))
				columnWidth[i]=avgWidth-10;
			else if(col.contains("c11"))
				columnWidth[i]=avgWidth-10;
			else
				columnWidth[i]=avgWidth;
			i++;
		}
		try
		  {
		   table.setTotalWidth(585);//设置表格的总宽度
		   table.setTotalWidth(columnWidth);//设置表格的各列宽度
		   table.setLockedWidth(true);//将宽度锁定。
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);//设置内 容水平居中显示 
		   table.getDefaultCell().setBorder(1);//设置表格边框为1
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	public PdfPTable createJZTable(String [] cols){
		PdfPTable table = new PdfPTable(cols.length);
	//	float[] columnWidth = {74,65,44,42,54,40,54,54,44,44,64};
		//float[] columnWidth = {124,85,44,22,52,40,34,52,44,48,34};
		
		float[] columnWidth =new float [cols.length];
		int avgWidth=780/cols.length;
		int i=0;
		for(String col:cols){
			if(col.contains("c01"))
				columnWidth[i]=avgWidth+20;
			else if(col.contains("c04"))
				columnWidth[i]=avgWidth-10;
			else if(col.contains("c06"))
				columnWidth[i]=avgWidth-5;
			else if(col.contains("c09"))
				columnWidth[i]=avgWidth-10;
			else if(col.contains("c11"))
				columnWidth[i]=avgWidth-10;
			else
				columnWidth[i]=avgWidth;
			i++;
		}
		try
		  {
		   table.setTotalWidth(585);//设置表格的总宽度
		   table.setTotalWidth(columnWidth);//设置表格的各列宽度
		   table.setLockedWidth(true);//将宽度锁定。
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);//设置内 容水平居中显示 
		   table.getDefaultCell().setBorder(1);//设置表格边框为1
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTable_JJFE(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		float[] columnWidth = {72,150,72,150};
		  try
		  {
		   table.setTotalWidth(520);//设置表格的总宽度
		   table.setTotalWidth(columnWidth);//设置表格的各列宽度
		   table.setLockedWidth(true);//将宽度锁定。
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);//设置内 容水平居中显示 
		   table.getDefaultCell().setBorder(1);//设置表格边框为1
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	

	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTableHead(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		float[] columnWidth = {90,380,80};
		  try
		  {
		   table.setTotalWidth(maxWidth);
		   table.setTotalWidth(columnWidth);
		   table.getRowHeight(15);
		   table.setLockedWidth(true);
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);
		   table.getDefaultCell().setBorder(1);
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTableFoot1(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		float[] columnWidth = {90,370,80};
		  try
		  {
		   table.setTotalWidth(maxWidth);
		   table.setTotalWidth(columnWidth);
		   table.setLockedWidth(true);
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);
		   table.getDefaultCell().setBorder(1);
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTableFoot2(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		float[] columnWidth = {120,340,85};
		  try
		  {
		   table.setTotalWidth(maxWidth);
		   table.setTotalWidth(columnWidth);
		   table.setLockedWidth(true);
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);
		   table.getDefaultCell().setBorder(1);		  
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTableFoot3(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		float[] columnWidth = {90,370,80};
		  try
		  {
		   table.setTotalWidth(maxWidth);
		   table.setTotalWidth(columnWidth);
		   table.setLockedWidth(true);
		   table.setHorizontalAlignment(Element.ALIGN_CENTER);
		   table.getDefaultCell().setBorder(1);
		  }
		  catch (Exception e)
		  {
		   e.printStackTrace();
		  }
		  return table;

	}
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @param colspan  占多少列
	 * @param boderFlag  是否有有边框
	 * @return    添加的文本框
	 */
	public PdfPCell createCell(String value, Font font, int align, int colspan,
		   boolean boderFlag){
		 
		  PdfPCell cell = new PdfPCell();
		  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		  cell.setHorizontalAlignment(align);
		  cell.setColspan(colspan);
		  cell.setPhrase(new Phrase(value, font));
		  cell.setPadding(5.0f);
		  cell.setMinimumHeight(15);
		  if (!boderFlag)
		  {
		   cell.setBorder(0);
		   cell.setPaddingTop(15.0f);
		   cell.setPaddingBottom(8.0f);
		  }
		return cell;
	}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @param colspan  占多少列
	 * @param boderFlag  是否有有边框
	 * @return    添加的文本框
	 */
	public PdfPCell createCell_JJFE(String value, Font font, int align, int colspan,
		   boolean boderFlag){
		 
		  PdfPCell cell = new PdfPCell();
		  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		  cell.setHorizontalAlignment(align);
		  cell.setColspan(colspan);
		  
		  cell.setPhrase(new Phrase(value, font));
		  
		  cell.setPadding(0.0f);
		  cell.setMinimumHeight(20);
		  if (!boderFlag)
		  {
		   cell.setBorder(0);
		   cell.setPaddingTop(25.0f);
		   cell.setPaddingLeft(15.0f);
		   cell.setPaddingBottom(10.0f);
		  }
		return cell;
	}
	
	
	
	public PdfPCell createCell_JJChunk(String value,String value1,String value2, Font font, int align, int colspan,
			   boolean boderFlag) throws DocumentException, IOException{
			 
			  PdfPCell cell = new PdfPCell();
			  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			  cell.setHorizontalAlignment(align);
			  cell.setColspan(colspan);
			  Chunk chunk1 = new Chunk(value,
					  new Font(BaseFont.createFont("STSong-Light", 
							  "UniGB-UCS2-H",BaseFont.NOT_EMBEDDED), 15, Font.NORMAL)); 
			  Chunk chunk2 = new Chunk(value1,
					  new Font(BaseFont.createFont("STSong-Light", 
							  "UniGB-UCS2-H",BaseFont.NOT_EMBEDDED), 15, Font.BOLD)); //17
			  Chunk chunk3 = new Chunk(value2,
					  new Font(BaseFont.createFont("STSong-Light", 
							  "UniGB-UCS2-H",BaseFont.NOT_EMBEDDED), 15, Font.NORMAL)); 
			  Phrase phrase =  new Phrase();
			  phrase.add(chunk1);
			  phrase.add(chunk2);
			  phrase.add(chunk3);
			  
			  cell.setPhrase(phrase);
			  
			  cell.setPadding(0.0f);
			  cell.setMinimumHeight(20);
			  if (!boderFlag)
			  {
			   cell.setBorder(0);
			   cell.setPaddingTop(25.0f);
			   cell.setPaddingLeft(15.0f);
			   cell.setPaddingBottom(10.0f);
			  }
			return cell;
		}
	
	public PdfPCell createCell_JJFEF(String value, Font font, int align, int colspan,
			   boolean boderFlag){
			 
			  PdfPCell cell = new PdfPCell();
			  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			  cell.setHorizontalAlignment(align);
			  cell.setColspan(colspan);
			  cell.setPhrase(new Phrase(value, font));
			  cell.setPadding(0.0f);
			  cell.setMinimumHeight(20);
			  if (!boderFlag)
			  {
			   cell.setBorder(0);
			   cell.setPaddingTop(15.0f);
			   cell.setPaddingLeft(15.0f);
			   cell.setPaddingBottom(10.0f);
			  }
			return cell;
		}
	
	
	
	/**
	 * 文成文件
	 * @param file 待生成的文件名
	 */
	public void CreatePdf(File file){
		document.setPageSize(PageSize.A4);// 设置页面大小
		document.setMargins(-60, -60, 0, 30);
		try{
			PdfWriter.getInstance(document, new FileOutputStream(file));
			document.open();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	public void CreateHengPdf(File file){
		document.setPageSize(new Rectangle(842F,595F));// 设置页面大小
		document.setMargins(-60, -60, 0, 30);
		try{
			PdfWriter.getInstance(document, new FileOutputStream(file));
			document.open();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	//初始化文件
	public void initFile(File file){
		document.setPageSize(PageSize.A4);// 设置页面大小
		document.setMargins(0, 0, 0, 30);
		try	{
			PdfWriter.getInstance(document, new FileOutputStream(file));
			document.open();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//初始化文件
		public void initFile_JJFE(File file){
			document.setPageSize(PageSize.A4);// 设置页面大小
			document.setMargins(5, 100, 50, 100);
			try	{
				PdfWriter.getInstance(document, new FileOutputStream(file));
				document.open();
			}catch (Exception e){
				e.printStackTrace();
			}
		}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @return    添加的文本框
	 */
	public PdfPCell createCell(String value, Font font, int align){
		PdfPCell cell = new PdfPCell();
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setHorizontalAlignment(align);
		cell.setPhrase(new Phrase(value, font));
		cell.setMinimumHeight(15);
		return cell;
	}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @return    添加的文本框
	 */
	public PdfPCell create_foot_Cell(String value, Font font, int align, int colspan,
			   boolean boderFlag){
		 
			  PdfPCell cell = new PdfPCell();
			  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			  cell.setHorizontalAlignment(align);
			  cell.setColspan(colspan);
			  cell.setPhrase(new Phrase(value, font));
			  cell.setPadding(0f);
			  cell.setMinimumHeight(10f);
			  if (!boderFlag)
			  {
			   cell.setBorder(0);
			   cell.setPaddingTop(7f);
			   cell.setPaddingBottom(0f);
			  }
			return cell;
	}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @return    添加的文本框
	 */
	public PdfPCell createCell_JJFEZ(String value, Font font, int align){
		PdfPCell cell = new PdfPCell();
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setHorizontalAlignment(align);
		cell.setPhrase(new Phrase(value, font));
		cell.setMinimumHeight(25);
		cell.setBorder(0);
		return cell;
	}
	
	public PdfPCell createCell_JJFE(String value, Font font, int align){
		PdfPCell cell = new PdfPCell();
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setHorizontalAlignment(align);
		cell.setPhrase(new Phrase(value, font));
		cell.setMinimumHeight(25);
		
		return cell;
	}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @return    添加的文本框
	 */
	public PdfPCell createCell_JJFEj(String value, Font font, int align,int heigh,int leftwith,int rightwith){
		PdfPCell cell = new PdfPCell();
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setHorizontalAlignment(align);
		cell.setPhrase(new Phrase(value, font));
		cell.setMinimumHeight(heigh);
		cell.setPaddingLeft(leftwith);
		cell.setPaddingRight(rightwith);
		return cell;
	}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @return    添加的文本框
	 */
	public PdfPCell createCells(String value, Font font,int align,int colspan, boolean boderFlag){
		 PdfPCell cell = new PdfPCell();
		 cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		 cell.setHorizontalAlignment(align);
		 cell.setPhrase(new Phrase(value, font));
		 cell.setMinimumHeight(15);
		 cell.setPadding(5.0f);
		 if (!boderFlag)
		  {
		   cell.setBorder(0);
		   cell.setPaddingTop(15.0f);
		   cell.setPaddingBottom(8.0f);
		  }
		 return cell;
	}
	
	/**
	 * 为表格添加一个内容
	 * @param value   值
	 * @param font   字体
	 * @return    添加的文本框
	 */
	public PdfPCell createCell(String value, Font font){
		 PdfPCell cell = new PdfPCell();
		 cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		 cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		 cell.setPhrase(new Phrase(value, font));
		 cell.setMinimumHeight(15);
		 return cell;
	}
	/**
	 * 生成ＰＤＦ(估值表)
	 * @param headorder
	 * @param head
	 * @param list
	 * @param colNum
	 * @param header
	 */
	public void CreatValuationTable(String [] headorder,String [] headnames,List list,String productName,String time,String unitNet,String opertor,String create_operator) {
	 try{
		// 创建一个表格
		int result = list.size();
		Date nowTime = new Date();
		SimpleDateFormat sdFormatter = new SimpleDateFormat("YYYY-MM-dd");
		String retStrFormatNowDate = sdFormatter.format(nowTime);
		
		
		
		
		int page=result%35==0?result/35:result/35+1;//分页总页数，每页35行
		for(int k = 0 ; k < page ; k++){
			
			
			//表头中文名
			//String[] head = {"科目代码","科目名称","数量","单位成本","成本","成本占净值%","行情收市价","市值","市值占净值%","估值增值","停牌信息"};
			String[] head = headnames;
			
			String[] overhead = {"净值日期: "+time,"","单位净值: "+unitNet};
			//String[] foot1 = {"打印操作员: "+opertor,"制表: "+create_operator,"打印日期: "+retStrFormatNowDate};
			String[] foot1 = {"","",""};
		//	String[] foot2 = {"制表: "+create_operator,"复核： ","审核: "};//
			String[] foot2 = {"","",""};//
			String[] foot3 = {"","第"+(k+1)+"页/共"+page+"页",""};
			//总列数
			int colNum = head.length;
			PdfPTable table = createTable(headorder);
			PdfPTable headTable = createTableHead(overhead.length);
			PdfPTable footTable1 = createTableFoot1(foot1.length);
			PdfPTable footTable2 = createTableFoot2(foot2.length);
			PdfPTable footTable3 = createTableFoot3(foot3.length);
			
			// 添加备注,靠左，不显示边框
			headTable.addCell(createCell("资产估值表", headfont, Element.ALIGN_CENTER, overhead.length,false));
			if(productName.contains("@@")){
				productName = productName.split("@@")[0];
			}
			headTable.addCell(createCell("申万宏源证券有限公司__"+productName+"__专用表", keyfont, Element.ALIGN_CENTER, overhead.length,false));
			for(int i = 0 ; i < overhead.length ; i++){
				headTable.addCell(createCell(overhead[i], otherfont, Element.ALIGN_CENTER,1,false));
			}
			
			
			//设置每列的字体
			for(int i = 0 ; i < head.length ; i++){
				if(i==3||i==5||i==6||i==8||i==9||i==10){
					table.addCell(createCell(head[i], keyfont1, Element.ALIGN_CENTER));
				}else{
					table.addCell(createCell(head[i], keyfont, Element.ALIGN_CENTER));
				}
			}
			int size = 0;
			if(k == (page-1) && page > 1){
				size = list.size()-37*(page-1);
			}else if(k==0&&page==1){
				size = list.size();
			}else{
				size = 35*(k+1);
			}
			if(null != list && list.size() > 0){
				for(int i = 0+(35*k) ; i < (35*k)+35 ; i++){
				if(i<list.size()){	
					//根据fkmbm和km_p的值判断行加粗
					Map map = (Map) list.get(i);
					String fkmbm = (String) map.get("c01");
					if (fkmbm == null || "".equals(fkmbm)){
						fkmbm = "";
					}
					String km_p = "";
					if(i<list.size()-1){
						Map map1 = (Map) list.get(i+1);
						km_p = (String) map1.get("c01");
						if (km_p == null || "".equals(km_p)){
							km_p = "";
						}
					}else{
						km_p = "不存在此信息！";
					}
					if(fkmbm.equals(km_p)){
						for(int j = 0 ; j < colNum ; j ++){
							//获得KEY值
							String firstLetter = headorder[j].trim(); 
							try{
								try{
									//添加数据
									String values = (String) map.get(firstLetter);
									if(values == "null"||values == null){
										values = "";
									}
									if(j==0||j==1){
										table.addCell(createCell(values, textfont00,Element.ALIGN_LEFT));
									}else if(j==2||j==4||j==7){
										if(values.length()>=9){
											table.addCell(createCell(values, textfont22,Element.ALIGN_RIGHT));
										}else{
											table.addCell(createCell(values, textfont00,Element.ALIGN_RIGHT));
										}
									}else if(j==9||j==10||j==11){
										table.addCell(createCell(values, textfont22,Element.ALIGN_RIGHT));
									}else{
										table.addCell(createCell(values, textfont00,Element.ALIGN_RIGHT));
									}
								}
								catch (IllegalArgumentException e){
									 logger.error(e.toString());
								} 
							}catch (SecurityException e){
								 logger.error(e.toString());
							}
						}
					}else{
						for(int j = 0 ; j < colNum ; j ++){
							//获得KEY值
							String firstLetter = headorder[j].trim(); 
							try{
								try{
									//添加数据
									String values = String.valueOf(map.get(firstLetter));
									if(values == "null"||values == null){
										values = "";
									}
									if(j==0||j==1){
										table.addCell(createCell(values, textfont,Element.ALIGN_LEFT));
									}else if(j==2||j==4||j==7){
										if(values.length()>=9){
											table.addCell(createCell(values, textfont1,Element.ALIGN_RIGHT));
										}else{
											table.addCell(createCell(values, textfont,Element.ALIGN_RIGHT));
										}
									}else if(j==9||j==10||j==11){
										table.addCell(createCell(values, textfont1,Element.ALIGN_RIGHT));
									}else{
										table.addCell(createCell(values, textfont,Element.ALIGN_RIGHT));
									}
								}
								catch (IllegalArgumentException e){
									 logger.error(e.toString());
								} 
							}catch (SecurityException e){
								 logger.error(e.toString());
							}
						}
					}
				}	
				}
				
			}
			//
			for(int i = 0 ; i < foot1.length ; i++){
				if(i==0||i==2){
					footTable1.addCell(create_foot_Cell(foot1[i], otherfont, Element.ALIGN_LEFT,1,false));
				}else{
					footTable1.addCell(create_foot_Cell(foot1[i], otherfont, Element.ALIGN_CENTER,1,false));
				}
				
			}
			//
			for(int i = 0 ; i < foot2.length ; i++){
				if(i==0||i==2){
					footTable2.addCell(create_foot_Cell(foot2[i], otherfont, Element.ALIGN_LEFT,1,false));
				}else{
					footTable2.addCell(create_foot_Cell(foot2[i], otherfont, Element.ALIGN_CENTER,1,false));
				}
			}
			
			for(int i = 0 ; i < foot3.length ; i++){
				if(i==0||i==2){
					footTable3.addCell(create_foot_Cell(foot3[i], otherfont, Element.ALIGN_LEFT,1,false));
				}else{
					footTable3.addCell(create_foot_Cell(foot3[i], otherfont, Element.ALIGN_CENTER,1,false));
				}
			}
			//创建新空白页
			document.newPage();
			//将表格添加到文档中
			document.add(headTable);
			document.add(table);
			document.add(footTable1);
			document.add(footTable3);
			//document.
		  }
		}catch (DocumentException e){
			  logger.error(e.toString());
		}catch (Exception e) {
			e.printStackTrace();
		}
	 finally{
			//关闭流
			document.close();
		}
	}
	public void CreatJZTable(String [] headorder,String [] headnames,List list,String productName,String time,String unitNet,String opertor,String create_operator) {
		 try{
			// 创建一个表格
			int result = list.size();
			Date nowTime = new Date();
			SimpleDateFormat sdFormatter = new SimpleDateFormat("YYYY-MM-dd");
			String retStrFormatNowDate = sdFormatter.format(nowTime);
			BaseFont mybfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
			Font	mykeyfont = new Font(mybfChinese, 10, Font.NORMAL);// 设置字体大小---加粗
			Font	mykeyfont2 = new Font(mybfChinese, 12, Font.BOLD);// 设置字体大小---加粗
			Font	mykeyfont3 = new Font(mybfChinese, 14, Font.BOLD);// 设置字体大小---加粗
			
			
			
			int page=result%35==0?result/35:result/35+1;//分页总页数，每页35行
			for(int k = 0 ; k < page ; k++){
				
				
				//表头中文名
				//String[] head = {"科目代码","科目名称","数量","单位成本","成本","成本占净值%","行情收市价","市值","市值占净值%","估值增值","停牌信息"};
				String[] head = headnames;
		/*		
				String[] overhead = {"净值日期: "+time,"","单位净值: "+unitNet};
				String[] foot1 = {"打印操作员: "+opertor,"制表: "+create_operator,"打印日期: "+retStrFormatNowDate};
				String[] foot2 = {"制表: "+create_operator,"复核： ","审核: "};//
				String[] foot3 = {"","第"+(k+1)+"页/共"+page+"页",""};*/
				String[] overhead = {"","",""};
				String[] foot1 = {"","",""};
				String[] foot2 = {"","",""};//
				String[] foot3 = {"","",""};
				//总列数
				int colNum = head.length;
				PdfPTable table = createJZTable(headorder);
				PdfPTable headTable = createTableHead(overhead.length);
				PdfPTable footTable1 = createTableFoot1(foot1.length);
				PdfPTable footTable2 = createTableFoot2(foot2.length);
				PdfPTable footTable3 = createTableFoot3(foot3.length);
				
				// 添加备注,靠左，不显示边框
				headTable.addCell(createCell("资产净值表", mykeyfont3, Element.ALIGN_CENTER, overhead.length,false));
				if(productName.contains("@@")){
					productName = productName.split("@@")[0];
				}
				headTable.addCell(createCell("申万宏源证券有限公司__"+productName+"__专用表", mykeyfont2, Element.ALIGN_CENTER, overhead.length,false));
				for(int i = 0 ; i < overhead.length ; i++){
					headTable.addCell(createCell(overhead[i], mykeyfont, Element.ALIGN_CENTER,1,false));
				}
				
				
				//设置每列的字体
				for(int i = 0 ; i < head.length ; i++){
					if(i==3||i==5||i==6||i==8||i==9||i==10){
						table.addCell(createCell(head[i], mykeyfont, Element.ALIGN_CENTER));
					}else{
						table.addCell(createCell(head[i], mykeyfont, Element.ALIGN_CENTER));
					}
				}
				int size = 0;
				if(k == (page-1) && page > 1){
					size = list.size()-37*(page-1);
				}else if(k==0&&page==1){
					size = list.size();
				}else{
					size = 35*(k+1);
				}
				if(null != list && list.size() > 0){
					for(int i = 0+(35*k) ; i < (35*k)+35 ; i++){
					if(i<list.size()){	
						//根据fkmbm和km_p的值判断行加粗
						Map map = (Map) list.get(i);
						String fkmbm = (String) map.get("c01");
						if (fkmbm == null || "".equals(fkmbm)){
							fkmbm = "";
						}
						String km_p = "";
						if(i<list.size()-1){
							Map map1 = (Map) list.get(i+1);
							km_p = (String) map1.get("c01");
							if (km_p == null || "".equals(km_p)){
								km_p = "";
							}
						}else{
							km_p = "不存在此信息！";
						}
						if(fkmbm.equals(km_p)){
							for(int j = 0 ; j < colNum ; j ++){
								//获得KEY值
								String firstLetter = headorder[j].trim(); 
								try{
									try{
										//添加数据
										String values = (String) map.get(firstLetter);
										if(values == "null"||values == null){
											values = "";
										}
										if(j==0||j==1){
											table.addCell(createCell(values, textfont00,Element.ALIGN_LEFT));
										}else if(j==2||j==4||j==7){
											if(values.length()>=9){
												table.addCell(createCell(values, textfont22,Element.ALIGN_RIGHT));
											}else{
												table.addCell(createCell(values, textfont00,Element.ALIGN_RIGHT));
											}
										}else if(j==9||j==10||j==11){
											table.addCell(createCell(values, textfont22,Element.ALIGN_RIGHT));
										}else{
											table.addCell(createCell(values, textfont00,Element.ALIGN_RIGHT));
										}
									}
									catch (IllegalArgumentException e){
										 logger.error(e.toString());
									} 
								}catch (SecurityException e){
									 logger.error(e.toString());
								}
							}
						}else{
						
							for(int j = 0 ; j < colNum ; j ++){
								//获得KEY值
								String firstLetter = headorder[j].trim(); 
								try{
									try{
										//添加数据
										String values = String.valueOf(map.get(firstLetter));
										if(values == "null"||values == null){
											values = "";
										}
										if(j==0||j==1){
											table.addCell(createCell(values, mykeyfont,Element.ALIGN_LEFT));
										}else if(j==2||j==4||j==7){
											if(values.length()>=9){
												table.addCell(createCell(values, mykeyfont,Element.ALIGN_RIGHT));
											}else{
												table.addCell(createCell(values, mykeyfont,Element.ALIGN_RIGHT));
											}
										}else if(j==9||j==10||j==11){
											table.addCell(createCell(values, mykeyfont,Element.ALIGN_RIGHT));
										}else{
											table.addCell(createCell(values, mykeyfont,Element.ALIGN_RIGHT));
										}
									}
									catch (IllegalArgumentException e){
										 logger.error(e.toString());
									} 
								}catch (SecurityException e){
									 logger.error(e.toString());
								}
							}
						}
					}	
					}
					
				}
				//
				for(int i = 0 ; i < foot1.length ; i++){
					if(i==0||i==2){
						footTable1.addCell(create_foot_Cell(foot1[i], otherfont, Element.ALIGN_LEFT,1,false));
					}else{
						footTable1.addCell(create_foot_Cell(foot1[i], otherfont, Element.ALIGN_CENTER,1,false));
					}
					
				}
				//
				for(int i = 0 ; i < foot2.length ; i++){
					if(i==0||i==2){
						footTable2.addCell(create_foot_Cell(foot2[i], otherfont, Element.ALIGN_LEFT,1,false));
					}else{
						footTable2.addCell(create_foot_Cell(foot2[i], otherfont, Element.ALIGN_CENTER,1,false));
					}
				}
				
				for(int i = 0 ; i < foot3.length ; i++){
					if(i==0||i==2){
						footTable3.addCell(create_foot_Cell(foot3[i], otherfont, Element.ALIGN_LEFT,1,false));
					}else{
						footTable3.addCell(create_foot_Cell(foot3[i], otherfont, Element.ALIGN_CENTER,1,false));
					}
				}
				//创建新空白页
				document.newPage();
				//将表格添加到文档中
				document.add(headTable);
				document.add(table);
				document.add(footTable1);
				document.add(footTable3);
				//document.
			  }
			}catch (DocumentException e){
				  logger.error(e.toString());
			}catch (Exception e) {
				e.printStackTrace();
			}
		 finally{
				//关闭流
				document.close();
			}
		}
	/**
	 * 生成ＰＤＦ公共方法
	 * @param headorder
	 * @param head
	 * @param list
	 * @param colNum
	 * @param header
	 */
	public void generatePDF(String [] headorder,String [] head,List list,int colNum,String header) {
		try{
		// 创建一个表格
		PdfPTable table = createTable(headorder);

		// 添加备注,靠左，不显示边框
		table.addCell(createCell(header, headfont, Element.ALIGN_CENTER, colNum,false));
		table.addCell(createCell("", keyfont, Element.ALIGN_CENTER, colNum,false));
		table.addCell(createCell("", keyfont, Element.ALIGN_CENTER, colNum,false));
		//设置表头
		for(int i = 0 ; i < colNum ; i++){
			table.addCell(createCell(head[i], keyfont, Element.ALIGN_CENTER));
		}
		if(null != list && list.size() > 0){
			int size = list.size();
			for(int i = 0 ; i < size ; i++){
				Map map = (Map) list.get(i);
				for(int j = 0 ; j < colNum ; j ++){
					//获得KEY值
					String firstLetter = headorder[j].trim(); 
					try{
						try{
							//添加数据
							String values = (String) map.get(firstLetter);
							if(values == "null"||values == null){
								values = "";
							}
							table.addCell(createCell(values, textfont,Element.ALIGN_RIGHT));
						}
						catch (IllegalArgumentException e){
							e.printStackTrace();
						} 
					}catch (SecurityException e){
						e.printStackTrace();
					}
				}
			}
		   }
			//将表格添加到文档中
			document.add(table);
		}catch (DocumentException e){
			e.printStackTrace();
		}finally{
			//关闭流
			document.close();
		}
	}
	
	/**
	 * 生成ＰＤＦ公共方法  wxl
	 * @param headorder
	 * @param head
	 * @param list
	 * @param colNum
	 * @param header
	 */
	public void generatePDF_JJFE(String [] headorder,String [] head,List list,int colNum,String header) {
	try{
		// 创建一个表格
		PdfPTable table = createTable_JJFE(colNum);
		PdfPTable Htable = createTable_JJFE(colNum);
		PdfPTable HPtable = createTable_JJFE(colNum);
		Date nowTime = new Date();
		SimpleDateFormat sdFormatter = new SimpleDateFormat("YYYY年MM月dd日");
		String retStrFormatNowDate = sdFormatter.format(nowTime);

		
		if(null != list && list.size() > 0){
			int size = list.size();
			for(int i = 0 ; i < size ; i++){
				Map map = (Map) list.get(i);

				String cust_name = (String) map.get("cust_name");//投资人姓名
				String cust_type = (String) map.get("cust_type");//投资人类型
				String card_number = (String) map.get("card_number");//证件号
				String card_type = (String) map.get("card_type");//证件类型
				String fund_name = (String) map.get("fund_name");//基金名称
				String last_modify_time_ = (String) map.get("last_modify_time");//份额最新变更日期
				String year=last_modify_time_.substring(0, 4);//年
				String mouth=last_modify_time_.substring(4, 6);//月
				String day=last_modify_time_.substring(6, 8);//日
				String last_modify_time=year+"年"+mouth+"月"+day+"日";
				String share_bal_ = (String) map.get("share_bal");//持有份额
				String share_bal =share_bal_.trim();
				String frz_share_ = (String) map.get("frz_share");//冻结份额
				String frz_share =frz_share_.trim();
				String nv_dt_ = (String) map.get("nv_dt");//净值日期
				String nv_dt_year=nv_dt_.substring(0, 4);//年
				String nv_dt_mouth=nv_dt_.substring(4, 6);//月
				String nv_dt_day=nv_dt_.substring(6, 8);//日
				String nv_dt=nv_dt_year+"年"+nv_dt_mouth+"月"+nv_dt_day+"日";
				String latest_market_val_ = (String) map.get("latest_market_val");//最新市值
				String latest_market_val_trim =latest_market_val_.trim();
				//最新市值保留两位小数
				String latest_market_val_str=latest_market_val_trim.replace(",", "");
			    BigDecimal bd = new BigDecimal(latest_market_val_str);
			     //,代表分隔符 //0.后面的##代表位数 如果换成0 效果就是位数不足0补齐
			    DecimalFormat df =new DecimalFormat("#,##0.##;(#)");
			    String latest_market_val=df.format(bd);
				//最新市值保留两位小数 end
				
				String fund_code=(String) map.get("fund_code");//基金代码
				String fm_name=(String) map.get("fm_name");//管理人名称
				
				String divdnd_mode=(String)map.get("divdnd_mode");//分红方式
				String frz_market_val_=(String)map.get("frz_market_val");//冻结市值
				String frz_market_val=frz_market_val_.trim();
				
				String wod="";
				String subwodend="";
				String subwod="";
				if(fm_name==""||fm_name==null){
					wod="您持有的"+fund_name+"的份额信息如下：";
				}else{
					wod="您持有由"+fm_name+"所管理的"+fund_name+"的份额信息如下：";
				}
				//String wod="您持有由"+fm_name+"所管理的"+fund_name+"("+fund_code+")的份额信息如下：";
				if(wod.length()>25){
					subwod=wod.substring(0, 25);
				subwodend=wod.substring(25, wod.length());
				}else{
					subwod=wod;
				}
			
				Paragraph p = new Paragraph(subwod, textfont_jj01);
				p.setAlignment(3);
				p.setFirstLineIndent(180.0f);				 
				p.setSpacingBefore(20.0f);
				 
				 
				 
				// 添加备注,靠左，不显示边框
				 Htable.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
				 Htable.addCell(createCell_JJFE(header, headfont_jj, Element.ALIGN_CENTER, colNum,false));
				 
				 try {
					Htable.addCell(createCell_JJChunk("尊敬的",cust_name,"您好:", textfont_jj03, Element.ALIGN_LEFT, colNum,false));
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				 
				 HPtable.addCell(createCell_JJFEF(subwodend, textfont_jj01, Element.ALIGN_LEFT, colNum,false));
				 try {
					document.add(Htable);
					document.add(p);
					document.add(HPtable);
				} catch (DocumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 
								
				for(int j=0;j<6;j++){
				//设置固定表格格式4列5行
					if(j==0){
						table.addCell(createCell_JJFE("投资人姓名", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+cust_name, textfont_jj02, Element.ALIGN_LEFT));
						table.addCell(createCell_JJFE("投资人类型", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+cust_type, textfont_jj02, Element.ALIGN_LEFT));
					}else if(j==1){
						table.addCell(createCell_JJFE("证件类型", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+card_type, textfont_jj02, Element.ALIGN_LEFT));
						table.addCell(createCell_JJFE("证件号码", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+card_number, textfont_jj02, Element.ALIGN_LEFT));
					}else if(j==2){
						table.addCell(createCell_JJFE("基金名称", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFEj(fund_name, textfont_jj02, Element.ALIGN_LEFT,25,7,2));
						table.addCell(createCell_JJFEj("份额最新变更日期", textfont_jj02, Element.ALIGN_CENTER,40,10,10));
						table.addCell(createCell_JJFE("  "+last_modify_time, textfont_jj02, Element.ALIGN_LEFT));
					}else if(j==3){
						table.addCell(createCell_JJFE("分红方式", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+divdnd_mode, textfont_jj02, Element.ALIGN_LEFT));
						table.addCell(createCell_JJFE("持有份额", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+share_bal+" 份", textfont_jj02, Element.ALIGN_LEFT));
					}else if(j==4){
						table.addCell(createCell_JJFE("冻结份额", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+frz_share+" 份", textfont_jj02, Element.ALIGN_LEFT));
						table.addCell(createCell_JJFE("冻结市值", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+frz_market_val+" 元", textfont_jj02, Element.ALIGN_LEFT));
					}else if(j==5){
						table.addCell(createCell_JJFE("净值日期", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+nv_dt, textfont_jj02, Element.ALIGN_LEFT));
						table.addCell(createCell_JJFE("最新市值", textfont_jj02, Element.ALIGN_CENTER));
						table.addCell(createCell_JJFE("  "+latest_market_val+" 元", textfont_jj02, Element.ALIGN_LEFT));
					}
				
				}
				table.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
				table.addCell(createCell_JJFE("申万宏源证券有限公司", textfont_jj01, Element.ALIGN_RIGHT,colNum,false));
				table.addCell(createCell_JJFE(retStrFormatNowDate, textfont_jj01, Element.ALIGN_RIGHT,colNum,false));
			}
		}
		
			document.add(table);
		}catch (DocumentException e){
			e.printStackTrace();
		}finally{
			//关闭流
			document.close();
		}
	}
	
	/**
	 * 提供外界调用的接口，生成以head为表头，list为数据的pdf
	 * @param head //数据表头
	 * @param list //数据
	 * @return  //excel所在的路径
	 */
	public String generatePDFs(String [] headorder,String [] head,List list,String saveFilePathAndName,String header){

		File file = new File(saveFilePathAndName);
		try{
			file.createNewFile();
		}catch (IOException e1){
			e1.printStackTrace();
		}
		initFile(file);
		try{
			file.createNewFile(); //生成一个pdf文件
		}catch (IOException e){
			e.printStackTrace();
		}
		CreatePdf(file);
		generatePDF(headorder,head,list,head.length,header); 
		return saveFilePathAndName;
	}
	
	/**
	 * 提供外界调用的接口，生成以head为表头，list为数据的pdf
	 * @param head //数据表头
	 * @param list //数据
	 * @return  //excel所在的路径
	 */
	public String generatePDFs_JJFE(String [] headorder,String [] head,List list,String saveFilePathAndName,String header){

		File file = new File(saveFilePathAndName);
		try{
			file.createNewFile();
		}catch (IOException e1){
			e1.printStackTrace();
		}
		initFile_JJFE(file);
		try{
			file.createNewFile(); //生成一个pdf文件
		}catch (IOException e){
			e.printStackTrace();
		}
		CreatePdf(file);
		generatePDF_JJFE(headorder,head,list,4,header);
		return saveFilePathAndName;
	}
	
	/**
	 * 提供外界调用的接口，生成以head为表头，list为数据的pdf
	 * @param head //数据表头
	 * @param list //数据
	 * @param opertor 
	 * @return  //excel所在的路径
	 */
	public String CreatValuationTables(String [] headorder,String [] headnames,List list,String saveFilePathAndName,String productName,String time,String unitNet, String opertor,String create_operator) throws Exception{
		File file = new File(saveFilePathAndName);
			file.delete();
		if(!file.exists()){
			file.createNewFile();
			CreatePdf(file);
			CreatValuationTable(headorder,headnames,list,productName,time,unitNet,opertor,create_operator); 
			return saveFilePathAndName;
		}else{
			return "";
		}
	}
	/**
	 * 提供外界调用的接口，生成以head为表头，list为数据的pdf
	 * @param head //数据表头
	 * @param list //数据
	 * @param opertor 
	 * @return  //excel所在的路径
	 */
	public String CreatJZTables(String [] headorder,String [] headnames,List list,String saveFilePathAndName,String productName,String time,String unitNet, String opertor,String create_operator) throws Exception{
		File file = new File(saveFilePathAndName);
			file.delete();
		if(!file.exists()){
			file.createNewFile();
			CreateHengPdf(file);
			CreatJZTable(headorder,headnames,list,productName,time,unitNet,opertor,create_operator); 
			return saveFilePathAndName;
		}else{
			return "";
		}
	}
	public static void addPdfMark(String function_, String InPdfFile, final OutputStream writer,LogoBean logoBean)
			throws Exception {
		PdfReader reader = new PdfReader(InPdfFile, "PDF".getBytes());
		PdfStamper stamp = new PdfStamper(reader, writer);
		final int pageSize = reader.getNumberOfPages();
		
		for (int i = 1; i <= pageSize; i++) {
			Rectangle rectangle =  reader.getPageSize(i);
			PdfContentByte imgPos = stamp.getOverContent(i);
			
			setIcon(function_,rectangle,imgPos,logoBean.getCompanyLogoPath(),true);
			setIcon(function_,rectangle,imgPos,logoBean.getCompanyStampPath(),false);
		}
		stamp.close();// 关闭
		writer.flush();
		writer.close();
	}
	
	public static void setIcon(String function_,Rectangle rectangle,PdfContentByte imgPos,final String iconPath,boolean leftAbsPostion) throws MalformedURLException, IOException, DocumentException{
        final float width = rectangle.getWidth();
        final float height =rectangle.getHeight();
        final Image img = Image.getInstance(iconPath);// 插入水印
		img.scaleToFit(180, 100);//设置图片的宽高
		if(leftAbsPostion){
			if(function_.equals("CreatValuationTable")){
				img.setAbsolutePosition(20, height-50);//设置在左上角
			}else if(function_.equals("interfaceDowload")){//基金份额
				img.setAbsolutePosition(80, height-60);//设置在左上角
			}
			
		}else{
			if(function_.equals("CreatValuationTable")){
				img.setAbsolutePosition(width-150, height-115);//设置在右上角
			}else if(function_.equals("interfaceDowload")){//基金份额
				img.setAbsolutePosition(width-200, height-520);//设置在右上角
			}
			
		}
		
		imgPos.addImage(img);
	}
	
	
	public static void main(String[] args) {
		String file_path = "1\\aewqrbd3.pdf";
	   String fileName  = file_path.replaceAll("/", "@@").replaceAll("\\\\", "@@");
	   fileName =fileName.substring(fileName.lastIndexOf("@@")+2);
        System.out.println(fileName);
	}
	
	}
