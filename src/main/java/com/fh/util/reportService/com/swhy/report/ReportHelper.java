package com.fh.util.reportService.com.swhy.report;

import org.jxls.builder.xls.XlsCommentAreaBuilder;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.apache.log4j.Logger;
import com.deepoove.poi.XWPFTemplate;
import com.deepoove.poi.util.PoitlIOUtils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.DeserializationFeature;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.microsoft.schemas.vml.CTFill;
import com.microsoft.schemas.vml.CTTextPath;

import org.apache.poi.openxml4j.util.ZipSecureFile;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlToken;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
	
import java.io.*;
import java.security.InvalidParameterException;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import javax.xml.namespace.QName;

import com.fh.util.reportService.com.swhy.report.poitl.doubleRenderPolicy;
import com.fh.util.reportService.com.swhy.report.poitl.double2RenderPolicy;
import com.fh.util.reportService.com.swhy.report.poitl.double4RenderPolicy;
import com.fh.util.reportService.com.swhy.report.poitl.double6RenderPolicy;
import com.fh.util.reportService.com.swhy.report.poitl.doublePercentSignRenderPolicy;
/**
 * @author Leonid Vysochyn
 *         Date: 1/30/12 12:15 PM
 */
public class ReportHelper {
    static public Logger logger = Logger.getLogger(ReportHelper.class);
    
    // private static ObjectFactory factory = null;
    private static String waterMark = "<w:r><w:rPr><w:noProof/></w:rPr><w:pict><v:shapetype id=\"_x0000_t136\" coordsize=\"21600,21600\" o:spt=\"136\" adj=\"10800\" path=\"m@7,l@8,m@5,21600l@6,21600e\"><v:formulas><v:f eqn=\"sum #0 0 10800\"/><v:f eqn=\"prod #0 2 1\"/><v:f eqn=\"sum 21600 0 @1\"/><v:f eqn=\"sum 0 0 @2\"/><v:f eqn=\"sum 21600 0 @3\"/><v:f eqn=\"if @0 @3 0\"/><v:f eqn=\"if @0 21600 @1\"/><v:f eqn=\"if @0 0 @2\"/><v:f eqn=\"if @0 @4 21600\"/><v:f eqn=\"mid @5 @6\"/><v:f eqn=\"mid @8 @5\"/><v:f eqn=\"mid @7 @8\"/><v:f eqn=\"mid @6 @7\"/><v:f eqn=\"sum @6 0 @5\"/></v:formulas><v:path textpathok=\"t\" o:connecttype=\"custom\" o:connectlocs=\"@9,0;@10,10800;@11,21600;@12,10800\" o:connectangles=\"270,180,90,0\"/><v:textpath on=\"t\" fitshape=\"t\"/><v:handles><v:h position=\"#0,bottomRight\" xrange=\"6629,14971\"/></v:handles><o:lock v:ext=\"edit\" text=\"t\" shapetype=\"t\"/></v:shapetype><v:shape id=\"PowerPlusWaterMarkObject1584793859\" o:spid=\"_x0000_s2049\" type=\"#_x0000_t136\" style=\"position:absolute;left:0;text-align:left;margin-left:0;margin-top:0;width:470.5pt;height:115pt;rotation:315;z-index:-251657216;mso-position-horizontal:center;mso-position-horizontal-relative:margin;mso-position-vertical:center;mso-position-vertical-relative:margin\" o:allowincell=\"f\" fillcolor=\"silver\" stroked=\"f\"><v:fill opacity=\".5\"/><v:textpath style=\"font-family:&quot;??????&quot;;font-size:1pt\" string=\"??????\"/></v:shape></w:pict></w:r></xml-fragment>";

    // ????????????
    // private static final String fontColor = "#d0d0d0";
	
    // ??????????????????????????????pt?????????????????????????????????????????????????????????*???????????????
    // private static  final Integer widthPerWord = 10;
	
