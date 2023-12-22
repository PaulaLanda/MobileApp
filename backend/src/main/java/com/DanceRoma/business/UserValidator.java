package com.DanceRoma.business;

import com.DanceRoma.model.UserManager;

public class UserValidator {


    private UserManager um;

    public UserValidator(){
        um = new UserManager();
    }
    public int userExists(String username, String password){
        return um.exists(username,password);
    }

    public int createClient(String name, String surname, String email, String pass1, String pass2){
        return um.createUser(name,surname,email,pass1,pass2,"CLIENT");
    }

    public int createOwner(String name, String surname, String email, String pass1, String pass2){
        return um.createUser(name,surname,email,pass1,pass2,"OWNER");
    }
}
