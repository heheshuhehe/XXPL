/**
 * 
 */
package com.fh.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.Properties;

import org.apache.log4j.Logger;
 
public final class SysInfo {
	private static final Logger logger = Logger.getLogger(SysInfo.class);

	public static Properties props=System.getProperties();
	public static String OS_NAME=getPropertery("os.name");
	public static String OS_LINE_SEPARATOR=getPropertery("line.separator");
	public static String OS_FILE_SEPARATOR=getPropertery("file.separator");
	
   
    public static String getSystemLocalIp() throws UnknownHostException{
    	String ip="";
    	InetAddress inet=null;
    	String osname=getSystemOSName();
    	//logger.info("osname:"+osname);
    	try {
			if(osname.contains("Window")){
					inet=getWinLocalIp();
			}else if(osname.contains("Linux")){
					inet=getUnixLocalIp();
			}
			if(null==inet){
				throw new UnknownHostException("");
			}
		}catch (SocketException e) {
			logger.error(""+e.getMessage());
			//throw new UnknownHostException(""+e.getMessage());
		}
    	if(inet!=null){
    		ip = inet.getHostAddress();
    	}
		return ip;
    }
	 
	public static String getSystemOSName() {
		Properties props=System.getProperties();
		String osname=props.getProperty("os.name");  
		if(logger.isDebugEnabled()){
			//logger.info("the ftp client system os Name "+osname);
		}
		return osname;
	}
	 
	public static String getPropertery(String propertyName){
		return props.getProperty(propertyName);
	}
    
 
    private static InetAddress getWinLocalIp() throws UnknownHostException{
		InetAddress inet = InetAddress.getLocalHost();     
		logger.info("ip=" + inet.getHostAddress()); 
         return inet;
	}
 
	private static InetAddress getUnixLocalIp() throws SocketException{
			Enumeration<NetworkInterface> netInterfaces = NetworkInterface.getNetworkInterfaces();
			InetAddress ip = null; 
			while(netInterfaces.hasMoreElements()){     
				//logger.info("进入netInterfaces循环里，netInterfaces不为空.. .... ..");
			    NetworkInterface ni= (NetworkInterface)netInterfaces.nextElement();     
			 //   logger.info("NetworkInterface名称："+ni.getName());  //打印网端名字  
			    Enumeration<InetAddress> addresses = ni.getInetAddresses(); //同样再定义网络地址枚举类  
			    while (addresses.hasMoreElements())  {
			    	 ip = addresses.nextElement();  
					 if( !ip.isSiteLocalAddress() && !ip.isLoopbackAddress()&& ip.getHostAddress().indexOf(":")==-1){     
					    	//logger.info("返回ip地址："+ip);
					    	return ip;
					    }     
			    } 
			}   
			
		return null;
	}
 
    public static final String getRAMinfo() {
        Runtime rt = Runtime.getRuntime();
        return "RAM: " + rt.totalMemory() + " bytes total, " + rt.freeMemory() + " bytes free.";
    }
    public static void main(String[] args) throws UnknownHostException {
		logger.info(SysInfo.getRAMinfo());
		try {
			logger.info(SysInfo.getWinLocalIp());
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		logger.info(SysInfo.getSystemLocalIp());
		
	}
}