    // ??????????????????
    // private static final int styleRotation = 45;
    /*
    private static ObjectFactory getFactoryInstance() {
    	if (factory == null) {
    		factory = org.docx4j.jaxb.Context.getWmlObjectFactory();
    	}
    	return factory;
    }
    */
    /**
     * @Description				??????excel?????????????????????excel??????
     * @param jsonStr 			??????json?????????
     * @param templateFilePath 	excel??????????????????
     * @param exceFilelPath 	??????excel??????????????????
     * @throws Exception 
     */
    public static void createExcel(String jsonStr, String templateFilePath, 
    		String exceFilelPath) throws Exception {   	
        Map<String, Object> jsonMap = null;
        InputStream is = null;
        OutputStream os = null;
        try {
        	ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            jsonMap = objectMapper.readValue(jsonStr, new TypeReference<Map<String, Object>>(){});
//            jsonMap.forEach((k, v) -> //logger.trace("Key : " + k + " Value : " + v));
            
            is = new FileInputStream(templateFilePath);
            os = new FileOutputStream(exceFilelPath);
            Context context = new Context();
            for (String key : jsonMap.keySet()) {
            	context.putVar(key, jsonMap.get(key));
            }
            XlsCommentAreaBuilder.addCommandMapping("setCell", SetCellCommand.class);
            JxlsHelper.getInstance().processTemplate(is, os, context);
        }
        catch(Exception e) {
        	//logger.error("create excel file failed.");
        	//logger.error(e.getLocalizedMessage(), e);
        	throw e;
        }
        finally {
        	if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        	if (os != null)
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        }        
    }
    
    
    /**
     * @Description				??????excel?????????????????????excel??????
     * @param jsonMap 			??????json??????????????????
     * @param templateFilePath 	excel??????????????????
     * @param exceFilelPath 	??????excel??????????????????
     * @throws Exception 
     */
    public static void createExcel(Map<String, Object> jsonMap, String templateFilePath, 
    		String exceFilelPath) throws Exception {   	
        InputStream is = null;
        OutputStream os = null;
        try {
            is = new FileInputStream(templateFilePath);
            os = new FileOutputStream(exceFilelPath);
            Context context = new Context();
            for (String key : jsonMap.keySet()) {
            	context.putVar(key, jsonMap.get(key));
            }
            XlsCommentAreaBuilder.addCommandMapping("setCell", SetCellCommand.class);
            JxlsHelper.getInstance().processTemplate(is, os, context);
        }
        catch(Exception e) {
        	//logger.error("create excel file failed.");
        	//logger.error(e.getLocalizedMessage(), e);
        	throw e;
        }
        finally {
        	if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        	if (os != null)
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        }        
    }
    
    /**
     * ??????docx?????????????????????docx????????????????????????????????????
     * @param jsonStr ??????json?????????
     * @param templatePath docx??????????????????
     * @param docxPath ??????docx??????????????????
     * @throws Exception 
     */
    public static void createDocx(String jsonStr, String templatePath, 
    		String docxPath) throws Exception {  	
        Map<String, Object> jsonMap = null;
        XWPFTemplate template = null;
        try {
        	ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            jsonMap = objectMapper.readValue(jsonStr, new TypeReference<Map<String, Object>>(){});
//            jsonMap.forEach((k, v) -> //logger.trace("Key : " + k + " Value : " + v));
        
            template = XWPFTemplate.compile(templatePath).render(jsonMap);
            template.writeAndClose(new FileOutputStream(docxPath));
        }
        catch(Exception e) {
        	//logger.error("create docx file failed.");
        	//logger.error(e.getLocalizedMessage(), e);
        	throw e;
        }
        finally {
        	if (template != null) PoitlIOUtils.closeQuietlyMulti(template);
        }        
    }
    
    

    /**
     * ??????docx?????????????????????docx????????????????????????????????????
     * @param jsonMap ??????json??????????????????
     * @param templatePath docx??????????????????
     * @param docxPath ??????docx??????????????????
     * @throws Exception 
     */
    public static void createDocx(Map<String, Object> jsonMap, String templatePath, 
    		String docxPath) throws Exception {  	
        XWPFTemplate template = null;
        try {        
            //template = XWPFTemplate.compile(templatePath).render(jsonMap);
            //template.writeAndClose(new FileOutputStream(docxPath));
            com.deepoove.poi.config.ConfigureBuilder builder = com.deepoove.poi.config.Configure.builder();
            builder.addPlugin('???', new doubleRenderPolicy()); 
            builder.addPlugin('??', new double2RenderPolicy());   
            builder.addPlugin('???', new double4RenderPolicy());
            builder.addPlugin('???', new double6RenderPolicy());
            builder.addPlugin('%', new doublePercentSignRenderPolicy());
            
            template = XWPFTemplate.compile(templatePath,builder.build());
            
            template.render(jsonMap);
            template.writeAndClose(new FileOutputStream(docxPath));
        }
        catch(Exception e) {
        	//logger.error("create docx file failed.");
        	//logger.error(e.getLocalizedMessage(), e);
        	throw e;
        }
        finally {
        	if (template != null) PoitlIOUtils.closeQuietlyMulti(template);
        }        
    }
    
