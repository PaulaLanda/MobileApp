package com.DanceRoma.converters;

import com.DanceRoma.dtos.*;
import com.DanceRoma.entities.*;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
        user.setPassword(dto.getPassword());
        user.setUserType(User.UserType.valueOf(dto.getUserType()));
        return user;
    }

    public Message convert(MessageInDto dto) {
        Message msg = new Message();
        msg.setId(dto.getId());
        msg.setText(dto.getMessage());
        msg.setDate(formatDatetime(dto.getDate()));
        return msg;
    }

    public Review convert(ReviewInDto dto) {
        Review r = new Review();
        r.setId(dto.getId());
        r.setText(dto.getMessage());
        r.setPhotoUrl(dto.getPhotoUrl());
        return r;
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
        disco.setPhotoUrl(dto.getPhotoUrl());

        List<Ticket> tickets = new ArrayList<>();
        for (TicketDto ticketDto : dto.getTicketDtos()) {
            tickets.add(convert(ticketDto));
        }
        disco.setTickets(tickets);

        return disco;
    }
    //flag
    public Ticket convert(TicketDto dto) {
        Ticket ticket = new Ticket();
        //ticket.setId(dto.getId());
        ticket.setDescription(dto.getDescription());
        ticket.setDrinksNumber(dto.getDrinksNumber());
        ticket.setPrice(dto.getPrice());
        return ticket;
    }

    private LocalDate formatDatetime(String inputDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return LocalDate.parse(inputDate, formatter);
    }
}