package com.DanceRoma.converters;

import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.dtos.MessageDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.Message;
import com.DanceRoma.entities.Ticket;
import com.DanceRoma.entities.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EntityToDtoConverter {

    public UserDto convert(User user) {
        UserDto dto = new UserDto();
        dto.setId(user.getId());
        dto.setNombre(user.getName());
        dto.setCorreo(user.getEmail());

        return dto;
    }

    public MessageDto convert(Message msg) {
        MessageDto dto = new MessageDto();
        dto.setId(msg.getId());
        dto.setMessage(msg.getText());
        dto.setSenderId(msg.getSenderId());
        dto.setReceptorId(msg.getReceptorId());
        dto.setDate(msg.getDate());
        return dto;
    }

    public DiscoDto convert(Disco disco) {
        DiscoDto dto = new DiscoDto();
        dto.setId(disco.getId());
        dto.setNombre(disco.getName());
        dto.setDireccion(disco.getAddress());
        dto.setUserDto(convert(disco.getUser()));
        dto.setHorarioLunes(disco.getMondaySchedule());
        dto.setHorarioMartes(disco.getTuesdaySchedule());
        dto.setHorarioMiercoles(disco.getWednesdaySchedule());
        dto.setHorarioJueves(disco.getThursdaySchedule());
        dto.setHorarioViernes(disco.getFridaySchedule());
        dto.setHorarioSabado(disco.getSaturdaySchedule());
        dto.setHorarioDomingo(disco.getSundaySchedule());

        List<TicketDto> ticketDtos = new ArrayList<>();
        for (Ticket ticket : disco.getTickets()) {
            ticketDtos.add(convert(ticket));
        }
        dto.setTicketDtos(ticketDtos);

        return dto;
    }

    public TicketDto convert(Ticket ticket) {
        TicketDto dto = new TicketDto();
        dto.setId(ticket.getId());
        dto.setDescripcion(ticket.getDescription());
        dto.setNumeroCopas(ticket.getDrinksNumber());
        dto.setPrecio(ticket.getDrinksNumber());

        return dto;
    }
}
