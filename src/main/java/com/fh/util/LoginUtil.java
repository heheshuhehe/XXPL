package com.fh.util;

import javax.servlet.http.HttpServletRequest;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

public class LoginUtil {

	public LoginUtil() {
		// TODO Auto-generated constructor stub
	}
	
	public static String getIPAdrress(HttpServletRequest request) {
		String ip = request.getHeader( "x-forwarded-for" );
	    if ( ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase( ip ) )
	    {
	        ip = request.getHeader( "Proxy-Client-IP" );
	    }
	    if ( ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase( ip ) )
	    {
	        ip = request.getHeader( "WL-Proxy-Client-IP" );
	    }
	    if ( ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase( ip ) )
	    {
	        ip = request.getRemoteAddr();
	    }
	    return ip;
	}

}
