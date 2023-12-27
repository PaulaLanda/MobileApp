package com.DanceRoma.converters;

import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.User;

public class DtoToEntityConverter {

    public User convert(UserDto dto) {
        User user = new User();
        user.setId(dto.getId());
        user.setNombre(dto.getNombre());
        user.setCorreo(dto.getCorreo());
        return user;
    }
}
