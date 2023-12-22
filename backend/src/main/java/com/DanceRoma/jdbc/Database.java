package com.DanceRoma.jdbc;

import java.sql.*;
import java.util.logging.Logger;

public class Database {

    private static String USERNAME = "root";
    private static String PASSWORD = "mieres123";
    //private static String CONNECTION_STRING="jdbc:mysql://localhost:3306/jdbc?serverTimezone=UTC";
    //private static String CONNECTION_STRING="jdbc:hsqldb:hsql://localhost/dr";

    private static String CONNECTION_STRING="jdbc:mysql://localhost/dr?"
            + "user=root&password=mieres123";


    public static void demo() throws SQLException {
        Connection con = getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM user");
        showResults(rs);
    }

    public ResultSet executeQuery(String query) throws SQLException {
        Connection con = getConnection();
        Statement st = con.createStatement();
        return st.executeQuery(query);
    }

    @SuppressWarnings("resource")
    public static Connection getConnection() throws SQLException {
        if(DriverManager.getDriver(CONNECTION_STRING) == null)
            DriverManager.registerDriver(new org.hsqldb.jdbc.JDBCDriver());
        //return DriverManager.getConnection(CONNECTION_STRING,USERNAME,PASSWORD);
        return DriverManager.getConnection(CONNECTION_STRING);
    }

    @SuppressWarnings("resource")
    public static void showResults(ResultSet rs) throws SQLException {
        int columnCount = rs.getMetaData().getColumnCount();
        StringBuilder headers = new StringBuilder();

        for(int i = 1; i < columnCount ; i++)
            headers.append(rs.getMetaData().getColumnName(i) + "\t");
        headers.append(rs.getMetaData().getColumnName(columnCount));

        System.out.println(headers.toString());
        StringBuilder result = null;

        while(rs.next()) {
            result = new StringBuilder();
            for(int i=1;i<columnCount;i++)
                result.append(rs.getObject(i)+ "\t");
            result.append(rs.getObject(columnCount));
            System.out.println(result.toString());
        }

        if(result==null)
            System.out.println("No data found");

    }


    public void executeUpdate(String query) throws SQLException {
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(query);
        ps.executeUpdate();
        ps.close();
        con.close();
    }
}
