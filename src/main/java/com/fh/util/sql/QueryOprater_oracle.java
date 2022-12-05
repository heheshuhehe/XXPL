package com.fh.util.sql;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class QueryOprater_oracle {
	
	private Connection connection;

	public QueryOprater_oracle(Connection connection_) {
		connection = connection_;
	}
	
	public QueryOprater_oracle() {
		connection = new ConGetter().get_connection();
	}
	
	public void closeConnection(){
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// private Connection connection;

	public List<LinkedHashMap<String, Object>> doQuery(String sql)
			throws Exception {
		//Connection connection = new ConGetter().get_connection();
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columns = rsmd.getColumnCount();
		List<Method> methods = new ArrayList<Method>();
		List<String> columnNames = new ArrayList<String>();
		for (int i = 1; i <= columns; i++) {
			String methodName = "getObject";
			String type = rsmd.getColumnTypeName(i).toUpperCase();
			if (type.equals("NUMBER")) {
				methodName = "getBigDecimal";
			} else if (type.equals("CHAR") || type.equals("VARCHAR2")) {
				methodName = "getString";
			} else if (type.equals("DATE")) {
				methodName = "getDate";
			}
			columnNames.add(rsmd.getColumnName(i).toLowerCase());
			methods.add(ResultSet.class.getMethod(methodName,
					new Class[] { int.class }));
		}
		List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
		while (rs.next()) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
			for (int i = 0; i < columns; i++) {

				map.put(columnNames.get(i),
						methods.get(i).invoke(rs, new Object[] { i + 1 }));
			}
			list.add(map);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return list;
	}

	public List<LinkedHashMap<String, String>> getAllStringList(String sql)
			throws Exception {
		//Connection connection = new ConGetter().get_connection();
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columns = rsmd.getColumnCount();
		List<String> columnNames = new ArrayList<String>();
		for (int i = 1; i <= columns; i++) {
			columnNames.add(rsmd.getColumnName(i).toLowerCase());
		}
		List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
		while (rs.next()) {
			LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
			for (int i = 0; i < columns; i++) {
				Object object = rs.getObject(i + 1);
				String string = object == null ? null : object.toString();
				map.put(columnNames.get(i), string);
			}
			list.add(map);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return list;
	}

	public void addTest(String sql) {
		//Connection connection = new ConGetter().get_connection();

		try {
			Statement pStatement = connection.createStatement();
			int result = pStatement.executeUpdate(sql);

			if (result == 0) {
				System.out.println("保存成功");
			}

			pStatement.close();
			//connection.close();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

	}

	public List<LinkedHashMap<String, String>> getDatasOfPage(String sql,
			int page, int size) throws Exception {
		//Connection connection = new ConGetter().get_connection();
		List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
		LinkedHashMap<String, String> info_map = new LinkedHashMap<String, String>();
		if (page <= 0 || size <= 0) {
			info_map.put("error", "椤垫暟涓嶈兘灏忎�?,姣忛〉鐨勬潯鏁颁篃涓嶈兘灏忎�?0");
			list.add(info_map);
			return list;
		}
		int maxSize = getMaxPages(sql, connection);
		int pages = 1;
		if (maxSize % size == 0) {
			pages = maxSize / size;
		} else {
			pages = maxSize / size + 1;
		}
		info_map.put("maxSize", maxSize + "");
		info_map.put("tottalPages", pages + "");
		int minNUM = size * (page - 1) + 1;
		int maxNUM = size * (page);
		list.add(info_map);
		String sql1 = "select * from (" + " select rownum rn,a.*" + " from ("
				+ sql + ")a" + " where rownum <= " + maxNUM + " )"
				+ " where rn >= " + minNUM;

		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql1);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columns = rsmd.getColumnCount();
		List<String> columnNames = new ArrayList<String>();
		for (int i = 1; i <= columns; i++) {
			columnNames.add(rsmd.getColumnName(i).toLowerCase());
		}
		while (rs.next()) {
			LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
			for (int i = 1; i < columns; i++) {
				Object object = rs.getObject(i + 1);
				String string = object == null ? null : object.toString();
				map.put(columnNames.get(i), string);
			}
			list.add(map);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return list;
	}

	private int getMaxPages(String sql, Connection connection) throws Exception {
		// 瑙ｅ喅SQL鎺掑簭褰卞搷缁熻鏁扮洰鐨勯棶棰�sql涓�?order by"蹇呴』鏄繖绉嶅浐�?氬啓娉�
		if (sql.lastIndexOf("select ") < sql.lastIndexOf("order by ")) {
			sql = sql.substring(0, sql.lastIndexOf("order by "));
		}
		String sql_new = "select count(1) from ( " + sql + " ) a ";
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql_new);
		while (rs.next()) {
			return rs.getInt(1);
		}
		return 0;
	}

	public Object getValue(String sql) throws Exception {
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		while (rs.next()) {
			return rs.getObject(1);
		}
		pStatement.close();
		//connection.close();
		return null;
	}

	// public void UPI(String sql,Connection connection) throws Exception
	// {
	//
	//
	// Statement stmt = connection.createStatement();
	// stmt.execute(sql);
	// }

	public void setAutoCommit(boolean b, Connection connection) {
		if (connection != null) {
			try {
				connection.setAutoCommit(b);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void rollback(Connection connection) {
		if (connection != null) {
			try {
				connection.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void commit(Connection connection) {
		if (connection != null) {
			try {
				connection.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public LinkedHashMap<String, String> getLinkedMap(String sql)
			throws Exception {
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columns = rsmd.getColumnCount();
		List<String> columnNames = new ArrayList<String>();
		for (int i = 1; i <= columns; i++) {
			columnNames.add(rsmd.getColumnName(i).toLowerCase());
		}
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		while (rs.next()) {
			for (int i = 0; i < columns; i++) {
				Object object = rs.getObject(i + 1);
				String string = object == null ? null : object.toString();
				map.put(string, string);
			}
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return map;
	}

	public List<String> getResultList(String sql) throws Exception {
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		List<String> list = new ArrayList<String>();
		while (rs.next()) {
			Object object = rs.getObject(1);
			String string = object == null ? null : object.toString();
			list.add(string);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return list;
	}

	public void UPI(String sql) throws Exception {
		Statement statement = connection.createStatement();
		statement.execute(sql);
		statement.close();
		//connection.close();
	}

	public LinkedHashMap<String, String> getIdNameModeMap(String sql)
			throws Exception {
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		while (rs.next()) {
			String key = rs.getString(1);
			String val = rs.getString(2);
			map.put(key, val);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return map;
	}

	public LinkedHashMap<String, Double> getKeyValueModeMap(String sql)
			throws Exception {
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		LinkedHashMap<String, Double> map = new LinkedHashMap<String, Double>();
		while (rs.next()) {
			String key = rs.getString(1);
			String strval = rs.getString(2);
			Double val = Double.parseDouble(strval);
			map.put(key, val);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return map;
	}

	public Map<String, LinkedHashMap<String, String>> getKeyEntityModeMap(
			String sql) throws Exception {
		Statement pStatement = connection.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = pStatement.executeQuery(sql);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columns = rsmd.getColumnCount();
		List<String> columnNames = new ArrayList<String>();
		for (int i = 1; i <= columns; i++) {
			columnNames.add(rsmd.getColumnName(i).toLowerCase());
		}
		Map<String, LinkedHashMap<String, String>> resultmap = new HashMap<String, LinkedHashMap<String, String>>();
		while (rs.next()) {
			LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
			String key = "";
			for (int i = 0; i < columns; i++) {
				Object object = rs.getObject(i + 1);
				String string = object == null ? null : object.toString();
				map.put(columnNames.get(i), string);
				if (i == 0) {
					key = string;
				}
			}
			resultmap.put(key, map);
		}
		pStatement.close();
		rs.close();
		//connection.close();
		return resultmap;
	}
}
