package com.DanceRoma.model;

import com.DanceRoma.jdbc.DatabaseManager;

public class UserManager {

    public static int USER_DOESNT_EXIST = 1;
    /**The password is not correct*/
    public static int WRONG_COMBINATION = 2;
    /**Correct combination of username and password || user creation worked fine*/
    public static int EVERYTHING_FINE = 0;
    public static int USER_ALREADY_EXISTS=3;
    /**Some field (name, surname...) is empty*/
    public static int EMPTY_FIELD=4;
    /**The password is not the same in 'Password' and 'Verify your password'*/
    public static int NOT_MATCHING_PASS=5;
    DatabaseManager dbm;

    public UserManager(){
        dbm = new DatabaseManager();
    }
    public int exists(String username, String password) {
        if(!dbm.userExists(username))
            return USER_DOESNT_EXIST;
        if(dbm.validUser(username,password))
            return EVERYTHING_FINE;
        return WRONG_COMBINATION;
    }

    public int createUser(String name, String surname, String email, String pass1, String pass2,String type) {
        if(name.isEmpty()||surname.isEmpty()||email.isEmpty()||pass1.isEmpty()||pass2.isEmpty())
            return EMPTY_FIELD;
        String[] aux=email.split("@");
        if(dbm.userExists(aux[0]))
            return USER_ALREADY_EXISTS;
        if(!pass1.equals(pass2))
            return NOT_MATCHING_PASS;
        dbm.createUser(aux[0],name,surname,email,pass1,type);
        return EVERYTHING_FINE;
    }
}