    /**
     * @Description				???docx????????????????????????
     * @param docxInFilePath 	??????docx????????????
     * @param docxOutFilePath 	??????docx????????????
     * @param watermark 		????????????????????????????????????
     * @param fontFamily		??????????????????
     * @param width 			????????????
     * @param height 			????????????
     * @param fillColor 		??????????????????
     * @param isTranslucent 	???????????????????????????
     * @param isHorizontal 		??????????????????????????????
     */
    /*
    public static void addDocxWaterMark(String docxInFilePath, 
    		String docxOutFilePath, String watermark, String fontFamily, 
    		float width, float height, String fillColor, boolean isTranslucent, 
    		boolean isHorizontal) throws Exception {
    	if (watermark == null || watermark.trim().isEmpty()) {
    		throw new InvalidParameterException(watermark + " is empty string");
    	}
        	
    	FileInputStream  docxInputStream = null;
        try {
        	docxInputStream = new FileInputStream(docxInFilePath);
        	WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.load(docxInputStream);        	
        	
        	HeaderPart headerPart = new HeaderPart();
    		Relationship relationship =  wordMLPackage.getMainDocumentPart()
    				.addTargetPart(headerPart);
    		Hdr hdr = getHdr(watermark, fontFamily, width, height, fillColor, 
    				isTranslucent, isHorizontal);
    		headerPart.setJaxbElement(hdr);    		
    		
    		List<SectionWrapper> sections = wordMLPackage.getDocumentModel().
    				getSections();		   
    		SectPr sectPr = sections.get(sections.size() - 1).getSectPr();
    		// There is always a section wrapper, but it might not contain a sectPr
    		if (sectPr == null ) {
    			
    			sectPr = getFactoryInstance().createSectPr();
    			wordMLPackage.getMainDocumentPart().addObject(sectPr);
    			sections.get(sections.size() - 1).setSectPr(sectPr);
    		}
    		HeaderReference headerReference = getFactoryInstance().createHeaderReference();
    		headerReference.setId(relationship.getId());
    		headerReference.setType(HdrFtrRef.DEFAULT);
    		sectPr.getEGHdrFtrReferences().add(headerReference);
    		
        	File docxOutFile = new File(docxOutFilePath);
        	wordMLPackage.save(docxOutFile);
        } catch (Exception e) {
        	//logger.error("add docx text watermark failed.");
        	//logger.error(e.getLocalizedMessage(), e);
        	throw e;
        } 
        finally {
        	try { if (docxInputStream != null) docxInputStream.close();        			
        	} catch (IOException e) { e.printStackTrace(); }
        }
    }
    */
    /**
     * @Description 		??????docx???????????????????????????pdf?????????????????????
     * @param docxFilePath 	??????docx??????????????????
     * @param pdfFilePath 	??????pdf??????????????????
     */
    public static void createPdf(String docxFilePath, String pdfFilePath) 
    		throws Exception {
    	ActiveXComponent app = null;
    	Dispatch documents = null;
    	Dispatch document = null;
        try {        	
        	File docxFile  = new File(docxFilePath);
        	if (!docxFile.exists()) 
        		throw new FileNotFoundException(docxFilePath + " does not exist");
        	if (!docxFile.isFile()) 
        		throw new InvalidParameterException(docxFilePath + " is not a file");
            long start = System.currentTimeMillis();
            ComThread.InitMTA(true); 
            app = new ActiveXComponent("Word.Application");
            documents = app.getProperty("Documents").toDispatch();
            document = Dispatch.call(documents, "Open", docxFilePath, 
            		false, true).toDispatch();
            File pdfFile  = new File(pdfFilePath);
            if (pdfFile.exists()) {
                pdfFile.delete();
            }
            Dispatch.call(document, "SaveAs", pdfFilePath, 17);
            Dispatch.call(document, "Close", new Variant(false));
            long end = System.currentTimeMillis();
            //logger.info("convert docx file to pdf file finished???" + 
             //       		(end - start) + "ms");
        } catch (Exception e) {
        	logger.error("convert docx to pdf file failed.");
        	logger.error(e.getLocalizedMessage(), e);
            throw e;                    
        } finally {
        	if (document != null) {
        		document.safeRelease();
        		document = null;
        	}
        	if (documents != null) {
        		documents.safeRelease();
        		documents = null;
        	}
        	if (app != null) {
        		app.invoke("Quit", new Variant[0]);
        		app.safeRelease();
        		app = null;
            }        	
            ComThread.Release();
        }
        return;
    }
    
