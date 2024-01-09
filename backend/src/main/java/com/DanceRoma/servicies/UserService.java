package com.DanceRoma.servicies;

import com.DanceRoma.dtos.LoginDto;
import com.DanceRoma.entities.User;
import com.DanceRoma.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> findAll() {
        return (List<User>) userRepository.findAll();
    }

    public User register(User user) throws Exception {
        Optional<User> userByEmail = userRepository.findByEmail(user.getEmail());
        if (userByEmail.isPresent()) {
            throw new Exception("Ya existe un usuario con el correo <" + user.getEmail() + ">");
        }
        return userRepository.save(user);
    }

    public User update(Long id, User toUpdate) throws Exception {
        Optional<User> user = userRepository.findById(id);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with id <" + id + ">");
        }
        toUpdate.setId(id);
        return userRepository.save(toUpdate);
    }

    public String login(LoginDto loginDto) throws Exception {
        Optional<User> userLogged = userRepository.findByEmailAndPassword(loginDto.getusuario(), loginDto.getContrasena());
        if (userLogged.isEmpty()) {
            throw new Exception("User or password incorrect");
        }
        return userLogged.get().getUserType().name();
    }

}
