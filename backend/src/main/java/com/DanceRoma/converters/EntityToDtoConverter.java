package com.DanceRoma.converters;

import com.DanceRoma.dtos.*;
import com.DanceRoma.entities.*;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EntityToDtoConverter {

    public UserDto convert(User user) {
        UserDto dto = new UserDto();
        dto.setId(user.getId());
        dto.setName(user.getName());
        dto.setSurname(user.getSurname());
        dto.setEmail(user.getEmail());
        dto.setPassword(user.getPassword());
        dto.setUserType(user.getUserType().name());

        return dto;
    }

    public ReviewOutDto convert(Review review) {
        ReviewOutDto dto = new ReviewOutDto();
        dto.setId(review.getId());
        dto.setUserDto(convert(review.getUser()));
        dto.setMessage(review.getText());
        dto.setPhotoUrl(review.getPhotoUrl());
        return dto;
    }

    public MessageDto convert(Message msg) {
        MessageDto dto = new MessageDto();
        dto.setId(msg.getId());
        dto.setMessage(msg.getText());
        dto.setSender(convert(msg.getSender()));
        dto.setSender(convert(msg.getReceptor()));
        dto.setDate(msg.getDate());
        return dto;
    }

    public DiscoDto convert(Disco disco) {
        DiscoDto dto = new DiscoDto();
        dto.setId(disco.getId());
        dto.setName(disco.getName());
        dto.setAddress(disco.getAddress());
        dto.setUserDto(convert(disco.getUser()));
        dto.setMondaySchedule(disco.getMondaySchedule());
        dto.setTuesdaySchedule(disco.getTuesdaySchedule());
        dto.setWednesdaySchedule(disco.getWednesdaySchedule());
        dto.setThursdaySchedule(disco.getThursdaySchedule());
        dto.setFridaySchedule(disco.getFridaySchedule());
        dto.setSaturdaySchedule(disco.getSaturdaySchedule());
        dto.setSundaySchedule(disco.getSundaySchedule());
        dto.setPhotoUrl(disco.getPhotoUrl());

        List<TicketDto> ticketDtos = new ArrayList<>();
        for (Ticket ticket : disco.getTickets()) {
            ticketDtos.add(convert(ticket));
        }
        dto.setTicketDtos(ticketDtos);

        List<ReviewOutDto> reviewOutDtos = new ArrayList<>();
        for (Review review : disco.getReviews()) {
            reviewOutDtos.add(convert(review));
        }
        dto.setReviewDtos(reviewOutDtos);

        return dto;
    }

    public TicketDto convert(Ticket ticket) {
        TicketDto dto = new TicketDto();
        //dto.setId(ticket.getId());
        dto.setDescription(ticket.getDescription());
        dto.setDrinksNumber(ticket.getDrinksNumber());
        dto.setPrice(ticket.getPrice());

        return dto;
    }
}