<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileNotFoundException"%>
 
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<%



  
try{
	InputStream is = null; 
	OutputStream os = null; 
	BufferedInputStream bis = null; 
	BufferedOutputStream bos = null; 
	String fullpath = request.getParameter("fullpath"); 
	//System.out.println(fullpath);
	fullpath=new String (fullpath.getBytes("iso-8859-1"),"utf-8");
	//System.out.println(fullpath);
	String filename = request.getParameter("filename"); 
	filename=new String (filename.getBytes("iso-8859-1"),"utf-8");

	is = new FileInputStream(new File(fullpath)); 
	response.setContentType("applicaiton/x-download"); 
	response.addHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(filename,"utf-8") ); 
	bis = new BufferedInputStream(is); 
	os = response.getOutputStream(); 
	bos = new BufferedOutputStream(os); 
	  
	byte[] b = new byte[1024]; 
	int len = 0; 
	while((len = bis.read(b)) != -1){ 
	  bos.write(b,0,len); 
	} 
	out.clear();
	out=pageContext.pushBody();
	bis.close(); 
	is.close(); 
	bos.close(); 
	os.close(); 
}catch(FileNotFoundException ex){
	
	out.println("<script language='javascript' type='text/javascript' > alert('文件不存在！') </script>") ;
}


%>

</head>
<body>

</body>
</html>