	/**
     * @Description: 			???pdf????????????????????????
     * @param pdfInFilePath 	pdf??????????????????
     * @param pdfOutFilePath 	pdf??????????????????
     * @param pngFilePath 		????????????????????????
     * @param xPos				???????????????pdf???????????????????????????
     * @param yPos				???????????????pdf???????????????????????????
     * @param percent			???????????????pdf?????????????????????
     * @param page				???????????????pdf???????????????
     */
    public static void signPdf(String pdfInFilePath, String pdfOutFilePath,
    		String pngFilePath, int xPos, int yPos, float percent, int page) 
    				throws Exception {
    	
    	PdfReader reader = null;
    	PdfStamper stamp = null;
    	FileOutputStream out = null;
    	try {
    		// ??????????????????pdf????????????
    		reader = new PdfReader(pdfInFilePath, "PDF".getBytes());
    		// ???????????????
    		out = new FileOutputStream(pdfOutFilePath);
    		//??????????????????????????????
    		stamp = new PdfStamper(reader, out);
    		// ????????????
    		Image signImage = Image.getInstance(pngFilePath);
    		//???pdf??????????????????
    		int pageSize = reader.getNumberOfPages();
    		//????????????
    		signImage.setAbsolutePosition(xPos, yPos);
    		//????????????
    		signImage.scalePercent(percent);
        
    		if (page == 0) // ?????????
    		{
    			for (int i = 1; i <= pageSize; i++) {
    				//???????????????
//                	PdfContentByte under = stamp.getUnderContent(i);
    				//???????????????
    				PdfContentByte under = stamp.getOverContent(i);
    				//??????????????????
    				under.addImage(signImage);
    			}
    		}
    		else if (page >= pageSize) { // ??????
    			PdfContentByte under = stamp.getOverContent(pageSize);
    			under.addImage(signImage);
    		}
    		else // 1 - pageSize ?????????
    		{
    			PdfContentByte under = stamp.getOverContent(page);
    			under.addImage(signImage);
    		}
    	}
    	catch(Exception e) {
    		e.printStackTrace();
        	//logger.error("sign pdf file failed.");
        	//logger.error(e.getLocalizedMessage(), e);
            throw e;
    	}
    	finally {
    		// ??????
    		if (stamp != null) stamp.close();
    		// ??????
    		if (out != null) out.close();
    		// ??????
    		if (reader != null) reader.close();
    	}
    }
    /*
	public static Hdr getHdr(String watermark, String fontFamily, float width,
			float height, String color, boolean isTranslucent, boolean isHorizontal) 
					throws Exception {

		Hdr hdr = getFactoryInstance().createHdr();
		
		String openXML = "<w:p xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:w10=\"urn:schemas-microsoft-com:office:word\">"
                + "<w:pPr>"
                      + "<w:pStyle w:val=\"Header\"/>"

                +"</w:pPr>" 
                + "<w:sdt>" 
                +   "<w:sdtPr>"
                      + "<w:id w:val=\"-1589924921\"/>"

                      + "<w:lock w:val=\"sdtContentLocked\"/>"

                      + "<w:docPartObj>"
                            + "<w:docPartGallery w:val=\"Watermarks\"/>"

                            + "<w:docPartUnique/>"

                      +"</w:docPartObj>"

                +"</w:sdtPr>"

                + "<w:sdtEndPr/>"

                + "<w:sdtContent>"
                      + "<w:r>"
                            + "<w:rPr>"
                                  + "<w:noProof/>"

                                  + "<w:lang w:eastAsia=\"zh-TW\"/>"

                            +"</w:rPr>"

                            + "<w:pict>"
                                  + "<v:shapetype adj=\"10800\" coordsize=\"21600,21600\" id=\"_x0000_t136\" o:spt=\"136\" path=\"m@7,l@8,m@5,21600l@6,21600e\">"
                                        + "<v:formulas>"
                                              + "<v:f eqn=\"sum #0 0 10800\"/>"

                                              + "<v:f eqn=\"prod #0 2 1\"/>"

                                              + "<v:f eqn=\"sum 21600 0 @1\"/>"

                                              + "<v:f eqn=\"sum 0 0 @2\"/>"

                                              + "<v:f eqn=\"sum 21600 0 @3\"/>"

                                              + "<v:f eqn=\"if @0 @3 0\"/>"

                                              + "<v:f eqn=\"if @0 21600 @1\"/>"

                                              + "<v:f eqn=\"if @0 0 @2\"/>"

                                              + "<v:f eqn=\"if @0 @4 21600\"/>"

                                              + "<v:f eqn=\"mid @5 @6\"/>"

                                              + "<v:f eqn=\"mid @8 @5\"/>"

                                              + "<v:f eqn=\"mid @7 @8\"/>"

                                              + "<v:f eqn=\"mid @6 @7\"/>"

                                              + "<v:f eqn=\"sum @6 0 @5\"/>"

                                        +"</v:formulas>"

                                        + "<v:path o:connectangles=\"270,180,90,0\" o:connectlocs=\"@9,0;@10,10800;@11,21600;@12,10800\" o:connecttype=\"custom\" textpathok=\"t\"/>"

                                        + "<v:textpath fitshape=\"t\" on=\"t\"/>"

                                        + "<v:handles>"
                                              + "<v:h position=\"#0,bottomRight\" xrange=\"6629,14971\"/>"

                                        +"</v:handles>"

                                        + "<o:lock shapetype=\"t\" text=\"t\" v:ext=\"edit\"/>"

                                  +"</v:shapetype>"

                                  + "<v:shape fillcolor=\"" + color + "\" id=\"PowerPlusWaterMarkObject357476642\" o:allowincell=\"f\" o:spid=\"_x0000_s2049\" stroked=\"f\" style=\"position:absolute;margin-left:0;margin-top:0;width:" + Float.toString(width) + "pt;height:" + Float.toString(height) + "pt;rotation:" + (isHorizontal ? "0" : "315") + ";z-index:-251658752;mso-position-horizontal:center;mso-position-horizontal-relative:margin;mso-position-vertical:center;mso-position-vertical-relative:margin\" type=\"#_x0000_t136\">"
                                        + "<v:fill opacity=\"" + (isTranslucent ? "0.5":"1.0") + "\"/>"

                                        + "<v:textpath string=\"" + watermark + "\" style=\"font-family:&quot;" + fontFamily + "&quot;;font-size:1pt\"/>"

                                        + "<w10:wrap anchorx=\"margin\" anchory=\"margin\"/>"

                                  +"</v:shape>"

                            +"</w:pict>"

                      +"</w:r>"

                +"</w:sdtContent>"

          +"</w:sdt>"
          + "</w:p>";
			
		P p = (P)XmlUtils.unmarshalString(openXML);			

	    hdr.getContent().add(p);
		return hdr;
	}
	*/
    /*
	public static String createTempFilePath(String filePath) {
		StringBuilder builder = new StringBuilder();
		int index = filePath.lastIndexOf('.');
		if (index != -1) {
			builder.append(filePath.substring(0,  index));
			builder.append(".tmp");
			builder.append(filePath.substring(index));
		}
		else {
			builder.append(filePath);
			builder.append(".tmp");
		}
		return builder.toString();
	}
	*/
	/**
     * ???????????? ??????poi
     * @param doc ?????????????????????word??????
     * @param watermark ??????????????????
     * @param color ???????????????
     * @param height ?????????????????????
     * @throws Exception
     */
    public static void addDocxWaterMark1(String docxInFilePath, 
    		String docxOutFilePath, String watermark, String fontFamily, 
    		float width, float height, String fillColor, boolean isTranslucent, 
    		boolean isHorizontal) throws Exception 
    {
        if (watermark == null || watermark.trim().isEmpty()) {
        	throw new InvalidParameterException(watermark + " is empty string");
        }
            	
        FileInputStream docxInputStream = null;
        FileOutputStream docxOutputStream = null;
        XWPFDocument doc = null;
        try {
        	docxInputStream = new FileInputStream(new File(docxInFilePath));
        	doc = new XWPFDocument(docxInputStream);
        	XWPFHeaderFooterPolicy headerFooterPolicy = 
        			doc.createHeaderFooterPolicy();
        	//??????????????????
            headerFooterPolicy.createWatermark(watermark);
            XWPFHeader header = 
            		headerFooterPolicy.getHeader(XWPFHeaderFooterPolicy.DEFAULT);
            XWPFParagraph paragraph = header.getParagraphArray(0);
            paragraph.getCTP().newCursor();
            XmlObject[] xmlobjects = paragraph.getCTP().getRArray(0).
            		getPictArray(0).selectChildren(
            				new QName("urn:schemas-microsoft-com:vml", "shape"));
            if (xmlobjects.length > 0) {
                com.microsoft.schemas.vml.CTShape ctshape = 
                		(com.microsoft.schemas.vml.CTShape)xmlobjects[0];
                //??????????????????
                ctshape.setFillcolor(fillColor);
                //??????????????????
                float rotation = isHorizontal? 0 : 315;
                ctshape.setStyle(getWaterMarkStyle(ctshape.getStyle(), width,
                		height, rotation));
                List<CTTextPath> textPathObjects = ctshape.getTextpathList();
                if (textPathObjects.size() > 0) {
                	 com.microsoft.schemas.vml.CTTextPath cttextpath = 
                			 (com.microsoft.schemas.vml.CTTextPath)
                			 textPathObjects.get(0);
                	 cttextpath.setStyle(getFontStyle(cttextpath.getStyle(), 
                			 fontFamily));
                }
                List<CTFill> fillObjects = ctshape.getFillList();
                if (fillObjects.size() > 0) {
                	com.microsoft.schemas.vml.CTFill ctfill = 
               			 (com.microsoft.schemas.vml.CTFill)fillObjects.get(0);
                	if (isTranslucent)
                		ctfill.setOpacity("0.5");
                	else
                		ctfill.setOpacity("1.0");
                }
            }
            docxOutputStream = new FileOutputStream(new File(docxOutFilePath));
            doc.write(docxOutputStream);
            docxOutputStream.flush();
        }
        catch(Exception e) {
        	e.printStackTrace();
        	//logger.error("add watermark1 to docx failed.");
        	//logger.error(e.getLocalizedMessage(), e);
            throw e;                    
        }
        finally {
        	if (doc != null) doc.close();
        	if (docxInputStream != null) docxInputStream.close();
        	if (docxOutputStream != null) docxOutputStream.close();
        }
    }

