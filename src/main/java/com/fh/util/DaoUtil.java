package com.fh.util;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Reader;
import java.lang.reflect.Field;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.bouncycastle.asn1.x509.qualified.TypeOfBiometricData;

import oracle.jdbc.driver.OracleTypes;


public class DaoUtil {

	DataSource ds;

	public static enum LogType{ REQandPARAM,SQL}

	public DataSource getDs() {
		return ds;
	}

	public void setDs(DataSource ds) {
		this.ds = ds;
	}
	public static List<Map<String, Object>> getResultToList(Connection conn, String sql, Object... params) {
		
		/*if(sql.length()<1200)
			System.out.println("SQL:"+sql);*/
		test(LogType.SQL,sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
		if (null == sql || "".equals(sql)) {
			return new ArrayList<Map<String, Object>>();
		}
		try {
			ps = conn.prepareStatement(sql);
			if (null != params && params.length > 0) {
				for (int i = 0, len = params.length; i < len; i++) {
				
					System.out.println(params[i].getClass().toString());
					if ("class java.util.Date".equals(params[i].getClass().toString())){
						java.sql.Date sqldate=new java.sql.Date(((java.util.Date)params[i]).getTime());
						ps.setDate(i+1,  sqldate);
					}
					else 
						ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();
			if (null != rs) {
				ResultSetMetaData rsm = rs.getMetaData();
				int count = rsm.getColumnCount();
				Map<String, Object> record = null;
				if (count > 0) {
					while (rs.next()) {
						record = new HashMap<String, Object>();
						for (int j = 0; j < count; j++) {
							Object obj = rs.getObject(j + 1);
							if(obj instanceof Clob){
								Clob clo=(Clob)obj;
								obj=clo.getSubString((long)1, (int) clo.length());
							}
								
							String columnName = rsm.getColumnName(j + 1);
							int columnType = rsm.getColumnType(j+1);
							if(!"_parentId".equals(columnName)){
								if(columnType==2){
									record.put(columnName.toLowerCase(),(obj == null) ? "0": obj);
								}else{
									record.put(columnName.toLowerCase(),(obj == null) ? "" : obj);
								}
							}else{
								record.put(columnName,(obj == null) ? "" : obj);
							}
						}
						rows.add(record);
					}
				}

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			release(rs, ps);
		}

		return rows;
	}
public static List<Map<String, Object>> getResultToList4numberTonull(Connection conn, String sql, Object... params) {
	test(LogType.SQL,sql);
		if(sql.length()<600)
		System.out.println("SQL:"+sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
		if (null == sql || "".equals(sql)) {
			return new ArrayList<Map<String, Object>>();
		}
		try {
			ps = conn.prepareStatement(sql);
			if (null != params && params.length > 0) {
				for (int i = 0, len = params.length; i < len; i++) {
				
					System.out.println(params[i].getClass().toString());
					if ("class java.util.Date".equals(params[i].getClass().toString())){
						java.sql.Date sqldate=new java.sql.Date(((java.util.Date)params[i]).getTime());
						ps.setDate(i+1,  sqldate);
					}
					else 
						ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();
			if (null != rs) {
				ResultSetMetaData rsm = rs.getMetaData();
				int count = rsm.getColumnCount();
				Map<String, Object> record = null;
				if (count > 0) {
					while (rs.next()) {
						record = new HashMap<String, Object>();
						for (int j = 0; j < count; j++) {
							Object obj = rs.getObject(j + 1);
							String columnName = rsm.getColumnName(j + 1);
							int columnType = rsm.getColumnType(j+1);
							if(!"_parentId".equals(columnName)){
								if(columnType==2){
									record.put(columnName.toLowerCase(),(obj == null) ? "": obj);
								}else{
									record.put(columnName.toLowerCase(),(obj == null) ? "" : obj);
								}
							}else{
								record.put(columnName,(obj == null) ? "" : obj);
							}
						}
						rows.add(record);
					}
				}

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			release(rs, ps);
		}

		return rows;
	}

	public static void insert (Connection conn, String sql) {
		test(LogType.SQL,sql);
		PreparedStatement ps=null;
		try {
			
			ps=conn.prepareStatement(sql);
			ps.executeUpdate();	
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			release(ps);
		}
		
	}
	public static void insertWithErrorPrompt (Connection conn, String sql) throws SQLException  {
		test(LogType.SQL,sql);
		PreparedStatement ps=null;
		try {
			
			ps=conn.prepareStatement(sql);
			ps.executeUpdate();	
		} 
		finally {
			release(ps);
		}
		
	}
//??????
	public static void release(Object...obj){
			if(null!=obj){
				for(Object o:obj){
					try {
						if (o instanceof ResultSet) {
							((ResultSet) o).close();					
						}else if (o instanceof PreparedStatement) {
							((PreparedStatement) o).close();
						} else if (o instanceof Connection) {
						((Connection) o).close();
						}
						else if (o instanceof CallableStatement) {
							((CallableStatement) o).close();
							}
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
			}
		}
	public  static void test(LogType type, String logtxt) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		String dateste=sdf.format(Calendar.getInstance().getTime());
		String path="";
	    try{
	    	if(type==LogType.REQandPARAM){
	    		 path = "D:/logs/reqparam"+dateste+".log";
	    	}else if(type==LogType.SQL){
	    		 path = "D:/logs/sql"+dateste+".log";
	    	}
	    
	    if(!new File("D:/logs").exists()){
	    	new File("D:/logs").mkdir();
	    }

	    File file = new File(path);
	    //????????????????????????????????????????????????
	    if(!file.exists()){
	    	return;//??????????????????sql????????????
	       // file.createNewFile();
	    }
	
	    //???????????????
	    OutputStream outPutStream;
	
	        outPutStream = new FileOutputStream(file,true);
	        StringBuilder stringBuilder = new StringBuilder();//???????????????????????????????????????
	        stringBuilder.append(sdf1.format(Calendar.getInstance().getTime())+logtxt+"\r\n");//??????????????????
	        //TODO ???????????????????????????;
	
	
	        String context = stringBuilder.toString();//???????????????????????????????????????????????????????????????????????????
	        byte[]  bytes = context.getBytes("UTF-8");//????????????????????????????????????????????????????????????UTF-8???
	        outPutStream.write(bytes);//??????????????????????????????
	        outPutStream.close();//???????????????????????????
	    }catch(Exception e){
	        e.printStackTrace();//????????????
	    }
	}
	
	/**
	 * ????????? ???cursor ???????????????list
	 *
	 * */
	public static Object[] getListFromProcedure(Connection con,String spName, Integer[] OUTOracleTypes,Object... INparams) {
		Object [] result=null;
		CallableStatement callSP=null;
		ResultSet rs=null;
		List<Map<String, Object>> curList=new ArrayList<>();
		try {
			String str2="";
			String  str1="";
			
			if (null != INparams && INparams.length > 0) {
				for (int i = 0, len = INparams.length; i < len; i++) {
					str2+=" ?,";
				}
				
				
			}
			if (null != OUTOracleTypes && OUTOracleTypes.length > 0) {
				for (int i = 0, len = OUTOracleTypes.length; i < len; i++) {
					str2+=" ?,";
				}
				
				result=new Object[OUTOracleTypes.length];
			}
			if(str2.length()>0){
				str2= str2.substring(0,str2.length()-1);
				str1=" ("+str2+")";
			}else
				str1="";
			
			
		
			String callSPStr=" {call "+spName+str1+ "}";
			callSP=con.prepareCall(callSPStr);
			//????????????
			if (null != INparams && INparams.length > 0) {
				for (int i = 0, len = INparams.length; i < len; i++) {
					System.out.println(INparams[i].getClass().toString());
					if ("class java.util.Date".equals(INparams[i].getClass().toString())){
						java.sql.Date sqldate=new java.sql.Date(((java.util.Date)INparams[i]).getTime());
						callSP.setDate(i+1,  sqldate);
					}else 
						callSP.setObject(i+1, INparams[i]);
				}
			}
		
			
			//????????????
			int baseLen=0;
			if(null != INparams && INparams.length > 0)
				baseLen=INparams.length;
			
			
			if (null != OUTOracleTypes && OUTOracleTypes.length > 0) {
				for (int i = 0, len = OUTOracleTypes.length; i < len; i++) {
						callSP.registerOutParameter(baseLen+i+1, OUTOracleTypes[i]); 
				}
			}
			
			 callSP.execute();
			 if (null != OUTOracleTypes && OUTOracleTypes.length > 0) {
					for (int i = 0, len = OUTOracleTypes.length; i < len; i++) {
						result[i]=callSP.getObject(baseLen+i+1);
							
					}
				}
			 if(null != OUTOracleTypes && OUTOracleTypes.length > 0){
				 for (int i = 0, len = OUTOracleTypes.length; i < len; i++) {

					 if(OUTOracleTypes[i]==OracleTypes.CURSOR){
						 rs =(ResultSet)result[i];
							if (null != rs) {
								ResultSetMetaData rsm = rs.getMetaData();
								int count = rsm.getColumnCount();
								Map<String, Object> record = null;
								if (count > 0) {
									while (rs.next()) {
										record = new HashMap<String, Object>();
										for (int j = 0; j < count; j++) {
											Object obj = rs.getObject(j + 1);
											String columnName = rsm.getColumnName(j + 1);
											int columnType = rsm.getColumnType(j+1);
											if(!"_parentId".equals(columnName)){
												if(columnType==2){
													record.put(columnName.toLowerCase(),(obj == null) ? "0": obj);
												}else{
													record.put(columnName.toLowerCase(),(obj == null) ? "" : obj);
												}
											}else{
												record.put(columnName,(obj == null) ? "" : obj);
											}
										}
										curList.add(record);
									}
								}

							}
							result[i]=curList;
							break;
					 }
							
					}
			 }
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DaoUtil.release(callSP,rs);
		}
		
		
		return result;
	}
	public static void getcallProcedure(Connection con,String spNameinculdeParams) {
		CallableStatement callSP=null;
	try {
				
			callSP=con.prepareCall(spNameinculdeParams);
			callSP.executeQuery();
	}
	catch (Exception e) {
		e.printStackTrace();
	}finally {
		DaoUtil.release(callSP);
	}
	
	}
	public static List<Map<String, Object>> getListFromProcedure(Connection con,String spNameinculdeParams) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		CallableStatement callSP=null;
		
		ResultSet rs=null;
		try {
			
			callSP=con.prepareCall(spNameinculdeParams);
		
			
			rs = callSP.executeQuery();
			if (null != rs) {
				ResultSetMetaData rsm = rs.getMetaData();
				int count = rsm.getColumnCount();
				Map<String, Object> record = null;
				if (count > 0) {
					while (rs.next()) {
						record = new HashMap<String, Object>();
						for (int j = 0; j < count; j++) {
							Object obj = rs.getObject(j + 1);
							String columnName = rsm.getColumnName(j + 1);
							int columnType = rsm.getColumnType(j+1);
							if(!"_parentId".equals(columnName)){
								if(columnType==2){
									record.put(columnName.toLowerCase(),(obj == null) ? "0": obj);
								}else{
									record.put(columnName.toLowerCase(),(obj == null) ? "" : obj);
								}
							}else{
								record.put(columnName,(obj == null) ? "" : obj);
							}
						}
						result.add(record);
					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DaoUtil.release(callSP);
		}
		
		
		return result;
	}
	public static void main(String[] args) {
		
		
		
		String StrUrl="jdbc:oracle:thin:@172.18.180.18:1521:sjcjdb1";
		Connection con=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection(StrUrl, "mds", "mds");
			List<Map<String, Object>> result=DaoUtil.getResultToList(con, "select * from rept_q_magr_rept where rownum=1 ");
			for(Map<String, Object> one :result){
				System.out.println(one.get("magr_rept").toString());
		
			}
			
		
	/*	String StrUrl="jdbc:oracle:thin:@18.10.20.100:1521:glrdb1";
		Connection con=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection(StrUrl, "db_fm", "db_fm_sinosoft");
			Integer [] types =new Integer [3];
			types[0]=OracleTypes.NUMBER;
			types[1]=OracleTypes.VARCHAR;
			types[2]=OracleTypes.CURSOR;
			Object[] result=DaoUtil.getListFromProcedure(con, " p_cl_calu_profit",types,"SA0514","20201019","1","0","");
			
			//List<Map<String, Object>> result=DaoUtil.getListFromProcedure(con, " { call p_cl_calu_profit@zhglpt( 'SA0090','20201019','0','0','',vary,vary1,vv3)  }"  );
			System.out.println("'");*/
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DaoUtil.release(con);
		}
		
	}
	

	/**
	 * ????????????????????????????????????????????????????????????sql?????????????????????????????????
	 * ??????????????????????????????????????????JAVA??????????????????????????????????????????
	 * @author 230355
	 * @param <T>	Type
	 * @param conn	SQL connection
	 * @param sql	SQL ??????
	 * @param cls	???????????????
	 * @return
	 */
   static  public  <T> List<T> resultSetToList(Connection conn, String sql,Class<T> cls) {
        //?????????????????????
        List<T> list = new ArrayList<T>();
        //?????????????????????????????????????????????
        Object obj=null;
        try {
        	 ResultSet rs = getResultSet(conn,sql);
            while (rs.next()) {
                //????????????????????????????????????????????????
                obj = cls.newInstance();
                //??????????????????????????????????????????????????????
//                Field [] fields = cls.getDeclaredFields();
                for(Field fd:cls.getDeclaredFields()){
                 		   //????????????
                 		 fd.setAccessible(true);
                  		  //?????????????????????
                 		 if (rs.getObject(fd.getName())==null) fd.set(obj,null);
                 		 if (rs.getObject(fd.getName()) instanceof Clob) {
                  			String temp =  ClobToString((Clob) rs.getObject(fd.getName()));
                  			fd.set(obj,temp);             			 
                 		 } 
                 		 else 
                 			 fd.set(obj,rs.getObject(fd.getName()));
                    }
                //????????????????????????
                list.add((T)obj);
            }
                
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (IOException e) {
			e.printStackTrace();
		}
        //????????????
        return list;
    }	
	
   /**
    * ?????????ResultSet
    * @author 230355
    * @param <T>
    * @param conn
    * @param sql
    * @param params
    * @return
    */
	private static <T> ResultSet getResultSet(Connection conn, String sql, Object... params) {
		
		/*if(sql.length()<1200)
			System.out.println("SQL:"+sql);*/
//		test(LogType.SQL,sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
		if (null == sql || "".equals(sql)) {
			return null;
		}
		try {
			ps = conn.prepareStatement(sql);
			if (null != params && params.length > 0) {
				for (int i = 0, len = params.length; i < len; i++) {
				
					System.out.println(params[i].getClass().toString());
					if ("class java.util.Date".equals(params[i].getClass().toString())){
						java.sql.Date sqldate=new java.sql.Date(((java.util.Date)params[i]).getTime());
						ps.setDate(i+1,  sqldate);
					}
					else 
						ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();

		}catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	/**
	 * clob???string
	 * @param clob	??????clob
	 * @return		??????String
	 * @throws SQLException
	 * @throws IOException
	 */
	static public  String ClobToString(Clob clob) throws SQLException, IOException {
		 
		String reString = "";
		Reader is = clob.getCharacterStream();// ?????????
		BufferedReader br = new BufferedReader(is);
		String s = br.readLine();
		StringBuffer sb = new StringBuffer();
		while (s != null) {// ?????????????????????????????????????????????StringBuffer???StringBuffer??????STRING
			sb.append(s + "\n");
			s = br.readLine();
		}
		reString = sb.toString();
		reString=reString.replaceAll("\\n", "\n");
		return reString;
	}
}


