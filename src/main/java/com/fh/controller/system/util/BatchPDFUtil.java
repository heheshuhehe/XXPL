package com.fh.controller.system.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

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




public class BatchPDFUtil {
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
	 private static Font textfont_jj02_bold; //字体加粗
	 private static Font textfont_jj02_11;//11号字体
	 private static Font textfont_jj02_11_bold;//11号字加粗
	
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
			textfont_jj02_11 = new Font(bfChinese, 11, Font.NORMAL);//11号字体---不加粗
			textfont_jj02_11_bold = new Font(bfChinese, 11, Font.BOLD);//11号字体---加粗
			textfont_jj02_bold = new Font(bfChinese, 13, Font.BOLD);// 设置字体大小---加粗 5号
			textfont_jj03 = new Font(bfChinese, 15, Font.NORMAL);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 创建表格
	 * @param colNumber
	 */
	
	public PdfPTable createTable(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		float[] columnWidth = {50,90,60,60,60,60,90,90};
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
	/**
	 * 【交易明细的底部时间和落款】
	 * @param value   值
	 * @param font   字体
	 * @param align   对齐方式
	 * @param colspan  占多少列
	 * @param boderFlag  是否有有边框
	 * @return    添加的文本框
	 */
	public PdfPCell createCell_JJJ(String value, Font font, int align, int colspan,
		   boolean boderFlag){
		 
		  PdfPCell cell = new PdfPCell();
		  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		  cell.setHorizontalAlignment(align);
		  cell.setColspan(colspan);
		  
		  cell.setPhrase(new Phrase(value, font));
		  
		  cell.setPadding(0.0f);
		  cell.setMinimumHeight(0);
		  if (!boderFlag)
		  {
		   cell.setBorder(0);
		   cell.setPaddingTop(10.0f);
		   cell.setPaddingLeft(15.0f);
		   cell.setPaddingBottom(0.0f);
		  }
		return cell;
	}
	
	
	public PdfPCell createCell_JJChunk(String value,String value1,String value2, Font font, int align, int colspan,
			   boolean boderFlag) throws DocumentException, IOException{
			 
			  PdfPCell cell = new PdfPCell();
			  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			  cell.setHorizontalAlignment(align);
			  cell.setColspan(colspan);
			  cell.setPhrase(new Phrase(value, font));		  
			  cell.setPadding(0.0f);
			  cell.setMinimumHeight(10);
			  if (!boderFlag)
			  {
			   cell.setBorder(0);
			   cell.setPaddingTop(10f);
			   cell.setPaddingLeft(0.0f);
			   cell.setPaddingBottom(0.0f);
			  }
			return cell;
		}
	
	
	public PdfPCell createCell_JJFEF(String value, Font font, int align, int colspan,
			   boolean boderFlag,String fundName){
			 
			  PdfPCell cell = new PdfPCell();
			  cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			  cell.setHorizontalAlignment(align);
			  cell.setColspan(colspan);
			  if(fundName !=null){
				  Paragraph largeText = new Paragraph();
				  String str1 = value.substring(0, 14);
				  String str2 = value.substring(14, fundName.length()+16);
				  String str3 = value.substring(fundName.length()+16);
				  Chunk chunk1 = new Chunk(str1, font);
				  Chunk chunk2 = new Chunk(str2, keyfont);
				  Chunk chunk3 = new Chunk(str3, font);
				  largeText.add(chunk1);
				  largeText.add(chunk2);
				  largeText.add(chunk3);
				  cell.setPhrase(largeText);
			  }else{
				  cell.setPhrase(new Phrase(value, font));
				  cell.setPadding(0.0f);
				  cell.setMinimumHeight(20);
			  }
			  if (!boderFlag)
			  {
			   cell.setBorder(0);
			   cell.setPaddingTop(10.0f);
			   cell.setPaddingLeft(20.0f);
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
	 * 交易明细底部的页码
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
			   cell.setPaddingTop(20.0f);
			   cell.setPaddingBottom(150.0f);
			  }
			return cell;
	}
	
	/**
	 * 交易明细的页码创建表格
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
	 * 生成ＰＤＦ(基金份额交易明细)
	 * @param headorder
	 * @param head
	 * @param list
	 * @param colNum
	 * @param header
	 */
	public void CreatValuationTableNewAll(String[] headName,String [] headorder,List list,String productName,String fmName,String fundName,String logo,String seal,String rq) {
		// 创建一个表格
		int result = list.size();
		Date nowTime = new Date();
		SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy年MM月dd日");
		String retStrFormatNowDate = sdFormatter.format(nowTime);
		String y = rq.substring(0, 4);
		String m = rq.substring(4,6);
		String d = rq.substring(6,rq.length());

		//表头中文名
		//{"客户名称","基金名称","份额类别","份额余额","最新市值","冻结份额","冻结市值","客户类型","证件类型","证件号码","销售商"};
		String[] head = headName;
		String[] overhead = {fmName+":","截止"+y+"年"+m+"月"+d+"日，"+fundName+"份额"+"明细如下:"};
		//总列数
		int colNum = head.length;
		
		PdfPTable headTable = createTable(colNum);
		PdfPTable ptable = createTable(colNum);
		PdfPTable foot = createTable(colNum);
		PdfPTable headH = createTable(colNum);
		headH.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
		headH.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
		headH.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
		foot.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
		foot.addCell(createCell_JJJ("申万宏源证券有限公司", textfont_jj01, Element.ALIGN_RIGHT,colNum,false));
		foot.addCell(createCell_JJJ(y+"年"+m+"月"+d+"日", textfont_jj01, Element.ALIGN_RIGHT,colNum,false));
		// 表头
		headTable.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
		headTable.addCell(createCell_JJFE("基金投资者份额", headfont, Element.ALIGN_CENTER, colNum,false));
		try {
			headTable.addCell(createCell_JJChunk(overhead[0],"","", keyfont, Element.ALIGN_LEFT, colNum,false));
		} catch (DocumentException e2) {
			e2.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		
		ptable.addCell(createCell_JJFEF(overhead[1], otherfont, Element.ALIGN_LEFT, colNum,false,fundName));
		try {
			document.add(headTable);
			document.add(ptable);
		} catch (DocumentException e1) {
			e1.printStackTrace();
		}
		
		PdfPTable table = createTable(colNum);				
		for(int i = 0 ; i < head.length ; i++){
			table.addCell(createCell(head[i], keyfont1, Element.ALIGN_CENTER));
		}
		
		if(null != list && list.size() > 0){
			for (int i = 0; i < list.size(); i++) {
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
								
								table.addCell(createCell(values, textfont1,Element.ALIGN_LEFT));
								
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

		try{
			try {
				Image mg = Image.getInstance(logo);
				mg.scaleToFit(180, 100);
				mg.setAbsolutePosition(70, 842-55);
				document.add(mg);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			float allHeight = table.getTotalHeight() 
					+ headTable.getTotalHeight() 
					+ ptable.getTotalHeight();
			if(Arrays.asList(head).contains("产品名称")){
				if(list.size() <=30){
					if(head.length >= 10){
						allHeight += 120;
					}else{
						allHeight += 130;
					}								
				}else {
					if(head.length <= 3){
						allHeight += 180;
					}else {
						allHeight += 200;
					}
				}							
			}else {
				allHeight += 140;
			}
					 
			float pdfHeight = document.getPageSize().getHeight();
			
			document.add(table);
			document.add(foot);
			try {
				 Image mg = Image.getInstance(seal);
				 mg.scaleToFit(180, 100);
				 mg.setAbsolutePosition(595-200, allHeight > pdfHeight ? pdfHeight - (allHeight % pdfHeight) : pdfHeight - allHeight);
			     document.add(mg);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}					
		}catch (DocumentException e){
			e.printStackTrace();
		}
		//关闭流
		document.close();
	}
	
	
	/**
	 * 生成ＰＤＦ(基金份额交易明细)
	 * @param headorder
	 * @param head
	 * @param list
	 * @param colNum
	 * @param header
	 */
	public void CreatValuationTable(String[] headName,String [] headorder,List list,String productName,String fmName,String fundName,String logo,String seal,String rq) {
		// 创建一个表格
		int result = list.size();
		Date nowTime = new Date();
		SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy年MM月dd日");
		String retStrFormatNowDate = sdFormatter.format(nowTime);
		int page=result%32==0?result/32:result/32+1;//分页总页数，每页32行
		String y = rq.substring(0, 4);
		String m = rq.substring(4,6);
		String d = rq.substring(6,rq.length());
		int lastH=0;
		if(result<=32){
			lastH = list.size()*15+270;
		}else{
			//lastH = list.size()%32*15+250;
			if(fundName.length()>15){
				lastH = list.size()%32*15+430;
			}else{
				lastH = list.size()%32*15+250;
			}
		}
			//表头中文名
			//{"客户名称","基金名称","份额类别","份额余额","最新市值","冻结份额","冻结市值","客户类型","证件类型","证件号码","销售商"};
			String[] head = headName;
			String[] overhead = {fmName+":","截止"+y+"年"+m+"月"+d+"日，"+fundName+"份额"+"明细如下:"};
			//总列数
			int colNum = head.length;
			
			PdfPTable headTable = createTable(colNum);
			PdfPTable ptable = createTable(colNum);
			PdfPTable foot = createTable(colNum);
			PdfPTable headH = createTable(colNum);
			headH.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
			headH.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
			headH.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
			foot.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
			foot.addCell(createCell_JJJ("申万宏源证券有限公司", textfont_jj01, Element.ALIGN_RIGHT,colNum,false));
			foot.addCell(createCell_JJJ(y+"年"+m+"月"+d+"日", textfont_jj01, Element.ALIGN_RIGHT,colNum,false));
			// 表头
			headTable.addCell(createCell_JJFE("", keyfont, Element.ALIGN_CENTER, colNum,false));
			headTable.addCell(createCell_JJFE("基金投资者份额", headfont, Element.ALIGN_CENTER, colNum,false));
				try {
					headTable.addCell(createCell_JJChunk(overhead[0],"","", keyfont, Element.ALIGN_LEFT, colNum,false));
				} catch (DocumentException e2) {
					e2.printStackTrace();
				} catch (IOException e2) {
					e2.printStackTrace();
				}
				
				ptable.addCell(createCell_JJFEF(overhead[1], otherfont, Element.ALIGN_LEFT, colNum,false,fundName));
				try {
					document.add(headTable);
					document.add(ptable);
				} catch (DocumentException e1) {
					e1.printStackTrace();
				}
				
			
			for(int k = 0 ; k < page ; k++){
				String[] foot3 = {"","第"+(k+1)+"页/共"+page+"页",""};
				PdfPTable footTable3 = createTableFoot3(foot3.length);
				PdfPTable table = createTable(colNum);				
				for(int i = 0 ; i < head.length ; i++){
					table.addCell(createCell(head[i], keyfont1, Element.ALIGN_CENTER));
			    }
			int size = 0;
			if(k == (page-1) && page > 1){
				size = list.size()-32*(page-1);
			}else if(k==0&&page==1){
				size = list.size();
			}else{
				size = 32*(k+1);
			}
			
			if(null != list && list.size() > 0){
				for(int i = 0+(32*k) ; i < (32*k)+32 ; i++){
				if(i<list.size()){	
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
									
									table.addCell(createCell(values, textfont1,Element.ALIGN_LEFT));
									
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
			}
			for(int i = 0 ; i < foot3.length ; i++){
				if(i==0||i==2){
					footTable3.addCell(create_foot_Cell(foot3[i], otherfont, Element.ALIGN_LEFT,1,false));
				}else{
					footTable3.addCell(create_foot_Cell(foot3[i], otherfont, Element.ALIGN_CENTER,1,false));
				}
			}
			try{
				//创建新空白页
				//document.newPage();
				//将表格添加到文档中
				if(k==0){
					try {
						 Image mg = Image.getInstance(logo);
						 mg.scaleToFit(180, 100);
						 mg.setAbsolutePosition(70, 842-55);
					     document.add(mg);
					} catch (MalformedURLException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				if(k!=0){
					document.add(headH);
				}
				document.add(table);
				
				if(k==(page-1)){
					document.add(foot);
					try {
						 Image mg = Image.getInstance(seal);
						 mg.scaleToFit(180, 100);
						 mg.setAbsolutePosition(595-200, 842-lastH);
					     document.add(mg);
					} catch (MalformedURLException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				document.add(footTable3);
				//document.add(footTable3);
			}catch (DocumentException e){
				e.printStackTrace();
			}
		}
		//关闭流
		document.close();
	}
	

	/**
	 * 提供外界调用的接口，生成以head为表头，list为数据的pdf  1.交易明细的
	 * @param head //数据表头
	 * @param list //数据
	 * @param opertor 
	 * @return  //excel所在的路径
	 */
	public String CreatValuationTables(String[] headName,String [] headorder,List list,String saveFilePathAndName,String productName,String fmName,String fundName,String logo,String seal,String rq){

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
		CreatValuationTable(headName,headorder,list,productName,fmName,fundName,logo,seal,rq); 
		
		return saveFilePathAndName;
	}
	
	/**
	 * 提供外界调用的接口，生成以head为表头，list为数据的pdf  1.交易明细的
	 * @param head //数据表头
	 * @param list //数据
	 * @param opertor 
	 * @return  //excel所在的路径
	 */
	public String CreatValuationTablesNewAll(String[] headName,String [] headorder,List list,String saveFilePathAndName,String productName,String fmName,String fundName,String logo,String seal,String rq){

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
		CreatValuationTableNewAll(headName,headorder,list,productName,fmName,fundName,logo,seal,rq); 
		
		return saveFilePathAndName;
	}

	/**
	 * 交易明细的专用
	 * @param function_
	 * @param InPdfFile
	 * @param writer
	 * @param logoBean
	 * @throws Exception
	 */
	public  void addPdfMarkJ(String function_, String InPdfFile, final OutputStream writer,LogoBean logoBean,int sum)
			throws Exception {
		PdfReader reader = new PdfReader(InPdfFile, "PDF".getBytes());
		PdfStamper stamp = new PdfStamper(reader, writer);
		final int pageSize = reader.getNumberOfPages();
				Rectangle rectangle =  reader.getPageSize(1);
				PdfContentByte imgPos = stamp.getOverContent(1);
					setIcon(function_,rectangle,imgPos,logoBean.getCompanyLogoPath(),true,sum);
				Rectangle re =  reader.getPageSize(pageSize);
				PdfContentByte img = stamp.getOverContent(pageSize);
					setIcon(function_,re,img,logoBean.getCompanyStampPath(),false,sum);
		stamp.close();// 关闭
		writer.flush();
		writer.close();
	}

	/**
	 * 交易明细专用
	 * @param function_
	 * @param rectangle
	 * @param imgPos
	 * @param iconPath
	 * @param leftAbsPostion
	 * @throws MalformedURLException
	 * @throws IOException
	 * @throws DocumentException
	 */
	public void setIcon(String function_,Rectangle rectangle,PdfContentByte imgPos,final String iconPath,boolean leftAbsPostion,int h) throws MalformedURLException, IOException, DocumentException{
        final float width = rectangle.getWidth();
        final float height =rectangle.getHeight();
        final Image img = Image.getInstance(iconPath);// 插入水印 
		img.scaleToFit(190, 110);//设置图片的宽高
		if(leftAbsPostion){
			if(function_.equals("CreatValuationTable")){
				img.setAbsolutePosition(20, height-50);//设置在左上角
			}else if(function_.equals("interfaceDowload")){//基金份额
				img.setAbsolutePosition(70, height-55);//设置在左上角
			}
			
		}else{
			if(function_.equals("CreatValuationTable")){
				img.setAbsolutePosition(width-150, height-115);//设置在右下角
			}else if(function_.equals("interfaceDowload")){//基金交易明细
				img.setAbsolutePosition(width-200,height-h);//设置在右下角
			}
			
		}
		
		imgPos.addImage(img);
	}

}
