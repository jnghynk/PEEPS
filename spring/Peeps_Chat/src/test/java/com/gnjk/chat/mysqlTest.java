package com.gnjk.chat;

import java.sql.Connection;

import java.sql.DriverManager;

import org.junit.Test;

	
public class mysqlTest {

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

	private static final String URL = "jdbc:mysql://127.0.0.1:3306/chat?serverTimezone=UTC";

	private static final String USER ="root";

	private static final String PW = "adminadmin";

	

	@Test
	public void testConnection() throws Exception{
		Class.forName(DRIVER);
		try (Connection con = DriverManager.getConnection(URL, USER, PW))	{
			System.out.println(con);

			

		}catch(Exception e){

			System.err.println(e);

		}

	}

	
}
