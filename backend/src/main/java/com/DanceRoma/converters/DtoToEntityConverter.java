package com.DanceRoma.converters;

import com.DanceRoma.dtos.ClubDto;
import com.DanceRoma.dtos.DayDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Club;
import com.DanceRoma.entities.Day;
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
        user.setNombre(dto.getNombre());
        user.setCorreo(dto.getCorreo());
        user.setApellido(dto.getApellido());
        user.setTipo(dto.getTipo());
        user.setContra(dto.getContra());
        return user;
    }

    public Club convert(ClubDto dto) {
        Club club = new Club();
        club.setId(dto.getId());
        club.setNombre(dto.getNombre());
        club.setDireccion(dto.getDireccion());
        List<Ticket> t = new ArrayList<Ticket>();
        club.setTickets(convertTicket(dto.getTickets()));
        club.setTimetable(convertDay(dto.getHorario()));
        return club;
    }


    private List<Day> convertDay(List<DayDto> dto) {
        List<Day> days = new ArrayList<Day>();
        Day d;
        for (DayDto dt : dto) {
            d = new Day();
            d.setId(dt.getId());
            d.setDay(dt.getDay());
            d.setClubId(dt.getClubId());
            d.setBegin(dt.getBegin());
            d.setEnd(dt.getEnd());
            days.add(d);
        }
        return days;
    }

    private List<Ticket> convertTicket(List<TicketDto> dto) {
        List<Ticket> tickets = new ArrayList<Ticket>();
        Ticket t;
        for (TicketDto ti : dto) {
            t = new Ticket();
            t.setId(ti.getId());
            t.setDef(ti.getDefinition());
            t.setClubId(ti.getClubId());
            t.setAmount(ti.getAmount());
            t.setPrice(ti.getPrice());
            tickets.add(t);
        }
        return tickets;
    }
}
