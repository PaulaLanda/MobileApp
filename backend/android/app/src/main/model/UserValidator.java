package model;

import java.util.ArrayList;
import java.util.List;

public class UserValidator {

    private List<User> users;
    private
    public UserValidator(){
        users = new ArrayList<User>();
        var mRemoteService : RemoteAPI =HelperClass.getIstance()
        getAll();
    }

    private void getAll(){

    }
    suspend fun getAll(){
        runBlocking {
            val json = mRemoteService.get()
            val keys= json.keySet()
            n = keys.size
            order = List(n){0}.toMutableStateList()
            items = List(n){Item()}.toMutableList()
            var i=0
            for (k in json.keySet()) {
                Log.i("REPLY ALL", "" + json)
                items[i].title=k
                items[i].description=json.get(k).asString
                i++
            }
        }
    }
    public boolean exists(String name, String password) {
        return false;
    }
}