    /**
     * ?????????????????????????????????????????????
     * @param styleStr  ??????????????????
     * @param height    ??????????????????
     * @return
     */
    public static String getWaterMarkStyle(String styleStr,float width, 
    		float height, float rotation){
        Pattern p=Pattern.compile(";");
        String[] strs = p.split(styleStr);
        for(String str : strs){
            if(str.startsWith("height:")){
                 String heightStr = "height:" + height + "pt";
                 styleStr = styleStr.replace(str,heightStr);
                 continue;
             }
            if(str.startsWith("width:")){
                String widthStr = "width:" + width + "pt";
                styleStr = styleStr.replace(str,widthStr);
                continue;
            }
            if(str.startsWith("rotation:")){
                String rotationStr = "rotation:" + rotation + "f";
                styleStr = styleStr.replace(str,rotationStr);
                continue;
            }
        }
        return styleStr;
    }

    /**
     * ???????????????????????????????????????
     * @param styleStr   ??????????????????
     * @param fontFamily ????????????
     * @return
     */
    public static String getFontStyle(String styleStr, String fontFamily) {
        Pattern p = Pattern.compile(";;");
        String[] strs = p.split(styleStr);
        for(String str : strs){
            if(str.startsWith("font-family:&quot;")){
                 String heightStr = "font-family:&quot;" + fontFamily + "&quot";
                 styleStr = styleStr.replace(str,heightStr);
                 break;
             }
        }
        return styleStr;
    }
    
