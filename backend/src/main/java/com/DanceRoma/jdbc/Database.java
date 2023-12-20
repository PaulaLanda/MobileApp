package com.DanceRoma.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {

    private static String USERNAME = "root";
    private static String PASSWORD = "mieres123";
    private static String CONNECTION_STRING="jdbc:mysql://localhost:3306/jdbc?serverTimezone=UTC";
    public static void main(String[] args){
    }

    @SuppressWarnings("resource")
    private static Connection getConnection() throws SQLException {
//        if(DriverManager.getDriver(CONNECTION_STRING) == null)
//            DriverManager.registerDriver(new org.hsqldb.jdbc.JDBCDriver());
        return DriverManager.getConnection(CONNECTION_STRING,USERNAME,PASSWORD);
    }

    @SuppressWarnings("resource")
    private static void showResults(ResultSet rs) throws SQLException {
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
}
