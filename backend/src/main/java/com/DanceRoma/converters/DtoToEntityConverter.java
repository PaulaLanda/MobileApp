package com.DanceRoma.converters;

import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.Ticket;
import com.DanceRoma.entities.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class DtoToEntityConverter {

    public User convert(UserDto dto) {
        User user = new User();
        user.setId(dto.getId());
        user.setName(dto.getNombre());
        user.setSurname(dto.getApellido());
        user.setEmail(dto.getCorreo());
        user.setUserType(User.UserType.valueOf(dto.getTipo()));
        return user;
    }

    public Disco convert(DiscoDto dto) {
        Disco disco = new Disco();
        disco.setId(dto.getId());
        disco.setName(dto.getNombre());
        disco.setAddress(dto.getDireccion());
        disco.setUser(convert(dto.getUserDto()));
        disco.setMondaySchedule(dto.getHorarioLunes());
        disco.setTuesdaySchedule(dto.getHorarioMartes());
        disco.setWednesdaySchedule(dto.getHorarioMiercoles());
        disco.setThursdaySchedule(dto.getHorarioJueves());
        disco.setFridaySchedule(dto.getHorarioViernes());
        disco.setSaturdaySchedule(dto.getHorarioSabado());
        disco.setSundaySchedule(dto.getHorarioDomingo());

        List<Ticket> tickets = new ArrayList<>();
        for (TicketDto ticketDto : dto.getTicketDtos()) {
            tickets.add(convert(ticketDto));
        }
        disco.setTickets(tickets);

        return disco;
    }

    public Ticket convert(TicketDto dto) {
        Ticket ticket = new Ticket();
        ticket.setId(dto.getId());
        ticket.setDescription(dto.getDescripcion());
        ticket.setDrinksNumber(dto.getNumeroCopas());
        ticket.setPrice(dto.getPrecio());
        return ticket;
    }
}
