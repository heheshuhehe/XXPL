package com.fh.util.sql;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.fh.util.sql.JdbcConfigBuilder.DbInstance;


/***
 * 具体连接获取
 * 
 * @author jiangshan
 * 
 */
public class ConGetter {
	static Logger loger = Logger.getLogger(ConGetter.class);

	public ConGetter() {
		super();

	}

	public Connection get_connection() {

		return JdbcConfigBuilder.get_connection(DbInstance.kfgl_mysql);

	}

	public static void main(String[] args) {
		loger.info(new ConGetter().get_connection());
	}
}
