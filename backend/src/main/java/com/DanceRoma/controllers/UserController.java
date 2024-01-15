package com.DanceRoma.controllers;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.dtos.LoginDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.User;
import com.DanceRoma.services.UserService;
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

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        ResponseEntity<?> toReturn;
        try {
            User byId = userService.findById(id);
            UserDto userDto = entityToDtoConverter.convert(byId);
            return ResponseEntity.ok(ResponseEntity.ok(userDto));
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());

        }
        return toReturn;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto) {
        ResponseEntity<?> toReturn;
        try {
            User user = userService.login(loginDto);
            return ResponseEntity.ok(entityToDtoConverter.convert(user));
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody UserDto userDto) {
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

    @PutMapping("/update/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody UserDto userDto) {
        ResponseEntity<?> toReturn;
        try {
            User toUpdate = dtoToEntityConverter.convert(userDto);
            User userUpdated = userService.update(id, toUpdate);
            UserDto userUpdatedDto = entityToDtoConverter.convert(userUpdated);
            toReturn = ResponseEntity.ok(userUpdatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @GetMapping("/add-fav/{discoId}/{userId}")
    public ResponseEntity<?> addToFavs(@PathVariable Long userId, @PathVariable Long discoId) {
        ResponseEntity<?> toReturn;
        try {
            List<Disco> favDiscos = userService.addToFav(discoId, userId);
            List<DiscoDto> favDiscosDto = favDiscos.stream().map(favDisco -> entityToDtoConverter.convert(favDisco)).collect(Collectors.toList());
            toReturn = ResponseEntity.ok(favDiscosDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @GetMapping("/delete-fav/{discoId}/{userId}")
    public ResponseEntity<?> deleteFromFavs(@PathVariable Long discoId, @PathVariable Long userId) {
        ResponseEntity<?> toReturn;
        try {
            List<Disco> favDiscos = userService.deleteFromFav(discoId, userId);
            List<DiscoDto> favDiscosDto = favDiscos.stream().map(favDisco -> entityToDtoConverter.convert(favDisco)).collect(Collectors.toList());
            toReturn = ResponseEntity.ok(favDiscosDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }
}