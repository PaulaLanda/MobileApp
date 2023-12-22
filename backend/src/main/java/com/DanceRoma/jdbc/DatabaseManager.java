package com.DanceRoma.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseManager {

    Database db;

    public DatabaseManager(){
        db = new Database();
    }


    public boolean userExists(String username) {
        ResultSet rs = null;
        try{
            rs = db.executeQuery("SELECT username from user where username='"+username+"'");
            return nonEmptyRS(rs);
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public boolean validUser(String username, String password) {
        ResultSet rs = null;
        try{
            rs = db.executeQuery("SELECT username from user where username='"+username+
                    "' and password='" + password + "'");
            return nonEmptyRS(rs);
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public boolean nonEmptyRS(ResultSet rs) throws SQLException {
        return rs.next();
    }

    public void createUser(String username,String name, String surname, String email, String pass, String type) {
        try {
            db.executeUpdate("INSERT INTO user VALUES('"+username+"','"+name+"','"+
                    surname+"','"+pass+"','"+email+"','"+type+"')");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
