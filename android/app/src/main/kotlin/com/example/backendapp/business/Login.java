package business;

import model.UserValidator;

public class Login {
    private UserValidator uv;

    public Login() {
        uv = new UserValidator();
    }

    public boolean existsUser(String name, String password) {
        return uv.exists(name, password);
    }
}
