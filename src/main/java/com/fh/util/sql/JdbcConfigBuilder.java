package com.fh.util.sql;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/***
 * 
 * @author wuguojiang
 * 
 * @since 2012-6-26
 * 
 * @version 2012-6-26
 * 
 */
public class JdbcConfigBuilder {

	static String propertiesdir = "jdbc.properties";

	public static Properties pros = new Properties();

	static {
		ClassLoader cl = JdbcConfigBuilder.class.getClassLoader();
		try {
			pros.load(cl.getResourceAsStream(propertiesdir));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public JdbcConfigBuilder() {
	}

	public enum DbInstance {
		local_mysql("local_mysql"), kfgl_mysql("kfgl_mysql");

		private String value = null;

		DbInstance(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	public static Connection get_connection(DbInstance dbInstance) {
		return getConnectionByDBname(dbInstance.getValue());

	}

	/***
	 * 
	 * @param connectionname
	 * @return
	 */
	public static Connection getConnectionByDBname(String connectionname) {

		Connection conn = null;
		if (conn == null) {
			// 二次获得连接
			String driver = pros.getProperty("db.driverClass");
			String url = pros.getProperty("db.jdbcUrl");
			String username = pros.getProperty("db.user");
			String password = pros.getProperty("db.password");
			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url, username, password);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return conn;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Connection connection = JdbcConfigBuilder
				.getConnectionByDBname("kfgl_mysql");

		System.out.println(connection);
	}

}
