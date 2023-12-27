package com.DanceRoma.converters;

import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.User;

public class EntityToDtoConverter {

    public UserDto convert(User user) {
        UserDto dto = new UserDto();
        dto.setId(user.getId());
        dto.setNombre(user.getNombre());
        dto.setCorreo(user.getCorreo());
        return dto;
    }
}