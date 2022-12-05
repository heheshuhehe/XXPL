package com.cfwx;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cfwx.multichannel.http.HttpClient;
import com.cfwx.multichannel.userinterface.pack.HttpPack;
import com.cfwx.multichannel.userinterface.pack.Message;
import com.cfwx.multichannel.userinterface.pack.RespPack;
import com.cfwx.multichannel.userinterface.pack.WSPack;
import com.cfwx.multichannel.ws.WsClient;

/**
 * 【注意�?�项目请采用UTF-8编码，如果是GBK编码，涉及中文的地方�?要转码成UTF-8编码�?
 */
public class SmS_go {

	public int send_sms(String phoneNums, String sms_content) {

		String url = "http://172.16.0.229:88/WEBService/DXBZJK.cfm"; // 由新短信平台提供
		String userName = "smjjhtfw"; // 由新短信平台提供，不同的接入系统对应的登录帐号和密码不同
		String passWd = "smjjhtfw159753"; // 由新短信平台提供，不同的接入系统对应的登录帐号和密码不同

		HttpClient hc = new HttpClient(url);

		Message packInfo = new Message(); // 【注意】是com.cfwx.multichannel.userinterface.pack.Message
		packInfo.userName = userName; // 验证用户名
		packInfo.passWd = passWd; // 验证密码
		packInfo.mobileNum = phoneNums.split(",").length; // 手机号码数量，必须与mobile中的数量一致
		packInfo.mobile = phoneNums;// 最高不超过10000个号码，中间以英文逗号分隔
		packInfo.content = sms_content;
		packInfo.creatorId = null; // 信息业务ID，不填或者填业务系统信息流水号，最大长度20
		packInfo.organId = ""; // 机构ID，必填
		packInfo.userId = ""; // 机构用户ID，可不填 ,指的是某机构下的用户id，跟接口用户id区别不同
		packInfo.infoType1 = 0; // 一级信息类型（或者短信业务类型、短信产品类型），暂时填0，待宏源业务类型规划完毕后再填入
		packInfo.infoType2 = 0; // 二级信息类型（或者短信业务类型、短信产品类型），暂时填0
		packInfo.reserved1 = 0; // 保留字段1，填0
		packInfo.reserved2 = null; // 保留字段2，不填
		packInfo.reserved3 = null; // 保留字段3，不填
		packInfo.isWAP = 0; // 是否是WapPush类型短信，0-不是，1-是
		packInfo.wapURL = null; // 不是WapPush短信时不填，如果是，则填URL
		packInfo.tryTimes = 0; // 发送失败重试次数，填0即可
		// packInfo.controlFlag = "000000";

		HttpPack hp = new HttpPack(); // 【注意】是com.cfwx.multichannel.userinterface.pack.HttpPack
		hp.setPackInfo(packInfo);

		int result = hc.send(hp);

		// 提交结果：0:-成功；其他-失败，比如：
		// 2029: 失败，一次群发不可超过一万个手机号； 2007: 信息包体长度格式错误； 2: 发送错误;

		hc.close(); // 【注意】发送完成后，请关闭HttpClient对象
		return result;
	}

	/**
	 * 0 成功
	 * 
	 * 1 失败
	 * 
	 * 
	 */
	public int send_sms_new(String phoneNums, String sms_content) { // url

		int code = 1;
		String httpPath = "http://172.17.130.113/communication/submitSmsRequest.ashx";
		StringBuffer params = null;
		// 程序ID
		String ClientID = "43";
		// 密码，需原密码转成MD5，也可以从平台数据库中直接查询这个MD5码
		String PWD = "65724b012c8108c6c07e1daea4adee34".toUpperCase();
		// 业务代码
		String SysCode = "106006";
		// 手机号码

		// 短信内容，居然要 encode 两次
		String testContent = sms_content;
		try {
			testContent = new String(URLEncoder.encode(URLEncoder.encode(testContent, "UTF-8"), "UTF-8").getBytes());
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
		}

		// 部门编号
		String Depart = "0102";
		// 流水号，18位以内纯数字
		String SysMsgID = String.valueOf(System.currentTimeMillis());
		for (String phonenum : phoneNums.split(",")) {

			if (phonenum.startsWith("0"))
				continue;
			if (phonenum.length() != 11)
				continue;

			try {

				params = new StringBuffer();
				params.append("ClientID=").append(ClientID).append("&").append("PWD=").append(PWD).append("&")
						.append("SysCode=").append(SysCode).append("&").append("Mobile=").append(phonenum).append("&")
						.append("Content=").append(testContent).append("&").append("Depart=").append(Depart).append("&")
						.append("SysMsgID=").append(SysMsgID);
				// System.out.println(httpPath + "?" + params.toString());

				String result = HttpUtil.sendPostRequestByParam(httpPath, params.toString());

				if (result.contains("ResultCode=0"))
					code = 0;
				Thread.sleep(10);

			} catch (Exception ex) {
				ex.printStackTrace();
			}

		}

		return code;

	}

	public static void main(String[] args) {
		SmS_go sms = new SmS_go();
		String content = "尊敬的管理人：我司已将贵司私募产品2018年1月纳税申报表发送至贵司信息披露预留邮箱，请查收！您也可登录我司基金综合管理平台下载纳税申报表。温馨提示：最晚应于2月22日完成1月纳税申报。";

		sms.send_sms("15210259033", content);
		sms.send_sms("13821031773", content);
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; // 加载JDBC驱动
		String dbURL = "jdbc:sqlserver://50.2.62.49:1433; DatabaseName=fundservice"; // 连接服务器和数据库test
		String userName = "sa"; // 默认用户名
		String userPwd = "sasa"; // 密码
		Connection dbConn = null;
		ResultSet rs = null;
		Statement stmt = null;
		Statement stmt2 = null;

		try {
			Class.forName(driverName);
			dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
			stmt = dbConn.createStatement();
			stmt2 = dbConn.createStatement();
			String sql = "select * from test";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				// String id =rs.getString("id");
				String phone = rs.getString("keys");
				phone = phone.trim();
				if (phone.length() != 11)
					continue;
				// sql= "update pxinfo set sms=0 where id="+id;

				int result = -1;
				// result = sms.send_sms("18612832469,15210259033,13821031773",
				// content);
				result = sms.send_sms(phone, content);
				System.out.println(phone);
				Thread.sleep(400);
				// sql= "update pxinfo set sms= "+result+" where id="+id;
				// stmt2.executeUpdate(sql);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				stmt2.close();
				dbConn.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
