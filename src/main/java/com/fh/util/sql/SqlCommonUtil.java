package com.fh.util.sql;
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;
 
import org.apache.log4j.Logger;
import org.junit.Test;
 
import sinosoft.utils.PropertyUtils;
 
public class SqlCommonUtil {
 
    protected Logger logger = Logger.getLogger(this.getClass());
    /**
     * 获得PreparedStatement向数据库提交的SQL语句
     * 
     * @param sql
     * @param params
     * @return
     * 
     */
    public static String getPreparedSQL(String sql, Object... params) {
        // 1 如果没有参数，说明是不是动态SQL语句
        int paramNum = 0;
        if (null != params)
            paramNum = params.length;
        if (1 > paramNum)
            return sql;
        // 2 如果有参数，则是动态SQL语句
        StringBuffer returnSQL = new StringBuffer();
        String[] subSQL = sql.split("\\?");
        for (int i = 0; i < paramNum; i++) {
            // if (params[i] instanceof Date) {
            // returnSQL
            // .append(subSQL[i])
            // .append(" '")
            // .append(MyDateUtil
            // .dateUtil2SQL((java.util.Date) params[i]))
            // .append("' ");
            // } else {
            returnSQL.append(subSQL[i]).append(" '").append(params[i])
                    .append("' ");
            // }
        }
 
        if (subSQL.length > params.length) {
            returnSQL.append(subSQL[subSQL.length - 1]);
        }
        return returnSQL.toString();
    }
    
    /**
     * get SQL content, judge whether the path is valid
     * @param sqlPath
     * @return null if the path not valid, otherwise call readAndLoadSQLScript  
     * @throws IOException 
     * @throws Exception 
     */
    public static String getSQLTXT (String sqlname) throws IOException  {
        try {
            if (null == sqlname || "" == sqlname) return null;
            String sqlScriptPath = PropertyUtils.getSysConfigSet("sqlScriptPath");
            //System.out.println("reading SQL script in path: "+ downloadBase);
//            File directory = new File ("");
//            System.out.println(directory.getCanonicalPath().toString());
            
            String path = SqlCommonUtil.class.getResource("/").toString().replace("file:/", "");
            path = path+sqlScriptPath+sqlname;
            
//            System.out.println("reading SQL script in path: "+ path);
            if (null == new File(path) ) return null; //throw new IOException("Cannot get the file: " + path);
            return new SqlCommonUtil().readAndLoadSQLScript (path); 
        } finally {
            
        }
    }
    
    /**
     * the implement of getting SQL content
     * @param sql
     * @param params
     * @return SQL content
     */
    public String readAndLoadSQLScript(String sqlPath) {
        String sqlContent = new String();
        try (Stream<String> stream = Files.lines(Paths.get(sqlPath),Charset.forName("UTF-8"))){
                List<String> raws = new ArrayList<>();
                raws = stream.collect(Collectors.toList());
                for (String s: raws) {
                    sqlContent += s;
                }
        } catch (IOException e) {
            logger.error(e);
        }
//        logger.info("sql content is :"+sqlContent);
        return sqlContent;
    }
 
    @Test
    public void testCommonSQL () throws IOException {
        final String string = "test.txt";
        getSQLTXT(string);
    }
}