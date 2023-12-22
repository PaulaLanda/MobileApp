package com.DanceRoma.test;

import com.DanceRoma.jdbc.Database;
import com.DanceRoma.jdbc.DatabaseManager;
import com.DanceRoma.model.UserManager;

import java.sql.SQLException;

public class DatabaseTest {

    private static UserManager um = new UserManager();
    private static Database db = new Database();

    public static void main(String[] args)  {
        try {
            //userTest();
            //createUserTest();
            viewUserData();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void viewUserData() throws SQLException {
        db.demo();
    }

    private static void createUserTest() {
        if(um.createUser("", "", "", "", "", "") == UserManager.EMPTY_FIELD)
            System.out.println("Empty field(s)");
        if(um.createUser("name", "surname", "mariagtlv@g.com", "pass1",
                "pass2", "type") == UserManager.EMPTY_FIELD)
            System.out.println("User already exists");
        if(um.createUser("name", "surname", "1@g.com", "a",
                "b", "type") == UserManager.NOT_MATCHING_PASS)
            System.out.println("Passwords dont match");
        if(um.createUser("name", "surname", "1@g.com", "a",
                "a", "CLIENT") == UserManager.EVERYTHING_FINE)
            System.out.println("Client account created");
        if(um.createUser("name", "surname", "2@g.com", "a",
                "a", "OWNER") == UserManager.EVERYTHING_FINE)
            System.out.println("Owner account created");
    }

    public static void userTest() throws SQLException {
        if(um.exists("mariagtlv","123")==UserManager.EVERYTHING_FINE)
            System.out.println("Right user and password");
        if(um.exists("maria","123")==UserManager.USER_DOESNT_EXIST)
            System.out.println("user does not exist");
        if(um.exists("mariagtlv","0")==UserManager.WRONG_COMBINATION)
            System.out.println("wrong password");
    }




}