    /**
     * ???????????? ??????poi
     * @param filePath ??????????????????word
     * @param waterMarkValue ???????????????
     * @throws Exception 
     */
    public static void addDocxWaterMark2(String docxInFilePath, 
    		String docxOutFilePath, String waterMarkValue, String fontFamily, 
    		float width, float height, String fillColor, boolean isTranslucent, 
    		boolean isHorizontal) throws Exception {
    	InputStream in = null;
    	OutputStream out = null;
    	XWPFDocument document = null;
    	try {
    		in = new FileInputStream(new File(docxInFilePath));
    		out = new FileOutputStream(new File(docxOutFilePath));
    		document = new XWPFDocument(in);
        
            XWPFHeaderFooterPolicy xFooter = new XWPFHeaderFooterPolicy(document);
            XWPFHeader header = xFooter.getHeader(XWPFHeaderFooterPolicy.DEFAULT);
            List<XWPFParagraph> paragraphs = header.getParagraphs();
            for(XWPFParagraph graph: paragraphs){
            	String paraText = graph.getCTP().xmlText();
            	//????????????????????????????????????????????????
            	if	(paraText.contains("id=\"PowerPlusWaterMarkObject")){
            		replaceWaterMark(graph,waterMarkValue);
            	} else {//???????????????????????????
            		String newParaText = waterMark.replace("??????",waterMarkValue);
            		String newText = paraText.replace("</xml-fragment>", newParaText);
            		XmlToken token = XmlToken.Factory.parse(newText);
            		graph.getCTP().set(token);
            	}
            }
            document.write(out);
            out.flush();
    	} catch (Exception e) {
    		e.printStackTrace();
        	//logger.error("add watermark2 to docx failed.");
        	//logger.error(e.getLocalizedMessage(), e);
            throw e;                    
        }
    	finally {
    		if (document != null) {
            	try {
            		document.close();
            	} catch (IOException e) {
            		e.printStackTrace();
            	}
            }
            if (in != null) {
            	try {
            		in.close();
            	} catch (IOException e) {
            		e.printStackTrace();
            	}
            }
            if (out != null) {
            	try {
            		out.close();
            	} catch (IOException e) {
            		e.printStackTrace();
            	}
            }
        }
    }
    /**
     * ???????????????????????????????????????????????????
     * @param graph ??????????????????
     * @param waterMarkValue ????????????
     * @throws IOException
     * @throws XmlException
     */
    public static void replaceWaterMark(XWPFParagraph graph,
    		String waterMarkValue) throws IOException,XmlException{
        String paraText = graph.getCTP().xmlText();
        if (paraText.contains("id=\"PowerPlusWaterMarkObject")){//<v:shape id=\"PowerPlusWaterMarkObject
            String beginStr = "string=\"";
            int begin = paraText.indexOf(beginStr) + beginStr.length();
            int end = paraText.indexOf("\"", begin);
            String oldWaterMarkText = paraText.substring(begin, end);
            String newText = paraText.replace("string=\""+ oldWaterMarkText +"\"",
                    "string=\"" + waterMarkValue + "\"");
            XmlToken token = XmlToken.Factory.parse(newText);
            graph.getCTP().set(token);
        }
    }
    
