package com.DanceRoma.controllers;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.dtos.LoginDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.User;
import com.DanceRoma.servicies.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto) throws Exception {
        String userType = userService.login(loginDto);
        return ResponseEntity.ok(userType);
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody UserDto userDto) throws Exception {
        ResponseEntity<?> toReturn;
        try {
            User user = dtoToEntityConverter.convert(userDto);
            User userCreated = userService.register(user);
            UserDto userCreatedDto = entityToDtoConverter.convert(userCreated);
            toReturn = ResponseEntity.ok(userCreatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @PutMapping("/update")
    public ResponseEntity<?> update(@RequestBody UserDto userDto) throws Exception {
        ResponseEntity<?> toReturn;
        try {
            User toUpdate = dtoToEntityConverter.convert(userDto);
            User userUpdated = userService.update(toUpdate);
            UserDto userUpdatedDto = entityToDtoConverter.convert(userUpdated);
            toReturn = ResponseEntity.ok(userUpdatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }
}
