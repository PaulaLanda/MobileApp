import db.DBHelper;

public class DatabaseTest {
    public static void main(String[] args) throws Exception {
        DBHelper dbh = new DBHelper();
        dbh.readDataBase();
    }

}