    /**

     * word????????????

     * @param inputPath

     * @param outPath

     * @param markStr

     */

    public static void addDocxWaterMark(String docxInFilePath, 
    		String docxOutFilePath, String waterMarkValue, String fontFamily, 
    		float width, float height, String fillColor, boolean isTranslucent, 
    		boolean isHorizontal) throws Exception {
        InputStream in = null;
    	OutputStream out = null;
    	//2003doc ???HWPFDocument  ??? 2007doc ??? XWPFDocument
    	XWPFDocument doc = null;

        try {
            // ??????????????????
            ZipSecureFile.setMinInflateRatio(-1.0d);
            in = new FileInputStream(new File(docxInFilePath));
    		out = new FileOutputStream(new File(docxOutFilePath));
    		doc = new XWPFDocument(in);

    		XWPFHeaderFooterPolicy headerFooterPolicy = doc.getHeaderFooterPolicy();
    		if (headerFooterPolicy == null) {
                headerFooterPolicy = doc.createHeaderFooterPolicy();
            }
    		//????????????
            headerFooterPolicy.createWatermark(waterMarkValue);
            doc.write(out);
            out.flush();
        } catch (Exception e) {
        	e.printStackTrace();
        	//logger.error("add watermark3 to docx failed.");
        	//logger.error(e.getLocalizedMessage(), e);
            throw e; 
        } finally {
        	if (doc != null) {
                try {
                    doc.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (in != null) {
            	try {
            		in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (out != null) {
            	try {
            		out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    /*
    public static void addDocxWaterMark4(String docxInFilePath, 
    		String docxOutFilePath, String waterMarkValue, String fontFamily, 
    		float width, float height, String fillColor, boolean isTranslucent, 
    		boolean isHorizontal) throws Exception {
        InputStream in = null;
    	OutputStream out = null;
    	//2003doc ???HWPFDocument  ??? 2007doc ??? XWPFDocument
    	XWPFDocument doc = null;

    	try {
    		in = new FileInputStream(new File(docxInFilePath));
    		out = new FileOutputStream(new File(docxOutFilePath));
    		doc = new XWPFDocument(in);
            String markText = waterMarkValue;
            // ????????????????????????
            for (int lineIndex = -5; lineIndex < 20; lineIndex++) {
				// ??????????????????
                int styleTop = 100*lineIndex;               
                // ?????????????????????
                // ????????????????????????8???????????????
                markText = markText + repeatString(" ", 8);
                // ????????????????????????????????????
                markText = repeatString(markText, 10);
                // ??????????????????????????? DEFAULT ???Header???????????????
                XWPFHeader header = doc.createHeader(HeaderFooterType.DEFAULT);
                int size = header.getParagraphs().size();
                if (size == 0) {
					header.createParagraph();
                }
                CTP ctp = header.getParagraphArray(0).getCTP();
                byte[] rsidr = doc.getDocument().getBody().getPArray(0).getRsidR();
                byte[] rsidrdefault = doc.getDocument().getBody().getPArray(0).getRsidRDefault();
                ctp.setRsidP(rsidr);
                ctp.setRsidRDefault(rsidrdefault);
                CTPPr ppr = ctp.addNewPPr();
                ppr.addNewPStyle().setVal("Header");
                // ???????????????
                CTR ctr = ctp.addNewR();
                CTRPr ctrpr = ctr.addNewRPr();
                ctrpr.addNewNoProof();
                CTGroup group = CTGroup.Factory.newInstance();
                CTShapetype shapetype = group.addNewShapetype();
                CTTextPath shapeTypeTextPath = shapetype.addNewTextpath();
                shapeTypeTextPath.setOn(STTrueFalse.T);
                shapeTypeTextPath.setFitshape(STTrueFalse.T);
                CTLock lock = shapetype.addNewLock();
                lock.setExt(STExt.VIEW);
                CTShape shape = group.addNewShape();
                shape.setId("PowerPlusWaterMarkObject");
                shape.setSpid("_x0000_s102");
                shape.setType("#_x0000_t136");
                // ???????????????????????????????????????????????????????????????
				int rotation = styleRotation;
				if (isHorizontal) rotation = 0;
                shape.setStyle(getShapeStyle(markText, styleTop, rotation));
                shape.setFillcolor(fillColor);
                // ?????????????????????
                shape.setStroked(STTrueFalse.FALSE);
                // ?????????????????????
                CTTextPath shapeTextPath = shape.addNewTextpath();
                // ???????????????????????????
                shapeTextPath.setStyle("font-family:" + fontFamily + ";font-size:0.2pt");
                shapeTextPath.setString(markText);
                CTPicture pict = ctr.addNewPict();
                pict.set(group);
            }
            doc.write(out);//???????????????
			out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        	//logger.error("add watermark4 to docx failed.");
        	//logger.error(e.getLocalizedMessage(), e);
            throw e; 
        }    
		finally {			
            if (doc != null) {
				try {
					doc.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
            if (in != null) {
				try {
					in.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
        }
    }
	*/
	/**
 	 * ??????Shape???????????????
 	 * @param customText
 	 * @return
 	 */
    /*
	private static String getShapeStyle(String customText, int top, int rotation) {
    	StringBuilder sb = new StringBuilder();
    	// ??????path?????????????????????
    	sb.append("position: ").append("absolute");
    	// ?????????????????????????????????????????????*???????????????
    	sb.append(";width: ").append(customText.length() * widthPerWord).append("pt");
    	// ????????????
    	sb.append(";height: ").append("20pt");
    	sb.append(";z-index: ").append("-251654144");
    	sb.append(";mso-wrap-edited: ").append("f");
    	// ??????????????????????????????????????????????????????top,?????????margin-top???
    	sb.append(";margin-top: ").append(top);
    	sb.append(";mso-position-horizontal-relative: ").append("page");
    	sb.append(";mso-position-vertical-relative: ").append("page");
    	sb.append(";mso-position-vertical: ").append("left");
    	sb.append(";mso-position-horizontal: ").append("center");
    	sb.append(";rotation: ").append(rotation);
    	return sb.toString();
	}
	*/
	/**
	 * ???????????????????????????repeats???.
	 */
    /*
	private static String repeatString(String pattern, int repeats) {
		StringBuilder buffer = new StringBuilder(pattern.length() * repeats);
		Stream.generate(() -> pattern).limit(repeats).forEach(buffer::append);
		return new String(buffer);
	}
	*/
}
