package com.DanceRoma.controllers;

import com.DanceRoma.converters.EntityToDtoConverter;
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

    @GetMapping("")
    public ResponseEntity<List<UserDto>> getAllUsers() {
        List<User> users = userService.getAll();
        List<UserDto> usersDto = users.stream().map(user -> entityToDtoConverter.convert(user)).collect(Collectors.toList());
        return ResponseEntity.ok(usersDto);
    }

    @GetMapping("/login")
    public ResponseEntity<?> login() {
        return ResponseEntity.ok("LOGIN OK");
    }
}
