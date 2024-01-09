package com.DanceRoma.servicies;

import com.DanceRoma.dtos.LoginDto;
import com.DanceRoma.dtos.UserDto;
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

    public User update(User user) throws Exception {
        Optional<User> existingUser = userRepository.findByEmail(user.getEmail());
        if (existingUser.isEmpty()) {
            throw new Exception("There is not any user with email <" + user.getEmail() + ">");
        }
        user.setId(existingUser.get().getId());
        return userRepository.save(user);
    }

    public String login(LoginDto loginDto) throws Exception {
        Optional<User> userLogged = userRepository.findByEmailAndPassword(loginDto.getUser(), loginDto.getPassword());
        if (userLogged.isEmpty()) {
            throw new Exception("User or password incorrect");
        }
        return userLogged.get().getUserType().name();
    }

}
