package com.DanceRoma.converters;

import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.dtos.DiscoInDto;
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
public class DtoToEntityConverter {

    public User convert(UserDto dto) {
        User user = new User();
        user.setId(dto.getId());
        user.setName(dto.getName());
        user.setSurname(dto.getSurname());
        user.setEmail(dto.getEmail());
        user.setUserType(User.UserType.valueOf(dto.getUserType()));
        return user;
    }

    public Message convert(MessageDto dto) {
        Message msg = new Message();
        msg.setId(dto.getId());
        msg.setText(dto.getMessage());
        msg.setSenderId(dto.getSenderId());
        msg.setReceptorId(dto.getReceptorId());
        msg.setDate(dto.getDate());
        return msg;
    }

    public Disco convert(DiscoDto dto) {
        Disco disco = new Disco();
        disco.setId(dto.getId());
        disco.setName(dto.getName());
        disco.setAddress(dto.getAddress());
        disco.setUser(convert(dto.getUserDto()));
        disco.setMondaySchedule(dto.getMondaySchedule());
        disco.setTuesdaySchedule(dto.getTuesdaySchedule());
        disco.setWednesdaySchedule(dto.getWednesdaySchedule());
        disco.setThursdaySchedule(dto.getThursdaySchedule());
        disco.setFridaySchedule(dto.getFridaySchedule());
        disco.setSaturdaySchedule(dto.getSaturdaySchedule());
        disco.setSundaySchedule(dto.getSundaySchedule());

        List<Ticket> tickets = new ArrayList<>();
        for (TicketDto ticketDto : dto.getTicketDtos()) {
            tickets.add(convert(ticketDto));
        }
        disco.setTickets(tickets);

        return disco;
    }

    public Disco convert(DiscoInDto dto) {
        Disco disco = new Disco();
        disco.setId(dto.getId());
        disco.setName(dto.getName());
        disco.setAddress(dto.getAddress());
        disco.setMondaySchedule(dto.getMondaySchedule());
        disco.setTuesdaySchedule(dto.getTuesdaySchedule());
        disco.setWednesdaySchedule(dto.getWednesdaySchedule());
        disco.setThursdaySchedule(dto.getThursdaySchedule());
        disco.setFridaySchedule(dto.getFridaySchedule());
        disco.setSaturdaySchedule(dto.getSaturdaySchedule());
        disco.setSundaySchedule(dto.getSundaySchedule());

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
        ticket.setDescription(dto.getDescription());
        ticket.setDrinksNumber(dto.getDrinksNumber());
        ticket.setPrice(dto.getPrice());
        return ticket;
    }
}
