package com.DanceRoma.controllers;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.dtos.LoginDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.User;
import com.DanceRoma.servicies.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/users")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private EntityToDtoConverter entityToDtoConverter;

    @Autowired
    private DtoToEntityConverter dtoToEntityConverter;

    @GetMapping("")
    public ResponseEntity<List<UserDto>> getAllUsers() {
        List<User> users = userService.findAll();
        List<UserDto> usersDto = users.stream().map(user -> entityToDtoConverter.convert(user)).collect(Collectors.toList());
        return ResponseEntity.ok(usersDto);
    }

    @PostMapping("/register")
    public ResponseEntity<UserDto> register(@RequestBody UserDto userDto) throws Exception {
        User user = dtoToEntityConverter.convert(userDto);
        User userCreated = userService.register(user);
        UserDto toReturn = entityToDtoConverter.convert(userCreated);
        return ResponseEntity.ok(toReturn);
    }

    @GetMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto) throws Exception {
        String userType = userService.login(loginDto);
        return ResponseEntity.ok("Usuario de tipo <" + userType + " logueado");
    }
}
